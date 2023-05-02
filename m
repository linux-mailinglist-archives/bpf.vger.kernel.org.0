Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC86F4973
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjEBSGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 14:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjEBSF7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 14:05:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593BB19AF
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 11:05:58 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342G0Y1E030665
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 11:05:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=IHYf6dP4HbVzTTw4/bJ0UhF6M/aCT/dbapdXFtCp+z8=;
 b=VKXhxufbUHoJboW2A7cGUp5eAefUaeqQLc3vPLFi+0TqECxgvTPCVTI6/f1R6r5BLmww
 PkVLtm+PnbGp/kI6YzGwO43TEzl6NdeY78oVUjwKaFPUE9K7H+eQQlQz95wp5JsVyxVP
 FA1BIZkVFRuGip+2N1f1KOtDMj2NL1osk2g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qatf9d9a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 11:05:57 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 11:05:55 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D784A1ECE4C42; Tue,  2 May 2023 11:05:43 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Emit struct bpf_tcp_sock type in vmlinux BTF
Date:   Tue, 2 May 2023 11:05:43 -0700
Message-ID: <20230502180543.1832140-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1xcjYwI3_2mVKcCLPolqoat-Hpye_Y0f
X-Proofpoint-ORIG-GUID: 1xcjYwI3_2mVKcCLPolqoat-Hpye_Y0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_10,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In one of our internal testing, we found a case where
  - uapi struct bpf_tcp_sock is in vmlinux.h where vmlinux.h is not
    generated from the testing kernel
  - struct bpf_tcp_sock is not in vmlinux BTF

The above combination caused bpf load failure as the following
memory access
  struct bpf_tcp_sock *tcp_sock =3D ...;
  ... tcp_sock->snd_cwnd ...
needs CORE relocation but the relocation cannot be resolved since
the kernel BTF does not have corresponding type.

Similar to other previous cases (nf_conn___init, tcp6_sock, mctcp_sock, e=
tc.),
add the type to vmlinux BTF with BTF_EMIT_TYPE macro.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index d9ce04ca22ce..451b0ec7f242 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6916,6 +6916,8 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access=
_type type,
 					FIELD));			\
 	} while (0)
=20
+	BTF_TYPE_EMIT(struct bpf_tcp_sock);
+
 	switch (si->off) {
 	case offsetof(struct bpf_tcp_sock, rtt_min):
 		BUILD_BUG_ON(sizeof_field(struct tcp_sock, rtt_min) !=3D
--=20
2.34.1

