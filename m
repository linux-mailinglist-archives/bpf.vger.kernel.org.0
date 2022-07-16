Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06F157717A
	for <lists+bpf@lfdr.de>; Sat, 16 Jul 2022 23:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGPVBG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Jul 2022 17:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPVBG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Jul 2022 17:01:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2450167CD
        for <bpf@vger.kernel.org>; Sat, 16 Jul 2022 14:01:04 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l24so6439672ion.13
        for <bpf@vger.kernel.org>; Sat, 16 Jul 2022 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0B6VvUam32Ee8jShgYFwdNCMk++jfIBgYD5Mgg9VTvM=;
        b=css7/5RKixy2lpug0Pc7Xo+zJjfShRBMHS957uGS7E8r2M5MoC0qcZ7jG7dlnlLWIU
         0HdxSP6HaibHUHNt5iC4GrkPjA+uShg1+qszY/OFqlnT/yT2BdDzPFDlD8KQGsmdmZxR
         DYq6Nyvqty6eV5kuMDgjqQZHDXPqUQUDW6+7ei8DXXTx/LwCwdU+bNnxHule26llQ1Yj
         pyb5K0L3smaKLvvF7vRiOyfl7bY2Ep/8df0xSx2SSRehswMC0iZvjn0STY/0nH7Kj91U
         qM3lJztFM4kOC/xdsHWoSqZTkyIhu8LN9LgbigMO/OPQaYcpVbhIZXb9OcG/iY/CiIm8
         uNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0B6VvUam32Ee8jShgYFwdNCMk++jfIBgYD5Mgg9VTvM=;
        b=UzWCbDKbdH9yZ2beRcPjABh4fjaJZ0RcGT4L2XGeg6+/TLNQOR88cRnv84E7G34xqj
         L3zxsD7lwmS0vL5OzwPJtPDIC1bFSepQWp4xYaPzTijGMCVbJBYFMhI6R487twNV3bxD
         2lSWMpW59DPU2hD5mZw7XogVNivaTbCrgQR2nG02z3KrToq2/b29CqH4/QI8PnxjfmIB
         /JfT1OFWjHcDZdCBcSGigmjCZrfwq6dSgaYuykNykGGuurOYrxNalKx2mlMYkg+oBBws
         XnQRMI2gv0ND23YF8TfN4Bq3W69XZU8Q87wvtPFLZIcZccf7H2eT8iyJpm98xi+05pMh
         3Mfg==
X-Gm-Message-State: AJIora84kCIsva6qG2lKjNz1+O78vGIf75oXs3VT20PdIVRqbZIfT1wI
        MIM8srIPyFTeXv6+5pRwr31VjDg3t5c8/CPbQWkIZDbUHNU=
X-Google-Smtp-Source: AGRyM1sMPEZi6irvvBki2+QuWpBK7gfmDY1As/Ne/poKMtCG/gl1VzyrW87cFo3J2lDfz+3ddi9SZ+88dNtlqabd+Qo=
X-Received: by 2002:a05:6638:210b:b0:33f:5635:4c4b with SMTP id
 n11-20020a056638210b00b0033f56354c4bmr11558668jaj.116.1658005264254; Sat, 16
 Jul 2022 14:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220713234529.4154673-1-davemarchevsky@fb.com>
 <CAP01T74k86cwBk22M=YgY=Vao196_wDezvmHjk5u_Nry98A6hQ@mail.gmail.com>
 <deb5310a-5ff5-0612-61f2-90d78a0bb147@fb.com> <CAP01T76iyDGvmWf1Sra153_3bQ1h5QpJm5NkgU9p31LyFUuuRQ@mail.gmail.com>
 <CAJnrk1ZmmSNMxMGwNwMKqLtv20uPFmVcFAay-EmD9j=SjuHfpg@mail.gmail.com>
In-Reply-To: <CAJnrk1ZmmSNMxMGwNwMKqLtv20uPFmVcFAay-EmD9j=SjuHfpg@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 16 Jul 2022 23:00:26 +0200
Message-ID: <CAP01T74YbdXKQy_jMzR7FpYxjdBzNnZD9f60Po1v6J_p=vr6cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add kptr_xchg to may_be_acquire_function check
To:     Joanne Koong <joannelkoong@gmail.com>
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

On Fri, 15 Jul 2022 at 20:01, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Fri, Jul 15, 2022 at 4:51 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Thu, 14 Jul 2022 at 19:33, Dave Marchevsky <davemarchevsky@fb.com> w=
rote:
> > >
> > > On 7/14/22 2:30 AM, Kumar Kartikeya Dwivedi wrote:
> > > > On Thu, 14 Jul 2022 at 01:46, Dave Marchevsky <davemarchevsky@fb.co=
m> wrote:
> > > >>
> > > >> The may_be_acquire_function check is a weaker version of
> > > >> is_acquire_function that only uses bpf_func_id to determine whethe=
r a
> > > >> func may be acquiring a reference. Most funcs which acquire a refe=
rence
> > > >> do so regardless of their input, so bpf_func_id is all that's nece=
ssary
> > > >> to make an accurate determination. However, map_lookup_elem only
> > > >> acquires when operating on certain MAP_TYPEs, so commit 64d85290d7=
9c
> > > >> ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH") added =
the
> > > >> may_be check.
> > > >>
> > > >> Any helper which always acquires a reference should pass both
> > > >> may_be_acquire_function and is_acquire_function checks. Recently-a=
dded
> > > >> kptr_xchg passes the latter but not the former. This patch resolve=
s this
> > > >> discrepancy and does some refactoring such that the list of functi=
ons
> > > >> which always acquire is in one place so future updates are in sync=
.
> > > >>
> > > >
> > > > Thanks for the fix.
> > > > I actually didn't add this on purpose, because the reason for using
> > > > the may_be_acquire_function (in check_refcount_ok) doesn't apply to
> > > > kptr_xchg, but maybe that was a poor choice on my part. I'm actuall=
y
> > > > not sure of the need for may_be_acquire_function, and
> > > > check_refcount_ok.
> > > >
> > > > Can we revisit why iit is needed? It only prevents
> > > > ARG_PTR_TO_SOCK_COMMON (which is not the only arg type that may be
> > > > refcounted) from being argument type of acquire functions. What is =
the
> > > > reason behind this? Should we rename arg_type_may_be_refcounted to =
a
> > > > less confusing name? It probably only applies to socket lookup
> > > > helpers.
> > > >
> > >
> > > I'm just starting to dive into this reference acquire/release stuff, =
so I was
> > > also hoping someone could clarify the semantics here :).
> > >
> > > Seems like the purpose of check_refcount_ok is to 1) limit helpers to=
 one
> > > refcounted arg - currently determined by =EF=BB=BFarg_type_may_be_ref=
counted, which was
> > > added as arg_type_is_refcounted in [0]; and 2) disallow helpers which=
 acquire
> >
> > I think this is already prevented in check_func_arg when it sees
> > meta->ref_obj_id already set, which is the more correct way to do it
> > instead of looking at argument types alone.
>
> I think check_func_arg() checks against having multiple args that are
> reference-acquired in the verifier (eg a ringbuf samples) whereas this
> checks against having multiple args that are internally
> reference-counted (eg pointers to sockets). I don't think an
> internally-reference-counted object always has an acquired reference
> in the verifier (eg the socket you get back from calling
> bpf_tcp_sock()).
>

Makes sense, since some candidates of ARG_PTR_TO_SOCK_COMMON may not
have reference state in the verifier (skb->sk is one example in the
commit message), but I don't get why those not having a reference
state in the verifier have to be limited. If this is needed and
specific to the socket types, then the check should probably be
renamed now since things have changed after it was added (back then
only socket lookup functions were acquire functions). Otherwise it
should just be dropped.


> >
> > > a reference from taking refcounted args. The reasoning behind 2) isn'=
t clear to
> > > me but my best guess based on [1] is that there's some delineation be=
tween
> > > "helpers which cast a refcounted thing but don't acquire" and helpers=
 that
> > > acquire.
> > >
> > > Maybe we can add similar type tags to OBJ_RELEASE, which you added in
> > > [2], to tag args which are casted in this manner and avoid hardcoding
> > > ARG_PTR_TO_SOCK_COMMON. Or at least rename =EF=BB=BFarg_type_may_be_r=
efcounted now that
> > > other things may be refcounted but don't need similar casting treatme=
nt.
> > >
> >
> > IMO there isn't any problem per se in an acquire function taking
> > refcounted argument, so maybe it was just a precautionary check back
> > then. I think the intention was that ARG_PTR_TO_SOCK_COMMON is never
> > an argument type of an acquire function, but I don't know why. The
> > commit [1] says:
> >
> > - check_refcount_ok() ensures is_acquire_function() cannot take
> >   arg_type_may_be_refcounted() as its argument.
> >
> > Back then only socket lookup functions were acquire functions.
> > Maybe Martin can shed some light as to why it was the case and whether
> > this check is needed.
> >
> > >   [0]: fd978bf7fd31 ("bpf: Add reference tracking to verifier")
> > >   [1]: 1b986589680a ("bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue=
 related to bpf_sk_release")
> > >   [2]: 8f14852e8911 ("bpf: Tag argument to be released in bpf_func_pr=
oto")
> > >
> > > >> Fixes: c0a5a21c25f3 ("bpf: Allow storing referenced kptr in map")
> > > >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > >> ---
> > > >>
> > > >> Sent to bpf-next instead of bpf as kptr_xchg not passing
> > > >> may_be_acquire_function isn't currently breaking anything, just
> > > >> logically inconsistent.
> > > >>
> > > >>  kernel/bpf/verifier.c | 33 +++++++++++++++++++++++----------
> > > >>  1 file changed, 23 insertions(+), 10 deletions(-)
> > > >>
> > > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > >> index 26e7e787c20a..df4b923e77de 100644
> > > >> --- a/kernel/bpf/verifier.c
> > > >> +++ b/kernel/bpf/verifier.c
> > > >> @@ -477,13 +477,30 @@ static bool type_may_be_null(u32 type)
> > > >>         return type & PTR_MAYBE_NULL;
> > > >>  }
> > > >>
> > > >> +/* These functions acquire a resource that must be later released
> > > >> + * regardless of their input
> > > >> + */
> > > >> +static bool __check_function_always_acquires(enum bpf_func_id fun=
c_id)
> > > >> +{
> > > >> +       switch (func_id) {
> > > >> +       case BPF_FUNC_sk_lookup_tcp:
> > > >> +       case BPF_FUNC_sk_lookup_udp:
> > > >> +       case BPF_FUNC_skc_lookup_tcp:
> > > >> +       case BPF_FUNC_ringbuf_reserve:
> > > >> +       case BPF_FUNC_kptr_xchg:
> > > >> +               return true;
> > > >> +       default:
> > > >> +               return false;
> > > >> +       }
> > > >> +}
> > > >> +
> > > >>  static bool may_be_acquire_function(enum bpf_func_id func_id)
> > > >>  {
> > > >> -       return func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
> > > >> -               func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
> > > >> -               func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
> > > >> -               func_id =3D=3D BPF_FUNC_map_lookup_elem ||
> > > >> -               func_id =3D=3D BPF_FUNC_ringbuf_reserve;
> > > >> +       /* See is_acquire_function for the conditions under which =
funcs
> > > >> +        * not in __check_function_always_acquires acquire a resou=
rce
> > > >> +        */
> > > >> +       return __check_function_always_acquires(func_id) ||
> > > >> +               func_id =3D=3D BPF_FUNC_map_lookup_elem;
> > > >>  }
> > > >>
> > > >>  static bool is_acquire_function(enum bpf_func_id func_id,
> > > >> @@ -491,11 +508,7 @@ static bool is_acquire_function(enum bpf_func=
_id func_id,
> > > >>  {
> > > >>         enum bpf_map_type map_type =3D map ? map->map_type : BPF_M=
AP_TYPE_UNSPEC;
> > > >>
> > > >> -       if (func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
> > > >> -           func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
> > > >> -           func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
> > > >> -           func_id =3D=3D BPF_FUNC_ringbuf_reserve ||
> > > >> -           func_id =3D=3D BPF_FUNC_kptr_xchg)
> > > >> +       if (__check_function_always_acquires(func_id))
> > > >>                 return true;
> > > >>
> > > >>         if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
> > > >> --
> > > >> 2.30.2
> > > >>
