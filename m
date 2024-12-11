Return-Path: <bpf+bounces-46586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E529EC1E2
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 03:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC08428206A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 02:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4519D897;
	Wed, 11 Dec 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYuxUW1d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1A1FBCA4
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882527; cv=none; b=NDlwlX7I5cs3ARDyFHij3DIGVGcizJjsUKwjiXVakw878Ndx4Mkt7pK338rKqH35wOqYt9InpmERfe8fW/8+wA8ywpwXmvw6zDBTmc69QbHkd7OzFxQWYcjS458uJ3bcGumyw4ygtqTDPqaQZQWfkKFp+rPdaddOX7fgWT7pAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882527; c=relaxed/simple;
	bh=QRNnBe3DRd4mK9fBBEY/1g9TO5PmLWWJcES8ftyNn/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXFUpxf048V0zMofEsIwJKmNeWXvFwBDWNlCN24KeYKuOrh3BSb34NEtNWolFCnDM5Ems5Q6SRVwt6aXyZ5DJlenn3p+P8W8dZs+wzYeqAkGls/87Pd9cj4P9U1LNtZWqJUK/Q2nTMdn+rV+wqzEMySAk902E7zQzp7pS60su3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYuxUW1d; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso5065105f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733882524; x=1734487324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMMFdKgeypfW24bc7+p1TtTRLYBv8lSMIhiHTmx5e1k=;
        b=TYuxUW1dWE13NqgVVqyNQaApfGiBy+9VVOGJsbujVfwZks0YKLz53d1l6zJ1xqAvwl
         KMpaKfUmprBgkW9B8hFXYaAJOTyY5SmUftPfM5I//sPGA7AdgtArbdoVUpU+ZdrR2dNE
         JKsqN2bNHFqxV6fgOVPtQGt73YPYpazboFIbDaDzmqJGeAvSW/JB40utU4Hbh4e/9dzn
         JR0th/VAW6djrwJKunbX9ZU+oAxYW7Z6H0zaocmPaStqq2xncoEf34zsna4VpTpt717K
         bazF5SdaYFD/B/YzexQ8jLqO9nKpvhg6coswegc8qz39VAqT/cjFo4dLy66j6ZehEuxJ
         MJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733882524; x=1734487324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMMFdKgeypfW24bc7+p1TtTRLYBv8lSMIhiHTmx5e1k=;
        b=Rkv0tiPzftzRLndRxLe5bulp8xE8nKyKwJO8bMcVqzeuluePo3NC8nVcscyhokt6cV
         /xi811PZndO6NdjL12wCv56rEXpeQjuSaRN39xDJIaGdym9tZS5HzJovnokTgxkq2aUc
         re4Kgqe6xeuRYBWt/3ysyk6uMgrJVcQpPFlmdraSkNaziTPQO78d7ZWloxBqYof4+qZG
         5VMjJQ5xTg6AsuwvquU6aOBNjgfcuQvhJaj4+Hrr/ZoUuvTaGGOhl8c916G0TaISnPDK
         P43fV1tuR1Ul5IFx3XrP1hBSfhdIFjTKzBgDMamdTcYVWXSJkj3i26LjscpU2ZeeUqbB
         1ppg==
X-Gm-Message-State: AOJu0YxfzBFwmhsxtMAeU4Tl05isQj+/73ZB10gJX9qSgkzOuI/4kQCF
	BiZ5OA+xqsAUtmxalhkRk7yKre8mh9E8aSEhS39/DMMdkmeCLLLUdd8EMnoVCyE=
X-Gm-Gg: ASbGncv7vJ7pbnvFAkauQAcg8SGAIl2mWgNbvA/S1wg7zjQG0ROSSQXzIzw7kAm9kXe
	Tb0kgoRV1DIObheSIyGppvlYdtM2E5Ywu0OBjwbKnXllVjSI3FO1jpL5r4efMR/lnRoC312UkEU
	gcW+Vn+/Z5v8L67WHASh1JaBaEW0cvc/v1NQQVhTDcxqrWkGjhEwVg0HZaCKht4iasog8+iyefG
	W4Co0e84bzSn7Xz6yq4FAFWS9isUqwKLg4Hu47IELyeeFMN7UwbCBx8K5YMtgz7q22aAKBlDBu3
	jm+prA==
X-Google-Smtp-Source: AGHT+IEcuwZa2XbyLZQ0/3hRqshVjhQGzDNY1L1JTASLIOINuHrwta5PyZsU3kZJHwOdstq76s8BGw==
X-Received: by 2002:a05:6000:1562:b0:385:df59:1158 with SMTP id ffacd0b85a97d-3864ced37cbmr874795f8f.53.1733882523492;
        Tue, 10 Dec 2024 18:02:03 -0800 (PST)
Received: from localhost (fwdproxy-cln-034.fbsv.net. [2a03:2880:31ff:22::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c2c9dsm89188f8f.54.2024.12.10.18.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 18:02:02 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Juri Lelli <juri.lelli@redhat.com>,
	Manu Bretelle <chantra@meta.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v1 3/4] bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
Date: Tue, 10 Dec 2024 18:01:55 -0800
Message-ID: <20241211020156.18966-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211020156.18966-1-memxor@gmail.com>
References: <20241211020156.18966-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9044; h=from:subject; bh=QRNnBe3DRd4mK9fBBEY/1g9TO5PmLWWJcES8ftyNn/4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnWPJWDc4pNbCrth2AiUGP+vGHgxCo6A6qs9Ve8AZk hXNDPIGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1jyVgAKCRBM4MiGSL8RygPQD/ 9k9rxcH4pfqCIJJyNeUtLpnzCuJOHZjH0IgtALFo68FD8+Rn6N1b9oXajsHfAoVptZyrWh2PCM8P8c PCl785j/rHAikhay1cK6Q4cPE6nxTAH76NI6IheSPIxP2sFm4eSICMVbMCLDh2FR4COIUjgGr55Qlp VuvJnrGJGWTdxMprwY1z7Tba64j/n2oyfHFImlgOtDJGohwa0QaebEN4oO0vhKfimFBEL5lmBHioSr n1WmcBcaNbxE+P4QcUKu44JMGH9vqQBYHlQPdfhfFuujvK9HCwS+JYw1/jUsIypGI4RhLLvcfwYO7f ieoayLj2o/+667IZxz9TTYFg4DikSAA6LNR4UHFypMNZFuV37P6xlpN1hyuqrtd9OLfGGDR1+hSxjq pMniddDvzVxArtyzdyrGtPN0ZoeYzrxXPWXLWJxDGRRVe8PuDHNo3qEIg7m7HzjZ6zLIK3iQnRXWBE pfchsAiGxcHmYqxoioWPmqdS/z2429vweTPI8VrKG2zj+O1N7neha05HW0ZVxo8mHRI2CcEk3wFjk2 NvCBr5eAj6TslqpPb41Eo5mbtdUnFGCw69xxO5alc+yIgBxm7NReVOZpyaHxfwFOcBoaAk+6s1Z/va PPqaOdDsnJcbjyGAXLyWTa6CRNFnO01ylHjWaernjWQAevhp+hNELp3Wcdig==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Arguments to a raw tracepoint are tagged as trusted, which carries the
semantics that the pointer will be non-NULL.  However, in certain cases,
a raw tracepoint argument may end up being NULL. More context about this
issue is available in [0].

Thus, there is a discrepancy between the reality, that raw_tp arguments can
actually be NULL, and the verifier's knowledge, that they are never NULL,
causing explicit NULL checks to be deleted, and accesses to such pointers
potentially crashing the kernel.

A previous attempt [1], i.e. the second fixed commit, was made to
simulate symbolic execution as if in most accesses, the argument is a
non-NULL raw_tp, except for conditional jumps.  This tried to suppress
branch prediction while preserving compatibility, but surfaced issues
with production programs that were difficult to solve without increasing
verifier complexity. A more complete discussion of issues and fixes is
available at [2].

Fix this by maintaining an explicit, incomplete list of tracepoints
where the arguments are known to be NULL, and mark the positional
arguments as PTR_MAYBE_NULL. Additionally, capture the tracepoints where
arguments are known to be PTR_ERR, and mark these arguments as scalar
values to prevent potential dereference.

In the future, an automated pass will be used to produce such a list, or
insert __nullable annotations automatically for tracepoints. Anyhow,
this is an attempt to close the gap until the automation lands, and
reflets the current best known list according to Jiri's analysis in [3].

  [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb
  [1]: https://lore.kernel.org/all/20241104171959.2938862-1-memxor@gmail.com
  [2]: https://lore.kernel.org/bpf/20241206161053.809580-1-memxor@gmail.com
  [3]: https://lore.kernel.org/bpf/Z1d-qbCdtJqg6Er4@krava

Reported-by: Juri Lelli <juri.lelli@redhat.com> # original bug
Reported-by: Manu Bretelle <chantra@meta.com> # bugs in masking fix
Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs")
Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ed3219da7181..cb72cbf04d12 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6439,6 +6439,96 @@ int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 	return off;
 }
 
+struct bpf_raw_tp_null_args {
+	const char *func;
+	u64 mask;
+};
+
+#define RAW_TP_NULL_ARGS(str, arg) { .func = "btf_trace_" #str, .mask = (arg) }
+/* Use 1-based indexing for argno */
+#define NULL_ARG(argno) (1 << (argno))
+
+struct bpf_raw_tp_null_args raw_tp_null_args[] = {
+	/* sched */
+	RAW_TP_NULL_ARGS(sched_pi_setprio, NULL_ARG(2)),
+	/* ... from sched_numa_pair_template event class */
+	RAW_TP_NULL_ARGS(sched_stick_numa, NULL_ARG(3)),
+	RAW_TP_NULL_ARGS(sched_swap_numa, NULL_ARG(3)),
+	/* afs */
+	RAW_TP_NULL_ARGS(afs_make_fs_call, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(afs_make_fs_calli, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(afs_make_fs_call1, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(afs_make_fs_call2, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(afs_protocol_error, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(afs_flock_ev, NULL_ARG(2)),
+	/* cachefiles */
+	RAW_TP_NULL_ARGS(cachefiles_lookup, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_unlink, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_rename, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_prep_read, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_mark_active, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_mark_failed, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_mark_inactive, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_vfs_error, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_io_error, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_ondemand_open, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_ondemand_copen, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_ondemand_close, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_ondemand_read, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_ondemand_cread, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_ondemand_fd_write, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(cachefiles_ondemand_fd_release, NULL_ARG(1)),
+	/* ext4, from ext4__mballoc event class */
+	RAW_TP_NULL_ARGS(ext4_mballoc_discard, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(ext4_mballoc_free, NULL_ARG(2)),
+	/* fib */
+	RAW_TP_NULL_ARGS(fib_table_lookup, NULL_ARG(3)),
+	/* filelock */
+	/* ... from filelock_lock event class */
+	RAW_TP_NULL_ARGS(posix_lock_inode, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(fcntl_setlk, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(locks_remove_posix, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(flock_lock_inode, NULL_ARG(2)),
+	/* ... from filelock_lease event class */
+	RAW_TP_NULL_ARGS(break_lease_noblock, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(break_lease_block, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(break_lease_unblock, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(generic_delete_lease, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(time_out_leases, NULL_ARG(2)),
+	/* host1x */
+	RAW_TP_NULL_ARGS(host1x_cdma_push_gather, NULL_ARG(5)),
+	/* huge_memory */
+	RAW_TP_NULL_ARGS(mm_khugepaged_scan_pmd, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(mm_collapse_huge_page_isolate, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(mm_khugepaged_scan_file, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(mm_khugepaged_collapse_file, NULL_ARG(2)),
+	/* kmem */
+	RAW_TP_NULL_ARGS(mm_page_alloc, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(mm_page_pcpu_drain, NULL_ARG(1)),
+	/* .. from mm_page event class */
+	RAW_TP_NULL_ARGS(mm_page_alloc_zone_locked, NULL_ARG(1)),
+	/* netfs */
+	RAW_TP_NULL_ARGS(netfs_failure, NULL_ARG(2)),
+	/* power */
+	RAW_TP_NULL_ARGS(device_pm_callback_start, NULL_ARG(2)),
+	/* qdisc */
+	RAW_TP_NULL_ARGS(qdisc_dequeue, NULL_ARG(4)),
+	/* rxrpc */
+	RAW_TP_NULL_ARGS(rxrpc_recvdata, NULL_ARG(1)),
+	RAW_TP_NULL_ARGS(rxrpc_resend, NULL_ARG(2)),
+	/* sunrpc */
+	RAW_TP_NULL_ARGS(xs_stream_read_data, NULL_ARG(1)),
+	/* tcp */
+	RAW_TP_NULL_ARGS(tcp_send_reset, NULL_ARG(1) | NULL_ARG(2)),
+	/* tegra_apb_dma */
+	RAW_TP_NULL_ARGS(tegra_dma_tx_status, NULL_ARG(3)),
+	/* timer_migration */
+	RAW_TP_NULL_ARGS(tmigr_update_events, NULL_ARG(1)),
+	/* writeback, from writeback_folio_template event class */
+	RAW_TP_NULL_ARGS(writeback_dirty_folio, NULL_ARG(2)),
+	RAW_TP_NULL_ARGS(folio_wait_writeback, NULL_ARG(2)),
+};
+
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info)
@@ -6449,6 +6539,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	const char *tname = prog->aux->attach_func_name;
 	struct bpf_verifier_log *log = info->log;
 	const struct btf_param *args;
+	bool ptr_err_raw_tp = false;
 	const char *tag_value;
 	u32 nr_args, arg;
 	int i, ret;
@@ -6591,6 +6682,36 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
 		info->reg_type |= PTR_MAYBE_NULL;
 
+	if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
+		struct btf *btf = prog->aux->attach_btf;
+		const struct btf_type *t;
+		const char *tname;
+
+		t = btf_type_by_id(btf, prog->aux->attach_btf_id);
+		if (!t)
+			goto done;
+		tname = btf_name_by_offset(btf, t->name_off);
+		if (!tname)
+			goto done;
+		for (int i = 0; i < ARRAY_SIZE(raw_tp_null_args); i++) {
+			/* Is this a func with potential NULL args? */
+			if (strcmp(tname, raw_tp_null_args[i].func))
+				continue;
+			/* Is the current arg NULL? */
+			if (raw_tp_null_args[i].mask & NULL_ARG(arg + 1))
+				info->reg_type |= PTR_MAYBE_NULL;
+			break;
+		}
+		/* Hardcode the only cases which has a IS_ERR pointer, i.e.
+		 * mr_integ_alloc's 4th argument (mr), and
+		 * cachefiles_lookup's 3rd argument (de).
+		 */
+		if (!strcmp(tname, "btf_trace_mr_integ_alloc") && (arg + 1) == 4)
+			ptr_err_raw_tp = true;
+		if (!strcmp(tname, "btf_trace_cachefiles_lookup") && (arg + 1) == 3)
+			ptr_err_raw_tp = true;
+	}
+done:
 	if (tgt_prog) {
 		enum bpf_prog_type tgt_type;
 
@@ -6635,6 +6756,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	bpf_log(log, "func '%s' arg%d has btf_id %d type %s '%s'\n",
 		tname, arg, info->btf_id, btf_type_str(t),
 		__btf_name_by_offset(btf, t->name_off));
+
+	/* Perform all checks on the validity of type for this argument, but if
+	 * we know it can be IS_ERR at runtime, scrub pointer type and mark as
+	 * scalar. We do not handle is_retval case as we hardcode ptr_err_raw_tp
+	 * handling for known tps.
+	 */
+	if (ptr_err_raw_tp)
+		info->reg_type = SCALAR_VALUE;
 	return true;
 }
 EXPORT_SYMBOL_GPL(btf_ctx_access);
-- 
2.43.5


