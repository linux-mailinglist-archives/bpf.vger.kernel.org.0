Return-Path: <bpf+bounces-67321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E760B427EE
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616CA563E17
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E82320CB4;
	Wed,  3 Sep 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1yJpYek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC223112C4
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920300; cv=none; b=r6XrdZv7w07g1eN87uUV9fU3jwgaFpknBe3t9rjFyY6aHvkseJXPye6I+clov6SsViHG5Hi7gT0+Jo6DSFGfxvj8/6xNsrIJJyQwHjusHSGfoqifj5yZwcNl7dczJ3v0HVPYFURqRctCkhW5aUOVp4ocNKnoZXGwiqisiJ8Co+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920300; c=relaxed/simple;
	bh=iKEWfmFrqaqXaxnFlEfibOPobVwqgig+QY7VP7uydlA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D+0ZF+WMYkrdmpyvN3SF+ALN7QHQToKQk/XDNRHyioJvs9jP+9N+C5ycrWArDIkp8f8EjaVx8orTluLAWRVL5D8qK1q38ihk3R2KddVsdBC2aVPGxASTNfd+JW2Zk8jRUSU6R9B0LOTDQiIG1mu1yc4VsJa6CzDzlks93XR2KdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1yJpYek; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329ee69e7f1so39589a91.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756920297; x=1757525097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZcBLO5WQFNSiCNIYliaGKFO4gbbcqxHBarWACkVCehw=;
        b=A1yJpYekcTi4lRlyZ/eyxTbFon5p5Z9U4Sj3VMqTFf41qd35dwqQmLyzPKm6YlUQtL
         9vp8kxmFv8+1Adt+HblRe0VQ6eRAvHmw2cvXXAB4gV4kO2ubHI3zo4Ye6hMG8T84Dnyb
         8bCignGFrBodn4i+P1kIXAod5IuphSHtS0+71n//OdtTpN7Qmlew25/Y3zlSK9sjPi0A
         52gpShHiz8VTji6iPPPaH7IS8PrkChGnma6z3LYEiK7NGKuieQpl3KobNnO5/6CrKoNd
         xLbqeNA57q+NR+zOVaaHqPpGBloHS/yuisCXPJ1n9lQ1kSl20lMrgXfZzB9ERKeEgItV
         qtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756920297; x=1757525097;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZcBLO5WQFNSiCNIYliaGKFO4gbbcqxHBarWACkVCehw=;
        b=qgsLHLcCRO+bnWAsYbSU6/inOqgKy3KGRGqWMcFgIC62T2ADj9wYkCXBfc7imY47zd
         SecN/eq+EFILAG+w4Vy+4ib6kjmzas5/d2KNh4O0Cu0Dzf7LxO/MtfH5oTni2rM6are4
         NrYakiD0R3xdjuMycEZs1sJnGVPSpNufGJ3WHDO5z/oE8Kb17ok74utIWJRzkL3yM83+
         ni3tE+2maBpqFYRNKERzClTM/Q5Pb1nICmBG3iByqlxDvGX+LpiRSTkRsxJOjHPgqodD
         1zwVsrFLO+bRGJvfEJ6zktZ3YbQ8ZTZstZGoQjZu1x46ksgMO8wMonK9QKxJYPuwRdXc
         7kSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzR+qoknfzZB7Pp4BkntlcNrO8xyXcU+0azvEsXDe2fSRAIvN0po/usLHh3CwTsx/SRi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXF+JIL9nHYgku5poQTD8EZFnQtxzOrzZhmMZ9VcIxN2uKlEb7
	BdbC1aFjvo5VzSSg+81C+5jyphmk9P2BcKsBvCGDOHHuZuoY6GHc1KFqBEh+YXZy0C7a2fuMsHx
	YWRd3AndnzQ==
X-Google-Smtp-Source: AGHT+IGrUtTmq2A3LULEO37FIg18dfky4t87pKsZQ3/zNmocgUbcFlFtDfIqvz3ZV7Tk281QMN5biz6HeeVp
X-Received: from pjb8.prod.google.com ([2002:a17:90b:2f08:b0:329:ccdd:e725])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d410:b0:327:6c75:1e3
 with SMTP id 98e67ed59e1d1-328156cc715mr18681947a91.25.1756920297498; Wed, 03
 Sep 2025 10:24:57 -0700 (PDT)
Date: Wed,  3 Sep 2025 10:24:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903172453.645226-1-irogers@google.com>
Subject: [PATCH v1] bpf: Add kernel-doc for struct bpf_prog_info
From: Ian Rogers <irogers@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Recently diagnosing a regression [1] would have been easier if struct
bpf_prog_info had some comments explaining its usage. As I found it
hard to generate comments for some parts of the struct,q what is here is a
mix of mostly hand written, but some AI written, comments.

[1] https://lore.kernel.org/lkml/CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/bpf.h | 187 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..008b559dc5c5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6607,45 +6607,230 @@ struct sk_reuseport_md {
 
 #define BPF_TAG_SIZE	8
 
+/**
+ * struct bpf_prog_info - Information about a BPF program.
+ *
+ * This structure is used by the bpf(BPF_OBJ_GET_INFO_BY_FD) syscall to retrieve
+ * metadata about a loaded BPF program. When values like the jited_prog_insns
+ * are desired typically two syscalls will be made, the first to determine the
+ * length of the buffers and the second with buffers for the syscall to fill
+ * in. The variables within the struct are ordered to minimize padding.
+ */
 struct bpf_prog_info {
+	/**
+	 * @type: The type of the BPF program (e.g.,
+	 * BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_KPROBE). This defines
+	 * where the program can be attached.
+	 */
 	__u32 type;
+	/**
+	 * @id: A unique, kernel-assigned ID for the loaded BPF program.
+	 */
 	__u32 id;
+	/**
+	 * @tag: A user-defined tag for the program, often a hash of the
+	 * object file it came from. Size is BPF_TAG_SIZE (8 bytes).
+	 */
 	__u8  tag[BPF_TAG_SIZE];
+	/**
+	 * @jited_prog_len: As an in argument this is the length of the
+	 * jited_prog_insns buffer. As an out argument, the length of the
+	 * JIT-compiled (native machine code) program image in bytes.
+	 */
 	__u32 jited_prog_len;
+	/**
+	 * @xlated_prog_len: As an in argument this is the length of the
+	 * xlated_prog_insns buffer. As an out argument, the length of the
+	 * translated BPF bytecode in bytes, after the verifier has potentially
+	 * modified it. 'xlated' is short for 'translated'.
+	 */
 	__u32 xlated_prog_len;
+	/**
+	 * @jited_prog_insns: When 0 (NULL) this is ignored by the kernel. When
+	 * non-zero a pointer to a buffer is expected and the kernel will write
+	 * jited_prog_len(s) worth of JIT-compiled machine code instructions into
+	 * the buffer.
+	 */
 	__aligned_u64 jited_prog_insns;
+	/**
+	 * @xlated_prog_insns: When 0 (NULL) this is ignored by the kernel. When
+	 * non-zero a pointer to a buffer is expected and the kernel will write
+	 * xlated_prog_len(s) worth of translated, after BPF verification, BPF
+	 * bytecode into the buffer.
+	 */
 	__aligned_u64 xlated_prog_insns;
-	__u64 load_time;	/* ns since boottime */
+	/**
+	 * @load_time: The timestamp (in nanoseconds since boot time) when the
+	 * program was loaded into the kernel.
+	 */
+	__u64 load_time;
+	/**
+	 * @created_by_uid: The user ID of the process that loaded this program.
+	 */
 	__u32 created_by_uid;
+	/**
+	 * @nr_map_ids: As an in argument this is the length of the map_ids
+	 * buffer in sizes of u32 (4 bytes). As an out argument, the number of
+	 * BPF maps used by this BPF program.
+	 */
 	__u32 nr_map_ids;
+	/**
+	 * @map_ids: When 0 (NULL) this is ignored by the kernel. When non-zero
+	 * a pointer to a buffer is expected and the kernel will write
+	 * nr_map_ids(s) worth of u32 kernel allocated BPF map id values into the
+	 * buffer.
+	 */
 	__aligned_u64 map_ids;
+	/**
+	 * @name: The name of the program, as specified in the ELF object file.
+	 * The max length is BPF_OBJ_NAME_LEN (16 characters).
+	 */
 	char name[BPF_OBJ_NAME_LEN];
+	/**
+	 * @ifindex: If the program is attached to a network device (netdev),
+	 * this field holds the interface index.
+	 */
 	__u32 ifindex;
+	/**
+	 * @gpl_compatible: A flag indicating if the program is compatible with
+	 * a GPL license. This is important for using certain GPL-only helpers.
+	 */
 	__u32 gpl_compatible:1;
 	__u32 :31; /* alignment pad */
+	/**
+	 * @netns_dev: The device identifier of the network namespace the
+	 * program is attached to.
+	 */
 	__u64 netns_dev;
+	/**
+	 * @netns_ino: The inode number of the network namespace the program is
+	 * attached to.
+	 */
 	__u64 netns_ino;
+	/**
+	 * @nr_jited_ksyms: As an in argument this is the length of the
+	 * jited_ksyms buffer in sizes of u64 (8 bytes). As an out argument, the
+	 * number of kernel symbols that the BPF program calls.
+	 */
 	__u32 nr_jited_ksyms;
+	/**
+	 * @nr_jited_func_lens: As an in argument this is the length of the
+	 * jited_func_lens buffer in sizes of u32 (4 bytes). As an out argument,
+	 * the number of distinct functions within the JIT-ed program.
+	 */
 	__u32 nr_jited_func_lens;
+	/**
+	 * @jited_ksyms: When 0 (NULL) this is ignored by the kernel. When
+	 * non-zero a pointer to a buffer is expected and the kernel will write
+	 * nr_jited_ksyms(s) worth of addresses of kernel symbols into the u64
+	 * buffer.
+	 */
 	__aligned_u64 jited_ksyms;
+	/**
+	 * @jited_func_lens: When 0 (NULL) this is ignored by the kernel. When
+	 * non-zero a pointer to a buffer is expected and the kernel will write
+	 * nr_jited_func_lens(s) worth of lengths into the u32 buffer.
+	 */
 	__aligned_u64 jited_func_lens;
+	/**
+	 * @btf_id: The ID of the BTF (BPF Type Format) object associated with
+	 * this program, which contains type information for debugging and
+	 * introspection.
+	 */
 	__u32 btf_id;
+	/**
+	 * @func_info_rec_size: The size in bytes of a single `bpf_func_info`
+	 * record.
+	 */
 	__u32 func_info_rec_size;
+	/**
+	 * @func_info: When 0 (NULL) this is ignored by the kernel. When
+	 * non-zero a pointer to a buffer is expected and the kernel will write
+	 * nr_func_info(s) worth of func_info_rec_size values.
+	 */
 	__aligned_u64 func_info;
+	/**
+	 * @nr_func_info: As an in argument this is the length of the func_info
+	 * buffer in sizes of func_info_rec_size. As an out argument, the number
+	 * of `bpf_func_info` records available.
+	 */
 	__u32 nr_func_info;
+	/**
+	 * @nr_line_info: As an in argument this is the length of the line_info
+	 * buffer in sizes of line_info_rec_size. As an out argument, the number
+	 * of `bpf_line_info` records, which map BPF instructions to source code
+	 * lines.
+	 */
 	__u32 nr_line_info;
+	/**
+	 * @line_info: When 0 (NULL) this is ignored by the kernel. When
+	 * non-zero a pointer to a buffer is expected and the kernel will write
+	 * nr_line_info(s) worth of line_info_rec_size values.
+	 */
 	__aligned_u64 line_info;
+	/**
+	 * @jited_line_info: When 0 (NULL) this is ignored by the kernel. When
+	 * non-zero a pointer to a buffer is expected and the kernel will write
+	 * nr_jited_line_info(s) worth of jited_line_info_rec_size values.
+	 */
 	__aligned_u64 jited_line_info;
+	/**
+	 * @nr_line_info: As an in argument this is the length of the
+	 * jited_line_info buffer in sizes of jited_line_info_rec_size. As an
+	 * out argument, the number of `bpf_line_info` records, which map JIT-ed
+	 * instructions to source code lines.
+	 */
 	__u32 nr_jited_line_info;
+	/**
+	 * @line_info_rec_size: The size in bytes of a `bpf_line_info` record.
+	 */
 	__u32 line_info_rec_size;
+	/**
+	 * @jited_line_info_rec_size: The size in bytes of a `bpf_line_info`
+	 * record for JIT-ed code.
+	 */
 	__u32 jited_line_info_rec_size;
+	/**
+	 * @nr_prog_tags: As an in argument this is the length of the prog_tags
+	 * buffer in sizes of BPF_TAG_SIZE (8 bytes). As an out argument, the
+	 * number of program tags, which are hashes of programs that this
+	 * program can tail-call.
+	 */
 	__u32 nr_prog_tags;
+	/**
+	 * @prog_tags: When 0 (NULL) this is ignored by the kernel. When
+	 * non-zero a pointer to a buffer is expected and the kernel will write
+	 * nr_prog_tags(s) worth of BPF_TAG_SIZE values.
+	 */
 	__aligned_u64 prog_tags;
+	/**
+	 * @run_time_ns: The total accumulated execution time of the program in
+	 * nanoseconds.
+	 */
 	__u64 run_time_ns;
+	/**
+	 * @run_cnt: The total number of times the program has been executed.
+	 */
 	__u64 run_cnt;
+	/**
+	 * @recursion_misses: The number of failed tail calls due to reaching
+	 * the recursion limit.
+	 */
 	__u64 recursion_misses;
+	/**
+	 * @verified_insns: The number of instructions processed by the
+	 * verifier.
+	 */
 	__u32 verified_insns;
+	/**
+	 * @attach_btf_obj_id: If attached via BTF (e.g., fentry/fexit), this is
+	 * the BTF object ID of the target object (e.g., kernel vmlinux).
+	 */
 	__u32 attach_btf_obj_id;
+	/**
+	 * @attach_btf_id: The BTF type ID of the function or tracepoint this
+	 * program is attached to.
+	 */
 	__u32 attach_btf_id;
 } __attribute__((aligned(8)));
 
-- 
2.51.0.338.gd7d06c2dae-goog


