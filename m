Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101EC6D0883
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 16:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjC3OmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 10:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjC3OmJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 10:42:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF8DE
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 07:42:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so19839491pjz.1
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680187324;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9/g15MjbTcP+7PKkyPIWz76lCcTl+9R3wBpUDGZn6Y=;
        b=Zuj4VZAwGlPGpdRKvfUijRn4SpMJP3puTUcB566dwUsztnWzQJgaj85NsESL/oo11Q
         gMGdgBWaLA3bQCKHfD3d4FzIcs2JO3vYtoox5qmrSz9oIVmrTNer4y70qRPJRT/y0snD
         65ux5w++4CeXEr5EuzOJrkLUSHS1fkex9UnpRvu/9FnIG0DMZG6WIVMfhr929u7tINfm
         GQ957WnyeMBUvIWod1n7H+9F2G8maLHcE2rAtKTDNTKwlkYhV/sBa57gBm3io6himl8L
         /5RoPbMJ0n8aCconBOb5TmnH6swUi7DBdGEs6SOevk/Bb9r7DRkICKOiIGgQSzLmj0Es
         PTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187324;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9/g15MjbTcP+7PKkyPIWz76lCcTl+9R3wBpUDGZn6Y=;
        b=ojCTZhOv+MqEDjE9Hprjf1KLG4K5Pz1XSvGgyZTHhCT19VkZMD0sHZRbjsJMRFgbbo
         h02ADwveYp3tBUTR8c4DCRorIu7Bguren/jEFaXdTpOTSeIdJioZLfiYBI9iRTB0izzn
         ZaG+jestH8Z+xQ0nLyImXn5xDtCBi3PNVYPFWRrZRJEg5C3+7vMpakuTrjKU6HvKZLCf
         wE0ggelEKMHc1ZZvH9a4nK+tk6HX3CvCdyooZKuwhMww0Ids2utXVNhMBWB16QcdHGiS
         hIOmKn9iRzM27ET0cwuy5EerpS9/+IKnhaJ+oBBwdw49OdDFD5zoBjQ0BochPE5sqyO8
         y0cA==
X-Gm-Message-State: AAQBX9cqfWsGWrZvZFsuKNHeG1waKEzhHgmQsFdl4XOpuD7KI/M1xdsM
        zieHwFFZ/qzLh4S7OcExXEHWdA==
X-Google-Smtp-Source: AKy350b+x6DzUOXkR7V7ONjATdKbxqkfI3Hrl2sNY4/vAvkZAhN7sm2m6EzieZ8gYMASfLeM0KNZuQ==
X-Received: by 2002:a17:90b:1b4d:b0:23f:9196:c038 with SMTP id nv13-20020a17090b1b4d00b0023f9196c038mr27378625pjb.37.1680187324117;
        Thu, 30 Mar 2023 07:42:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:cd81:c42c:e36a:c000? ([2601:647:4900:1fbb:cd81:c42c:e36a:c000])
        by smtp.gmail.com with ESMTPSA id gv7-20020a17090b11c700b0022335f1dae2sm3316492pjb.22.2023.03.30.07.42.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2023 07:42:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: Add bpf_sock_destroy kfunc
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <ZB4X/uOEdq79Lbof@google.com>
Date:   Thu, 30 Mar 2023 07:42:00 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED9BFD83-8CCE-4783-B28F-0742F70AAB8F@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-3-aditi.ghag@isovalent.com>
 <ZB4X/uOEdq79Lbof@google.com>
To:     Stanislav Fomichev <sdf@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 24, 2023, at 2:37 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>=20
> On 03/23, Aditi Ghag wrote:
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
>>  net/core/filter.c | 54 =
+++++++++++++++++++++++++++++++++++++++++++++++
>>  net/ipv4/tcp.c    | 10 ++++++---
>>  net/ipv4/udp.c    |  6 ++++--
>>  3 files changed, 65 insertions(+), 5 deletions(-)
>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 1d6f165923bf..ba3e0dac119c 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11621,3 +11621,57 @@ bpf_sk_base_func_proto(enum bpf_func_id =
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
>> + * The helper expects a non-NULL pointer to a socket. It invokes the
>> + * protocol specific socket destroy handlers.
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
>> +__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>> +{
>> +	struct sock *sk =3D (struct sock *)sock;
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
>=20
> Copy-pasting from v3, let's discuss here.
>=20
> Maybe make it more opt-in? (vs current "opt ipproto_raw out")
>=20
> if (sk->sk_prot->diag_destroy !=3D udp_abort &&
>    sk->sk_prot->diag_destroy !=3D tcp_abort)
>            return -EOPNOTSUPP;
>=20
> Is it more robust? Or does it look uglier? )
> But maybe fine as is, I'm just thinking out loud..

Do we expect the handler to be extended for more types? Probably not... =
So I'll leave it as is.

>=20
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
>> +}
>> +late_initcall(init_subsystem);
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 33f559f491c8..5df6231016e3 100644
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
>> @@ -4701,9 +4703,11 @@ int tcp_abort(struct sock *sk, int err)
>>  	}
>=20
>>  	bh_unlock_sock(sk);
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
>> index 58c620243e47..408836102e20 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -2925,7 +2925,8 @@ EXPORT_SYMBOL(udp_poll);
>=20
>>  int udp_abort(struct sock *sk, int err)
>>  {
>> -	lock_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		lock_sock(sk);
>=20
>>  	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid =
racing
>>  	 * with close()
>> @@ -2938,7 +2939,8 @@ int udp_abort(struct sock *sk, int err)
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

