Return-Path: <bpf+bounces-59325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B07AC8316
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 22:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433F516A596
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7B2920B0;
	Thu, 29 May 2025 20:12:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9191DF25A
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549528; cv=none; b=dLlEeasEirDkCX72tOVAaXuwAyAfUjUhl7QZK0R/Rw/rZz8ahhPaaMYnjsZvcweD1td/Z6ja3kK4h+Tb/QBmL0lTU89L/chK0ZfBLM989OB9vm4mbt7AXYvOTdunREL7QV1nUvpgW1cK6pG2YzX0AxKJOXSASf+gV3u8qc5pASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549528; c=relaxed/simple;
	bh=nAJiBG9Ga5LOHXluTkujwLKvexKI9YpkNAWedViJFZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6evsjiYZmF+U6eGlQhHbV5AFzfnMWwDipI/lg9EdeKWX5kleE60B/u2AW/2OXGIWEAg2XAFWdwQxFkGu8Vep+1o8KnjoBCZM80HCayNkY+rF7v2/2BdV55Lbqu28VoDUeCFs1MTqvSMuWhsqAzTnv/JuaVP/giVJUTN9cvADf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 519B587ADD39; Thu, 29 May 2025 13:11:51 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix selftest btf_tag/btf_type_tag_percpu_vmlinux_helper failure
Date: Thu, 29 May 2025 13:11:51 -0700
Message-ID: <20250529201151.1787575-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ihor Solodrai reported selftest 'btf_tag/btf_type_tag_percpu_vmlinux_help=
er'
failure ([1]) during 6.16 merge window. The failure log:

  ...
  7: (15) if r0 =3D=3D 0x0 goto pc+1        ; R0=3Dptr_css_rstat_cpu()
  ; *(volatile int *)rstat; @ btf_type_tag_percpu.c:68
  8: (61) r1 =3D *(u32 *)(r0 +0)
  cannot access ptr member updated_children with moff 0 in struct css_rst=
at_cpu with off 0 size 4

Two changes are needed. First, 'struct cgroup_rstat_cpu' needs to be
replaced with 'struct css_rstat_cpu' to be consistent with new data
structure. Second, layout of 'css_rstat_cpu' is changed compared
to 'cgroup_rstat_cpu'. The first member becomes a pointer so
the bpf prog needs to do 8-byte load instead of 4-byte load.

  [1] https://lore.kernel.org/bpf/6f688f2e-7d26-423a-9029-d1b1ef1c938a@li=
nux.dev/

Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/to=
ols/testing/selftests/bpf/progs/btf_type_tag_percpu.c
index 69f81cb555ca..d93f68024cc6 100644
--- a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
@@ -57,15 +57,15 @@ int BPF_PROG(test_percpu_load, struct cgroup *cgrp, c=
onst char *path)
 SEC("tp_btf/cgroup_mkdir")
 int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
 {
-	struct cgroup_rstat_cpu *rstat;
+	struct css_rstat_cpu *rstat;
 	__u32 cpu;
=20
 	cpu =3D bpf_get_smp_processor_id();
-	rstat =3D (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(
+	rstat =3D (struct css_rstat_cpu *)bpf_per_cpu_ptr(
 			cgrp->self.rstat_cpu, cpu);
 	if (rstat) {
 		/* READ_ONCE */
-		*(volatile int *)rstat;
+		*(volatile long *)rstat;
 	}
=20
 	return 0;
--=20
2.47.1


