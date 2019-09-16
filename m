Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034E2B3EBA
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfIPQSU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 12:18:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38596 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfIPQSU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 12:18:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so192236pfe.5
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 09:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i5luvagxCyY9ilv6QN0gqEM5QjMbfarfmsulZggG6O0=;
        b=ppnAirOZAJlKkoEnwC7UC0Ev6EiHbHcy9A3E7k5YYJjFuyxRJs3hzu9vIfcqlz7/Y/
         WihUHsuy/UrRAAGf8NtydYRgXP7utOMsZwYpwvTRvd1ZaaLf22TNm1qxx6qej0OAblyY
         LqFATOwhBy2LfDXNSaeS4P9VF65HiJM/t5C3Mp5WYAyf+OsNvdTc+liEouyjrv5ZUT0K
         BOF1whMKh+VZ3x/eUcyM7W98BVZRkgWlazYlrvulDYN+42dlEcNrOJA3432Ysva0wkR5
         jK175EcTfH04SO+BuSKn2K2zZEJ24tu2XCuhok2NYBFsoTZm4cL/R3anRR+K+eaOr0bf
         SJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i5luvagxCyY9ilv6QN0gqEM5QjMbfarfmsulZggG6O0=;
        b=BPvsmNuLmXH3mUt/6BnhiGQFvRKbhTLOlRO8caZoY6IB5kbRSJpVlkgMcmEtKbvKGE
         Y08UdVeede4tIDxR0YLxHplUe4YFCom9b7opRsEPz1JMgz1RyLBNX+33RgcwBNyd5qBh
         LG3GKtLwbnHu9oNBIoL4m9HJ0Hcdj3iR0+wVVz3l5X2tGawjjeS2lgui+wJyqXqm9Z8l
         P7JPA9L4e2Ssbki9m+yBohnKquAFARij6MEJcd1JedXU4mCOI+nsfgT9aV1dm5CJ7XhM
         IXUgYyQH9Hg0TJYua5jKg4dh7bqHvMKVao0fDlqyKFw4BhddtZRSLE+7OCexrCy48E9u
         jMoQ==
X-Gm-Message-State: APjAAAVAcz5pMzuaKMY8w7KGMZ21cUR9Jtn1SO5WgdDyaUx/AbmvDI0M
        7AM6eZYOPNhqvF+pTbrij7pNfyBh
X-Google-Smtp-Source: APXvYqwHQnoiPL0lI4ND//bNPzKYO7c4vk5mPX/Lk/37PoMPdolojpawHq8MqqVLjCQmQaE21i4HYw==
X-Received: by 2002:a62:4e52:: with SMTP id c79mr144480pfb.28.1568650699167;
        Mon, 16 Sep 2019 09:18:19 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::3:c644])
        by smtp.gmail.com with ESMTPSA id 127sm6121353pfc.115.2019.09.16.09.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 09:18:18 -0700 (PDT)
Date:   Mon, 16 Sep 2019 09:18:17 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net
Subject: Re: [GCC,LLVM] bpf_helpers.h
Message-ID: <20190916161742.54yabm3plqert2af@ast-mbp>
References: <87lfutgvsu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfutgvsu.fsf@oracle.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 12, 2019 at 09:26:57PM +0200, Jose E. Marchesi wrote:
> 
> Hi people!
> 
> First of all, many thanks for the lots of feedback I got at the LPC
> conference.  It was very useful and made these days totally worth it :)
> 
> In order to advance in the direction of having a single bpf_helpers.h
> header that works with both llvm and gcc, I would like to suggest a few
> changes for the kernel's header.
> 
> Kernel helpers
> --------------
> 
> First, there is the issue of kernel helpers.  You people made it very
> clear at LPC that having a compiler built-in function per kernel helper
> is way too restrictive, since it makes it impossible to use new kernel
> helpers without patching the compiler.  I agree.
> 
> However, I still think that the function pointer hack currently used in
> bpf_helpers.h is way too fragile, depending on the optimization level
> and the particular behavior of the compiler.
> 
> Thinking about a more robust and flexible solution, today I wrote a
> patch for GCC that adds a target-specific function attribute:
> 
>    __attribute__ ((kernel_helper (NUM)))
> 
> Then I changed my bpf-helpers.h to define the kernel helpers like:
> 
>    void *bpf_map_lookup_elem (void *map, const void *key)
>       __attribute__ ((kernel_helper (1)));
> 
> This new mechanism allows the user to mark any function prototype as a
> kernel helper, so the flexibility is total.  It also allowed me to get
> rid of the table of helpers in the GCC backend proper, which is awesome
> :)
> 
> Would you consider implementing this attribute in llvm and adapt the
> kernel's bpf_header accordingly?  In that respect, note that it is
> possible to pass enum entries to the attribute (at least in GCC.)  So
> you once you implement the attribute, you should be able to do:
> 
>    void *bpf_map_lookup_elem (void *map, const void *key)
>        __attribute__ ((kernel_helper (BPF_FUNC_map_lookup_elem)));
> 
> instead of the current:
> 
>    static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
> 	(void *) BPF_FUNC_map_lookup_elem;

What we've been using for long time is not exactly normal C code,
but it's a valid C code that any compiler and any backend should
consume and generate the code prescribed by the language.
Here it says that it's a function pointer with fixed offset.
x86 backends in both clang and gcc do the right thing.
I don't understand why it's causing bpf backend for gcc to stumble.
You mentioned "helper table in gcc bpf backend".
That sounds like a red flag.
The backend should not know names and numbers for helpers.
For the following:
static void (*foo)(void) = (void *) 123;
int bar()
{
        foo();
}
It should generate bpf instruction 'bpf_call 123', since that's
what C language is asking compiler to do.

It is as you pointed out 'fragile', since it won't work with -O0,
but that sort of the point. -O0 is too debuggy and un-optimized
that even without this call insn quirk the verifier is not able
to analyze even simple programs.
Hence -O2 was a requirement for bpf development due to verifier smartness.
One can argue that the verifier should become even smarter and analyze -O0 code,
but I would argue otherwise. Linux kernel itself won't work with -O0.
Same reasoning applies to bpf code. The main purpose of -O0 for user space
development is to produce code together with -g that debugger can understand.
The variables will stay on stack, line numbers will be intact, etc
For bpf program development that's anti pattern.
The 'bpf debugging' topic at plumbers showed that we still has a long way
to go to make bpf debugging better. Single step, execution trace, nested bpf, etc
All that will come, but -O0 support will not.

> Please let me know what do you think.
> 
> SKB load built-ins
> ------------------
> 
> bpf_helpers.h contains the following llvm-isms:
> 
>    /* llvm builtin functions that eBPF C program may use to
>     * emit BPF_LD_ABS and BPF_LD_IND instructions
>     */
>    struct sk_buff;
>    unsigned long long load_byte(void *skb,
>                                 unsigned long long off) asm("llvm.bpf.load.byte");
>    unsigned long long load_half(void *skb,
> 			        unsigned long long off) asm("llvm.bpf.load.half");
>    unsigned long long load_word(void *skb,
> 			        unsigned long long off) asm("llvm.bpf.load.word");
> 
> Would you consider adopting more standard built-ins in llvm, like I
> implemented in GCC?  These are:
> 
>    __builtin_bpf_load_byte (unsigned long long off)
>    __builtin_bpf_load_half (unsigned long long off)
>    __builtin_bpf_load_word (unsigned long long off)
> 
> Note that I didn't add an SKB argument to the builtins, as it is not
> used: the pointer to the skb is implied by the instructions to be in
> some predefined register.  I added compatibility wrappers in my
> bpf-helpers.h:
> 
>   #define load_byte(SKB,OFF) __builtin_bpf_load_byte ((OFF))
>   #define load_half(SKB,OFF) __builtin_bpf_load_half ((OFF))
>   #define load_word(SKB,OFF) __builtin_bpf_load_word ((OFF))
> 
> Would you consider removing the unused SKB arguments from the built-ins
> in llvm?  Or is there a good reason for having them, other than maybe
> backwards compatibility?  In case backwards compatibility is a must, I
> can add the unused argument to my builtins.

llvm.bpf.load.word consumes 'skb' pointer. llvm bpf backend makes sure
that it's in R6 before LD_ABS insn.
__builtin_bpf_load_byte (unsigned long long off) cannot produce correct code.

As far as doing it as __builtin_bpf_load_word(skb, off) instead of
asm("llvm.bpf.load.word") that's fine, of course.
Here compilers don't have to be the same.
#ifdef clang vs gcc in bpf_helpers.h should do it.
Also please get rid of bpf-helpers.h from gcc tree.
There shouldn't be such things shipped with compiler.

