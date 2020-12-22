Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133F12E0E01
	for <lists+bpf@lfdr.de>; Tue, 22 Dec 2020 18:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgLVRz4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Dec 2020 12:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgLVRzz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 12:55:55 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54694C0613D3
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 09:55:15 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id m23so12777017ioy.2
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 09:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WtdI3D3kn5MSp02VNkDOGkX1HTuAVPAlk83SIckoN3M=;
        b=FFudzNunjMrz0FF8t5Ib/opBi6miokzZJJyoAQtLq70yrse+jlDCNAcQsaYVAOwqD5
         iqn+jNRx0I/nqXoGLHizeQfuLEWD9VpId1Fo5/Qzlj92DyYjFbSC5rEAqN2LX+gmMd5t
         M8hmj+kCxi1mcmY92BTQE4Cu8x/1SdsLg8hsdW3AMp7W3571ABy1Y5+/5VF0mNA/7IaL
         0zPhHaovT9PnzWcp9wHIGKunEIbLCKHG5oA5zupn2pNS+xPryQg62ziF+sxTPcj0WEls
         fZhO+ctLvx4MLWUq8NqBY6jeE8DVtEKPfzhjbLmeQhDGDUySRTMo9HcJaKPk6nvaimX4
         mG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WtdI3D3kn5MSp02VNkDOGkX1HTuAVPAlk83SIckoN3M=;
        b=KpmqRT9MR04RH/0hRy20C74aSjDPnTaEeynWsSEu0eMAuko1sZ3r5fH58JkMp4C6L5
         YdZEJU3n/a1v+TpwgR+kfMyrfQPvkXU5lxwf7IU4i/SWMFy54/9GScQ9gnlJT4JiGiKZ
         FbWPJRKScPjhUwqxRKi/VHNFMStddjzQdu/tfDCC+bFoqFVEDZQvddAiZ3m5lYfWGmAY
         P/P9llYTPJL8yn1i1BZmFcDOrMuTbrmfdXOzFmr2//mm3xKJaDwzLQ7ENmUe8MWZZW8R
         s6uvmL4n1fHeRIy3zxknlK9BpbEwlYG+ZIMOUOBKHjXR/MUMRFskpoWvaqvx48ixIesJ
         yFVA==
X-Gm-Message-State: AOAM531wnuUJ3MZmt9E7VTklJiXBdc4i/PwV6r18BwUTzCsWIYF8KX4u
        eeL/GmjXi5IBCmrwSVIk654AJvm1iLrLWLWNCV0Ao1Kdo22bCw==
X-Google-Smtp-Source: ABdhPJxyT7bz/3zy1cJX+J1aOnfkPMTFWvRvEkm5KRXq8CeHBxdDBuklSZ8abS8amldLlt1/t7IEMznJ+AH2Q22fbkE=
X-Received: by 2002:a6b:ea08:: with SMTP id m8mr18984094ioc.140.1608659714271;
 Tue, 22 Dec 2020 09:55:14 -0800 (PST)
MIME-Version: 1.0
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Tue, 22 Dec 2020 12:55:02 -0500
Message-ID: <CABWLseseugQxOXj5PDOsZ+nvadPfY_Uvt6wZaOpqjyBBXA+WRQ@mail.gmail.com>
Subject: verifier rejects program under O2, works under O3
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello friends,

I've run into an issue on my first BPF program of non-trivial size.
The verifier rejects a program that, I believe, it "should" accept.
Even more interesting than the rejection is the fact that the program
is accepted when compiling with clang -03 instead of the original -02.
Also interesting is that, in the -O2 case, a simple change that should
be equivalent from at the C semantics level also makes it work.

I hope there's something to learn here. It's possible that my program
is wrong in all sorts of ways, but I hope that the difference
between the -O2 and -O3 makes it interesting from the verifier's
perspective. I'll describe what I'm seeing with some observations, and
provide the source. I'm happy to assist in any way if need be (for example by
sharing my screen with whoever is interested, anytime). I'm running
with a recent bpf-next kernel. I've tried compiling the BPF program
with both clang 11 and 12 (master). I'm using a recent libbpf for
loading and scaffolding.

I've tried for a minimal reproduction, but couldn't get something
super small. I think what I do have is traceable, though. For some
minimal context, I'm working on BPF code for running DWARF debug-info
programs, to be used for computing the locations of variables and then
reading said variables in the context of uprobes.

The program is in this GitHub repo (notice the branch):
https://github.com/andreimatei/bpfdwarf/tree/verifier-O2-O3
The line which the verifier complains about (under -O2) is probe.bpf.c:95 :
https://github.com/andreimatei/bpfdwarf/blob/cb06f688559d3e01a2452a15772b54da0185182b/probe.bpf.c#L95

immediate = instr[ip+1];  // This gets rejected under -O2 but not under -O3.

See build instructions at the bottom.

The tail of its logs below. The full logs are here:
https://gist.github.com/andreimatei/2242c5f6455a12e6c1ff5d76fd577a69

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

If you'll read the source, you'll see that the verifier seems to
complain about the access into the instr array being unbounded. It is,
in fact, supposed to be bounded by the line above:

if (ip >= (PROG_MAX_INSTR - 2)) { return 189; }

I believe the verifier says something about a map because my instr
array ultimately comes from a global - which globals I think are
auto-magically transformed to map elements by libbpf?

Again, this works under -O3. It also works if I change the line
immediate = instr[ip+1];
to
immediate = *(instr + ip + 1);

So, if I do the pointer arithmetic by hand, it works.

I've analyzed the assembly being produced in a couple of cases, and
have a (likely random) observation. In both of the cases that work
(i.e. -O3 and manual pointer arithmetic), the line in question ends up
compiling to a load that uses register as the source address, and a
*different* register as the destination. In the case that doesn't
work, the same register is used. This is a long shot, but - is it
possible that the verifier gets confused when a register is
overwritten like this?
The assembly output (clang -S) can be found here:
https://github.com/andreimatei/bpfdwarf/tree/verifier-O2-O3/assembly
1) the original program (accessing instr as an array), compiled with -O2 (fails)
2) the original program (accessing instr as an array), compiled with
-O3 (succeeds)
3) the modified program, accessing instr as a pointer, compiled with
-O2 (succeeds)

The relevant line is represented in these assembly files by stanzas like:
.loc 1 95 16 is_stmt 0               # probe.bpf.c:95:16
.Ltmp183:
r9 <<= 32
r9 >>= 32
r6 = r8
r6 += r9
r6 = *(u8 *)(r6 + 4)

I also have another random observation: in all the versions of the
assembly listed above, there's a pattern for clearing the high-order
bits of a word, happening around the variable used to index into the
offset:
r9 <<= 32
r9 >>= 32
These instructions are there, I believe, in order to get the right
addition overflow behavior in the 32bit domain. I'm thinking there's a
chance that this has something to do with the verifier sometimes
losing track of some register bounds (although, again, the pattern
appears even when the program loads fine). I say this because another
way I've gotten my program to work is by changing the index variable
to be a 64bit type.

Instructions for building the github repo:
To build:
LIBBPF_SRC=<path to libbpf/src> OPT=-O2 make
To run the host program (which in turn loads the BPF program and
attaches it as a uprobe):
sudo output/bpfdwarf -b <path to any binary; doesn't need to be running>

To switch to -O3, build with OPT=-O3.

Thank you very much for your help!

- Andrei
