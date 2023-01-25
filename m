Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0B67A750
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 01:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjAYADG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 19:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAYADE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 19:03:04 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A1A24D
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 16:03:03 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30ONlFI9011678
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 16:03:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=ysSPhKxrjQmu5RhTV0uXRUs1TJyZk7E70FHICmqYEwM=;
 b=Yb1LPdIRdIfb4ZTX3RcUM7JxM72wyiVC+bp5txAH54P1vOicAXOZeCAXG/yQvgl2B5RC
 kmpdK7hHqJNI9yb6/FwCNUxatyKLzNNdOuOH2X9d2gE3qyGJDw71Ya20rXNgQr+qiEQp
 8rvRHCzn2Qt8ITQcw2/NAt2X1g56OHlBkbejIhmzlPtgzqnwc47oecbuEemByO477FjE
 TW9ojnGZzX0+h2us7IAWAurr0y2j8tzH7PoVUKn+2ussWhV5Gn7zCy8Z1HB0rqwHwZ+w
 AZQngDEshMQ38yH40JJj5N1dCEHpjJcBofub5Iz1ngI7bokQgoeQaJ/qijHk+nEbr+Or Hg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3namjj20h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 16:03:02 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 24 Jan 2023 16:03:01 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id C449B36A0256; Tue, 24 Jan 2023 16:02:57 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next] bpf: Fix the kernel crash caused by bpf_setsockopt().
Date:   Tue, 24 Jan 2023 16:02:44 -0800
Message-ID: <20230125000244.1109228-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Swnc17yYH0rI0VbPfkZnQYTcFcclMZmm
X-Proofpoint-GUID: Swnc17yYH0rI0VbPfkZnQYTcFcclMZmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kernel crash was caused by a BPF program attached to the
"lsm_cgroup/socket_sock_rcv_skb" hook, which performed a call to
`bpf_setsockopt()` in order to set the TCP_NODELAY flag. This flag
causes the kernel to flush the outgoing queue of a socket, and this
hook can be triggered during a softirq. The issue was that in certain
circumstances, when `tcp_write_xmit()` was called to flush the queue,
it would also allow BH (bottom-half) to run. This could lead to our
program attempting to flush the same socket recursively, which caused
a `skbuf` to be unlinked twice.

The patch fixes this issue by ensuring that a BPF program attached to
the "lsm_cgroup/socket_sock_rcv_skb" hook is not allowed to call
`bpf_setsockopt()`.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 kernel/bpf/bpf_lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index a4a41ee3e80b..e14c822f8911 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -51,7 +51,6 @@ BTF_SET_END(bpf_lsm_current_hooks)
  */
 BTF_SET_START(bpf_lsm_locked_sockopt_hooks)
 #ifdef CONFIG_SECURITY_NETWORK
-BTF_ID(func, bpf_lsm_socket_sock_rcv_skb)
 BTF_ID(func, bpf_lsm_sock_graft)
 BTF_ID(func, bpf_lsm_inet_csk_clone)
 BTF_ID(func, bpf_lsm_inet_conn_established)
--=20
2.30.2

