Return-Path: <bpf+bounces-52162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E953BA3F14A
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 11:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7042217E1C8
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8720409F;
	Fri, 21 Feb 2025 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEbk3we2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C3199237;
	Fri, 21 Feb 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132190; cv=none; b=af/TOvxymPtOzyfQcKOQmp6cWhU79WQoGr4DpYzC5/IGE1bK+oA8ytYKs6AAT1SH/RtFuj1oiNyDKY8/QnkuZOVslU1kZM8QO6HiRWumNbb+Q5+ojFt1BEj/R0Tra1UuIDybgq4GyxVWWtCWbPpQPuu3t5GCIV0HCmYissHATbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132190; c=relaxed/simple;
	bh=ft5qZUmUcPmDr1vOHTSl2J7VjH0/Uk5IJJCo1NCKZQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rToVeTW1xytyt5g5km1qAmOGTOo/lp0lskveY9Km/CaDP0hzsmvqPXM/3QmFmAfM+3YaNSEEg5qnKqQDsmz7ICJvCoI1TA37tL4vacvCPihTBQarUjVdtnmLnp5qVPty4p4ZlPqpdcvp+98xybnHp+3WuN1E7oKqtQrf1aUvMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEbk3we2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-221206dbd7eso37260435ad.2;
        Fri, 21 Feb 2025 02:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740132188; x=1740736988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuhBlibuXv8j0/W4WvNxTMxfqegPnT+8JEvpDcrZkDA=;
        b=bEbk3we2xDCmpBoQWic7pD3uCsyagjGMXarlstuN0U82JU2Dm1nxOuMPRagpgnLSPk
         zuoVDV/PC5WqwGGbIlqjfLTUfgSxkWyTwXUzMuafTo0MCNUMLSIL5fdXGXwlaPVdkHDk
         wQRdUTdQCq0mTigjD6NCY19dvaDRtiMeP7uTsdaZUw5T497L8yvDk8eFJI321uEsd/Vh
         PT6BGmHGNoFYObdShvQ76CuGCDwlJl/sxU1mZLj6aqX9AubzoUwzXYEKNSUY9f6Qgkim
         zYYO71P3LsJs5Y0Z+8KGUyLeWIu0OLLxjPr+LJT0QV//iQD1m38b8Ghfe5wqmhA/k82s
         SJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132188; x=1740736988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vuhBlibuXv8j0/W4WvNxTMxfqegPnT+8JEvpDcrZkDA=;
        b=RJXXNhMLMky5EcOB37J7X5ZUlqlYi+ZDsqTq3tCDqaZTU0IbPEDUKX49TzW6KDkyBx
         K0lzP737a4VoE/Kh2wR8sjIOR6HANxYmYsSXp57PNb8miTDbsiT/8xmtzo283B2Bm3kI
         qNMfYURUVqIFZ1L1EmNnewID+7yirw7+UQPM8vuRE8yYK6JsPuEB8XoAh9Ll3EYRXUdV
         GIfVDi+LyF3ZIeSs2vfuCux8JqEeo238OgGN4sK5udIafzrBdpfA24D02w1IYki2aq27
         qg8t+AAPExZnzcDJLTRGExagO+kaSNoQDUTMj5OEi8Vbp/0ZVKN+5k+H+3tm++YcRdob
         v98w==
X-Forwarded-Encrypted: i=1; AJvYcCVo8aVTbAk7iHNpAR5pYQghZHuNcQnB7vBMRVJDBHUqO3nTT0bfWMdNs4oOQOqFHGtij7GVbs3Px+Ecd4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbcmSW+gAwZ6+ug8GuP6JO7xkBwDMacC4V+tT1GX3Bb/gRP7Z
	oNO0CFJmOGKsP10yQYtSAwJm4JmHMBXxCUOYXiRXZ4Hu370Qs7GyobIsdg==
X-Gm-Gg: ASbGncuab+OMyfW48jSL2xGOV+lAvFiN+glh8gGh0zBHWX4zuaV82xRuXNJqepFoVwt
	lUdvPjqgu21G+hzijrFsprsvjxXpZtNfR7Zou4g9F/Tn64hTBkEIsPHC3Y2DAMnFFCuSPv9hi8N
	ZXqhCxu1ITzugRxqnrDcclgF9fAG/ipOSN+Va7Qf4jGj+ywODYHa1ljBQ1HIhw3fIcFihPRGTyP
	/WiLkWdK6bdJ5vLFMAVcrSY1/sFbgYvSSDD6FVUH3/IK0BJs1hjYQkrVyDCFgjGCwJhjI6AYxCC
	kVSoaz/APLXYWKEWtb6SNXIUDRRJGA/22zOwEoNb60xZ
X-Google-Smtp-Source: AGHT+IFceq0IpGzYck+OoXl3MPSNZdIwcu/xUbXWdTBTkySq9xzG/9XqgOpHRkrPwBvqDzvkRDUJkQ==
X-Received: by 2002:a17:902:e851:b0:220:faa2:c90a with SMTP id d9443c01a7336-2219ffa75bemr40188705ad.37.1740132187973;
        Fri, 21 Feb 2025 02:03:07 -0800 (PST)
Received: from [172.23.162.68] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265a589ebsm12013736b3a.143.2025.02.21.02.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 02:03:07 -0800 (PST)
Message-ID: <1efd9535-82df-43f9-92e1-8c931354b945@gmail.com>
Date: Fri, 21 Feb 2025 18:03:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next v7 0/4] Add prog_kfunc feature probe
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, haoluo@google.com,
 jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212153912.24116-1-chen.dylane@gmail.com>
 <2b025df3-144b-4909-a2b4-66356540f71c@gmail.com>
 <598a7d089936b18472937679d4131286f102cb18.camel@gmail.com>
 <0eee016f-2d37-4c80-98cf-fc134d3ad917@gmail.com>
 <475831c7d175529df4cc638506217c67010bf8da.camel@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <475831c7d175529df4cc638506217c67010bf8da.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/21 02:43, Eduard Zingerman 写道:
> On Fri, 2025-02-21 at 02:09 +0800, Tao Chen wrote:
> 
> [...]
> 
>> Hi Eduard,
>>
>> I try to run your test case, but it seems btf_is_decl_tag always return
>> false, Are there any special restrictions for the tag feature of btf？
> 
> Hi Tao,
>   
>> My compilation environment：
>>
>> pahole --version
>> v1.29
>> clang --version
>> Ubuntu clang version 18.1.3 (1ubuntu1)
> 
> Hm, pahole should generate kfunc tags since 1.27.
> I use pahole 'next' branch, but it is the same as 1.29 at the moment.
> Do you see kfunc prototypes at the bottom of vmlinux.h?
> They look like so:
> 
>    ...
>    extern u32 tcp_reno_undo_cwnd(struct sock *sk) __weak __ksym;
>    ...
> 
> These are generated by bpftool from decl tags I look for in the test case.
> Decl tags are inserted by pahole, see btf_encoder.c:btf_encoder__tag_kfuncs().
> 

It's all right now, when i use make 
PAHOLE=/home/dylane/sdb/dwarves/build/pahole -j4, thanks.

> Anyways, below is the list of all kfuncs from my config,
> it is possible to adapt the test case with something like this:
> 
>          for (i = 0; i < ARRAY_SIZE(all_kfuncs); ++i) {
>                  kfunc = all_kfuncs[i];
>                  kfunc_id = btf__find_by_name_kind(vmlinux_btf, kfunc, BTF_KIND_FUNC);
>                  printf("%-42s ", kfunc);
>                  if (kfunc_id < 0) {
>                          printf("<not found>\n");
>                          continue;
>                  }
>                  ...
>          }
> 

Well, i try it.

> --- 8< --------------------------------------
> 
> static const char *all_kfuncs[] = {
> 	"bbr_cwnd_event",
> 	"bbr_init",
> 	"bbr_main",
> 	"bbr_min_tso_segs",
> 	"bbr_set_state",
> 	"bbr_sndbuf_expand",
> 	"bbr_ssthresh",
> 	"bbr_undo_cwnd",
> 	"bpf_arena_alloc_pages",
> 	"bpf_arena_free_pages",
> 	"bpf_cast_to_kern_ctx",
> 	"bpf_cgroup_acquire",
> 	"bpf_cgroup_ancestor",
> 	"bpf_cgroup_from_id",
> 	"bpf_cgroup_release",
> 	"bpf_copy_from_user_str",
> 	"bpf_cpumask_acquire",
> 	"bpf_cpumask_and",
> 	"bpf_cpumask_any_and_distribute",
> 	"bpf_cpumask_any_distribute",
> 	"bpf_cpumask_clear",
> 	"bpf_cpumask_clear_cpu",
> 	"bpf_cpumask_copy",
> 	"bpf_cpumask_create",
> 	"bpf_cpumask_empty",
> 	"bpf_cpumask_equal",
> 	"bpf_cpumask_first",
> 	"bpf_cpumask_first_and",
> 	"bpf_cpumask_first_zero",
> 	"bpf_cpumask_full",
> 	"bpf_cpumask_intersects",
> 	"bpf_cpumask_or",
> 	"bpf_cpumask_release",
> 	"bpf_cpumask_set_cpu",
> 	"bpf_cpumask_setall",
> 	"bpf_cpumask_subset",
> 	"bpf_cpumask_test_and_clear_cpu",
> 	"bpf_cpumask_test_and_set_cpu",
> 	"bpf_cpumask_test_cpu",
> 	"bpf_cpumask_weight",
> 	"bpf_cpumask_xor",
> 	"bpf_crypto_ctx_acquire",
> 	"bpf_crypto_ctx_create",
> 	"bpf_crypto_ctx_release",
> 	"bpf_crypto_decrypt",
> 	"bpf_crypto_encrypt",
> 	"bpf_ct_change_status",
> 	"bpf_ct_change_timeout",
> 	"bpf_ct_insert_entry",
> 	"bpf_ct_release",
> 	"bpf_ct_set_nat_info",
> 	"bpf_ct_set_status",
> 	"bpf_ct_set_timeout",
> 	"bpf_dynptr_adjust",
> 	"bpf_dynptr_clone",
> 	"bpf_dynptr_from_skb",
> 	"bpf_dynptr_from_xdp",
> 	"bpf_dynptr_is_null",
> 	"bpf_dynptr_is_rdonly",
> 	"bpf_dynptr_size",
> 	"bpf_dynptr_slice",
> 	"bpf_dynptr_slice_rdwr",
> 	"bpf_fentry_test1",
> 	"bpf_get_dentry_xattr",
> 	"bpf_get_file_xattr",
> 	"bpf_get_fsverity_digest",
> 	"bpf_get_kmem_cache",
> 	"bpf_get_task_exe_file",
> 	"bpf_iter_bits_destroy",
> 	"bpf_iter_bits_new",
> 	"bpf_iter_bits_next",
> 	"bpf_iter_css_destroy",
> 	"bpf_iter_css_new",
> 	"bpf_iter_css_next",
> 	"bpf_iter_css_task_destroy",
> 	"bpf_iter_css_task_new",
> 	"bpf_iter_css_task_next",
> 	"bpf_iter_kmem_cache_destroy",
> 	"bpf_iter_kmem_cache_new",
> 	"bpf_iter_kmem_cache_next",
> 	"bpf_iter_num_destroy",
> 	"bpf_iter_num_new",
> 	"bpf_iter_num_next",
> 	"bpf_iter_scx_dsq_destroy",
> 	"bpf_iter_scx_dsq_new",
> 	"bpf_iter_scx_dsq_next",
> 	"bpf_iter_task_destroy",
> 	"bpf_iter_task_new",
> 	"bpf_iter_task_next",
> 	"bpf_iter_task_vma_destroy",
> 	"bpf_iter_task_vma_new",
> 	"bpf_iter_task_vma_next",
> 	"bpf_key_put",
> 	"bpf_kfunc_call_memb_release",
> 	"bpf_kfunc_call_test_release",
> 	"bpf_list_pop_back",
> 	"bpf_list_pop_front",
> 	"bpf_list_push_back_impl",
> 	"bpf_list_push_front_impl",
> 	"bpf_local_irq_restore",
> 	"bpf_local_irq_save",
> 	"bpf_lookup_system_key",
> 	"bpf_lookup_user_key",
> 	"bpf_map_sum_elem_count",
> 	"bpf_modify_return_test",
> 	"bpf_modify_return_test2",
> 	"bpf_modify_return_test_tp",
> 	"bpf_obj_drop_impl",
> 	"bpf_obj_new_impl",
> 	"bpf_path_d_path",
> 	"bpf_percpu_obj_drop_impl",
> 	"bpf_percpu_obj_new_impl",
> 	"bpf_preempt_disable",
> 	"bpf_preempt_enable",
> 	"bpf_put_file",
> 	"bpf_rbtree_add_impl",
> 	"bpf_rbtree_first",
> 	"bpf_rbtree_remove",
> 	"bpf_rcu_read_lock",
> 	"bpf_rcu_read_unlock",
> 	"bpf_rdonly_cast",
> 	"bpf_refcount_acquire_impl",
> 	"bpf_remove_dentry_xattr",
> 	"bpf_send_signal_task",
> 	"bpf_session_cookie",
> 	"bpf_session_is_return",
> 	"bpf_set_dentry_xattr",
> 	"bpf_sk_assign_tcp_reqsk",
> 	"bpf_skb_ct_alloc",
> 	"bpf_skb_ct_lookup",
> 	"bpf_skb_get_fou_encap",
> 	"bpf_skb_get_xfrm_info",
> 	"bpf_skb_set_fou_encap",
> 	"bpf_skb_set_xfrm_info",
> 	"bpf_sock_addr_set_sun_path",
> 	"bpf_sock_destroy",
> 	"bpf_task_acquire",
> 	"bpf_task_from_pid",
> 	"bpf_task_from_vpid",
> 	"bpf_task_get_cgroup1",
> 	"bpf_task_release",
> 	"bpf_task_under_cgroup",
> 	"bpf_throw",
> 	"bpf_verify_pkcs7_signature",
> 	"bpf_wq_init",
> 	"bpf_wq_set_callback_impl",
> 	"bpf_wq_start",
> 	"bpf_xdp_ct_alloc",
> 	"bpf_xdp_ct_lookup",
> 	"bpf_xdp_flow_lookup",
> 	"bpf_xdp_get_xfrm_state",
> 	"bpf_xdp_metadata_rx_hash",
> 	"bpf_xdp_metadata_rx_timestamp",
> 	"bpf_xdp_metadata_rx_vlan_tag",
> 	"bpf_xdp_xfrm_state_release",
> 	"cgroup_rstat_flush",
> 	"cgroup_rstat_updated",
> 	"crash_kexec",
> 	"cubictcp_acked",
> 	"cubictcp_cong_avoid",
> 	"cubictcp_cwnd_event",
> 	"cubictcp_init",
> 	"cubictcp_recalc_ssthresh",
> 	"cubictcp_state",
> 	"dctcp_cwnd_event",
> 	"dctcp_cwnd_undo",
> 	"dctcp_init",
> 	"dctcp_ssthresh",
> 	"dctcp_state",
> 	"dctcp_update_alpha",
> 	"scx_bpf_consume",
> 	"scx_bpf_cpu_rq",
> 	"scx_bpf_cpuperf_cap",
> 	"scx_bpf_cpuperf_cur",
> 	"scx_bpf_cpuperf_set",
> 	"scx_bpf_create_dsq",
> 	"scx_bpf_destroy_dsq",
> 	"scx_bpf_dispatch",
> 	"scx_bpf_dispatch_cancel",
> 	"scx_bpf_dispatch_from_dsq",
> 	"scx_bpf_dispatch_from_dsq_set_slice",
> 	"scx_bpf_dispatch_from_dsq_set_vtime",
> 	"scx_bpf_dispatch_nr_slots",
> 	"scx_bpf_dispatch_vtime",
> 	"scx_bpf_dispatch_vtime_from_dsq",
> 	"scx_bpf_dsq_insert",
> 	"scx_bpf_dsq_insert_vtime",
> 	"scx_bpf_dsq_move",
> 	"scx_bpf_dsq_move_set_slice",
> 	"scx_bpf_dsq_move_set_vtime",
> 	"scx_bpf_dsq_move_to_local",
> 	"scx_bpf_dsq_move_vtime",
> 	"scx_bpf_dsq_nr_queued",
> 	"scx_bpf_dump_bstr",
> 	"scx_bpf_error_bstr",
> 	"scx_bpf_exit_bstr",
> 	"scx_bpf_get_idle_cpumask",
> 	"scx_bpf_get_idle_smtmask",
> 	"scx_bpf_get_online_cpumask",
> 	"scx_bpf_get_possible_cpumask",
> 	"scx_bpf_kick_cpu",
> 	"scx_bpf_now",
> 	"scx_bpf_nr_cpu_ids",
> 	"scx_bpf_pick_any_cpu",
> 	"scx_bpf_pick_idle_cpu",
> 	"scx_bpf_put_cpumask",
> 	"scx_bpf_put_idle_cpumask",
> 	"scx_bpf_reenqueue_local",
> 	"scx_bpf_select_cpu_dfl",
> 	"scx_bpf_task_cgroup",
> 	"scx_bpf_task_cpu",
> 	"scx_bpf_task_running",
> 	"scx_bpf_test_and_clear_cpu_idle",
> 	"tcp_cong_avoid_ai",
> 	"tcp_reno_cong_avoid",
> 	"tcp_reno_ssthresh",
> 	"tcp_reno_undo_cwnd",
> 	"tcp_slow_start",
> };
> 
> -------------------------------------- >8 ---
> 
> [...]
> 


-- 
Best Regards
Tao Chen

