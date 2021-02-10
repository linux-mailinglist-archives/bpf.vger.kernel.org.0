Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0F315CFA
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 03:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhBJCMf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 21:12:35 -0500
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:34784 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235304AbhBJCLQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 21:11:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1088312611;
        Wed, 10 Feb 2021 02:10:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:2393:2540:2559:2562:2828:2907:3138:3139:3140:3141:3142:3355:3622:3653:3865:3867:3868:3870:3871:3872:3873:3874:4250:4321:4605:5007:6119:6120:6238:7652:7809:7901:7903:7904:8603:9121:9149:10004:10848:11232:11233:11473:11658:11914:12043:12297:12438:12555:12679:12740:12760:12895:12986:13018:13019:13255:13439:13870:14181:14659:14721:21063:21080:21433:21451:21611:21627:21889:21939:21990:30003:30012:30029:30041:30054:30070:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: chin80_570a5ce2760c
X-Filterd-Recvd-Size: 5662
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Feb 2021 02:10:24 +0000 (UTC)
Message-ID: <2b4805f6ca2b44f4195b6fdba4f82d5e90ab1989.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
From:   Joe Perches <joe@perches.com>
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Date:   Tue, 09 Feb 2021 18:10:22 -0800
In-Reply-To: <20210209211954.490077-1-songliubraving@fb.com>
References: <20210209211954.490077-1-songliubraving@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-02-09 at 13:19 -0800, Song Liu wrote:
> BPF programs explicitly initialise global variables to 0 to make sure
> clang (v10 or older) do not put the variables in the common section.

Acked-by: Joe Perches <joe@perches.com>

So the patch is OK now, but I have a question about the concept:

Do you mean that these initialized to 0 global variables
should go into bss or another section?

Perhaps it'd be useful to somehow mark variables into specific
sections rather than bss when initialized to 0 and data when not
initialized to 0.

$ clang --version
clang version 10.0.0 (git://github.com/llvm/llvm-project.git 305b961f64b75e73110e309341535f6d5a48ed72)
Target: x86_64-unknown-linux-gnu
Thread model: posix

$ cat t_common.c
int a = 0;
int b = 1;

int foo_a(void)
{
	return a;
}

int foo_b(void)
{
	return b;
}

$ clang -c -O3 t_common.c

$ objdump -x t_common.o 

t_common.o:     file format elf64-x86-64
t_common.o
architecture: i386:x86-64, flags 0x00000011:
HAS_RELOC, HAS_SYMS
start address 0x0000000000000000

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00000017  0000000000000000  0000000000000000  00000040  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .bss          00000004  0000000000000000  0000000000000000  00000058  2**2
                  ALLOC
  2 .data         00000004  0000000000000000  0000000000000000  00000058  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .comment      00000068  0000000000000000  0000000000000000  0000005c  2**0
                  CONTENTS, READONLY
  4 .note.GNU-stack 00000000  0000000000000000  0000000000000000  000000c4  2**0
                  CONTENTS, READONLY
  5 .eh_frame     00000040  0000000000000000  0000000000000000  000000c8  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  6 .llvm_addrsig 00000000  0000000000000000  0000000000000000  00000210  2**0
                  CONTENTS, READONLY, EXCLUDE
SYMBOL TABLE:
0000000000000000 l    df *ABS*	0000000000000000 t_common.c
0000000000000000 l    d  .text	0000000000000000 .text
0000000000000000 g     O .bss	0000000000000004 a
0000000000000000 g     O .data	0000000000000004 b
0000000000000000 g     F .text	0000000000000007 foo_a
0000000000000010 g     F .text	0000000000000007 foo_b


RELOCATION RECORDS FOR [.text]:
OFFSET           TYPE              VALUE 
0000000000000002 R_X86_64_PC32     a-0x0000000000000004
0000000000000012 R_X86_64_PC32     b-0x0000000000000004


RELOCATION RECORDS FOR [.eh_frame]:
OFFSET           TYPE              VALUE 
0000000000000020 R_X86_64_PC32     .text
0000000000000034 R_X86_64_PC32     .text+0x0000000000000010


Perhaps instead something like:

$ cat t_common_bpf.c
 __attribute__((__section__("bpf"))) int a = 0;
 __attribute__((__section__("bpf"))) int b = 1;

int foo_a(void)
{
	return a;
}

int foo_b(void)
{
	return b;
}

$ clang -c -O3 t_common_bpf.c

$ objdump -x t_common_bpf.o 

t_common_bpf.o:     file format elf64-x86-64
t_common_bpf.o
architecture: i386:x86-64, flags 0x00000011:
HAS_RELOC, HAS_SYMS
start address 0x0000000000000000

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00000017  0000000000000000  0000000000000000  00000040  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 bpf           00000008  0000000000000000  0000000000000000  00000058  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .comment      00000068  0000000000000000  0000000000000000  00000060  2**0
                  CONTENTS, READONLY
  3 .note.GNU-stack 00000000  0000000000000000  0000000000000000  000000c8  2**0
                  CONTENTS, READONLY
  4 .eh_frame     00000040  0000000000000000  0000000000000000  000000c8  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  5 .llvm_addrsig 00000000  0000000000000000  0000000000000000  00000210  2**0
                  CONTENTS, READONLY, EXCLUDE
SYMBOL TABLE:
0000000000000000 l    df *ABS*	0000000000000000 t_common_bpf.c
0000000000000000 l    d  .text	0000000000000000 .text
0000000000000000 g     O bpf	0000000000000004 a
0000000000000004 g     O bpf	0000000000000004 b
0000000000000000 g     F .text	0000000000000007 foo_a
0000000000000010 g     F .text	0000000000000007 foo_b


RELOCATION RECORDS FOR [.text]:
OFFSET           TYPE              VALUE 
0000000000000002 R_X86_64_PC32     a-0x0000000000000004
0000000000000012 R_X86_64_PC32     b-0x0000000000000004


RELOCATION RECORDS FOR [.eh_frame]:
OFFSET           TYPE              VALUE 
0000000000000020 R_X86_64_PC32     .text
0000000000000034 R_X86_64_PC32     .text+0x0000000000000010




