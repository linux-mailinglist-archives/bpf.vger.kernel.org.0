Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3282E0E40
	for <lists+bpf@lfdr.de>; Tue, 22 Dec 2020 19:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgLVSgS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Dec 2020 13:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgLVSgR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 13:36:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9755FC0613D6
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 10:35:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w1so37677pjc.0
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=RHrWPLOzICwiwcuEBCqBQJYWVfCDQlz1MVc+yIRnG98=;
        b=nOT2GhikKz9HXOssDvtQ2vaDZhYmyGBzPXOWSpwGoJmP6Ck4fI407MDsJv1ANIO8ri
         8Y/0GvH5ART2nTTEvM+E5NBGOmW++tCzemG46hs2fXtjSmd9j6ieCJteoWWIQX+hWxCA
         ns2/AJPNhqd2NakIjrUdp29Sr3c0UinBuaI2Sc9nGj9ChfUbKsxPNsFpumbSqvlX6qPl
         YdSWDGjx8l/kP4YlL9h0n4TGZSRfvynAignOpJpxCyv9izYC8vdaljrgbZ1U5n4b0sl2
         keJnltwftxfNRavu44LrILzuQrRtXVrMSdQvmHct+aO/VR4zEfq7un/hbDhqLLHiRiwI
         myJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=RHrWPLOzICwiwcuEBCqBQJYWVfCDQlz1MVc+yIRnG98=;
        b=nXq62Zt2YuYFrWwIQfYe3x1V8TvdbbotCvrt6lMV54AuROz/ec4qGooyA8NBX918Dw
         qTzv0C9HYP2ZvAKaTmM4+Wp2kwiRk64DjARLUEPI6v3Hhy4K+iouJK7RlmZpCsFiKw4v
         Denn85fphf58fEFcs3RHM105JQff47NFH4UuWnzxSWaOCgvWQMxEBOQmM8e9A0kJulhI
         ty9MjI7OBeIIi2jVZfXZPnB5ZTJVoA20BekVLz1hPgjB57BV6d6rDdOP+KjecoT5/me8
         qzqr1AiWCq608PAQ15kmboydE28M/Vrc8PmfPclM3l/e98frlcMO35l6IGl1KNNHezf1
         qljQ==
X-Gm-Message-State: AOAM531VCjwWYSN9wT8NqOqMKRjSr9tbg7nL7kTTAj9+RF4gj0o8CHIO
        5LftgHAicz8sT9f8Fzk19qyv8XsaslT4qg==
X-Google-Smtp-Source: ABdhPJxPgMm2SdK3F/JBU9AQEik8o4CefKLp1mF1+ra9LZdOVv/+MSi3QcsuAPG/xfyZ2nu6Bm483w==
X-Received: by 2002:a17:90b:1202:: with SMTP id gl2mr23785419pjb.123.1608662137076;
        Tue, 22 Dec 2020 10:35:37 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id u12sm19895202pfn.88.2020.12.22.10.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:35:36 -0800 (PST)
Date:   Tue, 22 Dec 2020 10:35:27 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org
Message-ID: <5fe23c6f56a18_838a20825@john-XPS-13-9370.notmuch>
In-Reply-To: <CABWLseseugQxOXj5PDOsZ+nvadPfY_Uvt6wZaOpqjyBBXA+WRQ@mail.gmail.com>
References: <CABWLseseugQxOXj5PDOsZ+nvadPfY_Uvt6wZaOpqjyBBXA+WRQ@mail.gmail.com>
Subject: RE: verifier rejects program under O2, works under O3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrei Matei wrote:
> Hello friends,
> 
> I've run into an issue on my first BPF program of non-trivial size.
> The verifier rejects a program that, I believe, it "should" accept.
> Even more interesting than the rejection is the fact that the program
> is accepted when compiling with clang -03 instead of the original -02.
> Also interesting is that, in the -O2 case, a simple change that should
> be equivalent from at the C semantics level also makes it work.

[...]

> See build instructions at the bottom.
> 
> The tail of its logs below. The full logs are here:
> https://gist.github.com/andreimatei/2242c5f6455a12e6c1ff5d76fd577a69
> 

Would help to see a bit more logs here so we know where r2 came
from. 

> ; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
> 194: (bf) r9 = r2
> 195: (07) r9 += 1
> ; immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.
> 196: (67) r9 <<= 32
> 197: (77) r9 >>= 32
> 198: (bf) r8 = r6
> 199: (0f) r8 += r9
> 200: (71) r8 = *(u8 *)(r8 +4)
>  frame1: R0=invP0 R1=invP0
> R2=invP(id=3,umax_value=4294967295,var_off=(0x0; 0xffffffff))

boounds on r2 are effectively any 32bit value here, so shifting
bits around after assigning to r9 doesn't do anything.

> R3=map_value(id=0,off=72,ks=4,vs=272,imm=0) R4=invP10
> R5=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> R6=map_value(id=0,off=24,ks=4,vs=272,imm=0) R7=fp-40
> R8_w=map_value(id=0,off=24,ks=4,vs=272,umax_value=4294967295,var_off=(0x0;
> 0xffffffff)) R9_w=invP(id=0,umax_value=4294967295,var_off=(0x0;
> 0xffffffff)) R10=fp0 fp-8=??????mm fp-16=mmmmmmmm fp-24=mmmmmmmm
> fp-32=fp
> R8 unbounded memory access, make sure to bounds check any such access
> processed 112 insns (limit 1000000) max_states_per_insn 0 total_states
> 8 peak_states 8 mark_read 2

This happens because R9 is bounded only with umax_falue=0xffffFFFF
and 'r8 += r9' means r8 is the same. So verifier is right, not a valid
access from above snippet.

You need to walk back r2 and see why its not bounded. Either its
not bounded in your code or verifier lost it somewhere. Its
perhaps an interesting case if the verifier lost the bounds so we
can track it better.

[...]

> Again, this works under -O3. It also works if I change the line
> immediate = instr[ip+1];

Posting relevant block of code inline the email that is passing with
-O3 would perhaps be helpful. I guess its just chance moving of
registers around and unlikely that useful though.

> to
> immediate = *(instr + ip + 1);
> 
> So, if I do the pointer arithmetic by hand, it works.
> 
> I've analyzed the assembly being produced in a couple of cases, and
> have a (likely random) observation. In both of the cases that work
> (i.e. -O3 and manual pointer arithmetic), the line in question ends up
> compiling to a load that uses register as the source address, and a
> *different* register as the destination. In the case that doesn't
> work, the same register is used. This is a long shot, but - is it
> possible that the verifier gets confused when a register is
> overwritten like this?
> The assembly output (clang -S) can be found here:
> https://github.com/andreimatei/bpfdwarf/tree/verifier-O2-O3/assembly
> 1) the original program (accessing instr as an array), compiled with -O2 (fails)
> 2) the original program (accessing instr as an array), compiled with
> -O3 (succeeds)
> 3) the modified program, accessing instr as a pointer, compiled with
> -O2 (succeeds)

Best to just inline the relevant blocks. Sorry don't really have time
to dig through that asm to find relevant snippets for 03/02 etc.

[...]
 
> I also have another random observation: in all the versions of the
> assembly listed above, there's a pattern for clearing the high-order
> bits of a word, happening around the variable used to index into the
> offset:
> r9 <<= 32
> r9 >>= 32
> These instructions are there, I believe, in order to get the right
> addition overflow behavior in the 32bit domain. I'm thinking there's a
> chance that this has something to do with the verifier sometimes
> losing track of some register bounds (although, again, the pattern
> appears even when the program loads fine). I say this because another
> way I've gotten my program to work is by changing the index variable
> to be a 64bit type.

Its zero'ing upper bits because its an int in C code. Try compiling
with alu32 enabled and a lot of that will go away. Likely your
program will not hit the above verifier warning either is my guess.

Add --mcpu=v3 to your LLC_FLAGS.

Alternatively you can change some of those ints to 64bit types so
compiler doesn't believe it needs to zero upper bits.

.John
