Return-Path: <bpf+bounces-73118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B293C23A6B
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D84E54F464B
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB742E7641;
	Fri, 31 Oct 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2oNB6XZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8B32D428
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897635; cv=none; b=Ibb2WYOX/g8RlKldeH5ZTkqaBm5YUzRUqrHqD8LSNrPAdR2YAz4Qune5KAkqyAljKOpha1KhyncGG1rPod32mNxrt5sqcgvdmysUpwQQJ19u9imIVwegiHJZ6CSOBKKc+jOMRoCCSVDgfzNninMDiXKo9x0iutW53mQ8V21bfdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897635; c=relaxed/simple;
	bh=PY5JcpIz1RbUpSehb4OzqIXr+m4nDWvNZTAADYEpQgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GD0FdmR49+yda8efzrEAAhhTFp76+u7Ft0CxbJ3Ole/AdN1fy0Ba9gax2oQdcqyRbMg4dAcQG8S3zlwThJYxwX/Xj1XGlpA/dOCkX1q5IJXU8fYb3WmcX0ohBMuW9e1bzWMnluKgX7DWDS/Abjs9qMUmlmCQo2C6nKfaqKCa1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2oNB6XZ; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1528250a91.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761897631; x=1762502431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMEI8A5exlVvtBbYgkjVXGm9tCatVMbqAKq87JD9SN8=;
        b=E2oNB6XZDVfz2OEY8d42303HLwuruhOzAcpEZYthVkRdwTFpDyriOrscaNowC4FZry
         HbdSTtU4FvYN7z/slo0Qr5vZtk2xBQt/vfSsQA4NfsH5BuZdag/7xvI7zjG5pafFJWLw
         LFifE3TOWkErWgCw3fdw0nb57ZHFNMRJIdDsIKL6lO0YdEYc4Ds5NR3Ja3WJ+Bl2t7mq
         Dhxptn8HjxHu1+OxWBHfm/qgA7xNnoCx4xvejZtkQPyDij/GAuXU5ZpRolePsZabqPy7
         ldcigfHwMFhFqsdNe7jfqqljH1bahqfI5i5WNV7fqI2FFAkqqeJKsIdDt+fKZF30dCc2
         nQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897631; x=1762502431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMEI8A5exlVvtBbYgkjVXGm9tCatVMbqAKq87JD9SN8=;
        b=DLKSWzAkvCGrUCxADYlUCc8c9wEggH96VYxFRTzY3/ArABoenv+p+BBp4g+4OWzZ7P
         75M0onFystzi8wuc1ZRhQdTkn80DBamLQOBGCcCoas7AiYEWzP06oN2UFuCieHuyqQ/g
         qVf7pdX2uJNp9GzYMJkjhtAkTc2R8PgOP7ybzCG+QXkiOIUXZ65uaXpemQyXN/vBjUTZ
         QDvAeM7QYbDM5tMBs25Le/byLrqBhh4355cbGtC8/OQuhz/b32cuMRVtf5BxezsYKzX7
         34oV+g8bu7yWLhtRTc9cZw0jBfCu97jhe/9dZIf7ASrQt2ax6/8Rf03rbTUySZOjmfsD
         zZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCV52/rvnPK2Zjc9mg2QT6LEtFqzg3RVy5cji8B0Gz5AOIoVhhAf6gq+sUe3xWQ65zhy4O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykePeMIX3FQfjcURMWlzb0wmqJIH8iJKVK7Bf4Wqfy1qN081IP
	ZxDkB8Gu2Stk5JU5rhHiZzjSusgIoVBX/q98NuM0suAK3lxvUYEMZB3j
X-Gm-Gg: ASbGnctRiLO5hsLc6Yg9TycroRYqIqEadZYH81q0vTu1W7k2U9APTMfk0GZbj/KfANQ
	1jWvxxuHXMVBuj4dHRA2VHGP9rzTEaNXPz65uCS9TRMoqwk6KQg1eQdal/bfNxxyLjHRSvRdjJL
	3UPLEE8XpihPUxlxmNiU1oB9IgcM373FMDSnM4CdTQaUytlUbpalyN1xR/VbHtKcqlYbS7hwEQb
	mYJVZ4lrrd5o+KsBuzIsnlrcu/YBrPK2GPrWT1wEAVn5wKYmehSIxBa8DJd9ZBa/Cohd2zRUZHC
	tUqCvYsZ+m73ny3v6pgChHMfoQbOM8bjwxGWo/WkVsqUQ5I1YI1pM/4UapTXetld3YCAiCMqbs4
	/dvROEBxL9j16NB6umN1zEsYQbUxfn742KE+cLkmflWUYNiH8xLrrnfL/pcujypuIpfgIKhRgiM
	3aJDRH9y+ARb8Ido/Luw==
X-Google-Smtp-Source: AGHT+IE6I/euK7zSq1aq635xnYJW9TJkfDVuIBI96r+FjKNtnQk+YSU7YsB4Q+x/iCNHMPaC9aOiRQ==
X-Received: by 2002:a17:90b:4c10:b0:32e:936f:ad7 with SMTP id 98e67ed59e1d1-3408308ab21mr3411827a91.27.1761897630788;
        Fri, 31 Oct 2025 01:00:30 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4045fbsm1216575a12.28.2025.10.31.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:00:29 -0700 (PDT)
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
Subject: [PATCH v2 5/5] libbpf: Add doxygen documentation for btf/iter etc. in bpf.h
Date: Fri, 31 Oct 2025 15:59:07 +0800
Message-Id: <20251031075908.1472249-6-jianyungao89@gmail.com>
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

Add doxygen comment blocks for remaining helpers (btf/iter etc.) in
tools/lib/bpf/bpf.h. These doc comments are for:

-libbpf_set_memlock_rlim()
-bpf_btf_load()
-bpf_iter_create()
-bpf_btf_get_next_id()
-bpf_btf_get_fd_by_id()
-bpf_btf_get_fd_by_id_opts()
-bpf_raw_tracepoint_open_opts()
-bpf_raw_tracepoint_open()
-bpf_task_fd_query()

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v1->v2:
 - Fixed compilation error caused by embedded literal "/*" inside a
   comment (rephrased/escaped).
 - Fixed the non-ASCII characters in this patch.

The v1 is here:
https://lore.kernel.org/lkml/20251031032627.1414462-6-jianyungao89@gmail.com/

 tools/lib/bpf/bpf.h | 745 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 740 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a0cebda09e16..6ef1ea7921c4 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -34,7 +34,61 @@
 #ifdef __cplusplus
 extern "C" {
 #endif
-
+/**
+ * @brief Adjust process RLIMIT_MEMLOCK to facilitate loading BPF objects.
+ *
+ * libbpf_set_memlock_rlim() raises (or lowers) the calling process's
+ * RLIMIT_MEMLOCK soft and hard limits to at least the number of bytes
+ * specified by memlock_bytes. BPF map and program creation can require
+ * locking kernel/user pages; if RLIMIT_MEMLOCK is too low the kernel
+ * will fail operations with EPERM/ENOMEM. This helper provides a
+ * convenient way to pre-allocate sufficient memlock quota.
+ *
+ * Semantics:
+ *   - If current (soft or hard) RLIMIT_MEMLOCK is already >= memlock_bytes,
+ *     the limit is left unchanged and the function succeeds.
+ *   - Otherwise, the function attempts to set both soft and hard limits
+ *     to memlock_bytes using setrlimit(RLIMIT_MEMLOCK, ...).
+ *   - On systems enforcing privilege constraints, increasing the hard
+ *     limit may require CAP_SYS_RESOURCE; lack of privilege yields failure.
+ *
+ * Typical usage (before loading large maps/programs):
+ *   size_t needed = 128ul * 1024 * 1024; // 128 MB
+ *   if (libbpf_set_memlock_rlim(needed) < 0) {
+ *       // handle error (e.g., fall back to smaller maps or abort)
+ *   }
+ *
+ * Choosing a value:
+ *   - Sum anticipated sizes of maps (key_size + value_size) * max_entries
+ *     plus overhead. Add headroom for verifier, BTF, and future growth.
+ *   - Large per-CPU maps multiply value storage by number of CPUs.
+ *   - Overestimating is usually harmless (within administrative policy).
+ *
+ * Concurrency & scope:
+ *   - Affects only the calling process's RLIMIT_MEMLOCK.
+ *   - Child processes inherit the adjusted limits after fork/exec.
+ *
+ * Security / privileges:
+ *   - Increasing the hard limit above the current maximum may require
+ *     CAP_SYS_RESOURCE or appropriate PAM/ulimit configuration.
+ *   - Without sufficient privilege, the call fails with -errno (often -EPERM).
+ *
+ * @param memlock_bytes Desired minimum RLIMIT_MEMLOCK (in bytes). If zero,
+ *                      the function is a no-op (always succeeds).
+ *
+ * @return 0 on success;
+ *         < 0 negative error code (libbpf style == -errno) on failure:
+ *           - -EINVAL: Invalid argument (e.g., internal conversion issues).
+ *           - -EPERM / -EACCES: Insufficient privilege to raise hard limit.
+ *           - -ENOMEM: Rare failure allocating internal structures.
+ *           - Other -errno codes propagated from setrlimit().
+ *
+ * Failure handling:
+ *   - A failure means RLIMIT_MEMLOCK is unchanged; subsequent BPF map/program
+ *     loads may still succeed if existing limit is adequate.
+ *   - Check current limits manually (getrlimit) if precise sizing is critical.
+ *
+ */
 LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
 struct bpf_map_create_opts {
@@ -295,7 +349,104 @@ struct bpf_btf_load_opts {
 	size_t :0;
 };
 #define bpf_btf_load_opts__last_field token_fd
-
+/**
+ * @brief Load a BTF (BPF Type Format) blob into the kernel and obtain a BTF object FD.
+ *
+ * bpf_btf_load() wraps the BPF_BTF_LOAD command of the bpf(2) syscall. It validates
+ * and registers the BTF metadata described by @p btf_data so that subsequently loaded
+ * BPF programs and maps can reference rich type information (for CO-RE relocations,
+ * pretty printing, introspection, etc.).
+ *
+ * Typical usage:
+ *   // Prepare optional verifier/logging buffer (only if you want kernel diagnostics)
+ *   char log_buf[1 << 20] = {};
+ *   struct bpf_btf_load_opts opts = {
+ *       .sz        = sizeof(opts),
+ *       .log_buf   = log_buf,
+ *       .log_size  = sizeof(log_buf),
+ *       .log_level = 1,              // >0 to request kernel parsing/validation log
+ *   };
+ *   int btf_fd = bpf_btf_load(btf_blob_ptr, btf_blob_size, &opts);
+ *   if (btf_fd < 0) {
+ *       // Inspect errno; if opts.log_buf was provided, it may contain details.
+ *   } else {
+ *       // Use btf_fd (e.g. pass to bpf_prog_load() via prog_btf_fd, or query info).
+ *   }
+ *
+ * Input expectations:
+ *   - @p btf_data must point to a complete, well-formed BTF buffer starting with
+ *     struct btf_header followed by the type section and string section.
+ *   - @p btf_size is the total size in bytes of that buffer.
+ *   - Endianness must match the running kernel; cross-endian BTF is rejected.
+ *   - Types must obey kernel constraints (e.g., no unsupported kinds, valid string
+ *     offsets, canonical integer encodings, no dangling references).
+ *
+ * Logging (opts->log_*):
+ *   - If @p opts is non-NULL and opts->log_level > 0, the kernel may emit a textual
+ *     parse/validation log into opts->log_buf (up to opts->log_size - 1 bytes, with
+ *     trailing '\0').
+ *   - On supported kernels, opts->log_true_size is updated to reflect the full (untruncated)
+ *     length of the internal log; if larger than log_size, the log was truncated.
+ *   - If the kernel does not support returning true size, log_true_size remains equal
+ *     to the original log_size value or zero.
+ *
+ * Privileges & security:
+ *   - CAP_BPF and/or CAP_SYS_ADMIN may be required depending on kernel configuration,
+ *     LSM policy, and lockdown mode. Lack of privilege yields -EPERM / -EACCES.
+ *   - In delegated environments, opts->token_fd (if available and supported) can grant
+ *     scoped permission to load BTF without full global capabilities.
+ *
+ * Memory and lifetime:
+ *   - On success a file descriptor (>= 0) referencing the in-kernel BTF object is returned.
+ *     Close it with close() when no longer needed.
+ *   - The kernel makes its own copy of the supplied BTF blob; the caller can free or reuse
+ *     @p btf_data immediately after the call returns.
+ *   - BTF objects can be queried via bpf_btf_get_info_by_fd() and referenced by programs
+ *     (prog_btf_fd) or maps for type information.
+ *
+ * Concurrency & races:
+ *   - Loading is independent; multiple BTF objects may coexist.
+ *   - There is no automatic deduplication across separate loads (except any internal
+ *     kernel optimizations); user space manages uniqueness/pinning if desired.
+ *
+ * Validation tips:
+ *   - Use bpftool btf dump to sanity-check a blob before loading.
+ *   - Keep string table minimal; excessive strings inflate memory and may hit limits.
+ *   - Ensure all referenced type IDs exist and form a closed, acyclic graph (except
+ *     for permitted self-references in struct/union definitions).
+ *
+ * After loading:
+ *   - Pass the returned FD as prog_btf_fd when loading programs that rely on CO-RE
+ *     relocations or need BTF type validation.
+ *   - Optionally pin the BTF object with bpf_obj_pin() for persistence across process
+ *     lifetimes.
+ *   - Query metadata (e.g., number of types, string section size) with bpf_btf_get_info_by_fd().
+ *
+ * @param btf_data Pointer to the raw in-memory BTF blob.
+ * @param btf_size Size (in bytes) of the BTF blob pointed to by @p btf_data.
+ * @param opts     Optional pointer to a bpf_btf_load_opts struct. May be NULL.
+ *                 Must set opts->sz = sizeof(*opts) when non-NULL. Fields:
+ *                   - log_buf / log_size / log_level: Request and store kernel
+ *                     validation log (see Logging).
+ *                   - log_true_size: Updated by kernel on success (if supported).
+ *                   - btf_flags: Reserved for future extensions (must be 0 unless documented).
+ *                   - token_fd: Delegated permission token (0 or -1 if unused).
+ *
+ * @return
+ *   >= 0 : File descriptor referencing the loaded BTF object.
+ *   < 0  : Negative error code (see Error handling).
+ *
+ * Error handling (negative return codes == -errno style):
+ *   - -EINVAL: Malformed BTF (bad header, section sizes, invalid type graph, bad string
+ *              offsets, unsupported features), opts->sz mismatch, bad flags.
+ *   - -EFAULT: @p btf_data or opts->log_buf points to unreadable/writable memory.
+ *   - -ENOMEM: Kernel failed to allocate memory for internal BTF representation.
+ *   - -EPERM / -EACCES: Insufficient privileges or blocked by security policy.
+ *   - -E2BIG: Exceeds kernel size/complexity limits (e.g., too many types or strings).
+ *   - -ENOTSUP / -EOPNOTSUPP: Kernel lacks support for a feature used in the blob (rare).
+ *   - Other negative codes may be propagated from the underlying syscall.
+ *
+ */
 LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
 			    struct bpf_btf_load_opts *opts);
 
@@ -1840,7 +1991,84 @@ struct bpf_link_update_opts {
  */
 LIBBPF_API int bpf_link_update(int link_fd, int new_prog_fd,
 			       const struct bpf_link_update_opts *opts);
-
+/**
+ * @brief Create a user space iterator stream FD from an existing BPF iterator link.
+ *
+ * bpf_iter_create() wraps the kernel's BPF_ITER_CREATE command. Given a BPF
+ * link FD (@p link_fd) that represents an attached BPF iterator program
+ * (i.e., a program of type BPF_PROG_TYPE_TRACING with an iterator attach
+ * type such as BPF_TRACE_ITER), this function returns a new file descriptor
+ * from which user space can sequentially read the iterator's textual or
+ * binary output.
+ *
+ * Reading the returned FD:
+ *   - Use read(), pread(), or a buffered I/O layer to consume iterator data.
+ *   - Each read() returns zero (EOF) when the iterator has completed producing
+ *     all elements; close the FD afterward.
+ *   - Short reads are normal; loop until EOF or error.
+ *
+ * Lifetime & ownership:
+ *   - Success returns a new FD; caller owns it and must close() when finished.
+ *   - Closing the iterator FD does NOT destroy the underlying link or program.
+ *   - You can create multiple iterator FDs from the same link concurrently;
+ *     each is an independent traversal.
+ *
+ * Typical usage:
+ *   int link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_ITER, &opts);
+ *   if (link_fd < 0) { // handle error  }
+ *   int iter_fd = bpf_iter_create(link_fd);
+ *   if (iter_fd < 0) { // handle error  }
+ *   char buf[4096];
+ *   for (;;) {
+ *       ssize_t n = read(iter_fd, buf, sizeof(buf));
+ *       if (n < 0) {
+ *           if (errno == EINTR) continue;
+ *           perror("read iter");
+ *           break;
+ *       }
+ *       if (n == 0) // end of iteration
+ *           break;
+ *       fwrite(buf, 1, n, stdout);
+ *   }
+ *   close(iter_fd);
+ *
+ * Concurrency & races:
+ *   - Safe to call concurrently from multiple threads; each iterator FD
+ *     represents its own walk.
+ *   - Underlying kernel objects (maps, tasks, etc.) may change while iterating;
+ *     output is a best-effort snapshot, not a stable, atomic view.
+ *
+ * Performance considerations:
+ *   - Large buffers (e.g., 16-64 KiB) reduce syscall overhead for high-volume
+ *     iterators.
+ *   - For blocking behavior, select()/poll()/epoll() can be used; EOF is
+ *     indicated by read() returning 0.
+ *
+ * Security & privileges:
+ *   - May require CAP_BPF and/or CAP_SYS_ADMIN depending on kernel configuration,
+ *     lockdown mode, and LSM policy governing the iterator target.
+ *
+ * @param link_fd File descriptor of a BPF link representing an attached iterator program.
+ *
+ * @return >= 0: Iterator stream file descriptor to read from.
+ *         < 0 : Negative error code (libbpf style, == -errno) on failure.
+ *
+ *
+ * Error handling (negative libbpf-style return value == -errno):
+ *   - -EBADF: @p link_fd is not a valid open FD.
+ *   - -EINVAL: @p link_fd does not refer to an iterator-capable BPF link, or
+ *              unsupported combination for the running kernel.
+ *   - -EPERM / -EACCES: Insufficient privileges / blocked by security policy.
+ *   - -EOPNOTSUPP / -ENOTSUP: Kernel lacks iterator creation support for this link.
+ *   - -ENOMEM: Kernel could not allocate internal data structures.
+ *   - Other -errno codes may be propagated from the underlying bpf() syscall.
+ *
+ * Robustness tips:
+ *   - Verify the program was attached with the correct iterator attach type.
+ *   - Treat a 0-length read as normal completion, not an error.
+ *   - Always handle transient read() failures (EINTR, EAGAIN if non-blocking).
+ *
+ */
 LIBBPF_API int bpf_iter_create(int link_fd);
 
 struct bpf_prog_test_run_attr {
@@ -1953,6 +2181,68 @@ LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
  */
 LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
 
+/**
+ * @brief Retrieve the next existing BTF object ID after a given starting ID.
+ *
+ * This helper wraps the kernel's BPF_BTF_GET_NEXT_ID command and enumerates
+ * in-kernel BTF (BPF Type Format) objects in strictly ascending order of
+ * their kernel-assigned IDs. It is typically used to iterate all currently
+ * loaded BTF objects (e.g., vmlinux BTF, module BTFs, user-loaded BTF blobs).
+ *
+ * Enumeration pattern:
+ *   1. Initialize start_id to 0 to obtain the first (lowest) existing BTF ID.
+ *   2. On success, *next_id is set to the first BTF ID strictly greater than start_id.
+ *   3. Use the returned *next_id as the new start_id in a subsequent call.
+ *   4. Repeat until the function returns -ENOENT, which signals there is no
+ *      BTF object with ID greater than start_id (end of iteration).
+ *
+ * Concurrency & races:
+ *   - BTF objects can be loaded or unloaded concurrently with enumeration.
+ *     An ID retrieved in one call may become invalid (object unloaded) before
+ *     you convert it to a file descriptor with bpf_btf_get_fd_by_id().
+ *   - Enumeration does not provide a stable snapshot. Newly loaded BTFs may
+ *     appear after you've passed their predecessor ID.
+ *
+ * Lifetime & validity:
+ *   - IDs are monotonically increasing and effectively never wrap in normal
+ *     operation.
+ *   - Successfully retrieving an ID does NOT pin the corresponding BTF object.
+ *     Obtain a file descriptor immediately if you need to interact with it.
+ *
+ * Typical usage:
+ *   __u32 id = 0, next;
+ *   while (bpf_btf_get_next_id(id, &next) == 0) {
+ *       int btf_fd = bpf_btf_get_fd_by_id(next);
+ *       if (btf_fd >= 0) {
+ *           // Inspect/query BTF (e.g. bpf_btf_get_info_by_fd()).
+ *           close(btf_fd);
+ *       }
+ *       id = next;
+ *   }
+ *   // Loop ends when bpf_btf_get_next_id() returns -ENOENT.
+ *
+ * @param start_id
+ *        Starting point for the search. The helper finds the first BTF ID
+ *        strictly greater than start_id. Use 0 to begin enumeration.
+ * @param next_id
+ *        Pointer to a __u32 that receives the next BTF ID on success.
+ *        Must not be NULL.
+ *
+ * @return
+ *   0        on success (next_id populated);
+ *   -ENOENT  if there is no BTF ID greater than start_id (normal end of iteration);
+ *   -EINVAL  if next_id is NULL or arguments are otherwise invalid;
+ *   -EPERM / -EACCES if denied by security policy or lacking required privileges;
+ *   Other negative libbpf-style codes (-errno) on transient or system failures.
+ *
+ * Error handling notes:
+ *   - Treat -ENOENT as normal termination, not an exceptional error.
+ *   - For other failures, errno is set to the underlying cause.
+ *
+ * Follow-up:
+ *   - Convert retrieved IDs to FDs with bpf_btf_get_fd_by_id() to inspect
+ *     metadata or pin the BTF object.
+ */
 LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
 /**
  * @brief Retrieve the next existing BPF link ID after a given starting ID.
@@ -2227,9 +2517,171 @@ LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
  */
 LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
-
+/**
+ * @brief Obtain a file descriptor for an existing in-kernel BTF (BPF Type Format)
+ *        object given its kernel-assigned ID.
+ *
+ * bpf_btf_get_fd_by_id() wraps the BPF_BTF_GET_FD_BY_ID command of the bpf(2)
+ * syscall. Each loaded BTF object (vmlinux BTF, kernel module BTF, or user-supplied
+ * BTF blob loaded via BPF_BTF_LOAD) has a monotonically increasing, unique ID.
+ * This helper converts that stable ID into a process-local file descriptor
+ * suitable for introspection (e.g., via bpf_btf_get_info_by_fd()), pinning
+ * (bpf_obj_pin()), or reuse when loading BPF programs/maps that reference types
+ * from this BTF.
+ *
+ * Typical enumeration + open pattern:
+ *   __u32 id = 0, next;
+ *   while (bpf_btf_get_next_id(id, &next) == 0) {
+ *       int btf_fd = bpf_btf_get_fd_by_id(next);
+ *       if (btf_fd >= 0) {
+ *           // inspect with bpf_btf_get_info_by_fd(btf_fd, ...)
+ *           close(btf_fd);
+ *       }
+ *       id = next;
+ *   }
+ *   // Loop ends when bpf_btf_get_next_id() returns -ENOENT.
+ *
+ * Concurrency & races:
+ *   - A BTF object may be unloaded (e.g., module removal) between discovering
+ *     its ID and calling this function; in that case the call fails with -ENOENT.
+ *   - Successfully obtaining a file descriptor does not prevent later unloading
+ *     by other processes; subsequent operations on the FD can still fail.
+ *
+ * Lifetime & ownership:
+ *   - On success the caller owns the returned descriptor and must close() it
+ *     when no longer needed.
+ *   - Closing the FD does not destroy the underlying BTF object if other
+ *     references (FDs or pinned bpffs paths) remain.
+ *
+ * Privileges / security:
+ *   - May require CAP_BPF and/or CAP_SYS_ADMIN depending on kernel configuration,
+ *     LSM policies, or lockdown mode. Lack of privilege yields -EPERM / -EACCES.
+ *   - Access can also be restricted by namespace or cgroup-based security policies.
+ *
+ * Use cases:
+ *   - Retrieve BTF metadata (type counts, string section size, specific type
+ *     definitions) via bpf_btf_get_info_by_fd().
+ *   - Pass the FD as prog_btf_fd when loading eBPF programs needing CO-RE or
+ *     type validation.
+ *   - Pin the BTF object for persistence across process lifetimes.
+ *
+ * @param id
+ *        Kernel-assigned unique (non-zero) BTF object ID. Typically obtained via
+ *        bpf_btf_get_next_id() or from a prior info query. Must be > 0.
+ *
+ * @return
+ *   >= 0 : File descriptor referencing the BTF object (caller must close()).
+ *   < 0  : Negative libbpf-style error code (== -errno):
+ *            - -ENOENT : No BTF object with this ID (unloaded or never existed).
+ *            - -EPERM / -EACCES : Insufficient privileges / blocked by policy.
+ *            - -EINVAL : Invalid ID (e.g., 0) or kernel rejected the request.
+ *            - -ENOMEM : Kernel memory/resource exhaustion.
+ *            - Other negative values: Propagated syscall failures.
+ *
+ * Error handling notes:
+ *   - Treat -ENOENT as a normal race outcome if objects can disappear.
+ *   - Always close the returned FD to avoid resource leaks.
+ *
+ * Thread safety:
+ *   - Safe to call concurrently; each successful invocation yields an independent FD.
+ *
+ * Forward compatibility:
+ *   - ID space is monotonic; practical wraparound is not expected.
+ *   - Future kernels may add additional validation or permission gating; handle
+ *     new -errno codes conservatively.
+ */
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
 
+/**
+ * @brief Obtain a file descriptor for an existing in-kernel BTF (BPF Type Format)
+ *        object by its kernel-assigned ID, with extended open options.
+ *
+ * bpf_btf_get_fd_by_id_opts() is an extended variant of bpf_btf_get_fd_by_id().
+ * It wraps the BPF_BTF_GET_FD_BY_ID command of the bpf(2) syscall and converts
+ * a stable, monotonically increasing BTF object ID (@p id) into a process-local
+ * file descriptor, honoring optional attributes supplied via @p opts.
+ *
+ * A BTF object represents a loaded collection of type metadata (vmlinux BTF,
+ * kernel module BTF, or user-supplied BTF blob). Programs and maps can refer
+ * to these types for CO-RE relocations, verification, and introspection.
+ *
+ * Typical enumeration + open pattern:
+ *   __u32 cur = 0, next;
+ *   while (bpf_btf_get_next_id(cur, &next) == 0) {
+ *       struct bpf_get_fd_by_id_opts o = {
+ *           .sz = sizeof(o),
+ *           .open_flags = 0,
+ *           .token_fd = -1,
+ *       };
+ *       int btf_fd = bpf_btf_get_fd_by_id_opts(next, &o);
+ *       if (btf_fd >= 0) {
+ *           // use btf_fd (e.g. bpf_btf_get_info_by_fd())
+ *           close(btf_fd);
+ *       }
+ *       cur = next;
+ *   }
+ *   // Loop ends when bpf_btf_get_next_id() returns -ENOENT.
+ *
+ * Initialization & @p opts usage:
+ *   - @p opts may be NULL for default behavior (equivalent to zeroed fields).
+ *   - If @p opts is non-NULL, opts->sz MUST be set to sizeof(*opts); mismatch
+ *     yields -EINVAL.
+ *   - opts->open_flags:
+ *       Reserved for future kernel extensions; pass 0 unless a documented flag
+ *       is supported. Unsupported bits => -EINVAL.
+ *   - opts->token_fd:
+ *       Optional BPF token FD enabling delegated (restricted) permissions. Set
+ *       to -1 or 0 if unused. Provides a way to open BTF objects without full
+ *       CAP_BPF/CAP_SYS_ADMIN in controlled environments.
+ *
+ * Concurrency & races:
+ *   - A BTF object can be unloaded (e.g., module removal) after ID discovery
+ *     but before this call; expect -ENOENT in such races.
+ *   - Successfully obtaining a file descriptor does not guarantee the object
+ *     will remain available for its entire lifetime (it could still be removed
+ *     depending on kernel policies), so subsequent operations may fail.
+ *
+ * Lifetime & ownership:
+ *   - On success you own the returned FD and must close() it when done.
+ *   - Closing the FD does not destroy the BTF object if other references (FDs,
+ *     pinned bpffs entries) remain.
+ *   - You may pin the BTF object via bpf_obj_pin() for persistence.
+ *
+ * Security / privileges:
+ *   - May require CAP_BPF and/or CAP_SYS_ADMIN depending on kernel configuration,
+ *     LSM policy, and lockdown mode.
+ *   - Access via a token_fd is subject to token scope; insufficient rights yield
+ *     -EPERM / -EACCES.
+ *
+ * Use cases:
+ *   - Retrieve type information with bpf_btf_get_info_by_fd().
+ *   - Supply prog_btf_fd when loading eBPF programs needing CO-RE relocations.
+ *   - Enumerate and manage user-loaded or kernel-provided BTF datasets.
+ *
+ * Robustness tips:
+ *   - Treat -ENOENT as a normal race when enumerating dynamic BTF objects.
+ *   - Always zero-initialize opts before setting recognized fields:
+ *       struct bpf_get_fd_by_id_opts o = {};
+ *       o.sz = sizeof(o);
+ *   - Avoid non-zero open_flags until documented; future kernels may add semantic
+ *     modifiers (e.g., restricted viewing modes).
+ *
+ * @param id   Kernel-assigned unique BTF object ID (> 0).
+ * @param opts Optional pointer to struct bpf_get_fd_by_id_opts controlling open
+ *             behavior; may be NULL for defaults.
+ *
+ * @return >= 0: File descriptor referencing the BTF object (caller must close()).
+ *         < 0 : Negative error code (libbpf style == -errno) on failure.
+ *
+ * Error handling (negative return values are libbpf-style == -errno):
+ *   - -ENOENT: No BTF object with @p id (unloaded or never existed).
+ *   - -EINVAL: Invalid @p id (e.g., 0), malformed @p opts (bad sz), or unsupported
+ *              open_flags bits.
+ *   - -EPERM / -EACCES: Insufficient privileges or blocked by security policy.
+ *   - -ENOMEM: Kernel resource allocation failure.
+ *   - Other -errno codes may be propagated from underlying syscall failures.
+ *
+ */
 LIBBPF_API int bpf_btf_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
 /**
@@ -2650,11 +3102,294 @@ struct bpf_raw_tp_opts {
 	size_t :0;
 };
 #define bpf_raw_tp_opts__last_field cookie
-
+/**
+ * @brief Attach a loaded BPF program to a raw tracepoint using extended options.
+ *
+ * bpf_raw_tracepoint_open_opts() wraps the BPF_RAW_TRACEPOINT_OPEN command and
+ * creates a persistent attachment of @p prog_fd to the raw tracepoint named in
+ * @p opts->tp_name. On success it returns a file descriptor representing the
+ * attachment. Closing that FD detaches the program from the tracepoint.
+ *
+ * Compared to bpf_raw_tracepoint_open(), this variant allows passing a user
+ * cookie (opts->cookie) and provides forward/backward compatibility via the
+ * @p opts->sz field.
+ *
+ * Typical usage:
+ *   struct bpf_raw_tp_opts ropts = {
+ *       .sz      = sizeof(ropts),
+ *       .tp_name = "sched_switch",   // raw tracepoint name (no "tracepoint/" prefix)
+ *       .cookie  = 0xdeadbeef,       // optional user cookie (visible to program)
+ *   };
+ *   int tp_fd = bpf_raw_tracepoint_open_opts(prog_fd, &ropts);
+ *   if (tp_fd < 0) {
+ *       // handle error (inspect errno or negative return value)
+ *   }
+ *   // ... use attachment; close(tp_fd) to detach when done.
+ *
+ * Tracepoint name:
+ *   - Use the raw tracepoint identifier as exposed under
+ *     /sys/kernel/debug/tracing/events/ without category prefixes. For raw
+ *     tracepoints this is typically the internal kernel name (e.g., "sched_switch").
+ *   - Passing NULL or an empty string fails with -EINVAL.
+ *
+ * Cookie:
+ *   - opts->cookie (if non-zero) becomes available to the attached program via
+ *     bpf_get_attach_cookie() helper (where supported).
+ *   - Set to 0 if you don't need a cookie; kernel treats it as absent.
+ *
+ * Structure initialization:
+ *   - opts MUST NOT be NULL.
+ *   - Zero-initialize the struct, then set:
+ *       opts->sz      = sizeof(struct bpf_raw_tp_opts);
+ *       opts->tp_name = "<tracepoint_name>";
+ *       opts->cookie  = <optional_cookie>;
+ *   - Unrecognized future fields must remain zero for compatibility.
+ *
+ * Lifetime & detachment:
+ *   - The returned FD solely controls the attachment lifetime. Closing it
+ *     detaches the program.
+ *   - The program FD @p prog_fd may be closed independently after successful
+ *     attachment; the link remains active until the tracepoint FD is closed.
+ *
+ * Concurrency:
+ *   - Multiple programs can attach to the same raw tracepoint (each gets its
+ *     own FD).
+ *   - Attaching/detaching is atomic from the program's perspective; events
+ *     arriving after success will invoke the program.
+ *
+ * Privileges:
+ *   - Typically requires CAP_BPF and/or CAP_SYS_ADMIN depending on kernel
+ *     configuration, LSM policy, and lockdown mode.
+ *
+ * Performance considerations:
+ *   - Raw tracepoints invoke programs on every event occurrence; ensure program
+ *     logic is efficient to avoid noticeable system overhead.
+ *
+ * @param prog_fd
+ *   File descriptor of a previously loaded BPF program (bpf_prog_load()) that
+ *   is compatible with raw tracepoint attachment (e.g., program type
+ *   BPF_PROG_TYPE_RAW_TRACEPOINT or suitable tracing type).
+ *
+ * @param opts
+ *   Pointer to an initialized bpf_raw_tp_opts structure describing the target
+ *   tracepoint and optional cookie. Must not be NULL. opts->sz must equal
+ *   sizeof(struct bpf_raw_tp_opts).
+ *
+ * @return
+ *   >= 0 : File descriptor representing the attachment (close to detach).
+ *   < 0  : Negative libbpf-style error code (== -errno) on failure:
+ *            - -EINVAL   : Bad prog_fd, malformed opts (sz mismatch, NULL tp_name),
+ *                         unsupported program type, or kernel lacks raw TP support.
+ *            - -EPERM/-EACCES : Insufficient privileges or blocked by security policy.
+ *            - -ENOENT   : Tracepoint name not found / not supported by current kernel.
+ *            - -EBADF    : Invalid prog_fd.
+ *            - -ENOMEM   : Kernel memory/resource exhaustion.
+ *            - -EOPNOTSUPP/-ENOTSUP : Raw tracepoint attachment not supported.
+ *            - Other -errno codes may be propagated from the underlying syscall.
+ *
+ * Error handling:
+ *   - Inspect the negative return value or errno for diagnostics.
+ *   - Treat -ENOENT as "tracepoint unavailable" (kernel config or version gap).
+ *
+ * After attachment:
+ *   - Optionally pin the FD (bpf_obj_pin()) if you need persistence.
+ *   - Use bpf_obj_get_info_by_fd() to query attachment metadata if supported.
+ */
 LIBBPF_API int bpf_raw_tracepoint_open_opts(int prog_fd, struct bpf_raw_tp_opts *opts);
 
+/**
+ * @brief Attach a loaded BPF program to a raw tracepoint (legacy/simple API).
+ *
+ * bpf_raw_tracepoint_open() is a convenience wrapper that issues the
+ * BPF_RAW_TRACEPOINT_OPEN command to attach the BPF program referenced
+ * by @p prog_fd to the raw tracepoint named @p name. On success it returns
+ * a file descriptor representing the attachment; closing that FD detaches
+ * the program from the tracepoint.
+ *
+ * Compared to bpf_raw_tracepoint_open_opts(), this legacy interface
+ * provides no ability to specify an attach cookie or future extension
+ * fields. For new code prefer bpf_raw_tracepoint_open_opts() to enable
+ * forward/backward compatible option passing.
+ *
+ * Tracepoint name:
+ *   - @p name must be a non-NULL, null-terminated string identifying a
+ *     raw tracepoint (e.g. "sched_switch").
+ *   - Pass the raw kernel tracepoint identifier without any category
+ *     prefix (do not include "tracepoint/" or directory components).
+ *   - If the tracepoint is not available (kernel config/version) the
+ *     call fails with -ENOENT.
+ *
+ * Program requirements:
+ *   - @p prog_fd must refer to a loaded BPF program of a type compatible
+ *     with raw tracepoint attachment (e.g., BPF_PROG_TYPE_RAW_TRACEPOINT
+ *     or an allowed tracing program type accepted by the kernel).
+ *   - The program may be safely closed after a successful attachment;
+ *     the returned FD controls the lifetime of the link.
+ *
+ * Lifetime & detachment:
+ *   - Each successful call creates a distinct attachment with its own FD.
+ *   - Closing the returned FD immediately detaches the program from the
+ *     tracepoint.
+ *   - The returned FD can be pinned (bpf_obj_pin()) for persistence.
+ *
+ * Concurrency:
+ *   - Multiple programs can be attached to the same raw tracepoint.
+ *   - Attach/detach operations are atomic; events after success invoke
+ *     the program until its FD is closed.
+ *
+ * Privileges & security:
+ *   - Typically requires CAP_BPF and/or CAP_SYS_ADMIN depending on
+ *     kernel configuration, LSM, and lockdown mode.
+ *   - Insufficient privilege yields -EPERM / -EACCES.
+ *
+ * Performance considerations:
+ *   - Raw tracepoints can be very frequent; ensure attached program
+ *     logic is efficient to avoid noticeable overhead.
+ *
+ * @param name    Null-terminated raw tracepoint name (e.g. "sched_switch").
+ * @param prog_fd File descriptor of a loaded, compatible BPF program.
+ *
+ * @return >= 0 : Attachment file descriptor (close to detach).
+ *         < 0  : Negative error code (libbpf style == -errno) on failure.
+ *
+ * Error handling (negative libbpf-style return value == -errno):
+ *   - -EINVAL   : Invalid @p prog_fd, NULL/empty @p name, incompatible program type.
+ *   - -ENOENT   : Tracepoint not found / unsupported by current kernel.
+ *   - -EPERM/-EACCES : Insufficient privileges or blocked by security policy.
+ *   - -EBADF    : @p prog_fd is not a valid file descriptor.
+ *   - -ENOMEM   : Kernel memory/resource exhaustion.
+ *   - -EOPNOTSUPP/-ENOTSUP : Raw tracepoints unsupported by the kernel.
+ *   - Other negative codes may be propagated from the underlying syscall.
+ *
+ * Best practices:
+ *   - Prefer bpf_raw_tracepoint_open_opts() for new development to
+ *     gain cookie support and extensibility.
+ *   - Immediately check the return value; do not rely solely on errno.
+ *   - Pin the attachment if you need persistence across process lifetimes.
+ *
+ */
 LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
 
+/**
+ * @brief Query metadata about a file descriptor in another task (process) that
+ *        is associated with a BPF tracing/perf event and (optionally) an
+ *        attached BPF program.
+ *
+ * This helper wraps the kernel's BPF_TASK_FD_QUERY command. It inspects the
+ * file descriptor number @p fd that belongs to the task identified by @p pid
+ * and, if that FD represents a perf event or similar tracing attachment, it
+ * returns descriptive information about:
+ *   - The attached BPF program (its kernel program ID).
+ *   - The nature/type of the FD (tracepoint, raw_tracepoint, kprobe, uprobe, etc.).
+ *   - Target symbol/address/offset data for kprobe/uprobes.
+ *   - A human-readable identifier (tracepoint name, kprobe function name,
+ *     uprobe file path), copied into @p buf when provided.
+ *
+ * Typical use cases:
+ *   - Introspecting perf event FDs opened by another process to discover
+ *     which BPF program is attached.
+ *   - Enumerating and characterizing dynamically created kprobes or uprobes
+ *     (e.g., by observability agents).
+ *   - Building higher-level tooling that correlates program IDs with their
+ *     originating probe specifications.
+ *
+ * Usage pattern:
+ *   char info[256];
+ *   __u32 info_len = sizeof(info);
+ *   __u32 prog_id = 0, fd_type = 0;
+ *   __u64 probe_off = 0, probe_addr = 0;
+ *   int err = bpf_task_fd_query(target_pid, target_fd, 0,
+ *                               info, &info_len,
+ *                               &prog_id, &fd_type,
+ *                               &probe_off, &probe_addr);
+ *   if (err == 0) {
+ *       // info[] now holds a NUL-terminated identifier (if available)
+ *       // info_len == actual length (including terminating '\0')
+ *       // fd_type enumerates one of BPF_FD_TYPE_* values
+ *       // prog_id is the kernel-assigned BPF program ID (0 if none)
+ *       // probe_off / probe_addr describe offsets/addresses for kprobe/uprobe
+ *   } else if (err == -ENOSPC) {
+ *       // info_len contains required size; allocate larger buffer and retry
+ *   }
+ *
+ * Buffer semantics (@p buf / @p buf_len):
+ *   - On input @p *buf_len must hold the capacity (in bytes) of @p buf.
+ *   - If @p buf is large enough, the kernel copies a NUL-terminated string
+ *     (tracepoint name, kprobe symbol, uprobe path, etc.) and updates
+ *     @p *buf_len with the actual string length (including the NUL).
+ *   - If @p buf is too small, the call fails with -ENOSPC and sets
+ *     @p *buf_len to the required length; reallocate and retry.
+ *   - If a textual identifier is not applicable (or unavailable), the kernel
+ *     may set @p *buf_len to 0 (and leave @p buf untouched).
+ *   - Passing @p buf == NULL is allowed only if @p buf_len is non-NULL and
+ *     points to 0; otherwise -EINVAL is returned.
+ *
+ * Output parameters:
+ *   - @p prog_id: Set to the kernel BPF program ID attached to the perf event
+ *     FD (0 if no BPF program is attached).
+ *   - @p fd_type: Set to one of the BPF_FD_TYPE_* enum values describing the
+ *     FD (e.g., BPF_FD_TYPE_TRACEPOINT, BPF_FD_TYPE_KPROBE, BPF_FD_TYPE_UPROBE,
+ *     BPF_FD_TYPE_RAW_TRACEPOINT). Use this to disambiguate interpretation of
+ *     other outputs.
+ *   - @p probe_offset: For kprobe/uprobes, the offset within the symbol or
+ *     mapped file that was requested when the probe was created.
+ *   - @p probe_addr: For kprobes, the resolved kernel address of the probed
+ *     symbol/instruction; for uprobes may be 0 or implementation-dependent.
+ *   - Any output pointer may be NULL if the caller is not interested in that
+ *     field (it will simply be skipped).
+ *
+ * Privileges & access control:
+ *   - Querying another task's file descriptor typically requires sufficient
+ *     permissions (ptrace-like restrictions, CAP_BPF / CAP_SYS_ADMIN, and/or
+ *     LSM allowances). Lack of privilege yields -EPERM / -EACCES.
+ *   - The target task must exist and the FD must be valid at query time.
+ *
+ * Concurrency / races:
+ *   - The target process may close or replace its FD concurrently; the query
+ *     can fail with -EBADF or -ENOENT in such races.
+ *   - Retrieved metadata is a point-in-time snapshot and can become stale
+ *     immediately after return.
+ *
+ * @param pid          PID of the target task whose file descriptor table should be queried.
+ *                     Use the numeric PID (thread group leader or specific thread PID);
+ *                     passing 0 is typically invalid (returns -EINVAL).
+ * @param fd           File descriptor number as seen from inside the task identified by @p pid.
+ * @param flags        Query modifier flags. Must be 0 on current kernels; non-zero
+ *                     (unsupported) bits return -EINVAL.
+ * @param buf          Optional user buffer to receive a NUL-terminated identifier string
+ *                     (tracepoint name, kprobe symbol, uprobe path). Can be NULL if
+ *                     @p buf_len points to 0.
+ * @param buf_len      In/out pointer to buffer length. On input: capacity of @p buf.
+ *                     On success: actual length copied (including terminating NUL).
+ *                     On -ENOSPC: required length (caller should reallocate and retry).
+ * @param prog_id      Optional output pointer receiving the attached BPF program ID (0 if none).
+ * @param fd_type      Optional output pointer receiving one of BPF_FD_TYPE_* constants identifying FD type.
+ * @param probe_offset Optional output pointer receiving the probe offset (for kprobe/uprobe types).
+ * @param probe_addr   Optional output pointer receiving resolved kernel address (kprobe) or relevant mapping address.
+ *
+ * @return 0 on success;
+ *         Negative libbpf-style error code (< 0) on failure:
+ *           - -EINVAL  : Invalid arguments (bad pid/fd, unsupported flags, inconsistent buf/buf_len).
+ *           - -ENOENT  : Task, file descriptor, or associated probe/program not found.
+ *           - -EBADF   : Bad file descriptor in target task at time of query.
+ *           - -ENOSPC  : @p buf too small; @p *buf_len updated with required size.
+ *           - -EPERM / -EACCES : Insufficient privileges or access denied by security policy.
+ *           - -EFAULT  : User memory (buf or buf_len or an output pointer) not accessible.
+ *           - -ENOMEM  : Temporary kernel memory/resource exhaustion.
+ *           - Other -errno codes may be propagated from the underlying syscall.
+ *
+ * Best practices:
+ *   - Initialize *buf_len with the size of your buffer; handle -ENOSPC by allocating
+ *     a larger buffer using the returned required length.
+ *   - Check @p fd_type first to interpret @p probe_offset / @p probe_addr meaningfully.
+ *   - Treat -ENOENT and -EBADF as normal race outcomes in dynamic environments.
+ *   - Avoid querying extremely frequently in production paths; this is introspective
+ *     debug/management tooling, not a fast data path primitive.
+ *
+ * Thread safety:
+ *   - This helper is thread-safe; multiple threads can query different (or the same)
+ *     tasks concurrently. Returned data structures are per-call (no shared state).
+ */
 LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
 				 __u64 *probe_offset, __u64 *probe_addr);
-- 
2.34.1


