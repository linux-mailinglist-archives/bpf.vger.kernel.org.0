Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9251E208
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 01:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352354AbiEFWuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 18:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbiEFWuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 18:50:14 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA8659F
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 15:46:30 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f5so5676693ilj.13
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNv3HODdoQMG20zX099pZsdylxjGh3aKuM4EMRY7SNI=;
        b=MO/NNFH2Kg7JbgKj0Pi3eSJYvZkG1wTE8hRvTV1ILIb63wdFhW+bvG2UmPIXIzz3Wo
         j8QKhrc8iHIajLkwcpPK1GBlb8vBOuMudSSLEl8jNhib3j8cci2ScZjt4KbZ36g/doVX
         iBMwZAdVm6cCKx3T3bIlJOChklk6GMo+rlgeTYNAUbZf5vdRgJknM3F7hjn+r6kuOaRT
         CDOG0QDLWaUpLKigTgVrfioVvT03gYMFz35f/+gT/tJ23No9IiFVYWQhYJo9c8TMxuIb
         WaZeOGyZkmuT9snmJ89RJem9zuV48W8wZMvSAa+3pMBL8ziBSIT6/CX/DNxIQOxppwnz
         KBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNv3HODdoQMG20zX099pZsdylxjGh3aKuM4EMRY7SNI=;
        b=H5Y6kTeSZti+1U5dY2yZi/otPhG6RR2VqXht9VqkmUpiNkeowIcQalrbBOKvvwI4xp
         AypBItTygl4GlMGrE6MwvigLKhVuzXZqjBvYFrWa9ZOFIynhA39qz9zqD0sqS+A15tAB
         jGNbC9yDbMs+cItjajhwbcCDQyEfB4rlV45fRJaRpfiFx3dJJgEtFYOpESD2m/DUfJSR
         c58QtwXWor2RfVTBul/45W+jvuIK6mPrwTUX+LtWvpWiTD18vUbNReJpN1WQOXBkfkJi
         DHKyNJ/YOwFL3VZ9cCt8c+j3M8twyUOWY+3DM0WvENJkpTsc1nOCh98Avr8NJ4a4Zqug
         t/pQ==
X-Gm-Message-State: AOAM5314jXeA35jIOSfCZMk3p1vrfXAS3aWx2hzpE9DzsH37mZDs8/rl
        jyGm1mF69B1go+jR7ntEC/+SntlGqTrOnsh1HXxr9sSyf08=
X-Google-Smtp-Source: ABdhPJwaULpgu1S1xXQ48WjMkEiYZCn1JHDLIIe7B9hPsw8aGx7gQX6d6wkYLoGB62hEQNyw0dPIhaSg2ftZ8R+Ir24=
X-Received: by 2002:a92:cd8b:0:b0:2cf:90f9:30e0 with SMTP id
 r11-20020a92cd8b000000b002cf90f930e0mr33820ilb.252.1651877189837; Fri, 06 May
 2022 15:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-2-joannelkoong@gmail.com> <20220506150727.73dvaiyf5rerggj3@dev0025.ash9.facebook.com>
 <CAJnrk1Yc7G9BamfcNDGXvhMbHcrebROxN97GPPNENJ9_vGF5XA@mail.gmail.com> <20220506203224.e7pdw3jk6kqpe7dh@dev0025.ash9.facebook.com>
In-Reply-To: <20220506203224.e7pdw3jk6kqpe7dh@dev0025.ash9.facebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 15:46:19 -0700
Message-ID: <CAEf4BzavPM8o2OnYB3zSj_wfQp5us4rBjjKXzW4q-m-HARSZ1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Add MEM_UNINIT as a bpf_type_flag
To:     void@manifault.com
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 6, 2022 at 1:32 PM David Vernet <void@manifault.com> wrote:
>
> On Fri, May 06, 2022 at 12:09:37PM -0700, Joanne Koong wrote:
> > I think the bpf philosophy leans more towards conflating related-ish
> > patches into the same patchset. I think this patch could be its own
> > stand-alone patchset, but it's also related to the dynptr patchset in that
> > dynptrs need it to properly describe its initialization helper functions.
> > I'm happy to submit this as its own patchset though if that is preferred :)
>
> Totally up to you, if that's the BPF convention then that's fine with me.

You meant

- [ARG_PTR_TO_UNINIT_MEM]         = &mem_types,

parts as stand-alone patch? That would be invalid on its own without
adding MEM_UNINT, so would potentially break bisection. So no, it
shouldn't be a stand-alone patch. Each patch has to be logically
separate but not causing any regressions in behavior, compilation,
selftest, etc. So, for example, while we normally put selftests into
separate tests, if kernel change breaks selftests, selftests have to
be fixed in the same patch to avoid having any point where bisection
can detect the breakage.


>
> >
> > > -     } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE ||
> > > > -                base_type(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> > > > +     } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE) {
> > > >               if (type_may_be_null(arg_type) && register_is_null(reg))
> > > >                       return 0;
> > > >
> > > > @@ -5811,7 +5801,7 @@ static int check_func_arg(struct bpf_verifier_env
> > > *env, u32 arg,
> > > >                       verbose(env, "invalid map_ptr to access
> > > map->value\n");
> > > >                       return -EACCES;
> > > >               }
> > > > -             meta->raw_mode = (arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE);
> > > > +             meta->raw_mode = arg_type & MEM_UNINIT;
> > >
> > > Given that we're stashing in a bool here, should this be:
> > >
> > >         meta->raw_mode = (arg_type & MEM_UNINIT) != 0;
> > >
> > I think just arg_type & MEM_UNINIT is okay because it implicitly converts
> > from 1 -> true, 0 -> false. This is the convention that's used elsewhere in
> > the linux codebase as well
>
> Yeah I think functionally it will work just fine as is. I saw that a few
> other places in verifier.c use operators that explicitly make the result 0
> or 1, e.g.:
>
> 14699
> 14700         env->strict_alignment = !!(attr->prog_flags & BPF_F_STRICT_ALIGNMENT);
>
> But the compiler will indeed implicitly convert any nonzero value to 1 if
> it's stored in a bool, so it's not necessary for correctness. It looks like
> the kernel style guide also implies that using the extra operators isn't
> necessary, so I think we can leave it as you have it now:
> https://www.kernel.org/doc/html/latest/process/coding-style.html#using-bool

Yeah, the above example is rather unusual, I'd say. We do
!!(bool_expr) only when we want to assign that to integer (not bool)
variable/field as 0 or 1. Otherwise it's a well-defined compiler
conversion rule for any non-zero value to be true during bool
conversion.

>
> > > What do you think about this as a possibly more concise way to express that
> > > the curr and next args differ?
> > >
> > >         return (base_type(arg_curr) == ARG_PTR_TO_MEM) !=
> > >                 arg_type_is_mem_size(arg_next);
> > >
> > I was trying to decide between this and the more verbose expression above
> > and ultimately went with the more verbose expression because it seemed more
> > readable to me. But I don't feel strongly :) I'm cool with either one
>
> I don't feel strongly either, if you think your way is more readable then
> don't feel obligated to change it.
>

Heh, this also caught my eye. It's subjective, but inequality is
shorter and more readable (even in terms of the logic it expresses).
But it's fine either way with me.

> Thanks,
> David
