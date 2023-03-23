Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E26C7288
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCWVqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 17:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjCWVqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 17:46:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3517172D
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 14:46:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x15so12322375pjk.2
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 14:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679607966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt9uO5dqLL9xSBYOviuf0PltibOlINax6R+0HHYFKrs=;
        b=fbHN56POe+SjO7rygCDD8FmrlOCOcNz9gmKfGVkNOgPjZL2gblfywihDohxIP3eVZU
         eK4yvzN1/iOAiud/ZnKNUBYgmJjc1hZ/jsF1QXKeOqsYuhAupxS48ceUPvGCpNvYANLq
         +vqb+zt6xnKRk7cFRzidT3tILE80rZ5dB0YJeVpFWfiVSgH39pdZGO87/Hazrlm+M2ks
         2F0G29A3gdeDa+qVkrUKQMdnvAq11XTQGyX9iAZZ2lRcs4VmsI2SxmDK0yLgPGGG/mBF
         Vjlk2r4PqzunKSMZY3cI2GHIawkcuhLiwHgVtpYnj7+Wos72sEH178pTdOyjOnKvXXYo
         iFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679607966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt9uO5dqLL9xSBYOviuf0PltibOlINax6R+0HHYFKrs=;
        b=tDx4GuisqG/i63PIOwD9wYq6rke3nzdhAj83tWv7gdZrJGTLoLSv+3uaiNXSpRPp6p
         mrx/qprF1pNlHe/W45FDIWm8KV+pQW29tWEZ3I4UjneP9yhrOGVjh1HId3Oh9AvlsH9R
         HUpQqh+PtQKpgsxuCggMybrKz7TQFknGibU0sSGsOPa61H1m3xoSEvfahoVlb5w9C7Zz
         Bzg7U6QH7MRR54DK74c+1H3q1N2PVMa4THwvs6bdODRcG6LcQr+LalpZKkoBToRrjIY4
         4eKsvq0MAssJW5Q/GkF99jSDS/8Uqglfiwyiur/WCB5vTkg9jYE6zkfHyr0Gl0wAB8LF
         Y81w==
X-Gm-Message-State: AAQBX9f5ilze4IqvwTjcxZr9WKjTOcaSkr3XmjuuZktLetYHuGFOS5DQ
        r5i6zHA7wgRiIAjJ3YVgmz+i8fAvtK4+6LteNqOlshP7gMLcI4aH5+slpw==
X-Google-Smtp-Source: AKy350aNGomkITwal2tfruCLJ17E/9LI6RRP3AveW8+ONODK1BX1Z/DivWJISYZmxCklbT72QJswABFuVQOV/yeIUMs=
X-Received: by 2002:a17:90a:6808:b0:23d:424d:400f with SMTP id
 p8-20020a17090a680800b0023d424d400fmr152952pjj.9.1679607966041; Thu, 23 Mar
 2023 14:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-3-aditi.ghag@isovalent.com> <ZBobc8WSCmoUKvWc@google.com>
 <F946AEF3-2E02-4932-9AB2-486245DDA743@isovalent.com>
In-Reply-To: <F946AEF3-2E02-4932-9AB2-486245DDA743@isovalent.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 23 Mar 2023 14:45:54 -0700
Message-ID: <CAKH8qBvuDcWio-dpvtpx_edMLAB+M72MMKe6UWaCNBpigK+Rhw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: Add bpf_sock_destroy kfunc
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

On Thu, Mar 23, 2023 at 1:02=E2=80=AFPM Aditi Ghag <aditi.ghag@isovalent.co=
m> wrote:
>
>
>
> > On Mar 21, 2023, at 2:02 PM, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 03/21, Aditi Ghag wrote:
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
> >>  include/net/udp.h |  1 +
> >>  net/core/filter.c | 54 ++++++++++++++++++++++++++++++++++++++++++
> >>  net/ipv4/tcp.c    | 16 +++++++++----
> >>  net/ipv4/udp.c    | 60 +++++++++++++++++++++++++++++++++++++---------=
-
> >>  4 files changed, 114 insertions(+), 17 deletions(-)
> >
> >> diff --git a/include/net/udp.h b/include/net/udp.h
> >> index de4b528522bb..d2999447d3f2 100644
> >> --- a/include/net/udp.h
> >> +++ b/include/net/udp.h
> >> @@ -437,6 +437,7 @@ struct udp_seq_afinfo {
> >>  struct udp_iter_state {
> >>      struct seq_net_private  p;
> >>      int                     bucket;
> >> +    int                     offset;
> >>      struct udp_seq_afinfo   *bpf_seq_afinfo;
> >>  };
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
> > What makes IPPROTO_RAW special? Looks like it locks the socket as well?
>
> I haven't looked at the locking semantics for IPPROTO_RAW. These can be h=
andled in a follow-up patch. Wdyt?

Fine with me. Maybe make it more opt-in? (vs current "opt ipproto_raw out")

if (sk->sk_prot->diag_destroy !=3D udp_abort &&
    sk->sk_prot->diag_destroy !=3D tcp_abort)
        return -EOPNOTSUPP;

Is it more robust? Or does it look uglier? )
But maybe fine as is, I'm just thinking out loud..

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
> >> index 33f559f491c8..59a833c0c872 100644
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
> >> @@ -4688,7 +4690,8 @@ int tcp_abort(struct sock *sk, int err)
> >
> >>      /* Don't race with BH socket closes such as inet_csk_listen_stop.=
 */
> >>      local_bh_disable();
> >
> > [..]
> >
> >> -    bh_lock_sock(sk);
> >> +    if (!has_current_bpf_ctx())
> >> +            bh_lock_sock(sk);
> >
> > These are spinlocks and should probably be grabbed in the bpf context a=
s
> > well?
>
> Fixed in the next revision. Thanks!
>
> >
> >
> >>      if (!sock_flag(sk, SOCK_DEAD)) {
> >>              sk->sk_err =3D err;
> >> @@ -4700,10 +4703,13 @@ int tcp_abort(struct sock *sk, int err)
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
> >> index 545e56329355..02d357713838 100644
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
> >> @@ -3184,15 +3187,23 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
> >>      struct sock *first_sk =3D NULL;
> >>      struct sock *sk;
> >>      unsigned int bucket_sks =3D 0;
> >> -    bool first;
> >>      bool resized =3D false;
> >> +    int offset =3D 0;
> >> +    int new_offset;
> >
> >>      /* The current batch is done, so advance the bucket. */
> >> -    if (iter->st_bucket_done)
> >> +    if (iter->st_bucket_done) {
> >>              state->bucket++;
> >> +            state->offset =3D 0;
> >> +    }
> >
> >>      udptable =3D udp_get_table_afinfo(afinfo, net);
> >
> >> +    if (state->bucket > udptable->mask) {
> >> +            state->bucket =3D 0;
> >> +            state->offset =3D 0;
> >> +    }
> >> +
> >>  again:
> >>      /* New batch for the next bucket.
> >>       * Iterate over the hash table to find a bucket with sockets matc=
hing
> >> @@ -3204,43 +3215,60 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
> >>      iter->cur_sk =3D 0;
> >>      iter->end_sk =3D 0;
> >>      iter->st_bucket_done =3D false;
> >> -    first =3D true;
> >> +    first_sk =3D NULL;
> >> +    bucket_sks =3D 0;
> >> +    offset =3D state->offset;
> >> +    new_offset =3D offset;
> >
> >>      for (; state->bucket <=3D udptable->mask; state->bucket++) {
> >>              struct udp_hslot *hslot =3D &udptable->hash[state->bucket=
];
> >
> >> -            if (hlist_empty(&hslot->head))
> >> +            if (hlist_empty(&hslot->head)) {
> >> +                    offset =3D 0;
> >>                      continue;
> >> +            }
> >
> >>              spin_lock_bh(&hslot->lock);
> >> +            /* Resume from the last saved position in a bucket before
> >> +             * iterator was stopped.
> >> +             */
> >> +            while (offset-- > 0) {
> >> +                    sk_for_each(sk, &hslot->head)
> >> +                            continue;
> >> +            }
> >>              sk_for_each(sk, &hslot->head) {
> >>                      if (seq_sk_match(seq, sk)) {
> >> -                            if (first) {
> >> +                            if (!first_sk)
> >>                                      first_sk =3D sk;
> >> -                                    first =3D false;
> >> -                            }
> >>                              if (iter->end_sk < iter->max_sk) {
> >>                                      sock_hold(sk);
> >>                                      iter->batch[iter->end_sk++] =3D s=
k;
> >>                              }
> >>                              bucket_sks++;
> >>                      }
> >> +                    new_offset++;
> >>              }
> >>              spin_unlock_bh(&hslot->lock);
> >> +
> >>              if (first_sk)
> >>                      break;
> >> +
> >> +            /* Reset the current bucket's offset before moving to the=
 next bucket. */
> >> +            offset =3D 0;
> >> +            new_offset =3D 0;
> >> +
> >>      }
> >
> >>      /* All done: no batch made. */
> >>      if (!first_sk)
> >> -            return NULL;
> >> +            goto ret;
> >
> >>      if (iter->end_sk =3D=3D bucket_sks) {
> >>              /* Batching is done for the current bucket; return the fi=
rst
> >>               * socket to be iterated from the batch.
> >>               */
> >>              iter->st_bucket_done =3D true;
> >> -            return first_sk;
> >> +            goto ret;
> >>      }
> >>      if (!resized && !bpf_iter_udp_realloc_batch(iter, bucket_sks * 3 =
/ 2)) {
> >>              resized =3D true;
> >> @@ -3248,19 +3276,24 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
> >>              state->bucket--;
> >>              goto again;
> >>      }
> >> +ret:
> >> +    state->offset =3D new_offset;
> >>      return first_sk;
> >>  }
> >
> >>  static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, lof=
f_t *pos)
> >>  {
> >>      struct bpf_udp_iter_state *iter =3D seq->private;
> >> +    struct udp_iter_state *state =3D &iter->state;
> >>      struct sock *sk;
> >
> >>      /* Whenever seq_next() is called, the iter->cur_sk is
> >>       * done with seq_show(), so unref the iter->cur_sk.
> >>       */
> >> -    if (iter->cur_sk < iter->end_sk)
> >> +    if (iter->cur_sk < iter->end_sk) {
> >>              sock_put(iter->batch[iter->cur_sk++]);
> >> +            ++state->offset;
> >> +    }
> >
> >>      /* After updating iter->cur_sk, check if there are more sockets
> >>       * available in the current bucket batch.
> >> @@ -3630,6 +3663,9 @@ static int bpf_iter_init_udp(void *priv_data, st=
ruct bpf_iter_aux_info *aux)
> >>      }
> >>      iter->cur_sk =3D 0;
> >>      iter->end_sk =3D 0;
> >> +    iter->st_bucket_done =3D false;
> >> +    st->bucket =3D 0;
> >> +    st->offset =3D 0;
> >
> >>      return ret;
> >>  }
> >> --
> >> 2.34.1
>
