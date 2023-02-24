Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E266A2452
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 23:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBXWf7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 17:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXWf5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 17:35:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C916F43A
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 14:35:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5376fa4106eso12930577b3.7
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 14:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TiSV/tgwE0PA8BQtP7j/b4Uhn63BkBS6kRbHujS0Sd4=;
        b=BFvrfGu5Kw6wpkq7YqWGevX2GP7GHaFXwCYnIdx9aLLfFAYQ72HfgWWn+XSk8/Fo5A
         AkwBDNHbhc/UvP99yZ28zjJjf9iRbHnOwYtC6+FylLYwudDrbzi7jtQIHeJOXTkgAf0h
         +39CXweAtCf9VE5g/TmP9ppRwY31J7auB0MdeNi8KAzYF7jGsFz4McgIaTibFE2LaHUQ
         MSk994H2aNPGfiYopK6K2XXB7sIYUofy4hakCoMnQTrOln83JEeF6ZnvZ14Ad6iaxune
         gRFwDgVeSQMxSxxpngk0QqJNHZ4B9o0JcAw288WKnKNbLgf9SsSqGxfHptk1JvCWfY8B
         Ma8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiSV/tgwE0PA8BQtP7j/b4Uhn63BkBS6kRbHujS0Sd4=;
        b=WU3sw5LgLoYdoG3hILBsIKlFg1kFmaNkkZwsftm0RFiyBfvirpVvD7L7Ji4+FIgtGl
         HrdXl1t6re9N5CFmklnwMLkJLB+kDX12IhadT77fICZZLrOJdoDjBZlp+gRcRRbDWLj2
         w2dRSlsWwRGFQTOyMpCnE9yFHWKuw763VNjAj1FLapg5MTHj3DFmmKwDvxwjWyYFIcBm
         lE3QMQo7aC9AV8wiEB/2ZPvICJwW8CQ+G5E0r8OOceWflo3Brkmb9BXEvE6xkt0eqLc8
         21uMmnPiGC4Aj/sTq/uqP/WKGjJBaFPaJbCE08kMrh58NQseP4wqtS6XOzuftz3TMPsv
         +l7g==
X-Gm-Message-State: AO0yUKXEshdxzx2xAeHozzzI/jigtje7P0wQBDslMwf6+7Lvf4v0H5gm
        9Lwh9xdKTQckyG5BG0xXuBo/d7c=
X-Google-Smtp-Source: AK7set9NRSXsNBLpkitGV2GUeM/x79Jy3m6RkyUtNIs7rLeSeICL/QffMu2z/jXVSbRDdUPLW4CIKrI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:9392:0:b0:997:bdfe:78c5 with SMTP id
 a18-20020a259392000000b00997bdfe78c5mr4935559ybm.6.1677278155010; Fri, 24 Feb
 2023 14:35:55 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:35:53 -0800
In-Reply-To: <20230223215311.926899-3-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230223215311.926899-1-aditi.ghag@isovalent.com> <20230223215311.926899-3-aditi.ghag@isovalent.com>
Message-ID: <Y/k7yYCsHJqaqOjU@google.com>
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Add bpf_sock_destroy kfunc
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/23, Aditi Ghag wrote:
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
>   net/core/filter.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>   net/ipv4/tcp.c    | 17 ++++++++++-----
>   net/ipv4/udp.c    |  7 ++++--
>   3 files changed, 72 insertions(+), 7 deletions(-)

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1d6f165923bf..79cd91ba13d0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11621,3 +11621,58 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)

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
> + * The helper expects a non-NULL pointer to a full socket. It invokes
> + * the protocol specific socket destroy handlers.
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
> +int bpf_sock_destroy(struct sock_common *sock)

Prefix with __bpf_kfunc (see other kfuncs).

> +{
> +	/* Validates the socket can be type casted to a full socket. */
> +	struct sock *sk = sk_to_full_sk((struct sock *)sock);
> +
> +	if (!sk)
> +		return -EINVAL;
> +
> +	/* The locking semantics that allow for synchronous execution of the
> +	 * destroy handlers are only supported for TCP and UDP.
> +	 */
> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol == IPPROTO_RAW)
> +		return -EOPNOTSUPP;
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

Is it safe? Does it mean I can call bpf_sock_destroy from any tracing
program from anywhere? What if the socket is not locked?
IOW, do we have to constrain it to the iterator programs (at least for
now)?

> +}
> +late_initcall(init_subsystem);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 33f559f491c8..8123c264d8ea 100644
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
> @@ -4688,7 +4690,9 @@ int tcp_abort(struct sock *sk, int err)

>   	/* Don't race with BH socket closes such as inet_csk_listen_stop. */
>   	local_bh_disable();
> -	bh_lock_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		bh_lock_sock(sk);
> +

>   	if (!sock_flag(sk, SOCK_DEAD)) {
>   		sk->sk_err = err;
> @@ -4700,10 +4704,13 @@ int tcp_abort(struct sock *sk, int err)
>   		tcp_done(sk);
>   	}

> -	bh_unlock_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		bh_unlock_sock(sk);
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
> index 2f3978de45f2..1bc9ad92c3d4 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2925,7 +2925,9 @@ EXPORT_SYMBOL(udp_poll);

>   int udp_abort(struct sock *sk, int err)
>   {
> -	lock_sock(sk);
> +	/* BPF context ensures sock locking. */
> +	if (!has_current_bpf_ctx())
> +		lock_sock(sk);

>   	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
>   	 * with close()
> @@ -2938,7 +2940,8 @@ int udp_abort(struct sock *sk, int err)
>   	__udp_disconnect(sk, 0);

>   out:
> -	release_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		release_sock(sk);

>   	return 0;
>   }
> --
> 2.34.1

