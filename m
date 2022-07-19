Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1074F579251
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 07:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiGSFJU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 01:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSFJT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 01:09:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92097B84E
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 22:09:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy29so23917337ejc.12
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bUw2JNWre1Aw1BgDXTdgz8c59obHhlOX5jvgbBiuVmk=;
        b=RH6ztZvUfCamkDigg5oDDk4H3PKO6I1ChvPTeloFvasoRoWLO4xEwtFfmdQeBRGWsV
         jwK4UpMUQsb19otsxSJDld2Ci5nd1Zfb6uUVzqbZjVKh9jJza8W/EgGkJSCSFu1zKOJe
         Q5VyDM6agmjwNSnOgHHvlpAeK6LDszIMjJL/H6LyjsNGneSL8BD5pahyyaS55APF8fTH
         Hs0XdkgjYSQ4eniTO0dTVnx30C/ZBx/vctz5rRcU/vreTwmC2iMchyta+HfsuqbtxbeS
         +GX5ekF66HqUzGvReIU04+2kKWviW80vAEZbFkXMQn1q7WTgZlAT8EUboJ6dObLS6n5z
         wIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bUw2JNWre1Aw1BgDXTdgz8c59obHhlOX5jvgbBiuVmk=;
        b=EjAZ72yEe6snizECANnrZ1vN3BzrCP7/2aexSNQDpIQQEPgkoD0PcxdKogLTxE2Imf
         g1OqDP9Ta2gav8iK7WEiu3gSGlI3pf1eNCC2yiWxmn+nMYFF54kLjrLkNg244cFm24MA
         X+D80QRggUvvqFnIWEDUeyehO+5L6Vw8U6j7svr+hWJSB9Rcen49fV34cvVtkKc/fJVy
         wS0F2IDm03ti37sMGAnRb7PRpKL81Xxfo88nm/M3me2sz0+XWl8uFlU4DfoSswFOS2LA
         9L1x9lDta0dlhPka2acgLEFcjAAZgjk0GDLlnF3ZJKJT3fWwb5aRzZuYzoacNa92TMpb
         uNPw==
X-Gm-Message-State: AJIora9cmpy4h5HBMGhavPDf0jQt/gx2P2ye8CIZox8Pzq48oWXtjlYP
        FksuCc0Am5OUBdQoMOehWNIUzeg8VQLtxFTxCE4=
X-Google-Smtp-Source: AGRyM1s2+/Rdd3n+9Xs/aZvb1cXpk4F59nlC5IkjulqpbpYwVvKwICWosaZLNAO9Q2+p9WnGcbdkKl4SI5XVx4u1t28=
X-Received: by 2002:a17:907:6e02:b0:72b:9f16:1bc5 with SMTP id
 sd2-20020a1709076e0200b0072b9f161bc5mr28857889ejc.676.1658207357015; Mon, 18
 Jul 2022 22:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220713234529.4154673-1-davemarchevsky@fb.com>
 <CAP01T74k86cwBk22M=YgY=Vao196_wDezvmHjk5u_Nry98A6hQ@mail.gmail.com>
 <deb5310a-5ff5-0612-61f2-90d78a0bb147@fb.com> <CAP01T76iyDGvmWf1Sra153_3bQ1h5QpJm5NkgU9p31LyFUuuRQ@mail.gmail.com>
 <20220719003609.5yfchxkbxuyonir6@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220719003609.5yfchxkbxuyonir6@kafai-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 18 Jul 2022 22:09:05 -0700
Message-ID: <CAADnVQLXdg0V7GcqZ3xwiw+zokMO=goCzLQi6aC+Rh4rsyHqkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add kptr_xchg to may_be_acquire_function check
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Jul 18, 2022 at 5:36 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jul 15, 2022 at 01:49:28PM +0200, Kumar Kartikeya Dwivedi wrote:
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
> Trying to recall from the log history.
>
> I believe {is,may_be}_acquire_function() in check_refcount_ok() was for
> pre-cautionary.  At that time, in check_helper_call(),
> regs[BPF_REG_0].ref_obj_id was handled for is_acquire_function() first
> before is_ptr_cast_function().  If somehow a func proto could do
> both 'acquire' and 'ptr_cast',  the ref_obj_id tracking will break.
> May be a better check was to ensure a func cannot be both acquire and
> ptr_cast.  This ordering in check_helper_call() is reversed now though,
> so I think may_be_acquire_function() can be removed from check_refcount_o=
k().

Makes sense to me. Let's do that instead.

> Regarding to the original 'return count <=3D 1' check in check_refcount_o=
k(),
> I believe the idea was to ensure the release func_proto only takes one
> arg that is refcnt-ed.  [bpf_sk_release was the only release func proto].
> Otherwise,  if a release func can take two args that could have ref_obj_i=
d,
> the meta->ref_obj_id tracking will not work.  Think about only one of the=
m
> has ref_obj_id and it is not the arg that the func proto is actually rele=
asing.
> Since there is OBJ_RELEASE now and sk is not the only refcnt type,
> check_refcount_ok() may as well count by OBJ_RELEASE instead of
> arg-type.

+1. It also would be a good cleanup.
