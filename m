Return-Path: <bpf+bounces-54478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75328A6AB52
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B1E486DF4
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622AF2222A5;
	Thu, 20 Mar 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbmNHR6V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F61D7E41;
	Thu, 20 Mar 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489129; cv=none; b=EzwWEvEamEkSKpTElCuO56wcQsR5EfTIkVYkL8UeSXM3RQg0semDLHcNajwL0WjasoG8OUTHnXea6za9W4GCkqHOo9bxPwiZuixd6hhjA+FuxatUkEsOBD3XiSCzyFK9skf1e4bcFWGolZfi0bW/4Wsxjyx9+1VicEixG+PFiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489129; c=relaxed/simple;
	bh=95hM7WSs+2jk1ALyvUvZARhBGWcyDbfmG+wj8MfcaPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCsPl0OHqC2dqtryGhaa52Ei4spX3lPB2du2/OAZ7niJwQMcBBeNzDv1dXIx7ugS4XTFHc8FqEli/YMOz5+H0QdsUFHibwWtcP2GMiXF37F8G2MmMh7MDdNTDPJPMWmGp+pqMuRh/hAe8CdpYLCDikswUWQxJAgZotx6j4IQ6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbmNHR6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F700C4CEF2;
	Thu, 20 Mar 2025 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742489129;
	bh=95hM7WSs+2jk1ALyvUvZARhBGWcyDbfmG+wj8MfcaPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sbmNHR6VYM641yRYToxqUQuweYoo9rmvh4y+rn74wPnnhc9EoxHAzsKHOIQt1uh42
	 YaN2tlsYhSRb2GYsh06rYF8oH7Lv8km2DQ16wYYZHT0pAlA4L4fygLdEY7oshf54Bk
	 +BNUEPw21GnUeOZF11v3ADU6LQjsnhw0S3BQ7/x7DGOSD7WliaG2ipOTr28/TX9oEm
	 JuUUUPp5UmS1nZRumHiKvhkc1mc1ZG79K1GXlUZuMHkHf8vPSsFBsD6x7cYS/dKufA
	 yW0GCpjqNchN3Ic5ugNil8MH7eqK9SlFGLUQ5j93OYDgJR9zP792rxr5qJhykn9IL2
	 85nsGxzY79A/A==
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d3db3b68a7so10960245ab.0;
        Thu, 20 Mar 2025 09:45:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyFLu3Fsax76BqOrwcFlsbo3Euify75d0nHuJHCe8QJPRIPOFCp781sMTM7xczlPCBhYqjFULkfUwL0bcX@vger.kernel.org, AJvYcCWJ7PW88afbH4zdsoNpsJ9t5zn9gCtzcsT/UtfMN3F7usBemvEBfMBTg088SZqlDb+YBtM=@vger.kernel.org, AJvYcCXEuKJtvOlJiw7ltrkJzvWPRAeEOnSaUcRK1bsj64tFg/iLIEaMK6dJbJTUQBIpnn5S6hdWZc+1G+RmgcBCgmBFf3RB@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8BWU/R1srET1HWrWCcSUhEc8PEo+UVpM5GLr9bSOgVlF2NN3
	By9vUPeSC9iZEDO2Av8bxhUC7LK2EgZ8bbqFoO/V+FwN6mOf3sDRXbO0uYoK2plyPGP+24DdZqO
	jUMR9B0IbIfdmvVuHtS4WksMEgCU=
X-Google-Smtp-Source: AGHT+IHbw5Q8tz48eCSuApTbb36iOXnOyyNyFuQkeEw0WIffr0bdaSDuoStOjaZnL721aj2EXpDhICW9Nsw55qGLDSo=
X-Received: by 2002:a05:6e02:12cd:b0:3d4:6f37:3748 with SMTP id
 e9e14a558f8ab-3d59617722bmr863675ab.16.1742489128376; Thu, 20 Mar 2025
 09:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320032258.116156-1-yangfeng59949@163.com>
In-Reply-To: <20250320032258.116156-1-yangfeng59949@163.com>
From: Song Liu <song@kernel.org>
Date: Thu, 20 Mar 2025 09:45:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4iVUdwhgDsnwy0oeiPhdfMSrRfEcXSFHw7bqXtBVzPyQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr7GhwsS_gIT73WOYJdPv9bvQ8qKip01B1xk64Yv2z7FjJ9Gg8Gdm5HI3I
Message-ID: <CAPhsuW4iVUdwhgDsnwy0oeiPhdfMSrRfEcXSFHw7bqXtBVzPyQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove duplicate judgments
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:23=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> Most of the judgments also exist in bpf_base_func_deto, remove them.

"Most" of them also exist is not enough. Please make sure that this does
not introduce any behavior change. For example, we should not remove
return of bpf_perf_event_read_value_proto.

For future patches, please read Documentation/bpf/bpf_devel_QA.rst
and follow rules for email subject, etc. For example, this patch should
have a subject like "[PATCH bpf-next] xxx".

Thanks,
Song


>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  kernel/trace/bpf_trace.c | 72 ----------------------------------------
>  1 file changed, 72 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6b07fa7081d9..c89b25344422 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1443,56 +1443,14 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, =
const struct bpf_prog *prog)
>         const struct bpf_func_proto *func_proto;
>
>         switch (func_id) {
> -       case BPF_FUNC_map_lookup_elem:
> -               return &bpf_map_lookup_elem_proto;
> -       case BPF_FUNC_map_update_elem:
> -               return &bpf_map_update_elem_proto;
> -       case BPF_FUNC_map_delete_elem:
> -               return &bpf_map_delete_elem_proto;
> -       case BPF_FUNC_map_push_elem:
> -               return &bpf_map_push_elem_proto;
> -       case BPF_FUNC_map_pop_elem:
> -               return &bpf_map_pop_elem_proto;
> -       case BPF_FUNC_map_peek_elem:
> -               return &bpf_map_peek_elem_proto;
> -       case BPF_FUNC_map_lookup_percpu_elem:
> -               return &bpf_map_lookup_percpu_elem_proto;
> -       case BPF_FUNC_ktime_get_ns:
> -               return &bpf_ktime_get_ns_proto;
> -       case BPF_FUNC_ktime_get_boot_ns:
> -               return &bpf_ktime_get_boot_ns_proto;
> -       case BPF_FUNC_tail_call:
> -               return &bpf_tail_call_proto;
> -       case BPF_FUNC_get_current_task:
> -               return &bpf_get_current_task_proto;
> -       case BPF_FUNC_get_current_task_btf:
> -               return &bpf_get_current_task_btf_proto;
> -       case BPF_FUNC_task_pt_regs:
> -               return &bpf_task_pt_regs_proto;
>         case BPF_FUNC_get_current_uid_gid:
>                 return &bpf_get_current_uid_gid_proto;
>         case BPF_FUNC_get_current_comm:
>                 return &bpf_get_current_comm_proto;
> -       case BPF_FUNC_trace_printk:
> -               return bpf_get_trace_printk_proto();
>         case BPF_FUNC_get_smp_processor_id:
>                 return &bpf_get_smp_processor_id_proto;
> -       case BPF_FUNC_get_numa_node_id:
> -               return &bpf_get_numa_node_id_proto;
>         case BPF_FUNC_perf_event_read:
>                 return &bpf_perf_event_read_proto;
> -       case BPF_FUNC_get_prandom_u32:
> -               return &bpf_get_prandom_u32_proto;
> -       case BPF_FUNC_probe_read_user:
> -               return &bpf_probe_read_user_proto;
> -       case BPF_FUNC_probe_read_kernel:
> -               return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0=
 ?
> -                      NULL : &bpf_probe_read_kernel_proto;
> -       case BPF_FUNC_probe_read_user_str:
> -               return &bpf_probe_read_user_str_proto;
> -       case BPF_FUNC_probe_read_kernel_str:
> -               return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0=
 ?
> -                      NULL : &bpf_probe_read_kernel_str_proto;
>  #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         case BPF_FUNC_probe_read:
>                 return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0=
 ?
> @@ -1502,10 +1460,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
>                        NULL : &bpf_probe_read_compat_str_proto;
>  #endif
>  #ifdef CONFIG_CGROUPS
> -       case BPF_FUNC_cgrp_storage_get:
> -               return &bpf_cgrp_storage_get_proto;
> -       case BPF_FUNC_cgrp_storage_delete:
> -               return &bpf_cgrp_storage_delete_proto;
>         case BPF_FUNC_current_task_under_cgroup:
>                 return &bpf_current_task_under_cgroup_proto;
>  #endif
> @@ -1513,20 +1467,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
>                 return &bpf_send_signal_proto;
>         case BPF_FUNC_send_signal_thread:
>                 return &bpf_send_signal_thread_proto;
> -       case BPF_FUNC_perf_event_read_value:
> -               return &bpf_perf_event_read_value_proto;
> -       case BPF_FUNC_ringbuf_output:
> -               return &bpf_ringbuf_output_proto;
> -       case BPF_FUNC_ringbuf_reserve:
> -               return &bpf_ringbuf_reserve_proto;
> -       case BPF_FUNC_ringbuf_submit:
> -               return &bpf_ringbuf_submit_proto;
> -       case BPF_FUNC_ringbuf_discard:
> -               return &bpf_ringbuf_discard_proto;
> -       case BPF_FUNC_ringbuf_query:
> -               return &bpf_ringbuf_query_proto;
> -       case BPF_FUNC_jiffies64:
> -               return &bpf_jiffies64_proto;
>         case BPF_FUNC_get_task_stack:
>                 return prog->sleepable ? &bpf_get_task_stack_sleepable_pr=
oto
>                                        : &bpf_get_task_stack_proto;
> @@ -1534,12 +1474,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
>                 return &bpf_copy_from_user_proto;
>         case BPF_FUNC_copy_from_user_task:
>                 return &bpf_copy_from_user_task_proto;
> -       case BPF_FUNC_snprintf_btf:
> -               return &bpf_snprintf_btf_proto;
> -       case BPF_FUNC_per_cpu_ptr:
> -               return &bpf_per_cpu_ptr_proto;
> -       case BPF_FUNC_this_cpu_ptr:
> -               return &bpf_this_cpu_ptr_proto;
>         case BPF_FUNC_task_storage_get:
>                 if (bpf_prog_check_recur(prog))
>                         return &bpf_task_storage_get_recur_proto;
> @@ -1548,18 +1482,12 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, =
const struct bpf_prog *prog)
>                 if (bpf_prog_check_recur(prog))
>                         return &bpf_task_storage_delete_recur_proto;
>                 return &bpf_task_storage_delete_proto;
> -       case BPF_FUNC_for_each_map_elem:
> -               return &bpf_for_each_map_elem_proto;
> -       case BPF_FUNC_snprintf:
> -               return &bpf_snprintf_proto;
>         case BPF_FUNC_get_func_ip:
>                 return &bpf_get_func_ip_proto_tracing;
>         case BPF_FUNC_get_branch_snapshot:
>                 return &bpf_get_branch_snapshot_proto;
>         case BPF_FUNC_find_vma:
>                 return &bpf_find_vma_proto;
> -       case BPF_FUNC_trace_vprintk:
> -               return bpf_get_trace_vprintk_proto();
>         default:
>                 break;
>         }
> --
> 2.43.0
>

