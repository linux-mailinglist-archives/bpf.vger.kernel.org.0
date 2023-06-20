Return-Path: <bpf+bounces-2887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70991736662
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD83281129
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94CDBE62;
	Tue, 20 Jun 2023 08:37:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D710E5
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299E5C433C0;
	Tue, 20 Jun 2023 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250223;
	bh=8ua+Vb1NBWxPO1vcvFFz5SuVB5fzhHEUcxqQCECigXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDrrX2UnlZs0vKAan8vQ/CR+sAKVUsuKoWwUQk27m8umQeEITC3DYaGUs50vSe3z4
	 dFWxSCuP6UXC+Tqm1g1b72i8jKzddcoeo9oHniNEmR12ADcb/m1nCHGzmfVRBOwPSP
	 z41XsZqs9HcJuprHZ+xri57q4RUHGQD8n7kKzBm49t/qdKUzXhU/iqiwcTzha57JI1
	 vr2qWKunkjGr7Bjo/Tw19ZaR+JbxYevpgBnmpvpmEYG/ZWZUwwMImuksl2Zytfa1bR
	 0KuoLz1Xvuays6XnaGhZaa6esdh1a59Qeo9WiaVug98ufIlDkog1zjBkvK/zINa88G
	 QGRWT7G8B9pBA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 07/24] libbpf: Add open_elf/close_elf functions
Date: Tue, 20 Jun 2023 10:35:33 +0200
Message-ID: <20230620083550.690426-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding open_elf/close_elf functions and using it in
elf_find_func_offset_from_file function. It will be
used in following changes to save some code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cdac368c7ce1..30d9e3b69114 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10927,6 +10927,45 @@ static struct elf_symbol *elf_symbol_iter_next(struct elf_symbol_iter *iter)
 	return ret;
 }
 
+struct elf_fd {
+	Elf *elf;
+	int fd;
+};
+
+static int open_elf(const char *binary_path, struct elf_fd *elf_fd)
+{
+	char errmsg[STRERR_BUFSIZE];
+	int fd, ret;
+	Elf *elf;
+
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		pr_warn("failed to init libelf for %s\n", binary_path);
+		return -LIBBPF_ERRNO__LIBELF;
+	}
+	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		ret = -errno;
+		pr_warn("failed to open %s: %s\n", binary_path,
+			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+		return ret;
+	}
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf) {
+		pr_warn("elf: could not read elf from %s: %s\n", binary_path, elf_errmsg(-1));
+		close(fd);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+	elf_fd->fd = fd;
+	elf_fd->elf = elf;
+	return 0;
+}
+
+static void close_elf(struct elf_fd *elf_fd)
+{
+	elf_end(elf_fd->elf);
+	close(elf_fd->fd);
+}
+
 /* Find offset of function name in the provided ELF object. "binary_path" is
  * the path to the ELF binary represented by "elf", and only used for error
  * reporting matters. "name" matches symbol name or name@@LIB for library
@@ -11019,28 +11058,15 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
  */
 static long elf_find_func_offset_from_file(const char *binary_path, const char *name)
 {
-	char errmsg[STRERR_BUFSIZE];
+	struct elf_fd elf_fd = {};
 	long ret = -ENOENT;
-	Elf *elf;
-	int fd;
 
-	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		ret = -errno;
-		pr_warn("failed to open %s: %s\n", binary_path,
-			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+	ret = open_elf(binary_path, &elf_fd);
+	if (ret)
 		return ret;
-	}
-	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
-	if (!elf) {
-		pr_warn("elf: could not read elf from %s: %s\n", binary_path, elf_errmsg(-1));
-		close(fd);
-		return -LIBBPF_ERRNO__FORMAT;
-	}
 
-	ret = elf_find_func_offset(elf, binary_path, name);
-	elf_end(elf);
-	close(fd);
+	ret = elf_find_func_offset(elf_fd.elf, binary_path, name);
+	close_elf(&elf_fd);
 	return ret;
 }
 
-- 
2.41.0


