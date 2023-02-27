Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE52E6A4809
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 18:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjB0RbV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 12:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjB0RbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 12:31:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2D2413D
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 09:30:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so6849018pja.5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8oZTIgNWBQBXGeXhLSNgCW/IOqsnhIqfaDL0c+NTyQ=;
        b=XHHdqnpDfJwb5HJpaJeC0ghoPzHQRsbiLT/bpR1Xg1r4mUx4d03sDI9R8nuoKtBCaS
         MT6v73dhWVWeqYX7UTW4JFkeyby+sbyJQ8LiwZkaxrQZbIgl6jyeIfSj9nDhhPsdhOML
         O5KOq1uoo/tXJ6K7yIRZvgio6Zq8Pxbg4622ZLg0g65orGSzO8L412xXpB/LokLsaZEO
         6Z1Tj5gYTTwO4zvp//sMTdRkFqrF9LQoSZ//0Y8r+tVI5ozOqnym++02CoZa2oOGIVfI
         6MVSituygTGS5mh/9h9v9u6/yOnATk0NzMkw57idLDGHa4XyhN0S8UkCOpIxvsvpMIM2
         r09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8oZTIgNWBQBXGeXhLSNgCW/IOqsnhIqfaDL0c+NTyQ=;
        b=JT7HasTmZFCVyjMOKgls8S+LyZft1pWaTy1q5Spu9QRiOLaeVmjnIXzVjQFnCZhqHM
         AVBSuXOSQQoWV7LGyNly0vBx194cj7JWypaWcCaAfTQ+QevNNeTR75xX9OlxJU4zFj/E
         fQkEYQ5xHeRsHShxcth7jro/o+hK1ScCjHBKIbYOR+NCsgrqi1sh/Ymok/2D2g4bIGBx
         qAh5dNCYZvkXERe62UsXeFafyUfjRmgI33afdNGJ3pOQpGn7FH8RTyk38+HTAGRO6gkh
         dwe/pyAjXtrBSBk+GI5im39rkqRPJQKYuu/B8uYdfuX2fW5H72buDmQloojlp0gk61jC
         UzAw==
X-Gm-Message-State: AO0yUKWLc5xWkLlSj0E6JuAsAuopmH7TV4p1uZ1QWMyrDuAjEmCodmEs
        2LihNBs691+YOnTqPjsHyQP3BixoX3oin8FS7LstgQIb2+pdDx4h5xQ=
X-Google-Smtp-Source: AK7set8tkJy0mjyQrjHupvx/1aCZpGBb7tasHOes7dsNhO51V4t2lUyg95y7NROD7xvX2oWd+GI4QP8S2b4yXGKVugg=
X-Received: by 2002:a17:90a:578a:b0:234:bed1:1012 with SMTP id
 g10-20020a17090a578a00b00234bed11012mr10799pji.6.1677519037359; Mon, 27 Feb
 2023 09:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-3-aditi.ghag@isovalent.com> <Y/k7yYCsHJqaqOjU@google.com>
 <139B8C1E-A1B9-4DB4-BA0E-60EA4AAE6503@isovalent.com>
In-Reply-To: <139B8C1E-A1B9-4DB4-BA0E-60EA4AAE6503@isovalent.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 27 Feb 2023 09:30:25 -0800
Message-ID: <CAKH8qBsn7Xtf5SmbwstP=c8PZvMbsoPE7h63A5q0-V6ndh_Ecg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Add bpf_sock_destroy kfunc
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 6:56 AM Aditi Ghag <aditi.ghag@isovalent.com> wrote=
:
>
>
>
> > On Feb 24, 2023, at 2:35 PM, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 02/23, Aditi Ghag wrote:
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
> >>  net/core/filter.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  net/ipv4/tcp.c    | 17 ++++++++++-----
> >>  net/ipv4/udp.c    |  7 ++++--
> >>  3 files changed, 72 insertions(+), 7 deletions(-)
> >
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index 1d6f165923bf..79cd91ba13d0 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -11621,3 +11621,58 @@ bpf_sk_base_func_proto(enum bpf_func_id func_=
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
> >> + * The helper expects a non-NULL pointer to a full socket. It invokes
> >> + * the protocol specific socket destroy handlers.
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
> >> +int bpf_sock_destroy(struct sock_common *sock)
> >
> > Prefix with __bpf_kfunc (see other kfuncs).
>
> Will do!
>
> >
> >> +{
> >> +    /* Validates the socket can be type casted to a full socket. */
> >> +    struct sock *sk =3D sk_to_full_sk((struct sock *)sock);
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
> >
> > Is it safe? Does it mean I can call bpf_sock_destroy from any tracing
> > program from anywhere? What if the socket is not locked?
> > IOW, do we have to constrain it to the iterator programs (at least for
> > now)?
>
> Given kprobes are not considered as part of BPF_PROG_TYPE_TRACING, I'm no=
t sure if there are other tracing programs with sock/sock_common arguments.=
 Regardless, this is a valid point. I had brought up a similar topic earlie=
r during the v1 discussion -  https://lore.kernel.org/bpf/78E434B0-06A9-466=
F-A061-B9A05DC6DE6D@isovalent.com/. I suppose you would have a similar prob=
lem in the case of setsockopt* helpers.

Sure, the same problem exists for bpf_setsockopt helper, but these
should be exposed only in a handful of hooks (where we know that the
socket is either locked or not). See, for example, [0] as one of the
recent fixes.

> Is the general topic of limiting access for kfunc to a subset of BPF_PROG=
_* programs being discussed?

Some of that discussion might have happened in [1] (or one of the
earlier respins). I think at that time I was thinking maybe we can use
btf_tags to annotate __locked/__unlocked socket arguments. Then, in
those annotated contexts, the verifier might allow you to call
bpf_setsockopt.. But I haven't really explored this too much.

0: https://lore.kernel.org/bpf/20230127001732.4162630-1-kuifeng@meta.com/
1: https://lore.kernel.org/bpf/20220622160346.967594-1-sdf@google.com/

> >
> >> +}
> >> +late_initcall(init_subsystem);
> >> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> >> index 33f559f491c8..8123c264d8ea 100644
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
> >> @@ -4688,7 +4690,9 @@ int tcp_abort(struct sock *sk, int err)
> >
> >>      /* Don't race with BH socket closes such as inet_csk_listen_stop.=
 */
> >>      local_bh_disable();
> >> -    bh_lock_sock(sk);
> >> +    if (!has_current_bpf_ctx())
> >> +            bh_lock_sock(sk);
> >> +
> >
> >>      if (!sock_flag(sk, SOCK_DEAD)) {
> >>              sk->sk_err =3D err;
> >> @@ -4700,10 +4704,13 @@ int tcp_abort(struct sock *sk, int err)
> >>              tcp_done(sk);
> >>      }
> >
> >> -    bh_unlock_sock(sk);
> >> +    if (!has_current_bpf_ctx())
> >> +            bh_unlock_sock(sk);
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
> >> index 2f3978de45f2..1bc9ad92c3d4 100644
> >> --- a/net/ipv4/udp.c
> >> +++ b/net/ipv4/udp.c
> >> @@ -2925,7 +2925,9 @@ EXPORT_SYMBOL(udp_poll);
> >
> >>  int udp_abort(struct sock *sk, int err)
> >>  {
> >> -    lock_sock(sk);
> >> +    /* BPF context ensures sock locking. */
> >> +    if (!has_current_bpf_ctx())
> >> +            lock_sock(sk);
> >
> >>      /* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
> >>       * with close()
> >> @@ -2938,7 +2940,8 @@ int udp_abort(struct sock *sk, int err)
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
