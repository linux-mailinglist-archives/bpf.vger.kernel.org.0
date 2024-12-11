Return-Path: <bpf+bounces-46640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D569F9ECF30
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 15:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795151884D8A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441731A0726;
	Wed, 11 Dec 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH6Eghs9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAB19F116
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929023; cv=none; b=ad1vaVUIqxhPYE5/G/RsCwpRPvd3H14AF4hCQDqvBrpgz5HzFzjRMacsBjyagff3JEohzI78jFEAfTwCMRcpgPD3in+APE2q2W/BjnfZ99fdES6QPo5BcokFxM7gZrFHnc4XUPUzNX5NbfA9kTabJIi7jaqUYplGYsJ32h9Ka1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929023; c=relaxed/simple;
	bh=Q7PAVTvKlR6GBsKQzqzdV4tzOnc6vE85i44dToX8ILI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy4PoX4pNZjCFnhmnYWwf1vq2Pxnuu4TZVm8dwOnGGIXte1X0fBL+cWbQIRWROFf9jEaVPNPx90xTOYo4HmXYru0y9Y/RGNITlne42vaw2BlYyhCTNgiToCIrwnbIpLGNHk9HfceKIo/L43GqD9ZHAdqnsbXLN7z5tecMhCansg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH6Eghs9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa69077b93fso481568166b.0
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 06:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733929020; x=1734533820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SogCzOv7sBUjOa9IZupmUG7D3xzftxqdhxZbsTv4vtY=;
        b=dH6Eghs98OMTC/8bBOjJPtfZdAKNGFg617jrdmRiANG04faTKUKc5Jo4xHdoZyuRvR
         JV+uaCFlA42AGWQOmLDa+7gTB97pPjOLWifdlBau8Dw/4tU+zAwAYhiYbkRVD9AHDRn2
         88aBIbO1jjBTXrqgzlMf0M7tpM9xHnLZY5bUgBsX4MQBXPpMzVs6a6OCFxiOgDDnxwVH
         MfezkTrHMXWb/PP15zjeCBlLSSr0IIqjQuJMYTkmuIGHwzN8JBxYBsT5UC666M6k24uF
         rtgFLDR8dEXhesgsXRAHnvbn4yen6Gqsb8vV9YZEOHGTKC15Hp2KC6xDGq5k7GSc4yzb
         HsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929020; x=1734533820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SogCzOv7sBUjOa9IZupmUG7D3xzftxqdhxZbsTv4vtY=;
        b=KPswkNbkH6k1JhMwcHhVCHe+t1j71Ybd5E+srB1XUM5LjJLnZDJ6E7uazAttolh2od
         nt1E8d++9li/61Kw8i0wzaIPFgn3lqiPWI3Ya3Ug5pCmJWdhF7fpHusEYgP633BUyeQQ
         Ys7MvTJ74/fIBtAcAxuuzR42lZH1cqD5DsvGguORwaI1kJNW5F3Wstx6gAWuAcUr1w43
         7lr28jqbPKdrJIPQxa6zG4wzY4AjPS2OuRi5/sMCyvHt9dRMTDwsxsNxlTLx6j80xgWT
         8okZ25wTnOIGkuw7lZR02C+O53B8CQRDRAs5AbfsOrRuYdduaUCNU2n5dFD5u8tVa1yk
         B2JQ==
X-Gm-Message-State: AOJu0YwHSeFRzVswmlo/WUdRxF9wtAWhunIsaXD9AqHMQem3ligmQPEX
	XqmJfk0F/+6Fw1BE8BhTv3Sj3t3q8n38iCv4sU7gbKhl/BLlv+n+
X-Gm-Gg: ASbGncv86Ho/2gI00716fd/SIRLy7bQWYnehFxlm9mdbGzQvDjgcRIskY/tVWr3DUEc
	tTlxjfokrnTN+IFzygCMYii63GELGHtVlHrhDSBfLDprpNi3MHsBogKqhkZmsJv/nIDMqPvKiWx
	jGV6Vvpk2/+n3OJsKUYESgt2w/bvAUslLBnuE8u+8zQRxuW3SxQ9BkTIpB6Em3mn4L9TslhQIbb
	6mzMFOT/xkw0lNlHDmLwIWSIBcH0ejCZaxnjxy/EH30JvxJG2PbXy4MTeH5PEYuV7s0qSKDdP7N
	ZGCiC5jEHKEDH9VzvG3M7yV2FiA=
X-Google-Smtp-Source: AGHT+IFnGiX9s+EgUWjWv6UfLsTcBakG4OYxdOoAyizm+WjAEVtg824QsQ4ztjEF0ZdrWLzhiNMqcQ==
X-Received: by 2002:a17:906:32d6:b0:aa6:9372:cac7 with SMTP id a640c23a62f3a-aa6c1b101e9mr10653866b.31.1733929019795;
        Wed, 11 Dec 2024 06:56:59 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68bae18cfsm446394866b.115.2024.12.11.06.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 06:56:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Dec 2024 15:56:57 +0100
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Juri Lelli <juri.lelli@redhat.com>,
	Manu Bretelle <chantra@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf v1 3/4] bpf: Augment raw_tp arguments with
 PTR_MAYBE_NULL
Message-ID: <Z1moOcGsbWmn6XhU@krava>
References: <20241211020156.18966-1-memxor@gmail.com>
 <20241211020156.18966-4-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211020156.18966-4-memxor@gmail.com>

On Tue, Dec 10, 2024 at 06:01:55PM -0800, Kumar Kartikeya Dwivedi wrote:

SNIP

> +struct bpf_raw_tp_null_args raw_tp_null_args[] = {
> +	/* sched */
> +	RAW_TP_NULL_ARGS(sched_pi_setprio, NULL_ARG(2)),
> +	/* ... from sched_numa_pair_template event class */
> +	RAW_TP_NULL_ARGS(sched_stick_numa, NULL_ARG(3)),
> +	RAW_TP_NULL_ARGS(sched_swap_numa, NULL_ARG(3)),
> +	/* afs */
> +	RAW_TP_NULL_ARGS(afs_make_fs_call, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(afs_make_fs_calli, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(afs_make_fs_call1, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(afs_make_fs_call2, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(afs_protocol_error, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(afs_flock_ev, NULL_ARG(2)),
> +	/* cachefiles */
> +	RAW_TP_NULL_ARGS(cachefiles_lookup, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_unlink, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_rename, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_prep_read, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_mark_active, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_mark_failed, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_mark_inactive, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_vfs_error, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_io_error, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_ondemand_open, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_ondemand_copen, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_ondemand_close, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_ondemand_read, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_ondemand_cread, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_ondemand_fd_write, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(cachefiles_ondemand_fd_release, NULL_ARG(1)),
> +	/* ext4, from ext4__mballoc event class */
> +	RAW_TP_NULL_ARGS(ext4_mballoc_discard, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(ext4_mballoc_free, NULL_ARG(2)),
> +	/* fib */
> +	RAW_TP_NULL_ARGS(fib_table_lookup, NULL_ARG(3)),
> +	/* filelock */
> +	/* ... from filelock_lock event class */
> +	RAW_TP_NULL_ARGS(posix_lock_inode, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(fcntl_setlk, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(locks_remove_posix, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(flock_lock_inode, NULL_ARG(2)),
> +	/* ... from filelock_lease event class */
> +	RAW_TP_NULL_ARGS(break_lease_noblock, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(break_lease_block, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(break_lease_unblock, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(generic_delete_lease, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(time_out_leases, NULL_ARG(2)),
> +	/* host1x */
> +	RAW_TP_NULL_ARGS(host1x_cdma_push_gather, NULL_ARG(5)),
> +	/* huge_memory */
> +	RAW_TP_NULL_ARGS(mm_khugepaged_scan_pmd, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(mm_collapse_huge_page_isolate, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(mm_khugepaged_scan_file, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(mm_khugepaged_collapse_file, NULL_ARG(2)),
> +	/* kmem */
> +	RAW_TP_NULL_ARGS(mm_page_alloc, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(mm_page_pcpu_drain, NULL_ARG(1)),
> +	/* .. from mm_page event class */
> +	RAW_TP_NULL_ARGS(mm_page_alloc_zone_locked, NULL_ARG(1)),
> +	/* netfs */
> +	RAW_TP_NULL_ARGS(netfs_failure, NULL_ARG(2)),
> +	/* power */
> +	RAW_TP_NULL_ARGS(device_pm_callback_start, NULL_ARG(2)),
> +	/* qdisc */
> +	RAW_TP_NULL_ARGS(qdisc_dequeue, NULL_ARG(4)),
> +	/* rxrpc */
> +	RAW_TP_NULL_ARGS(rxrpc_recvdata, NULL_ARG(1)),
> +	RAW_TP_NULL_ARGS(rxrpc_resend, NULL_ARG(2)),
> +	/* sunrpc */
> +	RAW_TP_NULL_ARGS(xs_stream_read_data, NULL_ARG(1)),

I missed one more in sunrpc: xprt_cong_event class

jirka

> +	/* tcp */
> +	RAW_TP_NULL_ARGS(tcp_send_reset, NULL_ARG(1) | NULL_ARG(2)),
> +	/* tegra_apb_dma */
> +	RAW_TP_NULL_ARGS(tegra_dma_tx_status, NULL_ARG(3)),
> +	/* timer_migration */
> +	RAW_TP_NULL_ARGS(tmigr_update_events, NULL_ARG(1)),
> +	/* writeback, from writeback_folio_template event class */
> +	RAW_TP_NULL_ARGS(writeback_dirty_folio, NULL_ARG(2)),
> +	RAW_TP_NULL_ARGS(folio_wait_writeback, NULL_ARG(2)),
> +};
> +
>  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  		    const struct bpf_prog *prog,
>  		    struct bpf_insn_access_aux *info)
> @@ -6449,6 +6539,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  	const char *tname = prog->aux->attach_func_name;
>  	struct bpf_verifier_log *log = info->log;
>  	const struct btf_param *args;
> +	bool ptr_err_raw_tp = false;
>  	const char *tag_value;
>  	u32 nr_args, arg;
>  	int i, ret;
> @@ -6591,6 +6682,36 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
>  		info->reg_type |= PTR_MAYBE_NULL;
>  
> +	if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
> +		struct btf *btf = prog->aux->attach_btf;
> +		const struct btf_type *t;
> +		const char *tname;
> +
> +		t = btf_type_by_id(btf, prog->aux->attach_btf_id);
> +		if (!t)
> +			goto done;
> +		tname = btf_name_by_offset(btf, t->name_off);
> +		if (!tname)
> +			goto done;
> +		for (int i = 0; i < ARRAY_SIZE(raw_tp_null_args); i++) {
> +			/* Is this a func with potential NULL args? */
> +			if (strcmp(tname, raw_tp_null_args[i].func))
> +				continue;
> +			/* Is the current arg NULL? */
> +			if (raw_tp_null_args[i].mask & NULL_ARG(arg + 1))
> +				info->reg_type |= PTR_MAYBE_NULL;
> +			break;
> +		}
> +		/* Hardcode the only cases which has a IS_ERR pointer, i.e.
> +		 * mr_integ_alloc's 4th argument (mr), and
> +		 * cachefiles_lookup's 3rd argument (de).
> +		 */
> +		if (!strcmp(tname, "btf_trace_mr_integ_alloc") && (arg + 1) == 4)
> +			ptr_err_raw_tp = true;
> +		if (!strcmp(tname, "btf_trace_cachefiles_lookup") && (arg + 1) == 3)
> +			ptr_err_raw_tp = true;
> +	}
> +done:
>  	if (tgt_prog) {
>  		enum bpf_prog_type tgt_type;
>  
> @@ -6635,6 +6756,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  	bpf_log(log, "func '%s' arg%d has btf_id %d type %s '%s'\n",
>  		tname, arg, info->btf_id, btf_type_str(t),
>  		__btf_name_by_offset(btf, t->name_off));
> +
> +	/* Perform all checks on the validity of type for this argument, but if
> +	 * we know it can be IS_ERR at runtime, scrub pointer type and mark as
> +	 * scalar. We do not handle is_retval case as we hardcode ptr_err_raw_tp
> +	 * handling for known tps.
> +	 */
> +	if (ptr_err_raw_tp)
> +		info->reg_type = SCALAR_VALUE;
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(btf_ctx_access);
> -- 
> 2.43.5
> 

