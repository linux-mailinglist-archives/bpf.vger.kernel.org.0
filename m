Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A276D0B59
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjC3Qco (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjC3Qcn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 12:32:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0990C15B
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 09:32:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j13so17761977pjd.1
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680193957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O3TkWwLyZxfan5eXxoGoRIyEhKMLD0hNnC4ZwWGfmM=;
        b=Io3RRgFgGy7MYERQqil8pmJsy/a2+qO5XYejhaSDvINvb798EkexkfA7yPQW5+AQCI
         6Yzf/OvGi6Z5IoBovLzVw4chSqT+lwXfgzFZkDQj6RI6CnLFENTRNqORgtkvyR44yhYh
         WepJWnJ88u4nHxaHx/JyTm2BB8LyKpQLZKw2bzlB+T/6M+HlJHndEqwGVc1B4WGnbmwQ
         ngsd8xteQ+RmL0L04K5XDJN8+lRcmloukwh79prKK+Klj5Md7rEGdeWGq7kDNV9GGn3S
         BcEvyIEgyT2ymSOkEWBand36DdIslM1xcJPr2TnmT7cmb+nInXkUEzfgAkHThOiejcEM
         mEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680193957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O3TkWwLyZxfan5eXxoGoRIyEhKMLD0hNnC4ZwWGfmM=;
        b=lvwb/ceX/xBzxfM4FfkNdrSaqMyYl1WToiXbZjsOJR/8IyKd5HxTO9lchJD6N4H6kC
         dR4lizhc2JIwAy0rG2uroUy1Pr9b8z+TmFtJZD8iIIE77mhtyRBtAQakPrk6JJ9BrJ08
         DiA9gpdIKOVP3hOe1WWMI/rg69DYFwp4PSxgE3rd44CVYuyEDWah2sz87avPNZZfMnFh
         F4P6N5T4gMNNzsEZ5UtMcHvziLF4sORvYSfKXuAVQwHhvaGkkI1IuQKL/4+4OuNK6EPH
         x1WDjI5glkTiIYdG0Vo5YjfE70BGU5/IQrMiHHdBzUxLbsQyEF0xJPGuGv5tvFzqly7e
         89cw==
X-Gm-Message-State: AAQBX9fSDL/BV8tCRl2sz22v3bG3NW+WGwMS4JVJcYyaQAbYXhv0nBqA
        axp2HeZp5a5Py68dNM2DbczfouHJA5PfgPXWJMCKMQ==
X-Google-Smtp-Source: AKy350aIkrjgmgsQ5OT5IWfbxBqJ2A2ZRXGK/mHE5LjEuuxI/fG8HomcdVHEEvuzNYQUHMn9tmLtWfyTU24MTS9K+S8=
X-Received: by 2002:a17:902:dacc:b0:19a:7bd4:5b0d with SMTP id
 q12-20020a170902dacc00b0019a7bd45b0dmr8415925plx.8.1680193957158; Thu, 30 Mar
 2023 09:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-3-aditi.ghag@isovalent.com> <ZB4X/uOEdq79Lbof@google.com>
 <ED9BFD83-8CCE-4783-B28F-0742F70AAB8F@isovalent.com>
In-Reply-To: <ED9BFD83-8CCE-4783-B28F-0742F70AAB8F@isovalent.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 30 Mar 2023 09:32:24 -0700
Message-ID: <CAKH8qBvibAPqkJ_73-e_CpPRDMMhP9v4nP7vAqw=q9et8DPCig@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: Add bpf_sock_destroy kfunc
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 7:42=E2=80=AFAM Aditi Ghag <aditi.ghag@isovalent.co=
m> wrote:
>
>
>
> > On Mar 24, 2023, at 2:37 PM, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 03/23, Aditi Ghag wrote:
> >> The socket destroy kfunc is used to forcefully terminate sockets from
> >> certain BPF contexts. We plan to use the capability in Cilium to force
> >> client sockets to reconnect when their remote load-balancing backends =
are
> >> deleted. The other use case is on-the-fly policy enforcement where exi=
sting
> >> socket connections prevented by policies need to be forcefully termina=
ted.
> >> The helper allows terminating sockets that may or may not be actively
> >> sending traffic.
> >
> >> The helper is currently exposed to certain BPF iterators where users c=
an
> >> filter, and terminate selected sockets.  Additionally, the helper can =
only
> >> be called from these BPF contexts that ensure socket locking in order =
to
> >> allow synchronous execution of destroy helpers that also acquire socke=
t
> >> locks. The previous commit that batches UDP sockets during iteration
> >> facilitated a synchronous invocation of the destroy helper from BPF co=
ntext
> >> by skipping taking socket locks in the destroy handler. TCP iterators
> >> already supported batching.
> >
> >> The helper takes `sock_common` type argument, even though it expects, =
and
> >> casts them to a `sock` pointer. This enables the verifier to allow the
> >> sock_destroy kfunc to be called for TCP with `sock_common` and UDP wit=
h
> >> `sock` structs. As a comparison, BPF helpers enable this behavior with=
 the
> >> `ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no su=
ch
> >> option available with the verifier logic that handles kfuncs where BTF
> >> types are inferred. Furthermore, as `sock_common` only has a subset of
> >> certain fields of `sock`, casting pointer to the latter type might not
> >> always be safe. Hence, the BPF kfunc converts the argument to a full s=
ock
> >> before casting.
> >
> >> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> >> ---
> >>  net/core/filter.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  net/ipv4/tcp.c    | 10 ++++++---
> >>  net/ipv4/udp.c    |  6 ++++--
> >>  3 files changed, 65 insertions(+), 5 deletions(-)
> >
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index 1d6f165923bf..ba3e0dac119c 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -11621,3 +11621,57 @@ bpf_sk_base_func_proto(enum bpf_func_id func_=
id)
> >
> >>      return func;
> >>  }
> >> +
> >> +/* Disables missing prototype warnings */
> >> +__diag_push();
> >> +__diag_ignore_all("-Wmissing-prototypes",
> >> +              "Global functions as their definitions will be in vmlin=
ux BTF");
> >> +
> >> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error=
 code.
> >> + *
> >> + * The helper expects a non-NULL pointer to a socket. It invokes the
> >> + * protocol specific socket destroy handlers.
> >> + *
> >> + * The helper can only be called from BPF contexts that have acquired=
 the socket
> >> + * locks.
> >> + *
> >> + * Parameters:
> >> + * @sock: Pointer to socket to be destroyed
> >> + *
> >> + * Return:
> >> + * On error, may return EPROTONOSUPPORT, EINVAL.
> >> + * EPROTONOSUPPORT if protocol specific destroy handler is not implem=
ented.
> >> + * 0 otherwise
> >> + */
> >> +__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> >> +{
> >> +    struct sock *sk =3D (struct sock *)sock;
> >> +
> >> +    if (!sk)
> >> +            return -EINVAL;
> >> +
> >> +    /* The locking semantics that allow for synchronous execution of =
the
> >> +     * destroy handlers are only supported for TCP and UDP.
> >> +     */
> >> +    if (!sk->sk_prot->diag_destroy || sk->sk_protocol =3D=3D IPPROTO_=
RAW)
> >> +            return -EOPNOTSUPP;
> >
> > Copy-pasting from v3, let's discuss here.
> >
> > Maybe make it more opt-in? (vs current "opt ipproto_raw out")
> >
> > if (sk->sk_prot->diag_destroy !=3D udp_abort &&
> >    sk->sk_prot->diag_destroy !=3D tcp_abort)
> >            return -EOPNOTSUPP;
> >
> > Is it more robust? Or does it look uglier? )
> > But maybe fine as is, I'm just thinking out loud..
>
> Do we expect the handler to be extended for more types? Probably not... S=
o I'll leave it as is.

My worry is about somebody adding .diag_destroy to some new/old
protocol in the future, say sctp_prot, without being aware
of this bpf_sock_destroy helper and its locking requirements.

So having an opt-in here (as in sk_protocol =3D=3D IPPROTO_TCP ||
sk_protocol =3D=3D IPPROTO_UDP) feels more future-proof than your current
opt-out (sk_proto !=3D IPPROTO_RAW).
WDYT?

> >
> >> +
> >> +    return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> >> +}
> >> +
> >> +__diag_pop()
> >> +
> >> +BTF_SET8_START(sock_destroy_kfunc_set)
> >> +BTF_ID_FLAGS(func, bpf_sock_destroy)
> >> +BTF_SET8_END(sock_destroy_kfunc_set)
> >> +
> >> +static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set =3D {
> >> +    .owner =3D THIS_MODULE,
> >> +    .set   =3D &sock_destroy_kfunc_set,
> >> +};
> >> +
> >> +static int init_subsystem(void)
> >> +{
> >> +    return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sock=
_destroy_kfunc_set);
> >> +}
> >> +late_initcall(init_subsystem);
> >> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> >> index 33f559f491c8..5df6231016e3 100644
> >> --- a/net/ipv4/tcp.c
> >> +++ b/net/ipv4/tcp.c
> >> @@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
> >>              return 0;
> >>      }
> >
> >> -    /* Don't race with userspace socket closes such as tcp_close. */
> >> -    lock_sock(sk);
> >> +    /* BPF context ensures sock locking. */
> >> +    if (!has_current_bpf_ctx())
> >> +            /* Don't race with userspace socket closes such as tcp_cl=
ose. */
> >> +            lock_sock(sk);
> >
> >>      if (sk->sk_state =3D=3D TCP_LISTEN) {
> >>              tcp_set_state(sk, TCP_CLOSE);
> >> @@ -4701,9 +4703,11 @@ int tcp_abort(struct sock *sk, int err)
> >>      }
> >
> >>      bh_unlock_sock(sk);
> >> +
> >>      local_bh_enable();
> >>      tcp_write_queue_purge(sk);
> >> -    release_sock(sk);
> >> +    if (!has_current_bpf_ctx())
> >> +            release_sock(sk);
> >>      return 0;
> >>  }
> >>  EXPORT_SYMBOL_GPL(tcp_abort);
> >> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> >> index 58c620243e47..408836102e20 100644
> >> --- a/net/ipv4/udp.c
> >> +++ b/net/ipv4/udp.c
> >> @@ -2925,7 +2925,8 @@ EXPORT_SYMBOL(udp_poll);
> >
> >>  int udp_abort(struct sock *sk, int err)
> >>  {
> >> -    lock_sock(sk);
> >> +    if (!has_current_bpf_ctx())
> >> +            lock_sock(sk);
> >
> >>      /* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
> >>       * with close()
> >> @@ -2938,7 +2939,8 @@ int udp_abort(struct sock *sk, int err)
> >>      __udp_disconnect(sk, 0);
> >
> >>  out:
> >> -    release_sock(sk);
> >> +    if (!has_current_bpf_ctx())
> >> +            release_sock(sk);
> >
> >>      return 0;
> >>  }
> >> --
> >> 2.34.1
>
