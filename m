Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766AE67DA97
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 01:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjA0ASg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 19:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjA0ASU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 19:18:20 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E9E2685
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:17:45 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QNjlWT007481
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:17:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=87eGWaDuMav0tzkTSOivIM4A28Iq36s+NraABNhBVYE=;
 b=HAQ5NZjAA4s1ql1kAmISQA8CNUbjED06WowiNYy3flGVSmyl3sTBsMUX3Ha5kD1g5pAe
 J+2Qsm/rzzNUBZKiwCzGD6WlhxUZD3PyHqyKKS3r7kAdUFlJNcYfp8pF5TxgBVf7/kij
 rdC4kkOc5bD5hUZbHB3nABCXh7xYZA7Iqy0jr4u7TeZEQ5WB45A2iIiA2j3lOsuYYCXu
 4FQxJzSUmNDdovWQCj6XcK5LRg0BhD2V9NF7KUqa2SHg7oh1AUmf+XqBrqbp1sBvMmwE
 lhPwnpQRF+seshgH4wIEk2K+W+MY2O6vQInoX7x2hIqppBNTPBtlTFyklFVAzmDlHqrk CQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nbw3djj89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:17:45 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 16:17:43 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id AAD15393ECE1; Thu, 26 Jan 2023 16:17:39 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf v2] bpf: Fix the kernel crash caused by bpf_setsockopt().
Date:   Thu, 26 Jan 2023 16:17:32 -0800
Message-ID: <20230127001732.4162630-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OAyJSvHusCXyHwEEptKAyr2dtriGeWk0
X-Proofpoint-GUID: OAyJSvHusCXyHwEEptKAyr2dtriGeWk0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
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
`bpf_setsockopt()` in order to set the TCP_NODELAY flag as an
example. Flags like TCP_NODELAY can prompt the kernel to flush a
socket's outgoing queue, and this hook
"lsm_cgroup/socket_sock_rcv_skb" is frequently triggered by
softirqs. The issue was that in certain circumstances, when
`tcp_write_xmit()` was called to flush the queue, it would also allow
BH (bottom-half) to run. This could lead to our program attempting to
flush the same socket recursively, which caused a `skbuf` to be
unlinked twice.

`security_sock_rcv_skb()` is triggered by `tcp_filter()`. This occurs
before the sock ownership is checked in `tcp_v4_rcv()`. Consequently,
if a bpf program runs on `security_sock_rcv_skb()` while under softirq
conditions, it may not possess the lock needed for `bpf_setsoppt()`,
thus presenting an issue.

The patch fixes this issue by ensuring that a BPF program attached to
the "lsm_cgroup/socket_sock_rcv_skb" hook is not allowed to call
`bpf_setsockopt()`.

The differences from v1 are
 - changing commit log to explain holding the lock of the sock,
 - emphasizing that TCP_NODELAY is not the only flag, and
 - adding the fixes tag.

v1: https://lore.kernel.org/bpf/20230125000244.1109228-1-kuifeng@meta.com/

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Fixes: 9113d7e48e91 ("bpf: expose bpf_{g,s}etsockopt to lsm cgroup")
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

