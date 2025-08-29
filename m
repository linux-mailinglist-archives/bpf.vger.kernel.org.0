Return-Path: <bpf+bounces-66923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2987B3B0FB
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 04:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54771205C3E
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 02:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2E1F0994;
	Fri, 29 Aug 2025 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTVBpnbw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4C61BC5C
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756434101; cv=none; b=pxksrNwZzDJMy9sHDLt59hS2OKl0cNHjuBT+kwy1/I0lonsEe4hBeqL9o8DAaOYMOaNaE8l8L+DWWvCIXmojLqg2t4MRjglsMKAO8Y+/dbo44FGlCfmrU3UYRN73tQvFUGOdD6uHuC4RI1NQQsk5EHhqr33B5JHa3XoW1l9ef5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756434101; c=relaxed/simple;
	bh=WrFNgxcsDnHxlabSXoyODNDr7E3iklBSd0biaITraqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ti81ZWx/6itkb20GBDs98ferJyiBv9s14122WA7gcSKedfEGUAQq1sA6deFyXZJLerBXNma48FSMh/nMuMxJrzXwteogRWoaXDLrm9+kDxmDG8qLe3QBN6O7NfkcoGBa2Qjv3NIyJl55DIqf7Ec4RASmhM7mBTiVjHzrEmPrG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTVBpnbw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77033293ed8so1456056b3a.0
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 19:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756434100; x=1757038900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0cMm5g17HnH2b9tbw+RRmYcSX8Yt0s+yNB8UqCjgeQ=;
        b=RTVBpnbwRgOunRV/88toqFpI6dabx2v8zbrr9SMv4cK53k8vlp8EUPLMPkF0TY6u/L
         WN7ehX0OsbWx5eZDCqWaQQtsdvNTAnziEgfleXO+vc39D6b7wFiEffcbBW4bdBYbT+Yg
         mxC9Z6L3X/AlqL+hnLgtpOhmMZQcDZFKu0m1BNXCI/3HXhaJHlCL3DwUV+aVtPohCwR9
         6QbH8danVe9d+GYz5zgf3JHZsLM9s5Kp8oSAkRLYUrCoiIJaCB7/QaIKhpOLoDYQtSwX
         vefQ4s1lh8Er8uHUfdRqtyo3csbQBfBVFONvhK9XZ6jUoasZCSpbFc6RDyUnLldl66Z5
         Pybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756434100; x=1757038900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0cMm5g17HnH2b9tbw+RRmYcSX8Yt0s+yNB8UqCjgeQ=;
        b=ghtS6lY35VX3HW71uwP+8K5LCQEwkeuuoaumxTqijEG0gmPo6GXLeSMMtc90BJatc9
         v5vt9DTTNV7mk2Gmse208l5YiTndaIDopdD9AMLXFoZ5CynrcFPNoe0qY3+IhzAQP9Uz
         lE+bB/BdJw6z9Fw0mdMS+3mjFp+akWgXIEVb7OYEJeDS36joriLnDJ8dbsqXt4h3/0Ir
         kQaNaEIwBRQj3WpaSQHsd518JPksgEQ01cgZthYN6BweX8CvgQsWjTKBIVdLwxo298ro
         dggNZezcSPbCMwuHa3S8w5Ga1VOlgJLcdu2KzMcafZ6Yvri4fmRwz3bd0e8SmVIJ7TL5
         Jx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaUbSSyeW5RIuXmGY1PVOPGBFIa/vqRiCsWQgMUqOiurEfuDeOQio2udFywEFK3ViQs3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKgb2Z9rz5VlFJJgnhM0fXrYzLWZQKxxQ8ElRuUFO72qdzEbZ
	EVVp27QOEYhY/qH2cflU8HzA6uSIiPeUXci8iPr7UKBdSzdM9WzTogRMPeyuHw==
X-Gm-Gg: ASbGncvm2EA5XigyIXUoiA6k6BDhhnE/8RSj5tx1TLjxom6hDtNilne/33KUWoM9zEl
	BOpjEui06He3IZ7en+pkYc0mq6TpAb6JdqlAHfBzMqGCxo82DinUxd4x8qgFAdqwNJ731xoO9e6
	5SW+9cJWf3/dkoD2hnvv1o8nrV8fXf15AKnjQDdzkk7X1+pbf8xZQktCCVIMpMQq64v5zO8vXdE
	WqKL6VrxrdA4XtE8vcJbeqDuwrukWRQKnX6yJJZR3Vwa4dW6mP2QH51zxvL0ODYhzwyzryZk5bl
	z4u5B4m/ppE0ay/VCGi2WdQoZwjWY1uxCkwmGFTyjb3frZriPUQ7saCnNNeJDtB4iZWpLP3ooMQ
	2OAkL47HvfX5NIc3Bn6JSctQcjF337wy1nyNCi3HNGOQ2gg==
X-Google-Smtp-Source: AGHT+IGmxzoGh7Hgba3J4jKh4rMI3Sg8J/GLCUlgcIP43duaT4eCRRKggEPvllRo9vF1T9X4tLBOog==
X-Received: by 2002:a05:6a00:994:b0:772:3ef:369e with SMTP id d2e1a72fcca58-77203ef36e2mr12052137b3a.11.1756434099618;
        Thu, 28 Aug 2025 19:21:39 -0700 (PDT)
Received: from [10.22.65.172] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2d2ea5sm799011b3a.38.2025.08.28.19.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 19:21:38 -0700 (PDT)
Message-ID: <42f91ff0-b7bf-4ab8-90fe-4ce42eb6bb75@gmail.com>
Date: Fri, 29 Aug 2025 10:21:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
Content-Language: en-US
To: paulmck@kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
 <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev>
 <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
 <b3463ffa-c2cb-43c8-a0d2-92bad49e3c23@linux.dev>
 <93e75cff-871f-4b49-868c-11fea0eec396@paulmck-laptop>
 <DCE3PPX8IFF4.FE1BC8HMP4Y7@linux.dev>
 <CAADnVQ+G73vyC77tSo3AFcBT5FiBFbojfddnpYi5yRcqOxQiDQ@mail.gmail.com>
 <8ab6e14b-e639-413e-91cc-56dc02d1a4fb@paulmck-laptop>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <8ab6e14b-e639-413e-91cc-56dc02d1a4fb@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29/8/25 01:24, Paul E. McKenney wrote:
> On Thu, Aug 28, 2025 at 09:43:00AM -0700, Alexei Starovoitov wrote:
>> On Thu, Aug 28, 2025 at 6:39 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>
>>> On Thu Aug 28, 2025 at 7:50 PM +08, Paul E. McKenney wrote:

[...]

>>>
>>> I think it would be better to add "notrace" to following functions:
>>>
>>> ./bpfsnoop -k 'rcu_read_*lock_*held*,rcu_lockdep_*' --show-func-proto
>>> bool rcu_lockdep_current_cpu_online(); [traceable]
>>> int rcu_read_lock_any_held(); [traceable]
>>> int rcu_read_lock_bh_held(); [traceable]
>>> int rcu_read_lock_held(); [traceable]
>>> int rcu_read_lock_sched_held(); [traceable]
>>
>> Agree. Seems like an easy way to remove a footgun.
> 
> Very good, and please see below.  This might or might not make the next
> merge window, but if not, it should be good for the one after that.
> 
>> Independently it would be good to make noinstr/notrace to include __cpuidle
>> functions. I think right now it's allowed to attach to default_idle()
>> which is causing issues.

Nope.
./bpfsnoop -k 'default_idle' -k '__cpuidle' --show-func-proto
void default_idle();

Here are the traced functions of
./bpfsnoop -D -k "htab_*_elem" --output-fgraph --fgraph-debug
--fgraph-exclude
'rcu_read_lock_*held,rcu_lockdep_current_cpu_online,*raw_spin_*lock*,kvfree,show_stack,put_task_stack':

htab_lru_map_delete_elem
htab_lru_map_lookup_and_delete_elem
htab_lru_map_lookup_elem
htab_lru_map_update_elem
htab_lru_percpu_map_lookup_and_delete_elem
htab_lru_percpu_map_lookup_elem
htab_lru_percpu_map_lookup_percpu_elem
htab_lru_percpu_map_update_elem
htab_map_delete_elem
htab_map_lookup_and_delete_elem
htab_map_lookup_elem
htab_map_seq_show_elem
htab_map_update_elem
htab_of_map_lookup_elem
htab_percpu_map_lookup_and_delete_elem
htab_percpu_map_lookup_elem
htab_percpu_map_lookup_percpu_elem
htab_percpu_map_seq_show_elem
htab_percpu_map_update_elem
add_taint
alloc_htab_elem
arch_scale_cpu_capacity
arch_stack_walk
bpf_list_head_free
__bpf_obj_drop_impl
bpf_obj_free_fields
__bpf_prog_put
bpf_prog_put
bpf_rb_root_free
bpf_timer_cancel_and_free
bpf_wq_cancel_and_free
btf_find_struct_meta
btf_is_kernel
btf_type_seq_show
btf_type_seq_show_flags
btf_type_show
check_and_free_fields
check_panic_on_warn
check_timeout
clear_pending_if_disabled
console_verbose
copy_map_value_locked
ctx_sched_out
__delayacct_blkio_start
__do_set_cpus_allowed
do_trace_write_msr
enter_lazy_tlb
__folio_put
__folio_unqueue_deferred_split
free_frozen_pages
free_htab_elem
free_huge_folio
get_free_pages_noprof
get_state_synchronize_rcu
get_state_synchronize_rcu_full
get_taint
hrtick_start_fair
hrtimer_active
hrtimer_cancel
hrtimer_setup
hrtimer_start_range_ns
__htab_lru_percpu_map_update_elem
__htab_map_lookup_and_delete_elem
__htab_map_lookup_elem
htab_map_update_elem_in_place
invalidate_user_asid
__is_kernel_percpu_address
is_kernel_percpu_address
is_module_address
__is_module_percpu_address
is_module_percpu_address
is_vmalloc_addr
kallsyms_lookup
kexec_crash_loaded
kvfree_call_rcu
local_clock
__mem_cgroup_uncharge
__might_sleep
mm_needs_global_asid
mod_node_page_state
__msecs_to_jiffies
nbcon_cpu_emergency_enter
nbcon_cpu_emergency_exit
nbcon_get_cpu_emergency_nesting
pcpu_copy_value
perf_cgroup_switch
perf_clear_dirty_counters
perf_ctx_disable
perf_ctx_enable
perf_ctx_sched_task_cb
__perf_event_task_sched_out
perf_event_update_time
perf_event_update_userpage
perf_exclude_event
perf_pmu_sched_task
___perf_sw_event
perf_swevent_event
pick_next_task_fair
pick_task_fair
pick_task_fair
pick_task_idle
preempt_model_str
__printk_cpu_sync_put
__printk_cpu_sync_try_get
__printk_cpu_sync_wait
printk_percpu_data_ready
print_modules
print_stop_info
print_tainted
print_tainted_verbose
print_worker_info
profile_hits
put_prev_entity
queue_delayed_work_on
queued_spin_lock_slowpath
__queue_work
queue_work_on
rcu_note_context_switch
rcu_qs
rcu_report_exp_cpu_mult
rcu_tasks_trace_qs_blkd
rcu_trc_cmpxchg_need_qs
resilient_queued_spin_lock_slowpath
sched_balance_newidle
__schedule_bug
__schedule_delayed_monitor_work
seq_putc
seq_write
set_next_entity
stack_trace_print
stack_trace_save
switch_ldt
switch_mm_irqs_off
synchronize_rcu
task_h_load
task_work_add
this_cpu_in_panic
touch_all_softlockup_watchdogs
__traceiter_contention_begin
__traceiter_contention_end
__traceiter_lock_acquire
__traceiter_lock_release
__traceiter_rcu_preempt_task
__traceiter_sched_entry_tp
__traceiter_sched_exit_tp
__traceiter_tlb_flush
unpin_user_page
__update_context_time
update_rq_clock

> 
> Leon, would you be interested in putting together a patch for these?
> 

I think we can apply this patch first.

If other patch is required, I would like to send it later.

Thanks,
Leon


