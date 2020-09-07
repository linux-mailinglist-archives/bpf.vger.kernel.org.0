Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D7825F5C7
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 10:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgIGI5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 04:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgIGI5U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 04:57:20 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5778C061573
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 01:57:19 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t76so12961448oif.7
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 01:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rZwqZuWU+idY8p1gVUzMuyhMd4eBLh7Qt7rrWHUZuU=;
        b=rGIGzkI+P74Wp6CkJJ/OqePEn+7arx805fjI6iGwoa2vQpmBWrZylDsV4KYuor2qOE
         +ZVp+581BPHdH0zZzLahxtaCmAlBtw+9xPFmOc7L4qfwoM2MJxQHr/+oFv4WePJ3K1mH
         JW2dyVPzF4hysOp1DrHFSOKC6L8oYWzjlX2s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rZwqZuWU+idY8p1gVUzMuyhMd4eBLh7Qt7rrWHUZuU=;
        b=bw9GKDEeqq+ti/GzjYyN622K5UP5QW96p2utAn3HsjP1YTkZ7qsanp0ttvLCPDG2N0
         qs0D7/VNAKmKV7l17EwjDh69TgcG0v/rjcSrksr2AbXi+53JK8XD7SCOjoKPOJHxZZaL
         p2r7qdaHOUxyKMqi0ge/EjC8evLjlGwnBnNI89KL1Fh20siKkaSd2zOg1aTFnk1pLYfu
         k8op7dTsR+AMp6bQbd/Rty8SePubynF2YXAwITzdutHLI1oZz23Vg4/4ZCGGTAgWnGOC
         2KXiMLrd4gDjTj7FTlX6+bzI+S/VrlPmwzhLNtvC7SYqry88Do54UuiQX1aHOsnqt3+M
         vLIQ==
X-Gm-Message-State: AOAM5332vuhjnBl0m4pGKqTVS/u6zzIUB5LS4ik0NI3TM+ml7Ej5fPqJ
        GTkoaeG0R7Tk4pf0SgyMQoV5N76C+oZgCbO3/UVzcw==
X-Google-Smtp-Source: ABdhPJwsIWgyCFd2NjXxYMQyVV9nBRLoGtfxHxu8IyGZz9jVmmJwSEkRKzKkCWmEMu24oJtmVROe/wePybhKsnv7BwY=
X-Received: by 2002:aca:f0a:: with SMTP id 10mr6516518oip.13.1599469037944;
 Mon, 07 Sep 2020 01:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200904095904.612390-1-lmb@cloudflare.com> <20200904095904.612390-2-lmb@cloudflare.com>
 <20200906224008.fph4frjkkegs6w3b@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200906224008.fph4frjkkegs6w3b@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 7 Sep 2020 09:57:06 +0100
Message-ID: <CACAyw9-ftMBnoqOt_0dhir+Y=2EW4iLsh=LYSH78hEF=STA1iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Allow passing BTF pointers as PTR_TO_SOCKET
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 6 Sep 2020 at 23:40, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Sep 04, 2020 at 10:58:59AM +0100, Lorenz Bauer wrote:
> > Tracing programs can derive struct sock pointers from a variety
> > of sources, e.g. a bpf_iter for sk_storage maps receives one as
> > part of the context. It's desirable to be able to pass these to
> > functions that expect PTR_TO_SOCKET. For example, it enables us
> > to insert such a socket into a sockmap via map_elem_update.
> >
> > Teach the verifier that a PTR_TO_BTF_ID for a struct sock is
> > equivalent to PTR_TO_SOCKET. There is one hazard here:
> > bpf_sk_release also takes a PTR_TO_SOCKET, but expects it to be
> > refcounted. Since this isn't the case for pointers derived from
> > BTF we must prevent them from being passed to the function.
> > Luckily, we can simply check that the ref_obj_id is not zero
> > in release_reference, and return an error otherwise.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >  kernel/bpf/verifier.c | 61 +++++++++++++++++++++++++------------------
> >  1 file changed, 36 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b4e9c56b8b32..509754c3aa7d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3908,6 +3908,9 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
> >       return 0;
> >  }
> >
> > +BTF_ID_LIST(btf_fullsock_ids)
> > +BTF_ID(struct, sock)
> It may be fine for the sockmap iter case to treat the "struct sock" BTF_ID
> as a fullsock (i.e. PTR_TO_SOCKET).

I think it's unsafe even for the sockmap iter. Since it's a tracing
prog there might
be other ways for it to obtain a struct sock * in the future.

> This is a generic verifier change though.  For tracing, it is not always the
> case.  It cannot always assume that the "struct sock *" in the function being
> traced is always a fullsock.

Yes, I see, thanks for reminding me. What a footgun. I think the
problem boils down
to the fact that we can't express "this is a full socket" in BTF,
since there is no such
type in the kernel.

Which makes me wonder: how do tracing programs deal with struct sock*
that really
is a request sock or something?

> Currently, the func_proto taking ARG_PTR_TO_SOCKET can safely
> assume it must be a fullsock.  If it is allowed to also take BTF_ID
> "struct sock" in verification time,  I think the sk_fullsock()
> check in runtime is needed and this check should be pretty
> cheap to do.

Can you elaborate a little? Where do you think the check could happen?

I could change the patch to treat struct sock * as PTR_TO_SOCK_COMMON,
and adjust the sockmap helpers accordingly. The implication is that
over time, helpers will migrate to PTR_TO_SOCK_COMMON because that is
compatible with BTF. PTR_TO_SOCKET will become unused except to
maintain the ABI for access to struct bpf_sock. Maybe that's OK
though?

> > +
> >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         struct bpf_call_arg_meta *meta,
> >                         const struct bpf_func_proto *fn)
> > @@ -4000,37 +4003,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               expected_type = PTR_TO_SOCKET;
> >               if (!(register_is_null(reg) &&
> >                     arg_type == ARG_PTR_TO_SOCKET_OR_NULL)) {
> > -                     if (type != expected_type)
> > +                     if (type != expected_type &&
> > +                         type != PTR_TO_BTF_ID)
> >                               goto err_type;
> >               }
> > +             meta->btf_id = btf_fullsock_ids[0];
> >       } else if (arg_type == ARG_PTR_TO_BTF_ID) {
> > -             bool ids_match = false;
> > -
> >               expected_type = PTR_TO_BTF_ID;
> >               if (type != expected_type)
> >                       goto err_type;
> > -             if (!fn->check_btf_id) {
> > -                     if (reg->btf_id != meta->btf_id) {
> > -                             ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> > -                                                              meta->btf_id);
> > -                             if (!ids_match) {
> > -                                     verbose(env, "Helper has type %s got %s in R%d\n",
> > -                                             kernel_type_name(meta->btf_id),
> > -                                             kernel_type_name(reg->btf_id), regno);
> > -                                     return -EACCES;
> > -                             }
> > -                     }
> > -             } else if (!fn->check_btf_id(reg->btf_id, arg)) {
> > -                     verbose(env, "Helper does not support %s in R%d\n",
> > -                             kernel_type_name(reg->btf_id), regno);
> > -
> > -                     return -EACCES;
> > -             }
> > -             if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
> > -                     verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
> > -                             regno);
> > -                     return -EACCES;
> > -             }
> >       } else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
> >               if (meta->func_id == BPF_FUNC_spin_lock) {
> >                       if (process_spin_lock(env, regno, true))
> > @@ -4085,6 +4066,33 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               return -EFAULT;
> >       }
> >
> > +     if (type == PTR_TO_BTF_ID) {
> > +             bool ids_match = false;
> > +
> > +             if (!fn->check_btf_id) {
> > +                     if (reg->btf_id != meta->btf_id) {
> > +                             ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> > +                                                              meta->btf_id);
> > +                             if (!ids_match) {
> > +                                     verbose(env, "Helper has type %s got %s in R%d\n",
> > +                                             kernel_type_name(meta->btf_id),
> > +                                             kernel_type_name(reg->btf_id), regno);
> > +                                     return -EACCES;
> > +                             }
> > +                     }
> > +             } else if (!fn->check_btf_id(reg->btf_id, arg)) {
> > +                     verbose(env, "Helper does not support %s in R%d\n",
> > +                             kernel_type_name(reg->btf_id), regno);
> > +
> > +                     return -EACCES;
> > +             }
> > +             if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
> > +                     verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
> > +                             regno);
> > +                     return -EACCES;
> > +             }
> > +     }
> > +
> >       if (arg_type == ARG_CONST_MAP_PTR) {
> >               /* bpf_map_xxx(map_ptr) call: remember that map_ptr */
> >               meta->map_ptr = reg->map_ptr;
> > @@ -4561,6 +4569,9 @@ static int release_reference(struct bpf_verifier_env *env,
> >       int err;
> >       int i;
> >
> > +     if (!ref_obj_id)
> > +             return -EINVAL;
> hmm...... Is it sure this is needed?  If it was, it seems there was
> an existing bug in release_reference_state() below which could not catch
> the case where "bpf_sk_release()" is called on a pointer that has no
> reference acquired before.

Since sk_release takes a PTR_TO_SOCKET, it's possible to pass a tracing
struct sock * to it after this patch. Adding this check prevents the
release from
succeeding.

>
> Can you write a verifier test to demonstrate the issue?

There is a selftest in this series that ensures calling sk_release
doesn't work, which exercises this.

>
> > +
> >       err = release_reference_state(cur_func(env), ref_obj_id);
> >       if (err)
> >               return err;
> > --
> > 2.25.1
> >



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
