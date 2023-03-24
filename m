Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8311B6C8785
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 22:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCXVhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCXVhG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 17:37:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C3A1ACF4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 14:37:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y144-20020a253296000000b00b69ce0e6f2dso2980592yby.18
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679693824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JcoBZU0mz4nudmvGpn5wHjoC4D9Gjq7C7wiIlqE/Dz8=;
        b=WwxFBjvglqs48cpPO/GmAhUXNLCx21u1YVzYWHj1eej9YS+G7mcHRYzDvH+9nvVIIt
         gHLBTvtc51gK+A+shVOA0fsdsnezaePvIQ4MUEEjU3mF45/M0sLuaJ72ID7SFnidJanM
         Uav31Cnhy5WpqvlWa7ancN1FKmDxUv18EGwgLMunqH47XXvEXUN7XSm/VwNUWWWybdGW
         m0lK9OyofoDczgec4BG/zOB5C8rkEpFm+Zc8645xXH0hL7wqM/Prk7i+r/5ZimHeXbmb
         fMej9EG4Hi1HIa7iTJUcITGwNPzmIfptGFn1Sk+bqTFuFZZ6xM1nObGs47R43G0I3Vrp
         o5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcoBZU0mz4nudmvGpn5wHjoC4D9Gjq7C7wiIlqE/Dz8=;
        b=WbeFXZ/uZBW0uQccpEkYMo1PjM5H9eOAeea18oTBx5CK+IIzJN6issi5bAUPz6Oy5i
         ErylXQLRAROJNX3FA9Vo216LC5r/tlIZgLsgLD50cByJ2vi+PexX7bv5SAnMzxgME7p7
         fhwUdfOyNkRumuwla8nv/44D0lTbHMswuRN9p3p++pev/lnUkww/7lF7NOMJ6BYphFr+
         51U2+e5d2lhd3kfn8rFJ2LOpvmjMhg0OxXuyTx2k+Ygaq+jjW6qIoj8ofvz7zKXiMYxl
         w7DworslRX2huG7tQJrWo9ywJFx4GetMn76U0ia684gxArHTYqe0Os1LgwhDMJUC4xSZ
         FWzg==
X-Gm-Message-State: AAQBX9c7ofM3OrdwYxZ296S1TY58lKcIv5QQuv2hQZr3r6E+7rWy97W/
        faVELZ3dpzOcXuA6ogDIPrNeU2w=
X-Google-Smtp-Source: AKy350Zb0xFN8UVkgQUDJsNh5qa9yWNnKRDwoCnIuIWm7NHXx3nnPnsg68KzdRfoCDjZrnuplJQ9KNE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:d30b:0:b0:545:64d7:5086 with SMTP id
 y11-20020a81d30b000000b0054564d75086mr1823102ywi.1.1679693824237; Fri, 24 Mar
 2023 14:37:04 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:37:02 -0700
In-Reply-To: <20230323200633.3175753-3-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com> <20230323200633.3175753-3-aditi.ghag@isovalent.com>
Message-ID: <ZB4X/uOEdq79Lbof@google.com>
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: Add bpf_sock_destroy kfunc
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/23, Aditi Ghag wrote:
> The socket destroy kfunc is used to forcefully terminate sockets from
> certain BPF contexts. We plan to use the capability in Cilium to force
> client sockets to reconnect when their remote load-balancing backends are
> deleted. The other use case is on-the-fly policy enforcement where  
> existing
> socket connections prevented by policies need to be forcefully terminated.
> The helper allows terminating sockets that may or may not be actively
> sending traffic.

> The helper is currently exposed to certain BPF iterators where users can
> filter, and terminate selected sockets.  Additionally, the helper can only
> be called from these BPF contexts that ensure socket locking in order to
> allow synchronous execution of destroy helpers that also acquire socket
> locks. The previous commit that batches UDP sockets during iteration
> facilitated a synchronous invocation of the destroy helper from BPF  
> context
> by skipping taking socket locks in the destroy handler. TCP iterators
> already supported batching.

> The helper takes `sock_common` type argument, even though it expects, and
> casts them to a `sock` pointer. This enables the verifier to allow the
> sock_destroy kfunc to be called for TCP with `sock_common` and UDP with
> `sock` structs. As a comparison, BPF helpers enable this behavior with the
> `ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no such
> option available with the verifier logic that handles kfuncs where BTF
> types are inferred. Furthermore, as `sock_common` only has a subset of
> certain fields of `sock`, casting pointer to the latter type might not
> always be safe. Hence, the BPF kfunc converts the argument to a full sock
> before casting.

> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   net/core/filter.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>   net/ipv4/tcp.c    | 10 ++++++---
>   net/ipv4/udp.c    |  6 ++++--
>   3 files changed, 65 insertions(+), 5 deletions(-)

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1d6f165923bf..ba3e0dac119c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11621,3 +11621,57 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)

>   	return func;
>   }
> +
> +/* Disables missing prototype warnings */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in vmlinux BTF");
> +
> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error  
> code.
> + *
> + * The helper expects a non-NULL pointer to a socket. It invokes the
> + * protocol specific socket destroy handlers.
> + *
> + * The helper can only be called from BPF contexts that have acquired  
> the socket
> + * locks.
> + *
> + * Parameters:
> + * @sock: Pointer to socket to be destroyed
> + *
> + * Return:
> + * On error, may return EPROTONOSUPPORT, EINVAL.
> + * EPROTONOSUPPORT if protocol specific destroy handler is not  
> implemented.
> + * 0 otherwise
> + */
> +__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> +{
> +	struct sock *sk = (struct sock *)sock;
> +
> +	if (!sk)
> +		return -EINVAL;
> +
> +	/* The locking semantics that allow for synchronous execution of the
> +	 * destroy handlers are only supported for TCP and UDP.
> +	 */
> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol == IPPROTO_RAW)
> +		return -EOPNOTSUPP;

Copy-pasting from v3, let's discuss here.

Maybe make it more opt-in? (vs current "opt ipproto_raw out")

if (sk->sk_prot->diag_destroy != udp_abort &&
     sk->sk_prot->diag_destroy != tcp_abort)
             return -EOPNOTSUPP;

Is it more robust? Or does it look uglier? )
But maybe fine as is, I'm just thinking out loud..

> +
> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> +}
> +
> +__diag_pop()
> +
> +BTF_SET8_START(sock_destroy_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_sock_destroy)
> +BTF_SET8_END(sock_destroy_kfunc_set)
> +
> +static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &sock_destroy_kfunc_set,
> +};
> +
> +static int init_subsystem(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,  
> &bpf_sock_destroy_kfunc_set);
> +}
> +late_initcall(init_subsystem);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 33f559f491c8..5df6231016e3 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
>   		return 0;
>   	}

> -	/* Don't race with userspace socket closes such as tcp_close. */
> -	lock_sock(sk);
> +	/* BPF context ensures sock locking. */
> +	if (!has_current_bpf_ctx())
> +		/* Don't race with userspace socket closes such as tcp_close. */
> +		lock_sock(sk);

>   	if (sk->sk_state == TCP_LISTEN) {
>   		tcp_set_state(sk, TCP_CLOSE);
> @@ -4701,9 +4703,11 @@ int tcp_abort(struct sock *sk, int err)
>   	}

>   	bh_unlock_sock(sk);
> +
>   	local_bh_enable();
>   	tcp_write_queue_purge(sk);
> -	release_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		release_sock(sk);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tcp_abort);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 58c620243e47..408836102e20 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2925,7 +2925,8 @@ EXPORT_SYMBOL(udp_poll);

>   int udp_abort(struct sock *sk, int err)
>   {
> -	lock_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		lock_sock(sk);

>   	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
>   	 * with close()
> @@ -2938,7 +2939,8 @@ int udp_abort(struct sock *sk, int err)
>   	__udp_disconnect(sk, 0);

>   out:
> -	release_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		release_sock(sk);

>   	return 0;
>   }
> --
> 2.34.1

