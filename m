Return-Path: <bpf+bounces-11831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948307C03FE
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 21:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506CD281DAC
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 19:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1601B2FE3E;
	Tue, 10 Oct 2023 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KY9hYzrj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D322EE5
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 19:00:05 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F416D9E
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:00:01 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39AIfGL3028186
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cQn7bQ3A/aQhtSUfhZfQNL/cNVl1iAG50XECxuQrbco=;
 b=KY9hYzrjQHlaMhq9vvsekhUFrl2MNhZGMATzq+OtcJA8PjosFY5p4fgSIOBLyjkywniQ
 NrNJCp9WMhpNSl7SEy6IbSxVhyCQzkz5yvVO6KoAeyboJU8DCw1WpE+mbZWCtKY/9K95
 VMxPpBhC3IJX1ezg2olMsL+n2jj/7IbtQiE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3tnc3sg60w-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:00:01 -0700
Received: from twshared37115.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 10 Oct 2023 11:59:58 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id AA172258848D5; Tue, 10 Oct 2023 11:59:46 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH v6 bpf-next 1/4] bpf: Don't explicitly emit BTF for struct btf_iter_num
Date: Tue, 10 Oct 2023 11:59:41 -0700
Message-ID: <20231010185944.3888849-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010185944.3888849-1-davemarchevsky@fb.com>
References: <20231010185944.3888849-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zbgeucSeUZDUx2wGMOnf9SuEys73u80T
X-Proofpoint-ORIG-GUID: zbgeucSeUZDUx2wGMOnf9SuEys73u80T
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_14,2023-10-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 6018e1f407cc ("bpf: implement numbers iterator") added the
BTF_TYPE_EMIT line that this patch is modifying. The struct btf_iter_num
doesn't exist, so only a forward declaration is emitted in BTF:

  FWD 'btf_iter_num' fwd_kind=3Dstruct

That commit was probably hoping to ensure that struct bpf_iter_num is
emitted in vmlinux BTF. A previous version of this patch changed the
line to emit the correct type, but Yonghong confirmed that it would
definitely be emitted regardless in [0], so this patch simply removes
the line.

This isn't marked "Fixes" because the extraneous btf_iter_num FWD wasn't
causing any issues that I noticed, aside from mild confusion when I
looked through the code.

  [0]: https://lore.kernel.org/bpf/25d08207-43e6-36a8-5e0f-47a913d4cda5@lin=
ux.dev/

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/bpf_iter.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 96856f130cbf..833faa04461b 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -793,8 +793,6 @@ __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *i=
t, int start, int end)
 	BUILD_BUG_ON(sizeof(struct bpf_iter_num_kern) !=3D sizeof(struct bpf_iter=
_num));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) !=3D __alignof__(struc=
t bpf_iter_num));
=20
-	BTF_TYPE_EMIT(struct btf_iter_num);
-
 	/* start =3D=3D end is legit, it's an empty range and we'll just get NULL
 	 * on first (and any subsequent) bpf_iter_num_next() call
 	 */
--=20
2.34.1


