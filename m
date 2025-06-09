Return-Path: <bpf+bounces-60078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D7AAD259F
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79D93B1603
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13EF21D594;
	Mon,  9 Jun 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="k/iI32uL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13BB17A2EF
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493851; cv=none; b=muJLepPH87/MHwxkKiOhi/XDa9M/yyTWdBOaK6WFS3u8x8EDmtZ5D7nvWVDHG0+3dMrzQJD2TTPRpuVp4YLnAGExXSVnyISGQeVgD1NK3a+Ju8ewkq17dc0cQgrpavZk/gjU+6MUP9jjFTlmn8uqXpbaSDDQgDPKaQW5r5ETbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493851; c=relaxed/simple;
	bh=DTF6CgfRwP86lt1jcpFqtEXFooDVYicv5HUoU1NHJeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDEyPm98lO3hB25FboHtnGhYsuiydC2McO2kcHUFT8WGtmWUqHZLnbSgJoyKzH6ErnN7hZ7Yo+S4KK4S+XhLgzqM5hFIv502IlOEo6T1rrFWBpDJN7OKJPSamvrSHR4YGn25nC+mKy5s8lWljSjzIkzmEb79EI+jUog13Y0bnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=k/iI32uL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559HVMXq026716
	for <bpf@vger.kernel.org>; Mon, 9 Jun 2025 11:30:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=h+CE7ihfsOykMIZiVWmdWMwZcopfA3FLVDNcCdLoBos=; b=
	k/iI32uLoxQCgSnYCksBF7SjuVZBDmaII/w+uugkq2ZKimvcjdD4D+5TYrXQTij4
	LjSM8E5E3lTmT7csj+EsMHU6s0Z2jnX+8dhzB02AL/IeA/8KWuY2yBW1+C1PS3GX
	DNkiVQZ1Ut/Uq7sL4iW/wLxBdPtn4caOkszfjmHeXDcxH1OQDBogHCrs2YN+PEr1
	pGD/kd5A5VZO3uQv/gUfCZUeeVNp5vglVKDTCotaer6OKBEWwFwB788WK7mgtdgy
	w6DhYKyocaTrv+RT6lg8A8RJeRQTvHYJrTxAw/ooFEphr5v1OB6U7K10pUkC5hZj
	G/ung0P2FsbRGzP3r8iesw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47559w7tcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 11:30:48 -0700 (PDT)
Received: from twshared4652.28.prn2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 9 Jun 2025 18:30:45 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id D2B1C94A1E1; Mon,  9 Jun 2025 11:30:43 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <yonghong.song@linux.dev>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: add test cases with CONST_PTR_TO_MAP null checks
Date: Mon, 9 Jun 2025 11:30:24 -0700
Message-ID: <20250609183024.359974-4-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609183024.359974-1-isolodrai@meta.com>
References: <20250609183024.359974-1-isolodrai@meta.com>
Reply-To: <ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vE8FPeDz7GyCh_-duqD4F6zSa3je1MGI
X-Proofpoint-ORIG-GUID: vE8FPeDz7GyCh_-duqD4F6zSa3je1MGI
X-Authority-Analysis: v=2.4 cv=CbsI5Krl c=1 sm=1 tr=0 ts=68472858 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=N004WaJ9pzYtcZtV3jIA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0MCBTYWx0ZWRfX1aguDnOTrLIN YHQorfb3YY6iK+QhuPAHkazHqo+IrjFETWZlor5qSKQDiLPQxVmuN3svHUrazN0ORTpv6eEVwPg 8LNf6KjgnGqDLP+043woDT+59PpctevCrSf3EGAAz5BcgH0DitDkbgn3hmOjqPwI22D3pBvpcO3
 jHMnvrkaBl827dSvl5mnMigw9cR1t4WACVHHW47voPYe/7NuPs++miH3eeZdyj+IrCoI8bnKFxW tIWGCGaiC35ZcaLU/clzhhA59Nyuaj14os9jTl/tv2TdTy8yaXJuF5T1SxzRdVva5QXeslBDsL7 mmAz2axnnzqpyuy9lAPmDVOfdXc489KZFbpb3gSgSLcM6ABuZdegOIACjIzj1YaRQNYoFRXGX+u
 Fbr/6nOMxV7nCARDlzer6X0/6krpwTC253oLPezfoOdcJgVqpmb1h9U/t9TvIiXBj5c1kpIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_07,2025-06-09_02,2025-03-28_01

A test requires the following to happen:
  * CONST_PTR_TO_MAP value is checked for null
  * the code in the null branch fails verification

Add test cases:
* direct global map_ptr comparison to null
* lookup inner map, then two checks (the first transforms
  map_value_or_null into map_ptr)
* lookup inner map, spill-fill it, then check for null
* use an array of ringbufs to recreate a common coding pattern [1]

[1] https://lore.kernel.org/bpf/CAEf4BzZNU0gX_sQ8k8JaLe1e+Veth3Rk=3D4x7MD=
hv=3DhQxvO8EDw@mail.gmail.com/

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/verifier_map_in_map.c | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/to=
ols/testing/selftests/bpf/progs/verifier_map_in_map.c
index 7d088ba99ea5..16b761e510f0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -139,4 +139,122 @@ __naked void on_the_inner_map_pointer(void)
 	: __clobber_all);
 }
=20
+SEC("socket")
+__description("map_ptr is never null")
+__success
+__naked void map_ptr_is_never_null(void)
+{
+	asm volatile ("					\
+	r0 =3D 0;						\
+	r1 =3D %[map_in_map] ll;				\
+	if r1 !=3D 0 goto l0_%=3D;				\
+	r10 =3D 42;					\
+l0_%=3D:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_in_map)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map_ptr is never null inner")
+__success
+__naked void map_ptr_is_never_null_inner(void)
+{
+	asm volatile ("					\
+	r1 =3D 0;						\
+	*(u32*)(r10 - 4) =3D r1;				\
+	r2 =3D r10;					\
+	r2 +=3D -4;					\
+	r1 =3D %[map_in_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 =3D=3D 0 goto l0_%=3D;				\
+	if r0 !=3D 0 goto l0_%=3D;				\
+	r10 =3D 42;					\
+l0_%=3D:  exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_in_map)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map_ptr is never null inner spill fill")
+__success
+__naked void map_ptr_is_never_null_inner_spill_fill(void)
+{
+	asm volatile ("					\
+	r1 =3D 0;						\
+	*(u32*)(r10 - 4) =3D r1;				\
+	r2 =3D r10;					\
+	r2 +=3D -4;					\
+	r1 =3D %[map_in_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 !=3D 0 goto l0_%=3D;				\
+	exit;						\
+l0_%=3D:	*(u64 *)(r10 -16) =3D r0;				\
+	r1 =3D *(u64 *)(r10 -16);				\
+	if r1 =3D=3D 0 goto l1_%=3D;				\
+	exit;						\
+l1_%=3D:	r10 =3D 42;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_in_map)
+	: __clobber_all);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_RINGBUF);
+		__uint(max_entries, 64 * 1024);
+	});
+} rb_in_map SEC(".maps");
+
+struct rb_ctx {
+	void *rb;
+	struct bpf_dynptr dptr;
+};
+
+static __always_inline struct rb_ctx __rb_event_reserve(__u32 sz)
+{
+	struct rb_ctx rb_ctx =3D {};
+	void *rb;
+	__u32 cpu =3D bpf_get_smp_processor_id();
+	__u32 rb_slot =3D cpu & 1;
+
+	rb =3D bpf_map_lookup_elem(&rb_in_map, &rb_slot);
+	if (!rb)
+		return rb_ctx;
+
+	rb_ctx.rb =3D rb;
+	bpf_ringbuf_reserve_dynptr(rb, sz, 0, &rb_ctx.dptr);
+
+	return rb_ctx;
+}
+
+static __noinline void __rb_event_submit(struct rb_ctx *ctx)
+{
+	if (!ctx->rb)
+		return;
+
+	/* If the verifier (incorrectly) concludes that ctx->rb can be
+	 * NULL at this point, we'll get "BPF_EXIT instruction in main
+	 * prog would lead to reference leak" error
+	 */
+	bpf_ringbuf_submit_dynptr(&ctx->dptr, 0);
+}
+
+SEC("socket")
+int map_ptr_is_never_null_rb(void *ctx)
+{
+	struct rb_ctx event_ctx =3D __rb_event_reserve(256);
+	__rb_event_submit(&event_ctx);
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.47.1


