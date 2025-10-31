Return-Path: <bpf+bounces-73103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26141C232D5
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 04:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B41189DD97
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 03:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77127E077;
	Fri, 31 Oct 2025 03:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VluiVWyW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532726B96A
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881266; cv=none; b=Q9XPnNvMWJyQwdKDRaUh72xUykube1V37mRFmNyzfEWObPylB4GC2z1qgUVIVX6Exv/J/CjKwZ/+WigcKycOPYK7eTv9s0zWOt2BfULsRR1TH9GlF4EBnJTRbbHmNaT4oDZ1RKGr8wCNRYnwGvpPBACNOtliGJEgevNfgdLi9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881266; c=relaxed/simple;
	bh=V6cuAX6S9rs+7sQz2A1fMgADe914l1hKCAx5KV0DzXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdbpP/MVUvvGvWysOuDo0L+fUclgLc4rM+O7b2epyU9ru2Ot25sxk3Ad/lzAo+EhBqbpPf1hMEKk4uEN9+Ybrxq698vt046fMfdGET4iOrz5VdNNjBXCiLlP8PdaWSTY/d6h6rR4E6gxhaAoFpiWIL/R2+1PgN4mkGW83TLu17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VluiVWyW; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1901641b3a.1
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 20:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761881263; x=1762486063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX3lwDATB8vUjhEF6peoInhrRE6S5kC9v4IRgrhV7U4=;
        b=VluiVWyWRigSjftZzmlTM2xmSSFtKGqnrAmlCjmpNN7R32QN3hzsuh5hjAWibiuFN+
         m2D5oLoJpZgwM5Zrh4VQwCyFEEW+5kdDK6/k36faHsKjGe4Gc/6PpAs9V+XBwtB3nO+F
         l+Yph/jcmo2VlcZXdqpITzBQ0gmTa5MCl+Z6wKgeRC12HW5SzoT5M754ZVX2jtfQYxes
         Xv/dx9Mi01skkYfaLRdS5XSp9SMnqi9dCEbm2U6mGRgkH59hZv+uPO2JanYDVTH+gdBs
         AfATDq5MWSoGouJS4IH3/zJg8MDQjmEnJgkTaCe9Ve8KShl/UKcaIgAiXici/qqhhNfz
         5uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761881263; x=1762486063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX3lwDATB8vUjhEF6peoInhrRE6S5kC9v4IRgrhV7U4=;
        b=mMqhZxKT9dmgIoOYwLdRm+0zB44/ellBcCtph5aBZ6clmBfMaTU0ejGxiCWoTU7qEF
         W1Ft3vzFcCRmCTCgDnlTqEuE7coq10YH2HLSDYZ33PUzTKnIziJnFmw5f+iYnM8vwvsj
         pDFFF0e1wu0NjAWe7iC3+S0LOT7wPQTfS9r+gtJcPtQ4ki3zmbSyvmxnRZR7I91JjQwi
         lG9V9apS1DNH5DA3K1X0H/oU7kb/s9Ml7J4xovK6dHLH/i1wxdVceWnV56jPze2858dQ
         vePOI5Q6a5WgSr8T+UpIPR6Z7M6dUNMXlqeIYxRVAQ4l1y6hLMLUpCFhUTcBuY3b768S
         v6JA==
X-Gm-Message-State: AOJu0Yx9WjdMx5jy6RyTX3yVnpI/onQX02OOatq/tgSp23oTOXspiW0A
	CPv/B9rj2ZNjgk/jzm5dI+XZudoqxk1HT/usFluVnJAeetD9InRSBV4xKXVwpcZ7
X-Gm-Gg: ASbGncsTwNk/8590T8m85lgtjqsPYUA7dQUnlmkHIX0g8EKTAsopyqetMvs0oR7pVvh
	MFz/CwA3xLLJh157gmggFrj10Ud900DdTLNdTycZunGKlGzx2XxKtQL3TojSq+EpILBx4GuiTrc
	AMbaVzmJEgMfUMG3E3tUMc7y+/1hagnFW7AzfVApJ25IK8En/dovmxR9UfUsm9d55NIqKQVBsem
	nhl+wLAvh69roNJ/cflRRBYT4lcxKrWiIvalD6KgJPhUiS5OIoQ6iZvAVJS4LSnJcBtsJCF1wL1
	NplmlT2uSP/VSR6POOSp90wbRPvhKBBjDA+FOhDifqPL5o5xGL1gaa4JTS10undTxg3Y84dn8/y
	gDcqjbI29M9JhjbofuaAnv3rWhoZoIbdBY86hZcqQouqb5JR9JsGF1EsW3erdNpcczaNbELlNjN
	z7wGBDn1+chbzMnBkQxA==
X-Google-Smtp-Source: AGHT+IEcmw5HYpjZbbeUAi+XyltSfLZZ0XFJJVQl7jD/4UXib3v7RmRQK3DZ4EcOQoIDVSPOdEsL/g==
X-Received: by 2002:a05:6a00:1827:b0:77f:2b7d:ee01 with SMTP id d2e1a72fcca58-7a755f84e82mr3206662b3a.1.1761881262841;
        Thu, 30 Oct 2025 20:27:42 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897ed6csm418406b3a.13.2025.10.30.20.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:27:42 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: bpf@vger.kernel.org
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] libbpf: Add doxygen documentation for bpf_obj_* APIs in bpf.h
Date: Fri, 31 Oct 2025 11:26:25 +0800
Message-Id: <20251031032627.1414462-5-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031032627.1414462-1-jianyungao89@gmail.com>
References: <20251031032627.1414462-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
 tools/lib/bpf/bpf.h | 430 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 427 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a9fb5948ecd4..28bde19a45c1 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -895,8 +895,175 @@ struct bpf_obj_pin_opts {
 	size_t :0;
 };
 #define bpf_obj_pin_opts__last_field path_fd
-
+/**
+ * @brief Pin a BPF object (map, program, BTF, link, etc.) to a persistent
+ *        location in the BPF filesystem (bpffs).
+ *
+ * bpf_obj_pin() wraps the BPF_OBJ_PIN command and creates a bpffs file
+ * at @p pathname that permanently references the in‑kernel BPF object
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
+ *  - @p fd must reference a pin‑able BPF object (map, program, link, BTF, etc.).
+ *
+ * Idempotency & overwriting:
+ *  - If a file already exists at @p pathname, the call fails (typically
+ *    with -EEXIST). Remove or rename the existing entry before pinning
+ *    a new object to that path.
+ *
+ * Lifetime semantics:
+ *  - Pinning increments the in‑kernel object's refcount. The object will
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
+ * (bpffs inode) at @p pathname references the in‑kernel BPF object
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
+ *     extension explicitly documents valid bits (non‑zero may yield
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
 
@@ -909,8 +1076,190 @@ struct bpf_obj_get_opts {
 	size_t :0;
 };
 #define bpf_obj_get_opts__last_field path_fd
-
+/**
+ * @brief Open (re‑reference) a pinned BPF object by its bpffs pathname.
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
+ *     in‑kernel object; the object's lifetime is extended while this FD
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
+ * (previously created via bpf_obj_pin()/bpf_obj_pin_opts()) into a process‑local
+ * file descriptor referencing the underlying in-kernel BPF object (map, program,
+ * BTF object, link, etc.), honoring additional lookup/open semantics supplied
+ * through @p opts.
+ *
+ * Extended capabilities vs bpf_obj_get():
+ *   - Structured forward/backward compatibility via @p opts->sz.
+ *   - Optional directory FD–relative path resolution (opts->path_fd),
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
@@ -1598,6 +1947,7 @@ LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
  *        Other negative libbpf-style errors for transient or system failures.
  */
 LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
+
 LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
 /**
  * @brief Retrieve the next existing BPF link ID after a given starting ID.
@@ -1872,7 +2222,9 @@ LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
  */
 LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
+
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
+
 LIBBPF_API int bpf_btf_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
 /**
@@ -2021,7 +2373,77 @@ LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
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
@@ -2225,7 +2647,9 @@ struct bpf_raw_tp_opts {
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


