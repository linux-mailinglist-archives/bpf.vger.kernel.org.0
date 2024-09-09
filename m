Return-Path: <bpf+bounces-39378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D797259A
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F31F1C235D3
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220318DF69;
	Mon,  9 Sep 2024 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8Eckq68"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869238F5A
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923512; cv=none; b=TPuYwSCom5nhE699rqbR65/pK+a5p8fBkn3j/VIWKAAZ4tRsw/bBBvfaL6vgLb2dqxvs1t43TF9Cu6enizE8TPS5/SD+oBKbzKsLri5dvcF7GBwgofHCZWAA+ZmuPT3JwOHKILLXlc95GEcu2IEG5eFC/SBVhywizamBsLrMb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923512; c=relaxed/simple;
	bh=4N3AaOcmp7IonWD7KCp3/1GfNGK4FMLBU6L2OCfSpKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GY51y1lVMjMo5b0dNTzBCESG1JsmUrl+4Ix1Xbe4GTd7ODkZlML4y8mV0+OUBn9NPKfkUZrXKeqPcXbqrKvjisGQDUHuetzV17emz1Blfo2m5Jk7CgVaCgybik4N5gY6lEQpUkNDgT+hPFBvBgGK/ASIlJNdmhx/k4/q6b/mfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8Eckq68; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d6ad6050so2713826b3a.0
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 16:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725923510; x=1726528310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kfs6v4zaRNKDG86TWCku3WyfLJtwAR610uSbcjRGtQ=;
        b=N8Eckq682ZX0NhFxB9IKURrX0Cmqc7Fv6+nA7yABOzZpmhDx+jZTD1mUZyw9cyp5ng
         8f/c7ihoVuV1qDrArjxmUpFqnQhex0QxBR6t7bo+RKAxcAenWtAi65cD1DH5On09g3nK
         nudqq1Nr8Mq0tek9atVkTcYHFMQWoGBRJAl7YDPmjnoxO1mVEyFivfNGdek7rSXXSnZV
         MQA6XHA9pMB9ca/eOspv2+hhCcqnE9Zwtq44MLopdZh4bj1g/5Z24hCXaE37Er+HxCj9
         A2mNWAFBPRdHeB0TOZ9bdsi/3uQ8WCJ7UHfvJa5Qtjyc6mY03qv/pncOrZIu19h6TiF6
         XnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725923510; x=1726528310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kfs6v4zaRNKDG86TWCku3WyfLJtwAR610uSbcjRGtQ=;
        b=ZqsYyKZWL+iTRHhE2pwIlxmkbh4sLg2ds1mlpwg8mqkEKTSSsBn3VdVXg3EkbrWYzC
         7nsLETwCHvMMPGjUiD7ALK9yTiXZIPD4R9flSHTQnHW6Hwab+PGLIdKaHKVk5gBcxfP8
         JTQFCxJt6f6D1p5VTLMn2Vrcd0Ak6tb1wbhglF0tuOuAhzajfCdYSasyWN7yFnD+U9Es
         N9tBMMyPHSMfoybHKTGDiuAZr4hb5LLrIiajoXUH50tzrMrhrpbQijno93YevQmZgkrr
         ms34FqvDMv/j3iq+vwAI8qlktDL2Mn7+mFm9334n4UqUwch7EfZlWtE4qq/vGPapnxZl
         na0A==
X-Gm-Message-State: AOJu0Yz0/MlYoshqYTjINgk7+amVKp2iEbz4fI3HIXl3NHiwe507yJ8s
	nskJgcULjARGMzU+VkcBZ5Rv/PFUbl981GMxnnfHzCioAKyFOcNTq2tgurxcPPI=
X-Google-Smtp-Source: AGHT+IEYI52xxgANj+o4ZkprvF8JTx0mF+vqwh5UwnD+wpw3pPU+nUSTk64HeQmHQ4Px2r551Pxjsg==
X-Received: by 2002:a05:6a00:816:b0:717:8cef:4053 with SMTP id d2e1a72fcca58-718d5e9028cmr17321194b3a.14.1725923509425;
        Mon, 09 Sep 2024 16:11:49 -0700 (PDT)
Received: from ubuntu.ucsc.edu (ucsc-guest-169-233-121-184.ucsc.edu. [169.233.121.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8256d08b9sm4466405a12.63.2024.09.09.16.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 16:11:49 -0700 (PDT)
From: Yusheng Zheng <yunwei356@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	Yusheng Zheng <yunwei356@gmail.com>
Subject: [PATCH bpf-next v2] libbpf: fix some typos in comments
Date: Mon,  9 Sep 2024 23:11:23 +0000
Message-ID: <20240909231124.30826-1-yunwei356@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some spelling errors in the code comments of libbpf:

betwen -> between
paremeters -> parameters
knowning -> knowing
definiton -> definition
compatiblity -> compatibility
overriden -> overridden
occured -> occurred
proccess -> process
managment -> management
nessary -> necessary

Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h   |  2 +-
 tools/lib/bpf/bpf_tracing.h   |  2 +-
 tools/lib/bpf/btf.c           |  2 +-
 tools/lib/bpf/btf.h           |  2 +-
 tools/lib/bpf/btf_dump.c      |  2 +-
 tools/lib/bpf/libbpf.h        | 10 +++++-----
 tools/lib/bpf/libbpf_legacy.h |  4 ++--
 tools/lib/bpf/skel_internal.h |  2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 305c62817dd3..80bc0242e8dc 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -341,7 +341,7 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
  * I.e., it looks almost like high-level for each loop in other languages,
  * supports continue/break, and is verifiable by BPF verifier.
  *
- * For iterating integers, the difference betwen bpf_for_each(num, i, N, M)
+ * For iterating integers, the difference between bpf_for_each(num, i, N, M)
  * and bpf_for(i, N, M) is in that bpf_for() provides additional proof to
  * verifier that i is in [N, M) range, and in bpf_for_each() case i is `int
  * *`, not just `int`. So for integers bpf_for() is more convenient.
diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 4eab132a963e..8ea6797a2570 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -808,7 +808,7 @@ struct pt_regs;
  * tp_btf/fentry/fexit BPF programs. It hides the underlying platform-specific
  * low-level way of getting kprobe input arguments from struct pt_regs, and
  * provides a familiar typed and named function arguments syntax and
- * semantics of accessing kprobe input paremeters.
+ * semantics of accessing kprobe input parameters.
  *
  * Original struct pt_regs* context is preserved as 'ctx' argument. This might
  * be necessary when using BPF helpers like bpf_perf_event_output().
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8d51e73d55a8..3c131039c523 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4230,7 +4230,7 @@ static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id
  * consists of portions of the graph that come from multiple compilation units.
  * This is due to the fact that types within single compilation unit are always
  * deduplicated and FWDs are already resolved, if referenced struct/union
- * definiton is available. So, if we had unresolved FWD and found corresponding
+ * definition is available. So, if we had unresolved FWD and found corresponding
  * STRUCT/UNION, they will be from different compilation units. This
  * consequently means that when we "link" FWD to corresponding STRUCT/UNION,
  * type graph will likely have at least two different BTF types that describe
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index b68d216837a9..4e349ad79ee6 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -286,7 +286,7 @@ LIBBPF_API void btf_dump__free(struct btf_dump *d);
 LIBBPF_API int btf_dump__dump_type(struct btf_dump *d, __u32 id);
 
 struct btf_dump_emit_type_decl_opts {
-	/* size of this struct, for forward/backward compatiblity */
+	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
 	/* optional field name for type declaration, e.g.:
 	 * - struct my_struct <FNAME>
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 894860111ddb..0a7327541c17 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -304,7 +304,7 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
  * definition, in which case they have to be declared inline as part of field
  * type declaration; or as a top-level anonymous enum, typically used for
  * declaring global constants. It's impossible to distinguish between two
- * without knowning whether given enum type was referenced from other type:
+ * without knowing whether given enum type was referenced from other type:
  * top-level anonymous enum won't be referenced by anything, while embedded
  * one will.
  */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 64a6a3d323e3..6917653ef9fa 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -152,7 +152,7 @@ struct bpf_object_open_opts {
 	 * log_buf and log_level settings.
 	 *
 	 * If specified, this log buffer will be passed for:
-	 *   - each BPF progral load (BPF_PROG_LOAD) attempt, unless overriden
+	 *   - each BPF progral load (BPF_PROG_LOAD) attempt, unless overridden
 	 *     with bpf_program__set_log() on per-program level, to get
 	 *     BPF verifier log output.
 	 *   - during BPF object's BTF load into kernel (BPF_BTF_LOAD) to get
@@ -455,7 +455,7 @@ LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
 /**
  * @brief **bpf_program__attach()** is a generic function for attaching
  * a BPF program based on auto-detection of program type, attach type,
- * and extra paremeters, where applicable.
+ * and extra parameters, where applicable.
  *
  * @param prog BPF program to attach
  * @return Reference to the newly created BPF link; or NULL is returned on error,
@@ -679,7 +679,7 @@ struct bpf_uprobe_opts {
 /**
  * @brief **bpf_program__attach_uprobe()** attaches a BPF program
  * to the userspace function which is found by binary path and
- * offset. You can optionally specify a particular proccess to attach
+ * offset. You can optionally specify a particular process to attach
  * to. You can also optionally attach the program to the function
  * exit instead of entry.
  *
@@ -1593,11 +1593,11 @@ LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_i
  * memory region of the ring buffer.
  * This ring buffer can be used to implement a custom events consumer.
  * The ring buffer starts with the *struct perf_event_mmap_page*, which
- * holds the ring buffer managment fields, when accessing the header
+ * holds the ring buffer management fields, when accessing the header
  * structure it's important to be SMP aware.
  * You can refer to *perf_event_read_simple* for a simple example.
  * @param pb the perf buffer structure
- * @param buf_idx the buffer index to retreive
+ * @param buf_idx the buffer index to retrieve
  * @param buf (out) gets the base pointer of the mmap()'ed memory
  * @param buf_size (out) gets the size of the mmap()'ed region
  * @return 0 on success, negative error code for failure
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index 1e1be467bede..60b2600be88a 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -76,7 +76,7 @@ enum libbpf_strict_mode {
 	 * first BPF program or map creation operation. This is done only if
 	 * kernel is too old to support memcg-based memory accounting for BPF
 	 * subsystem. By default, RLIMIT_MEMLOCK limit is set to RLIM_INFINITY,
-	 * but it can be overriden with libbpf_set_memlock_rlim() API.
+	 * but it can be overridden with libbpf_set_memlock_rlim() API.
 	 * Note that libbpf_set_memlock_rlim() needs to be called before
 	 * the very first bpf_prog_load(), bpf_map_create() or bpf_object__load()
 	 * operation.
@@ -97,7 +97,7 @@ LIBBPF_API int libbpf_set_strict_mode(enum libbpf_strict_mode mode);
  * @brief **libbpf_get_error()** extracts the error code from the passed
  * pointer
  * @param ptr pointer returned from libbpf API function
- * @return error code; or 0 if no error occured
+ * @return error code; or 0 if no error occurred
  *
  * Note, as of libbpf 1.0 this function is not necessary and not recommended
  * to be used. Libbpf doesn't return error code embedded into the pointer
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 1e82ab06c3eb..0875452521e9 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -107,7 +107,7 @@ static inline void skel_free(const void *p)
  * The loader program will perform probe_read_kernel() from maps.rodata.initial_value.
  * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map and
  * does maps.rodata.initial_value = ~0ULL to signal skel_free_map_data() that kvfree
- * is not nessary.
+ * is not necessary.
  *
  * For user space:
  * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
-- 
2.43.0


