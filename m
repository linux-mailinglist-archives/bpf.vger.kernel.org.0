Return-Path: <bpf+bounces-678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFAA7059C9
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 23:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7013D1C20C14
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237327201;
	Tue, 16 May 2023 21:50:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A4271EF
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:50:01 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28359C4
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:49:59 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFmIKM027451
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:49:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=4O8nLtf+HS1vJDi5ZpSboz0JQwdabMX1aUGwg2P97Zs=;
 b=UpV5EkCAta+25SSNC1QZm5Yt5vLGXbVxNL4bm1+uMObawIjn8N45+I9Lzb0saVnlauB5
 IE5OiRoW7VskvdlMxpAsKxL1AXHpDDlE81HnTsibPS9QhHrnKuR17n+KCIM6g0AZQeNS
 FDtnHlzp9VoeWBracAS5VuPXsJyki8q+9z0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qm2wv6pg6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:49:59 -0700
Received: from twshared11183.02.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:49:56 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EFAD31FB1C2EA; Tue, 16 May 2023 14:49:45 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai
 Lau <martin.lau@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix s390 sock_field test failure
Date: Tue, 16 May 2023 14:49:45 -0700
Message-ID: <20230516214945.1013578-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6dJSvUxLqEil-0EmxpdeBEbR3bo-DMfb
X-Proofpoint-ORIG-GUID: 6dJSvUxLqEil-0EmxpdeBEbR3bo-DMfb
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

llvm patch [1] enabled cross-function optimization for func arguments
(ArgumentPromotion) at -O2 level. And this caused s390 sock_fields
test failure ([2]). The failure is gone right now as patch [1] was
reverted in [3]. But it is possible that patch [3] will be reverted
again and then the test failure in [2] will show up again. So it is
desirable to fix the failure regardless.

The following is an analysis why sock_field test fails with
llvm patch [1].

The main problem is in
  static __noinline bool sk_dst_port__load_word(struct bpf_sock *sk)
  {
        __u32 *word =3D (__u32 *)&sk->dst_port;
        return word[0] =3D=3D bpf_htons(0xcafe);
  }
  static __noinline bool sk_dst_port__load_half(struct bpf_sock *sk)
  {
        __u16 *half =3D (__u16 *)&sk->dst_port;
        return half[0] =3D=3D bpf_htons(0xcafe);
  }
  ...
  int read_sk_dst_port(struct __sk_buff *skb)
  {
	...
        sk =3D skb->sk;
	...
        if (!sk_dst_port__load_word(sk))
                RET_LOG();
        if (!sk_dst_port__load_half(sk))
                RET_LOG();
	...
  }

Through some cross-function optimization by ArgumentPromotion
optimization, the compiler does:
  static __noinline bool sk_dst_port__load_word(__u32 word_val)
  {
        return word_val =3D=3D bpf_htons(0xcafe);
  }
  static __noinline bool sk_dst_port__load_half(__u16 half_val)
  {
        return half_val =3D=3D bpf_htons(0xcafe);
  }
  ...
  int read_sk_dst_port(struct __sk_buff *skb)
  {
        ...
        sk =3D skb->sk;
        ...
        __u32 *word =3D (__u32 *)&sk->dst_port;
        __u32 word_val =3D word[0];
        ...
        if (!sk_dst_port__load_word(word_val))
                RET_LOG();

        __u16 half_val =3D word_val >> 16;
        if (!sk_dst_port__load_half(half_val))
                RET_LOG();
        ...
  }

In current uapi bpf.h, we have
  struct bpf_sock {
	...
        __be16 dst_port;        /* network byte order */
        __u16 :16;              /* zero padding */
	...
  };
But the old kernel (e.g., 5.6) we have
  struct bpf_sock {
	...
	__u32 dst_port;         /* network byte order */
	...
  };

So for backward compatability reason, 4-byte load of
dst_port is converted to 2-byte load internally.
Specifically, 'word_val =3D word[0]' is replaced by 2-byte load
by the verifier and this caused the trouble for later
sk_dst_port__load_half() where half_val becomes 0.

Typical usr program won't have such a code pattern tiggering
the above bug, so let us fix the test failure with source
code change. Adding an empty asm volatile statement seems
enough to prevent undesired transformation.

  [1] https://reviews.llvm.org/D148269
  [2] https://lore.kernel.org/bpf/e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta=
.com/
  [3] https://reviews.llvm.org/rG141be5c062ecf22bd287afffd310e8ac4711444a

Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/test_sock_fields.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/t=
esting/selftests/bpf/progs/test_sock_fields.c
index bbad3c2d9aa5..f75e531bf36f 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -265,7 +265,10 @@ static __noinline bool sk_dst_port__load_word(struct b=
pf_sock *sk)
=20
 static __noinline bool sk_dst_port__load_half(struct bpf_sock *sk)
 {
-	__u16 *half =3D (__u16 *)&sk->dst_port;
+	__u16 *half;
+
+	asm volatile ("");
+	half =3D (__u16 *)&sk->dst_port;
 	return half[0] =3D=3D bpf_htons(0xcafe);
 }
=20
--=20
2.34.1


