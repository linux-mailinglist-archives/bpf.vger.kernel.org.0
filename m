Return-Path: <bpf+bounces-48425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CABCA07F13
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEB2188D402
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A427D199235;
	Thu,  9 Jan 2025 17:40:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82639190678
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444438; cv=none; b=tm48D3JErahat/6tCAR+9y5rD59yLTP8aBJx8ekrV8xlGtYCRN2bkjM4xS3wwHiONTCkc/hDmR/ApXTwAOPn94P563hGWlFhdxcNVUT2zD2CPCYyG4wiXeq5HSha5kPsEiw4ujckIzvBFC2W9RIHOy/0cEjzOUbJggYj6W/zJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444438; c=relaxed/simple;
	bh=xOwCVbftli213R3xGiwN4Czgva/tqsx7e9n7BQ1cyuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUKVy4wEkUeKsmsEm0+Ssrlvbg+h+DeRlvws8XGehOQ97fBlXkGH6CnJjC131gRs2hvXQNkzBGLM1JXolXVJwyLRDrQ1F5XfHX1HQ1XiG/EX1rzB+jKpdn+I9dtrsNtybP6bFq/ijP1G0qrx0bIpjGRBPk+PJCCovUug0On6KTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 92E49CCB236A; Thu,  9 Jan 2025 09:40:23 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jordan Rome <linux@jordanrome.com>
Subject: [PATCH bpf-next v2 1/2] libbpf: Add unique_match option for multi kprobe
Date: Thu,  9 Jan 2025 09:40:23 -0800
Message-ID: <20250109174023.3368432-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Jordan reported an issue in Meta production environment where func
try_to_wake_up() is renamed to try_to_wake_up.llvm.<hash>() by clang
compiler at lto mode. The original 'kprobe/try_to_wake_up' does not
work any more since try_to_wake_up() does not match the actual func
name in /proc/kallsyms.

There are a couple of ways to resolve this issue. For example, in
attach_kprobe(), we could do lookup in /proc/kallsyms so try_to_wake_up()
can be replaced by try_to_wake_up.llvm.<hach>(). Or we can force users
to use bpf_program__attach_kprobe() where they need to lookup
/proc/kallsyms to find out try_to_wake_up.llvm.<hach>(). But these two
approaches requires extra work by either libbpf or user.

Luckily, suggested by Andrii, multi kprobe already supports wildcard ('*'=
)
for symbol matching. In the above example, 'try_to_wake_up*' can match
to try_to_wake_up() or try_to_wake_up.llvm.<hash>() and this allows
bpf prog works for different kernels as some kernels may have
try_to_wake_up() and some others may have try_to_wake_up.llvm.<hash>().

The original intention is to kprobe try_to_wake_up() only, so an optional
field unique_match is added to struct bpf_kprobe_multi_opts. If the
field is set to true, the number of matched functions must be one.
Otherwise, the attachment will fail. In the above case, multi kprobe
with 'try_to_wake_up*' and unique_match preserves user functionality.

Reported-by: Jordan Rome <linux@jordanrome.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c | 13 ++++++++++++-
 tools/lib/bpf/libbpf.h |  4 +++-
 2 files changed, 15 insertions(+), 2 deletions(-)

Changelog:
  v1 -> v2:
    - Avoid possible memory leak of res.addrs.
    - Return an error for !pattern && unique_match case.

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 46492cc0927d..a7cc6545ec63 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11534,7 +11534,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
 	struct bpf_link *link =3D NULL;
 	const unsigned long *addrs;
 	int err, link_fd, prog_fd;
-	bool retprobe, session;
+	bool retprobe, session, unique_match;
 	const __u64 *cookies;
 	const char **syms;
 	size_t cnt;
@@ -11553,6 +11553,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
 	addrs   =3D OPTS_GET(opts, addrs, false);
 	cnt     =3D OPTS_GET(opts, cnt, false);
 	cookies =3D OPTS_GET(opts, cookies, false);
+	unique_match =3D OPTS_GET(opts, unique_match, false);
=20
 	if (!pattern && !addrs && !syms)
 		return libbpf_err_ptr(-EINVAL);
@@ -11560,6 +11561,8 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 	if (!pattern && !cnt)
 		return libbpf_err_ptr(-EINVAL);
+	if (!pattern && unique_match)
+		return libbpf_err_ptr(-EINVAL);
 	if (addrs && syms)
 		return libbpf_err_ptr(-EINVAL);
=20
@@ -11570,6 +11573,14 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
 			err =3D libbpf_available_kallsyms_parse(&res);
 		if (err)
 			goto error;
+
+		if (unique_match && res.cnt !=3D 1) {
+			pr_warn("prog '%s': failed to find a unique match, num matches: %lu\n=
",
+				prog->name, res.cnt);
+			err =3D -EINVAL;
+			goto error;
+		}
+
 		addrs =3D res.addrs;
 		cnt =3D res.cnt;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d45807103565..3020ee45303a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -552,10 +552,12 @@ struct bpf_kprobe_multi_opts {
 	bool retprobe;
 	/* create session kprobes */
 	bool session;
+	/* enforce unique match */
+	bool unique_match;
 	size_t :0;
 };
=20
-#define bpf_kprobe_multi_opts__last_field session
+#define bpf_kprobe_multi_opts__last_field unique_match
=20
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
--=20
2.43.5


