Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408AD9D499
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2019 19:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfHZREG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Aug 2019 13:04:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35491 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfHZREG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Aug 2019 13:04:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so10324249plb.2
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2019 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQr2+CCalKgDrA12cz6kTPFlEgpE4NTSJBHk84k9KlA=;
        b=gK38A443J07JEv1eh/lZRr+OP0alDEoLrPFRvrv0zx5PtWmDjpTo4wBqkXvanXqjRb
         womdthz/nhAEw63Hr7UOKqCsf5KERELbxa/Zr5s1O5Mzy8LBJsr8yN34FuO60Jm1IiuT
         UXgjQtyVt5Gwo0tmxjHxcSj1RAoSitwBdXQW+n+vaJbaaYkMDPtVzPJwmd0tSg3sXNDU
         lXcphOgTaWgiVrnkBPDWoXbkjGp9PS3O27W1GwLxqG5n+xVP2vtsFBG1IBPoNTpGRS7K
         eRy5w6Wx8de29tC7h1k4Md4ZVCe4WSHKOUNT+qXUDzCB4ozgZaUlDffa25kNVr4n4ayr
         MYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQr2+CCalKgDrA12cz6kTPFlEgpE4NTSJBHk84k9KlA=;
        b=rJklV6NIt3PPQdIaiwJCkD/204hCDID+80KNCN3jHaf+hbDSd/WJgTn94FoDlIPmjy
         oLv1htDjo0W4lzu7YrlAEXE6xXtI1am8BdN2WJSKon/WdBken9CXlY/+mt+KZLN7Wid/
         ZwDU8vkOioVi5bYaHaCloPldHHEeN8lhWtMtsZJz2E6kF/yRSVgY0K7wSxyxP4S5KOED
         Lcg2Fuas0NOwn2f8k2PoNc2sCLG27g0bBAfxPKnvXyJDhdBdcuyKrhhPg6Tvo56Gs4E1
         F1GVlu0B7zrfLc8UKZPZnXlHzITwyBtprnCCwA9ZtUKaQLd51CUNf/rKfiLCuM0SPOxy
         kGtw==
X-Gm-Message-State: APjAAAXSYPvIAODQEDbH4z73rEnorq+SCF89T7w6HE178UBVCRgmZS6m
        QntNaUZDMwhTWdmRRD+x7jiPGknzqq/GyOiQ8Zo2Nw==
X-Google-Smtp-Source: APXvYqxjWDEwbkiE2ZsJXoDXKy8bI8tnus4ZqI8PGuQRfd0/qEvKV0AcHKVrO9J3tvHAbI2QR49LL7GHmT1tgXzHaKI=
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr19844087plo.223.1566839045123;
 Mon, 26 Aug 2019 10:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
 <20190812215052.71840-12-ndesaulniers@google.com> <20190813082744.xmzmm4j675rqiz47@willie-the-truck>
 <CANiq72mAfJ23PyWzZAELgbKQDCX2nvY0z+dmOMe14qz=wa6eFg@mail.gmail.com>
 <20190813170829.c3lryb6va3eopxd7@willie-the-truck> <CAKwvOdk4hca8WzWzhcPEvxXnJVLbXGnhBdDZbeL_W_H91Ttjqw@mail.gmail.com>
 <CANiq72mGoGpx7EAVUPcGuhVkLit8sB3bR-k1XBDyeM8HBUaDZw@mail.gmail.com>
 <CANiq72nUyT-q3A9mTrYzPZ+J9Ya7Lns5MyTK7W7-7yXgFWc2xA@mail.gmail.com>
 <CANiq72nfn4zxAO63GEEoUjumC6Jwi5_jdcD_5Xzt1vZRgh52fg@mail.gmail.com>
 <20190824112542.7guulvdenm35ihs7@willie-the-truck> <CANiq72mcSniCzMzW6AX_5tG5W2edjEmZ=Rf=jo-Mw3H-9RVJqw@mail.gmail.com>
In-Reply-To: <CANiq72mcSniCzMzW6AX_5tG5W2edjEmZ=Rf=jo-Mw3H-9RVJqw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Aug 2019 10:03:53 -0700
Message-ID: <CAKwvOdkhJQEwWNZSC08sg9vGjydTXrbqNqNrqfN6vbRZUsjGvA@mail.gmail.com>
Subject: Re: [PATCH 12/16] arm64: prefer __section from compiler_attributes.h
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Sat, Aug 24, 2019 at 5:48 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Aug 24, 2019 at 1:25 PM Will Deacon <will@kernel.org> wrote:
> >
> > Which bit are you pinging about? This patch (12/16) has been in -next for a
> > while and is queued in the arm64 tree for 5.4. The Oops/boot issue is
> > addressed in patch 14 which probably needs to be sent as a separate patch
> > (with a commit message) if it's targetting 5.3 and, I assume, routed via
> > somebody like akpm.
>
> I was pinging about the bit I was quoting, i.e. whether the Oops in
> the cover letter was #14 indeed. Also, since Nick said he wanted to
> get this ASAP through compiler-attributes, I assumed he wanted it to
> be in 5.3, but I have not seen the independent patch.
>
> Since he seems busy, I will write a better commit message myself and
> send it to Linus next week.

Sorry, very hectic week here last week.  I'll try to get the import
bit split off, collect the acks/reviewed-by tags, and resend a v2 of
the series this week.
-- 
Thanks,
~Nick Desaulniers
