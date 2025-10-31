Return-Path: <bpf+bounces-73115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A3C23A44
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC2584F25CA
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4532C943;
	Fri, 31 Oct 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwuh3xQr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65D32AACE
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897609; cv=none; b=YDnTVkwUJw3/zg6xefCm/0bYclNypRzlr6whclffYuCoe89SieeeOa9CY/k0OtrEZPF6gH2yCqHy+9FRuL7jGXmi+7AxHLxh5LpTrYLo4KtrxcSOLGDkFJyjfMQpBdpLzHOD8hrK/d4C2mzZcZJDaWzjrH9iU0f3CTSnnHLXcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897609; c=relaxed/simple;
	bh=TsrzwgFBeRd8IHfr1ejSjcMSRxPfnYpKZaoSbpXjCdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tofNmRiYq0HadjCTF8g9gDIawIHHRDgNSqmDy0KCY6VQHLBtYCAvfbZn3N0CJ6eEjnXUpIiM58CXZUdeWNNSa88QrvtQNDnCGAEanmsnUkJTHrEJiAFWjjp8hB7DLdxRHuCoydHhiI8sPmo4ffsQQaW1kDwkRARfsqFfkr7Natk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwuh3xQr; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so2003170b3a.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 01:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761897604; x=1762502404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqGVylxGniGAnG7/VQtFPRfIEHrq4fNkkxvdTdmPnjE=;
        b=Gwuh3xQro28QGw2TGi/nxEPbmcMAHrU9pVWODxBP17vK0XkBR7OhU0uBcOU/jd6PZr
         +GWJY/k1FGvZOnYkV9Snr9RYEM9GuymmZNmj/voTouD2MuVGpHJ37+0wnWC0zWCEbKHg
         QrvbKzUGzs8X8VB6BlOALKhDqZu8dSCSKggiG9NnRMexgNUfcQ2WVkxw8qPkt2Kg9qcV
         UjrfkKzUbOFes4TAlQe7ZP1Tr4+OqRuCnm4m4WuQGDBnnLA4jKoksoYUj5IGD508B2oP
         fF8E1nLaHPV0cZQjU9Uj7v0kn8mmnJ1OEXUNjVjfrCjTrtVXidg45u7ysC54e1gEqkmq
         DiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897604; x=1762502404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqGVylxGniGAnG7/VQtFPRfIEHrq4fNkkxvdTdmPnjE=;
        b=hMnGJHA0S1WixYW1Cj13KuwSHGRxNVtwA4bnuKpPLe4hm8VwjsszI3xDMvxabJvozo
         T3KoQre1sOxO1qq1nHDjglWtfghXxwKED6HVGG4yi6WXqC7iIhiVEQwE8rhEj3bG3mLu
         dUAFyBIjw7fSBEvBobIsbawH5jS0xdPAFR47dcNHbHx7U6dBLpACANoh5Tiy+oPOj0QD
         wNB6Nl30WGzZDP9e8lSBW7Nv6s3/8FxYu4gEr0jOIUaNHiORtvxTlH90jz9s2H7Qpl1/
         U/T2x+IWU8JEUNalsnSo6AoQ3yMjl69Koz0Q+Z8LKei07FkE8w/feTgyUyPvf5IzQfBY
         nWEg==
X-Forwarded-Encrypted: i=1; AJvYcCUuZmsobedkFXVAcixbosSFGe4Qkct4eL1LvD2KW9byxetmTl4t2pfcroB5z8pXCCvS3us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKaCh/1xTzgwVRSSzTxV2pn4cw80ajX6w2129a49luVTll7YtL
	6PLnm22Cv0I2mGwvKzOOgu6YopcR9dXC+MJYFsdaaYTZCXH2h/vShhEl
X-Gm-Gg: ASbGncv3RW1n4SNtsKTMWvnbG8hPr88visw4Dcsov/Ghj+JaGV5qXK82EmjgtySE+Pf
	zF4lVABm2nb6FwVqowKfghIYGXm2mZsGxFF4D2iWYvd4bTCI+3oG/2PianWI2I3CbXc1dpBAQAf
	HlUupdFTUwtvG7HG65rFyPxztw6DXsG5kAEF1bs/wmfzxK19+RNA0BbH/HpwOK5He6EvW6Kjt2B
	4b9GROK9Jj55OUalpDcqNZTByPteju0koX4ZMLKjpfzptcGcdfI1PoldnEdmQPbTrRQs2+GOkf9
	EcNhEQrr/2NwYcfeBfBwlP6264Om/GCrSnbkzIlW7mUPKvSC5hDJHw5NoE8BCo5Ly2idKjYkZSW
	S3hEnp8B/ktNCzVADUFnSDSnbgLTXo0TGKGiRkQ/a7ixfhNXvbgSlebxgqobP3N/mdrcLBVq2ly
	WPT080hmBL2Nk1z+Sw4w==
X-Google-Smtp-Source: AGHT+IGRQLdZnJOECdypxjzblvvJrzqPfek8AaF2rCRejcjnVvHasVu0V/yQqgXdbEq5sa4AZjk3Fg==
X-Received: by 2002:a05:6a20:3d07:b0:342:9487:7dee with SMTP id adf61e73a8af0-348c9f6791fmr3790833637.12.1761897603739;
        Fri, 31 Oct 2025 01:00:03 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4045fbsm1216575a12.28.2025.10.31.00.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:00:02 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	netdev@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH v2 2/5] libbpf: Add doxygen documentation for bpf_prog_* APIs in bpf.h
Date: Fri, 31 Oct 2025 15:59:04 +0800
Message-Id: <20251031075908.1472249-3-jianyungao89@gmail.com>
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

Add doxygen comment blocks for all public bpf_prog_* APIs in
tools/lib/bpf/bpf.h. These doc comments are for:

-bpf_prog_load()
-bpf_prog_attach()
-bpf_prog_detach()
-bpf_prog_detach2()
-bpf_prog_get_next_id()
-bpf_prog_get_fd_by_id()
-bpf_prog_get_fd_by_id_opts()
-bpf_prog_query()
-bpf_prog_bind_map()
-bpf_prog_test_run_opts()

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v1->v2:
 - Fixed the non-ASCII characters in this patch.

The v1 is here:
https://lore.kernel.org/lkml/20251031032627.1414462-3-jianyungao89@gmail.com/

 tools/lib/bpf/bpf.h | 655 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 649 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 35372c0790ee..cd96d7afed6b 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -167,7 +167,104 @@ struct bpf_prog_load_opts {
 	size_t :0;
 };
 #define bpf_prog_load_opts__last_field fd_array_cnt
-
+/**
+ * @brief Load (verify and register) a BPF program into the kernel.
+ *
+ * This is a high-level libbpf wrapper around the BPF_PROG_LOAD command of the
+ * bpf(2) syscall. It submits an array of eBPF instructions to the kernel
+ * verifier, optionally provides BTF metadata and attachment context, and
+ * returns a file descriptor referring to the newly loaded (but not yet
+ * attached) BPF program.
+ *
+ * Core flow:
+ *   1. The kernel verifier validates instruction safety, helper usage,
+ *      stack bounds, pointer arithmetic, and (if provided) BTF type
+ *      consistency.
+ *   2. If verification succeeds, a program FD is returned (>= 0).
+ *   3. If verification fails, a negative libbpf-style error is returned
+ *      (< 0). If logging was requested via @c opts->log_* fields, a textual
+ *      verifier log may be captured for debugging.
+ *
+ * @param prog_type
+ *        Enumerated BPF program type (enum bpf_prog_type) selecting verifier
+ *        expectations and permissible helpers (e.g. BPF_PROG_TYPE_SOCKET_FILTER,
+ *        BPF_PROG_TYPE_KPROBE, BPF_PROG_TYPE_TRACING, BPF_PROG_TYPE_XDP, etc.).
+ *
+ * @param prog_name
+ *        Optional, null-terminated human-readable name. Visible via bpftool
+ *        and in kernel introspection APIs. Can be NULL. If longer than the
+ *        kernel's max BPF object name length (typically BPF_OBJ_NAME_LEN),
+ *        it will be truncated. Use concise alphanumeric/underscore names.
+ *
+ * @param license
+ *        Null-terminated license string (e.g. "GPL", "Dual BSD/GPL"). Determines
+ *        eligibility for GPL-only helpers. Must not be NULL. Passing a license
+ *        incompatible with required GPL-only helpers yields -EACCES/-EPERM.
+ *
+ * @param insns
+ *        Pointer to an array of eBPF instructions (struct bpf_insn). Must be
+ *        non-NULL and executable by the verifier (no out-of-bounds jumps, etc.).
+ *        The kernel copies this array; caller can free/modify it after return.
+ *
+ * @param insn_cnt
+ *        Number of instructions in @p insns. Must be > 0 and within kernel
+ *        limits (historically <= ~1M instructions; exact cap is kernel-specific).
+ *        A too large value results in -E2BIG or -EINVAL.
+ *
+ * @param opts
+ *        Optional pointer to a zero-initialized struct bpf_prog_load_opts
+ *        providing extended parameters. Pass NULL for defaults. Only set
+ *        fields you understand; leaving others zero ensures fwd/back compat.
+ *
+ *        Notable fields:
+ *          - sz: Must be set to sizeof(struct bpf_prog_load_opts) for libbpf
+ *            to validate structure layout.
+ *          - attempts: Number of automatic retries if bpf() returns -EAGAIN
+ *            (transient verifier/resource contention). Default is 5 if zero.
+ *          - expected_attach_type: For some program types (tracing, LSM, etc.)
+ *            the verifier requires an attach type hint.
+ *          - prog_btf_fd: BTF describing function prototypes / types referenced
+ *            by the program (enables CO-RE relocations, enhanced validation).
+ *          - prog_flags: Bitmask of program load flags (e.g. BPF_F_STRICT_ALIGNMENT,
+ *            BPF_F_SLEEPABLE for sleepable programs; availability is kernel-dependent).
+ *          - prog_ifindex: Network interface index for certain net-specific types
+ *            (e.g., tc or XDP offload scenarios).
+ *          - kern_version: Legacy field (mostly for old kernels / cBPF migration).
+ *          - attach_btf_id / attach_btf_obj_fd: Identify kernel BTF target (e.g.
+ *            function or struct) for fentry/fexit/tracing program types.
+ *          - attach_prog_fd: Attach to an existing BPF program (e.g. for extension).
+ *          - fd_array / fd_array_cnt: Supply an array of FDs (maps, progs) when the
+ *            kernel expects auxiliary references (advanced use cases).
+ *          - func_info / line_info (+ *_cnt, *_rec_size): Raw .BTF.ext sections
+ *            used for richer debugging and introspection (normally handled by
+ *            libbpf when loading from object files; rarely set manually).
+ *          - log_level / log_size / log_buf: Request verifier output. Set
+ *            log_level > 0, allocate log_buf of at least log_size bytes. After
+ *            return, log_true_size (if kernel supports) reflects actual length
+ *            (may exceed provided size if truncated).
+ *          - token_fd: BPF token for delegated permissions (non-root controlled
+ *            environments).
+ *
+ *        Unrecognized (future) fields should remain zeroed. Always update sz.
+ *
+ * @return
+ *        >= 0 : File descriptor of loaded BPF program; caller owns it and must
+ *                close() when no longer needed.
+ *        < 0  : Negative libbpf-style error code (typically -errno). Common:
+ *                  - -EINVAL: Malformed instructions, bad prog_type/flags, struct
+ *                             size mismatch, missing required attach hints.
+ *                  - -EACCES / -EPERM: Disallowed helpers (license/capability),
+ *                                        missing CAP_BPF/CAP_SYS_ADMIN or blocked
+ *                                        by LSM/lockdown.
+ *                  - -E2BIG: Instruction count or log size too large.
+ *                  - -ENOMEM: Kernel memory/resource exhaustion.
+ *                  - -EFAULT: Bad user pointers (insns/log_buf).
+ *                  - -EOPNOTSUPP: Unsupported program type or flag on this kernel.
+ *                  - -ENOSPC: Program too complex (e.g. verifier limits exceeded).
+ *                  - -EAGAIN: Transient verifier failure; libbpf may retry until
+ *                              attempts exhausted.
+ *
+ */
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
 			     const struct bpf_insn *insns, size_t insn_cnt,
@@ -821,10 +918,182 @@ struct bpf_obj_get_opts {
 LIBBPF_API int bpf_obj_get(const char *pathname);
 LIBBPF_API int bpf_obj_get_opts(const char *pathname,
 				const struct bpf_obj_get_opts *opts);
-
+/**
+ * @brief Attach a loaded BPF program to a kernel hook or attach point.
+ *
+ * This is a low-level libbpf helper that wraps the bpf(BPF_PROG_ATTACH)
+ * syscall command. It establishes a relationship between an already loaded
+ * BPF program (@p prog_fd) and an attachable kernel entity represented by
+ * @p attachable_fd (or, for certain attach types, a pseudo file descriptor).
+ *
+ * Common attach targets include:
+ *   - cgroup FDs (for CGroup-related program types like BPF_PROG_TYPE_CGROUP_SKB,
+ *     BPF_PROG_TYPE_CGROUP_SOCK_ADDR, etc.).
+ *   - perf event FDs (for certain tracing or profiling program types).
+ *   - socket or socket-like FDs (for SK_MSG, SK_SKB, SOCK_OPS, etc.).
+ *   - BPF prog array FDs (when chaining programs).
+ *
+ * Prefer using newer link-based APIs (e.g., bpf_link_create()) when available,
+ * as they provide a stable lifetime model and automatic cleanup when the link
+ * FD is closed. This legacy API is still useful on older kernels or for
+ * attach types not yet covered by link abstractions.
+ *
+ * @param prog_fd
+ *        File descriptor of an already loaded BPF program obtained via
+ *        bpf_prog_load() or similar. Must be a valid BPF program FD.
+ *
+ * @param attachable_fd
+ *        File descriptor of the target attach point (e.g., cgroup FD, perf
+ *        event FD, target program array FD). For some attach types this might
+ *        be a special or pseudo FD whose semantics depend on @p type.
+ *
+ * @param type
+ *        Enumerated BPF attach type (enum bpf_attach_type) specifying how the
+ *        kernel should link the program to the target. The allowable set
+ *        depends on both the program's BPF program type and the nature of
+ *        @p attachable_fd. A mismatch typically yields -EINVAL.
+ *
+ * @param flags
+ *        Additional attach flags controlling behavior. Most attach types
+ *        require this to be 0. Some program families (e.g., cgroup) permit
+ *        flag combinations (such as replacing existing attachments) subject
+ *        to kernel version support. Unsupported flags result in -EINVAL.
+ *
+ * @return 0 on success; negative error code (< 0) on failure.
+ *
+ * Example (attaching a cgroup program):
+ *   int prog_fd = bpf_prog_load(...);
+ *   int cg_fd   = open("/sys/fs/cgroup/mygroup", O_RDONLY);
+ *   if (bpf_prog_attach(prog_fd, cg_fd, BPF_CGROUP_INET_INGRESS, 0) < 0)
+ *       perror("bpf_prog_attach");
+ *
+ */
 LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
 			       enum bpf_attach_type type, unsigned int flags);
+/**
+ * @brief Detach (unlink) BPF program(s) from an attach point.
+ *
+ * bpf_prog_detach() is a legacy convenience wrapper around the
+ * BPF_PROG_DETACH command of the bpf(2) syscall. It removes the BPF
+ * program currently attached to the kernel object represented by
+ * attachable_fd for the specified attach @p type. This API only works
+ * for attach types that historically supported a single attached
+ * program (e.g., older cgroup program types before multi-attach was
+ * introduced).
+ *
+ * For modern multi-program attach points (e.g., cgroup with multiple
+ * programs of the same attach type), prefer bpf_prog_detach2(), which
+ * allows specifying the exact program FD to be detached. Calling
+ * bpf_prog_detach() on a multi-attach capable target typically fails
+ * with -EINVAL or -EPERM, or detaches only the "base"/single program
+ * depending on kernel version, so it should be avoided in new code.
+ *
+ * Lifetime semantics:
+ *   - On success, the link between the program and the attach point is
+ *     removed; any subsequent events at that hook will no longer invoke
+ *     the detached program.
+ *   - The program itself remains loaded; its FD is still valid and
+ *     should be closed separately when no longer needed.
+ *
+ * Concurrency & races:
+ *   - Detach operations compete with parallel attach/detach attempts.
+ *     If another program is attached between inspection and detach,
+ *     the result may differ from expectations; always check return
+ *     codes.
+ *
+ * Typical usage (legacy cgroup case):
+ *   int cg_fd = open("/sys/fs/cgroup/mygroup", O_RDONLY);
+ *   if (cg_fd < 0) { perror("open cgroup"); return -1; }
+ *   if (bpf_prog_detach(cg_fd, BPF_CGROUP_INET_INGRESS) < 0)
+ *       perror("bpf_prog_detach");
+ *
+ * @param attachable_fd
+ *        File descriptor of the attach target (e.g., cgroup FD, perf event FD,
+ *        etc.). Must refer to an object supporting the given attach type.
+ * @param type
+ *        Enumerated BPF attach type (enum bpf_attach_type) corresponding to
+ *        the hook from which to detach. Must match the original attach type
+ *        used when the program was attached.
+ *
+ * @return 0 on success;
+ *         < 0 negative libbpf-style error code (typically -errno) on failure:
+ *           - -EBADF: attachable_fd is not a valid descriptor.
+ *           - -EINVAL: Unsupported attach type for this target, no program
+ *                     of that type attached, or legacy detach disallowed
+ *                     (multi-attach scenario).
+ *           - -ENOENT: No program currently attached for the given type.
+ *           - -EPERM / -EACCES: Insufficient privileges (missing CAP_BPF /
+ *                     CAP_SYS_ADMIN) or blocked by security policy.
+ *           - -EOPNOTSUPP: Kernel lacks support for detaching this type.
+ *           - Other negative codes: Propagated syscall failures (e.g., -ENOMEM).
+ *
+ */
 LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
+/**
+ * @brief Detach a specific BPF program from an attach point that may support multiple
+ *        simultaneously attached programs.
+ *
+ * bpf_prog_detach2() is an enhanced variant of bpf_prog_detach(). While
+ * bpf_prog_detach() detaches "the" program of a given @p type from @p attachable_fd
+ * (and therefore only works reliably for legacy single-attach hooks), this function
+ * targets and detaches the exact BPF program referenced by @p prog_fd from the
+ * attach point referenced by @p attachable_fd.
+ *
+ * Typical use cases:
+ *   - Cgroup multi-attach program types (e.g., CGROUP_SKB, CGROUP_SOCK, CGROUP_SYSCTL,
+ *     CGROUP_INET_INGRESS/EGRESS, etc.), where multiple programs of the same attach
+ *     type can coexist.
+ *   - Hooks that allow program stacking/chaining and require precise removal of a
+ *     single program without disturbing others.
+ *
+ * Preferred alternatives:
+ *   - For new code that establishes long-lived attachments, consider using link-based
+ *     APIs (bpf_link_create() + bpf_link_detach()/close(link_fd)), which provide
+ *     clearer lifetime semantics. bpf_prog_detach2() is still necessary on older
+ *     kernels or when working directly with legacy cgroup/perf event style attachments.
+ *
+ * Concurrency & races:
+ *   - If another thread/process detaches the same program (or destroys either FD)
+ *     concurrently, this call can fail with -ENOENT or -EBADF.
+ *   - Immediately check the return value; success means the specified program
+ *     was detached at the time of the call. The program remains loaded and its
+ *     @p prog_fd is still valid; close() it separately when done.
+ *
+ * Privileges:
+ *   - Typically requires CAP_BPF and/or CAP_SYS_ADMIN depending on kernel
+ *     configuration, LSM policies, and lockdown mode.
+ *
+ * Error handling (negative return codes, libbpf style == -errno):
+ *   - -EBADF: @p prog_fd or @p attachable_fd is not a valid file descriptor, or
+ *             @p prog_fd does not reference a loaded BPF program.
+ *   - -EINVAL: Unsupported @p type for the given attachable_fd, mismatch between
+ *              program's type/expected attach type and @p type, or kernel doesn't
+ *              support detach2 for this combination.
+ *   - -ENOENT: The specified program is not currently attached at the given hook
+ *              (it may have been detached already or never attached there).
+ *   - -EACCES / -EPERM: Insufficient privileges or blocked by security policy.
+ *   - -EOPNOTSUPP: Kernel lacks support for multi-program detachment for this
+ *                  attach type.
+ *   - Other negative codes: Propagated from underlying syscall (e.g., -ENOMEM
+ *     for transient resource issues).
+ *
+ * Example (detaching a cgroup eBPF program):
+ *   int prog_fd = bpf_prog_load(...);
+ *   int cg_fd   = open("/sys/fs/cgroup/mygroup", O_RDONLY);
+ *   // (Assume program was previously attached via bpf_prog_attach or link API)
+ *   if (bpf_prog_detach2(prog_fd, cg_fd, BPF_CGROUP_INET_INGRESS) < 0) {
+ *       perror("bpf_prog_detach2");
+ *   }
+ *
+ * @param prog_fd        File descriptor of the loaded BPF program to be detached.
+ * @param attachable_fd  File descriptor of the attach point (e.g., cgroup FD, perf
+ *                       event FD, socket-like FD, prog array FD).
+ * @param type           BPF attach type (enum bpf_attach_type) identifying the hook
+ *                       from which to detach this program. Must match the original
+ *                       attach type used when the program was attached.
+ *
+ * @return 0 on success; < 0 on failure (negative error code as described above).
+ */
 LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
 				enum bpf_attach_type type);
 
@@ -975,7 +1244,50 @@ struct bpf_prog_test_run_attr {
 	__u32 ctx_size_out; /* in: max length of ctx_out
 			     * out: length of cxt_out */
 };
-
+/**
+ * @brief Retrieve the next existing BPF program ID after a given starting ID.
+ *
+ * This helper wraps the kernel's BPF_PROG_GET_NEXT_ID command and enumerates
+ * system-wide BPF program IDs in strictly ascending order. It is typically used
+ * to iterate over all currently loaded BPF programs from user space.
+ *
+ * Enumeration pattern:
+ *   1. Initialize start_id to 0 to obtain the first (lowest) existing program ID.
+ *   2. On success, *next_id is set to the next valid ID greater than start_id.
+ *   3. Use the returned *next_id as the new start_id for the subsequent call.
+ *   4. Repeat until the function returns -ENOENT, indicating there is no program
+ *      with ID greater than start_id (end of enumeration).
+ *
+ * Concurrency & races:
+ *   - Program creation/destruction can race with enumeration. A program whose
+ *     ID you just retrieved might disappear (be unloaded) before you convert
+ *     it to a file descriptor (e.g., via bpf_prog_get_fd_by_id()). Always
+ *     handle failures when opening by ID.
+ *   - Enumeration does not provide a consistent snapshot; newly created
+ *     programs may appear after you pass their would-be predecessor ID.
+ *
+ * Lifetime considerations:
+ *   - IDs are monotonically increasing and not reused until wraparound (which
+ *     is practically unreachable in normal operation).
+ *   - Successfully retrieving an ID does not pin or otherwise prevent program
+ *     unloading; obtain an FD immediately if you need to interact with it.
+ *
+ *
+ * @param start_id
+ *        Starting point for the search. The helper finds the first program ID
+ *        strictly greater than start_id. Use 0 to begin enumeration.
+ * @param next_id
+ *        Pointer to a __u32 that receives the next program ID on success.
+ *        Must not be NULL.
+ *
+ * @return
+ *        0        on success (next_id populated);
+ *        -ENOENT  if there is no program ID greater than start_id (end of iteration);
+ *        -EINVAL  if next_id is NULL or invalid arguments were supplied;
+ *        -EPERM / -EACCES if denied by security policy or lacking required privileges;
+ *        Other negative libbpf-style errors (-errno) on transient or system failures.
+ *
+ */
 LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
 /**
  * @brief Retrieve the next existing BPF map ID after a given starting ID.
@@ -1035,8 +1347,88 @@ struct bpf_get_fd_by_id_opts {
 	size_t :0;
 };
 #define bpf_get_fd_by_id_opts__last_field token_fd
-
+/**
+ * @brief Convert a kernel-assigned BPF program ID into a process-local file descriptor.
+ *
+ * bpf_prog_get_fd_by_id() wraps the BPF_PROG_GET_FD_BY_ID command of the
+ * bpf(2) syscall. Given a stable, monotonically increasing program ID, it
+ * returns a new file descriptor referring to that loaded BPF program, allowing
+ * user space to inspect or further manage the program (e.g. query info, attach,
+ * pin, update links).
+ *
+ * Typical enumeration + open pattern:
+ *   __u32 id = 0, next;
+ *   while (!bpf_prog_get_next_id(id, &next)) {
+ *       int prog_fd = bpf_prog_get_fd_by_id(next);
+ *       if (prog_fd >= 0) {
+ *           // Use prog_fd (e.g. bpf_prog_get_info_by_fd(), attach, pin, etc.)
+ *           close(prog_fd);
+ *       }
+ *       id = next;
+ *   }
+ *   // Loop ends when bpf_prog_get_next_id() returns -ENOENT.
+ *
+ *
+ * @param id Kernel-assigned unique (non-zero) BPF program ID.
+ *
+ * @return
+ *   >= 0 : File descriptor referring to the BPF program (caller must close()).
+ *   < 0  : Negative error code (libbpf-style, see list above).
+ */
 LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
+/**
+ * @brief Obtain a file descriptor for an existing BPF program by its kernel-assigned ID,
+ *        with extended open options.
+ *
+ * This function is an extended variant of bpf_prog_get_fd_by_id(). It wraps the
+ * BPF_PROG_GET_FD_BY_ID command of the bpf(2) syscall and converts a stable BPF
+ * program ID into a process-local file descriptor, honoring optional attributes
+ * supplied via @p opts.
+ *
+ * Typical usage pattern:
+ *   1. Enumerate program IDs with bpf_prog_get_next_id().
+ *   2. For each ID, call bpf_prog_get_fd_by_id_opts() to obtain a program FD.
+ *   3. Use the FD (e.g., bpf_prog_get_info_by_fd(), attach, pin, link operations).
+ *   4. close() the FD when no longer needed.
+ *
+ * Example:
+ *   __u32 id = ...; // obtained via bpf_prog_get_next_id()
+ *   struct bpf_get_fd_by_id_opts o = {
+ *       .sz = sizeof(o),
+ *       .open_flags = 0,
+ *   };
+ *   int prog_fd = bpf_prog_get_fd_by_id_opts(id, &o);
+ *   if (prog_fd < 0) {
+ *       // handle error
+ *   } else {
+ *       // use prog_fd
+ *       close(prog_fd);
+ *   }
+ *
+ * @param id
+ *        Kernel-assigned unique (non-zero) BPF program ID, typically obtained via
+ *        bpf_prog_get_next_id() or from a prior info query. Must be > 0.
+ * @param opts
+ *        Optional pointer to a zero-initialized struct bpf_get_fd_by_id_opts controlling
+ *        open behavior. May be NULL for defaults. Fields:
+ *          - sz: Must be set to sizeof(struct bpf_get_fd_by_id_opts) for forward/backward
+ *                compatibility if @p opts is non-NULL.
+ *          - open_flags: Requested open/access flags (kernel-specific; pass 0 unless a
+ *                documented flag is needed). Unsupported flags yield -EINVAL.
+ *          - token_fd: FD of a BPF token providing delegated permissions (set to -1 or 0
+ *                if unused). If provided, enables restricted environments to open the
+ *                program without elevated global capabilities.
+ *
+ * @return
+ *   >= 0 : File descriptor referring to the BPF program (caller must close()).
+ *   < 0  : Negative libbpf-style error code (typically -errno):
+ *            - -ENOENT  : No program with @p id (unloaded or never existed).
+ *            - -EPERM / -EACCES : Insufficient privileges / denied by policy.
+ *            - -EINVAL  : Bad @p id, malformed @p opts, or unsupported flags.
+ *            - -ENOMEM  : Transient kernel resource exhaustion.
+ *            - Other negative codes: Propagated bpf() syscall errors.
+ *
+ */
 LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
 /**
@@ -1272,6 +1664,83 @@ struct bpf_prog_query_opts {
  */
 LIBBPF_API int bpf_prog_query_opts(int target, enum bpf_attach_type type,
 				   struct bpf_prog_query_opts *opts);
+/**
+ * @brief Query BPF programs attached to a given target (legacy/simple interface).
+ *
+ * bpf_prog_query() wraps the BPF_PROG_QUERY command of the bpf(2) syscall and
+ * retrieves information about one or more BPF programs attached to an attach
+ * point represented by @p target_fd for a specific attach @p type. For richer
+ * queries (including link IDs and per-program attach flags) use
+ * bpf_prog_query_opts(), which supersedes this API.
+ *
+ * Typical usage pattern:
+ *   1. Set *prog_cnt to the capacity (number of elements) of the @p prog_ids
+ *      buffer.
+ *   2. Call bpf_prog_query().
+ *   3. On success:
+ *        - If @p attach_flags is non-NULL, *attach_flags contains global
+ *          attach flags for the hook (e.g., multi-attach, replace semantics).
+ *        - *prog_cnt is updated with the number of program IDs actually written.
+ *        - prog_ids[0 .. *prog_cnt-1] holds the program IDs (ascending order
+ *          is typical but not guaranteed).
+ *
+ * Concurrency & races:
+ *   - Programs may be attached or detached concurrently. The returned list is
+ *     a snapshot at the moment of the query; programs might disappear before
+ *     you turn their IDs into FDs (via bpf_prog_get_fd_by_id()).
+ *   - Always check subsequent opens for -ENOENT.
+ *
+ * Buffer management:
+ *   - On input, *prog_cnt must reflect the capacity of @p prog_ids.
+ *   - On output, *prog_cnt is set to the number of IDs returned (0 is valid).
+ *   - If @p prog_ids is NULL, the call can still populate @p attach_flags (if
+ *     provided) and report whether any programs are attached by returning
+ *     *prog_cnt == 0 (legacy kernels may return -EINVAL in this case).
+ *
+ * @param target_fd
+ *        File descriptor of the attach point (e.g., a cgroup FD, perf event FD,
+ *        or other object that supports @p type).
+ * @param type
+ *        BPF attach type (enum bpf_attach_type) describing which hook to query
+ *        (must match how programs were attached).
+ * @param query_flags
+ *        Optional refinement flags (must be 0 unless specific flags are
+ *        supported by the running kernel; unsupported flags yield -EINVAL).
+ * @param attach_flags
+ *        Optional output pointer to receive aggregate attach flags describing
+ *        the state/behavior of the attach point. Pass NULL to ignore.
+ * @param prog_ids
+ *        Caller-provided array to receive program IDs; may be NULL only if
+ *        *prog_cnt == 0 or when only @p attach_flags is of interest (kernel
+ *        version dependent).
+ * @param prog_cnt
+ *        In: capacity (number of elements) in @p prog_ids.
+ *        Out: number of program IDs actually written. Must not be NULL.
+ *
+ * @return
+ *        0 on success (results populated as described);
+ *        < 0 a negative libbpf-style error code (typically -errno):
+ *          - -EINVAL: Bad arguments (NULL prog_cnt, unsupported query/type,
+ *                     invalid flags, insufficient buffer) or target_fd not a
+ *                     valid attach point for @p type.
+ *          - -ENOENT: No program(s) of this @p type attached (older kernels may
+ *                     use 0 + *prog_cnt == 0 instead).
+ *          - -EPERM / -EACCES: Insufficient privileges (CAP_BPF/CAP_SYS_ADMIN)
+ *                              or blocked by security policy.
+ *          - -EBADF: target_fd is not a valid file descriptor.
+ *          - -EFAULT: User memory (prog_ids / attach_flags / prog_cnt) is
+ *                    unreadable or unwritable.
+ *          - -ENOMEM: Transient kernel memory/resource exhaustion.
+ *          - Other negative codes: Propagated syscall failures.
+ *
+ * Post-processing:
+ *   - Convert each returned program ID to an FD with bpf_prog_get_fd_by_id()
+ *     for further introspection or management.
+ *
+ * Recommended alternative:
+ *   - Prefer bpf_prog_query_opts() for new code; it supports link enumeration,
+ *     per-program attach flags, revision checks, and future extensions.
+ */
 LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
 			      __u32 query_flags, __u32 *attach_flags,
 			      __u32 *prog_ids, __u32 *prog_cnt);
@@ -1305,7 +1774,57 @@ struct bpf_prog_bind_opts {
 	__u32 flags;
 };
 #define bpf_prog_bind_opts__last_field flags
-
+/**
+ * @brief Bind (associate) an already loaded BPF program with an existing BPF map.
+ *
+ * bpf_prog_bind_map() is a low-level libbpf helper wrapping the
+ * BPF_PROG_BIND_MAP kernel command. It establishes (or updates) an
+ * association between a loaded BPF program (prog_fd) and a map (map_fd)
+ * that the program is expected to reference at run time. This allows
+ * certain late binding or rebinding scenarios (e.g., providing a map that
+ * could not be created or located at initial program load time, or
+ * updating a program's backing/global data map after load). The exact
+ * semantics and which map types are supported are kernel-version dependent;
+ * unsupported combinations will fail with an error.
+ *
+ * Typical use cases:
+ *   - Late injection of a data/config map into a program that was loaded
+ *     without direct access to that map.
+ *   - Rebinding a program to a replacement map (e.g., upgraded layout),
+ *     where the kernel permits such updates without reloading the program.
+ *   - Establishing program <-> map relationship needed for specific kernel
+ *     features (e.g., global data sections, special helper expectations,
+ *     or JIT/runtime adjustments).
+ *
+ *
+ * Recommended pattern:
+ *   struct bpf_prog_bind_opts opts = {
+ *       .sz = sizeof(opts),
+ *       .flags = 0,
+ *   };
+ *   if (bpf_prog_bind_map(prog_fd, map_fd, &opts) < 0) {
+ *       perror("bpf_prog_bind_map");
+ *       // handle failure
+ *   }
+ *
+ * @param prog_fd File descriptor of an already loaded BPF program.
+ * @param map_fd  File descriptor of the BPF map to bind to the program.
+ * @param opts    Optional pointer to bpf_prog_bind_opts (may be NULL for defaults).
+ *                Must have opts->sz set when non-NULL. opts->flags must be 0 unless
+ *                documented otherwise.
+ *
+ * @return 0 on success; negative error code (< 0) on failure.
+ *
+ * Error handling (negative libbpf-style return codes; errno set):
+ *   - -EBADF: prog_fd or map_fd is not a valid descriptor.
+ *   - -EINVAL: Invalid arguments, unsupported map/program type combination,
+ *              malformed opts, bad flags, or kernel does not support binding.
+ *   - -EPERM / -EACCES: Insufficient privileges (CAP_BPF/CAP_SYS_ADMIN) or
+ *                       blocked by LSM / lockdown policy.
+ *   - -ENOENT: The referenced program or map no longer exists (race).
+ *   - -ENOMEM: Transient kernel resource exhaustion.
+ *   - Other negative codes: Propagated from underlying bpf() syscall.
+ */
 LIBBPF_API int bpf_prog_bind_map(int prog_fd, int map_fd,
 				 const struct bpf_prog_bind_opts *opts);
 
@@ -1331,7 +1850,131 @@ struct bpf_test_run_opts {
 	__u32 batch_size;
 };
 #define bpf_test_run_opts__last_field batch_size
-
+/**
+ * @brief Execute a loaded BPF program in a controlled (synthetic) context and
+ *        collect its return code, output data, and timing statistics.
+ *
+ * bpf_prog_test_run_opts() is a high-level wrapper around the kernel's
+ * BPF_PROG_TEST_RUN command. It allows user space to "test run" a program
+ * without attaching it to a live hook, supplying optional input data
+ * (data_in), optional execution context (ctx_in), and retrieving any
+ * transformed output data (data_out), context (ctx_out), program return
+ * value, and average per-run duration in nanoseconds.
+ *
+ * Typical purposes:
+ *   - Unit-style testing of program logic (e.g., XDP, TC, SK_MSG) before
+ *     deployment.
+ *   - Verifying correctness of packet mangling or map access patterns.
+ *   - Microbenchmarking via repeat execution (repeat > 1).
+ *   - Exercising program behavior under different synthetic contexts.
+ *
+ * Usage pattern (minimal):
+ *   struct bpf_test_run_opts opts = {};
+ *   opts.sz           = sizeof(opts);
+ *   opts.data_in      = pkt;
+ *   opts.data_size_in = pkt_len;
+ *   opts.data_out     = out_buf;
+ *   opts.data_size_out = out_buf_cap;
+ *   opts.repeat       = 1000;
+ *   if (bpf_prog_test_run_opts(prog_fd, &opts) == 0) {
+ *       printf("prog retval=%u avg_ns=%u out_len=%u\n",
+ *              opts.retval, opts.duration, opts.data_size_out);
+ *   } else {
+ *       perror("bpf_prog_test_run_opts");
+ *   }
+ *
+ * Structure initialization notes:
+ *   - opts.sz MUST be set to sizeof(struct bpf_test_run_opts) for
+ *     forward/backward compatibility.
+ *   - All unused fields should be zeroed (memset(&opts, 0, sizeof(opts))).
+ *   - Omit (leave NULL/zero) optional buffers you don't need (e.g., ctx_out).
+ *
+ * Input fields (set by caller):
+ *   - data_in / data_size_in:
+ *       Optional raw input buffer fed to the program. For packet-oriented
+ *       types (e.g., XDP) this simulates an ingress frame. If data_in is
+ *       NULL, data_size_in must be 0.
+ *   - data_out / data_size_out:
+ *       Optional buffer receiving (potentially) modified data. On success
+ *       data_size_out is updated with actual bytes written. If data_out
+ *       is NULL, set data_size_out = 0 (no output capture).
+ *   - ctx_in / ctx_size_in:
+ *       Optional synthetic context (e.g., struct xdp_md) passed to the
+ *       program. Only meaningful for program types expecting a context
+ *       argument. If unused, leave NULL/0.
+ *   - ctx_out / ctx_size_out:
+ *       Optional buffer to retrieve (possibly altered) context. Provide
+ *       initial max size in ctx_size_out. Set ctx_out NULL if not needed.
+ *   - repeat:
+ *       Number of times to run the program back-to-back. If > 1 the kernel
+ *       accumulates total time and returns averaged per-run duration in
+ *       opts.duration. Use for stable timing. If 0 or 1, program executes
+ *       exactly once.
+ *   - flags:
+ *       Feature/control flags (must be 0 unless a supported kernel extension
+ *       is documented; unknown bits yield errors).
+ *   - cpu:
+ *       Optional CPU index hint for program types allowing per-CPU execution
+ *       binding during test runs (e.g., for percpu data semantics). If 0 and
+ *       not meaningful for the program type, ignored. If unsupported, call
+ *       may fail with -EINVAL.
+ *   - batch_size:
+ *       For program types that support batched test execution (kernel-
+ *       dependent). Each test iteration may process up to batch_size items
+ *       internally. Leave 0 unless specifically targeting a batched mode.
+ *
+ * Output fields (populated on success):
+ *   - data_size_out:
+ *       Actual number of bytes written to data_out (may be <= original
+ *       capacity; unchanged if no output).
+ *   - ctx_size_out:
+ *       Actual number of bytes written to ctx_out (if provided).
+ *   - retval:
+ *       Program's return value (semantics depend on program type; e.g.,
+ *       XDP_* action code for XDP programs).
+ *   - duration:
+ *       Average per run execution time in nanoseconds (only meaningful
+ *       when repeat > 0; may be 0 if kernel cannot measure).
+ *
+ * Concurrency & isolation:
+ *   - Test runs occur in isolation from live attachment points; no real
+ *     packets, sockets, or kernel events are consumed.
+ *   - Map interactions are real: the program can read/update maps during
+ *     test runs. Ensure maps are in a suitable state.
+ *
+ * Data & context lifetime:
+ *   - Kernel copies input data/context before executing; caller can reuse
+ *     buffers after return.
+ *   - Output buffers must be writable and sufficiently sized; truncation
+ *     occurs if too small (reported via size_out fields).
+ *
+ * Performance measurement guidance:
+ *   - Use a sufficiently large repeat count (hundreds/thousands) to
+ *     smooth timing variance.
+ *   - Avoid measuring with data_out/ctx_out unless necessary; copying
+ *     increases overhead.
+ *
+ *
+ * @param prog_fd
+ *        File descriptor of the loaded BPF program to test.
+ * @param opts
+ *        Pointer to an initialized bpf_test_run_opts describing input,
+ *        output, and execution parameters. Must not be NULL.
+ *
+ * @return 0 on success; negative error code (< 0) on failure (errno is also set).
+ *
+ * Error handling (return value < 0, errno set):
+ *   - -EINVAL: Malformed opts (missing sz), unsupported flags, invalid
+ *              buffer sizes, or program type mismatch.
+ *   - -EPERM / -EACCES: Insufficient privileges (CAP_BPF / CAP_SYS_ADMIN)
+ *                       or restricted by LSM/lockdown.
+ *   - -EFAULT: Bad user pointers (data_in/out or ctx_in/out).
+ *   - -ENOMEM: Kernel resource allocation failure.
+ *   - -ENOTSUP / -EOPNOTSUPP: Test run unsupported for this program type
+ *                             or kernel version.
+ *   - Other negative codes: Propagated from underlying bpf() syscall.
+ *
+ */
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
 
-- 
2.34.1


