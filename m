Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1BF576685
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 20:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiGOSCD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGOSB6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 14:01:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A626946D98
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:01:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mf4so10309553ejc.3
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rdwIRQ2ThREtAGl3hSYV6YG88raMa9LOsHuvMKnFgbc=;
        b=gYIpXOuRs+WH+xzlVNRo/IZUObdEF4Y0OWO8Pqusl1CUDDAjVxPgPCi2ZyCktAVuyR
         z+Ns7r8Jh+7+pvcsAf3M54/JOumO45yQv4OyLEF+bfU/brkQ8HXU7X/TB+4axh/WNAcb
         fy+7LiI6XQHEGkLYCDg/4sg5Xa3t4KXFMKBqfRYfolSGlumNtzs1poTHZInpgclPB+gK
         gvfhVdxgtydMCO8n5kREkuWTUpTuMSdurkeA4mMOTbZBmMVLStA7cJfHtPcmg+Wu/zGd
         0DoHL19vVg00veqaRFLJuaR7Z2EOB3BSroadSswEs6KhbWatTReIcHCsBFt9huMmD5AO
         is3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rdwIRQ2ThREtAGl3hSYV6YG88raMa9LOsHuvMKnFgbc=;
        b=JSJgXsq3F7hrlmhGAzzAeS16soeVG7iMobP0+SWHrNwV8FonIJ/Hc+bppt218Qo7k3
         TdH37Jm5tnEuD5Q1CD0URCzdJsfxvmdw6T9T8OGDg29GAbkuQPx5RO6ig+IpPHosVpFI
         XApxz6IDUudKtvUZzNWQv7mT7FLjaFYVtlNbQHU9AKV5iEFcZaQF7TnYxU5FkCGMBKrq
         yVUiQOdYK2naYOXoUOHLH/g0JvvqRXDkWybamyJyekqYi86K7cg5yHZt6qvtsQD99yAA
         2LtbLly2BL9V/9SAPPLy4bpVVyYC63vdkTm2WT88KvS7IFfE9jzs5WPIF2MwnPe4eKG3
         zsTw==
X-Gm-Message-State: AJIora8pi/TfSERmzbvyr9FvxmcJVyvhfbr27t0xEF8MTS/PKhpQbWUM
        o0fH9Pw/ZIx2dPPcn5jeXZGBIB8a2kTWXmknYU8=
X-Google-Smtp-Source: AGRyM1twTV3vnjYHbUjyizpZtNHlJalJECj/2LJsB8TWVYp1etE8hd/O560FoPvuSR4CwHSnlxSPr2IwKMGeEyZg1+s=
X-Received: by 2002:a17:907:a40f:b0:72b:64ee:5b2f with SMTP id
 sg15-20020a170907a40f00b0072b64ee5b2fmr15423273ejc.268.1657908114105; Fri, 15
 Jul 2022 11:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220713234529.4154673-1-davemarchevsky@fb.com>
 <CAP01T74k86cwBk22M=YgY=Vao196_wDezvmHjk5u_Nry98A6hQ@mail.gmail.com>
 <deb5310a-5ff5-0612-61f2-90d78a0bb147@fb.com> <CAP01T76iyDGvmWf1Sra153_3bQ1h5QpJm5NkgU9p31LyFUuuRQ@mail.gmail.com>
In-Reply-To: <CAP01T76iyDGvmWf1Sra153_3bQ1h5QpJm5NkgU9p31LyFUuuRQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 15 Jul 2022 11:01:43 -0700
Message-ID: <CAJnrk1ZmmSNMxMGwNwMKqLtv20uPFmVcFAay-EmD9j=SjuHfpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add kptr_xchg to may_be_acquire_function check
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 15, 2022 at 4:51 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 14 Jul 2022 at 19:33, Dave Marchevsky <davemarchevsky@fb.com> wro=
te:
> >
> > On 7/14/22 2:30 AM, Kumar Kartikeya Dwivedi wrote:
> > > On Thu, 14 Jul 2022 at 01:46, Dave Marchevsky <davemarchevsky@fb.com>=
 wrote:
> > >>
> > >> The may_be_acquire_function check is a weaker version of
> > >> is_acquire_function that only uses bpf_func_id to determine whether =
a
> > >> func may be acquiring a reference. Most funcs which acquire a refere=
nce
> > >> do so regardless of their input, so bpf_func_id is all that's necess=
ary
> > >> to make an accurate determination. However, map_lookup_elem only
> > >> acquires when operating on certain MAP_TYPEs, so commit 64d85290d79c
> > >> ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH") added th=
e
> > >> may_be check.
> > >>
> > >> Any helper which always acquires a reference should pass both
> > >> may_be_acquire_function and is_acquire_function checks. Recently-add=
ed
> > >> kptr_xchg passes the latter but not the former. This patch resolves =
this
> > >> discrepancy and does some refactoring such that the list of function=
s
> > >> which always acquire is in one place so future updates are in sync.
> > >>
> > >
> > > Thanks for the fix.
> > > I actually didn't add this on purpose, because the reason for using
> > > the may_be_acquire_function (in check_refcount_ok) doesn't apply to
> > > kptr_xchg, but maybe that was a poor choice on my part. I'm actually
> > > not sure of the need for may_be_acquire_function, and
> > > check_refcount_ok.
> > >
> > > Can we revisit why iit is needed? It only prevents
> > > ARG_PTR_TO_SOCK_COMMON (which is not the only arg type that may be
> > > refcounted) from being argument type of acquire functions. What is th=
e
> > > reason behind this? Should we rename arg_type_may_be_refcounted to a
> > > less confusing name? It probably only applies to socket lookup
> > > helpers.
> > >
> >
> > I'm just starting to dive into this reference acquire/release stuff, so=
 I was
> > also hoping someone could clarify the semantics here :).
> >
> > Seems like the purpose of check_refcount_ok is to 1) limit helpers to o=
ne
> > refcounted arg - currently determined by =EF=BB=BFarg_type_may_be_refco=
unted, which was
> > added as arg_type_is_refcounted in [0]; and 2) disallow helpers which a=
cquire
>
> I think this is already prevented in check_func_arg when it sees
> meta->ref_obj_id already set, which is the more correct way to do it
> instead of looking at argument types alone.

I think check_func_arg() checks against having multiple args that are
reference-acquired in the verifier (eg a ringbuf samples) whereas this
checks against having multiple args that are internally
reference-counted (eg pointers to sockets). I don't think an
internally-reference-counted object always has an acquired reference
in the verifier (eg the socket you get back from calling
bpf_tcp_sock()).

>
> > a reference from taking refcounted args. The reasoning behind 2) isn't =
clear to
> > me but my best guess based on [1] is that there's some delineation betw=
een
> > "helpers which cast a refcounted thing but don't acquire" and helpers t=
hat
> > acquire.
> >
> > Maybe we can add similar type tags to OBJ_RELEASE, which you added in
> > [2], to tag args which are casted in this manner and avoid hardcoding
> > ARG_PTR_TO_SOCK_COMMON. Or at least rename =EF=BB=BFarg_type_may_be_ref=
counted now that
> > other things may be refcounted but don't need similar casting treatment=
.
> >
>
> IMO there isn't any problem per se in an acquire function taking
> refcounted argument, so maybe it was just a precautionary check back
> then. I think the intention was that ARG_PTR_TO_SOCK_COMMON is never
> an argument type of an acquire function, but I don't know why. The
> commit [1] says:
>
> - check_refcount_ok() ensures is_acquire_function() cannot take
>   arg_type_may_be_refcounted() as its argument.
>
> Back then only socket lookup functions were acquire functions.
> Maybe Martin can shed some light as to why it was the case and whether
> this check is needed.
>
> >   [0]: fd978bf7fd31 ("bpf: Add reference tracking to verifier")
> >   [1]: 1b986589680a ("bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue r=
elated to bpf_sk_release")
> >   [2]: 8f14852e8911 ("bpf: Tag argument to be released in bpf_func_prot=
o")
> >
> > >> Fixes: c0a5a21c25f3 ("bpf: Allow storing referenced kptr in map")
> > >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > >> ---
> > >>
> > >> Sent to bpf-next instead of bpf as kptr_xchg not passing
> > >> may_be_acquire_function isn't currently breaking anything, just
> > >> logically inconsistent.
> > >>
> > >>  kernel/bpf/verifier.c | 33 +++++++++++++++++++++++----------
> > >>  1 file changed, 23 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >> index 26e7e787c20a..df4b923e77de 100644
> > >> --- a/kernel/bpf/verifier.c
> > >> +++ b/kernel/bpf/verifier.c
> > >> @@ -477,13 +477,30 @@ static bool type_may_be_null(u32 type)
> > >>         return type & PTR_MAYBE_NULL;
> > >>  }
> > >>
> > >> +/* These functions acquire a resource that must be later released
> > >> + * regardless of their input
> > >> + */
> > >> +static bool __check_function_always_acquires(enum bpf_func_id func_=
id)
> > >> +{
> > >> +       switch (func_id) {
> > >> +       case BPF_FUNC_sk_lookup_tcp:
> > >> +       case BPF_FUNC_sk_lookup_udp:
> > >> +       case BPF_FUNC_skc_lookup_tcp:
> > >> +       case BPF_FUNC_ringbuf_reserve:
> > >> +       case BPF_FUNC_kptr_xchg:
> > >> +               return true;
> > >> +       default:
> > >> +               return false;
> > >> +       }
> > >> +}
> > >> +
> > >>  static bool may_be_acquire_function(enum bpf_func_id func_id)
> > >>  {
> > >> -       return func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
> > >> -               func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
> > >> -               func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
> > >> -               func_id =3D=3D BPF_FUNC_map_lookup_elem ||
> > >> -               func_id =3D=3D BPF_FUNC_ringbuf_reserve;
> > >> +       /* See is_acquire_function for the conditions under which fu=
ncs
> > >> +        * not in __check_function_always_acquires acquire a resourc=
e
> > >> +        */
> > >> +       return __check_function_always_acquires(func_id) ||
> > >> +               func_id =3D=3D BPF_FUNC_map_lookup_elem;
> > >>  }
> > >>
> > >>  static bool is_acquire_function(enum bpf_func_id func_id,
> > >> @@ -491,11 +508,7 @@ static bool is_acquire_function(enum bpf_func_i=
d func_id,
> > >>  {
> > >>         enum bpf_map_type map_type =3D map ? map->map_type : BPF_MAP=
_TYPE_UNSPEC;
> > >>
> > >> -       if (func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
> > >> -           func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
> > >> -           func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
> > >> -           func_id =3D=3D BPF_FUNC_ringbuf_reserve ||
> > >> -           func_id =3D=3D BPF_FUNC_kptr_xchg)
> > >> +       if (__check_function_always_acquires(func_id))
> > >>                 return true;
> > >>
> > >>         if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
> > >> --
> > >> 2.30.2
> > >>
