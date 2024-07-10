Return-Path: <bpf+bounces-34355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C575E92C9C2
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 06:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A8B2274C
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 04:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19A142056;
	Wed, 10 Jul 2024 04:29:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D1210FF
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720585776; cv=none; b=TQ/GUw5q3xAkRNpuZyARvohCe7iYmYZSYjrCBwRYwQPJsjUhgUdC01K/nF8XDNg3Ydbq5qughptR6R6Vp3aK+ZUc4y54L68dpZaNHspjw8HxxHBjOOlngHCaKOywSuej7Fl/RQuTBizpgWCjra0Zgb3wtypsfjBmZvyRfsGgRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720585776; c=relaxed/simple;
	bh=2SD9UZGiJHpfsSe7bJx8VQwUpBh+9s0J/NOp74mTcJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6vC7q5vfi+ilv1RhxK0DnuF8ceygifr9b0jt7Bi42T03AXMXru6AkS7qb6kamEaclZ+DQz7ywFbWg3jr0b9TvQvTbaHoQPht2kL99KfwHCH+epvXmU+ayYPTUVetOK/CDT5HI7V+WDxpIgV6VAQ4iWk48P9vXst7SuSXBHUNYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A914866A8CF9; Tue,  9 Jul 2024 21:29:20 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add ldsx selftests for ldsx and subreg compare
Date: Tue,  9 Jul 2024 21:29:20 -0700
Message-ID: <20240710042920.1212221-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710042915.1211933-1-yonghong.song@linux.dev>
References: <20240710042915.1211933-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a few selftests to test 32/16/8-bit ldsx followed by subreg compariso=
n.
Without the previous patch, all added tests will fail.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_ldsx.c       | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
index d4427d8e1217..3b96a9436a0c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -144,6 +144,112 @@ __naked void ldsx_s32_range(void)
 	: __clobber_all);
 }
=20
+#define MAX_ENTRIES 12
+
+struct test_val {
+        int foo[MAX_ENTRIES];
+};
+
+struct {
+        __uint(type, BPF_MAP_TYPE_HASH);
+        __uint(max_entries, 1);
+        __type(key, long long);
+        __type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+SEC("socket")
+__description("LDSX, S8, subreg compare")
+__success __success_unpriv
+__naked void ldsx_s8_subreg_compare(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"*(u64 *)(r10 - 8) =3D r0;"
+	"w6 =3D w0;"
+	"if w6 > 0x1f goto l0_%=3D;"
+	"r7 =3D *(s8 *)(r10 - 8);"
+	"if w7 > w6 goto l0_%=3D;"
+	"r1 =3D 0;"
+	"*(u64 *)(r10 - 8) =3D r1;"
+	"r2 =3D r10;"
+	"r2 +=3D -8;"
+	"r1 =3D %[map_hash_48b] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 =3D=3D 0 goto l0_%=3D;"
+	"r0 +=3D r7;"
+	"*(u64 *)(r0 + 0) =3D 1;"
+"l0_%=3D:"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_addr(map_hash_48b),
+	  __imm(bpf_map_lookup_elem)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("LDSX, S16, subreg compare")
+__success __success_unpriv
+__naked void ldsx_s16_subreg_compare(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"*(u64 *)(r10 - 8) =3D r0;"
+	"w6 =3D w0;"
+	"if w6 > 0x1f goto l0_%=3D;"
+	"r7 =3D *(s16 *)(r10 - 8);"
+	"if w7 > w6 goto l0_%=3D;"
+	"r1 =3D 0;"
+	"*(u64 *)(r10 - 8) =3D r1;"
+	"r2 =3D r10;"
+	"r2 +=3D -8;"
+	"r1 =3D %[map_hash_48b] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 =3D=3D 0 goto l0_%=3D;"
+	"r0 +=3D r7;"
+	"*(u64 *)(r0 + 0) =3D 1;"
+"l0_%=3D:"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_addr(map_hash_48b),
+	  __imm(bpf_map_lookup_elem)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("LDSX, S32, subreg compare")
+__success __success_unpriv
+__naked void ldsx_s32_subreg_compare(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"*(u64 *)(r10 - 8) =3D r0;"
+	"w6 =3D w0;"
+	"if w6 > 0x1f goto l0_%=3D;"
+	"r7 =3D *(s32 *)(r10 - 8);"
+	"if w7 > w6 goto l0_%=3D;"
+	"r1 =3D 0;"
+	"*(u64 *)(r10 - 8) =3D r1;"
+	"r2 =3D r10;"
+	"r2 +=3D -8;"
+	"r1 =3D %[map_hash_48b] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 =3D=3D 0 goto l0_%=3D;"
+	"r0 +=3D r7;"
+	"*(u64 *)(r0 + 0) =3D 1;"
+"l0_%=3D:"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_addr(map_hash_48b),
+	  __imm(bpf_map_lookup_elem)
+	: __clobber_all);
+}
+
 #else
=20
 SEC("socket")
--=20
2.43.0


