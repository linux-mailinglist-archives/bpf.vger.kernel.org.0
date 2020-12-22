Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7C22E1010
	for <lists+bpf@lfdr.de>; Tue, 22 Dec 2020 23:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgLVWUA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Dec 2020 17:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgLVWUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 17:20:00 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5CC0613D3
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 14:19:19 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id q1so13356399ilt.6
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 14:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP5USv9svPR6lf0Rj/I43sZZ0ONM7IShtkgr6TcRHeM=;
        b=vgH2d0gYRhHyNl47piil+Ptq4GvIyaQf+k8K2BuWl5thcVIOeC6NRYIytSS7DZsObZ
         QVqeB6LPPkhdY1sD26vsmtDgE8cuv7haA4CoNge7xSflNWcvUKTy04//zUpnDA0PRRFK
         TGwPKZSR4phOkZQ/W32QWzFIG+WHkOR3XOPshIw4u/Cbj8+OD6PYPdukOu1OzLVBmZNM
         6scj9e96u94xtgri4n3wW/WJrCEsRCMRSgqsfoewS1+VRK/e3YhBX4j+H3R8BwGG6M3b
         gixEr7VA/y3mdSdYXXV0ZvoYmi+9OsiyXOEoLV+vZnKaPvCcMfj6NCWNdMEs54bQI0Pp
         XQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP5USv9svPR6lf0Rj/I43sZZ0ONM7IShtkgr6TcRHeM=;
        b=YBndAzCFZCm6q46afBTqhU1DqpMuRfg1JJzeROn/MKBQvfL+z6HJDOa824dAznKFLW
         tQV00WpcL8Bqcz/Pcq4+BqVujMo+atXrMUpAgvqBWYTwfvd2/ScPirPUkhv10KsRMrl+
         ggJ8s4uZzI7qQZC6aANQjXR0xDPDyk4lfQifEPMEshjOBCIeWB1f6Jsbg+ZSJwXLkLaj
         tA2SvOyG/EsduDQq+vr4AGjELN3gXZpwiGuGu5MT7ObV52YAguKW83F11BfwjKbpuVLZ
         r8KdlX0yo1lmxOuD6pW7gqNdHghd2kXaQhBfxNXblX2eIApa0Me2RXTnW0D6Ul4OZFaE
         U2Tw==
X-Gm-Message-State: AOAM532Cd3j66+HPuuwVwj8YAHmd1pzVs7YWUPg+QslWT2ZpUCz/oPpd
        m/QNl5r/rby0f+i2FntlB9j1LKvY/WLnSZQfhV0=
X-Google-Smtp-Source: ABdhPJzzom2M/1+/evpKg8rFa1/hgPxPGdtX5DDNSq5zB1aTV4GlzwGjeRlA8HLqRjRrz6/ap0yynNU5U5TzBtHXJGk=
X-Received: by 2002:a05:6e02:188f:: with SMTP id o15mr22675431ilu.308.1608675558970;
 Tue, 22 Dec 2020 14:19:18 -0800 (PST)
MIME-Version: 1.0
References: <CABWLseseugQxOXj5PDOsZ+nvadPfY_Uvt6wZaOpqjyBBXA+WRQ@mail.gmail.com>
 <5fe23c6f56a18_838a20825@john-XPS-13-9370.notmuch>
In-Reply-To: <5fe23c6f56a18_838a20825@john-XPS-13-9370.notmuch>
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Tue, 22 Dec 2020 17:19:07 -0500
Message-ID: <CABWLsetVRaCo8GqvwDaTFxpn2DzaxmxYBXtEc2Awk_5myC7Rqg@mail.gmail.com>
Subject: Re: verifier rejects program under O2, works under O3
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, "Raphael 'Kena' Poss" <knz@thaumogen.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

OK, I've stared at the assembly for a while and believe I now
understand what's going on. I think the issue is that the verifier
does not "back-propagate" boundaries at the sub-register level, and
this causes it to miss opportunities to later have proper bounds on
other registers. I'm making assumptions about what the verifier does
and doesn't do, but here's what I see. To clarify, I'm not looking for
suggestions about how to get my code to load (I believe I understand
how to do that), but I want to see if there's an opportunity to
improve the verifier.

First, my abridged code in order to get some sympathy, as it seems
like it should work.

const unsigned int ip = p->ip;
unsigned char* instr = p->instr;
if (ip >= (PROG_MAX_INSTR - 2)) { return 189; }
long immediate;
unsigned char ins = instr[ip];
...
immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.

The verifier claims that `ip + 1` is unbounded, but it is bounded
because of the `if (ip >= (PROG_MAX_INSTR - 2)` part. But, alas, there
are different types at play here. `ip` and `p->ip` are ints (32bit),
so they don't always occupy full registers.
Now the relevant -O2 assembly, with my commentary.

; CHECK_PROG(prog);
124: (61) r2 = *(u32 *)(r6 +0)
 frame1: R0_w=invP(id=0) R1_w=invP0
R3_w=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4_w=invP10
R6_w=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7_w=fp-40 R10=fp0
fp-8=??????mm fp-16_w=mmmmmmmm fp-24_w=mmmmmmmm fp-32_w=fp

# ^- r2 starts here as an unbounded value. I'm surprised I don't  see
it listed in this frame1; is that expected? In any case, we'll see it
listed later.

125: (05) goto pc+46
; CHECK_PROG(prog);
172: (bf) r0 = r2
173: (67) r0 <<= 32
174: (77) r0 >>= 32
;
175: (b7) r9 = 1
; CHECK_PROG(prog);
176: (25) if r0 > 0x9 goto pc+36
 frame1: R0_w=invP(id=0,umax_value=9,var_off=(0x0; 0xf)) R1=invP0
R2=invP(id=3,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4=invP10
R6=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7=fp-40 R9_w=invP1
R10=fp0 fp-8=??????mm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=fp

# ^- notice how we copied r0 = r2, zero'ed out r0's high-order bits,
and then put a bound on r0. And note how R2 is now listed as
unbounded. An opportunity was seemingly lost here - we have some
information about R2, which could save me later.

(omitted some irrelevant assembly)

180: (bf) r0 = r2
181: (67) r0 <<= 32
182: (77) r0 >>= 32
; if (ip >= (PROG_MAX_INSTR - 2)) { return 189; }
183: (25) if r0 > 0x7 goto pc+29
 frame1: R0=invP(id=0,umax_value=7,var_off=(0x0; 0x7)) R1=invP0
R2=invP(id=3,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4=invP10
R5=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7=fp-40 R9=invP189
R10=fp0 fp-8=??????mm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=fp
; unsigned char ins = instr[ip];

# ^- same dance as before; we copy r2 to r0 and put a bound on r0

(omitted)

; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
194: (bf) r9 = r2
195: (07) r9 += 1
; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
196: (67) r9 <<= 32
197: (77) r9 >>= 32
198: (bf) r8 = r6
199: (0f) r8 += r9
200: (71) r8 = *(u8 *)(r8 +4)
 frame1: R0=invP0 R1=invP0
R2=invP(id=3,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R3=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4=invP10
R5=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
R6=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7=fp-40
R8_w=map_value(id=0,off=24,ks=4,vs=272,umax_value=4294967295,var_off=(0x0;
0xffffffff)) R9_w=invP(id=0,umax_value=4294967295,var_off=(0x0;
0xffffffff)) R10=fp0 fp-8=??????mm fp-16=mmmmmmmm fp-24=mmmmmmmm
fp-32=fp
R8 unbounded memory access, make sure to bounds check any such access
processed 112 insns (limit 1000000) max_states_per_insn 0 total_states
8 peak_states 8 mark_read 2

# ^- here at the end we copy r2 to r9, do similar zeroing, and then
use r9 in the failing load: r8 = *(u8 *)(r6 + r9 +4). Since r2 and r9
are not bound, it doesn't work.

I'm thinking that, *if* we would have kept a bound on the lower 32
bits of r2, and *if* we would have propagated that bound to the lower
bits of r9, *and if* we would have inferred from `r9 >>= 32` that the
higher bits of r9 are 0, then it would have all gloriously worked out
for the memory access. Does that seem feasible at all?
A side question - does the verifier handle simpler cases like:
r2 = r1
if r2 > 10 goto ...
At this point, is there a limit on r1 (besides the limit on r2)?

I also have a more general question: are situations like this, where
something works with some level of optimizations but not others,
automatically a cause of concern for the verifier? Does the verifier
aim to be smart enough to be fairly resilient to clang optimizations,
or is that a lost cause?

Thank you!

On Tue, Dec 22, 2020 at 1:35 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Andrei Matei wrote:
> > Hello friends,
> >
> > I've run into an issue on my first BPF program of non-trivial size.
> > The verifier rejects a program that, I believe, it "should" accept.
> > Even more interesting than the rejection is the fact that the program
> > is accepted when compiling with clang -03 instead of the original -02.
> > Also interesting is that, in the -O2 case, a simple change that should
> > be equivalent from at the C semantics level also makes it work.
>
> [...]
>
> > See build instructions at the bottom.
> >
> > The tail of its logs below. The full logs are here:
> > https://gist.github.com/andreimatei/2242c5f6455a12e6c1ff5d76fd577a69
> >
>
> Would help to see a bit more logs here so we know where r2 came
> from.
>
> > ; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
> > 194: (bf) r9 = r2
> > 195: (07) r9 += 1
> > ; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
> > 196: (67) r9 <<= 32
> > 197: (77) r9 >>= 32
> > 198: (bf) r8 = r6
> > 199: (0f) r8 += r9
> > 200: (71) r8 = *(u8 *)(r8 +4)
> >  frame1: R0=invP0 R1=invP0
> > R2=invP(id=3,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>
> boounds on r2 are effectively any 32bit value here, so shifting
> bits around after assigning to r9 doesn't do anything.
>
> > R3=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4=invP10
> > R5=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> > R6=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7=fp-40
> > R8_w=map_value(id=0,off=24,ks=4,vs=272,umax_value=4294967295,var_off=(0x0;
> > 0xffffffff)) R9_w=invP(id=0,umax_value=4294967295,var_off=(0x0;
> > 0xffffffff)) R10=fp0 fp-8=??????mm fp-16=mmmmmmmm fp-24=mmmmmmmm
> > fp-32=fp
> > R8 unbounded memory access, make sure to bounds check any such access
> > processed 112 insns (limit 1000000) max_states_per_insn 0 total_states
> > 8 peak_states 8 mark_read 2
>
> This happens because R9 is bounded only with umax_falue=0xffffFFFF
> and 'r8 += r9' means r8 is the same. So verifier is right, not a valid
> access from above snippet.
>
> You need to walk back r2 and see why its not bounded. Either its
> not bounded in your code or verifier lost it somewhere. Its
> perhaps an interesting case if the verifier lost the bounds so we
> can track it better.
>
> [...]
>
> > Again, this works under -O3. It also works if I change the line
> > immediate = instr[ip+1];
>
> Posting relevant block of code inline the email that is passing with
> -O3 would perhaps be helpful. I guess its just chance moving of
> registers around and unlikely that useful though.
>
> > to
> > immediate = *(instr + ip + 1);
> >
> > So, if I do the pointer arithmetic by hand, it works.
> >
> > I've analyzed the assembly being produced in a couple of cases, and
> > have a (likely random) observation. In both of the cases that work
> > (i.e. -O3 and manual pointer arithmetic), the line in question ends up
> > compiling to a load that uses register as the source address, and a
> > *different* register as the destination. In the case that doesn't
> > work, the same register is used. This is a long shot, but - is it
> > possible that the verifier gets confused when a register is
> > overwritten like this?
> > The assembly output (clang -S) can be found here:
> > https://github.com/andreimatei/bpfdwarf/tree/verifier-O2-O3/assembly
> > 1) the original program (accessing instr as an array), compiled with -O2 (fails)
> > 2) the original program (accessing instr as an array), compiled with
> > -O3 (succeeds)
> > 3) the modified program, accessing instr as a pointer, compiled with
> > -O2 (succeeds)
>
> Best to just inline the relevant blocks. Sorry don't really have time
> to dig through that asm to find relevant snippets for 03/02 etc.
>
> [...]
>
> > I also have another random observation: in all the versions of the
> > assembly listed above, there's a pattern for clearing the high-order
> > bits of a word, happening around the variable used to index into the
> > offset:
> > r9 <<= 32
> > r9 >>= 32
> > These instructions are there, I believe, in order to get the right
> > addition overflow behavior in the 32bit domain. I'm thinking there's a
> > chance that this has something to do with the verifier sometimes
> > losing track of some register bounds (although, again, the pattern
> > appears even when the program loads fine). I say this because another
> > way I've gotten my program to work is by changing the index variable
> > to be a 64bit type.
>
> Its zero'ing upper bits because its an int in C code. Try compiling
> with alu32 enabled and a lot of that will go away. Likely your
> program will not hit the above verifier warning either is my guess.
>
> Add --mcpu=v3 to your LLC_FLAGS.
>
> Alternatively you can change some of those ints to 64bit types so
> compiler doesn't believe it needs to zero upper bits.
>
> .John
