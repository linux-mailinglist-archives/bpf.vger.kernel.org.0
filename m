Return-Path: <bpf+bounces-46162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7949E5809
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 14:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF7E28B927
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBFA218EA7;
	Thu,  5 Dec 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+Z9iLRA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEE1D5AD3
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407191; cv=none; b=IU/akbsxLoYGaOlWjZnFsPLjEqTj6pisJOJ4YL6W5JKJ7pVo4cyxxQ1C8x9qDXzfU9GL05i1x+qAGfUFDLZm5OfI5rDQXytsoF8AWk6bvwtgGzNjstj8+CMz7w/lHlirozfsuQKvYlT5/wQhCnVMXHsR216yaIZKS7MDbkG8JR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407191; c=relaxed/simple;
	bh=Td71PiCmLdAK9aGa3Ehq0NeQQVQdKZEYmxIZDkuR8bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDKsdpMYH2Nispc2E4zQHg6s+47oTEtH5iqY1JUn2v3yiOrVF7jHdYK73kxD6kefOpaxGTre+2adqX/zMlOoMqmThmNXUqZoBJqyvje7KkEMhi2zmDgINjyw5i686gS44XKVGjkYtjlSDIB4ubznsI+S+dVVHbZzgTNyfIG1uZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+Z9iLRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5300CC4CED1;
	Thu,  5 Dec 2024 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733407190;
	bh=Td71PiCmLdAK9aGa3Ehq0NeQQVQdKZEYmxIZDkuR8bY=;
	h=From:To:Cc:Subject:Date:From;
	b=L+Z9iLRAdPeyylL5lba2m4zZs+SZSXkKvZqtvKNc/1uSCqjzR1Emct6uYKh7DNRos
	 VbuOar6qiHlA2YAweEAEIx9wcPPXFhhoJ/ZbNvSZmiYrqPsxyMbm/JC/uZlO54STfF
	 cYO+d4e78qBA7oPRX7JJ/AeQqbownZDxlMckzmD+4U+x17UN0GD1y/fmA/ZY10hGt+
	 EelVREyFU8PQy4iBydWNyMcnn77eU838Pn4NzzRl1cn7w/4E5AxytSwRokrJdWvrm/
	 z6O2d/r/lCwFeSfB6YFFU6w55iG12HtILbzzTzHSQcYLQvytB3JcAGpEiVF984XxEM
	 RmQ0sjgpm9dmA==
From: Quentin Monnet <qmo@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next] libbpf: Fix segfault due to libelf functions not setting errno
Date: Thu,  5 Dec 2024 13:59:42 +0000
Message-ID: <20241205135942.65262-1-qmo@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Libelf functions do not set errno on failure. Instead, it relies on its
internal _elf_errno value, that can be retrieved via elf_errno (or the
corresponding message via elf_errmsg()). From "man libelf":

    If a libelf function encounters an error it will set an internal
    error code that can be retrieved with elf_errno. Each thread
    maintains its own separate error code. The meaning of each error
    code can be determined with elf_errmsg, which returns a string
    describing the error.

As a consequence, libbpf should not return -errno when a function from
libelf fails, because an empty value will not be interpreted as an error
and won't prevent the program to stop. This is visible in
bpf_linker__add_file(), for example, where we call a succession of
functions that rely on libelf:

    err = err ?: linker_load_obj_file(linker, filename, opts, &obj);
    err = err ?: linker_append_sec_data(linker, &obj);
    err = err ?: linker_append_elf_syms(linker, &obj);
    err = err ?: linker_append_elf_relos(linker, &obj);
    err = err ?: linker_append_btf(linker, &obj);
    err = err ?: linker_append_btf_ext(linker, &obj);

If the object file that we try to process is not, in fact, a correct
object file, linker_load_obj_file() may fail with errno not being set,
and return 0. In this case we attempt to run linker_append_elf_sysms()
and may segfault.

This can happen (and was discovered) with bpftool:

    $ bpftool gen object output.o sample_ret0.bpf.c
    libbpf: failed to get ELF header for sample_ret0.bpf.c: invalid `Elf' handle
    zsh: segmentation fault (core dumped)  bpftool gen object output.o sample_ret0.bpf.c

Fix the issue by returning a non-null error code (-EINVAL) when libelf
functions fail.

Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/lib/bpf/linker.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index cf71d149fe26..e56ba6e67451 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -566,17 +566,15 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 	}
 	obj->elf = elf_begin(obj->fd, ELF_C_READ_MMAP, NULL);
 	if (!obj->elf) {
-		err = -errno;
 		pr_warn_elf("failed to parse ELF file '%s'", filename);
-		return err;
+		return -EINVAL;
 	}
 
 	/* Sanity check ELF file high-level properties */
 	ehdr = elf64_getehdr(obj->elf);
 	if (!ehdr) {
-		err = -errno;
 		pr_warn_elf("failed to get ELF header for %s", filename);
-		return err;
+		return -EINVAL;
 	}
 
 	/* Linker output endianness set by first input object */
@@ -606,9 +604,8 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 	}
 
 	if (elf_getshdrstrndx(obj->elf, &obj->shstrs_sec_idx)) {
-		err = -errno;
 		pr_warn_elf("failed to get SHSTRTAB section index for %s", filename);
-		return err;
+		return -EINVAL;
 	}
 
 	scn = NULL;
@@ -618,26 +615,23 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 
 		shdr = elf64_getshdr(scn);
 		if (!shdr) {
-			err = -errno;
 			pr_warn_elf("failed to get section #%zu header for %s",
 				    sec_idx, filename);
-			return err;
+			return -EINVAL;
 		}
 
 		sec_name = elf_strptr(obj->elf, obj->shstrs_sec_idx, shdr->sh_name);
 		if (!sec_name) {
-			err = -errno;
 			pr_warn_elf("failed to get section #%zu name for %s",
 				    sec_idx, filename);
-			return err;
+			return -EINVAL;
 		}
 
 		data = elf_getdata(scn, 0);
 		if (!data) {
-			err = -errno;
 			pr_warn_elf("failed to get section #%zu (%s) data from %s",
 				    sec_idx, sec_name, filename);
-			return err;
+			return -EINVAL;
 		}
 
 		sec = add_src_sec(obj, sec_name);
@@ -2680,14 +2674,14 @@ int bpf_linker__finalize(struct bpf_linker *linker)
 
 	/* Finalize ELF layout */
 	if (elf_update(linker->elf, ELF_C_NULL) < 0) {
-		err = -errno;
+		err = -EINVAL;
 		pr_warn_elf("failed to finalize ELF layout");
 		return libbpf_err(err);
 	}
 
 	/* Write out final ELF contents */
 	if (elf_update(linker->elf, ELF_C_WRITE) < 0) {
-		err = -errno;
+		err = -EINVAL;
 		pr_warn_elf("failed to write ELF contents");
 		return libbpf_err(err);
 	}
-- 
2.43.0


