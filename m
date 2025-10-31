Return-Path: <bpf+bounces-73102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6BC232D8
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 04:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD60401353
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 03:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654B27F163;
	Fri, 31 Oct 2025 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au7UZSF6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90626FD86
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881256; cv=none; b=auAx07UvRQby9jJxq0bx4iJU3c0WtT7LwoOM9+5FOhWEQ/e5p+fyXKYr20T2vFSQP6IfxlRKiRHTQ9GRX42oFiCD+vQPOCUAs7L3vHwQP8e/qRP4AFKvBu/PWqF6olJ4grPmYlmSgjzeNTfuRX6XAsR64gSuRYKe3H2pEy9fn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881256; c=relaxed/simple;
	bh=NER14kUbeRf+WjWrvzlR2qHWgmjXtl1WdNshvRQVOM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfwCkkCRVmvZHwNbWQuvXfSYR2LN2w0lXMGUBEzXzPD7f+WYmZKJk/5lNbfAnZA4KG3BSN3SVqGC/qRVcyqAYsRx/iurcXyvq9lnNBKnA0IBzyHzz9TpIRr5ujmOE9yomtwyKHTI9qGohv6aa/s0VmEQrgUxX6aM2uPnGloOTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au7UZSF6; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so1773148b3a.2
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 20:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761881253; x=1762486053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u5Jn+0QKZeIMMkU/tcEYNiZL6udrCAF3v8WbghiuSA=;
        b=au7UZSF6GR8Q5pXM6+cxJ72ESewDpo3dL+8rpNqbE5WE1dJDNreVggQwVCFNQATadc
         uaAZvvxHTf6MIW+kio/ntUqcf2l86lajdrv5v5OTlIN8cyuxVGVSi7DgR98/seXZCupT
         p9FVISxTTDMJ8zy/cpJqvIIWGKJrc6JhC1X0ZOMiJlYahgDPcpeFL1ASpcBzDnkfkSos
         WvjR9DuQhM9Hc7tcOamYwtNbu9iqqFAaUqtAb+8bbtuZKaVoGOykmQ/fATed0lXBTFwc
         VlgT5MFdOij5MTKMDfooIiepPbRvrvfdYKdUqLA/9IfQuhhv/ovgJ0W9yQ2NeiYC81oC
         V8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761881253; x=1762486053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u5Jn+0QKZeIMMkU/tcEYNiZL6udrCAF3v8WbghiuSA=;
        b=pYb9UufA9Oa//Im28NytaWFMNKU/dzdVUjEJEZjTb8JiFYNoKelx4D46/c078A3Xsk
         5oH5smiTRvS8lSQoNiihRMrCeplyBlfnLI+zz00daJ1R2q/96h8pZNonCToRdk9U4kkD
         6h6zmeVmG84eC37Q3bF0nqXEjUu8adl4IUUPbP39D4uYrXO5TfBTRmVSZwDzJB8u9rxM
         64o6qpwIbibeGptxxzxTQiMvs2x2/eOTmVxLR/ZqeWZDxHu/yw+zJ4rZivp4mNd6FxeD
         MNZcqAgF2JXAxO5Xl1LTv0LUU4ckSr1UgGtt06YI7yzfsLEuy2ZMyBXvTBNwMdz7ibCA
         m6HQ==
X-Gm-Message-State: AOJu0YzIXwxQu3XABCsSZBpEddQqRBo5PjaKXvm8U6/dcA8HfrLeS2Fg
	EzMIVUDaaCF6zNnkLjX5w2tYagNfEXb1Rg5PaOCyxISmy1XlPRRjBFQUJSdWGugL
X-Gm-Gg: ASbGncvnovsv5nxeMtI/n7iHfbJgKo2TxJfeodXhsixW3O2FwUmCYkMm5YAkfYTSINV
	krNYlXupOa/1Og7/qLRZyHfqJQPQdxMezUjyMqAkn6aah54TYlKBhQ/cZYnkIpaMIn+2Xy3WDVD
	yohHwuco2cqrItSfaKs4lHK9ZwKQ8frFgcP+jYor+ZxlBWKma9BVmQ2XOpjTRHnBowt3tC0jHyq
	glCvX5ynj4ZgluXevBs65pWHgkzU9ilY4mtQSlD8rXabieF5WMglSM15QDuVJIcf4URF5BuzX+t
	ds0so6DmT+NF4xgsFjakKsYk8Wg0QVShUwLAv5nsXJ7A12z/7hAQmIjiliPXmN5dj3flt6M5yra
	kZJFo+4lYRd2ongCLkk0yJ4Qq86wJrfsQ609Xzeq3BWZBnLNYuKQHvnv1CES6nIwNpC8k35eKTB
	nLb0sUuZw4jnbgZ8LKmg==
X-Google-Smtp-Source: AGHT+IGQDv+PQlTA+MCofSeNxlugQzrVwQE39+DQMR/cxq5bc+D2bgAuP2Bv/mDyWKi2niZXN9Gjog==
X-Received: by 2002:a05:6a20:734b:b0:262:c083:bb41 with SMTP id adf61e73a8af0-348c9f671b8mr2591218637.3.1761881252531;
        Thu, 30 Oct 2025 20:27:32 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897ed6csm418406b3a.13.2025.10.30.20.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:27:31 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: bpf@vger.kernel.org
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
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH 3/5] libbpf: Add doxygen documentation for bpf_link_* APIs in bpf.h
Date: Fri, 31 Oct 2025 11:26:24 +0800
Message-Id: <20251031032627.1414462-4-jianyungao89@gmail.com>
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

Add doxygen comment blocks for all public bpf_link_* APIs in
tools/lib/bpf/bpf.h. These doc comments are for:

-bpf_link_create()
-bpf_link_detach()
-bpf_link_update()
-bpf_link_get_next_id()
-bpf_link_get_fd_by_id()
-bpf_link_get_fd_by_id_opts()

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 tools/lib/bpf/bpf.h | 482 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 479 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 0b1a0113e7c4..a9fb5948ecd4 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -1203,11 +1203,195 @@ struct bpf_link_create_opts {
 	size_t :0;
 };
 #define bpf_link_create_opts__last_field uprobe_multi.pid
-
+/**
+ * @brief Create a persistent BPF link that attaches a loaded BPF program to a
+ *        kernel hook or target object.
+ *
+ * bpf_link_create() wraps the BPF_LINK_CREATE syscall command and establishes
+ * a first–class in‑kernel "link" object representing the attachment of
+ * @p prog_fd to @p target_fd (or to a kernel entity implied by @p attach_type).
+ * The returned FD (>= 0) owns the lifetime of that attachment: closing it
+ * cleanly detaches the program without requiring a separate detach syscall.
+ *
+ * Compared to legacy bpf_prog_attach()/bpf_raw_tracepoint_open(), link-based
+ * attachment:
+ *   - Provides explicit lifetime control (close(link_fd) == detach).
+ *   - Enables richer introspection via bpf_link_get_info_by_fd().
+ *   - Avoids ambiguous detach semantics and races inherent in "implicit detach
+ *     on last program FD close" patterns.
+ *
+ * Typical usage:
+ *   struct bpf_link_create_opts opts = {
+ *       .sz = sizeof(opts),
+ *       .flags = 0,
+ *   };
+ *   int link_fd = bpf_link_create(prog_fd, target_fd, BPF_TRACE_FENTRY, &opts);
+ *   if (link_fd < 0) {
+ *       // handle error
+ *   }
+ *   // ... use link_fd; close(link_fd) to detach later.
+ *
+ * @param prog_fd
+ *        File descriptor of a previously loaded BPF program (from bpf_prog_load()
+ *        or libbpf higher-level loader). Must be valid and compatible with
+ *        @p attach_type.
+ *
+ * @param target_fd
+ *        File descriptor of the attach target, when required by @p attach_type
+ *        (e.g. a cgroup FD, perf event FD, network interface, or another BPF
+ *        object). For some attach types (e.g. certain tracing variants) this may
+ *        be -1 or ignored; passing an inappropriate FD yields -EINVAL.
+ *
+ * @param attach_type
+ *        Enumeration value (enum bpf_attach_type) describing the hook/context
+ *        at which the program should be executed (e.g. BPF_CGROUP_INET_INGRESS,
+ *        BPF_TRACE_FENTRY, BPF_PERF_EVENT, BPF_NETFILTER, etc.). The program's
+ *        bpf_prog_type and expected_attach_type must be compatible; otherwise
+ *        verification will fail or the syscall returns -EINVAL/-EOPNOTSUPP.
+ *
+ * @param opts
+ *        Optional pointer to a zero-initialized struct bpf_link_create_opts
+ *        extended options; may be NULL for defaults. Must set opts->sz to
+ *        sizeof(struct bpf_link_create_opts) when non-NULL.
+ *
+ *        Common fields:
+ *          - .flags: Link creation flags (most callers set 0; future kernels
+ *            may define bits for pinning behaviors, exclusivity, etc.).
+ *          - .target_btf_id: For BTF-enabled tracing/fentry/fexit/kprobe multi
+ *            scenarios, identifies a BTF entity (function/type) this link
+ *            targets.
+ *          - .iter_info / .iter_info_len: Provide iterator-specific metadata
+ *            for BPF iter programs.
+ *
+ *        Attach-type specific nested unions:
+ *          - .perf_event.bpf_cookie: User-defined cookie visible to program via
+ *            bpf_get_attach_cookie() for PERF_EVENT and some tracing types.
+ *          - .kprobe_multi: Batch (multi) kprobe attachment:
+ *                * flags: KPROBE_MULTI_* flags controlling semantics.
+ *                * cnt: Number of symbols/addresses.
+ *                * syms / addrs: Symbol names or raw addresses (one of them
+ *                  used depending on kernel capabilities).
+ *                * cookies: Optional per-probe cookies.
+ *          - .uprobe_multi: Batch uprobes:
+ *                * path: Target binary path.
+ *                * offsets / ref_ctr_offsets: Instruction/file offsets and
+ *                  optional reference counter offsets.
+ *                * pid: Target PID (0 for any or to let kernel decide).
+ *                * cookies: Per-uprobe cookies.
+ *          - .tracing.cookie: Generic tracing cookie for newer tracing types.
+ *          - .netfilter: Attaching to Netfilter with:
+ *                * pf (protocol family), hooknum, priority, flags.
+ *          - .tcx / .netkit / .cgroup: Relative attachment variants allowing
+ *            multi-attach ordering and revision consistency:
+ *                * relative_fd / relative_id: Anchor or neighbor link/program.
+ *                * expected_revision: Revision check to avoid races (fail with
+ *                  -ESTALE if mismatch).
+ *
+ *        Zero any fields you do not explicitly use for forward compatibility.
+ *
+ * @return
+ *   >= 0 : Link file descriptor (attachment active).
+ *   < 0  : Negative error code (attachment failed; program not attached).
+ *
+ * Error Handling (negative libbpf-style codes; errno also set):
+ *   - -EINVAL: Invalid prog_fd/target_fd/attach_type combination, malformed
+ *              opts, bad sizes, unsupported flags, or missing required union
+ *              fields.
+ *   - -EOPNOTSUPP / -ENOTSUP: Attach type or creation mode unsupported by
+ *              running kernel.
+ *   - -EPERM / -EACCES: Insufficient privileges (CAP_BPF/CAP_SYS_ADMIN) or
+ *              blocked by LSM/lockdown.
+ *   - -ENOENT: Target object no longer exists (race) or unresolved symbol for
+ *              kprobe/uprobes multi-attach.
+ *   - -EBADF: Invalid file descriptor(s).
+ *   - -ENOMEM: Kernel memory/resource exhaustion.
+ *   - -ESTALE: Revision mismatch when using expected_revision (atomicity guard).
+ *   - Other negative codes: Propagated from underlying bpf() syscall failures.
+ *
+ * Lifetime & Ownership:
+ *   - Success returns a link FD. Caller must close() it to detach.
+ *   - Closing the original program FD does NOT detach the link; only closing
+ *     the link FD (or explicit bpf_link_detach()) does.
+ *   - Link FDs can be pinned to bpffs via bpf_obj_pin() for persistence.
+ *
+ * Concurrency & Races:
+ *   - Linking can fail if another concurrent operation changes target's state
+ *     (revision checks can mitigate using expected_revision).
+ *   - Multi-attach environments may reorder relative attachments if not using
+ *     relative_* fields; always inspect returned link state if ordering matters.
+ *
+ * Introspection:
+ *   - Use bpf_link_get_info_by_fd(link_fd, ...) to query link metadata
+ *     (program ID, attach type, target, cookies, multi-probe details).
+ *   - Enumerate existing links via bpf_link_get_next_id() then open with
+ *     bpf_link_get_fd_by_id().
+ *
+ */
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
 			       const struct bpf_link_create_opts *opts);
-
+/**
+ * @brief Detach (tear down) an existing BPF link represented by a link file descriptor.
+ *
+ * bpf_link_detach() issues the BPF_LINK_DETACH command to the kernel, breaking
+ * the association between a previously created BPF link (see bpf_link_create())
+ * and its target (cgroup, tracing hook, perf event, netfilter hook, etc.). After
+ * a successful call the program will no longer be invoked at that attach point.
+ *
+ * In most cases you do not need to call bpf_link_detach() explicitly; simply
+ * closing the link FD (close(link_fd)) also detaches the link. This helper is
+ * useful when you want to explicitly detach early while keeping the FD open for
+ * introspection (e.g., querying link info after detachment) or when building
+ * higher‑level lifecycle abstractions.
+ *
+ * Semantics:
+ *   - Success makes the in‑kernel link inactive; subsequent events at the hook
+ *     no longer trigger the program.
+ *   - The link FD itself does NOT automatically close; you are still responsible
+ *     for close(link_fd) to release user space resources.
+ *   - Repeated calls after a successful detach will fail (idempotency: only the
+ *     first detach succeeds).
+ *
+ * Typical usage:
+ *   int link_fd = bpf_link_create(prog_fd, target_fd, attach_type, &opts);
+ *   ...
+ *   if (bpf_link_detach(link_fd) < 0)
+ *       perror("bpf_link_detach");
+ *   close(link_fd); // optional: now just releases the FD
+ *
+ * Concurrency & races:
+ *   - Detaching can race with another thread closing or detaching the same link.
+ *     In such cases you may observe -EBADF or -ENOENT.
+ *   - Once detached, the program can be safely re‑attached elsewhere if desired
+ *     (requires a new link via bpf_link_create()).
+ *
+ * Privileges:
+ *   - Usually requires CAP_BPF and/or CAP_SYS_ADMIN depending on kernel
+ *     configuration, LSM, and lockdown mode. Lack of privileges yields -EPERM
+ *     or -EACCES.
+ *
+ * Post-detach:
+ *   - The program object remains loaded; its own FD is still valid and can be
+ *     attached again.
+ *   - Maps referenced by the program are unaffected.
+ *
+ * @param link_fd File descriptor of the active BPF link to detach; must have
+ *                been obtained via bpf_link_create() or equivalent.
+ *
+ * @return 0 on success; < 0 on failure (negative error code as described above).
+ *
+ * Error handling (negative libbpf-style return codes, errno also set):
+ *   - -EBADF: link_fd is not a valid open file descriptor.
+ *   - -EINVAL: link_fd does not refer to a BPF link, or the kernel does not
+ *              support BPF_LINK_DETACH for this link type.
+ *   - -ENOENT: Link already detached or no longer exists (race with close()).
+ *   - -EPERM / -EACCES: Insufficient privileges or denied by security policy.
+ *   - -EOPNOTSUPP / -ENOTSUP: Kernel lacks support for link detachment of this
+ *                             specific attach type.
+ *   - -ENOMEM: Transient kernel resource exhaustion (rare in this path).
+ *   - Other negative codes may be propagated from the underlying bpf() syscall.
+ *
+ */
 LIBBPF_API int bpf_link_detach(int link_fd);
 
 struct bpf_link_update_opts {
@@ -1217,7 +1401,89 @@ struct bpf_link_update_opts {
 	__u32 old_map_fd;  /* expected old map FD */
 };
 #define bpf_link_update_opts__last_field old_map_fd
-
+/**
+ * @brief Atomically replace (update) the BPF program or map referenced by an
+ *        existing link with a new program.
+ *
+ * bpf_link_update() wraps the BPF_LINK_UPDATE command of the bpf(2) syscall.
+ * It allows retargeting an already established BPF link (identified by
+ * link_fd) to point at a different loaded BPF program (new_prog_fd) without
+ * having to tear the link down (detach) and recreate it. This is typically
+ * used for hot‑swapping a program while preserving:
+ *   - Link pinning (bpffs path remains valid).
+ *   - Relative ordering in multi‑attach contexts (TC/XDP/cgroup revisions).
+ *   - Existing references held by other processes.
+ *
+ * Consistency & safety:
+ *   - The update is performed atomically: events arriving at the hook will
+ *     either see the old program before the call, or the new one after the
+ *     call; no window exists with an unattached link.
+ *   - Optional expectations can be enforced via @p opts to avoid races:
+ *       * old_prog_fd: Fail with -ESTALE if the link does not currently
+ *         reference that program.
+ *       * old_map_fd:  (Kernel dependent) Can be used when links encapsulate
+ *         a map association; if set and mismatched, update fails.
+ *       * flags: Future extension bits (must be 0 on current kernels).
+ *
+ * Typical usage:
+ *   struct bpf_link_update_opts u = {
+ *       .sz = sizeof(u),
+ *       .flags = 0,
+ *       .old_prog_fd = old_fd, // set to 0 to skip validation
+ *   };
+ *   if (bpf_link_update(link_fd, new_prog_fd, &u) < 0)
+ *       perror("bpf_link_update");
+ *
+ * Preconditions:
+ *   - link_fd must refer to a valid, updatable BPF link. Not all link types
+ *     support in‑place program replacement; unsupported types return -EOPNOTSUPP.
+ *   - new_prog_fd must be a loaded BPF program whose type and expected attach
+ *     type are compatible with the link's attach context.
+ *   - If @p opts is non‑NULL, opts->sz MUST be set to sizeof(*opts).
+ *
+ * @param link_fd
+ *        File descriptor of the existing BPF link to be updated.
+ * @param new_prog_fd
+ *        File descriptor of the newly loaded BPF program that should replace
+ *        the currently attached program.
+ * @param opts
+ *        Optional pointer to bpf_link_update_opts controlling validation:
+ *          - sz: Structure size for forward/backward compatibility.
+ *          - flags: Reserved; must be 0 (unsupported bits yield -EINVAL).
+ *          - old_prog_fd: Expected current program FD (0 to skip check).
+ *          - old_map_fd:  Expected current map FD (0 to skip; kernel-specific).
+ *        Pass NULL for default (no expectation checks).
+ *
+ * @return
+ *   0        on success (link now points to new_prog_fd).
+ *  <0        negative libbpf-style error code (typically -errno):
+ *              - -EBADF: Invalid link_fd or new_prog_fd.
+ *              - -EINVAL: Malformed opts (bad sz/flags) or incompatible program type.
+ *              - -EOPNOTSUPP: Link type does not support updates.
+ *              - -EPERM / -EACCES: Insufficient privileges (CAP_BPF/CAP_SYS_ADMIN) or blocked by LSM.
+ *              - -ENOENT: Link no longer exists (race) or old_prog_fd refers to a non-existent program.
+ *              - -ESTALE: Expectation mismatch (old_prog_fd / old_map_fd differs).
+ *              - -ENOMEM: Kernel resource allocation failure.
+ *              - Other -errno codes propagated from the bpf() syscall.
+ *
+ * Postconditions:
+ *   - On success, the old program remains loaded; caller should close its FD
+ *     if no longer needed.
+ *   - Pinning status and link ID are preserved.
+ *   - Maps referenced by the new program must be valid; no automatic rebinding
+ *     occurs beyond program substitution.
+ *
+ * Caveats:
+ *   - If verifier features differ (e.g., CO-RE relocations) ensure the new
+ *     program was loaded with compatible expectations for the same hook.
+ *   - Updating to a program of a strictly different attach semantics (e.g.,
+ *     sleepable vs non-sleepable) is rejected if the link type disallows it.
+ *
+ * Thread safety:
+ *   - Safe to call concurrently with other update attempts; only one succeeds.
+ *   - Consumers of the link see either old or new program; intermediate states
+ *     are not observable.
+ */
 LIBBPF_API int bpf_link_update(int link_fd, int new_prog_fd,
 			       const struct bpf_link_update_opts *opts);
 
@@ -1333,6 +1599,72 @@ LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
  */
 LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
+/**
+ * @brief Retrieve the next existing BPF link ID after a given starting ID.
+ *
+ * This helper wraps the kernel's BPF_LINK_GET_NEXT_ID command and enumerates
+ * system‑wide BPF link objects (each representing a persistent attachment of
+ * a BPF program) in strictly ascending order of their kernel‑assigned IDs.
+ * It is typically used to iterate over all currently existing BPF links from
+ * user space.
+ *
+ * Enumeration pattern:
+ *   1. Initialize start_id to 0 to obtain the first (lowest) existing link ID.
+ *   2. On success, *next_id is set to the first link ID strictly greater than start_id.
+ *   3. Use the returned *next_id as the new start_id for the subsequent call.
+ *   4. Repeat until the function returns -ENOENT, indicating there is no link
+ *      with ID greater than start_id (end of enumeration).
+ *
+ * Concurrency & races:
+ *   - Links can be created or detached concurrently with enumeration. A link ID
+ *     you just retrieved might become invalid before you convert it to an FD
+ *     (via bpf_link_get_fd_by_id()). Always handle failures when opening by ID.
+ *   - Enumeration does not provide a consistent snapshot; links created after
+ *     you pass their predecessor ID may appear in later iterations.
+ *
+ * Lifetime considerations:
+ *   - Link IDs are monotonically increasing and not reused until wraparound
+ *     (effectively unreachable in normal operation).
+ *   - Successfully retrieving an ID does not pin or otherwise prevent link
+ *     detachment; obtain an FD immediately if you need to interact with the link.
+ *
+ * Usage example:
+ *   __u32 id = 0, next;
+ *   while (bpf_link_get_next_id(id, &next) == 0) {
+ *       int link_fd = bpf_link_get_fd_by_id(next);
+ *       if (link_fd >= 0) {
+ *           // Inspect link (e.g., bpf_link_get_info_by_fd(link_fd))
+ *           close(link_fd);
+ *       }
+ *       id = next;
+ *   }
+ *   // Loop terminates when -ENOENT is returned.
+ *
+ * @param start_id
+ *        Starting point for the search. The helper finds the first link ID
+ *        strictly greater than start_id. Use 0 to begin enumeration.
+ * @param next_id
+ *        Pointer to a __u32 that receives the next link ID on success.
+ *        Must not be NULL.
+ *
+ * @return
+ *        0        on success (next_id populated);
+ *        -ENOENT  if there is no link ID greater than start_id (end of iteration);
+ *        -EINVAL  if next_id is NULL or invalid arguments were supplied;
+ *        -EPERM / -EACCES if denied by security policy or lacking required privileges;
+ *        Other negative libbpf-style errors (-errno) on transient or system failures.
+ *
+ * Error handling notes:
+ *   - Treat -ENOENT as normal termination (not an error condition).
+ *   - For other negative returns, errno will also be set to the underlying cause.
+ *
+ * After enumeration:
+ *   - Convert retrieved IDs to FDs with bpf_link_get_fd_by_id() for introspection
+ *     or detachment (via bpf_link_detach()).
+ *   - Closing the FD does not destroy the link if other references remain (e.g.,
+ *     pinned in bpffs); the link persists until explicitly detached or all
+ *     references are released.
+ */
 LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
 
 struct bpf_get_fd_by_id_opts {
@@ -1543,9 +1875,153 @@ LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_btf_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
+/**
+ * @brief Obtain a file descriptor for an existing BPF link given its kernel-assigned ID.
+ *
+ * bpf_link_get_fd_by_id() wraps the BPF_LINK_GET_FD_BY_ID command of the bpf(2)
+ * syscall. A BPF "link" is a persistent in‑kernel object representing an
+ * attachment of a BPF program to some hook (cgroup, tracing point, perf event,
+ * netfilter hook, tc/xdp chain, etc.). Each link has a unique, monotonically
+ * increasing ID. This helper converts such an ID into a process‑local file
+ * descriptor, allowing user space to inspect, pin, update, or detach the link.
+ *
+ * Typical enumeration + open pattern:
+ *   __u32 id = 0, next;
+ *   while (bpf_link_get_next_id(id, &next) == 0) {
+ *       int link_fd = bpf_link_get_fd_by_id(next);
+ *       if (link_fd >= 0) {
+ *           // Use link_fd (e.g. bpf_link_get_info_by_fd(), bpf_link_detach(), pin)
+ *           close(link_fd);
+ *       }
+ *       id = next;
+ *   }
+ *   // Loop terminates when bpf_link_get_next_id() returns -ENOENT.
+ *
+ * Concurrency & races:
+ *   - A link may be detached (or otherwise invalidated) between discovering its ID
+ *     and calling this function. In that case the call fails with -ENOENT.
+ *   - Successfully retrieving a file descriptor does not prevent later detachment
+ *     by other processes; always handle subsequent operation failures gracefully.
+ *
+ * Lifetime & ownership:
+ *   - On success, the caller owns the returned FD and must close() it when done.
+ *   - Closing the FD decreases the user space reference count; the underlying link
+ *     persists while any references (FDs or pinned bpffs path) remain.
+ *   - Detaching the link (via bpf_link_detach() or closing the last active FD)
+ *     invalidates future operations on that FD.
+ *
+ * Privileges / access control:
+ *   - May require CAP_BPF and/or CAP_SYS_ADMIN depending on kernel configuration,
+ *     LSM policy, or lockdown mode. Lack of privileges yields -EPERM / -EACCES.
+ *   - Security policies can deny access even if the link ID exists.
+ *
+ * Error handling (negative libbpf-style codes; errno is also set):
+ *   - -ENOENT: No link with the specified ID (never existed or already detached).
+ *   - -EPERM / -EACCES: Insufficient privilege or blocked by security policy.
+ *   - -EINVAL: Invalid ID (e.g., 0) or kernel rejected the request (rare).
+ *   - -ENOMEM: Transient kernel resource exhaustion while creating the FD.
+ *   - -EBADF, -EFAULT, or other -errno values: Propagated from the underlying syscall.
+ *
+ * Usage notes:
+ *   - Immediately call bpf_link_get_info_by_fd() after acquiring the FD if you need
+ *     metadata (program ID, attach type, target, cookie, etc.).
+ *   - To keep a link across process restarts, pin it to bpffs via bpf_obj_pin().
+ *   - Prefer using bpf_link_get_fd_by_id_opts() if you need extended open semantics
+ *     (e.g., token-based delegated permissions) on newer kernels.
+ *
+ * @param id
+ *        Kernel-assigned unique ID of the target BPF link (must be > 0). Usually
+ *        obtained via bpf_link_get_next_id() or from a prior info query.
+ *
+ * @return
+ *        >= 0 : File descriptor referring to the BPF link (caller must close()).
+ *        < 0  : Negative error code (libbpf-style, typically -errno) on failure.
+ */
 LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
+/**
+ * @brief Obtain a file descriptor for an existing BPF link by kernel-assigned link ID
+ *        with extended open options.
+ *
+ * bpf_link_get_fd_by_id_opts() is an extended variant of bpf_link_get_fd_by_id().
+ * It wraps the BPF_LINK_GET_FD_BY_ID command of the bpf(2) syscall and converts a
+ * stable, monotonically increasing BPF link ID into a process-local file descriptor
+ * while honoring optional attributes supplied via @p opts.
+ *
+ * A BPF "link" represents a persistent attachment of a BPF program to some kernel
+ * hook (cgroup, tracing point, perf event, netfilter, tc/xdp chain, etc.). Links can
+ * be enumerated system-wide by first calling bpf_link_get_next_id().
+ *
+ * Typical enumeration + open pattern:
+ *   __u32 id = 0, next;
+ *   while (bpf_link_get_next_id(id, &next) == 0) {
+ *       struct bpf_get_fd_by_id_opts o = {
+ *           .sz = sizeof(o),
+ *           .open_flags = 0,
+ *           .token_fd = 0,
+ *       };
+ *       int link_fd = bpf_link_get_fd_by_id_opts(next, &o);
+ *       if (link_fd >= 0) {
+ *           // inspect link (e.g. bpf_link_get_info_by_fd(link_fd))
+ *           close(link_fd);
+ *       }
+ *       id = next;
+ *   }
+ *   // Loop ends when bpf_link_get_next_id() returns -ENOENT (no more links).
+ *
+ * Concurrency & races:
+ *   - A link may detach between enumeration and opening; handle -ENOENT gracefully.
+ *   - Successfully obtaining a FD does not prevent future detachment by other processes;
+ *     subsequent operations (e.g., bpf_link_get_info_by_fd()) can still fail.
+ *
+ * Lifetime & ownership:
+ *   - The returned FD holds a user-space reference; close() decrements it.
+ *   - The underlying link persists while any references remain (FDs or bpffs pin).
+ *   - Use bpf_obj_pin() to make the link persistent across process lifetimes.
+ *
+ * Security:
+ *   - CAP_BPF and/or CAP_SYS_ADMIN may be required depending on kernel configuration.
+ *   - Token-based access (token_fd) can allow operations in sandboxed environments.
+ *
+ * Follow-up introspection:
+ *   - Call bpf_link_get_info_by_fd(link_fd, ...) to retrieve program ID, attach type,
+ *     target info, cookies, and other metadata.
+ *   - Detach via bpf_link_detach(link_fd) or simply close(link_fd).
+ *
+ * Recommended usage notes:
+ *   - Always zero-initialize the opts struct before setting fields.
+ *   - Treat -ENOENT after enumeration as normal termination, not an error condition.
+ *   - Avoid relying on stable ordering beyond ascending ID sequence; links created
+ *     during enumeration may appear after you pass their predecessor ID.
+ *
+ * @param id
+ *   Kernel-assigned unique (non-zero) BPF link ID. Usually obtained from
+ *   bpf_link_get_next_id() or from a prior info query. Must be > 0.
+ *
+ * @param opts
+ *   Optional pointer to a zero-initialized struct bpf_get_fd_by_id_opts:
+ *     - sz: MUST be set to sizeof(struct bpf_get_fd_by_id_opts) if @p opts
+ *           is non-NULL (enables fwd/backward compatibility).
+ *     - open_flags: Additional open/access flags (currently most callers set 0;
+ *                   unsupported bits yield -EINVAL; semantics are kernel-specific).
+ *     - token_fd: File descriptor of a BPF token granting delegated permissions
+ *                 (set 0 or -1 if unused). Allows restricted environments to
+ *                 open the link without elevated global capabilities.
+ *   Pass NULL for defaults (equivalent to open_flags=0, no token).
+ *
+ * @return
+ *   >= 0 : File descriptor referencing the BPF link (caller owns it; close() when done).
+ *   < 0  : Negative libbpf-style error code (typically -errno):
+ *            - -ENOENT  : Link with @p id does not exist (detached or never created).
+ *            - -EPERM / -EACCES : Insufficient privilege or blocked by LSM/lockdown.
+ *            - -EINVAL  : Invalid @p id (0), malformed @p opts (bad sz / flags), or
+ *                         unsupported open_flags.
+ *            - -ENOMEM  : Transient kernel memory/resource exhaustion.
+ *            - Other negative codes: Propagated from underlying bpf() syscall.
+ *
+ */
 LIBBPF_API int bpf_link_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
+
 LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
 
 /**
-- 
2.34.1


