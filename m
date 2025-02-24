Return-Path: <bpf+bounces-52396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE53A42953
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5AE3A4E05
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27882263C66;
	Mon, 24 Feb 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lP7oDQJn"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A867263884
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417247; cv=none; b=frCad+Xwut8RUgWiKCjcfkMs9Wv8XM24nXJmpG5HlUPUg6Rw4B1Z11gx6whr6vMBEqyYdDyIiQlTv3ldzP7PLH5zBGm3KMK9q00EiLxueXb67tlvAmVLkKovSI/eIIpdRiA86cHCaeY4+5yENZtX/xV9j6wQgd/6Q6KOE3Okkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417247; c=relaxed/simple;
	bh=PwRxqQD0wAdBd1zDdaSom+KR9ihKhhFSomnZuCsM/ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNb53cQRy8LazbiTCol4+J2Lb3/gBKvx5tEEVOlsaGBuUdpKxmdE5uRwdhL/zaTH3GujWBwRm9DFSmYPdMFbKjnwNsElD8Aaa7hlvGXnC8kGhMvXMIpXWEqTtqoUjZELTyuiRSEb5sZq5HDx8l/Jd08NLMzZDtok7fJD09N5LNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lP7oDQJn; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9e36bd3-0903-4ce6-afdc-7deff6d489c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740417242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOnBmNy8R6M0jKk8g0HOfWTQudBqwDfcR0uXVQHIjRQ=;
	b=lP7oDQJntjKoHQogLnVylX/6KDMSm3Lm+jQEd5VzjLJuO0P1XYY0hKYi/W4GkNu7L7s+He
	ReaUIHWOl7tZDdjpP1vV4xZvVV6tSzvSYD7PxsRC+HJBlYc11L8Dz7vPRlG7Wigz8dLvNw
	bOU5/BtT6Lxtkwhf0AgAoJeYekR4wrI=
Date: Tue, 25 Feb 2025 01:13:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 0/5] Add prog_kfunc feature probe
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, chen.dylane@gmail.com
References: <20250224165912.599068-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20250224165912.599068-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/25 00:59, Tao Chen 写道:
> More and more kfunc functions are being added to the kernel.
> Different prog types have different restrictions when using kfunc.
> Therefore, prog_kfunc probe is added to check whether it is supported,
> and the use of this api will be added to bpftool later.
> 
> Change list:
> - v7 -> v8:
>    - fix "kfuncs require device-bound" verifier info
>    - init expected_attach_type for kprobe prog type
>    - patchset Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> - v7
>    https://lore.kernel.org/bpf/20250212153912.24116-1-chen.dylane@gmail.com/
> 
> - v6 -> v7:
>    - wrap err with libbpf_err
>    - comments fix
>    - handle btf_fd < 0 as vmlinux
>    - patchset Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> - v6
>    https://lore.kernel.org/bpf/20250211111859.6029-1-chen.dylane@gmail.com
> 
> - v5 -> v6:
>    - remove fd_array_cnt
>    - test case clean code
> - v5
>    https://lore.kernel.org/bpf/20250210055945.27192-1-chen.dylane@gmail.com
> 
> - v4 -> v5:
>    - use fd_array on stack
>    - declare the scope of use of btf_fd
> - v4
>    https://lore.kernel.org/bpf/20250206051557.27913-1-chen.dylane@gmail.com/
> 
> - v3 -> v4:
>    - add fd_array init for kfunc in mod btf
>    - add test case for kfunc in mod btf
>    - refactor common part as prog load type check for
>      libbpf_probe_bpf_{helper,kfunc}
> - v3
>    https://lore.kernel.org/bpf/20250124144411.13468-1-chen.dylane@gmail.com
> 
> - v2 -> v3:
>    - rename parameter off with btf_fd
>    - extract the common part for libbpf_probe_bpf_{helper,kfunc}
> - v2
>    https://lore.kernel.org/bpf/20250123170555.291896-1-chen.dylane@gmail.com
> 
> - v1 -> v2:
>    - check unsupported prog type like probe_bpf_helper
>    - add off parameter for module btf
>    - check verifier info when kfunc id invalid
> - v1
>    https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com
> 
> Tao Chen (5):
>    libbpf: Extract prog load type check from libbpf_probe_bpf_helper
>    libbpf: Init fd_array when prog probe load
>    libbpf: Add libbpf_probe_bpf_kfunc API
>    libbpf: Init kprobe prog expected_attach_type for kfunc probe
>    selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
> 
>   tools/lib/bpf/libbpf.h                        |  19 ++-
>   tools/lib/bpf/libbpf.map                      |   1 +
>   tools/lib/bpf/libbpf_probes.c                 |  90 +++++++++++---
>   .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 ++++++++++++++++++
>   4 files changed, 205 insertions(+), 16 deletions(-)
> 


Hi Eduard,
I used a simple script to find all kfunc prog types and comapre it with 
your program, most of them are consistent， the results are as follows, 
and i add pathch 4 additionally to fix kfunc probe like 
bpf_session_is_return.

-------------------------------------------------
The script results:
hid_bpf_allocate_context: SYSCALL
hid_bpf_release_context: SYSCALL
hid_bpf_hw_request: SYSCALL
hid_bpf_hw_output_report: SYSCALL
hid_bpf_input_report: SYSCALL
bpf_session_is_return: KPROBE
bpf_session_cookie: KPROBE
scx_bpf_create_dsq: SYSCALL
scx_bpf_dsq_move_set_slice: SYSCALL
scx_bpf_dsq_move_set_vtime: SYSCALL
scx_bpf_dsq_move: SYSCALL
scx_bpf_dsq_move_vtime: SYSCALL
scx_bpf_dispatch_from_dsq_set_slice: SYSCALL
scx_bpf_dispatch_from_dsq_set_vtime: SYSCALL
scx_bpf_dispatch_from_dsq: SYSCALL
scx_bpf_dispatch_vtime_from_dsq: SYSCALL
scx_bpf_kick_cpu: SYSCALL
scx_bpf_dsq_nr_queued: SYSCALL
scx_bpf_destroy_dsq: SYSCALL
bpf_iter_scx_dsq_new: SYSCALL
bpf_iter_scx_dsq_next: SYSCALL
bpf_iter_scx_dsq_destroy: SYSCALL
scx_bpf_exit_bstr: SYSCALL
scx_bpf_error_bstr: SYSCALL
scx_bpf_dump_bstr: SYSCALL
scx_bpf_cpuperf_cap: SYSCALL
scx_bpf_cpuperf_cur: SYSCALL
scx_bpf_cpuperf_set: SYSCALL
scx_bpf_nr_cpu_ids: SYSCALL
scx_bpf_get_possible_cpumask: SYSCALL
scx_bpf_get_online_cpumask: SYSCALL
scx_bpf_put_cpumask: SYSCALL
scx_bpf_get_idle_cpumask: SYSCALL
scx_bpf_get_idle_smtmask: SYSCALL
scx_bpf_put_idle_cpumask: SYSCALL
scx_bpf_test_and_clear_cpu_idle: SYSCALL
scx_bpf_pick_idle_cpu: SYSCALL
scx_bpf_pick_any_cpu: SYSCALL
scx_bpf_task_running: SYSCALL
scx_bpf_task_cpu: SYSCALL
scx_bpf_cpu_rq: SYSCALL
scx_bpf_task_cgroup: SYSCALL
scx_bpf_now: SYSCALL
bpf_arena_alloc_pages: UNSPEC
bpf_arena_free_pages: UNSPEC
bpf_crypto_decrypt: XDP, SCHED_ACT, SCHED_CLS
bpf_crypto_encrypt: XDP, SCHED_ACT, SCHED_CLS
bpf_crypto_ctx_create: SYSCALL
bpf_crypto_ctx_release: SYSCALL
bpf_crypto_ctx_acquire: SYSCALL
bpf_map_sum_elem_count: UNSPEC
bpf_cpumask_create: SYSCALL
bpf_cpumask_release: SYSCALL
bpf_cpumask_acquire: SYSCALL
bpf_cpumask_first: SYSCALL
bpf_cpumask_first_zero: SYSCALL
bpf_cpumask_first_and: SYSCALL
bpf_cpumask_set_cpu: SYSCALL
bpf_cpumask_clear_cpu: SYSCALL
bpf_cpumask_test_cpu: SYSCALL
bpf_cpumask_test_and_set_cpu: SYSCALL
bpf_cpumask_test_and_clear_cpu: SYSCALL
bpf_cpumask_setall: SYSCALL
bpf_cpumask_clear: SYSCALL
bpf_cpumask_and: SYSCALL
bpf_cpumask_or: SYSCALL
bpf_cpumask_xor: SYSCALL
bpf_cpumask_equal: SYSCALL
bpf_cpumask_intersects: SYSCALL
bpf_cpumask_subset: SYSCALL
bpf_cpumask_empty: SYSCALL
bpf_cpumask_full: SYSCALL
bpf_cpumask_copy: SYSCALL
bpf_cpumask_any_distribute: SYSCALL
bpf_cpumask_any_and_distribute: SYSCALL
bpf_cpumask_weight: SYSCALL
crash_kexec: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_obj_new_impl: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_percpu_obj_new_impl: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_obj_drop_impl: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_percpu_obj_drop_impl: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_refcount_acquire_impl: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_list_push_front_impl: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_list_push_back_impl: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_list_pop_front: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_list_pop_back: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_task_acquire: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_task_release: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_rbtree_remove: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_rbtree_add_impl: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_rbtree_first: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_cgroup_acquire: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_cgroup_release: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_cgroup_ancestor: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_cgroup_from_id: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_task_under_cgroup: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_task_get_cgroup1: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_task_from_pid: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_task_from_vpid: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_throw: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_send_signal_task: XDP, SCHED_CLS, CGROUP_SKB, SYSCALL
bpf_cast_to_kern_ctx: UNSPEC
bpf_rdonly_cast: UNSPEC
bpf_rcu_read_lock: UNSPEC
bpf_rcu_read_unlock: UNSPEC
bpf_dynptr_slice: UNSPEC
bpf_dynptr_slice_rdwr: UNSPEC
bpf_iter_num_new: UNSPEC
bpf_iter_num_next: UNSPEC
bpf_iter_num_destroy: UNSPEC
bpf_iter_task_vma_new: UNSPEC
bpf_iter_task_vma_next: UNSPEC
bpf_iter_task_vma_destroy: UNSPEC
bpf_iter_css_task_new: UNSPEC
bpf_iter_css_task_next: UNSPEC
bpf_iter_css_task_destroy: UNSPEC
bpf_iter_css_new: UNSPEC
bpf_iter_css_next: UNSPEC
bpf_iter_css_destroy: UNSPEC
bpf_iter_task_new: UNSPEC
bpf_iter_task_next: UNSPEC
bpf_iter_task_destroy: UNSPEC
bpf_dynptr_adjust: UNSPEC
bpf_dynptr_is_null: UNSPEC
bpf_dynptr_is_rdonly: UNSPEC
bpf_dynptr_size: UNSPEC
bpf_dynptr_clone: UNSPEC
bpf_modify_return_test_tp: UNSPEC
bpf_wq_init: UNSPEC
bpf_wq_set_callback_impl: UNSPEC
bpf_wq_start: UNSPEC
bpf_preempt_disable: UNSPEC
bpf_preempt_enable: UNSPEC
bpf_iter_bits_new: UNSPEC
bpf_iter_bits_next: UNSPEC
bpf_iter_bits_destroy: UNSPEC
bpf_copy_from_user_str: UNSPEC
bpf_get_kmem_cache: UNSPEC
bpf_iter_kmem_cache_new: UNSPEC
bpf_iter_kmem_cache_next: UNSPEC
bpf_iter_kmem_cache_destroy: UNSPEC
bpf_local_irq_save: UNSPEC
bpf_local_irq_restore: UNSPEC
bpf_skb_set_fou_encap: SCHED_CLS
bpf_skb_get_fou_encap: SCHED_CLS
bpf_xdp_ct_alloc: XDP, SCHED_CLS
bpf_xdp_ct_lookup: XDP, SCHED_CLS
bpf_skb_ct_alloc: XDP, SCHED_CLS
bpf_skb_ct_lookup: XDP, SCHED_CLS
bpf_ct_insert_entry: XDP, SCHED_CLS
bpf_ct_release: XDP, SCHED_CLS
bpf_ct_set_timeout: XDP, SCHED_CLS
bpf_ct_change_timeout: XDP, SCHED_CLS
bpf_ct_set_status: XDP, SCHED_CLS
bpf_ct_change_status: XDP, SCHED_CLS
bpf_ct_set_nat_info: XDP, SCHED_CLS
bpf_xdp_flow_lookup: XDP
bpf_skb_get_xfrm_info: SCHED_CLS
bpf_skb_set_xfrm_info: SCHED_CLS
bpf_xdp_get_xfrm_state: XDP
bpf_xdp_xfrm_state_release: XDP
name: XDP
bpf_dynptr_from_skb: LWT_OUT, SCHED_ACT, SCHED_CLS, LWT_XMIT, NETFILTER, 
LWT_IN, SK_SKB, LWT_SEG6LOCAL, SOCKET_FILTER, CGROUP_SKB
bpf_dynptr_from_xdp: XDP
bpf_sock_addr_set_sun_path: CGROUP_SOCK_ADDR
bpf_sk_assign_tcp_reqsk: SCHED_CLS
bpf_kfunc_call_test_release: SCHED_CLS, SYSCALL
bpf_kfunc_call_memb_release: SCHED_CLS, SYSCALL

---------------------------------------------------
The c code results:
[106425] scx_bpf_select_cpu_dfl
[106393] scx_bpf_dsq_insert
[106394] scx_bpf_dsq_insert_vtime
[106381] scx_bpf_dispatch
[106391] scx_bpf_dispatch_vtime
[106389] scx_bpf_dispatch_nr_slots
[106382] scx_bpf_dispatch_cancel
[106398] scx_bpf_dsq_move_to_local
[106369] scx_bpf_consume
[106396] scx_bpf_dsq_move_set_slice         SYSCALL
[106397] scx_bpf_dsq_move_set_vtime         SYSCALL
[106395] scx_bpf_dsq_move                   SYSCALL
[106399] scx_bpf_dsq_move_vtime             SYSCALL
[106386] scx_bpf_dispatch_from_dsq_set_slice     SYSCALL
[106388] scx_bpf_dispatch_from_dsq_set_vtime     SYSCALL
[106384] scx_bpf_dispatch_from_dsq          SYSCALL
[106392] scx_bpf_dispatch_vtime_from_dsq     SYSCALL
[106423] scx_bpf_reenqueue_local
[106378] scx_bpf_create_dsq                 SYSCALL
[106413] scx_bpf_kick_cpu                   SYSCALL
[106401] scx_bpf_dsq_nr_queued              SYSCALL
[106379] scx_bpf_destroy_dsq                SYSCALL
[59846 ] bpf_iter_scx_dsq_new               SYSCALL
[59848 ] bpf_iter_scx_dsq_next              SYSCALL
[59844 ] bpf_iter_scx_dsq_destroy           SYSCALL
[106406] scx_bpf_exit_bstr                  SYSCALL
[106404] scx_bpf_error_bstr                 SYSCALL
[106403] scx_bpf_dump_bstr                  SYSCALL
[106373] scx_bpf_cpuperf_cap                SYSCALL
[106374] scx_bpf_cpuperf_cur                SYSCALL
[106376] scx_bpf_cpuperf_set                SYSCALL
[106415] scx_bpf_nr_cpu_ids                 SYSCALL
[106411] scx_bpf_get_possible_cpumask       SYSCALL
[106410] scx_bpf_get_online_cpumask         SYSCALL
[106420] scx_bpf_put_cpumask                SYSCALL
[106408] scx_bpf_get_idle_cpumask           SYSCALL
[106409] scx_bpf_get_idle_smtmask           SYSCALL
[106422] scx_bpf_put_idle_cpumask           SYSCALL
[106433] scx_bpf_test_and_clear_cpu_idle     SYSCALL
[106418] scx_bpf_pick_idle_cpu              SYSCALL
[106417] scx_bpf_pick_any_cpu               SYSCALL
[106431] scx_bpf_task_running               SYSCALL
[106429] scx_bpf_task_cpu                   SYSCALL
[106371] scx_bpf_cpu_rq                     SYSCALL
[106427] scx_bpf_task_cgroup                SYSCALL
[106414] scx_bpf_now                        SYSCALL
[62231 ] cgroup_rstat_updated
[62225 ] cgroup_rstat_flush
[60053 ] bpf_lookup_user_key
[60051 ] bpf_lookup_system_key
[59954 ] bpf_key_put
[60551 ] bpf_session_is_return          KPROBE
[60550 ] bpf_session_cookie             KPROBE
[64314 ] crash_kexec                      XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60256 ] bpf_obj_new_impl                 XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60290 ] bpf_percpu_obj_new_impl          XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60242 ] bpf_obj_drop_impl                XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60289 ] bpf_percpu_obj_drop_impl         XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60484 ] bpf_refcount_acquire_impl        XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60027 ] bpf_list_push_front_impl         XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60026 ] bpf_list_push_back_impl          XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60024 ] bpf_list_pop_front               XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60023 ] bpf_list_pop_back                XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60797 ] bpf_task_acquire                 XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60808 ] bpf_task_release                 XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60472 ] bpf_rbtree_remove                XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60468 ] bpf_rbtree_add_impl              XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60470 ] bpf_rbtree_first                 XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[59305 ] bpf_cgroup_acquire               XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[59320 ] bpf_cgroup_release               XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[59307 ] bpf_cgroup_ancestor              XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[59309 ] bpf_cgroup_from_id               XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60818 ] bpf_task_under_cgroup            XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60805 ] bpf_task_get_cgroup1             XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60801 ] bpf_task_from_pid                XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60803 ] bpf_task_from_vpid               XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60871 ] bpf_throw                        XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[60539 ] bpf_send_signal_task             XDP SYSCALL SCHED_CLS 
CGROUP_SKB
[59303 ] bpf_cast_to_kern_ctx           KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60476 ] bpf_rdonly_cast                KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60473 ] bpf_rcu_read_lock              KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60474 ] bpf_rcu_read_unlock            KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59556 ] bpf_dynptr_slice               KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59557 ] bpf_dynptr_slice_rdwr          KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59834 ] bpf_iter_num_new               KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59836 ] bpf_iter_num_next              KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59832 ] bpf_iter_num_destroy           KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59867 ] bpf_iter_task_vma_new          KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59869 ] bpf_iter_task_vma_next         KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59865 ] bpf_iter_task_vma_destroy      KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59774 ] bpf_iter_css_task_new          KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59776 ] bpf_iter_css_task_next         KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59772 ] bpf_iter_css_task_destroy      KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59768 ] bpf_iter_css_new               KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59770 ] bpf_iter_css_next              KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59766 ] bpf_iter_css_destroy           KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59858 ] bpf_iter_task_new              KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59860 ] bpf_iter_task_next             KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59854 ] bpf_iter_task_destroy          KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59528 ] bpf_dynptr_adjust              KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59546 ] bpf_dynptr_is_null             KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59547 ] bpf_dynptr_is_rdonly           KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59554 ] bpf_dynptr_size                KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59532 ] bpf_dynptr_clone               KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60197 ] bpf_modify_return_test_tp      KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60981 ] bpf_wq_init                    KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60983 ] bpf_wq_set_callback_impl       KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60985 ] bpf_wq_start                   KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60311 ] bpf_preempt_disable            KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60312 ] bpf_preempt_enable             KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59746 ] bpf_iter_bits_new              KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59748 ] bpf_iter_bits_next             KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59744 ] bpf_iter_bits_destroy          KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59356 ] bpf_copy_from_user_str         KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59657 ] bpf_get_kmem_cache             KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59807 ] bpf_iter_kmem_cache_new        KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59809 ] bpf_iter_kmem_cache_next       KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59805 ] bpf_iter_kmem_cache_destroy    KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60030 ] bpf_local_irq_save             KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60029 ] bpf_local_irq_restore          KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[60153 ] bpf_map_sum_elem_count         KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59280 ] bpf_arena_alloc_pages          KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59282 ] bpf_arena_free_pages           KPROBE XDP SYSCALL SCHED_CLS 
SCHED_ACT SK_SKB SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT 
LWT_SEG6LOCAL NETFILTER
[59404 ] bpf_cpumask_create                 SYSCALL
[59416 ] bpf_cpumask_release                SYSCALL
[59390 ] bpf_cpumask_acquire                SYSCALL
[59409 ] bpf_cpumask_first                  SYSCALL
[59411 ] bpf_cpumask_first_zero             SYSCALL
[59410 ] bpf_cpumask_first_and              SYSCALL
[59419 ] bpf_cpumask_set_cpu                SYSCALL
[59400 ] bpf_cpumask_clear_cpu              SYSCALL
[59426 ] bpf_cpumask_test_cpu               SYSCALL
[59424 ] bpf_cpumask_test_and_set_cpu       SYSCALL
[59423 ] bpf_cpumask_test_and_clear_cpu     SYSCALL
[59420 ] bpf_cpumask_setall                 SYSCALL
[59398 ] bpf_cpumask_clear                  SYSCALL
[59392 ] bpf_cpumask_and                    SYSCALL
[59415 ] bpf_cpumask_or                     SYSCALL
[59428 ] bpf_cpumask_xor                    SYSCALL
[59408 ] bpf_cpumask_equal                  SYSCALL
[59413 ] bpf_cpumask_intersects             SYSCALL
[59421 ] bpf_cpumask_subset                 SYSCALL
[59406 ] bpf_cpumask_empty                  SYSCALL
[59412 ] bpf_cpumask_full                   SYSCALL
[59402 ] bpf_cpumask_copy                   SYSCALL
[59396 ] bpf_cpumask_any_distribute         SYSCALL
[59394 ] bpf_cpumask_any_and_distribute     SYSCALL
[59427 ] bpf_cpumask_weight                 SYSCALL
[59434 ] bpf_crypto_ctx_create              SYSCALL
[59436 ] bpf_crypto_ctx_release             SYSCALL
[59432 ] bpf_crypto_ctx_acquire             SYSCALL
[59438 ] bpf_crypto_decrypt               XDP   SCHED_CLS SCHED_ACT
[59439 ] bpf_crypto_encrypt               XDP   SCHED_CLS SCHED_ACT
[59538 ] bpf_dynptr_from_skb                  SCHED_CLS SCHED_ACT SK_SKB 
SOCKET_FILTER CGROUP_SKB LWT_OUT LWT_IN LWT_XMIT LWT_SEG6LOCAL NETFILTER
[59542 ] bpf_dynptr_from_xdp              XDP
[60702 ] bpf_sock_addr_set_sun_path                   CGROUP_SKB
[60564 ] bpf_sk_assign_tcp_reqsk              SCHED_CLS
[60712 ] bpf_sock_destroy
[61023 ] bpf_xdp_metadata_rx_timestamp
[61021 ] bpf_xdp_metadata_rx_hash
[61025 ] bpf_xdp_metadata_rx_vlan_tag
[60193 ] bpf_modify_return_test
[60195 ] bpf_modify_return_test2
[59582 ] bpf_fentry_test1
[59960 ] bpf_kfunc_call_test_release        SYSCALL SCHED_CLS
[59957 ] bpf_kfunc_call_memb_release        SYSCALL SCHED_CLS
[60998 ] bpf_xdp_ct_alloc                 XDP   SCHED_CLS
[61000 ] bpf_xdp_ct_lookup                XDP   SCHED_CLS
[60635 ] bpf_skb_ct_alloc                 XDP   SCHED_CLS
[60637 ] bpf_skb_ct_lookup                XDP   SCHED_CLS
[59472 ] bpf_ct_insert_entry              XDP   SCHED_CLS
[59474 ] bpf_ct_release                   XDP   SCHED_CLS
[59480 ] bpf_ct_set_timeout               XDP   SCHED_CLS
[59470 ] bpf_ct_change_timeout            XDP   SCHED_CLS
[59478 ] bpf_ct_set_status                XDP   SCHED_CLS
[59468 ] bpf_ct_change_status             XDP   SCHED_CLS
[59476 ] bpf_ct_set_nat_info              XDP   SCHED_CLS
[65211 ] cubictcp_init
[65212 ] cubictcp_recalc_ssthresh
[65208 ] cubictcp_cong_avoid
[65214 ] cubictcp_state
[65210 ] cubictcp_cwnd_event
[65207 ] cubictcp_acked
[113327] tcp_reno_ssthresh
[113326] tcp_reno_cong_avoid
[113328] tcp_reno_undo_cwnd
[113396] tcp_slow_start
[113087] tcp_cong_avoid_ai
[61008 ] bpf_xdp_get_xfrm_state           XDP
[61037 ] bpf_xdp_xfrm_state_release       XDP

--------------------------------------------------------------
The script:
#!/bin/python3

import os
import re
from collections import defaultdict

# Regular expression to match register_btf_kfunc_id_set calls (supports 
multi-line)
register_pattern = re.compile(
     r'register_btf_kfunc_id_set\s*\(\s*(BPF_PROG_TYPE_\w+)\s*,'  # 
Match function name and first argument
     r'[\s\S]*?&(\w+)\s*\)',  # Match second argument (supports multi-line)
     re.DOTALL  # Enable multi-line matching
)

# Regular expression to match struct variable definitions and .set 
initialization
struct_var_pattern = re.compile(
     r'static\s+const\s+struct\s+btf_kfunc_id_set\s+'  # Match struct 
variable definition
     r'(\w+)\s*=\s*\{.*?\.set\s*=\s*&(\w+)\s*,.*?\};',  # Match .set 
initialization
     re.DOTALL  # Enable multi-line matching
)

# Regular expression to match BTF_KFUNCS_START and BTF_KFUNCS_END blocks
btf_kfuncs_pattern = re.compile(
     r'BTF_KFUNCS_START\s*\(\s*(\w+)\s*\)'  # Match BTF_KFUNCS_START
     r'([\s\S]*?)'  # Match any content (non-greedy)
     r'BTF_KFUNCS_END\s*\(\s*\1\s*\)',  # Match BTF_KFUNCS_END with the 
same parameter
     re.DOTALL  # Enable multi-line matching
)

# Regular expression to match BTF_ID_FLAGS(func, ...) declared functions
btf_id_flags_pattern = re.compile(
     r'BTF_ID_FLAGS\s*\(\s*func\s*,\s*(\w+)\s*(?:,\s*.*?)?\)'  # Match 
function name
)

# Dictionary to store functions and their corresponding prog_types
func_prog_types = defaultdict(set)

# Set of prog_types to exclude
excluded_prog_types = {
     "TRACING",
     "EXT",
     "LSM",
     "STRUCT_OPS",
}

def scan_file(file_path):
     """
     Scan a single file to find register_btf_kfunc_id_set calls and 
further scan for struct variables and BTF_KFUNCS blocks.
     """
     with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
         content = file.read()
         content = content.replace('\r\n', '\n')

         # Find register_btf_kfunc_id_set calls
         register_matches = register_pattern.findall(content)
         for prog_type, kfunc_set in register_matches:
             # Remove BPF_PROG_TYPE_ prefix
             prog_type_short = prog_type.replace("BPF_PROG_TYPE_", "")

             # Skip excluded prog_types
             if prog_type_short in excluded_prog_types:
                 continue

             print(f"File: {file_path}")
             print(f"  prog_type: {prog_type_short}")
             print(f"  kfunc_set: {kfunc_set}")

             # Find struct variables with the same name
             struct_var_matches = struct_var_pattern.findall(content)
             found = False
             for struct_var_name, set_name in struct_var_matches:
                 if struct_var_name == kfunc_set:
                     print(f"  Struct variable: {struct_var_name}")
                     print(f"  .set initialized with: {set_name}")
                     found = True

                     # Find BTF_KFUNCS_START and BTF_KFUNCS_END blocks
                     btf_kfuncs_matches = 
btf_kfuncs_pattern.findall(content)
                     #print(btf_kfuncs_matches)
                     if btf_kfuncs_matches:
                         for func, block_content in btf_kfuncs_matches:
                             if func == set_name:
                                 #block_content = btf_kfuncs_match.group(2)
                                 print(f"  BTF_KFUNCS block found for 
{set_name}")

                                 # Extract functions declared in 
BTF_ID_FLAGS(func, ...)
                                 func_matches = 
btf_id_flags_pattern.findall(block_content)
                                 if func_matches:
                                     print("  Functions declared in block:")
                                     for func_name in func_matches:
                                         print(f"    {func_name} 
(prog_type: {prog_type_short})")
                                         # Record function and its 
corresponding prog_type
  
func_prog_types[func_name].add(prog_type_short)
                                 else:
                                     print("  No functions found in block")
                     else:
                         print(f"  No BTF_KFUNCS block found for 
{set_name}")

                     break

             if not found:
                 print(f"  No matching struct variable found for 
{kfunc_set}")

             print("-" * 40)

def scan_repository(repo_path):
     """
     Traverse all .c and .h files in the repository and call scan_file 
for each file.
     """
     for root, dirs, files in os.walk(repo_path):
         # Exclude selftest directory
         if "selftests" in dirs:
             dirs.remove("selftests")

         for file_name in files:
             if file_name.endswith(('.c', '.h')):
                 file_path = os.path.join(root, file_name)
                 scan_file(file_path)

def print_func_prog_types():
     print("\nSummary of functions and their corresponding prog_types:")
     for func_name, prog_types in func_prog_types.items():
         print(f"{func_name}: {', '.join(prog_types)}")

if __name__ == "__main__":
     repo_path = "/home/dylane/sdb/bpf-next2/bpf-next"  # Replace with 
your repository path

     print(f"Scanning repository: {repo_path}")
     scan_repository(repo_path)

     print_func_prog_types()

------------------------------------------------------
the c code:
static const struct {
	const char *name;
	int code;
} program_types[] = {
#define _T(n) { #n, BPF_PROG_TYPE_ ## n }
	_T(KPROBE),
	_T(XDP),
	_T(SYSCALL),
	_T(SCHED_CLS),
	_T(SCHED_ACT),
	_T(SK_SKB),
	_T(SOCKET_FILTER),
	_T(CGROUP_SKB),
	_T(LWT_OUT),
	_T(LWT_IN),
	_T(LWT_XMIT),
	_T(LWT_SEG6LOCAL),
	_T(NETFILTER)
#undef _T
};

void test_libbpf_probe_kfuncs_many(void)
{
	int i, kfunc_id, ret, id;
	const struct btf_type *t;
	struct btf *btf = NULL;
	const char *kfunc;
	const char *tag;

	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
	if (!ASSERT_OK_PTR(btf, "btf_parse"))
		return;
	for (id = 0; id < btf__type_cnt(btf); ++id) {
		t = btf__type_by_id(btf, id);
		if (!t)
			continue;
		if (!btf_is_decl_tag(t))
			continue;
		tag = btf__name_by_offset(btf, t->name_off);
		if (strcmp(tag, "bpf_kfunc") != 0)
			continue;
		kfunc_id = t->type;
		t = btf__type_by_id(btf, kfunc_id);
		if (!btf_is_func(t))
			continue;
		kfunc = btf__name_by_offset(btf, t->name_off);
		printf("[%-6d] %-42s ", kfunc_id, kfunc);
		for (i = 0; i < ARRAY_SIZE(program_types); ++i) {
			ret = libbpf_probe_bpf_kfunc(program_types[i].code, kfunc_id, -1, NULL);
			if (ret < 0)
				printf("%-2d  ", ret);
			else if (ret == 0)
				printf("%2s", "");
			else
				printf("%2s  ", program_types[i].name);
		}
		printf("\n");
	}
	btf__free(btf);
}


-- 
Best Regards
Tao Chen

