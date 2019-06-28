Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919715A5BA
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 22:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfF1UNK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 16:13:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33329 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfF1UNH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 16:13:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4so3071153pgk.0
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Amybm5wgl2x2y4DQCaMoG+V1yEtg0sPRIUl33wffDtM=;
        b=mKRe8AlrdnV37n3R/e0SHNzE+3TaRdo7lnVjd4bk7zs18tyFuBsAGMZHZK9VXigKCu
         R5iAFeyGORMt8fI4mpk1wAToBG3AU3HhUuMYUMx0Sso1lVU4mcDpfNSQJhRdkPscHDqX
         Ml6S23r0uzZ8QaD9QdC77KfCUsiXhgo2cx8MRcf157hmjVV2hJjJM3rEwbCSeoDH9VZt
         Hmq+tkQSuNw7cExfaeTka61npJLRDz2tbji/7zeexm8MvNyg0rdldyznTPoI8jtdD49A
         7GeSioTJ8HINNRMJXfedXTJSLaaUkAYMcwq5aOLBGzug+T5YhID5mraITrUN4Ba9zAPc
         V+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Amybm5wgl2x2y4DQCaMoG+V1yEtg0sPRIUl33wffDtM=;
        b=qy4qrMKwJUuqiuLquj6kuMr7rs+16rzJgGRDtHedZnYc0r/tzFLOtJxx/wgauBZsfn
         F1FUtkkffmVMaoG4dyzGU8LHRwVezHU3IsRhOIryyM9VTbN6Grw2Azn/yPu34Uo7s0yM
         ffhBQJOSo+bE301hVgA96/wbW11oDuYyVkqBEBZWPskL2fJXR1YPxfRSR3XYaUa2kPXL
         0puke4GWfxGRq3ppsYIjk36ykxqT1Sh/ArCc4c5T7rY3ix7HuV4rB3RZZkKVnWqWUq80
         0OJhV8XWJPpHzMhuWdRl9whnq68hKpGFvjafZErcDj8fO7SW/9xUho4oj2yIEAWmcTgu
         3DeQ==
X-Gm-Message-State: APjAAAVRSV2RMNiTHaFi3Blr47czZkU0hbT1ITBmrvrQEwjoqWjpWwlg
        4daHEug0TvkiRlmHT5b8xGpGyQ==
X-Google-Smtp-Source: APXvYqwQlwGbq08xmhQ85fDT2HBB2aE1HikF9eJeJ1GGjCpdJuPoVVznmuu95mz+s5u5C1T4GmGPlQ==
X-Received: by 2002:a63:d006:: with SMTP id z6mr11354160pgf.364.1561752785884;
        Fri, 28 Jun 2019 13:13:05 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id 30sm3217597pjk.17.2019.06.28.13.13.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 13:13:05 -0700 (PDT)
Date:   Fri, 28 Jun 2019 13:13:04 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        bpf <bpf@vger.kernel.org>, lkp@01.org
Subject: Re: [bpf/tools] cd17d77705:
 kernel_selftests.bpf.test_sock_addr.sh.fail
Message-ID: <20190628201304.GA6757@mini-arch>
References: <20190627090446.GG7221@shao2-debian>
 <20190627155029.GC4866@mini-arch>
 <20190627172932.GD4866@mini-arch>
 <CAEf4Bzbf8OE9TUV2Pq7HZp3PYhoUgMzH-Gs+GMafTPwPc_jYxA@mail.gmail.com>
 <20190628023810.GF4866@mini-arch>
 <CAEf4BzbKkE0DYc0faaHThqyEbAu6qA1pFpUJ0uhX5xVd7Q7zSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbKkE0DYc0faaHThqyEbAu6qA1pFpUJ0uhX5xVd7Q7zSg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/28, Andrii Nakryiko wrote:
> On Thu, Jun 27, 2019 at 7:38 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 06/27, Andrii Nakryiko wrote:
> > > On Thu, Jun 27, 2019 at 10:29 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > On 06/27, Stanislav Fomichev wrote:
> > > > > On 06/27, kernel test robot wrote:
> > > > > > FYI, we noticed the following commit (built with gcc-7):
> > > > > >
> > > > > > commit: cd17d77705780e2270937fb3cbd2b985adab3edc ("bpf/tools: sync bpf.h")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > >
> > > > > > in testcase: kernel_selftests
> > > > > > with following parameters:
> > > > > >
> > > > > >     group: kselftests-00
> > > > > >
> > > > > > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > > > > > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > > > > >
> > > > > >
> > > > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > > > >
> > > > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > > >
> > > > > > # 55: (18) r1 = 0x100000000000000
> > > > > > # ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
> > > > > > # 57: (7b) *(u64 *)(r6 +16) = r1
> > > > > > # invalid bpf_context access off=16 size=8
> > > > > This looks like clang doing single u64 write for user_ip6[2] and
> > > > > user_ip6[3] instead of two u32. I don't think we allow that.
> > > > >
> > > > > I've seen this a couple of times myself while playing with some
> > > > > progs, but not sure what's the right way to 'fix' it.
> > > > >
> > > > Any thoughts about the patch below? Another way to "fix" it
> > >
> > > I'll give it a more thorough look a bit later, but see my comments below.
> > >
> > > > would be to mark context accesses 'volatile' in bpf progs, but that sounds
> > > > a bit gross.
> > > >
> > > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > > index 43b45d6db36d..34a14c950e60 100644
> > > > --- a/include/linux/filter.h
> > > > +++ b/include/linux/filter.h
> > > > @@ -746,6 +746,20 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
> > > >         return size <= size_default && (size & (size - 1)) == 0;
> > > >  }
> > > >
> > > > +static inline bool __bpf_ctx_wide_store_ok(u32 off, u32 size)
> > >
> > > It seems like bpf_ctx_wide_store_ok and __bpf_ctx_wide_store_ok are
> > > used only inside net/core/filter.c, why declaring them in header file?
> > I wanted it to be next to bpf_ctx_narrow_access_ok which does the
> > reverse operation for reads.
> 
> Ah, ok, I see that bpf_ctx_narrow_access_ok is used in
> kernel/bpf/cgroup.c as well and bpf_ctx_wide_store_ok might be useful
> in some other contexts as well, let's keep it here.
> 
> >
> > > > +{
> > > > +       /* u64 access is aligned and fits into the field size */
> > > > +       return off % sizeof(__u64) == 0 && off + sizeof(__u64) <= size;
> > > > +}
> > > > +
> > > > +#define bpf_ctx_wide_store_ok(off, size, type, field) \
> > > > +       (size == sizeof(__u64) && \
> > > > +        off >= offsetof(type, field) && \
> > > > +        off < offsetofend(type, field) ? \
> > > > +       __bpf_ctx_wide_store_ok(off - offsetof(type, field), \
> > > > +                                FIELD_SIZEOF(type, field)) : 0)
> 
> This would be sufficient, right?
Thanks, that looks much better and is actually more correct than my
implementation. We should really look at the off alignment, not
the off-offsetof(type, field) as I did.

> #define bpf_ctx_wide_store_ok(off, size, type, field) \
>         size == sizeof(__u64) &&                      \
>         off >= offsetof(type, field) &&               \
>         off + size <= offsetofend(type, field) &&     \
>         off % sizeof(__u64) == 0
> 
> > >
> > > Why do you need ternary operator instead of just a chain of &&s?
> > Good point. I didn't spend too much time on the patch tbh :-)
> > If it looks good in general, I can add proper tests and do a
> > proper submition, this patch is just to get the discussion started.
> 
> Consider it started. :) Talking with Yonghong about preventing this
> from happening in the first place in Clang, it seems like that would
> be harder and more cumbersome than supporting in BPF verifier. So
> please go ahead and submit a proper patch.
>
> >
> > > It also seems like you can avoid macro and use plain function if
> > > instead of providing (type, field) you provide values of offsetof and
> > > offsetofend (offsetofend - offsetof should equal FIELD_SIZEOF(type,
> > > field), shouldn't it?).
> > But then I'd have to copy-paste the args of offsetof/offsetofend at
> > the caller, right? I wanted the caller to be clean and simple.
> 
> Yeah, that's a bit verbose, I agree. I don't mind macro, so no worries.
> 
> >
> > > >  #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
> > > >
> > > >  static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 2014d76e0d2a..2d3787a439ae 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -6849,6 +6849,16 @@ static bool sock_addr_is_valid_access(int off, int size,
> > > >                         if (!bpf_ctx_narrow_access_ok(off, size, size_default))
> > > >                                 return false;
> > > >                 } else {
> > > > +                       if (bpf_ctx_wide_store_ok(off, size,
> > > > +                                                 struct bpf_sock_addr,
> > > > +                                                 user_ip6))
> > > > +                               return true;
> > > > +
> > > > +                       if (bpf_ctx_wide_store_ok(off, size,
> > > > +                                                 struct bpf_sock_addr,
> > > > +                                                 msg_src_ip6))
> > > > +                               return true;
> > > > +
> > > >                         if (size != size_default)
> > > >                                 return false;
> > > >                 }
> > > > @@ -7689,9 +7699,6 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> > > >  /* SOCK_ADDR_STORE_NESTED_FIELD_OFF() has semantic similar to
> > > >   * SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF() but for store operation.
> > > >   *
> > > > - * It doesn't support SIZE argument though since narrow stores are not
> > > > - * supported for now.
> > > > - *
> > > >   * In addition it uses Temporary Field TF (member of struct S) as the 3rd
> > > >   * "register" since two registers available in convert_ctx_access are not
> > > >   * enough: we can't override neither SRC, since it contains value to store, nor
> > > > @@ -7699,7 +7706,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> > > >   * instructions. But we need a temporary place to save pointer to nested
> > > >   * structure whose field we want to store to.
> > > >   */
> > > > -#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF, TF)                       \
> > > > +#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE, OFF, TF)         \
> > > >         do {                                                                   \
> > > >                 int tmp_reg = BPF_REG_9;                                       \
> > > >                 if (si->src_reg == tmp_reg || si->dst_reg == tmp_reg)          \
> > > > @@ -7710,8 +7717,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> > > >                                       offsetof(S, TF));                        \
> > > >                 *insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(S, F), tmp_reg,         \
> > > >                                       si->dst_reg, offsetof(S, F));            \
> > > > -               *insn++ = BPF_STX_MEM(                                         \
> > > > -                       BPF_FIELD_SIZEOF(NS, NF), tmp_reg, si->src_reg,        \
> > > > +               *insn++ = BPF_STX_MEM(SIZE, tmp_reg, si->src_reg,              \
> > > >                         bpf_target_off(NS, NF, FIELD_SIZEOF(NS, NF),           \
> > > >                                        target_size)                            \
> > > >                                 + OFF);                                        \
> > > > @@ -7723,8 +7729,8 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> > > >                                                       TF)                      \
> > > >         do {                                                                   \
> > > >                 if (type == BPF_WRITE) {                                       \
> > > > -                       SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF,    \
> > > > -                                                        TF);                  \
> > > > +                       SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE,   \
> > > > +                                                        OFF, TF);             \
> > > >                 } else {                                                       \
> > > >                         SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF(                  \
> > > >                                 S, NS, F, NF, SIZE, OFF);  \
