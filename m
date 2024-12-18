Return-Path: <bpf+bounces-47280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63EA9F7054
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 23:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE2618943D8
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 22:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1CF1FC102;
	Wed, 18 Dec 2024 22:53:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3F1BDC3
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562385; cv=none; b=epbcCrkCwRbrcTaZ/UjAwolYWaPRTNfN26uTESk9P2/3HCP+QEZkwGH/yFA+uplcFzqsgEwS5oHxz4BvmYl1fHZcSfglZTcAkgYZdl+9bXl8SI3+M+oP8xvqEUWQlUhA09kgxfCS39RuQRDRzemrsHdfSsUVoGbfPRRJjx7BDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562385; c=relaxed/simple;
	bh=CtQQ/MyIgXV859VB3hLsJHAElLDX6UHrPtcmvjMcMSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVp7tjdTF/+lsokQXOBdj79gOZj7+k+GniIlYJENOoWUnychW0jBHEki5fY6tizmUNdh5c5aW1j+PI03TGe+6Tx4Y39WaEiYJB4kIGcmtuouutW7XtbCv9tlzmnRInDkZ+1KU7m6DRoc2kR9Br0rfIefM003d0M709VwviReT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 276B6C2A69C6; Wed, 18 Dec 2024 14:52:46 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jordan Rome <linux@jordanrome.com>
Subject: [PATCH bpf-next 1/2] libbpf: Add unique_match option for multi kprobe
Date: Wed, 18 Dec 2024 14:52:46 -0800
Message-ID: <20241218225246.3170300-1-yonghong.song@linux.dev>
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
 tools/lib/bpf/libbpf.c | 10 +++++++++-
 tools/lib/bpf/libbpf.h |  4 +++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5a2d..649c6e92972a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11522,7 +11522,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
 	struct bpf_link *link =3D NULL;
 	const unsigned long *addrs;
 	int err, link_fd, prog_fd;
-	bool retprobe, session;
+	bool retprobe, session, unique_match;
 	const __u64 *cookies;
 	const char **syms;
 	size_t cnt;
@@ -11558,6 +11558,14 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
 			err =3D libbpf_available_kallsyms_parse(&res);
 		if (err)
 			goto error;
+
+		unique_match =3D OPTS_GET(opts, unique_match, false);
+		if (unique_match && res.cnt !=3D 1) {
+			pr_warn("prog '%s': failed to find unique match: cnt %lu\n",
+				prog->name, res.cnt);
+			return libbpf_err_ptr(-EINVAL);
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


