Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521CC67197D
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 11:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjARKpf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 05:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjARKnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 05:43:16 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B8A676DE;
        Wed, 18 Jan 2023 01:49:14 -0800 (PST)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pI544-000GsH-Jt; Wed, 18 Jan 2023 10:49:04 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pI543-000TL6-U9; Wed, 18 Jan 2023 10:49:03 +0100
Subject: Re: [PATCH V2] bpf: security enhancement by limiting the offensive
 eBPF helpers
To:     Yi He <clangllvm@126.com>, yhs@meta.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
        mhiramat@kernel.org, rostedt@goodmis.org, sdf@google.com,
        song@kernel.org, yhs@fb.com
References: <f539bfef-c098-5ff0-51ef-bfa8fd0c4661@meta.com>
 <20230118005432.634229-1-clangllvm@126.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ef9b8445-b02b-3f6a-a566-587695f322b7@iogearbox.net>
Date:   Wed, 18 Jan 2023 10:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230118005432.634229-1-clangllvm@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26785/Wed Jan 18 09:42:40 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/18/23 1:54 AM, Yi He wrote:
> The bpf_send_singal, bpf_send_singal_thread and bpf_override_return
> is similar to bpf_write_user and can affect userspace processes.
> Thus, these three helpers should also be restricted by security lockdown.
> 
> Signed-off-by: Yi He <clangllvm@126.com>
> ---
>   V1 -> V2: add security lockdown to bpf_send_singal_thread and remove
> 	the unused LOCKDOWN_OFFENSIVE_BPF_MAX.
> 
>   include/linux/security.h | 2 ++
>   kernel/trace/bpf_trace.c | 9 ++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5b67f208f..42420e620 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -123,6 +123,8 @@ enum lockdown_reason {
>   	LOCKDOWN_DEBUGFS,
>   	LOCKDOWN_XMON_WR,
>   	LOCKDOWN_BPF_WRITE_USER,
> +	LOCKDOWN_BPF_SEND_SIGNAL,
> +	LOCKDOWN_BPF_OVERRIDE_RETURN,
>   	LOCKDOWN_DBG_WRITE_KERNEL,
>   	LOCKDOWN_RTAS_ERROR_INJECTION,
>   	LOCKDOWN_INTEGRITY_MAX,

I'm not applying this.. i) this means by default you effectively remove these
helpers from existing users in the wild given integrity mode is default for
secure boot, but also ii) should we lock-down and remove the ability for other
privileged entities like processes to send signals, seccomp to ret_kill, ptrace,
etc given they all "can affect userspace processes". For the other one, check
out already existing FUNCTION_ERROR_INJECTION kernel config.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c8..fdb94868d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1463,9 +1463,11 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_cgrp_storage_delete_proto;
>   #endif
>   	case BPF_FUNC_send_signal:
> -		return &bpf_send_signal_proto;
> +		return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
> +		       NULL : &bpf_send_signal_proto;
>   	case BPF_FUNC_send_signal_thread:
> -		return &bpf_send_signal_thread_proto;
> +		return security_locked_down(LOCKDOWN_BPF_SEND_SIGNAL) < 0 ?
> +		       NULL : &bpf_send_signal_thread_proto;
>   	case BPF_FUNC_perf_event_read_value:
>   		return &bpf_perf_event_read_value_proto;
>   	case BPF_FUNC_get_ns_current_pid_tgid:
> @@ -1531,7 +1533,8 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_get_stack_proto;
>   #ifdef CONFIG_BPF_KPROBE_OVERRIDE
>   	case BPF_FUNC_override_return:
> -		return &bpf_override_return_proto;
> +		return security_locked_down(LOCKDOWN_BPF_OVERRIDE_RETURN) < 0 ?
> +		       NULL : &bpf_override_return_proto;
>   #endif
>   	case BPF_FUNC_get_func_ip:
>   		return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ?
> 

