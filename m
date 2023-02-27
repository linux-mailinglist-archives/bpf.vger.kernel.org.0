Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F566A4551
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjB0O4o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 09:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0O4o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 09:56:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E522A23
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 06:56:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l1so6414306pjt.2
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 06:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCGHaWNQHMFkKEX4NDlz+b8MHS7DM/zyguCgC+2qcOo=;
        b=VwEZazauzB+hC2IlTPSTsmCQp9PHjQSxgXCwsu6uIkBOtNZfbE2CrvifhnePF0FjBS
         2jYCNgtVB7MCpa1uGJzMHPcopH2X/t9FXLBlQ5CAPHfw3d3Jn/Dace6IOPgqWaOtLnCQ
         4ystiuobZuR+t5m3CErBRgliveRo/Oht09mLDGEcuM/df2fZ8mxx7dB4N0FW1toe55yn
         JQWUAwreO5iZIvPZLqWChTsgV0gcNNZp8o7IKDQUaU+BHPAl2iaUI8Mko79eeAc+aHD4
         ijjdVgqFudUp4EjsQVSyyt8kR2FMqB333+33SzlhPJ5P7S608hyMOoRw0y9I0oAQJz+v
         JcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCGHaWNQHMFkKEX4NDlz+b8MHS7DM/zyguCgC+2qcOo=;
        b=Ac4OFQyYTJYkMGhZoxvT4jcb2vu3CzTfrB/hfacm+QB53xtnQoviG1OXmwFetotNH1
         kqaoQ1PXTra2IL9Z44SAcXZQOkLcfs9+ER7NScelRYgYlixP6Z7hFnlqM1OBDAFhqOR0
         sj6ymg9ukik/nl51GpIWiiF2W4rl+Xxxqwsxs38e8VSRDuIM42R61HaTv7SIe4Su1RHL
         wXg34tVor4mbP9j5ge+WGXc+LUCuiWHGO+/NjJBMOcyNZsX/YLZmAbaxK3FC4SfKHLP3
         bkdJDJcdWAe/B4JkngCegMA/EI1NL8XA7ZGqBCSg6QZlj8aKw9o+VQ/T3PBkuHqqO9vS
         KC+A==
X-Gm-Message-State: AO0yUKUoxWfa+ljs7LlH8ZCCmVdU9kSWNw/BD9R4ZhqvS2SFiinb6+iR
        1+yRlGunZlJZ5sRZMaCnrmtATKcdHy56VNVE
X-Google-Smtp-Source: AK7set/3+6djB8F+quC4I6rQ9gtdb+oRBfuh5XHiWkQtnScjxAdf8dVGq8J5ahaZ0qwrOIQ2hZfCPQ==
X-Received: by 2002:a05:6a20:54a6:b0:c7:2a63:8792 with SMTP id i38-20020a056a2054a600b000c72a638792mr30355555pzk.29.1677509776845;
        Mon, 27 Feb 2023 06:56:16 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:d4f9:ae90:bdaf:7478? ([2601:647:4900:b6:d4f9:ae90:bdaf:7478])
        by smtp.gmail.com with ESMTPSA id f23-20020aa782d7000000b005dea362ed18sm4390293pfn.27.2023.02.27.06.56.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2023 06:56:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Add bpf_sock_destroy kfunc
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <Y/k7yYCsHJqaqOjU@google.com>
Date:   Mon, 27 Feb 2023 06:56:14 -0800
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <139B8C1E-A1B9-4DB4-BA0E-60EA4AAE6503@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-3-aditi.ghag@isovalent.com>
 <Y/k7yYCsHJqaqOjU@google.com>
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



> On Feb 24, 2023, at 2:35 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>=20
> On 02/23, Aditi Ghag wrote:
>> The socket destroy kfunc is used to forcefully terminate sockets from
>> certain BPF contexts. We plan to use the capability in Cilium to =
force
>> client sockets to reconnect when their remote load-balancing backends =
are
>> deleted. The other use case is on-the-fly policy enforcement where =
existing
>> socket connections prevented by policies need to be forcefully =
terminated.
>> The helper allows terminating sockets that may or may not be actively
>> sending traffic.
>=20
>> The helper is currently exposed to certain BPF iterators where users =
can
>> filter, and terminate selected sockets.  Additionally, the helper can =
only
>> be called from these BPF contexts that ensure socket locking in order =
to
>> allow synchronous execution of destroy helpers that also acquire =
socket
>> locks. The previous commit that batches UDP sockets during iteration
>> facilitated a synchronous invocation of the destroy helper from BPF =
context
>> by skipping taking socket locks in the destroy handler. TCP iterators
>> already supported batching.
>=20
>> The helper takes `sock_common` type argument, even though it expects, =
and
>> casts them to a `sock` pointer. This enables the verifier to allow =
the
>> sock_destroy kfunc to be called for TCP with `sock_common` and UDP =
with
>> `sock` structs. As a comparison, BPF helpers enable this behavior =
with the
>> `ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no =
such
>> option available with the verifier logic that handles kfuncs where =
BTF
>> types are inferred. Furthermore, as `sock_common` only has a subset =
of
>> certain fields of `sock`, casting pointer to the latter type might =
not
>> always be safe. Hence, the BPF kfunc converts the argument to a full =
sock
>> before casting.
>=20
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  net/core/filter.c | 55 =
+++++++++++++++++++++++++++++++++++++++++++++++
>>  net/ipv4/tcp.c    | 17 ++++++++++-----
>>  net/ipv4/udp.c    |  7 ++++--
>>  3 files changed, 72 insertions(+), 7 deletions(-)
>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 1d6f165923bf..79cd91ba13d0 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11621,3 +11621,58 @@ bpf_sk_base_func_proto(enum bpf_func_id =
func_id)
>=20
>>  	return func;
>>  }
>> +
>> +/* Disables missing prototype warnings */
>> +__diag_push();
>> +__diag_ignore_all("-Wmissing-prototypes",
>> +		  "Global functions as their definitions will be in =
vmlinux BTF");
>> +
>> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED =
error code.
>> + *
>> + * The helper expects a non-NULL pointer to a full socket. It =
invokes
>> + * the protocol specific socket destroy handlers.
>> + *
>> + * The helper can only be called from BPF contexts that have =
acquired the socket
>> + * locks.
>> + *
>> + * Parameters:
>> + * @sock: Pointer to socket to be destroyed
>> + *
>> + * Return:
>> + * On error, may return EPROTONOSUPPORT, EINVAL.
>> + * EPROTONOSUPPORT if protocol specific destroy handler is not =
implemented.
>> + * 0 otherwise
>> + */
>> +int bpf_sock_destroy(struct sock_common *sock)
>=20
> Prefix with __bpf_kfunc (see other kfuncs).

Will do!

>=20
>> +{
>> +	/* Validates the socket can be type casted to a full socket. */
>> +	struct sock *sk =3D sk_to_full_sk((struct sock *)sock);
>> +
>> +	if (!sk)
>> +		return -EINVAL;
>> +
>> +	/* The locking semantics that allow for synchronous execution of =
the
>> +	 * destroy handlers are only supported for TCP and UDP.
>> +	 */
>> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol =3D=3D =
IPPROTO_RAW)
>> +		return -EOPNOTSUPP;
>> +
>> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
>> +}
>> +
>> +__diag_pop()
>> +
>> +BTF_SET8_START(sock_destroy_kfunc_set)
>> +BTF_ID_FLAGS(func, bpf_sock_destroy)
>> +BTF_SET8_END(sock_destroy_kfunc_set)
>> +
>> +static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set =3D =
{
>> +	.owner =3D THIS_MODULE,
>> +	.set   =3D &sock_destroy_kfunc_set,
>> +};
>> +
>> +static int init_subsystem(void)
>> +{
>> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, =
&bpf_sock_destroy_kfunc_set);
>=20
> Is it safe? Does it mean I can call bpf_sock_destroy from any tracing
> program from anywhere? What if the socket is not locked?
> IOW, do we have to constrain it to the iterator programs (at least for
> now)?

Given kprobes are not considered as part of BPF_PROG_TYPE_TRACING, I'm =
not sure if there are other tracing programs with sock/sock_common =
arguments. Regardless, this is a valid point. I had brought up a similar =
topic earlier during the v1 discussion -  =
https://lore.kernel.org/bpf/78E434B0-06A9-466F-A061-B9A05DC6DE6D@isovalent=
.com/. I suppose you would have a similar problem in the case of =
setsockopt* helpers.=20
Is the general topic of limiting access for kfunc to a subset of =
BPF_PROG_* programs being discussed?

>=20
>> +}
>> +late_initcall(init_subsystem);
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 33f559f491c8..8123c264d8ea 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
>>  		return 0;
>>  	}
>=20
>> -	/* Don't race with userspace socket closes such as tcp_close. */
>> -	lock_sock(sk);
>> +	/* BPF context ensures sock locking. */
>> +	if (!has_current_bpf_ctx())
>> +		/* Don't race with userspace socket closes such as =
tcp_close. */
>> +		lock_sock(sk);
>=20
>>  	if (sk->sk_state =3D=3D TCP_LISTEN) {
>>  		tcp_set_state(sk, TCP_CLOSE);
>> @@ -4688,7 +4690,9 @@ int tcp_abort(struct sock *sk, int err)
>=20
>>  	/* Don't race with BH socket closes such as =
inet_csk_listen_stop. */
>>  	local_bh_disable();
>> -	bh_lock_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		bh_lock_sock(sk);
>> +
>=20
>>  	if (!sock_flag(sk, SOCK_DEAD)) {
>>  		sk->sk_err =3D err;
>> @@ -4700,10 +4704,13 @@ int tcp_abort(struct sock *sk, int err)
>>  		tcp_done(sk);
>>  	}
>=20
>> -	bh_unlock_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		bh_unlock_sock(sk);
>> +
>>  	local_bh_enable();
>>  	tcp_write_queue_purge(sk);
>> -	release_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		release_sock(sk);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(tcp_abort);
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 2f3978de45f2..1bc9ad92c3d4 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -2925,7 +2925,9 @@ EXPORT_SYMBOL(udp_poll);
>=20
>>  int udp_abort(struct sock *sk, int err)
>>  {
>> -	lock_sock(sk);
>> +	/* BPF context ensures sock locking. */
>> +	if (!has_current_bpf_ctx())
>> +		lock_sock(sk);
>=20
>>  	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid =
racing
>>  	 * with close()
>> @@ -2938,7 +2940,8 @@ int udp_abort(struct sock *sk, int err)
>>  	__udp_disconnect(sk, 0);
>=20
>>  out:
>> -	release_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		release_sock(sk);
>=20
>>  	return 0;
>>  }
>> --
>> 2.34.1

