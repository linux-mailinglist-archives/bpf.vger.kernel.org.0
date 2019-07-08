Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9EE625E1
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 18:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfGHQNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 12:13:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40493 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfGHQNl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 12:13:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so7833743pfp.7
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8t0LI8f5d2yC1Ell37KaoDAT1u2qrCk09hV1h5m1t5o=;
        b=14SwpmVCFEAW+QYYzXuCkYAQ31/ZEp78hlPwaiSPUKrN4JJ9b93kY0cHVk5zrKg1mS
         Y+wixUDWvAa6udSGUeqVUFtLlpYCueOfp7RVv/y8B0vBpiiuxjJytcJjbBQ5tSioI7TU
         IbMOe4xa94Fnc9zkULY0FE4Ewj9dYx3e+jrKrtuA/RgBXV6PjaVNX1h73YWdzpNY/SXI
         KBajHmyGxkW5CSYXo8xrGXxZAJ6aMA4OAzAPgwL/Cq7l7Y0mVjrI5HJKE8juhGbsQYi6
         HWTBQaN6dIckCIaMDmoilaY48HRpold/lJw7MILvMdUlKfNMt91Kc4MSZGApw6zaqMYt
         Hhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8t0LI8f5d2yC1Ell37KaoDAT1u2qrCk09hV1h5m1t5o=;
        b=UTtgS8HnfPBVfMh0NNd9ewrwA3mX2+dBqYer8T1lzQ9KLKxF5mDjZuFHVFBTn/Gvww
         jiCFdY5fsdPV9tzWOjal6Z8UXnM8duZvxf6xHuL1flXFrZWGa7/+z2/BXPohFeHSkKgz
         N7pQdwmZhGoYUcyHkRB+vHfPdixyZ3r9tB5AUpPzpWK1eWe4MkWYW291tt2AXwSjEMpu
         H/iRZjVF+UiOX0FkqWNtJmxdTrtho+C7iwh8fmSIPrDtszPBsAuqrKfcdlWRtrkxSAKW
         CHLXYzX38jDB+1hvZY5U7zMrXxEPsxO0xt/TTKT6wCxl2RpsPhIlcGnfjdB6e6HUK1+j
         rJvg==
X-Gm-Message-State: APjAAAVC3/Ly0yh7kuHesfTO/C1QIcmLMxY0N9GlBFAaXQmHZClvyOAY
        vunwrEcZCCiBn+w6p3FPEjy+cA==
X-Google-Smtp-Source: APXvYqxTCeIzZ2W/qBHTEFfMqxCwVIiy/cRoCD7v0m1Vc7OhF130e0EtJ36LUm3tpYyvtyjhFdZYGQ==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr24693864pgd.241.1562602420513;
        Mon, 08 Jul 2019 09:13:40 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id j15sm18527333pfr.146.2019.07.08.09.13.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:13:39 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:13:38 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Y Song <ys114321@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: make verifier loop tests arch
 independent
Message-ID: <20190708161338.GC29524@mini-arch>
References: <20190703205100.142904-1-sdf@google.com>
 <CAH3MdRWePmAZNRfGNcBdjKAJ+D33=4Vgg1STYC3khNps8AmaHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3MdRWePmAZNRfGNcBdjKAJ+D33=4Vgg1STYC3khNps8AmaHQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/03, Y Song wrote:
> On Wed, Jul 3, 2019 at 1:51 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Take the first x bytes of pt_regs for scalability tests, there is
> > no real reason we need x86 specific rax.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/testing/selftests/bpf/progs/loop1.c | 3 ++-
> >  tools/testing/selftests/bpf/progs/loop2.c | 3 ++-
> >  tools/testing/selftests/bpf/progs/loop3.c | 3 ++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/loop1.c b/tools/testing/selftests/bpf/progs/loop1.c
> > index dea395af9ea9..d530c61d2517 100644
> > --- a/tools/testing/selftests/bpf/progs/loop1.c
> > +++ b/tools/testing/selftests/bpf/progs/loop1.c
> > @@ -14,11 +14,12 @@ SEC("raw_tracepoint/kfree_skb")
> >  int nested_loops(volatile struct pt_regs* ctx)
> >  {
> >         int i, j, sum = 0, m;
> > +       volatile int *any_reg = (volatile int *)ctx;
> >
> >         for (j = 0; j < 300; j++)
> >                 for (i = 0; i < j; i++) {
> >                         if (j & 1)
> > -                               m = ctx->rax;
> > +                               m = *any_reg;
> 
> I agree. ctx->rax here is only to generate some operations, which
> cannot be optimized away by the compiler. dereferencing a volatile
> pointee may just serve that purpose.
> 
> Comparing the byte code generated with ctx->rax and *any_reg, they are
> slightly different. Using *any_reg is slighly worse, but this should
> be still okay for the test.
> 
> >                         else
> >                                 m = j;
> >                         sum += i * m;
> > diff --git a/tools/testing/selftests/bpf/progs/loop2.c b/tools/testing/selftests/bpf/progs/loop2.c
> > index 0637bd8e8bcf..91bb89d901e3 100644
> > --- a/tools/testing/selftests/bpf/progs/loop2.c
> > +++ b/tools/testing/selftests/bpf/progs/loop2.c
> > @@ -14,9 +14,10 @@ SEC("raw_tracepoint/consume_skb")
> >  int while_true(volatile struct pt_regs* ctx)
> >  {
> >         int i = 0;
> > +       volatile int *any_reg = (volatile int *)ctx;
> >
> >         while (true) {
> > -               if (ctx->rax & 1)
> > +               if (*any_reg & 1)
> >                         i += 3;
> >                 else
> >                         i += 7;
> > diff --git a/tools/testing/selftests/bpf/progs/loop3.c b/tools/testing/selftests/bpf/progs/loop3.c
> > index 30a0f6cba080..3a7f12d7186c 100644
> > --- a/tools/testing/selftests/bpf/progs/loop3.c
> > +++ b/tools/testing/selftests/bpf/progs/loop3.c
> > @@ -14,9 +14,10 @@ SEC("raw_tracepoint/consume_skb")
> >  int while_true(volatile struct pt_regs* ctx)
> >  {
> >         __u64 i = 0, sum = 0;
> > +       volatile __u64 *any_reg = (volatile __u64 *)ctx;
> >         do {
> >                 i++;
> > -               sum += ctx->rax;
> > +               sum += *any_reg;
> >         } while (i < 0x100000000ULL);
> >         return sum;
> >  }
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> 
> Ilya Leoshkevich (iii@linux.ibm.com, cc'ed) has another patch set
> trying to solve this problem by introducing s360 arch register access
> macros. I guess for now that patch set is not needed any more?
Oh, I missed them. Do they fix the tests for other (non-s360) arches as
well? I was trying to fix the issue by not depending on any arch
specific stuff because the test really doesn't care :-)
