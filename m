Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F116A461F
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjB0Pc1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjB0Pc1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:32:27 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3FDBFC
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:32:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso6495255pjb.4
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUnY6Vo9nhqAOtvU1m53e3jXoFufYPKOV4jAaAR5wSU=;
        b=MJ4it3mdNsYJhUR+QFa7FEI2TOo6MZkMhbvc/IYgfIeaklHfSavy6A4ABtj1c4g/5q
         p7ndtOAEH+3/cdOyeGUHkSg6HO49TDvNYQOyxVm+OSOd+XqkRRKMg+L7okP68gVK6UjG
         WU1ND2+2D0ZXdVVVwh+NomE7VVICwxUs1t97scaN01wEv4qAYo4Qe3JUMI95MkE+sFs6
         0E/MdYOBUQlDJb3lSyX9v6fzOh8OXc/en5ugVm/E8hxcVrWkU5hqXXBcRPtzg+YdKIT4
         83F3nF+PbpglsATXZ9s+G+esG7MLgxKnXbTueV9DJo4NK4O5WdZkTtXrtTFIlaLQWK1a
         H/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUnY6Vo9nhqAOtvU1m53e3jXoFufYPKOV4jAaAR5wSU=;
        b=b64easLjZB3WnVPyAqh0YwoksJaogWtrU2N+VRdovs/7nlkmfL0gL4URDNDMnhMKEi
         OfgHvACWMSRWRuuH5CtzoXnjgI0DTMRs3ozsMzLrVoxhzye4GDS6ck7Xy8spdEdriXBh
         JS8RkcLjoCgdTKj9fI6mvLU+ulM0dZ9bsGcOExzgOaRkaofdKqtSF/y2st8cqp00HTSG
         B9OjmqciMQc1mdj3VzemHRfl+qXVG8MvZryerXsdfWUvlH+re2WFEi6ruIr3XWzyesUY
         3lJ/3HTmVhmC3oICl7osTZ8klOiv06Qwynft5Fdp+YMSmBKlfCP57RJyL2LtG31ZOaDU
         dWJg==
X-Gm-Message-State: AO0yUKWYe5xxaCSGkXjcgDD3s6CZc5jXvrL/havOFygRbkdiUIE90HpB
        +VBhXVuQZM1lAG8G8ZY88lSm4y/GYlRzGDa/
X-Google-Smtp-Source: AK7set+ZDJ+VcEFqZVcvJtFq2zECWj9oZbtg0n/7KccZFVAmXA6i1e0jYvXOtvOuf6FKeN6g4bsg1A==
X-Received: by 2002:a05:6a21:99a7:b0:bf:1662:b2f4 with SMTP id ve39-20020a056a2199a700b000bf1662b2f4mr22637416pzb.49.1677511944798;
        Mon, 27 Feb 2023 07:32:24 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:d4f9:ae90:bdaf:7478? ([2601:647:4900:b6:d4f9:ae90:bdaf:7478])
        by smtp.gmail.com with ESMTPSA id m21-20020aa78a15000000b005a8dcd32851sm4563964pfa.11.2023.02.27.07.32.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2023 07:32:24 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Add bpf_sock_destroy kfunc
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <139B8C1E-A1B9-4DB4-BA0E-60EA4AAE6503@isovalent.com>
Date:   Mon, 27 Feb 2023 07:32:23 -0800
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E68DC93-5846-413B-A164-83A70C266F67@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-3-aditi.ghag@isovalent.com>
 <Y/k7yYCsHJqaqOjU@google.com>
 <139B8C1E-A1B9-4DB4-BA0E-60EA4AAE6503@isovalent.com>
To:     Stanislav Fomichev <sdf@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 27, 2023, at 6:56 AM, Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>=20
>=20
>=20
>> On Feb 24, 2023, at 2:35 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>>=20
>> On 02/23, Aditi Ghag wrote:
>>> The socket destroy kfunc is used to forcefully terminate sockets =
from
>>> certain BPF contexts. We plan to use the capability in Cilium to =
force
>>> client sockets to reconnect when their remote load-balancing =
backends are
>>> deleted. The other use case is on-the-fly policy enforcement where =
existing
>>> socket connections prevented by policies need to be forcefully =
terminated.
>>> The helper allows terminating sockets that may or may not be =
actively
>>> sending traffic.
>>=20
>>> The helper is currently exposed to certain BPF iterators where users =
can
>>> filter, and terminate selected sockets.  Additionally, the helper =
can only
>>> be called from these BPF contexts that ensure socket locking in =
order to
>>> allow synchronous execution of destroy helpers that also acquire =
socket
>>> locks. The previous commit that batches UDP sockets during iteration
>>> facilitated a synchronous invocation of the destroy helper from BPF =
context
>>> by skipping taking socket locks in the destroy handler. TCP =
iterators
>>> already supported batching.
>>=20
>>> The helper takes `sock_common` type argument, even though it =
expects, and
>>> casts them to a `sock` pointer. This enables the verifier to allow =
the
>>> sock_destroy kfunc to be called for TCP with `sock_common` and UDP =
with
>>> `sock` structs. As a comparison, BPF helpers enable this behavior =
with the
>>> `ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no =
such
>>> option available with the verifier logic that handles kfuncs where =
BTF
>>> types are inferred. Furthermore, as `sock_common` only has a subset =
of
>>> certain fields of `sock`, casting pointer to the latter type might =
not
>>> always be safe. Hence, the BPF kfunc converts the argument to a full =
sock
>>> before casting.
>>=20
>>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>>> ---
>>> net/core/filter.c | 55 =
+++++++++++++++++++++++++++++++++++++++++++++++
>>> net/ipv4/tcp.c    | 17 ++++++++++-----
>>> net/ipv4/udp.c    |  7 ++++--
>>> 3 files changed, 72 insertions(+), 7 deletions(-)
>>=20
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 1d6f165923bf..79cd91ba13d0 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -11621,3 +11621,58 @@ bpf_sk_base_func_proto(enum bpf_func_id =
func_id)
>>=20
>>> 	return func;
>>> }
>>> +
>>> +/* Disables missing prototype warnings */
>>> +__diag_push();
>>> +__diag_ignore_all("-Wmissing-prototypes",
>>> +		  "Global functions as their definitions will be in =
vmlinux BTF");
>>> +
>>> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED =
error code.
>>> + *
>>> + * The helper expects a non-NULL pointer to a full socket. It =
invokes
>>> + * the protocol specific socket destroy handlers.
>>> + *
>>> + * The helper can only be called from BPF contexts that have =
acquired the socket
>>> + * locks.
>>> + *
>>> + * Parameters:
>>> + * @sock: Pointer to socket to be destroyed
>>> + *
>>> + * Return:
>>> + * On error, may return EPROTONOSUPPORT, EINVAL.
>>> + * EPROTONOSUPPORT if protocol specific destroy handler is not =
implemented.
>>> + * 0 otherwise
>>> + */
>>> +int bpf_sock_destroy(struct sock_common *sock)
>>=20
>> Prefix with __bpf_kfunc (see other kfuncs).
>=20
> Will do!
>=20
>>=20
>>> +{
>>> +	/* Validates the socket can be type casted to a full socket. */
>>> +	struct sock *sk =3D sk_to_full_sk((struct sock *)sock);
>>> +
>>> +	if (!sk)
>>> +		return -EINVAL;
>>> +
>>> +	/* The locking semantics that allow for synchronous execution of =
the
>>> +	 * destroy handlers are only supported for TCP and UDP.
>>> +	 */
>>> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol =3D=3D =
IPPROTO_RAW)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
>>> +}
>>> +
>>> +__diag_pop()
>>> +
>>> +BTF_SET8_START(sock_destroy_kfunc_set)
>>> +BTF_ID_FLAGS(func, bpf_sock_destroy)
>>> +BTF_SET8_END(sock_destroy_kfunc_set)
>>> +
>>> +static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set =3D =
{
>>> +	.owner =3D THIS_MODULE,
>>> +	.set   =3D &sock_destroy_kfunc_set,
>>> +};
>>> +
>>> +static int init_subsystem(void)
>>> +{
>>> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, =
&bpf_sock_destroy_kfunc_set);
>>=20
>> Is it safe? Does it mean I can call bpf_sock_destroy from any tracing
>> program from anywhere? What if the socket is not locked?
>> IOW, do we have to constrain it to the iterator programs (at least =
for
>> now)?
>=20
> Given kprobes are not considered as part of BPF_PROG_TYPE_TRACING, I'm =
not sure if there are other tracing programs with sock/sock_common =
arguments. Regardless, this is a valid point. I had brought up a similar =
topic earlier during the v1 discussion - =
https://lore.kernel.org/bpf/78E434B0-06A9-466F-A061-B9A05DC6DE6D@isovalent=
.com/. I suppose you would have a similar problem in the case of =
setsockopt* helpers.=20
> Is the general topic of limiting access for kfunc to a subset of =
BPF_PROG_* programs being discussed?

I've submitted this as a potential topic for the lsm/mm/bpf agenda. =
Also, related to this discussion: could we have something similar to =
lockdep_sock_is_held with less overhead?=20

>=20
>>=20
>>> +}
>>> +late_initcall(init_subsystem);
>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>> index 33f559f491c8..8123c264d8ea 100644
>>> --- a/net/ipv4/tcp.c
>>> +++ b/net/ipv4/tcp.c
>>> @@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
>>> 		return 0;
>>> 	}
>>=20
>>> -	/* Don't race with userspace socket closes such as tcp_close. */
>>> -	lock_sock(sk);
>>> +	/* BPF context ensures sock locking. */
>>> +	if (!has_current_bpf_ctx())
>>> +		/* Don't race with userspace socket closes such as =
tcp_close. */
>>> +		lock_sock(sk);
>>=20
>>> 	if (sk->sk_state =3D=3D TCP_LISTEN) {
>>> 		tcp_set_state(sk, TCP_CLOSE);
>>> @@ -4688,7 +4690,9 @@ int tcp_abort(struct sock *sk, int err)
>>=20
>>> 	/* Don't race with BH socket closes such as =
inet_csk_listen_stop. */
>>> 	local_bh_disable();
>>> -	bh_lock_sock(sk);
>>> +	if (!has_current_bpf_ctx())
>>> +		bh_lock_sock(sk);
>>> +
>>=20
>>> 	if (!sock_flag(sk, SOCK_DEAD)) {
>>> 		sk->sk_err =3D err;
>>> @@ -4700,10 +4704,13 @@ int tcp_abort(struct sock *sk, int err)
>>> 		tcp_done(sk);
>>> 	}
>>=20
>>> -	bh_unlock_sock(sk);
>>> +	if (!has_current_bpf_ctx())
>>> +		bh_unlock_sock(sk);
>>> +
>>> 	local_bh_enable();
>>> 	tcp_write_queue_purge(sk);
>>> -	release_sock(sk);
>>> +	if (!has_current_bpf_ctx())
>>> +		release_sock(sk);
>>> 	return 0;
>>> }
>>> EXPORT_SYMBOL_GPL(tcp_abort);
>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>> index 2f3978de45f2..1bc9ad92c3d4 100644
>>> --- a/net/ipv4/udp.c
>>> +++ b/net/ipv4/udp.c
>>> @@ -2925,7 +2925,9 @@ EXPORT_SYMBOL(udp_poll);
>>=20
>>> int udp_abort(struct sock *sk, int err)
>>> {
>>> -	lock_sock(sk);
>>> +	/* BPF context ensures sock locking. */
>>> +	if (!has_current_bpf_ctx())
>>> +		lock_sock(sk);
>>=20
>>> 	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid =
racing
>>> 	 * with close()
>>> @@ -2938,7 +2940,8 @@ int udp_abort(struct sock *sk, int err)
>>> 	__udp_disconnect(sk, 0);
>>=20
>>> out:
>>> -	release_sock(sk);
>>> +	if (!has_current_bpf_ctx())
>>> +		release_sock(sk);
>>=20
>>> 	return 0;
>>> }
>>> --
>>> 2.34.1

