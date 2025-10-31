Return-Path: <bpf+bounces-73114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 630D6C23A29
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 424BA4F05B5
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE5432A3FE;
	Fri, 31 Oct 2025 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej94qFTg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB3328B70
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897598; cv=none; b=XQImSp0iSFkytf3FqEK5e7GGErWECGoN8hsDVQjcHN5KNIzdfrX0DS+ntxXiZ/ZTz8h0SdnNpxJFdp3kWLrfm+yY6yosI4rERptCWXnG4VKUSkMNdb0FKW82hd37SPcDJnbwN+pUllD7Xe+XPwYFfMv1Yop8RPNiOVtn0SqqZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897598; c=relaxed/simple;
	bh=W/RNd09jH5me9bf0kPlfjjSDODbnHc9ViAcrgWeECzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8IQz1fuWrcOQAgW5UYBgrodoFrMYr/8lYZQs3vdAAiv7NIwZRDT9A3TZrKCTgmLn5OM9ZfbI1rG7nT8cZDtwm5CVKbo7K9dCJvyTNQPykoQgnnsUOPDUpxe08sEahaxk9ZyLr24FKpJhLoKCgcOYl1gUjxYzJ57VzrFpX0uLQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej94qFTg; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso2044569b3a.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761897595; x=1762502395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEDxYB3NbhXbLQBKmdkOBhSE/MmzDxmJF2zUVWvC4W8=;
        b=Ej94qFTg/w9pB/ZtuqFs+l6M4zfeFJIJCXDaH3UnN0IGvzf47/GWBDwNXczs/kZX+D
         3i2izy/Lxhgd76Cm2Rn63qo7mD4fqu++UB64qYVlubsrieNjZ36F9pMEzzqc1g9j89j1
         h1vHIuDf87VAg5xGrdfozRKj1oyPclSyKv9WyoOkkX0d9DwkLK0TwvLB4nlgkmrDqN8m
         LmoOmixYVWcVd2+7BYBcmnquZU935Qt1k2XJPHM7riTfTNfJNqfQjN7Z+r5mMJJ4l7ZZ
         DfI0SSAzIyxBLo4fI9VTKwJ0AH6m9+ImleFtWUA9VzkIJ2isIvCg8l690f/J+Z0ZMDNb
         35zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897595; x=1762502395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEDxYB3NbhXbLQBKmdkOBhSE/MmzDxmJF2zUVWvC4W8=;
        b=Z3dTDbKpXnpXOnXNxVoZu67bl5IS24TJqLJA/2cD/NiXNxagkt/6kKaaPKMFSCvgDI
         ZJhI971nGWgS4bfgzikFGZ40LNTpZ0WrPhZsN46DJ7iO8tjJ3EPiep8r/1lUlkpGIhV+
         gTSnrERzZOpKeC4sYNIf386XD8L8jdsuUj6jVmXPeIXpkV9JLYsmPEn+wRwO82qGfY5L
         bzyZtCYrIU6oJkaX+YnIH0RY2VxpbMD9ktxC4+0NkfbBK2hIxTCPUO/tZ3YavdCwZjeC
         Hl887NGrs/XtbqLaa8/MrcbJfjzNHtfl2mGiCI/jeNKlLKJjWhLoQpHj+55fhVrjdTyv
         39VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV60yMTXPMhFTrkcg3w3Lozd9ovfp6eJo69ehh8rWcN1EqhQCIbOkH/BA/TvKr6eQ3ZiMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAD0OmQ4UIi8/AV3BxVUXIBYWvtt+Tty/vKnKn20UkeksufIEY
	tGbGeirn5OWUyKzaNYEJqmTrU9TpVHa8hvztKs38HQKGYul1+b9whdpt
X-Gm-Gg: ASbGnctNrOgVaXA3LzQQlgqg0VLQ1QsjGTB3WqBAfHOTbyLE+RGVr9GM0bHBXYCNgYH
	ymiLWlScHrxKzp6Us8bWj5o64InJKrRjs0Yq3rUMuKi2VJrkkJ8x7AgbTUjYvH/aH3MRTwvJavf
	KeFOSIyaDyynNGDpEPOED1YElCvaCoA+Hb8fMng0TfXse7NBQSYUJaxJ5x4gfpQuKe3T1fyDyr2
	8Y3tEK9Klbly/VtU5Le7sjbMD9jl2tz4g9ZBB6Bd9bglWzNlM/RWTQFBRq3CcELld3hfgk6pdUl
	3Nvs/NnFvw1EHMeNIRZYfNDnWn8UbVY+aSqd3OYti/uK/bOaqNT2K7gXB+QWJiE2msggrn5exOZ
	uAS29VYbIbR520pIrheyM/W1AMI18A+xl0+co77JbYlZ8xvT2yFnzVfYOihztw/5QXnDJPQMrCm
	eKdGnOHHwVC+bqowPGEA==
X-Google-Smtp-Source: AGHT+IEwzd/fCoh42agXKCWbNtScc/vcJggdFNwNhuE6cmGlHfU/+/mepMN1f5UQG20G4W2+QDI+4g==
X-Received: by 2002:a05:6a20:7290:b0:344:a607:5548 with SMTP id adf61e73a8af0-348cde0a4e6mr4184291637.58.1761897595159;
        Fri, 31 Oct 2025 00:59:55 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4045fbsm1216575a12.28.2025.10.31.00.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:59:54 -0700 (PDT)
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
Subject: [PATCH v2 1/5] libbpf: Add doxygen documentation for bpf_map_* APIs in bpf.h
Date: Fri, 31 Oct 2025 15:59:03 +0800
Message-Id: <20251031075908.1472249-2-jianyungao89@gmail.com>
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

Add doxygen comment blocks for all public bpf_map_* APIs in
tools/lib/bpf/bpf.h. These doc comments are for:

-bpf_map_create()
-bpf_map_update_elem()
-bpf_map_lookup_elem()
-bpf_map_lookup_elem_flags()
-bpf_map_lookup_and_delete_elem()
-bpf_map_lookup_and_delete_elem_flags()
-bpf_map_delete_elem()
-bpf_map_delete_elem_flags()
-bpf_map_get_next_key()
-bpf_map_freeze()
-bpf_map_get_next_id()
-bpf_map_get_fd_by_id()
-bpf_map_get_fd_by_id_opts()

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v1->v2:
 - Refined bpf_map_* return value docs: explicit non-negative success
   vs negative -errno failures.
 - Fixed the non-ASCII characters in this patch.

The v1 is here:
https://lore.kernel.org/lkml/20251031032627.1414462-2-jianyungao89@gmail.com/

 tools/lib/bpf/bpf.h | 647 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 647 insertions(+)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e983a3e40d61..35372c0790ee 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -61,6 +61,57 @@ struct bpf_map_create_opts {
 };
 #define bpf_map_create_opts__last_field excl_prog_hash_size
 
+/**
+ * @brief Create a new BPF map.
+ *
+ * This helper wraps the kernel's BPF_MAP_CREATE command and returns a file
+ * descriptor referring to the newly created map. The map's behavior (e.g.
+ * key/value semantics, lookup/update constraints) is determined by its
+ * type and various size parameters.
+ *
+ * @param map_type
+ *        Map type (enum bpf_map_type) selecting the kernel map implementation
+ *        (e.g. BPF_MAP_TYPE_HASH, ARRAY, LRU_HASH, PERCPU_ARRAY, etc.).
+ *
+ * @param map_name
+ *        Optional human-readable name (null-terminated). May appear in
+ *        bpftool output and used for pinning; can be NULL for unnamed maps.
+ *        Must not exceed the kernel's NAME_MAX for BPF objects.
+ *
+ * @param key_size
+ *        Size (in bytes) of a single key. For some map types this must match
+ *        kernel expectations (e.g. prog array uses sizeof(int)). Must be > 0.
+ *
+ * @param value_size
+ *        Size (in bytes) of a single value. Some map types have specific or
+ *        implicit value sizes (e.g. perf event array); still pass the
+ *        required size. Must be > 0 unless the map type defines otherwise.
+ *
+ * @param max_entries
+ *        Maximum number of key/value pairs (capacity). For certain map types
+ *        (e.g. ring buffer, stack, queue) semantics differ but this field is
+ *        still used. Must be > 0 except for types that ignore it.
+ *
+ * @param opts
+ *        Optional pointer to bpf_map_create_opts providing extended creation
+ *        parameters. Pass NULL for defaults. Common fields include:
+ *          - .map_flags: Additional BPF map flags (e.g. BPF_F_NO_PREALLOC).
+ *          - .numa_node: Prefer allocation on specified NUMA node.
+ *          - .btf_fd / .btf_key_type_id / .btf_value_type_id: Associate BTF
+ *            types for verification and introspection.
+ *          - .inner_map_fd: For map-in-map types (array_of_maps / hash_of_maps).
+ *          - .map_ifindex: Bind map to a network interface when supported.
+ *          - .map_extra: Reserved/experimental extensions (depends on kernel).
+ *        Not all fields may be available in older libbpf versions; zero-init
+ *        the struct and set only known fields.
+ *
+ * @return
+ *        >= 0: File descriptor of the created map (caller owns it and should
+ *              close() when no longer needed).
+ *        < 0 : Negative error code (libbpf style, typically -errno). Detailed
+ *              reason can be inferred from -ret or examined via errno (if
+ *              converted) / libbpf logging.
+ */
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
 			      __u32 key_size,
@@ -151,19 +202,457 @@ struct bpf_btf_load_opts {
 LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
 			    struct bpf_btf_load_opts *opts);
 
+/**
+ * @brief Update or insert an element in a BPF map.
+ *
+ * Attempts to store the value referenced by @p value into the BPF map
+ * identified by @p fd under the key referenced by @p key. The semantics
+ * of the operation are controlled by @p flags:
+ *
+ *   - BPF_ANY:     Create a new element or update an existing one.
+ *   - BPF_NOEXIST: Create a new element only; fail if the key already exists (errno = EEXIST).
+ *   - BPF_EXIST:   Update an existing element only; fail if the key does not exist (errno = ENOENT).
+ *   - (Optional) BPF_F_LOCK: If supported by the map type, perform a lock-based update
+ *                            (mainly for certain per-cpu map types).
+ *
+ * The memory pointed to by @p key and @p value must be at least the size of the map's
+ * key and value definitions respectively, and properly aligned for the target architecture.
+ * Callers typically place key/value objects on the stack or in static storage; the kernel
+ * copies their contents during the call, so they need not remain valid after the function
+ * returns.
+ *
+ * Concurrency: For most map types, updates are atomic with respect to lookups and other
+ * updates. For per-CPU maps, the update affects the current CPU's copy (unless a flag
+ * or map type enforces different behavior). Locking flags (e.g., BPF_F_LOCK) may be
+ * required for certain map types to ensure consistent read-modify-write sequences.
+ *
+ * Privileges: Some map updates may require CAP_SYS_ADMIN or CAP_BPF depending on the
+ * map type and system configuration (e.g., locked down environments or LSM policies).
+ *
+ * @param fd     File descriptor referring to the opened BPF map.
+ * @param key    Pointer to the key data to be inserted/updated.
+ * @param value  Pointer to the value data to be stored for the key.
+ * @param flags  Operation control flags (see above).
+ *
+ * @return 0 on success; negative error code, otherwise (errno is also set to
+ * the error code).
+ *
+ * Possible errno values include (not exhaustive):
+ *   - E2BIG:      Key or value size exceeds map definition.
+ *   - EINVAL:     Invalid map fd, flags, or unsupported operation for map type.
+ *   - EBADF:      @p fd is not a valid BPF map descriptor.
+ *   - ENOENT:     Key does not exist (with BPF_EXIST).
+ *   - EEXIST:     Key already exists (with BPF_NOEXIST).
+ *   - ENOMEM:     Kernel memory allocation failure.
+ *   - EPERM/EACCES: Insufficient privileges or rejected by security policy.
+ *   - ENOSPC:     Map at capacity (for maps with a max entries limit).
+ *
+ */
 LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
 				   __u64 flags);
 
+/**
+ * @brief Look up an element in a BPF map by key.
+ *
+ * Retrieves the value associated with the specified key from a BPF map
+ * identified by its file descriptor. The caller must supply a pointer to
+ * a key of the map's key size, and a writable buffer large enough to hold
+ * the map's value size. On success, the value buffer is filled with the
+ * data stored in the map.
+ *
+ * This is a blocking system call that wraps the BPF_MAP_LOOKUP_ELEM
+ * command. It may incur a context switch and can fail for a variety of
+ * reasons, including transient kernel conditions.
+ *
+ * @param fd   File descriptor of an open BPF map (obtained via bpf_obj_get(),
+ *             bpf_map_create(), or via loading an object file).
+ * @param key  Pointer to a buffer containing the key to look up. The buffer
+ *             must be exactly the size of the map's key type.
+ * @param value Pointer to a buffer where the map's value will be copied on
+ *             success. Must be at least the size of the map's value type.
+ *
+ * @return 0 on success (value populated); negative error code, otherwise
+ * (errno is also set to the error code):
+ *         - ENOENT: The key does not exist in the map.
+ *         - EINVAL: Invalid parameters (e.g., wrong sizes or bad map type).
+ *         - EPERM / EACCES: Insufficient privileges (e.g., missing CAP_BPF or
+ *           related capability).
+ *         - EBADF: Invalid map file descriptor.
+ *         - ENOMEM: Kernel could not allocate required memory.
+ *         - EFAULT: key or value points to invalid user memory.
+ *
+ */
 LIBBPF_API int bpf_map_lookup_elem(int fd, const void *key, void *value);
+
+/**
+ * @brief Look up (read) a value stored in a BPF map.
+ *
+ * This is a thin libbpf wrapper around the BPF_MAP_LOOKUP_ELEM command of the
+ * bpf(2) system call. It retrieves the value associated with the provided key
+ * from the map referred to by fd.
+ *
+ * The caller must supply storage for both the key and the value. On success
+ * the memory pointed to by value is filled with the map element's data.
+ *
+ * Concurrency semantics depend on the map type. For maps whose values contain
+ * a bpf_spin_lock (e.g. certain HASH or ARRAY-like map types), you may pass
+ * the BPF_F_LOCK flag in flags to request that the kernel return the value
+ * while holding the spin lock, guaranteeing a consistent snapshot for complex
+ * composite data. The lock is released immediately after copying the value
+ * out to user space. Pass 0 for default (unlocked) lookup semantics.
+ *
+ * Note: Only flags supported by the running kernel (currently BPF_F_LOCK) are
+ * valid; unsupported flags will cause the lookup to fail with EINVAL.
+ *
+ * Key requirements:
+ *  - For array-like maps (e.g., BPF_MAP_TYPE_ARRAY, PERCPU_ARRAY), key points
+ *    to an integer index.
+ *  - For hash-like maps, key points to a full key of the map's declared key
+ *    size.
+ *
+ * Value requirements:
+ *  - value must point to a buffer at least as large as the map's value size
+ *    (use bpf_obj_get_info_by_fd() or bpf_map__value_size() helpers to query
+ *    this).
+ *
+ * @param fd     File descriptor of the BPF map obtained via bpf_create_map(),
+ *               bpf_obj_get(), or a libbpf helper.
+ * @param key    Pointer to the key (or index) identifying the element to read.
+ *               Must not be nullptr.
+ * @param value  Pointer to caller-allocated buffer that receives the value on
+ *               success. Must not be nullptr.
+ * @param flags  Bitmask of lookup flags. Use 0 for a normal lookup. Specify
+ *               BPF_F_LOCK (if supported) to perform a locked read of values
+ *               containing a bpf_spin_lock.
+ *
+ * @return 0 on success; negative error code, otherwise
+ * (errno is also set to the error code):
+ *         - ENOENT: No element with the specified key exists.
+ *         - EINVAL: Invalid arguments (bad flags, key/value pointers, or map type).
+ *         - EPERM / EACCES: Insufficient privileges (e.g., map access restrictions).
+ *         - EBADF: Invalid map file descriptor.
+ *         - EFAULT: key or value points to unreadable/writable memory.
+ *         - E2BIG: Key size does not match the map's declared key size.
+ *         - Other standard Linux errors depending on map type and kernel.
+ *
+ */
 LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *value,
 					 __u64 flags);
+/**
+ * @brief Atomically look up and delete a single element from a BPF map.
+ *
+ * Performs a combined "lookup-and-delete" operation for the element
+ * identified by the key pointed to by @p key in the map referred to by
+ * @p fd. If the key exists, its value is copied into the user-provided
+ * @p value buffer (if non-null) and the element is removed from the map
+ * as one atomic kernel operation, preventing races between a separate
+ * lookup and delete sequence.
+ *
+ * Supported map types are those for which the kernel implements
+ * BPF_MAP_LOOKUP_AND_DELETE_ELEM (e.g., queue/stack-like maps and
+ * certain hash variants). On unsupported map types the call fails.
+ *
+ * Concurrency:
+ *  - The lookup and deletion are performed atomically with respect to
+ *    other map operations on the same key, avoiding TOCTOU races.
+ *  - For per-CPU maps (where applicable) the deletion affects only the
+ *    current CPU's instance unless the map semantics dictate otherwise.
+ *
+ * Memory requirements:
+ *  - @p key must point to a buffer exactly equal to the declared key
+ *    size of the map.
+ *  - @p value must point to a buffer at least as large as the map's
+ *    value size. If @p value is NULL, no value is copied; the element
+ *    is still deleted (kernel may return EFAULT on older kernels that
+ *    require a non-null value pointer).
+ *
+ * Privileges:
+ *  - May require CAP_BPF or CAP_SYS_ADMIN depending on kernel
+ *    configuration, LSM policies, or lockdown state.
+ *
+ * @param fd     File descriptor of an open BPF map.
+ * @param key    Pointer to the key identifying the element to remove.
+ * @param value  Pointer to caller-allocated buffer that receives the
+ *               value prior to deletion (can be NULL on kernels that
+ *               allow skipping value copy).
+ *
+ * @return 0 on success (value copied and element deleted); negative error
+ * code, otherwise (errno is also set to the error code):
+ *         - ENOENT: Key not found in the map.
+ *         - EINVAL: Invalid arguments (bad key pointer/size, unsupported map type).
+ *         - EOPNOTSUPP: Operation not supported for this map type.
+ *         - EBADF: @p fd is not a valid BPF map descriptor.
+ *         - EFAULT: key/value points to inaccessible user memory.
+ *         - EPERM / EACCES: Insufficient privileges.
+ *         - ENOMEM: Kernel failed to allocate temporary resources.
+ *
+ */
 LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
 					      void *value);
+/**
+ * @brief Atomically look up and delete an element from a BPF map with extra flags.
+ *
+ * This is a flags-capable variant of bpf_map_lookup_and_delete_elem(). It performs
+ * a single atomic kernel operation that (optionally) retrieves the value associated
+ * with the specified key and then deletes the element from the map. The additional
+ * @p flags parameter allows requesting special semantics if supported by the map
+ * type and kernel (e.g., locked access with BPF_F_LOCK when the map value embeds
+ * a bpf_spin_lock).
+ *
+ * Semantics:
+ *   - If the key exists:
+ *       * Its value is copied into the user-provided @p value buffer (if non-NULL).
+ *       * The element is removed from the map.
+ *   - If the key does not exist: fails with errno = ENOENT, no deletion performed.
+ *
+ * Atomicity:
+ *   The lookup and deletion occur as one kernel operation, eliminating race
+ *   windows that would exist if lookup and delete were performed separately.
+ *
+ * Flags (@p flags):
+ *   - 0: Perform a normal atomic lookup-and-delete.
+ *   - BPF_F_LOCK: If supported and the map value contains a bpf_spin_lock, the
+ *                 kernel acquires the spin lock during value retrieval ensuring
+ *                 a consistent snapshot, then releases it prior to returning.
+ *   - Other bits: Must be zero unless future kernels introduce new semantics;
+ *                 unsupported flags yield -1 with errno = EINVAL.
+ *
+ * Memory requirements:
+ *   - @p key must point to a buffer exactly the size of the map's key.
+ *   - @p value must point to a buffer at least the size of the map's value if
+ *     non-NULL. Passing NULL skips value copy (if supported by the running kernel).
+ *
+ * Supported map types:
+ *   Only those implementing BPF_MAP_LOOKUP_AND_DELETE_ELEM (e.g., queue, stack,
+ *   certain hash variants). Unsupported types fail with errno = EOPNOTSUPP.
+ *
+ * Privileges:
+ *   May require CAP_BPF or CAP_SYS_ADMIN depending on kernel configuration,
+ *   lockdown mode, or LSM policies.
+ *
+ * Concurrency:
+ *   - The operation is atomic with respect to other concurrent updates,
+ *     lookups, or deletions of the same key.
+ *   - For per-CPU maps, semantics follow the underlying map implementation
+ *     (typically deleting from the calling CPU's instance).
+ *
+ * @param fd     File descriptor of an open BPF map.
+ * @param key    Pointer to the key identifying the element to consume.
+ * @param value  Optional pointer to a buffer receiving the element's value prior
+ *               to deletion. Can be NULL to skip retrieval (subject to kernel support).
+ * @param flags  Bitmask controlling lookup/delete behavior (see above).
+ *
+ * @return 0 on success; negative error code, otherwise
+ * (errno is also set to the error code):
+ *         - ENOENT: Key not found.
+ *         - EINVAL: Bad arguments, unsupported flags, or mismatched key size.
+ *         - EOPNOTSUPP: Operation not supported for this map type.
+ *         - EBADF: Invalid map file descriptor.
+ *         - EFAULT: key/value points to inaccessible user memory.
+ *         - EPERM / EACCES: Insufficient privileges / denied by security policy.
+ *         - ENOMEM: Temporary kernel allocation failure.
+ *
+ */
 LIBBPF_API int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key,
 						    void *value, __u64 flags);
+/**
+ * @brief Delete (remove) a single element from a BPF map.
+ *
+ * Issues the BPF_MAP_DELETE_ELEM command for the map referenced by @p fd,
+ * removing the element identified by the key pointed to by @p key. This
+ * helper is the simplest deletion API and does not support any additional
+ * deletion or locking flags. For flag-capable deletion semantics (e.g.,
+ * locked delete of spin_lock-embedded values) use bpf_map_delete_elem_flags().
+ *
+ * Semantics:
+ *   - If an element with the specified key exists, it is atomically removed.
+ *   - If the key is absent, the call fails with errno = ENOENT.
+ *   - No value is returned; if you need to retrieve and consume an element,
+ *     use bpf_map_lookup_and_delete_elem() (or its flags variant).
+ *
+ * Concurrency:
+ *   - Deletion is atomic with respect to concurrent lookups and updates of
+ *     the same key.
+ *   - Ordering relative to other operations is map-type dependent; no
+ *     global ordering guarantees are provided beyond atomicity for the key.
+ *
+ * Key requirements:
+ *   - @p key must point to a buffer exactly equal in size to the map's
+ *     declared key size. Supplying a buffer of incorrect size or alignment
+ *     can lead to EINVAL or EFAULT.
+ *
+ * Privileges:
+ *   - May require CAP_BPF, CAP_SYS_ADMIN, or be restricted by LSM or
+ *     lockdown policies depending on system configuration and map type.
+ *
+ * Error handling (errno set on failure):
+ *   - ENOENT: Key not found in the map.
+ *   - EINVAL: Invalid map fd, bad key size, or operation unsupported for map type.
+ *   - EBADF:  @p fd is not a valid (open) BPF map descriptor.
+ *   - EFAULT: @p key points to unreadable user memory.
+ *   - EPERM / EACCES: Insufficient privileges or blocked by security policy.
+ *   - ENOMEM: Transient kernel memory/resource exhaustion (rare).
+ *
+ * @param fd  File descriptor of an open BPF map.
+ * @param key Pointer to a buffer containing the key to delete; must not be NULL.
+ *
+ * @return 0 on success; negative error code, otherwise
+ * (errno is also set to the error code).
+ *
+ */
 LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
+/**
+ * @brief Delete an element from a BPF map with optional flags.
+ *
+ * This is a flags-capable variant of bpf_map_delete_elem(). It issues the
+ * BPF_MAP_DELETE_ELEM command to remove the element identified by the key
+ * pointed to by @p key from the map referenced by @p fd. Unlike the plain
+ * variant, this helper allows passing lookup/delete control flags in @p flags.
+ *
+ * Typical usage mirrors bpf_map_delete_elem(), but if the map's value type
+ * embeds a bpf_spin_lock (and the kernel supports locked delete semantics),
+ * you may specify BPF_F_LOCK in @p flags to request the kernel to take the
+ * spin lock while performing the deletion, ensuring consistent removal for
+ * composite values that might otherwise require user space synchronization.
+ *
+ * Semantics:
+ *   - If the key exists, the element is removed.
+ *   - If the key does not exist, the call fails with errno = ENOENT.
+ *   - No value is returned; for consume-and-retrieve use
+ *     bpf_map_lookup_and_delete_elem() or
+ *     bpf_map_lookup_and_delete_elem_flags().
+ *
+ * Flags (@p flags):
+ *   - 0: Perform a normal deletion.
+ *   - BPF_F_LOCK: (If supported) acquire/release map value's spin lock around
+ *     delete operation. Ignored or rejected if unsupported for the map type.
+ *   - Unsupported bits cause failure with errno = EINVAL.
+ *
+ * Concurrency:
+ *   - Deletion is atomic with respect to concurrent lookups/updates of the
+ *     same key.
+ *   - For per-CPU map types, semantics follow underlying implementation
+ *     (only current CPU's instance is affected where applicable).
+ *
+ * Privileges:
+ *   - May require CAP_BPF or CAP_SYS_ADMIN depending on kernel configuration,
+ *     system lockdown mode, or LSM policies.
+ *
+ * @param fd     File descriptor of an open BPF map.
+ * @param key    Pointer to a buffer containing the key to delete. Must be
+ *               exactly the size of the map's key type.
+ * @param flags  Deletion control flags (see above). Use 0 for default behavior.
+ *
+ * @return 0 on success; negative error code, otherwise
+ * (errno is also set to the error code):
+ *         - ENOENT: Key not found.
+ *         - EINVAL: Invalid arguments, unsupported flags, or wrong key size.
+ *         - EBADF:  @p fd is not a valid BPF map descriptor.
+ *         - EFAULT: @p key points to inaccessible user memory.
+ *         - EPERM / EACCES: Insufficient privileges or denied by security policy.
+ *         - ENOMEM: Temporary kernel resource allocation failure.
+ *
+ */
 LIBBPF_API int bpf_map_delete_elem_flags(int fd, const void *key, __u64 flags);
+/**
+ * @brief Iterate over keys in a BPF map by retrieving the key that follows a given key.
+ *
+ * This helper wraps the BPF_MAP_GET_NEXT_KEY command. It copies into @p next_key
+ * the key that lexicographically (or implementation-defined order) follows @p key
+ * in the map referenced by @p fd. It is typically used to enumerate all keys in
+ * a map from user space.
+ *
+ * Iteration pattern:
+ *   1. Pass NULL as @p key to retrieve the first key in the map.
+ *   2. On each successful call, use the returned @p next_key as the @p key input
+ *      for the subsequent call to advance the iteration.
+ *   3. When there are no more keys, the call fails with errno = ENOENT and
+ *      iteration is complete.
+ *
+ * Concurrency:
+ *   - The order of enumeration is not guaranteed to be stable across concurrent
+ *     inserts/deletes. Keys added or removed during iteration may or may not be
+ *     observed.
+ *   - For hash-like maps, ordering is implementation-dependent (hash bucket
+ *     traversal). For array-like maps (ARRAY/PERCPU_ARRAY), "next" corresponds
+ *     to the next valid index.
+ *
+ * Memory requirements:
+ *   - @p key (if non-NULL) must point to a buffer exactly the size of the map's
+ *     key type.
+ *   - @p next_key must point to a writable buffer at least the size of the map's
+ *     key type.
+ *
+ * Privileges:
+ *   - Access may require CAP_BPF or CAP_SYS_ADMIN depending on system lockdown
+ *     mode, LSM policy, or map type.
+ *
+ * @param fd       File descriptor of an open BPF map.
+ * @param key      Pointer to the current key; NULL to start iteration from the first key.
+ * @param next_key Pointer to a buffer that receives the next key on success.
+ *
+ * @return 0 on success (next key stored in @p next_key); negative error code, otherwise
+ * (errno is also set to the error code):
+ *           - ENOENT: No further keys (end of iteration) or map is empty (when @p key is NULL).
+ *           - EINVAL: Invalid arguments (bad fd, wrong key size, unsupported map type).
+ *           - EBADF:  @p fd is not a valid BPF map descriptor.
+ *           - EFAULT: @p key or @p next_key points to inaccessible user memory.
+ *           - EPERM / EACCES: Insufficient privileges or access denied by security policy.
+ *
+ */
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
+/**
+ * @brief Mark a BPF map as frozen (read-only for any future user space modifications).
+ *
+ * Invokes the kernel's BPF_MAP_FREEZE command on the map referred to by @p fd.
+ * Once a map is successfully frozen:
+ *   - User space can still perform lookups (bpf_map_lookup_elem*(), batch lookups, etc.).
+ *   - All further update, delete, and batch mutation operations from user space
+ *     will fail (typically with EPERM).
+ *   - Freezing is irreversible for the lifetime of the map.
+ *
+ * Typical use cases:
+ *   - Finalizing initialization data (e.g., config arrays or constant maps)
+ *     before exposing the map to untrusted code or other processes.
+ *   - Enforcing write-once semantics to ensure stronger safety guarantees.
+ *   - Preventing accidental or malicious runtime mutation of maps that should
+ *     remain constant after setup.
+ *
+ * Semantics & scope:
+ *   - The freeze applies system-wide to the map object, not just to the calling
+ *     process.
+ *   - BPF programs' ability to modify the map after freezing depends on kernel
+ *     semantics: for most map types, freezing blocks user space mutations only.
+ *     (Do not rely on program write restrictions unless explicitly documented
+ *     for a specific kernel/map type.)
+ *   - Re-freezing an already frozen map succeeds (idempotent) or may return
+ *     an error depending on kernel version; treat a second freeze as a no-op.
+ *
+ * Privileges:
+ *   - Typically requires CAP_BPF or CAP_SYS_ADMIN (depending on kernel
+ *     configuration, LSM, and lockdown state).
+ *
+ * @param fd File descriptor of an open BPF map to freeze.
+ *
+ * @return 0 on success; negative libbpf-style error code (< 0) on failure.
+ *
+ * Possible errors (returned as -errno style negatives):
+ *   - -EBADF: @p fd is not a valid file descriptor.
+ *   - -EINVAL: @p fd is not a BPF map, or map type is not freezable.
+ *   - -EPERM / -EACCES: Insufficient privileges or blocked by security policy.
+ *   - -EOPNOTSUPP: Kernel doesn't support BPF_MAP_FREEZE.
+ *   - -ENOMEM: Temporary resource allocation failure inside the kernel.
+ *
+ * Thread safety:
+ *   - Safe to call concurrently; only the first successful call transitions
+ *     the map into the frozen state.
+ *
+ * After freezing:
+ *   - Continue using lookup APIs to read data.
+ *   - Avoid calling mutation APIs (update/delete) unless prepared to handle
+ *     expected failures.
+ *
+ */
 LIBBPF_API int bpf_map_freeze(int fd);
 
 struct bpf_map_batch_opts {
@@ -488,6 +977,53 @@ struct bpf_prog_test_run_attr {
 };
 
 LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
+/**
+ * @brief Retrieve the next existing BPF map ID after a given starting ID.
+ *
+ * This helper enumerates system-wide BPF map IDs in ascending order. It wraps
+ * the kernel's BPF_OBJ_GET_NEXT_ID command restricted to BPF maps.
+ *
+ * Enumeration pattern:
+ *   1. Initialize start_id to 0 to obtain the first (lowest) existing map ID.
+ *   2. On success, *next_id is set. Use that returned value as the new start_id
+ *      for the subsequent call to advance the iteration.
+ *   3. Repeat until the function returns -ENOENT, which indicates there is no
+ *      map with ID greater than start_id (end of enumeration).
+ *
+ * Concurrency & races:
+ *   - Map creation/deletion can race with enumeration; a retrieved ID might
+ *     become invalid by the time you act on it (e.g., when calling
+ *     bpf_map_get_fd_by_id()).
+ *   - To safely interact with a map after enumeration, immediately convert the
+ *     ID to a file descriptor with bpf_map_get_fd_by_id() and handle possible
+ *     failures (e.g., -ENOENT if the map was removed).
+ *
+ * Typical usage example:
+ *   __u32 id = 0, next;
+ *   while (!bpf_map_get_next_id(id, &next)) {
+ *       int map_fd = bpf_map_get_fd_by_id(next);
+ *       if (map_fd >= 0) {
+ *           // process map_fd
+ *           close(map_fd);
+ *       }
+ *       id = next;
+ *   }
+ *   // Loop terminates when -ENOENT is returned (no more IDs).
+ *
+ * @param start_id
+ *        Starting point for the search; the function looks for a map ID
+ *        strictly greater than start_id. Use 0 to get the first existing ID.
+ * @param next_id
+ *        Pointer to a __u32 that receives the next map ID on success.
+ *        Must not be NULL.
+ *
+ * @return
+ *        0 on success (next_id populated);
+ *        -ENOENT if there is no map ID greater than start_id (end of iteration);
+ *        -EINVAL on invalid arguments (e.g., next_id == NULL);
+ *        -EPERM / -EACCES if denied by security policy or lacking privileges;
+ *        Other negative libbpf-style errors for transient or system failures.
+ */
 LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
@@ -503,7 +1039,118 @@ struct bpf_get_fd_by_id_opts {
 LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
+/**
+ * @brief Get a file descriptor for an existing BPF map given its kernel-assigned ID.
+ *
+ * This helper wraps the BPF_MAP_GET_FD_BY_ID command of the bpf(2) syscall and
+ * converts a stable (monotonically increasing) map ID into a process-local
+ * file descriptor referring to that map object. The returned descriptor grants
+ * the caller access consistent with system security policy (LSM, cgroup,
+ * namespace, capabilities) at the time of the call.
+ *
+ * Typical enumeration pattern:
+ *   __u32 id = 0, next;
+ *   while (!bpf_map_get_next_id(id, &next)) {
+ *       int map_fd = bpf_map_get_fd_by_id(next);
+ *       if (map_fd >= 0) {
+ *           // Use map_fd (query info, perform lookups, etc.)
+ *           close(map_fd);
+ *       }
+ *       id = next;
+ *   }
+ *   // Loop ends when bpf_map_get_next_id() returns -ENOENT.
+ *
+ * Concurrency & races:
+ *   - A map may be deleted between obtaining its ID (e.g., via
+ *     bpf_map_get_next_id()) and calling this function; in that case the call
+ *     fails with -ENOENT.
+ *   - Immediately act on (and, when done, close) the returned file descriptor
+ *     to minimize race windows.
+ *
+ * Lifetime & ownership:
+ *   - On success the caller owns the returned file descriptor and must close()
+ *     it when no longer needed.
+ *   - The underlying map persists system-wide until all references (FDs and
+ *     in-kernel attachments) are gone; closing this FD alone does not destroy
+ *     the map.
+ *
+ * Privileges / access control:
+ *   - May require CAP_BPF, CAP_SYS_ADMIN, or be denied by LSM / lockdown
+ *     policies depending on system configuration.
+ *   - A successful return does not guarantee unrestricted operations on the
+ *     map; specific actions (updates, pinning, freezing) may still be gated.
+ *
+ * Error handling (negative libbpf-style return codes):
+ *   - -ENOENT: No map with the specified ID (deleted or never existed).
+ *   - -EACCES / -EPERM: Access denied by security policy or insufficient
+ *     privilege.
+ *   - -EINVAL: Invalid attributes passed to the kernel (rare; typically
+ *     indicates an out-of-date kernel/libbpf mismatch).
+ *   - -ENOMEM: Transient kernel memory/resource exhaustion.
+ *   - Other negative values: Propagated -errno from the bpf() syscall.
+ *
+ * @param id
+ *        Kernel-assigned unique ID of the target BPF map (obtained via
+ *        bpf_map_get_next_id() or from info queries). Must be > 0.
+ *
+ * @return
+ *        >= 0: File descriptor referring to the BPF map (caller must close()).
+ *        < 0 : Negative error code (libbpf-style, e.g., -ENOENT, -EPERM).
+ *
+ */
 LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
+/**
+ * @brief Obtain a file descriptor for an existing BPF map by its kernel-assigned ID,
+ *        with extended options.
+ *
+ * This is an extended variant of bpf_map_get_fd_by_id() that allows the caller
+ * to specify additional attributes (via @p opts) affecting how the kernel opens
+ * the map. It wraps the BPF_MAP_GET_FD_BY_ID command of the bpf(2) syscall.
+ *
+ * Typical usage pattern:
+ *   - Enumerate map IDs with bpf_map_get_next_id().
+ *   - For each ID, call bpf_map_get_fd_by_id_opts() to convert the ID into a
+ *     process-local file descriptor.
+ *   - Use the returned FD to query info (bpf_map_get_info_by_fd()), perform
+ *     lookups/updates, or pin the map.
+ *   - close() the FD when finished.
+ *
+ * Concurrency & races:
+ *   A map can be deleted between discovering its ID and calling this function.
+ *   In that case the call fails with -ENOENT. Always check the return value and
+ *   handle transient failures.
+ *
+ * Lifetime & ownership:
+ *   On success the caller owns the returned FD. Closing it decrements a
+ *   reference on the underlying map object but does not destroy the map if
+ *   other references (FDs or in-kernel links/programs) remain.
+ *
+ * Security / privileges:
+ *   Access can be denied by capabilities (CAP_BPF, CAP_SYS_ADMIN), LSM policies,
+ *   or lockdown mode, yielding -EPERM/-EACCES. Supplying certain @p opts values
+ *   (e.g., restrictive @c open_flags) does not bypass system security policy.
+ *
+ * @param id
+ *        Kernel-assigned unique ID of the target map (must be > 0). Typically
+ *        obtained via bpf_map_get_next_id() or from a prior info query.
+ * @param opts
+ *        Optional pointer to bpf_get_fd_by_id_opts controlling open behavior:
+ *          - .open_flags: Requested access/open semantics (kernel-specific;
+ *            pass 0 for default). Unsupported flags produce -EINVAL.
+ *          - .token_fd: FD of a BPF token (if using delegated permissions).
+ *        May be NULL for default behavior. Unrecognized or unsupported fields
+ *        should be zero-initialized for forward/backward compatibility.
+ *
+ * @return
+ *        >= 0 : File descriptor referring to the BPF map (caller must close()).
+ *        < 0  : Negative libbpf-style error code (typically -errno):
+ *                - -ENOENT  : No map with @p id (deleted or never existed).
+ *                - -EPERM / -EACCES : Insufficient privileges / denied by policy.
+ *                - -EINVAL  : Invalid @p id, malformed @p opts, or bad flags.
+ *                - -ENOMEM  : Transient kernel resource exhaustion.
+ *                - Other negative codes propagated from bpf() syscall.
+ *
+ */
 LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
-- 
2.34.1


