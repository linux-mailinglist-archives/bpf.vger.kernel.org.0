Return-Path: <bpf+bounces-4929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A9175188F
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA30281AF3
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E305698;
	Thu, 13 Jul 2023 06:07:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814DB5679
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:07:53 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D456A1FD7
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:07:45 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CMvX9m003207
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:07:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jcVt5rbL5yWHX2y2rj8Y3v3u4bFK0w0cDL1Q4eq8xDs=;
 b=KXiCOkw/nrwkmsE+6tij/qeKWjzo9n12cg4dT62shQqx1rcFgLhmahGU1n5kI3RjeCcH
 yjQqslfLWT8dUJLbM01zHHwOvfmgLlFSeHANt/D7H+9N7+Jmt5VJkPTqwjq18kxgwJ5B
 ZLG5zw9/amjmgn6WlTgkLGaBiMkL12UuK8o= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsgfqtq5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:07:44 -0700
Received: from twshared18891.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:07:43 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4CFE522EFA262; Wed, 12 Jul 2023 23:07:29 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 02/15] bpf: Fix sign-extension ctx member accesses
Date: Wed, 12 Jul 2023 23:07:29 -0700
Message-ID: <20230713060729.390027-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713060718.388258-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0F7oZLTv6ZMFB4Byj12e_TBCX4BUY1-9
X-Proofpoint-ORIG-GUID: 0F7oZLTv6ZMFB4Byj12e_TBCX4BUY1-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_02,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In uapi bpf.h, there are two ctx structures which contain
signed members. Without cpu v4, such signed members will
be loaded with unsigned load and the compiler will generate
proper left and right shifts to get the proper final value.

With sign-extension load, however, left/right shifts are gone,
we need to ensure these signed members are properly handled,
with signed loads or other means. The following are list of
signed ctx members and how they are handled.

(1).
  struct bpf_sock {
     ...
     __s32 rx_queue_mapping;
  }

The corresponding kernel fields are
  struct sock_common {
     ...
     unsigned short          skc_rx_queue_mapping;
     ...
  }

Current ctx rewriter uses unsigned load for the kernel field
which is correct and does not need further handling.

(2).
  struct bpf_sockopt {
     ...
     __s32   level;
     __s32   optname;
     __s32   optlen;
     __s32   retval;
  }
The level/optname/optlen are from struct bpf_sockopt_kern
  struct bpf_sockopt_kern {
     ...
     s32             level;
     s32             optname;
     s32             optlen;
     ...
  }
and the 'retval' is from struct bpf_cg_run_ctx
  struct bpf_cg_run_ctx {
     ...
     int retval;
  }
Current the above four fields are loaded with unsigned load.
Let us modify the read macro for bpf_sockopt which use
the same signedness for the original insn.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/cgroup.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..29e3606ff6f4 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2397,9 +2397,10 @@ static bool cg_sockopt_is_valid_access(int off, in=
t size,
 }
=20
 #define CG_SOCKOPT_READ_FIELD(F)					\
-	BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F),	\
+	BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F) |	\
+		      BPF_MODE(si->code) | BPF_CLASS(si->code)),	\
 		    si->dst_reg, si->src_reg,				\
-		    offsetof(struct bpf_sockopt_kern, F))
+		    offsetof(struct bpf_sockopt_kern, F), si->imm)
=20
 #define CG_SOCKOPT_WRITE_FIELD(F)					\
 	BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F) |	\
@@ -2456,7 +2457,7 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_a=
ccess_type type,
 			*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ctx)=
,
 					      treg, treg,
 					      offsetof(struct task_struct, bpf_ctx));
-			*insn++ =3D BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_MEM |
+			*insn++ =3D BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_MODE(si->code) |
 					       BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retval),
 					       treg, si->src_reg,
 					       offsetof(struct bpf_cg_run_ctx, retval),
@@ -2470,9 +2471,10 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_=
access_type type,
 			*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ctx)=
,
 					      si->dst_reg, si->dst_reg,
 					      offsetof(struct task_struct, bpf_ctx));
-			*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retva=
l),
-					      si->dst_reg, si->dst_reg,
-					      offsetof(struct bpf_cg_run_ctx, retval));
+			*insn++ =3D BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, ret=
val) |
+						BPF_MODE(si->code) | BPF_CLASS(si->code)),
+					       si->dst_reg, si->dst_reg,
+					       offsetof(struct bpf_cg_run_ctx, retval), si->imm);
 		}
 		break;
 	case offsetof(struct bpf_sockopt, optval):
--=20
2.34.1


