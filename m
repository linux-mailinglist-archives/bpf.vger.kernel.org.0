Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046E14EB7AF
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 03:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbiC3BQx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 21:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiC3BQu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 21:16:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAC54348D
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 18:15:04 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22U0cMFk015775
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 18:15:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=SVBf2/u5oAmdJshvBA1KURwjiAd7YCXZcAoyDpni+ps=;
 b=IOoXuUn01qb5f3i7o+SVd3RCgGN64LOEhfhkQ3IXuj1SlCNBGRtvTSWYKQZizvAFsWug
 ieKP7ubtZOpFogt8KsrZanL5zISAVFk3ldBkV2jGPV6s2d3x/e6Cl3VWMnvRIhh9Bpim
 kO5ruJ8efDo5zS2A0SZNMai4B+p7H0ROJLY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f3raayw2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 18:15:03 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 18:15:02 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 767B92BD3B8F; Tue, 29 Mar 2022 18:14:56 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf 1/2] bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT
Date:   Tue, 29 Mar 2022 18:14:56 -0700
Message-ID: <20220330011456.2984509-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3_DOcUSRgIsFCC4AlBDYOCPQyAalxqY-
X-Proofpoint-GUID: 3_DOcUSRgIsFCC4AlBDYOCPQyAalxqY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_10,2022-03-29_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The commit 7e40781cc8b7 ("bpf: verifier: Use target program's type for ac=
cess verifications")
fixes the verifier checking for BPF_PROG_TYPE_EXT (extension)
prog such that the verifier looks for things based
on the target prog type that it is extending instead of
the BPF_PROG_TYPE_EXT itself.

The current resolve_prog_type() returns the target prog type.
It checks for nullness on prog->aux->dst_prog.  However,
when loading a BPF_PROG_TYPE_TRACING prog and it is tracing another
bpf prog instead of a kernel function, prog->aux->dst_prog is not
NULL also.  In this case, the verifier should still verify as the
BPF_PROG_TYPE_TRACING type instead of the traced prog type in
prog->aux->dst_prog->type.

An oops has been reported when tracing a struct_ops prog.  A NULL
dereference happened in check_return_code() when accessing the
prog->aux->attach_func_proto->type and prog->aux->attach_func_proto
is NULL here because the traced struct_ops prog has the "unreliable" set.

This patch is to change the resolve_prog_type() to only
return the target prog type if the prog being verified is
BPF_PROG_TYPE_EXT.

Fixes: 7e40781cc8b7 ("bpf: verifier: Use target program's type for access=
 verifications")
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf_verifier.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c1fc4af47f69..3a9d2d7cc6b7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -570,9 +570,11 @@ static inline u32 type_flag(u32 type)
 	return type & ~BPF_BASE_TYPE_MASK;
 }
=20
+/* only use after check_attach_btf_id() */
 static inline enum bpf_prog_type resolve_prog_type(struct bpf_prog *prog=
)
 {
-	return prog->aux->dst_prog ? prog->aux->dst_prog->type : prog->type;
+	return prog->type =3D=3D BPF_PROG_TYPE_EXT ?
+		prog->aux->dst_prog->type : prog->type;
 }
=20
 #endif /* _LINUX_BPF_VERIFIER_H */
--=20
2.30.2

