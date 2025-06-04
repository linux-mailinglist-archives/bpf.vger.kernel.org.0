Return-Path: <bpf+bounces-59572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F31ACD0B8
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A21D3A732E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674F6DDC1;
	Wed,  4 Jun 2025 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AY0/YgFd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D6C2FA
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997519; cv=none; b=Jd/8wdrxsTdHFNz9l+XX7UJ681cbSyLvUx6G8WD7pnrV2IDRm/suU+QSw5vbHrDljUD6UgzteuLC1A/vVHDtNmnZ+pymy93KcrDAk//Pnk46sqdzp9+FJwSLr5VKfR3lNwUYqowsnozrGmB1E5oqAPgrwg99SSzSbQvlChwSync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997519; c=relaxed/simple;
	bh=ModqsCBrFmdPKCY7KyZBdvaVC9o4FwbS4e0il+sD1Pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pS2mIPd/e2jLv0SQWeXRuFhaaqSI00pBd1tf8R4A+zTuunInOMte7ni306BpfV9ntbajrkND7aB4pcO0oOpe5tNp3Ss3lg0pyrUTZGDu0Xo4JjLLAZsXJc7997/NJakkAwqhxkcPmrUUa9eQlaka5oLiAEOLIdBzOwiwVlBFktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AY0/YgFd; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 553MunHx023549
	for <bpf@vger.kernel.org>; Tue, 3 Jun 2025 17:38:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=SwkVB8OB/PCyzLTD4BGRlVMqGcpAxsh3XvN0roqoU8I=; b=
	AY0/YgFd7NTlwFkKm/HGl07UjfV+0MhKFodLeWu5cJDE6IkMxXk8u5oJ+ZyyMOkY
	BmMuwtQeQj/DK3c/cRukkiFYHQI7Uz5eMRy8MmC9WSv1H8PgJMRIUgCT/rcNlO2G
	pdbCiTOSo73PhvwZGe2T61PnPsGlQLfXqZxuNvsYoFJ1o5u2GRS5dD4XrULLnmUn
	I/kd4DQwRhVsld0gfPynr2vlTRAt6z2y+8K8A3zbptNfncokCOtdBSE5Ox1RcKWK
	qCCsgpQC9ZbykNByE9+IfQ8t5hLQPjtBH0ud7pQKytf/8cPRekkkgAEzFIInd3H4
	GR1hzPce+PILmExTnh5/3A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 471x0pxgp8-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 17:38:35 -0700 (PDT)
Received: from twshared71637.05.prn6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 4 Jun 2025 00:38:31 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 855F4343F85; Tue,  3 Jun 2025 17:38:25 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: add test cases with CONST_PTR_TO_MAP null checks
Date: Tue, 3 Jun 2025 17:37:59 -0700
Message-ID: <20250604003759.1020745-3-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250604003759.1020745-1-isolodrai@meta.com>
References: <20250604003759.1020745-1-isolodrai@meta.com>
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
X-Authority-Analysis: v=2.4 cv=UrljN/wB c=1 sm=1 tr=0 ts=683f958b cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=-RqxKfJqtAKTVEPrGAIA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDAwMiBTYWx0ZWRfX4vdAlo/ccNnv tE25XMrS6aCbzdL4XxxPcqsk+qhvBGGHLJd2kBv3/IpMdLZyEyf0ASq4rd/sUSAo2NbYRjWQrOV E75Ut0PNwramSlMAlzma0kx0fTQsD9gEUPDH5SEpHqpR1oXfdJadVrzkqZ9l34CkoWqXxFhpIcA
 5OpvjGP/ORp3P6bkf49+EIFc7tixLITtljFKJom9VHTAbLI/dfG2cTmS4nLZMNB8JV7td/dk40p hx5hQiXAqkU1VuLjaOm+1fLxxZCY3HNoUPDEzs6zHBcRZpxWR3z8/48RiNPOTY5vStCdiIsdfgc msvP8KgXg5K4unmQkFsFBwSHMvsADv9BrSRdI2grC+gm9UDWsNcMU2X0yPLygysmB/gq6EJxSBv
 n53FQx4baNQPw5EnrvzYk4b5x7Js50hvkbwXxtqSd7QqCS/LZJu23xicIIoj3Q16rNWPvhNd
X-Proofpoint-ORIG-GUID: EixJ8jQ9ewHYITjf6XkUZtLEpVUbEIZK
X-Proofpoint-GUID: EixJ8jQ9ewHYITjf6XkUZtLEpVUbEIZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01

A test requires the following to happen:
  * CONST_PTR_TO_MAP value is put on the stack
  * then this value is checked for null
  * the code in the null branch fails verification

I was able to achieve this by using a stack allocated array of maps,
populated with values from a global map. This is the first test case:
map_ptr_is_never_null.

The second test case (map_ptr_is_never_null_rb) involves an array of
ringbufs and attempts to recreate a common coding pattern [1].

[1] https://lore.kernel.org/bpf/CAEf4BzZNU0gX_sQ8k8JaLe1e+Veth3Rk=3D4x7MD=
hv=3DhQxvO8EDw@mail.gmail.com/

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../selftests/bpf/progs/verifier_map_in_map.c | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/to=
ols/testing/selftests/bpf/progs/verifier_map_in_map.c
index 7d088ba99ea5..1dd5c6902c53 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -139,4 +139,81 @@ __naked void on_the_inner_map_pointer(void)
 	: __clobber_all);
 }
=20
+SEC("socket")
+int map_ptr_is_never_null(void *ctx)
+{
+	struct bpf_map *maps[2] =3D { 0 };
+	struct bpf_map *map =3D NULL;
+	int __attribute__((aligned(8))) key =3D 0;
+
+	for (key =3D 0; key < 2; key++) {
+		map =3D bpf_map_lookup_elem(&map_in_map, &key);
+		if (map)
+			maps[key] =3D map;
+		else
+			return 0;
+	}
+
+	/* After the loop every element of maps is CONST_PTR_TO_MAP so
+	 * the invalid branch should not be explored by the verifier.
+	 */
+	if (!maps[0])
+		asm volatile ("r10 =3D 0;");
+
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_RINGBUF);
+		__uint(max_entries, 4096);
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


