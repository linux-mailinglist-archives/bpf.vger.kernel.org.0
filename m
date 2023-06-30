Return-Path: <bpf+bounces-3775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FFB74375C
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B031C20BEE
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CA7A957;
	Fri, 30 Jun 2023 08:35:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15830A932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AF6C433C8;
	Fri, 30 Jun 2023 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114125;
	bh=Lo2VfRcx8TDju3ULQzfkd+mHlmoXoIiWwskwmwWB7rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uIpfkMmC86NglFlSxwjuWjG8ufAV0amw3i3iZlACmi2lmFiyWMozdCp/gvd6v7i0P
	 Ijcq3ALLPQ8cqYUtrIGQIYxSxneU4HCrA2U1XfjqpYxmDaPC8FQuPed6afp5BXl5Yp
	 PlKn/eIxT5KVlsAgntFWxzrvYycgGBI7eI1Led+78BKPl77lH0Gz3e2l3l68PL19U2
	 ACW1i69tiCWByIIL38bCtr2a/Ls/wsgv9J/KUA8C8QBzZpZuUo7wpYNy65dXaTbB52
	 Wj03PYFIS+BQ2c9TSvJ34h8CxWkGiId0hLh/7BaUTWWmwhP/Zy52vrY75W5WUVeugb
	 zdZCPvR2WWQ0A==
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
Subject: [PATCHv3 bpf-next 08/26] libbpf: Add elf_open/elf_close functions
Date: Fri, 30 Jun 2023 10:33:26 +0200
Message-ID: <20230630083344.984305-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding elf_open/elf_close functions and using it in
elf_find_func_offset_from_file function. It will be
used in following changes to save some common code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/elf.c        | 59 +++++++++++++++++++++++++-------------
 tools/lib/bpf/libbpf_elf.h |  8 ++++++
 tools/lib/bpf/usdt.c       | 31 ++++++--------------
 3 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 2b62b4af28ce..74e35071d22e 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -11,6 +11,40 @@
 
 #define STRERR_BUFSIZE  128
 
+int elf_open(const char *binary_path, struct elf_fd *elf_fd)
+{
+	char errmsg[STRERR_BUFSIZE];
+	int fd, ret;
+	Elf *elf;
+
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		pr_warn("elf: failed to init libelf for %s\n", binary_path);
+		return -LIBBPF_ERRNO__LIBELF;
+	}
+	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		ret = -errno;
+		pr_warn("elf: failed to open %s: %s\n", binary_path,
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
+void elf_close(struct elf_fd *elf_fd)
+{
+	elf_end(elf_fd->elf);
+	close(elf_fd->fd);
+}
+
 /* Return next ELF section of sh_type after scn, or first of that type if scn is NULL. */
 static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
 {
@@ -171,28 +205,13 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
  */
 long elf_find_func_offset_from_file(const char *binary_path, const char *name)
 {
-	char errmsg[STRERR_BUFSIZE];
+	struct elf_fd elf_fd;
 	long ret = -ENOENT;
-	Elf *elf;
-	int fd;
 
-	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		ret = -errno;
-		pr_warn("failed to open %s: %s\n", binary_path,
-			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+	ret = elf_open(binary_path, &elf_fd);
+	if (ret)
 		return ret;
-	}
-	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
-	if (!elf) {
-		pr_warn("elf: could not read elf from %s: %s\n", binary_path, elf_errmsg(-1));
-		close(fd);
-		return -LIBBPF_ERRNO__FORMAT;
-	}
-
-	ret = elf_find_func_offset(elf, binary_path, name);
-	elf_end(elf);
-	close(fd);
+	ret = elf_find_func_offset(elf_fd.elf, binary_path, name);
+	elf_close(&elf_fd);
 	return ret;
 }
-
diff --git a/tools/lib/bpf/libbpf_elf.h b/tools/lib/bpf/libbpf_elf.h
index 1b652220fabf..c763ac35a85e 100644
--- a/tools/lib/bpf/libbpf_elf.h
+++ b/tools/lib/bpf/libbpf_elf.h
@@ -5,6 +5,14 @@
 
 #include <libelf.h>
 
+struct elf_fd {
+	Elf *elf;
+	int fd;
+};
+
+int elf_open(const char *binary_path, struct elf_fd *elf_fd);
+void elf_close(struct elf_fd *elf_fd);
+
 long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name);
 long elf_find_func_offset_from_file(const char *binary_path, const char *name);
 
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index f1a141555f08..9fa883ebc0bd 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -19,6 +19,7 @@
 #include "libbpf.h"
 #include "libbpf_common.h"
 #include "libbpf_internal.h"
+#include "libbpf_elf.h"
 #include "hashmap.h"
 
 /* libbpf's USDT support consists of BPF-side state/code and user-space
@@ -943,32 +944,22 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 					  const char *usdt_provider, const char *usdt_name,
 					  __u64 usdt_cookie)
 {
-	int i, fd, err, spec_map_fd, ip_map_fd;
+	int i, err, spec_map_fd, ip_map_fd;
 	LIBBPF_OPTS(bpf_uprobe_opts, opts);
 	struct hashmap *specs_hash = NULL;
 	struct bpf_link_usdt *link = NULL;
 	struct usdt_target *targets = NULL;
+	struct elf_fd elf_fd;
 	size_t target_cnt;
-	Elf *elf;
 
 	spec_map_fd = bpf_map__fd(man->specs_map);
 	ip_map_fd = bpf_map__fd(man->ip_to_spec_id_map);
 
-	fd = open(path, O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		err = -errno;
-		pr_warn("usdt: failed to open ELF binary '%s': %d\n", path, err);
+	err = elf_open(path, &elf_fd);
+	if (err)
 		return libbpf_err_ptr(err);
-	}
 
-	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
-	if (!elf) {
-		err = -EBADF;
-		pr_warn("usdt: failed to parse ELF binary '%s': %s\n", path, elf_errmsg(-1));
-		goto err_out;
-	}
-
-	err = sanity_check_usdt_elf(elf, path);
+	err = sanity_check_usdt_elf(elf_fd.elf, path);
 	if (err)
 		goto err_out;
 
@@ -981,7 +972,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	/* discover USDT in given binary, optionally limiting
 	 * activations to a given PID, if pid > 0
 	 */
-	err = collect_usdt_targets(man, elf, path, pid, usdt_provider, usdt_name,
+	err = collect_usdt_targets(man, elf_fd.elf, path, pid, usdt_provider, usdt_name,
 				   usdt_cookie, &targets, &target_cnt);
 	if (err <= 0) {
 		err = (err == 0) ? -ENOENT : err;
@@ -1066,9 +1057,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 
 	free(targets);
 	hashmap__free(specs_hash);
-	elf_end(elf);
-	close(fd);
-
+	elf_close(&elf_fd);
 	return &link->link;
 
 err_out:
@@ -1076,9 +1065,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 		bpf_link__destroy(&link->link);
 	free(targets);
 	hashmap__free(specs_hash);
-	if (elf)
-		elf_end(elf);
-	close(fd);
+	elf_close(&elf_fd);
 	return libbpf_err_ptr(err);
 }
 
-- 
2.41.0


