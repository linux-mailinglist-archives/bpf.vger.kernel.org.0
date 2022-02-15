Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320334B76DC
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 21:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242762AbiBOR4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 12:56:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242805AbiBOR4K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 12:56:10 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7F1017F5
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 09:55:58 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id x13so151106iop.4
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 09:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqmnLjh3Hx5KlB36rFWOPuEM9P698eDQbVmjfmtnERE=;
        b=BBEQpTmgMlkVSPnb1n/yc3plaE2OkN+zeXyOvJbd4dxMuJ8ZhywikoGkATFv2wEnTl
         i/9sHv2jv6MRUizh82RUmmvQXErI9KUEDxffYfGz1UTPvPg8RIjtj7kY04KaNyVvTdsG
         fhy0Oq0PTVhA04oTWYNMkZJcjiU8uh6ijHbkNjj73uI1JP7sKlrtmEyAWFsJjSPmzUMu
         MBxSzKJgU++MbUD2PeCn6hjzGPCTYTgk1nH21Ey2pnYC6BG78SLzjiVXQ/9JKb2tKTix
         cltwRRqR1PU2cqzo3gU1VykNfpdz0VkVPb9TndttN8DEwI1Ywa7+Tr5LPuB0iRasoAEX
         nGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqmnLjh3Hx5KlB36rFWOPuEM9P698eDQbVmjfmtnERE=;
        b=qSJUkaSJm9GxHUICdP3/q9plfIlKnLCaVnjhrDPwRNkrEfu/0acdab9zcbD8uSMDW7
         Q7yq804ka1t+MhxLw9WIjKRpfdGDUnCrWkz7iVc/qAX5tvfbwK0P/cQmPSBO12Y1RXfs
         9oG1xILQKFZK94WTWvJF0x5ed4bHDx8UQrs7sb9+4sXgCVzpaslLENuJ+/2A+df47TEO
         g62QhzCwGFCuSjObNZg35OuwWI5NXSCNxpsDZ7PtpcaC15snVgxYBrDw0ovKEHX467vT
         3ny49EwtirLGlsLxyWe5U5y3F7cA0wwR816qGDuzKi1MZ+xs2JfPcqHwDuD4Resi0kuo
         5s9w==
X-Gm-Message-State: AOAM530caRhNURk4aDVzd0jbWHTXBsT/HkRJxJUpgFLtNM8XV6m2CFHy
        pZwl16vRiAMLyO5Ca1ZhHlCEYXltsIFnZzKfk6g=
X-Google-Smtp-Source: ABdhPJy70WcrSGo+yNksx7X23s6DsJ8sI5Gjcq/ooL++swtPw6/YH/8SS5rVW4mYJ+zpw9Ml82Whh4xrzYl0lTI3l3c=
X-Received: by 2002:a02:7417:: with SMTP id o23mr38760jac.145.1644947757865;
 Tue, 15 Feb 2022 09:55:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644884357.git.delyank@fb.com> <6c673f48d35fd06bc3490b00d4e6527b7e180d59.1644884357.git.delyank@fb.com>
 <CAEf4BzYZ7r3hpUsEQvkF-fpJhHdt0OXAxJxPvPDN-f4088bM6A@mail.gmail.com> <8c8820379a241322535ce0821bdb9f6c05c91290.camel@fb.com>
In-Reply-To: <8c8820379a241322535ce0821bdb9f6c05c91290.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Feb 2022 09:55:46 -0800
Message-ID: <CAEf4BzY1JY=GcnBGOr3H3ay=PC0fiYX4YQv27ROV=6KiYFzi=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpftool: bpf skeletons assert type sizes
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Feb 15, 2022 at 9:27 AM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Mon, 2022-02-14 at 21:11 -0800, Andrii Nakryiko wrote:
> > So doing it right after each section really pollutes the layout of the
> > skeleton's struct and hurts readability a lot.
> >
> > How about adding all those _Static_asserts in <skeleton__elf_bytes()
> > function, after the huge binary dump, to get it out of sight?
>
> I can just add a `void __attribute__((unused)) skeleton__assert_sizes()` at the
> end? Or a `struct skeleton__type_asserts`? It feels weird to just put them in
> elf_bytes, they don't belong there.

SGTM.

>
> > I think
> > if we are doing asserts, we might as well validate that not just
> > sizes, but also each variable's offset within the section is right.
>
> Sure, can do.

Alexei pointed out that it's very unlikely that we'll mess up offsets
(we have actual offset from BTF and then we control alignment in
skeleton's struct, so should never get out of sync), so let's skip
offset assertion for now.

>
>
> > _Static_assert(sizeof(s->data->in1) == 4, "invalid size of in1");
> > _Static_assert(offsetof(typeof(*skel->data), in1) == 0, "invalid
> > offset of in1");
> > ...
> > _Static_assert(sizeof(s->data_read_mostly->read_mostly_var) == 4,
> > "invalid size of read_mostly_var");
> > _Static_assert(offsetof(typeof(*skel->data_read_mostly),
> > read_mostly_var) == 0, "invalid offset of read_mostly_var");
> >
> > (void)s; /* avoid unused variable warning */
> >
> > WDYT?
>
> That's fine by me, I have no objections. I'll see if a function or a struct is
> more readable.
>
> I suspect `SIZE_ASSERT(data, in1, 4); OFFSET_ASSERT(data, in1, 0);` is probably
> most readable but I hate that I'd have to include the macros inline (to emit the
> skeleton type name).

No one should read those asserts, so putting them somewhere after
elf_bytes function and writing out _Static_assert() directly is
probably best for when one of those asserts fires. It will result in
simpler compiler error (rather than unscrambling a chain of macro
invocations). So yeah, I'd stick to a bit more verbose _Static_assert.


>
> > >         return 0;
> > >  }
> > >
> > > @@ -756,6 +779,12 @@ static int do_skeleton(int argc, char **argv)
> > >                                                                             \n\
> > >                 #include <bpf/skel_internal.h>                              \n\
> > >                                                                             \n\
> > > +               #ifdef __cplusplus                                          \n\
> > > +               #define BPF_STATIC_ASSERT static_assert                     \n\
> > > +               #else                                                       \n\
> > > +               #define BPF_STATIC_ASSERT _Static_assert                    \n\
> > > +               #endif                                                      \n\
> >
> > Maybe just:
> >
> > #ifdef __cplusplus
> > #define _Static_assert static_assert
> > #endif
> >
> > ? Or that doesn't work?
>
> It does work, it's just less explicit. I'd be happy to remove the macro
> expansion on the C path though, it would make diagnostics shorter.

Yep, it was my thinking that we should "optimize" for pure C case.

>
>
> > Also any such macro has to be #undef in this file, otherwise it will
> > "leak" into the user's code (as this is just a header file included in
> > user's .c files).
>
> My bad, just thought of that too.
>
> --
>
> To summarize, structurally I'll do this:
>
> 1. Put them all in one place. (tbd what type)
> 2. Put them at the end of the file.
> 3. Add offsets.
> 4. Fix up the macro usage.
>
