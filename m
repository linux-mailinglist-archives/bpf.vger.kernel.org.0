Return-Path: <bpf+bounces-43901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB79BBAE8
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D881C219A3
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4041C4A2F;
	Mon,  4 Nov 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM8Yz7pn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E3762EB
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739667; cv=none; b=sDIAUikqo3+e5XqpO7hdF39qyNLCM77naAOzT3as550N8EBE8dssD4FhOjNLDVUjRbPzVuTxBfjrVMVAYnf4XrphDm0rlB21vc6nG3pm1pJ/rlQnuLlxqfvqh530v7fnhMi8PZZORydwA9ANONLUkROxf5o/XldyN2PBTdjQtBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739667; c=relaxed/simple;
	bh=N4Mfw8sZYWcwsGVmUVASRGZogR0y07t6u2xsCUJgk7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1JbzODwpd03pAs/Cc52ldUAatLZahMWNHSELFgMPTJYCh/9ozHwWw9M2sy8PjtvXajtUvPgnBEV0x0c7/eY3uRGxb30V8wU+Wnx6iVJSjXd0W+cWPHPidN7C2/XFTnHefpy+l6hnqRPhCGLavPuU+HzuvhhjOOZdVJD1zDzVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM8Yz7pn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so592643666b.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 09:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730739662; x=1731344462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fTblpBYuZZ7r5bZPZp3ST9HB0TWObi+KIxHx2I1kNg=;
        b=MM8Yz7pniUdX592qdo1eQioJpVpDKhAl31tdOtvnp9gs3C9rTtvMBspYa1qDALCPG5
         V5x0YevYV25D1zNmNoY55PrIMKuaofa09tK0YALmFNfa5Q5t/6fIIgF6iobVZCnc1K8B
         yEi0RrmiKPtjIYtwmJe+QkIangkXcRrPbS2WxRub5wfxlCLfPTC2XMheYwJeBU2TQNig
         pCEbkcAzhtfAv/MrmMKuCPDzaAjLT+nvH6Tc5KTEVNOBr+TX9aiOu6mdgFYDVFlVB4Hh
         z53FK+skY4hPaf42feaEIegNKH2dgWLnG0GLG1jBbFpLDTGW0DGU5pdg4vllAfduzJ1w
         Ggrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739662; x=1731344462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fTblpBYuZZ7r5bZPZp3ST9HB0TWObi+KIxHx2I1kNg=;
        b=MZd2yr+vSbKIWd6DMAF54EQgdvP7zMif746a9YVdOecMBjKARbhprlgzAFutvZlNoc
         mo6/dq4c7lOqGQ2toMntVMlFIfdVdw27rBYBetMHXr1akdE8rpdtJ39ShCF6t4Rj5SAv
         Bt7dmgkfJmwo+6AAFFuLokSBsxF44lgOpT9My4mgh0aMc03+33/UgDL5eoXhfexYiBy8
         Au/JaeYdTra2sk0mHt6TVvvMKq9c2jM6MjZYi8tkU5diqjLxl/SXXLfWFn+88oY9i1Fv
         s52teYU3v5oYnWoDdEUb5PXxvgImAPVY6r7OrBwb0N7lvkGXCbE/OGQvYdpmxHQ9RObk
         KSbA==
X-Gm-Message-State: AOJu0YzZk9Ept35jt09DebSouA5whWU/g6bFmBe6we39ISzOCUMTGyvJ
	zBqr57cmRN8R6zq43l7bqI+mt9MHR6razaApf0FQWR0fnSJAS7ufIo2p/A==
X-Google-Smtp-Source: AGHT+IEo8tPjjOjb5Sbc8PEzJ9U3/pnjeIUFKzOU1wZso75A6Ne9y8hO3jSZh840LzSXOsMQk6M+nA==
X-Received: by 2002:a17:907:31c4:b0:a9a:90c:8bc with SMTP id a640c23a62f3a-a9e508abcd6mr1416192866b.12.1730739661542;
        Mon, 04 Nov 2024 09:01:01 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:400::5:a13f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17d0af1sm5022066b.94.2024.11.04.09.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:01:01 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] libbpf: stringify error codes in warning messages
Date: Mon,  4 Nov 2024 17:00:48 +0000
Message-ID: <20241104170048.1158254-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Libbpf may report error in 2 ways:
 1. Numeric errno
 2. Errno's text representation, returned by strerror
Both ways may be confusing for users: numeric code requires people to
know how to find its meaning and strerror may be too generic and
unclear.

This patch modifies libbpf error reporting by swapping numeric codes and
strerror with the standard short error name, for example:
"failed to attach: -22" becomes "failed to attach: EINVAL".

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 429 ++++++++++++++++++++++-------------------
 1 file changed, 231 insertions(+), 198 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 711173acbcef..26608d8585ec 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -336,6 +336,83 @@ static inline __u64 ptr_to_u64(const void *ptr)
 	return (__u64) (unsigned long) ptr;
 }
 
+/*
+ ** string returned from errstr() is invalidated upon the next call
+ */
+static const char *errstr(int err)
+{
+	static __thread char buf[11];
+	const char *str;
+	bool neg;
+
+	if (err < 0) {
+		err = -err;
+		neg = true;
+	}
+
+	switch (err) {
+	case EINVAL:
+		str = "-EINVAL"; break;
+	case EPERM:
+		str = "-EPERM"; break;
+	case ENOMEM:
+		str = "-ENOMEM"; break;
+	case ENOENT:
+		str = "-ENOENT"; break;
+	case E2BIG:
+		str = "-E2BIG"; break;
+	case EEXIST:
+		str = "-EEXIST"; break;
+	case EFAULT:
+		str = "-EFAULT"; break;
+	case ENOSPC:
+		str = "-ENOSPC"; break;
+	case EACCES:
+		str = "-EACCES"; break;
+	case EAGAIN:
+		str = "-EAGAIN"; break;
+	case EBADF:
+		str = "-EBADF"; break;
+	case ENAMETOOLONG:
+		str = "-ENAMETOOLONG"; break;
+	case ESRCH:
+		str = "-ESRCH"; break;
+	case EBUSY:
+		str = "-EBUSY"; break;
+	case ENOTSUP:
+		str = "-ENOTSUP"; break;
+	case EPROTO:
+		str = "-EPROTO"; break;
+	case ERANGE:
+		str = "-ERANGE"; break;
+	case EMSGSIZE:
+		str = "-EMSGSIZE"; break;
+	case EINTR:
+		str = "-EINTR"; break;
+	case ENODATA:
+		str = "-ENODATA"; break;
+	case EIO:
+		str = "-EIO"; break;
+	case EUCLEAN:
+		str = "-EUCLEAN"; break;
+	case EDOM:
+		str = "-EDOM"; break;
+	case EPROTONOSUPPORT:
+		str = "-EPROTONOSUPPORT"; break;
+	case EDEADLK:
+		str = "-EDEADLK"; break;
+	case EOVERFLOW:
+		str = "-EOVERFLOW"; break;
+	default:
+		snprintf(buf, sizeof(buf), "%d", err);
+		return buf;
+	}
+	if (!neg)
+		++str;
+
+	return str;
+}
+
 int libbpf_set_strict_mode(enum libbpf_strict_mode mode)
 {
 	/* as of v1.0 libbpf_set_strict_mode() is a no-op */
@@ -1550,11 +1627,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	} else {
 		obj->efile.fd = open(obj->path, O_RDONLY | O_CLOEXEC);
 		if (obj->efile.fd < 0) {
-			char errmsg[STRERR_BUFSIZE], *cp;
-
-			err = -errno;
-			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-			pr_warn("elf: failed to open %s: %s\n", obj->path, cp);
+			pr_warn("elf: failed to open %s: %s\n", obj->path, errstr(err));
 			return err;
 		}
 
@@ -1960,8 +2033,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	if (map->mmaped == MAP_FAILED) {
 		err = -errno;
 		map->mmaped = NULL;
-		pr_warn("failed to alloc map '%s' content buffer: %d\n",
-			map->name, err);
+		pr_warn("failed to alloc map '%s' content buffer: %s\n", map->name, errstr(err));
 		zfree(&map->real_name);
 		zfree(&map->name);
 		return err;
@@ -2125,7 +2197,7 @@ static int parse_u64(const char *value, __u64 *res)
 	*res = strtoull(value, &value_end, 0);
 	if (errno) {
 		err = -errno;
-		pr_warn("failed to parse '%s' as integer: %d\n", value, err);
+		pr_warn("failed to parse '%s': %s\n", value, errstr(err));
 		return err;
 	}
 	if (*value_end) {
@@ -2291,8 +2363,8 @@ static int bpf_object__read_kconfig_file(struct bpf_object *obj, void *data)
 	while (gzgets(file, buf, sizeof(buf))) {
 		err = bpf_object__process_kconfig_line(obj, buf, data);
 		if (err) {
-			pr_warn("error parsing system Kconfig line '%s': %d\n",
-				buf, err);
+			pr_warn("error parsing system Kconfig line '%s': %s\n",
+				buf, errstr(err));
 			goto out;
 		}
 	}
@@ -2312,15 +2384,15 @@ static int bpf_object__read_kconfig_mem(struct bpf_object *obj,
 	file = fmemopen((void *)config, strlen(config), "r");
 	if (!file) {
 		err = -errno;
-		pr_warn("failed to open in-memory Kconfig: %d\n", err);
+		pr_warn("failed to open in-memory Kconfig: %s\n", errstr(err));
 		return err;
 	}
 
 	while (fgets(buf, sizeof(buf), file)) {
 		err = bpf_object__process_kconfig_line(obj, buf, data);
 		if (err) {
-			pr_warn("error parsing in-memory Kconfig line '%s': %d\n",
-				buf, err);
+			pr_warn("error parsing in-memory Kconfig line '%s': %s\n",
+				buf, errstr(err));
 			break;
 		}
 	}
@@ -3235,7 +3307,7 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 		err = libbpf_get_error(obj->btf);
 		if (err) {
 			obj->btf = NULL;
-			pr_warn("Error loading ELF section %s: %d.\n", BTF_ELF_SEC, err);
+			pr_warn("Error loading ELF section %s: %s.\n", BTF_ELF_SEC, errstr(err));
 			goto out;
 		}
 		/* enforce 8-byte pointers for BPF-targeted BTFs */
@@ -3253,8 +3325,8 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 		obj->btf_ext = btf_ext__new(btf_ext_data->d_buf, btf_ext_data->d_size);
 		err = libbpf_get_error(obj->btf_ext);
 		if (err) {
-			pr_warn("Error loading ELF section %s: %d. Ignored and continue.\n",
-				BTF_EXT_ELF_SEC, err);
+			pr_warn("Error loading ELF section %s: %s. Ignored and continue.\n",
+				BTF_EXT_ELF_SEC, errstr(err));
 			obj->btf_ext = NULL;
 			goto out;
 		}
@@ -3346,8 +3418,8 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 	if (t->size == 0) {
 		err = find_elf_sec_sz(obj, sec_name, &size);
 		if (err || !size) {
-			pr_debug("sec '%s': failed to determine size from ELF: size %u, err %d\n",
-				 sec_name, size, err);
+			pr_debug("sec '%s': failed to determine size from ELF: size %u, err %s\n",
+				 sec_name, size, errstr(err));
 			return -ENOENT;
 		}
 
@@ -3501,7 +3573,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
 	obj->btf_vmlinux = btf__load_vmlinux_btf();
 	err = libbpf_get_error(obj->btf_vmlinux);
 	if (err) {
-		pr_warn("Error loading vmlinux BTF: %d\n", err);
+		pr_warn("Error loading vmlinux BTF: %s\n", errstr(err));
 		obj->btf_vmlinux = NULL;
 		return err;
 	}
@@ -3605,9 +3677,11 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 	if (err) {
 		btf_mandatory = kernel_needs_btf(obj);
 		if (btf_mandatory) {
-			pr_warn("Error loading .BTF into kernel: %d. BTF is mandatory, can't proceed.\n", err);
+			pr_warn("Error loading .BTF into kernel: %s. BTF is mandatory, can't proceed.\n",
+				errstr(err));
 		} else {
-			pr_info("Error loading .BTF into kernel: %d. BTF is optional, ignoring.\n", err);
+			pr_info("Error loading .BTF into kernel: %s. BTF is optional, ignoring.\n",
+				errstr(err));
 			err = 0;
 		}
 	}
@@ -4811,8 +4885,8 @@ static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
 	fp = fopen(file, "re");
 	if (!fp) {
 		err = -errno;
-		pr_warn("failed to open %s: %d. No procfs support?\n", file,
-			err);
+		pr_warn("failed to open %s: %s. No procfs support?\n", file,
+			errstr(err));
 		return err;
 	}
 
@@ -4967,8 +5041,8 @@ static int bpf_object_prepare_token(struct bpf_object *obj)
 	bpffs_fd = open(bpffs_path, O_DIRECTORY, O_RDWR);
 	if (bpffs_fd < 0) {
 		err = -errno;
-		__pr(level, "object '%s': failed (%d) to open BPF FS mount at '%s'%s\n",
-		     obj->name, err, bpffs_path,
+		__pr(level, "object '%s': failed (%s) to open BPF FS mount at '%s'%s\n",
+		     obj->name, errstr(err), bpffs_path,
 		     mandatory ? "" : ", skipping optional step...");
 		return mandatory ? err : 0;
 	}
@@ -5002,7 +5076,6 @@ static int bpf_object_prepare_token(struct bpf_object *obj)
 static int
 bpf_object__probe_loading(struct bpf_object *obj)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -5018,7 +5091,8 @@ bpf_object__probe_loading(struct bpf_object *obj)
 
 	ret = bump_rlimit_memlock();
 	if (ret)
-		pr_warn("Failed to bump RLIMIT_MEMLOCK (err = %d), you might need to do it explicitly!\n", ret);
+		pr_warn("Failed to bump RLIMIT_MEMLOCK (err = %s), you might need to do it explicitly!\n",
+			errstr(ret));
 
 	/* make sure basic loading works */
 	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
@@ -5026,11 +5100,8 @@ bpf_object__probe_loading(struct bpf_object *obj)
 		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
 	if (ret < 0) {
 		ret = errno;
-		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-		pr_warn("Error in %s():%s(%d). Couldn't load trivial BPF "
-			"program. Make sure your kernel supports BPF "
-			"(CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is "
-			"set to big enough value.\n", __func__, cp, ret);
+		pr_warn("Error in %s(): %s. Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.\n",
+			__func__, errstr(ret));
 		return -ret;
 	}
 	close(ret);
@@ -5055,7 +5126,6 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 {
 	struct bpf_map_info map_info;
-	char msg[STRERR_BUFSIZE];
 	__u32 map_info_len = sizeof(map_info);
 	int err;
 
@@ -5065,7 +5135,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 		err = bpf_get_map_info_from_fdinfo(map_fd, &map_info);
 	if (err) {
 		pr_warn("failed to get map info for map FD %d: %s\n", map_fd,
-			libbpf_strerror_r(errno, msg, sizeof(msg)));
+			errstr(err));
 		return false;
 	}
 
@@ -5080,7 +5150,6 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 static int
 bpf_object__reuse_map(struct bpf_map *map)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	int err, pin_fd;
 
 	pin_fd = bpf_obj_get(map->pin_path);
@@ -5092,9 +5161,8 @@ bpf_object__reuse_map(struct bpf_map *map)
 			return 0;
 		}
 
-		cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
 		pr_warn("couldn't retrieve pinned map '%s': %s\n",
-			map->pin_path, cp);
+			map->pin_path, errstr(err));
 		return err;
 	}
 
@@ -5120,7 +5188,6 @@ static int
 bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 {
 	enum libbpf_map_type map_type = map->libbpf_type;
-	char *cp, errmsg[STRERR_BUFSIZE];
 	int err, zero = 0;
 	size_t mmap_sz;
 
@@ -5134,10 +5201,8 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 
 	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
 	if (err) {
-		err = -errno;
-		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 		pr_warn("map '%s': failed to set initial contents: %s\n",
-			bpf_map__name(map), cp);
+			bpf_map__name(map), errstr(err));
 		return err;
 	}
 
@@ -5145,10 +5210,8 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 	if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG) {
 		err = bpf_map_freeze(map->fd);
 		if (err) {
-			err = -errno;
-			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 			pr_warn("map '%s': failed to freeze as read-only: %s\n",
-				bpf_map__name(map), cp);
+				bpf_map__name(map), errstr(err));
 			return err;
 		}
 	}
@@ -5174,8 +5237,8 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 		mmaped = mmap(map->mmaped, mmap_sz, prot, MAP_SHARED | MAP_FIXED, map->fd, 0);
 		if (mmaped == MAP_FAILED) {
 			err = -errno;
-			pr_warn("map '%s': failed to re-mmap() contents: %d\n",
-				bpf_map__name(map), err);
+			pr_warn("map '%s': failed to re-mmap() contents: %s\n",
+				bpf_map__name(map), errstr(err));
 			return err;
 		}
 		map->mmaped = mmaped;
@@ -5232,8 +5295,8 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 				return err;
 			err = bpf_object__create_map(obj, map->inner_map, true);
 			if (err) {
-				pr_warn("map '%s': failed to create inner map: %d\n",
-					map->name, err);
+				pr_warn("map '%s': failed to create inner map: %s\n",
+					map->name, errstr(err));
 				return err;
 			}
 			map->inner_map_fd = map->inner_map->fd;
@@ -5287,12 +5350,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 					def->max_entries, &create_attr);
 	}
 	if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf_value_type_id)) {
-		char *cp, errmsg[STRERR_BUFSIZE];
-
 		err = -errno;
-		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
-			map->name, cp, err);
+		pr_warn("Error in bpf_create_map_xattr(%s): %s. Retrying without BTF.\n",
+			map->name, errstr(err));
 		create_attr.btf_fd = 0;
 		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
@@ -5347,8 +5407,8 @@ static int init_map_in_map_slots(struct bpf_object *obj, struct bpf_map *map)
 		}
 		if (err) {
 			err = -errno;
-			pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %d\n",
-				map->name, i, targ_map->name, fd, err);
+			pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %s\n",
+				map->name, i, targ_map->name, fd, errstr(err));
 			return err;
 		}
 		pr_debug("map '%s': slot [%d] set to map '%s' fd=%d\n",
@@ -5380,8 +5440,8 @@ static int init_prog_array_slots(struct bpf_object *obj, struct bpf_map *map)
 		err = bpf_map_update_elem(map->fd, &i, &fd, 0);
 		if (err) {
 			err = -errno;
-			pr_warn("map '%s': failed to initialize slot [%d] to prog '%s' fd=%d: %d\n",
-				map->name, i, targ_prog->name, fd, err);
+			pr_warn("map '%s': failed to initialize slot [%d] to prog '%s' fd=%d: %s\n",
+				map->name, i, targ_prog->name, fd, errstr(err));
 			return err;
 		}
 		pr_debug("map '%s': slot [%d] set to prog '%s' fd=%d\n",
@@ -5434,7 +5494,6 @@ static int
 bpf_object__create_maps(struct bpf_object *obj)
 {
 	struct bpf_map *map;
-	char *cp, errmsg[STRERR_BUFSIZE];
 	unsigned int i, j;
 	int err;
 	bool retried;
@@ -5508,8 +5567,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 				if (map->mmaped == MAP_FAILED) {
 					err = -errno;
 					map->mmaped = NULL;
-					pr_warn("map '%s': failed to mmap arena: %d\n",
-						map->name, err);
+					pr_warn("map '%s': failed to mmap arena: %s\n",
+						map->name, errstr(err));
 					return err;
 				}
 				if (obj->arena_data) {
@@ -5531,8 +5590,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 					retried = true;
 					goto retry;
 				}
-				pr_warn("map '%s': failed to auto-pin at '%s': %d\n",
-					map->name, map->pin_path, err);
+				pr_warn("map '%s': failed to auto-pin at '%s': %s\n",
+					map->name, map->pin_path, errstr(err));
 				goto err_out;
 			}
 		}
@@ -5541,8 +5600,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 	return 0;
 
 err_out:
-	cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-	pr_warn("map '%s': failed to create: %s(%d)\n", map->name, cp, err);
+	pr_warn("map '%s': failed to create: %s\n", map->name, errstr(err));
 	pr_perm_msg(err);
 	for (j = 0; j < i; j++)
 		zclose(obj->maps[j].fd);
@@ -5666,7 +5724,7 @@ static int load_module_btfs(struct bpf_object *obj)
 		}
 		if (err) {
 			err = -errno;
-			pr_warn("failed to iterate BTF objects: %d\n", err);
+			pr_warn("failed to iterate BTF objects: %s\n", errstr(err));
 			return err;
 		}
 
@@ -5675,7 +5733,7 @@ static int load_module_btfs(struct bpf_object *obj)
 			if (errno == ENOENT)
 				continue; /* expected race: BTF was unloaded */
 			err = -errno;
-			pr_warn("failed to get BTF object #%d FD: %d\n", id, err);
+			pr_warn("failed to get BTF object #%d FD: %s\n", id, errstr(err));
 			return err;
 		}
 
@@ -5687,7 +5745,7 @@ static int load_module_btfs(struct bpf_object *obj)
 		err = bpf_btf_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			err = -errno;
-			pr_warn("failed to get BTF object #%d info: %d\n", id, err);
+			pr_warn("failed to get BTF object #%d info: %s\n", id, errstr(err));
 			goto err_out;
 		}
 
@@ -5700,8 +5758,8 @@ static int load_module_btfs(struct bpf_object *obj)
 		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
 		err = libbpf_get_error(btf);
 		if (err) {
-			pr_warn("failed to load module [%s]'s BTF object #%d: %d\n",
-				name, id, err);
+			pr_warn("failed to load module [%s]'s BTF object #%d: %s\n",
+				name, id, errstr(err));
 			goto err_out;
 		}
 
@@ -5930,7 +5988,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 		obj->btf_vmlinux_override = btf__parse(targ_btf_path, NULL);
 		err = libbpf_get_error(obj->btf_vmlinux_override);
 		if (err) {
-			pr_warn("failed to parse target BTF: %d\n", err);
+			pr_warn("failed to parse target BTF: %s\n", errstr(err));
 			return err;
 		}
 	}
@@ -5990,8 +6048,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 
 			err = record_relo_core(prog, rec, insn_idx);
 			if (err) {
-				pr_warn("prog '%s': relo #%d: failed to record relocation: %d\n",
-					prog->name, i, err);
+				pr_warn("prog '%s': relo #%d: failed to record relocation: %s\n",
+					prog->name, i, errstr(err));
 				goto out;
 			}
 
@@ -6000,15 +6058,15 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 
 			err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
 			if (err) {
-				pr_warn("prog '%s': relo #%d: failed to relocate: %d\n",
-					prog->name, i, err);
+				pr_warn("prog '%s': relo #%d: failed to relocate: %s\n",
+					prog->name, i, errstr(err));
 				goto out;
 			}
 
 			err = bpf_core_patch_insn(prog->name, insn, insn_idx, rec, i, &targ_res);
 			if (err) {
-				pr_warn("prog '%s': relo #%d: failed to patch insn #%u: %d\n",
-					prog->name, i, insn_idx, err);
+				pr_warn("prog '%s': relo #%d: failed to patch insn #%u: %s\n",
+					prog->name, i, insn_idx, errstr(err));
 				goto out;
 			}
 		}
@@ -6276,8 +6334,8 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
 				       &main_prog->func_info_rec_size);
 	if (err) {
 		if (err != -ENOENT) {
-			pr_warn("prog '%s': error relocating .BTF.ext function info: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': error relocating .BTF.ext function info: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 		if (main_prog->func_info) {
@@ -6304,8 +6362,8 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
 				       &main_prog->line_info_rec_size);
 	if (err) {
 		if (err != -ENOENT) {
-			pr_warn("prog '%s': error relocating .BTF.ext line info: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': error relocating .BTF.ext line info: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 		if (main_prog->line_info) {
@@ -7069,8 +7127,8 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 	if (obj->btf_ext) {
 		err = bpf_object__relocate_core(obj, targ_btf_path);
 		if (err) {
-			pr_warn("failed to perform CO-RE relocations: %d\n",
-				err);
+			pr_warn("failed to perform CO-RE relocations: %s\n",
+				errstr(err));
 			return err;
 		}
 		bpf_object__sort_relos(obj);
@@ -7114,8 +7172,8 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 
 		err = bpf_object__relocate_calls(obj, prog);
 		if (err) {
-			pr_warn("prog '%s': failed to relocate calls: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': failed to relocate calls: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 
@@ -7151,16 +7209,16 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		/* Process data relos for main programs */
 		err = bpf_object__relocate_data(obj, prog);
 		if (err) {
-			pr_warn("prog '%s': failed to relocate data references: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': failed to relocate data references: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 
 		/* Fix up .BTF.ext information, if necessary */
 		err = bpf_program_fixup_func_info(obj, prog);
 		if (err) {
-			pr_warn("prog '%s': failed to perform .BTF.ext fix ups: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': failed to perform .BTF.ext fix ups: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 	}
@@ -7469,7 +7527,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, load_attr);
 	const char *prog_name = NULL;
-	char *cp, errmsg[STRERR_BUFSIZE];
 	size_t log_buf_size = 0;
 	char *log_buf = NULL, *tmp;
 	bool own_log_buf = true;
@@ -7533,8 +7590,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
 		err = prog->sec_def->prog_prepare_load_fn(prog, &load_attr, prog->sec_def->cookie);
 		if (err < 0) {
-			pr_warn("prog '%s': failed to prepare load attributes: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': failed to prepare load attributes: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 		insns = prog->insns;
@@ -7598,9 +7655,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 					continue;
 
 				if (bpf_prog_bind_map(ret, map->fd, NULL)) {
-					cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 					pr_warn("prog '%s': failed to bind map '%s': %s\n",
-						prog->name, map->real_name, cp);
+						prog->name, map->real_name, errstr(errno));
 					/* Don't fail hard if can't bind rodata. */
 				}
 			}
@@ -7630,8 +7686,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	/* post-process verifier log to improve error descriptions */
 	fixup_verifier_log(prog, log_buf, log_buf_size);
 
-	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, cp);
+	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, errstr(errno));
 	pr_perm_msg(ret);
 
 	if (own_log_buf && log_buf && log_buf[0] != '\0') {
@@ -7924,7 +7979,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
 					   obj->license, obj->kern_version, &prog->fd);
 		if (err) {
-			pr_warn("prog '%s': failed to load: %d\n", prog->name, err);
+			pr_warn("prog '%s': failed to load: %s\n", prog->name, errstr(err));
 			return err;
 		}
 	}
@@ -7958,8 +8013,8 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		if (prog->sec_def->prog_setup_fn) {
 			err = prog->sec_def->prog_setup_fn(prog, prog->sec_def->cookie);
 			if (err < 0) {
-				pr_warn("prog '%s': failed to initialize: %d\n",
-					prog->name, err);
+				pr_warn("prog '%s': failed to initialize: %s\n",
+					prog->name, errstr(err));
 				return err;
 			}
 		}
@@ -8148,7 +8203,7 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
 	f = fopen("/proc/kallsyms", "re");
 	if (!f) {
 		err = -errno;
-		pr_warn("failed to open /proc/kallsyms: %d\n", err);
+		pr_warn("failed to open /proc/kallsyms: %s\n", errstr(err));
 		return err;
 	}
 
@@ -8632,7 +8687,6 @@ int bpf_object__load(struct bpf_object *obj)
 
 static int make_parent_dir(const char *path)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	char *dname, *dir;
 	int err = 0;
 
@@ -8646,15 +8700,13 @@ static int make_parent_dir(const char *path)
 
 	free(dname);
 	if (err) {
-		cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
-		pr_warn("failed to mkdir %s: %s\n", path, cp);
+		pr_warn("failed to mkdir %s: %s\n", path, errstr(err));
 	}
 	return err;
 }
 
 static int check_path(const char *path)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	struct statfs st_fs;
 	char *dname, *dir;
 	int err = 0;
@@ -8668,8 +8720,7 @@ static int check_path(const char *path)
 
 	dir = dirname(dname);
 	if (statfs(dir, &st_fs)) {
-		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-		pr_warn("failed to statfs %s: %s\n", dir, cp);
+		pr_warn("failed to statfs %s: %s\n", dir, errstr(errno));
 		err = -errno;
 	}
 	free(dname);
@@ -8684,7 +8735,6 @@ static int check_path(const char *path)
 
 int bpf_program__pin(struct bpf_program *prog, const char *path)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	int err;
 
 	if (prog->fd < 0) {
@@ -8702,8 +8752,7 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
 
 	if (bpf_obj_pin(prog->fd, path)) {
 		err = -errno;
-		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path, cp);
+		pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path, errstr(err));
 		return libbpf_err(err);
 	}
 
@@ -8734,7 +8783,6 @@ int bpf_program__unpin(struct bpf_program *prog, const char *path)
 
 int bpf_map__pin(struct bpf_map *map, const char *path)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	int err;
 
 	if (map == NULL) {
@@ -8793,8 +8841,7 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 	return 0;
 
 out_err:
-	cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
-	pr_warn("failed to pin map: %s\n", cp);
+	pr_warn("failed to pin map: %s\n", errstr(err));
 	return libbpf_err(err);
 }
 
@@ -9981,8 +10028,8 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 	memset(&info, 0, info_len);
 	err = bpf_prog_get_info_by_fd(attach_prog_fd, &info, &info_len);
 	if (err) {
-		pr_warn("failed bpf_prog_get_info_by_fd for FD %d: %d\n",
-			attach_prog_fd, err);
+		pr_warn("failed bpf_prog_get_info_by_fd for FD %d: %s\n",
+			attach_prog_fd, errstr(err));
 		return err;
 	}
 
@@ -9994,7 +10041,7 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 	btf = btf__load_from_kernel_by_id(info.btf_id);
 	err = libbpf_get_error(btf);
 	if (err) {
-		pr_warn("Failed to get BTF %d of the program: %d\n", info.btf_id, err);
+		pr_warn("Failed to get BTF %d of the program: %s\n", info.btf_id, errstr(err));
 		goto out;
 	}
 	err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
@@ -10076,8 +10123,8 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 		}
 		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd);
 		if (err < 0) {
-			pr_warn("prog '%s': failed to find BPF program (FD %d) BTF ID for '%s': %d\n",
-				 prog->name, attach_prog_fd, attach_name, err);
+			pr_warn("prog '%s': failed to find BPF program (FD %d) BTF ID for '%s': %s\n",
+				prog->name, attach_prog_fd, attach_name, errstr(err));
 			return err;
 		}
 		*btf_obj_fd = 0;
@@ -10096,8 +10143,8 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 					 btf_type_id);
 	}
 	if (err) {
-		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %d\n",
-			prog->name, attach_name, err);
+		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %s\n",
+			prog->name, attach_name, errstr(err));
 		return err;
 	}
 	return 0;
@@ -10325,14 +10372,14 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 		mmap_new_sz = array_map_mmap_sz(size, map->def.max_entries);
 		err = bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz);
 		if (err) {
-			pr_warn("map '%s': failed to resize memory-mapped region: %d\n",
-				bpf_map__name(map), err);
+			pr_warn("map '%s': failed to resize memory-mapped region: %s\n",
+				bpf_map__name(map), errstr(err));
 			return err;
 		}
 		err = map_btf_datasec_resize(map, size);
 		if (err && err != -ENOENT) {
-			pr_warn("map '%s': failed to adjust resized BTF, clearing BTF key/value info: %d\n",
-				bpf_map__name(map), err);
+			pr_warn("map '%s': failed to adjust resized BTF, clearing BTF key/value info: %s\n",
+				bpf_map__name(map), errstr(err));
 			map->btf_value_type_id = 0;
 			map->btf_key_type_id = 0;
 		}
@@ -10823,7 +10870,6 @@ static void bpf_link_perf_dealloc(struct bpf_link *link)
 struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *prog, int pfd,
 						     const struct bpf_perf_event_opts *opts)
 {
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link_perf *link;
 	int prog_fd, link_fd = -1, err;
 	bool force_ioctl_attach;
@@ -10858,9 +10904,8 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 		link_fd = bpf_link_create(prog_fd, pfd, BPF_PERF_EVENT, &link_opts);
 		if (link_fd < 0) {
 			err = -errno;
-			pr_warn("prog '%s': failed to create BPF link for perf_event FD %d: %d (%s)\n",
-				prog->name, pfd,
-				err, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			pr_warn("prog '%s': failed to create BPF link for perf_event FD %d: %s\n",
+				prog->name, pfd, errstr(err));
 			goto err_out;
 		}
 		link->link.fd = link_fd;
@@ -10874,7 +10919,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 		if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
 			err = -errno;
 			pr_warn("prog '%s': failed to attach to perf_event FD %d: %s\n",
-				prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+				prog->name, pfd, errstr(err));
 			if (err == -EPROTO)
 				pr_warn("prog '%s': try add PERF_SAMPLE_CALLCHAIN to or remove exclude_callchain_[kernel|user] from pfd %d\n",
 					prog->name, pfd);
@@ -10885,7 +10930,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
 		err = -errno;
 		pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
-			prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			prog->name, pfd, errstr(err));
 		goto err_out;
 	}
 
@@ -10968,7 +11013,6 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
-	char errmsg[STRERR_BUFSIZE];
 	int type, pfd;
 
 	if ((__u64)ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
@@ -10981,7 +11025,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	if (type < 0) {
 		pr_warn("failed to determine %s perf type: %s\n",
 			uprobe ? "uprobe" : "kprobe",
-			libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
+			errstr(type));
 		return type;
 	}
 	if (retprobe) {
@@ -10991,7 +11035,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 		if (bit < 0) {
 			pr_warn("failed to determine %s retprobe bit: %s\n",
 				uprobe ? "uprobe" : "kprobe",
-				libbpf_strerror_r(bit, errmsg, sizeof(errmsg)));
+				errstr(bit));
 			return bit;
 		}
 		attr.config |= 1 << bit;
@@ -11120,14 +11164,13 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
-	char errmsg[STRERR_BUFSIZE];
 	int type, pfd, err;
 
 	err = add_kprobe_event_legacy(probe_name, retprobe, kfunc_name, offset);
 	if (err < 0) {
 		pr_warn("failed to add legacy kprobe event for '%s+0x%zx': %s\n",
 			kfunc_name, offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		return err;
 	}
 	type = determine_kprobe_perf_type_legacy(probe_name, retprobe);
@@ -11135,7 +11178,7 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
 		err = type;
 		pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s\n",
 			kfunc_name, offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_clean_legacy;
 	}
 
@@ -11151,7 +11194,7 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
 	if (pfd < 0) {
 		err = -errno;
 		pr_warn("legacy kprobe perf_event_open() failed: %s\n",
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_clean_legacy;
 	}
 	return pfd;
@@ -11227,7 +11270,6 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 {
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	enum probe_attach_mode attach_mode;
-	char errmsg[STRERR_BUFSIZE];
 	char *legacy_probe = NULL;
 	struct bpf_link *link;
 	size_t offset;
@@ -11285,7 +11327,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe",
 			func_name, offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_out;
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
@@ -11295,7 +11337,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe",
 			func_name, offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_clean_legacy;
 	}
 	if (legacy) {
@@ -11431,7 +11473,7 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 	f = fopen(available_functions_file, "re");
 	if (!f) {
 		err = -errno;
-		pr_warn("failed to open %s: %d\n", available_functions_file, err);
+		pr_warn("failed to open %s: %s\n", available_functions_file, errstr(err));
 		return err;
 	}
 
@@ -11506,7 +11548,7 @@ static int libbpf_available_kprobes_parse(struct kprobe_multi_resolve *res)
 	f = fopen(available_path, "re");
 	if (!f) {
 		err = -errno;
-		pr_warn("failed to open %s: %d\n", available_path, err);
+		pr_warn("failed to open %s: %s\n", available_path, errstr(err));
 		return err;
 	}
 
@@ -11552,7 +11594,6 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	};
 	enum bpf_attach_type attach_type;
 	struct bpf_link *link = NULL;
-	char errmsg[STRERR_BUFSIZE];
 	const unsigned long *addrs;
 	int err, link_fd, prog_fd;
 	bool retprobe, session;
@@ -11620,7 +11661,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	if (link_fd < 0) {
 		err = -errno;
 		pr_warn("prog '%s': failed to attach: %s\n",
-			prog->name, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			prog->name, errstr(err));
 		goto error;
 	}
 	link->fd = link_fd;
@@ -11827,15 +11868,15 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
 
 	err = add_uprobe_event_legacy(probe_name, retprobe, binary_path, offset);
 	if (err < 0) {
-		pr_warn("failed to add legacy uprobe event for %s:0x%zx: %d\n",
-			binary_path, (size_t)offset, err);
+		pr_warn("failed to add legacy uprobe event for %s:0x%zx: %s\n",
+			binary_path, (size_t)offset, errstr(err));
 		return err;
 	}
 	type = determine_uprobe_perf_type_legacy(probe_name, retprobe);
 	if (type < 0) {
 		err = type;
-		pr_warn("failed to determine legacy uprobe event id for %s:0x%zx: %d\n",
-			binary_path, offset, err);
+		pr_warn("failed to determine legacy uprobe event id for %s:0x%zx: %s\n",
+			binary_path, offset, errstr(err));
 		goto err_clean_legacy;
 	}
 
@@ -11850,7 +11891,7 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
 		      -1 /* group_fd */,  PERF_FLAG_FD_CLOEXEC);
 	if (pfd < 0) {
 		err = -errno;
-		pr_warn("legacy uprobe perf_event_open() failed: %d\n", err);
+		pr_warn("legacy uprobe perf_event_open() failed: %s\n", errstr(err));
 		goto err_clean_legacy;
 	}
 	return pfd;
@@ -12015,7 +12056,6 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	unsigned long *resolved_offsets = NULL;
 	int err = 0, link_fd, prog_fd;
 	struct bpf_link *link = NULL;
-	char errmsg[STRERR_BUFSIZE];
 	char full_path[PATH_MAX];
 	const __u64 *cookies;
 	const char **syms;
@@ -12068,8 +12108,8 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 		if (!strchr(path, '/')) {
 			err = resolve_full_path(path, full_path, sizeof(full_path));
 			if (err) {
-				pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
-					prog->name, path, err);
+				pr_warn("prog '%s': failed to resolve full path for '%s': %s\n",
+					prog->name, path, errstr(err));
 				return libbpf_err_ptr(err);
 			}
 			path = full_path;
@@ -12110,7 +12150,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	if (link_fd < 0) {
 		err = -errno;
 		pr_warn("prog '%s': failed to attach multi-uprobe: %s\n",
-			prog->name, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			prog->name, errstr(err));
 		goto error;
 	}
 	link->fd = link_fd;
@@ -12129,7 +12169,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const struct bpf_uprobe_opts *opts)
 {
 	const char *archive_path = NULL, *archive_sep = NULL;
-	char errmsg[STRERR_BUFSIZE], *legacy_probe = NULL;
+	char *legacy_probe = NULL;
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	enum probe_attach_mode attach_mode;
 	char full_path[PATH_MAX];
@@ -12161,8 +12201,8 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	} else if (!strchr(binary_path, '/')) {
 		err = resolve_full_path(binary_path, full_path, sizeof(full_path));
 		if (err) {
-			pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
-				prog->name, binary_path, err);
+			pr_warn("prog '%s': failed to resolve full path for '%s': %s\n",
+				prog->name, binary_path, errstr(err));
 			return libbpf_err_ptr(err);
 		}
 		binary_path = full_path;
@@ -12228,7 +12268,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		pr_warn("prog '%s': failed to create %s '%s:0x%zx' perf event: %s\n",
 			prog->name, retprobe ? "uretprobe" : "uprobe",
 			binary_path, func_offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_out;
 	}
 
@@ -12239,7 +12279,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		pr_warn("prog '%s': failed to attach to %s '%s:0x%zx': %s\n",
 			prog->name, retprobe ? "uretprobe" : "uprobe",
 			binary_path, func_offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_clean_legacy;
 	}
 	if (legacy) {
@@ -12360,8 +12400,8 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
 	if (!strchr(binary_path, '/')) {
 		err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
 		if (err) {
-			pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
-				prog->name, binary_path, err);
+			pr_warn("prog '%s': failed to resolve full path for '%s': %s\n",
+				prog->name, binary_path, errstr(err));
 			return libbpf_err_ptr(err);
 		}
 		binary_path = resolved_path;
@@ -12439,14 +12479,13 @@ static int perf_event_open_tracepoint(const char *tp_category,
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
-	char errmsg[STRERR_BUFSIZE];
 	int tp_id, pfd, err;
 
 	tp_id = determine_tracepoint_id(tp_category, tp_name);
 	if (tp_id < 0) {
 		pr_warn("failed to determine tracepoint '%s/%s' perf event ID: %s\n",
 			tp_category, tp_name,
-			libbpf_strerror_r(tp_id, errmsg, sizeof(errmsg)));
+			errstr(tp_id));
 		return tp_id;
 	}
 
@@ -12461,7 +12500,7 @@ static int perf_event_open_tracepoint(const char *tp_category,
 		err = -errno;
 		pr_warn("tracepoint '%s/%s' perf_event_open() failed: %s\n",
 			tp_category, tp_name,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		return err;
 	}
 	return pfd;
@@ -12473,7 +12512,6 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *p
 						     const struct bpf_tracepoint_opts *opts)
 {
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int pfd, err;
 
@@ -12486,7 +12524,7 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *p
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create tracepoint '%s/%s' perf event: %s\n",
 			prog->name, tp_category, tp_name,
-			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+			errstr(pfd));
 		return libbpf_err_ptr(pfd);
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
@@ -12495,7 +12533,7 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *p
 		close(pfd);
 		pr_warn("prog '%s': failed to attach to tracepoint '%s/%s': %s\n",
 			prog->name, tp_category, tp_name,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		return libbpf_err_ptr(err);
 	}
 	return link;
@@ -12546,7 +12584,6 @@ bpf_program__attach_raw_tracepoint_opts(const struct bpf_program *prog,
 					struct bpf_raw_tracepoint_opts *opts)
 {
 	LIBBPF_OPTS(bpf_raw_tp_opts, raw_opts);
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, pfd;
 
@@ -12571,7 +12608,7 @@ bpf_program__attach_raw_tracepoint_opts(const struct bpf_program *prog,
 		pfd = -errno;
 		free(link);
 		pr_warn("prog '%s': failed to attach to raw tracepoint '%s': %s\n",
-			prog->name, tp_name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+			prog->name, tp_name, errstr(pfd));
 		return libbpf_err_ptr(pfd);
 	}
 	link->fd = pfd;
@@ -12630,7 +12667,6 @@ static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_program *pro
 						   const struct bpf_trace_opts *opts)
 {
 	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, pfd;
 
@@ -12655,7 +12691,7 @@ static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_program *pro
 		pfd = -errno;
 		free(link);
 		pr_warn("prog '%s': failed to attach: %s\n",
-			prog->name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+			prog->name, errstr(pfd));
 		return libbpf_err_ptr(pfd);
 	}
 	link->fd = pfd;
@@ -12696,7 +12732,6 @@ bpf_program_attach_fd(const struct bpf_program *prog,
 		      const struct bpf_link_create_opts *opts)
 {
 	enum bpf_attach_type attach_type;
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, link_fd;
 
@@ -12718,7 +12753,7 @@ bpf_program_attach_fd(const struct bpf_program *prog,
 		free(link);
 		pr_warn("prog '%s': failed to attach to %s: %s\n",
 			prog->name, target_name,
-			libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
+			errstr(link_fd));
 		return libbpf_err_ptr(link_fd);
 	}
 	link->fd = link_fd;
@@ -12860,7 +12895,6 @@ bpf_program__attach_iter(const struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts)
 {
 	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, link_fd;
 	__u32 target_fd = 0;
@@ -12888,7 +12922,7 @@ bpf_program__attach_iter(const struct bpf_program *prog,
 		link_fd = -errno;
 		free(link);
 		pr_warn("prog '%s': failed to attach to iterator: %s\n",
-			prog->name, libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
+			prog->name, errstr(link_fd));
 		return libbpf_err_ptr(link_fd);
 	}
 	link->fd = link_fd;
@@ -12930,12 +12964,10 @@ struct bpf_link *bpf_program__attach_netfilter(const struct bpf_program *prog,
 
 	link_fd = bpf_link_create(prog_fd, 0, BPF_NETFILTER, &lopts);
 	if (link_fd < 0) {
-		char errmsg[STRERR_BUFSIZE];
-
 		link_fd = -errno;
 		free(link);
 		pr_warn("prog '%s': failed to attach to netfilter: %s\n",
-			prog->name, libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
+			prog->name, errstr(link_fd));
 		return libbpf_err_ptr(link_fd);
 	}
 	link->fd = link_fd;
@@ -13220,7 +13252,6 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 			  int cpu, int map_key)
 {
 	struct perf_cpu_buf *cpu_buf;
-	char msg[STRERR_BUFSIZE];
 	int err;
 
 	cpu_buf = calloc(1, sizeof(*cpu_buf));
@@ -13236,7 +13267,7 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 	if (cpu_buf->fd < 0) {
 		err = -errno;
 		pr_warn("failed to open perf buffer event on cpu #%d: %s\n",
-			cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
+			cpu, errstr(err));
 		goto error;
 	}
 
@@ -13247,14 +13278,14 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 		cpu_buf->base = NULL;
 		err = -errno;
 		pr_warn("failed to mmap perf buffer on cpu #%d: %s\n",
-			cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
+			cpu, errstr(err));
 		goto error;
 	}
 
 	if (ioctl(cpu_buf->fd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
 		err = -errno;
 		pr_warn("failed to enable perf buffer event on cpu #%d: %s\n",
-			cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
+			cpu, errstr(err));
 		goto error;
 	}
 
@@ -13330,7 +13361,6 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 {
 	const char *online_cpus_file = "/sys/devices/system/cpu/online";
 	struct bpf_map_info map;
-	char msg[STRERR_BUFSIZE];
 	struct perf_buffer *pb;
 	bool *online = NULL;
 	__u32 map_info_len;
@@ -13353,7 +13383,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 		 */
 		if (err != -EINVAL) {
 			pr_warn("failed to get map info for map FD %d: %s\n",
-				map_fd, libbpf_strerror_r(err, msg, sizeof(msg)));
+				map_fd, errstr(err));
 			return ERR_PTR(err);
 		}
 		pr_debug("failed to get map info for FD %d; API not supported? Ignoring...\n",
@@ -13383,7 +13413,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 	if (pb->epoll_fd < 0) {
 		err = -errno;
 		pr_warn("failed to create epoll instance: %s\n",
-			libbpf_strerror_r(err, msg, sizeof(msg)));
+			errstr(err));
 		goto error;
 	}
 
@@ -13414,7 +13444,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 
 	err = parse_cpu_mask_file(online_cpus_file, &online, &n);
 	if (err) {
-		pr_warn("failed to get online CPU mask: %d\n", err);
+		pr_warn("failed to get online CPU mask: %s\n", errstr(err));
 		goto error;
 	}
 
@@ -13445,7 +13475,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 			err = -errno;
 			pr_warn("failed to set cpu #%d, key %d -> perf FD %d: %s\n",
 				cpu, map_key, cpu_buf->fd,
-				libbpf_strerror_r(err, msg, sizeof(msg)));
+				errstr(err));
 			goto error;
 		}
 
@@ -13456,7 +13486,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 			err = -errno;
 			pr_warn("failed to epoll_ctl cpu #%d perf FD %d: %s\n",
 				cpu, cpu_buf->fd,
-				libbpf_strerror_r(err, msg, sizeof(msg)));
+				errstr(err));
 			goto error;
 		}
 		j++;
@@ -13551,7 +13581,7 @@ int perf_buffer__poll(struct perf_buffer *pb, int timeout_ms)
 
 		err = perf_buffer__process_records(pb, cpu_buf);
 		if (err) {
-			pr_warn("error while processing records: %d\n", err);
+			pr_warn("error while processing records: %s\n", errstr(err));
 			return libbpf_err(err);
 		}
 	}
@@ -13635,7 +13665,8 @@ int perf_buffer__consume(struct perf_buffer *pb)
 
 		err = perf_buffer__process_records(pb, cpu_buf);
 		if (err) {
-			pr_warn("perf_buffer: failed to process records in buffer #%d: %d\n", i, err);
+			pr_warn("perf_buffer: failed to process records in buffer #%d: %s\n",
+				i, errstr(err));
 			return libbpf_err(err);
 		}
 	}
@@ -13746,14 +13777,14 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz)
 	fd = open(fcpu, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		err = -errno;
-		pr_warn("Failed to open cpu mask file %s: %d\n", fcpu, err);
+		pr_warn("Failed to open cpu mask file %s: %s\n", fcpu, errstr(err));
 		return err;
 	}
 	len = read(fd, buf, sizeof(buf));
 	close(fd);
 	if (len <= 0) {
 		err = len ? -errno : -EINVAL;
-		pr_warn("Failed to read cpu mask from %s: %d\n", fcpu, err);
+		pr_warn("Failed to read cpu mask from %s: %s\n", fcpu, errstr(err));
 		return err;
 	}
 	if (len >= sizeof(buf)) {
@@ -13845,20 +13876,21 @@ int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
 	obj = bpf_object_open(NULL, s->data, s->data_sz, s->name, opts);
 	if (IS_ERR(obj)) {
 		err = PTR_ERR(obj);
-		pr_warn("failed to initialize skeleton BPF object '%s': %d\n", s->name, err);
+		pr_warn("failed to initialize skeleton BPF object '%s': %s\n",
+			s->name, errstr(err));
 		return libbpf_err(err);
 	}
 
 	*s->obj = obj;
 	err = populate_skeleton_maps(obj, s->maps, s->map_cnt, s->map_skel_sz);
 	if (err) {
-		pr_warn("failed to populate skeleton maps for '%s': %d\n", s->name, err);
+		pr_warn("failed to populate skeleton maps for '%s': %s\n", s->name, errstr(err));
 		return libbpf_err(err);
 	}
 
 	err = populate_skeleton_progs(obj, s->progs, s->prog_cnt, s->prog_skel_sz);
 	if (err) {
-		pr_warn("failed to populate skeleton progs for '%s': %d\n", s->name, err);
+		pr_warn("failed to populate skeleton progs for '%s': %s\n", s->name, errstr(err));
 		return libbpf_err(err);
 	}
 
@@ -13888,13 +13920,13 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
 
 	err = populate_skeleton_maps(s->obj, s->maps, s->map_cnt, s->map_skel_sz);
 	if (err) {
-		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		pr_warn("failed to populate subskeleton maps: %s\n", errstr(err));
 		return libbpf_err(err);
 	}
 
 	err = populate_skeleton_progs(s->obj, s->progs, s->prog_cnt, s->prog_skel_sz);
 	if (err) {
-		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		pr_warn("failed to populate subskeleton maps: %s\n", errstr(err));
 		return libbpf_err(err);
 	}
 
@@ -13941,7 +13973,7 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 
 	err = bpf_object__load(*s->obj);
 	if (err) {
-		pr_warn("failed to load BPF skeleton '%s': %d\n", s->name, err);
+		pr_warn("failed to load BPF skeleton '%s': %s\n", s->name, errstr(err));
 		return libbpf_err(err);
 	}
 
@@ -13980,8 +14012,8 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 
 		err = prog->sec_def->prog_attach_fn(prog, prog->sec_def->cookie, link);
 		if (err) {
-			pr_warn("prog '%s': failed to auto-attach: %d\n",
-				bpf_program__name(prog), err);
+			pr_warn("prog '%s': failed to auto-attach: %s\n",
+				bpf_program__name(prog), errstr(err));
 			return libbpf_err(err);
 		}
 
@@ -14024,7 +14056,8 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		*link = bpf_map__attach_struct_ops(map);
 		if (!*link) {
 			err = -errno;
-			pr_warn("map '%s': failed to auto-attach: %d\n", bpf_map__name(map), err);
+			pr_warn("map '%s': failed to auto-attach: %s\n",
+				bpf_map__name(map), errstr(err));
 			return libbpf_err(err);
 		}
 	}
-- 
2.47.0


