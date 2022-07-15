Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ED95760DF
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiGOLuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 07:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiGOLuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 07:50:07 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EDC3CBE9
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 04:50:06 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c16so1159570ils.7
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+x8tfdMY5+Rdzn1sf1op++o5iSf0K0Dqk1Yae/BD6kA=;
        b=BdIA8U1SXCZTP8j5A8xBjYMjK2290KQU3uwmzk8T5DMbir2UBluvp+yzPnL7Lv5PK1
         udg/ok4P+Z6M976Q8c08uWbxhk+/tHoqscBWb2sEfcc+5xXS+1jXuF6YhoibBw9viQiy
         j3hFtSzCoKHB7f2apcZXYEG0Cprj0lnADYYI+1cZ/6Nn8xQDiOpHC65m3ucvqr59BFjg
         EAq/4ZPxKMDNT0rna+6+kwikA5VtokViK9Iq6bOzqfcF8W3SYk9oqc0S41qso0j9dtqs
         w/odz3+UFxJUHOWyiSamuuETmp1XYhxIQHjm8Qp9TMADMsONQtKyfX4puPyekaluoogr
         5AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+x8tfdMY5+Rdzn1sf1op++o5iSf0K0Dqk1Yae/BD6kA=;
        b=nI9Ve4bJrtRKYCbB9PM3FWubOK896YF43RyLQW6NcVVoV7HjUpeE0MMKOEBHatjCvV
         V18FSydjSKWRAt4jL7Cq3pp8GxX7oUQzYgzhj4pn0NXwC7rLvgIzQwDl7DZ/6k9DZHq/
         x94RYrcFVXq6BNxuE+8fxUcl/0TNrNL/L4bl1hLOd8OcVaRQGrFQG1X15yp8p1wTOsT2
         mjPGzR7XlP8iuWGEQo8hXKlb5/srlPmPJtarb7eCuqY0xK600u3gve9hoHYSNuV59v9T
         BCunkfCmAmvQCnOE4YXWexrIdOgxoHihnxW/p+6dTJdXJ8zAcbsoaPQUeq4wkeHIGlfS
         ftCg==
X-Gm-Message-State: AJIora8q+0JCIgL7/jGdk+7cufg5ju1zfGDENONHLj/vFAc+8hTrCEQI
        VuqIgDckvVwuPyCZXQ2fm2H9L729qGibTOf3TEE=
X-Google-Smtp-Source: AGRyM1tYIwwPmZkbuPb1dDN9N1cc2/V0LrMUH7NkBgQuqA7SC5cKrW5fqwMIgSJb+8CAPGKcxYJesAm4amo5vXPZ8tE=
X-Received: by 2002:a05:6e02:1c08:b0:2dc:bd57:f80a with SMTP id
 l8-20020a056e021c0800b002dcbd57f80amr1887494ilh.68.1657885806016; Fri, 15 Jul
 2022 04:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220713234529.4154673-1-davemarchevsky@fb.com>
 <CAP01T74k86cwBk22M=YgY=Vao196_wDezvmHjk5u_Nry98A6hQ@mail.gmail.com> <deb5310a-5ff5-0612-61f2-90d78a0bb147@fb.com>
In-Reply-To: <deb5310a-5ff5-0612-61f2-90d78a0bb147@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 15 Jul 2022 13:49:28 +0200
Message-ID: <CAP01T76iyDGvmWf1Sra153_3bQ1h5QpJm5NkgU9p31LyFUuuRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add kptr_xchg to may_be_acquire_function check
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, kafai@fb.com
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

On Thu, 14 Jul 2022 at 19:33, Dave Marchevsky <davemarchevsky@fb.com> wrote=
:
>
> On 7/14/22 2:30 AM, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 14 Jul 2022 at 01:46, Dave Marchevsky <davemarchevsky@fb.com> w=
rote:
> >>
> >> The may_be_acquire_function check is a weaker version of
> >> is_acquire_function that only uses bpf_func_id to determine whether a
> >> func may be acquiring a reference. Most funcs which acquire a referenc=
e
> >> do so regardless of their input, so bpf_func_id is all that's necessar=
y
> >> to make an accurate determination. However, map_lookup_elem only
> >> acquires when operating on certain MAP_TYPEs, so commit 64d85290d79c
> >> ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH") added the
> >> may_be check.
> >>
> >> Any helper which always acquires a reference should pass both
> >> may_be_acquire_function and is_acquire_function checks. Recently-added
> >> kptr_xchg passes the latter but not the former. This patch resolves th=
is
> >> discrepancy and does some refactoring such that the list of functions
> >> which always acquire is in one place so future updates are in sync.
> >>
> >
> > Thanks for the fix.
> > I actually didn't add this on purpose, because the reason for using
> > the may_be_acquire_function (in check_refcount_ok) doesn't apply to
> > kptr_xchg, but maybe that was a poor choice on my part. I'm actually
> > not sure of the need for may_be_acquire_function, and
> > check_refcount_ok.
> >
> > Can we revisit why iit is needed? It only prevents
> > ARG_PTR_TO_SOCK_COMMON (which is not the only arg type that may be
> > refcounted) from being argument type of acquire functions. What is the
> > reason behind this? Should we rename arg_type_may_be_refcounted to a
> > less confusing name? It probably only applies to socket lookup
> > helpers.
> >
>
> I'm just starting to dive into this reference acquire/release stuff, so I=
 was
> also hoping someone could clarify the semantics here :).
>
> Seems like the purpose of check_refcount_ok is to 1) limit helpers to one
> refcounted arg - currently determined by =EF=BB=BFarg_type_may_be_refcoun=
ted, which was
> added as arg_type_is_refcounted in [0]; and 2) disallow helpers which acq=
uire

I think this is already prevented in check_func_arg when it sees
meta->ref_obj_id already set, which is the more correct way to do it
instead of looking at argument types alone.

> a reference from taking refcounted args. The reasoning behind 2) isn't cl=
ear to
> me but my best guess based on [1] is that there's some delineation betwee=
n
> "helpers which cast a refcounted thing but don't acquire" and helpers tha=
t
> acquire.
>
> Maybe we can add similar type tags to OBJ_RELEASE, which you added in
> [2], to tag args which are casted in this manner and avoid hardcoding
> ARG_PTR_TO_SOCK_COMMON. Or at least rename =EF=BB=BFarg_type_may_be_refco=
unted now that
> other things may be refcounted but don't need similar casting treatment.
>

IMO there isn't any problem per se in an acquire function taking
refcounted argument, so maybe it was just a precautionary check back
then. I think the intention was that ARG_PTR_TO_SOCK_COMMON is never
an argument type of an acquire function, but I don't know why. The
commit [1] says:

- check_refcount_ok() ensures is_acquire_function() cannot take
  arg_type_may_be_refcounted() as its argument.

Back then only socket lookup functions were acquire functions.
Maybe Martin can shed some light as to why it was the case and whether
this check is needed.

>   [0]: fd978bf7fd31 ("bpf: Add reference tracking to verifier")
>   [1]: 1b986589680a ("bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue rel=
ated to bpf_sk_release")
>   [2]: 8f14852e8911 ("bpf: Tag argument to be released in bpf_func_proto"=
)
>
> >> Fixes: c0a5a21c25f3 ("bpf: Allow storing referenced kptr in map")
> >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >> ---
> >>
> >> Sent to bpf-next instead of bpf as kptr_xchg not passing
> >> may_be_acquire_function isn't currently breaking anything, just
> >> logically inconsistent.
> >>
> >>  kernel/bpf/verifier.c | 33 +++++++++++++++++++++++----------
> >>  1 file changed, 23 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 26e7e787c20a..df4b923e77de 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -477,13 +477,30 @@ static bool type_may_be_null(u32 type)
> >>         return type & PTR_MAYBE_NULL;
> >>  }
> >>
> >> +/* These functions acquire a resource that must be later released
> >> + * regardless of their input
> >> + */
> >> +static bool __check_function_always_acquires(enum bpf_func_id func_id=
)
> >> +{
> >> +       switch (func_id) {
> >> +       case BPF_FUNC_sk_lookup_tcp:
> >> +       case BPF_FUNC_sk_lookup_udp:
> >> +       case BPF_FUNC_skc_lookup_tcp:
> >> +       case BPF_FUNC_ringbuf_reserve:
> >> +       case BPF_FUNC_kptr_xchg:
> >> +               return true;
> >> +       default:
> >> +               return false;
> >> +       }
> >> +}
> >> +
> >>  static bool may_be_acquire_function(enum bpf_func_id func_id)
> >>  {
> >> -       return func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
> >> -               func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
> >> -               func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
> >> -               func_id =3D=3D BPF_FUNC_map_lookup_elem ||
> >> -               func_id =3D=3D BPF_FUNC_ringbuf_reserve;
> >> +       /* See is_acquire_function for the conditions under which func=
s
> >> +        * not in __check_function_always_acquires acquire a resource
> >> +        */
> >> +       return __check_function_always_acquires(func_id) ||
> >> +               func_id =3D=3D BPF_FUNC_map_lookup_elem;
> >>  }
> >>
> >>  static bool is_acquire_function(enum bpf_func_id func_id,
> >> @@ -491,11 +508,7 @@ static bool is_acquire_function(enum bpf_func_id =
func_id,
> >>  {
> >>         enum bpf_map_type map_type =3D map ? map->map_type : BPF_MAP_T=
YPE_UNSPEC;
> >>
> >> -       if (func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
> >> -           func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
> >> -           func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
> >> -           func_id =3D=3D BPF_FUNC_ringbuf_reserve ||
> >> -           func_id =3D=3D BPF_FUNC_kptr_xchg)
> >> +       if (__check_function_always_acquires(func_id))
> >>                 return true;
> >>
> >>         if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
> >> --
> >> 2.30.2
> >>
