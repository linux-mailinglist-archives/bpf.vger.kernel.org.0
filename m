Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C638E09D
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 00:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfHNWUq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Aug 2019 18:20:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39353 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfHNWUp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 18:20:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so236184pln.6
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3k2w+T8PpskZpxccjtIiizfMIZhjmdjjp0d3COyTRJs=;
        b=bIzCRgoqfzNuUan1EfvB7NRSozZHajM22ukZLoilzYM9sYiJ7YkDvmA7Uj+9V3whQX
         tVwoUOufC9BTkAMrQC/rHvkb/exsHErFgJVr/8W7KT829V0wEHH9QAxZdmZ/ErITekS6
         xrKE/Bq6vysHbTrERMP3oECXC0pPuqF/A4lnVBELZNj6IgYErrd6+O2HP/vitjEgPg/G
         Vo3XjVH1cvHMNyp/jwUDdyb50ZiaJxDo6aTcH/2RYATRNkXzQBQZglJb7q5MJyn2amFZ
         e2uUqZNKxy7OtuBUudolHQGGHryuTumSWmufu1hM+Awk5W4Y9ddcKD4aXMaQEHtNXxkv
         B8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3k2w+T8PpskZpxccjtIiizfMIZhjmdjjp0d3COyTRJs=;
        b=ajk966ulZpcjhKOR3j2JIVOUsSYZYP71n5LLaLeo5HriLR4Rv6z70sUEmrhf+nafcf
         FHfBV/S01TDHgN1aDG4KQIjwT+kxCbLnYpJa7sR5faeeZNERJVBdKNBu692bfbz6+AHg
         AqaGoO4uDfJGpjDxt2pFZX80K59LI36hPO8OKO4BIzDPL8aW1sMJ9hn+ABnMtkG2P3+U
         vqCKYNfecXySDkCzjD2OaSbP9NewqV/JU1UUdPdYgIMszWApV6Ol5dIxuKgx/2Sq4MSa
         oTMJ0OiDM9S4Z6wPsiEEChU4m62IqHXOIZSC5tKJtpt09S21GALj9M3y+J9KOLtXFi2K
         RzBw==
X-Gm-Message-State: APjAAAVrcUgBmhzyE6YvWnRqO1GMJLz+uL1w2a0IJizjSI+T1Onkj173
        Kj4mcyoEUds4nMuDO31YCcLVGQK1Kfg3axaLdtc/fg==
X-Google-Smtp-Source: APXvYqxHrSJ2tRfUqC4Ul74AEgggKrkSwf6kd2vyhl5jNkzvxCgzLD0h2XP16ofmSNmQ6rstXRsNaFKQHmMH2KlVrOE=
X-Received: by 2002:a17:902:a9c3:: with SMTP id b3mr1454831plr.179.1565821244245;
 Wed, 14 Aug 2019 15:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
 <20190812215052.71840-12-ndesaulniers@google.com> <20190813082744.xmzmm4j675rqiz47@willie-the-truck>
 <CANiq72mAfJ23PyWzZAELgbKQDCX2nvY0z+dmOMe14qz=wa6eFg@mail.gmail.com> <20190813170829.c3lryb6va3eopxd7@willie-the-truck>
In-Reply-To: <20190813170829.c3lryb6va3eopxd7@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Aug 2019 15:20:33 -0700
Message-ID: <CAKwvOdk4hca8WzWzhcPEvxXnJVLbXGnhBdDZbeL_W_H91Ttjqw@mail.gmail.com>
Subject: Re: [PATCH 12/16] arm64: prefer __section from compiler_attributes.h
To:     Will Deacon <will@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Yonghong Song <yhs@fb.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 13, 2019 at 10:08 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Aug 13, 2019 at 02:36:06PM +0200, Miguel Ojeda wrote:
> > On Tue, Aug 13, 2019 at 10:27 AM Will Deacon <will@kernel.org> wrote:
> > > On Mon, Aug 12, 2019 at 02:50:45PM -0700, Nick Desaulniers wrote:
> > > > GCC unescapes escaped string section names while Clang does not. Because
> > > > __section uses the `#` stringification operator for the section name, it
> > > > doesn't need to be escaped.
> > > >
> > > > This antipattern was found with:
> > > > $ grep -e __section\(\" -e __section__\(\" -r
> > > >
> > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > ---
> > > >  arch/arm64/include/asm/cache.h     | 2 +-
> > > >  arch/arm64/kernel/smp_spin_table.c | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Does this fix a build issue, or is it just cosmetic or do we end up with
> > > duplicate sections or something else?
> >
> > This should be cosmetic -- basically we are trying to move all users
> > of current available __attribute__s in compiler_attributes.h to the
> > __attr forms. I am also adding (slowly) new attributes that are
> > already used but we don't have them yet in __attr form.

This lone patch of the series is just cosmetic, but patch 14/16 fixes
a real boot issue:
https://github.com/ClangBuiltLinux/linux/issues/619
Miguel, I'd like to get that one landed ASAP; the rest are just for consistency.

> >
> > > Happy to route it via arm64, just having trouble working out whether it's
> > > 5.3 material!

Thanks!
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=80d838122643a09a9f99824adea4b4261e4451e6

> >
> > As you prefer! Those that are not taken by a maintainer I will pick up
> > and send via compiler-attributes.

Miguel, how do you want to take the rest of these patches? Will picked
up the arm64 one, I think the SuperH one got picked up.  There was
feedback to add more info to individual commits' commit messages.

I kept these tree wide changes separate to improve the likelihood that
they'd backport to stable cleanly, but could always squash if you'd
prefer to have 1 patch instead of a series.  Just let me know.
-- 
Thanks,
~Nick Desaulniers
