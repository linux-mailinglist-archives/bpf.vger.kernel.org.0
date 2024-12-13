Return-Path: <bpf+bounces-46919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 765E69F18F9
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7CC188F28A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EB61EC4C6;
	Fri, 13 Dec 2024 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnAeP8IM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADE1A7AC7
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128382; cv=none; b=EwTO4DYYvkk177FqWMp5mNTeAn3dY9N1KobSjnpBx8gGxioEONmoHXMZQs2mdOoc8ZKUEoiotrCPSEzjGRefBFtYHu8QtSt/h+2k9TvWLCJ/CA+gvXVJxhIg0GE3bEYcaNUDCH/TFtUhgZzPFS6APRFlVZf5EmE0CfeOb1hnGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128382; c=relaxed/simple;
	bh=TOktLQI5dAYkR6Hyn62aVd3TlNwXf+iaDDCkArzju5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilB+bGqJcoKbgEowMqD+ztotNCChfyyL61JLRC+cR37cu+mfALECQztPSXDzjHn9BsZaPrtzTy4J2SMvAD7UZ0TgWwt1J15cHIHAw8n3aL3/2DEdLXHyRyeLeHBDlNdtWgWUXoiag5gywIYtrw/HIWpfuRaJtm9aCMggRoJYjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnAeP8IM; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-436202dd730so16341415e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 14:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128378; x=1734733178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RVSSmUqL++a+EY7gKKS9MMxfzWGDgoy19gSXP/x8TE=;
        b=MnAeP8IMBr2+xAQVNgPN3uShgabERm7KaurznG3EW/k0r76BtBIzZsoc6MK6ty0HBl
         2rsBA4lhseYAMcGiS8/Xc8IPz2r69nf1Os5m5RCiQ5yeIdR8DBzWu0MFl+/X6CdKwo1a
         souNAUx2fxVy7xsw4enLXXr6T/hb//uXDwoyX1TH4nCGFb0CHWcELyhNfhVbhvzLQuTK
         qqdzQdk0q9lnjToi+ChkVrRY2yVhdd7rUT6IkkjWrXvMKlLL02160fE6N9Wcyy0hHM3Z
         UspKS/gZqg12ryUU0wW1mAvQGm9tNnYth7kXtmizXDwIakBaaYNYDL7HlLVOU/K7plLb
         Mhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128378; x=1734733178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RVSSmUqL++a+EY7gKKS9MMxfzWGDgoy19gSXP/x8TE=;
        b=M7uoOHKas/YuUBkzbgwD1tOH19hDioorcmoOTET4f1L1Kcw+C8BEaWS0ig4idhFQ3Y
         wGpZ9aPKjqHp+KBgJ4Zjo9ZeRzg2sb4Q3h0KXR1+PzXerj8VXv7lEXBVuap8SzuA3Zys
         oDj+rLtddPf+WvBowdv2Vo5ZZuXMH5R7xkL38aGZ2SUbjCR77jLqoOS/qy83AGJ9yFkV
         avNsrN5dLH7DeP9U/ZIBUZ23eqLQDW9uIvc43KQQDaeSvP663DZypLQbMl7mDNk/lyOh
         ubs6QCS2hdxHao7cryB3Ze5mQ9+ndkUIbT8v53uVuvaiZkVGO+tnHjsJmJMY63Vn6usG
         MicA==
X-Gm-Message-State: AOJu0YxrqX8bDFbhRqDb45jgIZ4GINJRXvFownMgRh1iwyttzy05oQ0d
	Wqn8l1IBqx7EU05jNK9hjVmuhqkusJb5nfcmqiR7+JsOwV7/YRXjPfgU6PssOLkJ7A==
X-Gm-Gg: ASbGncsca9brYvuEJ6jlqC1UkjbQGyNazoOSXat1SG8WJYWEOww0+RtBw5Vy8yxJj3O
	QEKaks1h96VM5tg3FGnh1OA+y78HzV/O9hb3LiJ2LcSpke3tVzXrykb2btrgeGDRJWH1iUSjmM6
	e3XrRmEgxnJZbHp4SURBsBXUG3jDFmT8eICMWL3GIJAdlbTOjpMSQoyOCF4VLvKIEJ5y9gZbQ35
	LqJyFTup3fLl41yl7O88n45SHofWroZFeo4Xmhy6UUthkjOaqiSIFIchCrou6ast1bC7zmExgMN
	zL6DFi0=
X-Google-Smtp-Source: AGHT+IFl47QStVKCNMLjvadnZP41lyUzcg5qCcsXaswT43EKi3RkcxtgCnDY7seEmfZ7Tk8weNMvmg==
X-Received: by 2002:a5d:5f82:0:b0:385:fd31:ca34 with SMTP id ffacd0b85a97d-3888e0c06bbmr4072003f8f.54.1734128377763;
        Fri, 13 Dec 2024 14:19:37 -0800 (PST)
Received: from localhost (fwdproxy-cln-014.fbsv.net. [2a03:2880:31ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80165c5sm688738f8f.25.2024.12.13.14.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:19:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Juri Lelli <juri.lelli@redhat.com>,
	Manu Bretelle <chantra@meta.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf v3 2/3] bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
Date: Fri, 13 Dec 2024 14:19:28 -0800
Message-ID: <20241213221929.3495062-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221929.3495062-1-memxor@gmail.com>
References: <20241213221929.3495062-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10747; h=from:subject; bh=TOktLQI5dAYkR6Hyn62aVd3TlNwXf+iaDDCkArzju5w=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnXK5lmnu19gVHJHqykjZOtgKaxwveQhbTv/vlCp4O 1j6KlYWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1yuZQAKCRBM4MiGSL8RygLHEA CACOTMmUWtMvA9ZOYDumbY5RTRXqcxQRqgXnCEi1f+4162lmLYP8pZP1ATuEWXrYZDL3FgwYxPen63 myb6Z8HCHTOPwqrYb85wi9md9sioCz2zQ+C+aZZVU6KKpCHB1R8k+grb1cdxohlQVfqsB/X/mY9UbE pv3U+rRu4kH/7WW+kA3qwy7Z7TuKX6j5WkblAx4VkOtxVdMNR5tvKWXgbKW3uGR+zxAYOvq9FZ2yLk aJAcRJ3Ox0q5Qr3ePy8RtXHMH9T21tAvgFDw6xQAZxJEE9XOB0DkAfNJ82bTLdCEpHxCvp3IsWEA9e 7YfnxP64EdH2HEfMa+kQlA0a0W7idTownYLn1CPn1G+bBSzN+XCBUHu6IlCKehZCoZXSJWbPuEyKHn 2VSjO5IzyFslWd8ldaKroik6yst0I87zR2C5eIG2wtd7rPr0jlYCZoWLDny2+4SxKYU4YdkcCcnfGf VWMHIPHESxg8GRjEaoA9wuV3SgcKni24EEdk3nE0FgUuohl0+q21yPXd6SFn7Nr9CJDzpeHrnRrKSG Dt2fruVxhDI8jKDJM8qnC/Yf4GgOJ59cxrKErrpdquy6Oqvgnq7qkpxndpSY8IdHc/KoxzXCP/xRBr MReWcfu0JwgqPEbULABNr+Xmnc5nJ65/cfw1ZAucAzQB2msKAt4BOmg61MDA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Arguments to a raw tracepoint are tagged as trusted, which carries the
semantics that the pointer will be non-NULL.  However, in certain cases,
a raw tracepoint argument may end up being NULL. More context about this
issue is available in [0].

Thus, there is a discrepancy between the reality, that raw_tp arguments can
actually be NULL, and the verifier's knowledge, that they are never NULL,
causing explicit NULL check branch to be dead code eliminated.

A previous attempt [1], i.e. the second fixed commit, was made to
simulate symbolic execution as if in most accesses, the argument is a
non-NULL raw_tp, except for conditional jumps.  This tried to suppress
branch prediction while preserving compatibility, but surfaced issues
with production programs that were difficult to solve without increasing
verifier complexity. A more complete discussion of issues and fixes is
available at [2].

Fix this by maintaining an explicit list of tracepoints where the
arguments are known to be NULL, and mark the positional arguments as
PTR_MAYBE_NULL. Additionally, capture the tracepoints where arguments
are known to be ERR_PTR, and mark these arguments as scalar values to
prevent potential dereference.

Each hex digit is used to encode NULL-ness (0x1) or ERR_PTR-ness (0x2),
shifted by the zero-indexed argument number x 4. This can be represented
as follows:
1st arg: 0x1
2nd arg: 0x10
3rd arg: 0x100
... and so on (likewise for ERR_PTR case).

In the future, an automated pass will be used to produce such a list, or
insert __nullable annotations automatically for tracepoints. Each
compilation unit will be analyzed and results will be collated to find
whether a tracepoint pointer is definitely not null, maybe null, or an
unknown state where verifier conservatively marks it PTR_MAYBE_NULL.
A proof of concept of this tool from Eduard is available at [3].

Note that in case we don't find a specification in the raw_tp_null_args
array and the tracepoint belongs to a kernel module, we will
conservatively mark the arguments as PTR_MAYBE_NULL. This is because
unlike for in-tree modules, out-of-tree module tracepoints may pass NULL
freely to the tracepoint. We don't protect against such tracepoints
passing ERR_PTR (which is uncommon anyway), lest we mark all such
arguments as SCALAR_VALUE.

While we are it, let's adjust the test raw_tp_null to not perform
dereference of the skb->mark, as that won't be allowed anymore, and make
it more robust by using inline assembly to test the dead code
elimination behavior, which should still stay the same.

  [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb
  [1]: https://lore.kernel.org/all/20241104171959.2938862-1-memxor@gmail.com
  [2]: https://lore.kernel.org/bpf/20241206161053.809580-1-memxor@gmail.com
  [3]: https://github.com/eddyz87/llvm-project/tree/nullness-for-tracepoint-params

Reported-by: Juri Lelli <juri.lelli@redhat.com> # original bug
Reported-by: Manu Bretelle <chantra@meta.com> # bugs in masking fix
Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs")
Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c                              | 138 ++++++++++++++++++
 .../testing/selftests/bpf/progs/raw_tp_null.c |  19 ++-
 2 files changed, 147 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c4aa304028ce..e5a5f023cedd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6439,6 +6439,101 @@ int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 	return off;
 }
 
+struct bpf_raw_tp_null_args {
+	const char *func;
+	u64 mask;
+};
+
+static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
+	/* sched */
+	{ "sched_pi_setprio", 0x10 },
+	/* ... from sched_numa_pair_template event class */
+	{ "sched_stick_numa", 0x100 },
+	{ "sched_swap_numa", 0x100 },
+	/* afs */
+	{ "afs_make_fs_call", 0x10 },
+	{ "afs_make_fs_calli", 0x10 },
+	{ "afs_make_fs_call1", 0x10 },
+	{ "afs_make_fs_call2", 0x10 },
+	{ "afs_protocol_error", 0x1 },
+	{ "afs_flock_ev", 0x10 },
+	/* cachefiles */
+	{ "cachefiles_lookup", 0x1 | 0x200 },
+	{ "cachefiles_unlink", 0x1 },
+	{ "cachefiles_rename", 0x1 },
+	{ "cachefiles_prep_read", 0x1 },
+	{ "cachefiles_mark_active", 0x1 },
+	{ "cachefiles_mark_failed", 0x1 },
+	{ "cachefiles_mark_inactive", 0x1 },
+	{ "cachefiles_vfs_error", 0x1 },
+	{ "cachefiles_io_error", 0x1 },
+	{ "cachefiles_ondemand_open", 0x1 },
+	{ "cachefiles_ondemand_copen", 0x1 },
+	{ "cachefiles_ondemand_close", 0x1 },
+	{ "cachefiles_ondemand_read", 0x1 },
+	{ "cachefiles_ondemand_cread", 0x1 },
+	{ "cachefiles_ondemand_fd_write", 0x1 },
+	{ "cachefiles_ondemand_fd_release", 0x1 },
+	/* ext4, from ext4__mballoc event class */
+	{ "ext4_mballoc_discard", 0x10 },
+	{ "ext4_mballoc_free", 0x10 },
+	/* fib */
+	{ "fib_table_lookup", 0x100 },
+	/* filelock */
+	/* ... from filelock_lock event class */
+	{ "posix_lock_inode", 0x10 },
+	{ "fcntl_setlk", 0x10 },
+	{ "locks_remove_posix", 0x10 },
+	{ "flock_lock_inode", 0x10 },
+	/* ... from filelock_lease event class */
+	{ "break_lease_noblock", 0x10 },
+	{ "break_lease_block", 0x10 },
+	{ "break_lease_unblock", 0x10 },
+	{ "generic_delete_lease", 0x10 },
+	{ "time_out_leases", 0x10 },
+	/* host1x */
+	{ "host1x_cdma_push_gather", 0x10000 },
+	/* huge_memory */
+	{ "mm_khugepaged_scan_pmd", 0x10 },
+	{ "mm_collapse_huge_page_isolate", 0x1 },
+	{ "mm_khugepaged_scan_file", 0x10 },
+	{ "mm_khugepaged_collapse_file", 0x10 },
+	/* kmem */
+	{ "mm_page_alloc", 0x1 },
+	{ "mm_page_pcpu_drain", 0x1 },
+	/* .. from mm_page event class */
+	{ "mm_page_alloc_zone_locked", 0x1 },
+	/* netfs */
+	{ "netfs_failure", 0x10 },
+	/* power */
+	{ "device_pm_callback_start", 0x10 },
+	/* qdisc */
+	{ "qdisc_dequeue", 0x1000 },
+	/* rxrpc */
+	{ "rxrpc_recvdata", 0x1 },
+	{ "rxrpc_resend", 0x10 },
+	/* sunrpc */
+	{ "xs_stream_read_data", 0x1 },
+	/* ... from xprt_cong_event event class */
+	{ "xprt_reserve_cong", 0x10 },
+	{ "xprt_release_cong", 0x10 },
+	{ "xprt_get_cong", 0x10 },
+	{ "xprt_put_cong", 0x10 },
+	/* tcp */
+	{ "tcp_send_reset", 0x11 },
+	/* tegra_apb_dma */
+	{ "tegra_dma_tx_status", 0x100 },
+	/* timer_migration */
+	{ "tmigr_update_events", 0x1 },
+	/* writeback, from writeback_folio_template event class */
+	{ "writeback_dirty_folio", 0x10 },
+	{ "folio_wait_writeback", 0x10 },
+	/* rdma */
+	{ "mr_integ_alloc", 0x2000 },
+	/* bpf_testmod */
+	{ "bpf_testmod_test_read", 0x0 },
+};
+
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info)
@@ -6449,6 +6544,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	const char *tname = prog->aux->attach_func_name;
 	struct bpf_verifier_log *log = info->log;
 	const struct btf_param *args;
+	bool ptr_err_raw_tp = false;
 	const char *tag_value;
 	u32 nr_args, arg;
 	int i, ret;
@@ -6597,6 +6693,39 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
 		info->reg_type |= PTR_MAYBE_NULL;
 
+	if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
+		struct btf *btf = prog->aux->attach_btf;
+		const struct btf_type *t;
+		const char *tname;
+
+		/* BTF lookups cannot fail, return false on error */
+		t = btf_type_by_id(btf, prog->aux->attach_btf_id);
+		if (!t)
+			return false;
+		tname = btf_name_by_offset(btf, t->name_off);
+		if (!tname)
+			return false;
+		/* Checked by bpf_check_attach_target */
+		tname += sizeof("btf_trace_") - 1;
+		for (i = 0; i < ARRAY_SIZE(raw_tp_null_args); i++) {
+			/* Is this a func with potential NULL args? */
+			if (strcmp(tname, raw_tp_null_args[i].func))
+				continue;
+			if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
+				info->reg_type |= PTR_MAYBE_NULL;
+			/* Is the current arg IS_ERR? */
+			if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
+				ptr_err_raw_tp = true;
+			break;
+		}
+		/* If we don't know NULL-ness specification and the tracepoint
+		 * is coming from a loadable module, be conservative and mark
+		 * argument as PTR_MAYBE_NULL.
+		 */
+		if (i == ARRAY_SIZE(raw_tp_null_args) && btf_is_module(btf))
+			info->reg_type |= PTR_MAYBE_NULL;
+	}
+
 	if (tgt_prog) {
 		enum bpf_prog_type tgt_type;
 
@@ -6641,6 +6770,15 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	bpf_log(log, "func '%s' arg%d has btf_id %d type %s '%s'\n",
 		tname, arg, info->btf_id, btf_type_str(t),
 		__btf_name_by_offset(btf, t->name_off));
+
+	/* Perform all checks on the validity of type for this argument, but if
+	 * we know it can be IS_ERR at runtime, scrub pointer type and mark as
+	 * scalar.
+	 */
+	if (ptr_err_raw_tp) {
+		bpf_log(log, "marking pointer arg%d as scalar as it may encode error", arg);
+		info->reg_type = SCALAR_VALUE;
+	}
 	return true;
 }
 EXPORT_SYMBOL_GPL(btf_ctx_access);
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/testing/selftests/bpf/progs/raw_tp_null.c
index 457f34c151e3..5927054b6dd9 100644
--- a/tools/testing/selftests/bpf/progs/raw_tp_null.c
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
@@ -3,6 +3,7 @@
 
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -17,16 +18,14 @@ int BPF_PROG(test_raw_tp_null, struct sk_buff *skb)
 	if (task->pid != tid)
 		return 0;
 
-	i = i + skb->mark + 1;
-	/* The compiler may move the NULL check before this deref, which causes
-	 * the load to fail as deref of scalar. Prevent that by using a barrier.
+	/* If dead code elimination kicks in, the increment +=2 will be
+	 * removed. For raw_tp programs attaching to tracepoints in kernel
+	 * modules, we mark input arguments as PTR_MAYBE_NULL, so branch
+	 * prediction should never kick in.
 	 */
-	barrier();
-	/* If dead code elimination kicks in, the increment below will
-	 * be removed. For raw_tp programs, we mark input arguments as
-	 * PTR_MAYBE_NULL, so branch prediction should never kick in.
-	 */
-	if (!skb)
-		i += 2;
+	asm volatile ("%[i] += 1; if %[ctx] != 0 goto +1; %[i] += 2;"
+			: [i]"+r"(i)
+			: [ctx]"r"(skb)
+			: "memory");
 	return 0;
 }
-- 
2.43.5


