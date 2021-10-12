Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C51429C02
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 05:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhJLDiy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 23:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhJLDis (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 23:38:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F56C061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:36:42 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id u32so43540822ybd.9
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btvC4E48dYmamwT4ySb+LyNN+d7V5fNadHWo65oCgb4=;
        b=cCT/c4Hj5/OesBdFlebo7IZag/9yxfly2+VL6U6sf1cb/0kpBIT+bRO7CSxMqSEpOs
         zmwHX7b0UFAs1fzF1GFGkik3+MlzZ09jYNOPlzUXg2Y7ugLqaceX9excjwXorsJ8vaLn
         TX7OCaKDkST40umoUyjQU4zsYEJdg0+EZA05Zbt06npGbzglVCvex0vFVqsezUMu+gW3
         XHZcK8LsCVaPoRE7PqxNxFj/wcTyO0ZQLyUlTxHRlxaMCl8C7j9nCm3N55yQx1uMz89P
         0hpSvGP3cW/h5xURbnblPQVCC9iMkr1pnJIr1RE3wfWwvDfqqbh2hVbO0irHgoXKg3TU
         dTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btvC4E48dYmamwT4ySb+LyNN+d7V5fNadHWo65oCgb4=;
        b=dMpNx4HIQfk01WoOIg++u8ytA7YeIP8xLaFvp6w/R+0MzSfMGQdC8dbyE4gFv10FB3
         qa3l3Y7IbNcgjYruP1QTGf6nh/Q5LhIUVpBRWPhgu+cimwvw1Jgy7JEGy0Su/fyyDgMO
         qwjP1A5+yla/YMdNSQXYcKQatDcjF9s3gd9EItinIfgq/GqPHx1i4MaG2Bx3SkUt6kOG
         CMjSLqtIqeyKFfffzsnk2nLHFJSh+T8A2swj2vp7RrQ2LC3Yh9gKCdOj72xB3W/q+m8c
         rgxv/Aj/0C1LL81RtLKRbcdVXWQgpmUZ8CQzTiq7wCcvkqmkj3Fm110rTJgezsmmVMYl
         +JTA==
X-Gm-Message-State: AOAM531jKS1dHoudXd7YsNZRA+cC+9lFMOESOaYrNslsOMrj8LJjRirN
        lGtB78XSgaUbyfs3i+3NtD5SfmyyDKlyhr/Ao3Iz5JpZO4bALMn5Ulo=
X-Google-Smtp-Source: ABdhPJwcOF8X7EdihVRP1JFyYq8U89/qNVGuBsKjr+VC4bDbcpNqIpK/Cg3UKhLCTs1S/GYttRzZfGzlgvmk+g/tIQU=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr26414482ybc.225.1634009801548;
 Mon, 11 Oct 2021 20:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <f70ddfc2-8cc4-72d6-6a87-0b4f08a1fdee@fb.com>
In-Reply-To: <f70ddfc2-8cc4-72d6-6a87-0b4f08a1fdee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Oct 2021 05:36:30 +0200
Message-ID: <CAEf4BzZXFwBUb=HWxfzfnA-Nq9OKpNXGa=mPqpQs2ABFPdm=uA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/10] libbpf: support custom .rodata.*/.data.* sections
To:     Alexei Starovoitov <ast@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 11:30 PM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 10/7/21 5:02 PM, andrii.nakryiko@gmail.com wrote:
> >
> > One interesting possibility that is now open by these changes is that it's
> > possible to do:
> >
> >      bpf_trace_printk("My fmt %s", sizeof("My fmt %s"), "blah");
> >
> > and it will work as expected.
>
> Could you explain what would be the difference vs existing bpf_printk macro?
> Why these patches enable above to work ?

Good question. Have you ever noticed warnings like this during selftests build:

libbpf: elf: skipping unrecognized data section(6) .rodata.str1.1

I'm recalling from memory a bit here, so excuse me if I get some small
details wrong. Let's say we have a `bpf_printk("Hello!\n");` call. It
is turned into:

static const char fmt[] = "Hello!\n";
bpf_trace_printk(fmt, 7);

`fmt` variable above is always in .rodata section, it will even have a
dedicated BTF VAR with the name '<func>.fmt'. For reasons unknown to
me (Yonghong will know, probably), the compiler *also* and *sometimes*
puts the same "Hello!\n" string into the .rodata.str1.1 section. So we
end up with this warning about unknown and skipped .rodata.str1.1.
Good news is that we actually never reference "Hello!\n" from
.rodata.str1.1, which is why the bpf_printk() works today.

But if you were to rewrite the above snippet as more natural:

bpf_trace_printk("Hello!\n", 7);

... and compiler puts that "Hello!\n" into .rodata.str1.1 (and *not*
into .rodata), then we'd have a relocation against .rodata.str1.1,
which will fail because up until now libbpf never did anything with
.rodata.str1.1.

So it's a bit roundabout way to say that with this patch set, no
matter which .rodata* section compiler decided to put compile-time
constants into (doesn't have to be string, could be struct literal for
initializing a struct, for example) it should work, because it's just
a normal relocation, so all the libbpf relocation logic works, and for
kernel it will be just another global data ARRAY, so everything works
as expected. What was necessary to make this work was internal
refactoring to remove a simplifying assumption that there could be
only one .rodata map, and one .data map, etc.

Hope that clears it a bit.

>
> > I haven't updated libbpf-provided helpers in
> > bpf_helpers.h for snprintf, seq_printf, and printk, because using
> > `static const char ___fmt[] = fmt;` trick is still efficient and doesn't fill
> > out the buffer at runtime (no copying), but it also enforces that format
> > string is compile-time string literal:
> >
> >      const char *s = NULL;
> >
> >      bpf_printk("hi"); /* works */
> >      bpf_printk(s); /* compilation error */
> >
> > By passing fmt directly to bpf_trace_printk() would actually compile
> > bpf_printk(s) above with no warnings and will not work at runtime, which is
> > worse user experience, IMO.
>
> What is the example of "compile with no warning and not work at runtime" ?

Right, so imagine we rewritten bpf_printk to expand into

bpf_trace_printk(fmt, sizeof(fmt), args...));

Now, if you do bpf_printk("BLAH"), everything works, fmt string
literal is passed properly and its size is calculated as 5. But if you
now pass const char *, you end up doing:

bpf_trace_printk(s, sizeof(s) /* == 8 */, args...);

See how passing a pointer is right for the first argument, but using
it to determine the string size is completely wrong. And the worst
thing is it won't trigger any warning. There's a similar danger of
using sizeof() with arrays. Pure C language gotcha, nothing BPF
specific.
