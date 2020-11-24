Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670EC2C343B
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 23:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgKXWwD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 17:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgKXWwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 17:52:03 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4E3C0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 14:52:03 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t22so256709ljk.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 14:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r683sKbs5/DcIWgIaIqqRuZT9qeJGO0+wglTvaIb1mI=;
        b=Pxpcsj9Q5At5MhJf6//uvkxU3BuoJIMnYTiSFaYptW075Rtm5j0bbBhIx0TryXQX18
         q9TsiD+mun/viB7dllxjGuG1mxdYxq6IAH8ob7+mSX2XK5VILqzHDQ1SO4ReCRLrmcAg
         mctjtX45rppV0hTgFivFGLCEjZ5i2wxWN1xJ2BX4R79LlaYY5BPgSKSvmnw33xfLCHi/
         Odjdu7Np5Wqyz520kXtnG3BAvPDS2odZYD0MoUdVoE7Xe5JqalTSepG6oG4p8motDDgN
         uL9Y4yADPILKU+RLhZETNBKcgFBy/fnUvChUzjnqXVwJoT/FUZgWd9nI535JqAlbb258
         NJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r683sKbs5/DcIWgIaIqqRuZT9qeJGO0+wglTvaIb1mI=;
        b=hh+7ZVTZSSCAMI4lhta9CCP67mYRxPxvR1hpkKNqoEx+VK+tA+22maGZ1dfBNbi/mc
         yfGAv7EaN+nP0Rbsrg0Z7f/0ofje9tWEQSnv/ad+ohAM2gY99vd1mvAOU+NnYx01v4kW
         WvZVn/FiJiHSd7Om+hV+/mrjgQ/QtsJYQ9vSD5uqdjEwPGkO4k4MSzA+ZkDtiDB1ihUm
         tzys/fxsS3TsuOJCYT9K3WHZol8gPfH8SsrCvYRtrVglP/LaCLWCLZOHnvqZz9uqizmC
         VLfqb6zc65umOctqNvwrBXDzinf6zwPs5GSobJPetANoAUlmCsdO/iA+a6pkoDM7DsQC
         cZTw==
X-Gm-Message-State: AOAM533nYydLNemCQY1bL0I2662E7zSjTvy2Xga3QXQfUxPTbXTFiUhU
        rk2LAPiJ61WbeYxJAO/20OtK7Wnd1apLcW8lopM=
X-Google-Smtp-Source: ABdhPJxI1yybh1cf04GVecbeWMn09Ll8EDZY4jbWlvipyz7nOwgB/CU7+D+znJK5KRx940vZeyjCjeC4TS8NXpcUgRE=
X-Received: by 2002:a2e:9681:: with SMTP id q1mr214301lji.2.1606258321475;
 Tue, 24 Nov 2020 14:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20201123173202.1335708-1-jackmanb@google.com> <20201123173202.1335708-7-jackmanb@google.com>
 <20201124064000.5wd4ngq7ydb63chl@ast-mbp> <20201124105551.GB1883487@google.com>
In-Reply-To: <20201124105551.GB1883487@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Nov 2020 14:51:50 -0800
Message-ID: <CAADnVQJ8-dy667Z6fv-yfS=d+YOrmgGcN60LshhQbydV5kB4EA@mail.gmail.com>
Subject: Re: [PATCH 6/7] bpf: Add instructions for atomic_cmpxchg and friends
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 24, 2020 at 2:55 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Mon, Nov 23, 2020 at 10:40:00PM -0800, Alexei Starovoitov wrote:
> > On Mon, Nov 23, 2020 at 05:32:01PM +0000, Brendan Jackman wrote:
> > > These are the operations that implement atomic exchange and
> > > compare-exchange.
> > >
> > > They are peculiarly named because of the presence of the separate
> > > FETCH field that tells you whether the instruction writes the value
> > > back to the src register. Neither operation is supported without
> > > BPF_FETCH:
> > >
> > > - BPF_CMPSET without BPF_FETCH (i.e. an atomic compare-and-set
> > >   without knowing whether the write was successfully) isn't implemented
> > >   by the kernel, x86, or ARM. It would be a burden on the JIT and it's
> > >   hard to imagine a use for this operation, so it's not supported.
> > >
> > > - BPF_SET without BPF_FETCH would be bpf_set, which has pretty
> > >   limited use: all it really lets you do is atomically set 64-bit
> > >   values on 32-bit CPUs. It doesn't imply any barriers.
> >
> > ...
> >
> > > -                   if (insn->imm & BPF_FETCH) {
> > > +                   switch (insn->imm) {
> > > +                   case BPF_SET | BPF_FETCH:
> > > +                           /* src_reg = atomic_chg(*(u32/u64*)(dst_reg + off), src_reg); */
> > > +                           EMIT1(0x87);
> > > +                           break;
> > > +                   case BPF_CMPSET | BPF_FETCH:
> > > +                           /* r0 = atomic_cmpxchg(*(u32/u64*)(dst_reg + off), r0, src_reg); */
> > > +                           EMIT2(0x0F, 0xB1);
> > > +                           break;
> > ...
> > >  /* atomic op type fields (stored in immediate) */
> > > +#define BPF_SET            0xe0    /* atomic write */
> > > +#define BPF_CMPSET 0xf0    /* atomic compare-and-write */
> > > +
> > >  #define BPF_FETCH  0x01    /* fetch previous value into src reg */
> >
> > I think SET in the name looks odd.
> > I understand that you picked this name so that SET|FETCH together would form
> > more meaningful combination of words, but we're not planning to support SET
> > alone. There is no such instruction in a cpu. If we ever do test_and_set it
> > would be something different.
>
> Yeah this makes sense...
>
> > How about the following instead:
> > +#define BPF_XCHG     0xe1    /* atomic exchange */
> > +#define BPF_CMPXCHG  0xf1    /* atomic compare exchange */
> > In other words get that fetch bit right away into the encoding.
> > Then the switch statement above could be:
> > +                     switch (insn->imm) {
> > +                     case BPF_XCHG:
> > +                             /* src_reg = atomic_chg(*(u32/u64*)(dst_reg + off), src_reg); */
> > +                             EMIT1(0x87);
> > ...
> > +                     case BPF_ADD | BPF_FETCH:
> > ...
> > +                     case BPF_ADD:
>
> ... Although I'm a little wary of this because it makes it very messy to
> do something like switch(BPF_OP(insn->imm)) since we'd have no name for
> BPF_OP(0xe1). That might be fine - I haven't needed such a construction
> so far (although I have used BPF_OP(insn->imm)) so maybe we wouldn't
> ever need it.
>
> What do you think? Maybe we add the `#define BPF_XCHG 0xe1` and then if we
> later need to do switch(BPF_OP(insn->imm)) we could bring back
> `#define BPF_SET 0xe` as needed?

I don't think we'll add C atomic_set any time soon.
Since kernel's atomic_set according to the kernel memory model is the
same as write_once.
Which is different from C atomic_set that is implemented in llvm as atomic_xchg
which includes the barrier. Kernel barriers are explicit.
I think eventually we may add various barriers to bpf isa, but not atomic_set.
Just like we don't add insns for read_once, write_once. The normal load/store
should be honored by JITs. So read_once/write_once == *(volatile uX *) in C
will be compiled by llvm into normal bpf ld/st and JITs have to
preserve them as-is.
Otherwise bpf memory model (when it's defined eventually) would have to
diverge too much from the kernel. I think it needs to preserve
read_once/write_once
just like the kernel. Hence no special C-like atomic_set and when JITs process
ld/st they have to emit them as single insn when possible.
