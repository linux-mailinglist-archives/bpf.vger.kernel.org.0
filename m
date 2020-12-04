Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DA82CF474
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 19:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgLDS5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 13:57:11 -0500
Received: from www62.your-server.de ([213.133.104.62]:55538 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDS5L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 13:57:11 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1klGFo-00006u-Vn; Fri, 04 Dec 2020 19:56:29 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1klGFo-00074p-Pt; Fri, 04 Dec 2020 19:56:28 +0100
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, kpsingh@chromium.org,
        revest@google.com, linux-kernel@vger.kernel.org
References: <20201203213330.1657666-1-revest@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bdd7153b-4bf9-12dd-5950-df0ebe91659d@iogearbox.net>
Date:   Fri, 4 Dec 2020 19:56:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201203213330.1657666-1-revest@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26007/Thu Dec  3 14:13:31 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/3/20 10:33 PM, Florent Revest wrote:
> This creates a new helper proto because the existing
> bpf_get_socket_cookie_sock_proto has a ARG_PTR_TO_CTX argument and only
> works for BPF programs where the context is a sock.
> 
> This helper could also be useful to other BPF program types such as LSM.
> 
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>   include/uapi/linux/bpf.h       | 7 +++++++
>   kernel/trace/bpf_trace.c       | 4 ++++
>   net/core/filter.c              | 7 +++++++
>   tools/include/uapi/linux/bpf.h | 7 +++++++
>   4 files changed, 25 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c3458ec1f30a..3e0e33c43998 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1662,6 +1662,13 @@ union bpf_attr {
>    * 	Return
>    * 		A 8-byte long non-decreasing number.
>    *
> + * u64 bpf_get_socket_cookie(void *sk)
> + * 	Description
> + * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
> + * 		*sk*, but gets socket from a BTF **struct sock**.
> + * 	Return
> + * 		A 8-byte long non-decreasing number.

I would not mention this here since it's not fully correct and we should avoid users
taking non-decreasing granted in their progs. The only assumption you can make is
that it can be considered a unique number. See also [0] with reverse counter..

   [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92acdc58ab11af66fcaef485433fde61b5e32fac

> + *
>    * u32 bpf_get_socket_uid(struct sk_buff *skb)
>    * 	Return
>    * 		The owner UID of the socket associated to *skb*. If the socket
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d255bc9b2bfa..14ad96579813 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1725,6 +1725,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   	}
>   }
>   
> +extern const struct bpf_func_proto bpf_get_socket_cookie_sock_tracing_proto;
> +
>   const struct bpf_func_proto *
>   tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   {
> @@ -1748,6 +1750,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_sk_storage_get_tracing_proto;
>   	case BPF_FUNC_sk_storage_delete:
>   		return &bpf_sk_storage_delete_tracing_proto;
> +	case BPF_FUNC_get_socket_cookie:
> +		return &bpf_get_socket_cookie_sock_tracing_proto;
>   #endif
>   	case BPF_FUNC_seq_printf:
>   		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ca5eecebacf..177c4e5e529d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4631,6 +4631,13 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
>   	.arg1_type	= ARG_PTR_TO_CTX,
>   };
>   
> +const struct bpf_func_proto bpf_get_socket_cookie_sock_tracing_proto = {
> +	.func		= bpf_get_socket_cookie_sock,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> +};
> +
