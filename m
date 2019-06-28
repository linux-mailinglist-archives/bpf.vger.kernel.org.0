Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6307C5A340
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 20:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF1SOd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 14:14:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37584 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfF1SOd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 14:14:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so5599999qkl.4;
        Fri, 28 Jun 2019 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQBJt5k5XIEtyxhj7uriI5Uz6ZpfRCSKwrxa7OQkTDA=;
        b=YgCshxwKygKi2hTeHh0CMZeHkpmgGhFH7vslGDmKMXCuF/ltiPBJo2JCWzgEPXoZ6I
         c81zdco4HwAxPZhhSTq/ldzj/bfa6OXmfc3RUX8cx381et0O3/XhzmsehjU2Pav3WZWN
         bx6npzPUf2xkpqzHIsoYGQV2FYLNfV0O3495jfQQewQid5/xVT/alIAgshMZnVUauN9e
         mBkjqIZ0WzZ9rNO0AHmlqnArnPqs1/9GCM/Dm5oram4YBjKFemSu0t0mUltLXzwq3Xxj
         GzP1VkJS6B7ELL2tns2UlsJFGYis/ClUFZcVAfYpZbRmppl5sGvS9rKnK16xoT2Q2jAW
         NeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQBJt5k5XIEtyxhj7uriI5Uz6ZpfRCSKwrxa7OQkTDA=;
        b=C84b57JLAQa1VuVryTIWj8o1HjSjOlLQHmWnK3tGHhOkq09RdUngpJE0F0aG5dA2hO
         jAmZLtpg97UNce28lBltP4v2vtAOrQCdlvDB5DCmGNodgBPOkt7QLuQ/+zqAgSLbPO+6
         CHMj6SJlUREyPI4pP5glCi8uOJCIYDdfVSSczWuR0mfBiuoQHkbxTeA3YB+I+JQPWK9P
         01/UV2ZDAZ7kkin+zM3UF3mxJ2lfuNV2h4iBU+mQ34ckhqkhRc14AK+UOB+An3T57tzw
         AFlAT7EV/4AxvRHfifGuuCCaz5o3RnDVl4jET4auwMW77LtivymulB8uSw1sv0zZ44sc
         VbQQ==
X-Gm-Message-State: APjAAAU0TWadm8a92YIGDYGtIUFBAu+Bvfod3AupxNGNKXdgDnZQvXU0
        eQw5DyUYyoJ0/Il59jf/gBkQAJa0ZwpziXpST9Q=
X-Google-Smtp-Source: APXvYqz2UZuV2gA7NnCbl060//e1+uRk9yGpebKzVN90FKyfRF+Gut/J6LLFUm8XWio8c9boAtTF1e5tF8fS+nS/TDw=
X-Received: by 2002:a37:a095:: with SMTP id j143mr10325047qke.449.1561745671678;
 Fri, 28 Jun 2019 11:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190627090446.GG7221@shao2-debian> <20190627155029.GC4866@mini-arch>
 <20190627172932.GD4866@mini-arch> <CAEf4Bzbf8OE9TUV2Pq7HZp3PYhoUgMzH-Gs+GMafTPwPc_jYxA@mail.gmail.com>
 <20190628023810.GF4866@mini-arch>
In-Reply-To: <20190628023810.GF4866@mini-arch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Jun 2019 11:14:20 -0700
Message-ID: <CAEf4BzbKkE0DYc0faaHThqyEbAu6qA1pFpUJ0uhX5xVd7Q7zSg@mail.gmail.com>
Subject: Re: [bpf/tools] cd17d77705: kernel_selftests.bpf.test_sock_addr.sh.fail
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        bpf <bpf@vger.kernel.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 27, 2019 at 7:38 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 06/27, Andrii Nakryiko wrote:
> > On Thu, Jun 27, 2019 at 10:29 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > >
> > > On 06/27, Stanislav Fomichev wrote:
> > > > On 06/27, kernel test robot wrote:
> > > > > FYI, we noticed the following commit (built with gcc-7):
> > > > >
> > > > > commit: cd17d77705780e2270937fb3cbd2b985adab3edc ("bpf/tools: sync bpf.h")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > >
> > > > > in testcase: kernel_selftests
> > > > > with following parameters:
> > > > >
> > > > >     group: kselftests-00
> > > > >
> > > > > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > > > > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > > > >
> > > > >
> > > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > > >
> > > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > >
> > > > > # 55: (18) r1 = 0x100000000000000
> > > > > # ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
> > > > > # 57: (7b) *(u64 *)(r6 +16) = r1
> > > > > # invalid bpf_context access off=16 size=8
> > > > This looks like clang doing single u64 write for user_ip6[2] and
> > > > user_ip6[3] instead of two u32. I don't think we allow that.
> > > >
> > > > I've seen this a couple of times myself while playing with some
> > > > progs, but not sure what's the right way to 'fix' it.
> > > >
> > > Any thoughts about the patch below? Another way to "fix" it
> >
> > I'll give it a more thorough look a bit later, but see my comments below.
> >
> > > would be to mark context accesses 'volatile' in bpf progs, but that sounds
> > > a bit gross.
> > >
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index 43b45d6db36d..34a14c950e60 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -746,6 +746,20 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
> > >         return size <= size_default && (size & (size - 1)) == 0;
> > >  }
> > >
> > > +static inline bool __bpf_ctx_wide_store_ok(u32 off, u32 size)
> >
> > It seems like bpf_ctx_wide_store_ok and __bpf_ctx_wide_store_ok are
> > used only inside net/core/filter.c, why declaring them in header file?
> I wanted it to be next to bpf_ctx_narrow_access_ok which does the
> reverse operation for reads.

Ah, ok, I see that bpf_ctx_narrow_access_ok is used in
kernel/bpf/cgroup.c as well and bpf_ctx_wide_store_ok might be useful
in some other contexts as well, let's keep it here.

>
> > > +{
> > > +       /* u64 access is aligned and fits into the field size */
> > > +       return off % sizeof(__u64) == 0 && off + sizeof(__u64) <= size;
> > > +}
> > > +
> > > +#define bpf_ctx_wide_store_ok(off, size, type, field) \
> > > +       (size == sizeof(__u64) && \
> > > +        off >= offsetof(type, field) && \
> > > +        off < offsetofend(type, field) ? \
> > > +       __bpf_ctx_wide_store_ok(off - offsetof(type, field), \
> > > +                                FIELD_SIZEOF(type, field)) : 0)

This would be sufficient, right?

#define bpf_ctx_wide_store_ok(off, size, type, field) \
        size == sizeof(__u64) &&                      \
        off >= offsetof(type, field) &&               \
        off + size <= offsetofend(type, field) &&     \
        off % sizeof(__u64) == 0

> >
> > Why do you need ternary operator instead of just a chain of &&s?
> Good point. I didn't spend too much time on the patch tbh :-)
> If it looks good in general, I can add proper tests and do a
> proper submition, this patch is just to get the discussion started.

Consider it started. :) Talking with Yonghong about preventing this
from happening in the first place in Clang, it seems like that would
be harder and more cumbersome than supporting in BPF verifier. So
please go ahead and submit a proper patch.

>
> > It also seems like you can avoid macro and use plain function if
> > instead of providing (type, field) you provide values of offsetof and
> > offsetofend (offsetofend - offsetof should equal FIELD_SIZEOF(type,
> > field), shouldn't it?).
> But then I'd have to copy-paste the args of offsetof/offsetofend at
> the caller, right? I wanted the caller to be clean and simple.

Yeah, that's a bit verbose, I agree. I don't mind macro, so no worries.

>
> > >  #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
> > >
> > >  static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 2014d76e0d2a..2d3787a439ae 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -6849,6 +6849,16 @@ static bool sock_addr_is_valid_access(int off, int size,
> > >                         if (!bpf_ctx_narrow_access_ok(off, size, size_default))
> > >                                 return false;
> > >                 } else {
> > > +                       if (bpf_ctx_wide_store_ok(off, size,
> > > +                                                 struct bpf_sock_addr,
> > > +                                                 user_ip6))
> > > +                               return true;
> > > +
> > > +                       if (bpf_ctx_wide_store_ok(off, size,
> > > +                                                 struct bpf_sock_addr,
> > > +                                                 msg_src_ip6))
> > > +                               return true;
> > > +
> > >                         if (size != size_default)
> > >                                 return false;
> > >                 }
> > > @@ -7689,9 +7699,6 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> > >  /* SOCK_ADDR_STORE_NESTED_FIELD_OFF() has semantic similar to
> > >   * SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF() but for store operation.
> > >   *
> > > - * It doesn't support SIZE argument though since narrow stores are not
> > > - * supported for now.
> > > - *
> > >   * In addition it uses Temporary Field TF (member of struct S) as the 3rd
> > >   * "register" since two registers available in convert_ctx_access are not
> > >   * enough: we can't override neither SRC, since it contains value to store, nor
> > > @@ -7699,7 +7706,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> > >   * instructions. But we need a temporary place to save pointer to nested
> > >   * structure whose field we want to store to.
> > >   */
> > > -#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF, TF)                       \
> > > +#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE, OFF, TF)         \
> > >         do {                                                                   \
> > >                 int tmp_reg = BPF_REG_9;                                       \
> > >                 if (si->src_reg == tmp_reg || si->dst_reg == tmp_reg)          \
> > > @@ -7710,8 +7717,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> > >                                       offsetof(S, TF));                        \
> > >                 *insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(S, F), tmp_reg,         \
> > >                                       si->dst_reg, offsetof(S, F));            \
> > > -               *insn++ = BPF_STX_MEM(                                         \
> > > -                       BPF_FIELD_SIZEOF(NS, NF), tmp_reg, si->src_reg,        \
> > > +               *insn++ = BPF_STX_MEM(SIZE, tmp_reg, si->src_reg,              \
> > >                         bpf_target_off(NS, NF, FIELD_SIZEOF(NS, NF),           \
> > >                                        target_size)                            \
> > >                                 + OFF);                                        \
> > > @@ -7723,8 +7729,8 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> > >                                                       TF)                      \
> > >         do {                                                                   \
> > >                 if (type == BPF_WRITE) {                                       \
> > > -                       SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF,    \
> > > -                                                        TF);                  \
> > > +                       SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE,   \
> > > +                                                        OFF, TF);             \
> > >                 } else {                                                       \
> > >                         SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF(                  \
> > >                                 S, NS, F, NF, SIZE, OFF);  \
