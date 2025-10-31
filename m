Return-Path: <bpf+bounces-73117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA13C23A62
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1742D4F4062
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78F732C930;
	Fri, 31 Oct 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji1aeolb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED3329C53
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897628; cv=none; b=IRYoBM64gwIcAaQk/Cf7CvDbfjPATDPgJUm0f5EuwAv2aHDN9piS7Uzpq4rb54e6cnpbI77k4JynVB8YHmxXoBWmtY3wBPl7fAstKc5CtN0mIBkicXFpFlA/J02yZcmH+6n4dkdZV3FeDoK0i7fKsG208ygGFCj2CpkJr97WbuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897628; c=relaxed/simple;
	bh=yq5Ld84mvWeaSPZmbqfeRjs+iWZ2K7zR4uHlTNbTICg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVfMmPOk09VS8TO//C+khcNyMeHVBT93GkXTSkDz9F7hSe1x0NgMPZ6EFjWv+HhJ5TheupXgB9FL091yJR8Xe8tBPoxcRNeAG1hTcmsUTn0nQ5IJ/ilYGkhCewMHGbWl6amFe2bIZzTxv2hTjI54BaqDisSAYqYihkwjIZiIAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji1aeolb; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-340564186e0so1649974a91.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761897624; x=1762502424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGLcR+vDk0i4tFYe5UMZqo2qGNoEKjSp0blyyOlE0s8=;
        b=Ji1aeolbv9/5WkHNZ5cy/TKmgAdl65m7UDU3Yk+uHaWxHpn+NxO09U7J6721+7tUGL
         uTAHmx+eHncvniLE4ntYOi/CcmXURAu92NrqRBsLzpPocVrLnyBycuOSsWYOPAIf068k
         +OXHIwvKileLHYHCeiwKzoOMR+t7TJzjV5NTj1am7iEzVpQxYyiwBkVG5jfCriTcdMPk
         rkEQmZtC/SzEOKJcf3dk9n8rWL7Ra5dU+Csc/SuBXcpPZwpVYkuIVR+SwvnmTCjBpcfG
         F8woPDi1CCKfDBMf9TXVrVtz+yal2W3YsJK6bF6F02YG4qYvBXAXU0Ws4MvRw6+n3pq8
         jOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897624; x=1762502424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGLcR+vDk0i4tFYe5UMZqo2qGNoEKjSp0blyyOlE0s8=;
        b=IAkeuBx8FaNJSh4/FuR890S+7BqwAB8FnyMW6gTGiBMpmO13eaYUXakHa5NOU5k8w/
         UeHVJWn9UjHGR24KxziwiGlPQT+4RbtqwIuuVxJZkQyXWdGNwGbTrQ7zsM9pWkvZBCQi
         ld6yUg8UJl/Eutq4uy1Sa5z56BZsu/plvMgx2blh93A3W4O+H2R3pigfWNlkz7O9E7Br
         Pq1KdRAhZLsLmjCMCy53wFGz3gm67RatqugjikkULK7oSJHF8KbMznDDnqt+AR2HKArY
         RohcZu/OtoukO2q/iI7EibzShKeLk1GNG/yrYKIabEU3vGnnacWvl2MzC9X0IGFoqNLl
         tPGw==
X-Forwarded-Encrypted: i=1; AJvYcCWIklHQEu3WwWSm0ybfcFYtEvhQmqGeydxRQSlit1rKBokcqSauR0ThGRkwSkxigQHlJto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNRXS48VlK8vr3RcfVRWb+7JUvEZ73jBqPj6KVDrnABgLtzj5
	FzE1aYVmhdECdlcZe/uJ6ZrFO/QsUk1mKsIzfqgrpCtCsYnk4kVZT4iYCDvv/whG
X-Gm-Gg: ASbGnctz50CyhRMgtGP4ty4O9kWSaF3t+060rg9t8sgeIwbFHLqUis7ChnY2S6Sg/bn
	ukPth6oxEIsjuT/ef52Avh3I/fbRzxuixWRM0fcD1+ja2Tb+HMAglIEMdW9AHy1di5XiFbdLC7S
	+oDoJvFpgQLzRMOD8TVfvJjo99GkuBGIgJ3Z2xzlCJOiQtoWi9c8yrIDOcoiW6ElU5pfQ84fydl
	LE0BtA6LfDk/QekRJVG9joncJLcnzhuypnZ9Pf1e56O7J3uBbw2hTPFLrbI2EDcySZUDV8XybfD
	tavElvXSp2ksWaD8xtEefpcxk4laPrBDpJNv9YLBMt2wDQIwg3ryADmWgrYMxUusL1g4/aAxBaW
	3ir2hfb2OizJS9NF22auwSFPd4foR/6vO/S/3YHbfYKgHV9wvYUcG7OzwNKIOnKhrKVUSnKPKrg
	B76YH9MrnGpdeliWvOKwjZSHNEW2U3
X-Google-Smtp-Source: AGHT+IHvFC5sr7N/yrAoDiwyYNN2PxetDa4jsXkqKkOOoLtvNMqyrcxeH9Y5h1Z4gwtVXit1PESW1w==
X-Received: by 2002:a17:90b:3c52:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-34082fdbf52mr3850629a91.15.1761897623489;
        Fri, 31 Oct 2025 01:00:23 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4045fbsm1216575a12.28.2025.10.31.01.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:00:22 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH v2 4/5] libbpf: Add doxygen documentation for bpf_obj_* APIs in bpf.h
Date: Fri, 31 Oct 2025 15:59:06 +0800
Message-Id: <20251031075908.1472249-5-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031075908.1472249-1-jianyungao89@gmail.com>
References: <20251031075908.1472249-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add doxygen comment blocks for all public bpf_obj_* APIs in
tools/lib/bpf/bpf.h. These doc comments are for:

-bpf_obj_pin()
-bpf_obj_pin_opts()
-bpf_obj_get()
-bpf_obj_get_opts()
-bpf_obj_get_info_by_fd()

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v1->v2:
 - Fixed the non-ASCII characters in this patch.

The v1 is here:
https://lore.kernel.org/lkml/20251031032627.1414462-5-jianyungao89@gmail.com/

 tools/lib/bpf/bpf.h | 430 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 427 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9040fc891b81..a0cebda09e16 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -900,8 +900,175 @@ struct bpf_obj_pin_opts {
 	size_t :0;
 };
 #define bpf_obj_pin_opts__last_field path_fd
-
+/**
+ * @brief Pin a BPF object (map, program, BTF, link, etc.) to a persistent
+ *        location in the BPF filesystem (bpffs).
+ *
+ * bpf_obj_pin() wraps the BPF_OBJ_PIN command and creates a bpffs file
+ * at @p pathname that permanently references the in-kernel BPF object
+ * associated with @p fd. Once pinned, the object survives process exit
+ * and can later be reopened (referenced) by other processes via
+ * bpf_obj_get()/bpf_obj_get_opts().
+ *
+ * Typical use cases:
+ *  - Share maps or programs across processes (e.g., loader + consumer).
+ *  - Preserve objects across service restarts.
+ *  - Provide stable, discoverable paths for orchestration tooling.
+ *
+ * Requirements:
+ *  - The BPF filesystem (usually mounted at /sys/fs/bpf) must be mounted.
+ *  - All parent directories in @p pathname must already exist; this helper
+ *    does NOT create intermediate directories.
+ *  - @p fd must reference a pin-able BPF object (map, program, link, BTF, etc.).
+ *
+ * Idempotency & overwriting:
+ *  - If a file already exists at @p pathname, the call fails (typically
+ *    with -EEXIST). Remove or rename the existing entry before pinning
+ *    a new object to that path.
+ *
+ * Lifetime semantics:
+ *  - Pinning increments the in-kernel object's refcount. The object will
+ *    remain alive until the pinned bpffs entry is removed and all other
+ *    references (FDs, links, attachments) are closed.
+ *  - Closing @p fd after pinning does NOT unpin the object.
+ *
+ * Security & permissions:
+ *  - Usually requires write permission to the bpffs mount and appropriate
+ *    capabilities (CAP_BPF and/or CAP_SYS_ADMIN depending on kernel/LSM).
+ *  - Path components must not traverse outside bpffs (no ".." escapes).
+ *
+ * Example:
+ *   int map_fd = bpf_map_create(...);
+ *   if (map_fd < 0)
+ *       return -1;
+ *   if (bpf_obj_pin(map_fd, "/sys/fs/bpf/myapp/session_map") < 0) {
+ *       perror("bpf_obj_pin");
+ *       // handle error (e.g., create parent dir, adjust permissions)
+ *   }
+ *
+ * Re-opening later:
+ *   int pinned_fd = bpf_obj_get("/sys/fs/bpf/myapp/session_map");
+ *   if (pinned_fd >= 0) {
+ *       // use map
+ *       close(pinned_fd);
+ *   }
+ *
+ * @param fd        File descriptor of the loaded BPF object to pin.
+ * @param pathname  Absolute or relative path inside bpffs where the object
+ *                  should be pinned (e.g. "/sys/fs/bpf/my_map"). Must not be NULL.
+ *
+ * @return 0 on success; < 0 negative error code (libbpf style == -errno) on failure.
+ *
+ * Common errors (negative libbpf-style return codes == -errno):
+ *  - -EBADF: @p fd is not a valid BPF object FD.
+ *  - -EINVAL: @p fd refers to an object type that cannot be pinned, or
+ *             pathname is invalid.
+ *  - -EEXIST: A file already exists at @p pathname.
+ *  - -ENOENT: One or more parent directories in the path do not exist.
+ *  - -ENOTDIR: A path component expected to be a directory is not.
+ *  - -EPERM / -EACCES: Insufficient privileges or denied by security policy.
+ *  - -ENOMEM: Kernel failed to allocate internal metadata.
+ *  - Other -errno codes may be propagated from the underlying syscall.
+ *
+ */
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
+
+/**
+ * @brief Pin a BPF object (map, program, BTF, link, etc.) to bpffs with
+ *        extended options controlling filesystem open semantics.
+ *
+ * This is an extended variant of bpf_obj_pin() that allows specifying
+ * additional pinning attributes through @p opts. On success a new file
+ * (bpffs inode) at @p pathname references the in-kernel BPF object
+ * associated with @p fd, incrementing its refcount and making it
+ * persist beyond the lifetime of the creating process.
+ *
+ * Differences vs bpf_obj_pin():
+ *   - Supports optional struct bpf_obj_pin_opts for forward/backward
+ *     compatibility without breaking older kernels.
+ *   - Allows passing file creation flags (opts->file_flags) and a
+ *     directory file descriptor (opts->path_fd) for path resolution
+ *     using the underlying kernel support (e.g. enabling O_EXCL-style
+ *     semantics if/when supported).
+ *
+ * Typical usage:
+ *   struct bpf_obj_pin_opts popts = {
+ *       .sz        = sizeof(popts),
+ *       .file_flags = 0,          // reserved / must be 0 unless documented
+ *       .path_fd    = -1,         // optional dir FD; -1 means unused
+ *   };
+ *   if (bpf_obj_pin_opts(obj_fd, "/sys/fs/bpf/myapp/session_map", &popts) < 0) {
+ *       perror("bpf_obj_pin_opts");
+ *       // handle error (inspect errno or negative return value)
+ *   }
+ *
+ * Notes on @p pathname:
+ *   - Must reside within a mounted BPF filesystem (bpffs), typically
+ *     /sys/fs/bpf.
+ *   - All parent directories must already exist; intermediate directories
+ *     are not created automatically.
+ *   - Existing path results in -EEXIST (no overwrite).
+ *   - Avoid relative paths that could escape bpffs (no ".." traversal).
+ *
+ * opts initialization:
+ *   - If @p opts is non-NULL, opts->sz MUST be set to sizeof(*opts).
+ *   - Unused/unknown fields should be zeroed for forward compatibility.
+ *   - opts->file_flags: Currently reserved; pass 0 unless a kernel
+ *     extension explicitly documents valid bits (non-zero may yield
+ *     -EINVAL on older kernels).
+ *   - opts->path_fd: Optional directory file descriptor that serves as
+ *     the base for relative @p pathname resolution (similar to *at()
+ *     syscalls). Set to -1 or 0 to ignore and use normal absolute path
+ *     semantics. If used, ensure it refers to bpffs.
+ *
+ * Concurrency:
+ *   - Pinning is atomic with respect to path name; two simultaneous
+ *     attempts to pin to the same pathname will result in one success
+ *     and one -EEXIST failure.
+ *   - After success, closing @p fd does NOT unpin; removal of the pinned
+ *     bpffs file (unlink) plus closing all other references is required
+ *     to allow object destruction.
+ *
+ * Security / Privileges:
+ *   - May require CAP_BPF and/or CAP_SYS_ADMIN depending on kernel
+ *     configuration, LSM policy, and lockdown mode.
+ *   - Filesystem permissions on bpffs apply; lack of write/execute on
+ *     parent directories yields -EACCES / -EPERM.
+ *
+ * After pinning:
+ *   - Object can be reopened via bpf_obj_get()/bpf_obj_get_opts() using
+ *     the same pathname.
+ *   - Can be safely shared across processes and persists across
+ *     restarts until explicitly unpinned (unlink).
+ *
+ * Best practices:
+ *   - Zero-initialize opts: struct bpf_obj_pin_opts popts = {};
+ *   - Always set popts.sz = sizeof(popts) when passing opts.
+ *   - Validate that bpffs is mounted (e.g., stat("/sys/fs/bpf")) before
+ *     attempting to pin.
+ *   - Use distinct subdirectories (e.g., /sys/fs/bpf/<app>/...) to avoid
+ *     naming collisions and facilitate cleanup.
+ *
+ * @param fd        File descriptor of the loaded BPF object to pin.
+ * @param pathname  Absolute (recommended) or relative path inside bpffs
+ *                  identifying where to create the pin entry. Must not be NULL.
+ * @param opts      Optional pointer to a struct bpf_obj_pin_opts providing
+ *                  extended pin options; may be NULL for defaults.
+ *
+ * @return 0 on success; < 0 negative error code (libbpf style == -errno) on failure.
+ *
+ * Error handling (negative libbpf-style return codes == -errno):
+ *   - -EBADF: Invalid @p fd, or @p path_fd (if used) not a valid directory FD.
+ *   - -EINVAL: opts->sz mismatch, unsupported file_flags, invalid pathname,
+ *              or object type cannot be pinned.
+ *   - -EEXIST: A file already exists at @p pathname.
+ *   - -ENOENT: Parent directory component missing (or @p path_fd base invalid).
+ *   - -ENOTDIR: A path component expected to be a directory is not.
+ *   - -EPERM / -EACCES: Insufficient privileges or blocked by security policy.
+ *   - -ENOMEM: Kernel failed to allocate internal metadata.
+ *   - Other -errno codes may be propagated from the underlying bpf() syscall.
+ *
+ */
 LIBBPF_API int bpf_obj_pin_opts(int fd, const char *pathname,
 				const struct bpf_obj_pin_opts *opts);
 
@@ -914,8 +1081,190 @@ struct bpf_obj_get_opts {
 	size_t :0;
 };
 #define bpf_obj_get_opts__last_field path_fd
-
+/**
+ * @brief Open (re-reference) a pinned BPF object by its bpffs pathname.
+ *
+ * bpf_obj_get() wraps the BPF_OBJ_GET command of the bpf(2) syscall. It
+ * converts a persistent BPF filesystem (bpffs) entry (previously created
+ * with bpf_obj_pin()/bpf_obj_pin_opts()) back into a live file descriptor
+ * that the caller owns and can use for further operations (e.g. map
+ * lookups/updates, program introspection, link detachment, BTF queries).
+ *
+ * Supported object kinds (depending on kernel version):
+ *   - Maps
+ *   - Programs
+ *   - BTF objects
+ *   - Links
+ *   - (Future kinds may also become accessible through the same API)
+ *
+ * Typical usage:
+ *   int fd = bpf_obj_get("/sys/fs/bpf/myapp/session_map");
+ *   if (fd < 0) {
+ *       perror("bpf_obj_get");
+ *       // handle error
+ *   } else {
+ *       // use fd
+ *       close(fd);
+ *   }
+ *
+ * Path requirements:
+ *   - @p pathname must reside inside a mounted BPF filesystem (usually
+ *     /sys/fs/bpf).
+ *   - Intermediate directories must already exist.
+ *   - The path must reference a previously pinned object; regular files
+ *     or non-BPF entries yield errors.
+ *
+ * Lifetime semantics:
+ *   - Success returns a new file descriptor referencing the existing
+ *     in-kernel object; the object's lifetime is extended while this FD
+ *     (and any others) remain open or while the bpffs entry stays pinned.
+ *   - Closing the returned FD does not remove or unpin the object.
+ *   - To permanently remove the object, unlink the bpffs path and close
+ *     all remaining descriptors.
+ *
+ * Concurrency & races:
+ *   - If the pinned entry is removed (unlink) between name resolution and
+ *     the syscall, the call may fail with -ENOENT.
+ *   - Multiple opens of the same pinned path are safe and return distinct
+ *     FDs.
+ *
+ * Privileges & security:
+ *   - May require CAP_BPF and/or CAP_SYS_ADMIN depending on kernel config,
+ *     LSM policies, and lockdown mode.
+ *   - Filesystem permission checks apply (read/search on parent dirs).
+ *
+ * Thread safety:
+ *   - The function itself is thread-safe; distinct threads can open the
+ *     same pinned path concurrently.
+ *
+ * Performance considerations:
+ *   - Operation cost is dominated by path lookup and a single bpf()
+ *     syscall; typically negligible compared to subsequent map/program
+ *     usage.
+ *
+ * @param pathname Absolute (recommended) or relative bpffs path of the
+ *                 pinned BPF object; must not be NULL.
+ *
+ * @return >= 0 : File descriptor referencing the object (caller must close()).
+ *         < 0  : Negative error code (libbpf style, see list above).
+ *
+ *
+ * Error handling (negative libbpf-style return codes == -errno):
+ *   - -ENOENT: Path does not exist or was unpinned.
+ *   - -ENOTDIR: A path component expected to be a directory is not.
+ *   - -EACCES / -EPERM: Insufficient privileges or denied by security policy.
+ *   - -EINVAL: Path does not refer to a valid pinned BPF object (type mismatch,
+ *              corrupted entry, or unsupported kernel feature).
+ *   - -ENOMEM: Kernel could not allocate internal resources.
+ *   - -EBADF: Rare: internal descriptor handling failed.
+ *   - Other negative codes propagated from the underlying syscall.
+ *
+ */
 LIBBPF_API int bpf_obj_get(const char *pathname);
+
+/**
+ * @brief Open (re-reference) a pinned BPF object with extended options.
+ *
+ * bpf_obj_get_opts() is an extended variant of bpf_obj_get() that wraps the
+ * BPF_OBJ_GET command of the bpf(2) syscall. It converts a bpffs pathname
+ * (previously created via bpf_obj_pin()/bpf_obj_pin_opts()) into a process-local
+ * file descriptor referencing the underlying in-kernel BPF object (map, program,
+ * BTF object, link, etc.), honoring additional lookup/open semantics supplied
+ * through @p opts.
+ *
+ * Extended capabilities vs bpf_obj_get():
+ *   - Structured forward/backward compatibility via @p opts->sz.
+ *   - Optional directory FD-relative path resolution (opts->path_fd),
+ *     similar to *at() family syscalls (openat, fstatat, etc.).
+ *   - Future room for file/open semantic modifiers (opts->file_flags).
+ *
+ * Requirements:
+ *   - The target pathname must reside inside a mounted BPF filesystem
+ *     (usually /sys/fs/bpf). Relative paths are resolved either against
+ *     the current working directory (if opts->path_fd is -1 or 0) or
+ *     against the directory represented by opts->path_fd.
+ *   - All parent directories must already exist; intermediate components
+ *     are not created automatically.
+ *   - The bpffs entry at @p pathname must refer to a pinned BPF object.
+ *
+ * Lifetime semantics:
+ *   - Success returns a new file descriptor owning a user space reference
+ *     to the object. Closing this FD does NOT unpin or destroy the object
+ *     if other references (FDs or pinned entries) remain.
+ *   - To remove the persistent reference, unlink(2) the bpffs path and
+ *     close all remaining FDs.
+ *
+ * Concurrency & races:
+ *   - If the pinned entry is unlinked concurrently, the call may fail
+ *     with -ENOENT.
+ *   - Multiple successful opens of the same path yield distinct FDs.
+ *
+ * Security / privileges:
+ *   - May require CAP_BPF and/or CAP_SYS_ADMIN depending on kernel config,
+ *     LSM policies, or lockdown mode.
+ *   - Filesystem permission checks apply to path traversal and directory
+ *     components (execute/search permissions).
+ *
+ * @param pathname
+ *        Absolute or relative bpffs path of the pinned BPF object. Must
+ *        not be NULL. If relative and opts->path_fd is a valid directory
+ *        FD, resolution is performed relative to that directory; otherwise
+ *        relative to the process's current working directory.
+ * @param opts
+ *        Optional pointer to a zero-initialized bpf_obj_get_opts structure.
+ *        May be NULL for default behavior. Fields:
+ *          - sz: MUST be set to sizeof(struct bpf_obj_get_opts) when @p opts
+ *                is non-NULL; mismatch causes -EINVAL.
+ *          - file_flags: Reserved for future extensions; MUST be 0 on
+ *                current kernels or the call may fail with -EINVAL.
+ *          - path_fd: Directory file descriptor for *at()-style relative
+ *                path resolution. Set to -1 (or 0) to ignore and use normal
+ *                pathname semantics. Must reference a directory within bpffs
+ *                if used with relative @p pathname.
+ *
+ * @return
+ *   >= 0 : File descriptor referencing the pinned BPF object (caller must close()).
+ *   < 0  : Negative libbpf-style error code (== -errno):
+ *            - -ENOENT: Path does not exist or was unpinned.
+ *            - -ENOTDIR: A path component is not a directory; or opts->path_fd
+ *                       is not a directory when required.
+ *            - -EACCES / -EPERM: Insufficient privileges or denied by security policy.
+ *            - -EBADF: Invalid opts->path_fd (not an open FD) or internal FD misuse.
+ *            - -EINVAL: opts->sz mismatch, unsupported file_flags, invalid pathname,
+ *                       or path does not refer to a valid pinned BPF object.
+ *            - -ENOMEM: Kernel failed to allocate internal metadata/resources.
+ *            - Other -errno codes may be propagated from the underlying syscall.
+ *
+ * Usage example:
+ *   struct bpf_obj_get_opts gopts = {
+ *       .sz = sizeof(gopts),
+ *       .file_flags = 0,
+ *       .path_fd = -1,
+ *   };
+ *   int fd = bpf_obj_get_opts("/sys/fs/bpf/myapp/session_map", &gopts);
+ *   if (fd < 0) {
+ *       // handle error (inspect -fd or errno)
+ *   } else {
+ *       // use fd
+ *       close(fd);
+ *   }
+ *
+ * Best practices:
+ *   - Always zero-initialize the opts struct before setting recognized fields.
+ *   - Verify bpffs is mounted (e.g., stat("/sys/fs/bpf")) before calling.
+ *   - Avoid passing non-zero file_flags until documented by newer kernels.
+ *   - Treat -ENOENT as a normal condition if the object might have been
+ *     cleaned up asynchronously.
+ *
+ * Thread safety:
+ *   - Safe to call concurrently from multiple threads; each successful call
+ *     yields its own FD.
+ *
+ * Forward compatibility:
+ *   - Unrecognized future fields must remain zeroed to avoid -EINVAL.
+ *   - Ensure opts->sz matches the libbpf version's struct size to enable
+ *     kernel-side bounds checking and extension handling.
+ */
 LIBBPF_API int bpf_obj_get_opts(const char *pathname,
 				const struct bpf_obj_get_opts *opts);
 /**
@@ -1603,6 +1952,7 @@ LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
  *        Other negative libbpf-style errors for transient or system failures.
  */
 LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
+
 LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
 /**
  * @brief Retrieve the next existing BPF link ID after a given starting ID.
@@ -1877,7 +2227,9 @@ LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
  */
 LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
+
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
+
 LIBBPF_API int bpf_btf_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
 /**
@@ -2026,7 +2378,77 @@ LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
  */
 LIBBPF_API int bpf_link_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
-
+/**
+ * @brief Retrieve information about a BPF object (program, map, BTF, or link) given
+ *        its file descriptor.
+ *
+ * This is a generic libbpf wrapper around the kernel's BPF_OBJ_GET_INFO_BY_FD
+ * command. Depending on what type of BPF object @p bpf_fd refers to, the kernel
+ * expects @p info to point to an appropriately typed info structure:
+ *
+ *   - struct bpf_prog_info  (for program FDs)
+ *   - struct bpf_map_info   (for map FDs)
+ *   - struct bpf_btf_info   (for BTF object FDs)
+ *   - struct bpf_link_info  (for link FDs)
+ *
+ * You must:
+ *   1. Zero-initialize the chosen info structure (to avoid undefined padding contents).
+ *   2. Set *@p info_len to sizeof(struct <relevant_info_type>) before the call.
+ *   3. Pass a pointer to the structure as @p info.
+ *
+ * On success, the kernel fills as much of the structure as it supports/recognizes
+ * for the running kernel version and may update *@p info_len with the actual number
+ * of bytes written (libbpf preserves kernel behavior). Unrecognized future fields
+ * remain zeroed. If *@p info_len is smaller than the minimum required size for that
+ * object type, the call fails with -EINVAL.
+ *
+ * Typical usage (program example):
+ *   struct bpf_prog_info pinfo = {};
+ *   __u32 len = sizeof(pinfo);
+ *   if (bpf_obj_get_info_by_fd(prog_fd, &pinfo, &len) == 0) {
+ *       // pinfo now populated (len bytes). Inspect fields like pinfo.id, pinfo.type, ...
+ *   } else {
+ *       // handle error (errno set; negative return value also provided)
+ *   }
+ *
+ * Concurrency & races:
+ *   - The object referenced by @p bpf_fd remains valid while its FD is open, so
+ *     races are limited. However, fields referring to related kernel entities
+ *     (e.g., map IDs a program references) may change if other management operations
+ *     occur concurrently.
+ *
+ * Forward/backward compatibility:
+ *   - Always zero the entire info struct before calling; newer kernels may fill
+ *     additional fields.
+ *   - Do not assume all fields are populated; check size/version or specific
+ *     feature flags if present.
+ *
+ * Security / privileges:
+ *   - Access may require CAP_BPF and/or CAP_SYS_ADMIN depending on kernel configuration,
+ *     LSM policy, and lockdown mode. Insufficient privilege yields -EPERM / -EACCES.
+ *
+ * @param bpf_fd   File descriptor of a loaded BPF object (program, map, BTF, or link).
+ * @param info     Pointer to a zero-initialized, type-appropriate info structure
+ *                 (see list above).
+ * @param info_len Pointer to a __u32 containing the size of *info* on input; on
+ *                 success updated to the number of bytes actually written. Must
+ *                 not be NULL.
+ *
+ * @return 0 on success;
+ *         < 0 negative error code (libbpf style == -errno) on failure:
+ *           - -EBADF:  @p bpf_fd is not a valid BPF object descriptor.
+ *           - -EINVAL: Wrong object type, info_len too small, malformed arguments.
+ *           - -EFAULT: @p info or @p info_len points to inaccessible user memory.
+ *           - -EPERM / -EACCES: Insufficient privileges / blocked by security policy.
+ *           - -ENOMEM: Kernel failed to allocate internal resources.
+ *           - Other -errno values may be propagated from the underlying syscall.
+ *
+ * Error handling notes:
+ *   - Treat -EINVAL as often indicating a size mismatch; verify that sizeof(your struct)
+ *     matches what the kernel expects for your libbpf/kernel version.
+ *   - Always inspect errno (or the negative return value) for precise failure reasons.
+ *
+ */
 LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
 
 /**
@@ -2230,7 +2652,9 @@ struct bpf_raw_tp_opts {
 #define bpf_raw_tp_opts__last_field cookie
 
 LIBBPF_API int bpf_raw_tracepoint_open_opts(int prog_fd, struct bpf_raw_tp_opts *opts);
+
 LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
+
 LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
 				 __u64 *probe_offset, __u64 *probe_addr);
-- 
2.34.1


