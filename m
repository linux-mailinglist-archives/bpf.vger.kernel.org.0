Return-Path: <bpf+bounces-20418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2FD83E112
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 19:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13441C219B1
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D8208BD;
	Fri, 26 Jan 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JGwJp2Gq"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B31EB45
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292624; cv=none; b=W0VjfjG+gXv2MokLgG04IUQg6h1orasTzzucY1XXnpT5Pz80RDBpt1Yokg6wTRPok3GEUo5ewKncnyt/kfQ4fdXtLLlzDG7cYSY20BM0NhZlOvr6mwpf4oXaKBrOcLyu+yQeRD20LnbUQWfW8nn1kviMC00a38gDp3fo610H2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292624; c=relaxed/simple;
	bh=DmssJNXtva3XPNZbNwVa+ziYXXP7tIScpBj+nZ6LQz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhuU6G+RlwCA6YFDHx3863ob1cVpmgyJ1XSThMVmSntBrDpPIGKh/OG5YRuNLBEAPrqAdr1TReZGlsc0FNFvOgCFhRT7/go3J/ttm2oEGOmZjlIUJUIAwmnzzRXRBdLmMgIZ812hIuKNASNhsmOj1l1ga+2AoW9BC3jOb2uCkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JGwJp2Gq; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c1efbc9-7f4e-4d83-bc3c-2e7ebf027537@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706292619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NS+iISM9dWdM2OzA4tx/kQl9v+f1cZiARiAEvSn+rI=;
	b=JGwJp2Gq5i5I9Egz4vMPgauXIyqmhbV+MtRDd1vXdpKw5135WFgKlXRy5IQRTcDZ3uYrV1
	wCMfKpHqzbDby4X//OZd5hPMDlNjcmVLiOfMtvVWPxIfXyKoHy+q31FSWXxp3uqCgV2snn
	SabXHtJtCGdQL9OKFWd67gVHxH61lRY=
Date: Fri, 26 Jan 2024 10:10:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BTF generation and pruning (notes from office hours)
Content-Language: en-GB
To: David Faust <david.faust@oracle.com>, bpf@vger.kernel.org
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 Indu Bhagat <indu.bhagat@oracle.com>, Eduard Zingerman <eddyz87@gmail.com>
References: <a513d5c8-cae1-4c5d-a0aa-170c678c278b@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a513d5c8-cae1-4c5d-a0aa-170c678c278b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/25/24 2:56 PM, David Faust wrote:
> This morning in the BPF office hours we discussed BTF, starting from
> some specific cases where gcc and clang differ, and ending up at the
> broader question of what precisely should or should not be present
> in generated BTF info and in what cases.
>
> Below is a summary/notes on the discussion so far. Apologies if I've
> forgotten anything.
>
> Motivation: there are some cases where gcc emits more BTF information
> than clang, in particular (not necessarily exhaustive):
>    + clang does not emit BTF for unused static vars
>    + clang does not emit BTF for variables which have been optimized
>      away entirely
>    + clang does not emit BTF for types which are only used by one
>      of the above
>    (See a couple of concrete examples at the bottom.)

that is correct.

>
> One reason for this is implementation differences in the compiler.
> - In clang, BTF is generated late, in the BPF backend, after most
>    optimizations have happened.

right. clang generates BTF after all optimization is done.

> - In gcc, BTF is currently generated similarly to DWARF. This means:
>    + It reflects more closely the types/vars etc. in input source
>    + It is earlier; many optimizations have not happened yet, so
>      variables which eventually get optimized away are still present.
>
> Another reason is size concern. Clang deliberately does not add
> some types or do pointer chasing in some cases to avoid adding many
> BTF records for types not immediately relevant to the program. The
> obvious example is bpf_helpers.h or vmlinux.h - programs often need
> just a few helpers and ignore the rest, but by including them end
> up pulling in thousands of types which they do not use.

Let us differentiate between bpf_helpers.h and vmlinux.h, representing
BTF for bpf programs and BTF for kernel. clang BPF backend
generates BTF for bpf programs. But for kernel BTF, the BPF
backend didn't do anything. clang generates dwarf based on
native architecture and pahole process it to generate BTF.

The deliberate btf pruning only happens in llvm bpf backend
to avoid large BTF size for bpf programs.
The following are general rules for btf pruning in llvm bpf backend:
Generating BTF for
   - all functions at the end of compilation, including parameter types and return types
   - all global variables at the end of compilation
   - all called extern functions, including parameter types and return types
   - all CORE relocations
Do not generate BTF for types for other local variables.

The key pruning is to stop at the member with pointer type.
For example,
   $ cat t.c
   struct foo {
     int a;
   };
   struct bar {
     struct foo *a;
     int b;
   };
   int func(struct bar *arg) {
     return arg->b;
   }
   $ clang --target=bpf -O2 -g -c t.c
   $ bpftool btf dump file t.o
   [1] PTR '(anon)' type_id=2
   [2] STRUCT 'bar' size=16 vlen=2
           'a' type_id=3 bits_offset=0
           'b' type_id=4 bits_offset=64
   [3] PTR '(anon)' type_id=7
   [4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
   [5] FUNC_PROTO '(anon)' ret_type_id=4 vlen=1
           'arg' type_id=1
   [6] FUNC 'func' type_id=5 linkage=global
   [7] FWD 'foo' fwd_kind=struct
   $
See the above, 'struct foo' is a forward declaration.
But if you have explicit usage of 'struct foo' (e.g., struct foo *global_var),
then 'struct foo' will be generated and the forward declaration will be gone.

The libbpf map definition needs special processing. For example,
for the original map definition,
    struct {
         __uint(type, BPF_MAP_TYPE_HASH);
         __uint(max_entries, 64);
         __type(key, int);
         __type(value, struct hmap_elem);
    } hmap SEC(".maps");
after preprocessing, we have
    struct {
      int (*type)[1 /* BPF_MAP_TYPE_HASH */];
      int (*max_entries)[64];
      typeof(int) *key;
      typeof(struct hmap_elem) *value;
    } hmap __attribute__((section(".maps"), used));
If we use the previous member/pointer rule, we will not
emit 'struct hmap_elem' type which is not what we want,
so for any struct with '.maps' section, the member/pointer
rule starts after ptr type is visited for each member.
    $ cat t1.c
    struct foo {
      int a;
    };

    struct hmap_elem {
      struct foo *v;
    };

    struct {
      int (*type)[1 /* BPF_MAP_TYPE_HASH */];
      int (*max_entries)[64];
      typeof(int) *key;
     typeof(struct hmap_elem) *value;
   } hmap __attribute__((section(".maps"), used));
   $ clang --target=bpf -O2 -g -c t1.c
   $ bpftool btf dump file t1.o
   [1] PTR '(anon)' type_id=3
   [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
   [3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1
   [4] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
   [5] PTR '(anon)' type_id=6
   [6] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=64
   [7] PTR '(anon)' type_id=2
   [8] PTR '(anon)' type_id=9
   [9] STRUCT 'hmap_elem' size=8 vlen=1
         'v' type_id=10 bits_offset=0
   [10] PTR '(anon)' type_id=14
   [11] STRUCT '(anon)' size=32 vlen=4
         'type' type_id=1 bits_offset=0
         'max_entries' type_id=5 bits_offset=64
         'key' type_id=7 bits_offset=128
         'value' type_id=8 bits_offset=192
   [12] VAR 'hmap' type_id=11, linkage=global
   [13] DATASEC '.maps' size=0 vlen=1
         type_id=12 offset=0 size=32 (VAR 'hmap')
   [14] FWD 'foo' fwd_kind=struct

The above ptr/member rule also caused another issue
related with __kptr marking where the __kptr pointee
type is needed by the kernel.
   https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/local_kptr_stash.c#L54-L66
Theoretically we could ask the compiler to recognize __kptr and emit the
type, but so far the workaround is declare a global variable
to force emit the type.

> - This also comes with some drawbacks, in some cases BTF will not
>    be emitted when it is desired. There is a BTF_TYPE_EMIT macro to
>    work around that. It isn't a perfect solution.

This is due to dwarf. The type most likely not in dwarf,
I will take a look.

>
> So, the question is twofold:
> 1. What ought to be represented in BTF for a BPF program?
> 2. Is that/should that be followed for non-BPF program cases, such
>     as generating BTF for vmlinux?
>
> Discussion / things that were generally agreed on:
> - BTF for a BPF program should represent exactly what is in the
>    final program; things like variables which are optimized away
>    entirely should not be represented. Note that this differs from
>    other debug formats like DWARF which more closely represent the
>    original source.
>    + In addition, things like static variables which are not used
>      are not represented.
>
>    Reasons:
>    1. BTF for a BPF program is primarily of use to the BPF loader,
>       so representing in BTF things which no longer exist in the
>       actual BPF program is counter-productive.
>
>    2. Size. BPF programs including bpf_helpers.h or vmlinux.h pull
>       in many many types which are not used. Representing all
>       those bloats the BTF significantly for no gain.

Right. We would like bpf program BTF to be compact and represents
the state of elf binary.

>
> - BTF for vmlinux currently is similar, and aims to represent what
>    is actually there. The end goal for BTF is to to have everything
>    needed for full visibility for tracing. Size of BTF is also a
>    concern; there are many things which pahole omits, like global
>    variables.
>
> - BTF itself is not specific to BPF. gcc supports -gbtf for any
>    target. So it does not make sense to always prune types as though
>    generating BTF for a BPF program.
>
> - There are also cases for BPF where it makes sense for the compiler
>    to not try to be too clever about what to prune, and rather
>    leave it up to something else. For example, if in the future
>    BTF for the kernel is generated from the compiler and pahole
>    is used to do BTF->BTF translation, it makes sense to have the
>    compiler emit everything, and let pahole decide what to prune.

from vmlinux BTF perspective, full dwarf is available to pahole
and yes, if in the future clang backend supports to generate
BTF for x86 etc, we could maintain the full BTF as well.

>
> - We could add some sort of compiler flag, -fprune-btf or so,
>    to control this behavior. Initially we thought of 3 levels,
>    but narrowed it down to two being useful:
>    0 - compiler does no additional pruning, BTF is closer to source,
>        how gcc behaves now
>    1 - compiler does pruning as though for a BPF program,
>        represents only what is in final program
>        how clang behaves now
>    (With only two levels, the flag just becomes an on/off switch
>     to control the pruning step)
>
> - For this flag, we need to have the precise criteria used in
>    clang to determine what to prune. Probably this should also
>    be documented somehow(?)

Such a flag (-fprune-btf=<level>) will be useful. It can be
used for llvm bpf backend, can also be used (in the future)
for llvm generating vmlinux BTF.

>
> - LTO, the linker (as in ld), and BTF deduplication.
>    + For DWARF LTO is more complicated because of call site info.
>    + For BTF right now: no LTO for BPF programs.
>      Supposing linker did BTF dedup, right now nothing additional
>      would be needed for LTO.
>    + If at some point BTF adds call site info, linker could simply
>      discard BTF from the first compiler invocation and dedup BTF
>      emitted by the second compiler invocation (assumes BTF emission
>      in finish() rather than early_finish() for gcc).
>
> - We had some discussion of how all this could affect/interact with
>    things like split BTF for vmlinux, but I don't think we reached
>    any conclusions. Input appreciated.
>
>
> ===========
> examples discussed, for reference
>
> 1. BTF for unused static global variable and its types
> $ cat reduced.c
> typedef long long unsigned int __u64;
>
> struct bpf_timer {
>    __u64 __opaque[2];
> } __attribute__((preserve_access_index));
>
> static long (*bpf_timer_set_callback)(struct bpf_timer *timer, void *callback_fn) = (void *) 170;
> char LICENSE[] __attribute__((section("license"), used)) = "GPL";
>
> gcc
> $ ~/toolchains/bpf/bin/bpf-unknown-none-gcc -c -gbtf -O2 reduced.c -o reduced.o.gcc
> $ /usr/sbin/bpftool btf dump file reduced.o.gcc
> [1] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> [2] TYPEDEF '__u64' type_id=1
> [3] STRUCT 'bpf_timer' size=16 vlen=1
> 	'__opaque' type_id=5 bits_offset=0
> [4] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> [5] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=2
> [6] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> [7] FUNC_PROTO '(anon)' ret_type_id=6 vlen=2
> 	'(anon)' type_id=8
> 	'(anon)' type_id=9
> [8] PTR '(anon)' type_id=3
> [9] PTR '(anon)' type_id=0
> [10] PTR '(anon)' type_id=7
> [11] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> [12] ARRAY '(anon)' type_id=11 index_type_id=4 nr_elems=4
> [13] VAR 'bpf_timer_set_callback' type_id=10, linkage=static
> [14] VAR 'LICENSE' type_id=12, linkage=global
> [15] DATASEC 'license' size=0 vlen=1
> 	type_id=14 offset=0 size=4 (VAR 'LICENSE')
>
> clang:
> $ ~/toolchains/llvm/bin/clang -target bpf -c -g -O2 reduced.c -o reduced.o.clang
> $ /usr/sbin/bpftool btf dump file reduced.o.clang
> [1] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> [2] ARRAY '(anon)' type_id=1 index_type_id=3 nr_elems=4
> [3] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [4] VAR 'LICENSE' type_id=2, linkage=global
> [5] DATASEC 'license' size=0 vlen=1
> 	type_id=4 offset=0 size=4 (VAR 'LICENSE')
>
> Note how clang does not include any BTF info for bpf_timer_set_callback,
> since it is a variable which is not used in the program. This elides
> all the types used only by it as well.
>
>
> ===================
>
> 2. BTF for variable which is entirely optimized away
> $ cat optvar.c
> static int a = 5;
>
> int foo (int x) {
> 	return a + x;
> }
>
> gcc:
> $ ~/toolchains/bpf/bin/bpf-unknown-none-gcc -c -gbtf -O2 optvar.c -o optvar.o.gcc
> $ /usr/sbin/bpftool btf dump file optvar.o.gcc
> [1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1
> 	'x' type_id=1
> [3] VAR 'a' type_id=1, linkage=static
> [4] FUNC 'foo' type_id=2 linkage=global
>
> clang:
> $ ~/toolchains/llvm/bin/clang -target bpf -c -g -O2 optvar.c -o optvar.o.clang
> $ /usr/sbin/bpftool btf dump file optvar.o.clang
> [1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1
> 	'x' type_id=1
> [3] FUNC 'foo' type_id=2 linkage=global
>
> Simple case, variable 'a' gets completely optimized away and
> replaced with literal 5 when used. Clang does not include a
> VAR record for it, but gcc does.
>

