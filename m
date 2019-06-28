Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5504E5913A
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 04:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF1CiM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 22:38:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41219 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF1CiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 22:38:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so2172520pff.8
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+GLZ8M6m+0RiomYK5+gI+yu7sTNTSRUBHps1OHnh/A=;
        b=qDntbU8G38cfZcDrqbTvKfyIyS4PnVVQdM/rkqtCu43rh9MpBivm7CbKPCsy/yhUTS
         wRWwbxr8tQSWvngDmyCa3iqNVDKvBh+7lznv86EmwBf6zX9r5McrPnvJTwhWpq0o0XIo
         JrnbckqJsTsgIXXBZwB4F26jCSyUCGlc/2kB19escyrQDiP38Spb2g0bZLXY4g8gypgT
         LBreZQtAp5Jf6BEqXBTolQKJDW5wrMxzYb5+hz1UEMUKvteHRk8xNMD8zSuJauGGV1Mq
         Oeg66KJMO/dKbW/9+28PNa+QwFDjqYir5oUfHtmZosichOUlOM5on8TKJsC4osY3PwI5
         Sbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+GLZ8M6m+0RiomYK5+gI+yu7sTNTSRUBHps1OHnh/A=;
        b=XykoQp5ChZdJ3AkUnkPCuCpdpmisfn87RhHishtdNWAiXcYGleEmTfsSSzN18FI0W+
         gbZsGl4kjeCPSFiHzgJ0kirj1fw1l9yWO4yXDeME6rtBer2VI54RGiol5jfaSSdEewqA
         tr2e4ygESCqUuSG275qudWJL83Xc+re8yskoufIH87g4hI84x7CmKsXWUgffFbQwM9e5
         LebvB/zeTp8pdWGUxJWBJuYQ++ZrzFj+8Cb1JRKTiK8uw3xHulm2tSSDOyUiUOuMq6fC
         3cFq5dEaMxfzuwdwTozHdBEXfl6ThQckQmg6xBR6EsUnKMCuCsyBsjQ7W/mkQqkRntUF
         ZoKA==
X-Gm-Message-State: APjAAAUw3xwFCLBSgkPpTsbty9ZqFWXDmvGzXeu0vTgZ05xChjAqHQvh
        mmSLaJIP+r8htK3cXkL1NTSx0w==
X-Google-Smtp-Source: APXvYqxUAXmRXenMPdCCnV02LqbuIin87jCuhFY2druebwVMqBcL7dQC6Q8odc74AdYxOxdC6QeDbQ==
X-Received: by 2002:a17:90a:216f:: with SMTP id a102mr10217638pje.29.1561689491546;
        Thu, 27 Jun 2019 19:38:11 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id v184sm440013pfb.82.2019.06.27.19.38.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 19:38:11 -0700 (PDT)
Date:   Thu, 27 Jun 2019 19:38:10 -0700
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
Message-ID: <20190628023810.GF4866@mini-arch>
References: <20190627090446.GG7221@shao2-debian>
 <20190627155029.GC4866@mini-arch>
 <20190627172932.GD4866@mini-arch>
 <CAEf4Bzbf8OE9TUV2Pq7HZp3PYhoUgMzH-Gs+GMafTPwPc_jYxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbf8OE9TUV2Pq7HZp3PYhoUgMzH-Gs+GMafTPwPc_jYxA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/27, Andrii Nakryiko wrote:
> On Thu, Jun 27, 2019 at 10:29 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 06/27, Stanislav Fomichev wrote:
> > > On 06/27, kernel test robot wrote:
> > > > FYI, we noticed the following commit (built with gcc-7):
> > > >
> > > > commit: cd17d77705780e2270937fb3cbd2b985adab3edc ("bpf/tools: sync bpf.h")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > >
> > > > in testcase: kernel_selftests
> > > > with following parameters:
> > > >
> > > >     group: kselftests-00
> > > >
> > > > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > > > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > > >
> > > >
> > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > >
> > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > >
> > > > # 55: (18) r1 = 0x100000000000000
> > > > # ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
> > > > # 57: (7b) *(u64 *)(r6 +16) = r1
> > > > # invalid bpf_context access off=16 size=8
> > > This looks like clang doing single u64 write for user_ip6[2] and
> > > user_ip6[3] instead of two u32. I don't think we allow that.
> > >
> > > I've seen this a couple of times myself while playing with some
> > > progs, but not sure what's the right way to 'fix' it.
> > >
> > Any thoughts about the patch below? Another way to "fix" it
> 
> I'll give it a more thorough look a bit later, but see my comments below.
> 
> > would be to mark context accesses 'volatile' in bpf progs, but that sounds
> > a bit gross.
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 43b45d6db36d..34a14c950e60 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -746,6 +746,20 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
> >         return size <= size_default && (size & (size - 1)) == 0;
> >  }
> >
> > +static inline bool __bpf_ctx_wide_store_ok(u32 off, u32 size)
> 
> It seems like bpf_ctx_wide_store_ok and __bpf_ctx_wide_store_ok are
> used only inside net/core/filter.c, why declaring them in header file?
I wanted it to be next to bpf_ctx_narrow_access_ok which does the
reverse operation for reads.

> > +{
> > +       /* u64 access is aligned and fits into the field size */
> > +       return off % sizeof(__u64) == 0 && off + sizeof(__u64) <= size;
> > +}
> > +
> > +#define bpf_ctx_wide_store_ok(off, size, type, field) \
> > +       (size == sizeof(__u64) && \
> > +        off >= offsetof(type, field) && \
> > +        off < offsetofend(type, field) ? \
> > +       __bpf_ctx_wide_store_ok(off - offsetof(type, field), \
> > +                                FIELD_SIZEOF(type, field)) : 0)
> 
> Why do you need ternary operator instead of just a chain of &&s?
Good point. I didn't spend too much time on the patch tbh :-)
If it looks good in general, I can add proper tests and do a
proper submition, this patch is just to get the discussion started.

> It also seems like you can avoid macro and use plain function if
> instead of providing (type, field) you provide values of offsetof and
> offsetofend (offsetofend - offsetof should equal FIELD_SIZEOF(type,
> field), shouldn't it?).
But then I'd have to copy-paste the args of offsetof/offsetofend at
the caller, right? I wanted the caller to be clean and simple.

> >  #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
> >
> >  static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 2014d76e0d2a..2d3787a439ae 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -6849,6 +6849,16 @@ static bool sock_addr_is_valid_access(int off, int size,
> >                         if (!bpf_ctx_narrow_access_ok(off, size, size_default))
> >                                 return false;
> >                 } else {
> > +                       if (bpf_ctx_wide_store_ok(off, size,
> > +                                                 struct bpf_sock_addr,
> > +                                                 user_ip6))
> > +                               return true;
> > +
> > +                       if (bpf_ctx_wide_store_ok(off, size,
> > +                                                 struct bpf_sock_addr,
> > +                                                 msg_src_ip6))
> > +                               return true;
> > +
> >                         if (size != size_default)
> >                                 return false;
> >                 }
> > @@ -7689,9 +7699,6 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> >  /* SOCK_ADDR_STORE_NESTED_FIELD_OFF() has semantic similar to
> >   * SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF() but for store operation.
> >   *
> > - * It doesn't support SIZE argument though since narrow stores are not
> > - * supported for now.
> > - *
> >   * In addition it uses Temporary Field TF (member of struct S) as the 3rd
> >   * "register" since two registers available in convert_ctx_access are not
> >   * enough: we can't override neither SRC, since it contains value to store, nor
> > @@ -7699,7 +7706,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> >   * instructions. But we need a temporary place to save pointer to nested
> >   * structure whose field we want to store to.
> >   */
> > -#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF, TF)                       \
> > +#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE, OFF, TF)         \
> >         do {                                                                   \
> >                 int tmp_reg = BPF_REG_9;                                       \
> >                 if (si->src_reg == tmp_reg || si->dst_reg == tmp_reg)          \
> > @@ -7710,8 +7717,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> >                                       offsetof(S, TF));                        \
> >                 *insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(S, F), tmp_reg,         \
> >                                       si->dst_reg, offsetof(S, F));            \
> > -               *insn++ = BPF_STX_MEM(                                         \
> > -                       BPF_FIELD_SIZEOF(NS, NF), tmp_reg, si->src_reg,        \
> > +               *insn++ = BPF_STX_MEM(SIZE, tmp_reg, si->src_reg,              \
> >                         bpf_target_off(NS, NF, FIELD_SIZEOF(NS, NF),           \
> >                                        target_size)                            \
> >                                 + OFF);                                        \
> > @@ -7723,8 +7729,8 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
> >                                                       TF)                      \
> >         do {                                                                   \
> >                 if (type == BPF_WRITE) {                                       \
> > -                       SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF,    \
> > -                                                        TF);                  \
> > +                       SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE,   \
> > +                                                        OFF, TF);             \
> >                 } else {                                                       \
> >                         SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF(                  \
> >                                 S, NS, F, NF, SIZE, OFF);  \
