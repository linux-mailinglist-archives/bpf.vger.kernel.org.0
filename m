Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05F42D46D6
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 17:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgLIQgB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 11:36:01 -0500
Received: from www62.your-server.de ([213.133.104.62]:46626 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgLIQgB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 11:36:01 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kn2Qw-000AWm-AE; Wed, 09 Dec 2020 17:35:18 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kn2Qw-0001Eu-42; Wed, 09 Dec 2020 17:35:18 +0100
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, kpsingh@chromium.org,
        kafai@fb.com, linux-kernel@vger.kernel.org
References: <20201209132636.1545761-1-revest@chromium.org>
 <20201209132636.1545761-2-revest@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c3f1619d-41c1-89d3-a2a2-c2de0041fa51@iogearbox.net>
Date:   Wed, 9 Dec 2020 17:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201209132636.1545761-2-revest@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26013/Wed Dec  9 15:33:37 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/9/20 2:26 PM, Florent Revest wrote:
> This needs two new helpers, one that works in a sleepable context (using
> sock_gen_cookie which disables/enables preemption) and one that does not
> (for performance reasons). Both take a struct sock pointer and need to
> check it for NULLness.
> 
> This helper could also be useful to other BPF program types such as LSM.

Looks like this commit description is now stale and needs to be updated
since we only really add one helper?

> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>   include/linux/bpf.h            |  1 +
>   include/uapi/linux/bpf.h       |  7 +++++++
>   kernel/trace/bpf_trace.c       |  2 ++
>   net/core/filter.c              | 12 ++++++++++++
>   tools/include/uapi/linux/bpf.h |  7 +++++++
>   5 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 07cb5d15e743..5a858e8c3f1a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1860,6 +1860,7 @@ extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
>   extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
>   extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
>   extern const struct bpf_func_proto bpf_sock_from_file_proto;
> +extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
>   
>   const struct bpf_func_proto *bpf_tracing_func_proto(
>   	enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ba59309f4d18..9ac66cf25959 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1667,6 +1667,13 @@ union bpf_attr {
>    * 	Return
>    * 		A 8-byte long unique number.
>    *
> + * u64 bpf_get_socket_cookie(void *sk)
> + * 	Description
> + * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
> + * 		*sk*, but gets socket from a BTF **struct sock**.

Maybe add a small comment that this one also works for sleepable [tracing] progs?

> + * 	Return
> + * 		A 8-byte long unique number.

... or 0 if *sk* is NULL.

>    * u32 bpf_get_socket_uid(struct sk_buff *skb)
>    * 	Return
>    * 		The owner UID of the socket associated to *skb*. If the socket
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 52ddd217d6a1..be5e96de306d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1760,6 +1760,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_sk_storage_delete_tracing_proto;
>   	case BPF_FUNC_sock_from_file:
>   		return &bpf_sock_from_file_proto;
> +	case BPF_FUNC_get_socket_cookie:
> +		return &bpf_get_socket_ptr_cookie_proto;
>   #endif
>   	case BPF_FUNC_seq_printf:
>   		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 255aeee72402..13ad9a64f04f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4631,6 +4631,18 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
>   	.arg1_type	= ARG_PTR_TO_CTX,
>   };
>   
> +BPF_CALL_1(bpf_get_socket_ptr_cookie, struct sock *, sk)
> +{
> +	return sk ? sock_gen_cookie(sk) : 0;
> +}
> +
> +const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto = {
> +	.func		= bpf_get_socket_ptr_cookie,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> +};
> +
>   BPF_CALL_1(bpf_get_socket_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
>   {
>   	return __sock_gen_cookie(ctx->sk);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index ba59309f4d18..9ac66cf25959 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1667,6 +1667,13 @@ union bpf_attr {
>    * 	Return
>    * 		A 8-byte long unique number.
>    *
> + * u64 bpf_get_socket_cookie(void *sk)
> + * 	Description
> + * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
> + * 		*sk*, but gets socket from a BTF **struct sock**.
> + * 	Return
> + * 		A 8-byte long unique number.
> + *
>    * u32 bpf_get_socket_uid(struct sk_buff *skb)
>    * 	Return
>    * 		The owner UID of the socket associated to *skb*. If the socket
> 

