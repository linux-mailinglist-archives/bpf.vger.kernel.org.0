Return-Path: <bpf+bounces-17505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D72380E918
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D56F1C20AEB
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A925B5C9;
	Tue, 12 Dec 2023 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="OiPgsEjZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5BA0
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 02:28:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54f49c10c37so8266379a12.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 02:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1702376913; x=1702981713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lKUaQTifCUm8ST0e2S2+QmUEdCAe8bP9ujD3SeY0DTY=;
        b=OiPgsEjZCcZWg1sOvkWzDLKXoGQ2S5KAKYHFfF9o5vxmpjjeEN1yEsyAf+Zf2zMd5Q
         d4qVrZPetB5IQ0HiLfew2S811Rl/eig5YlFd+c6dHhBtdeuoSNI/THhXkq547A3JhWO2
         1kMR7GGr3IT8TVg65C0Y4pXqOysml1fhSXD5/HpK7Rb7Pi6wDOmTczfb8PLs+T9+1YKZ
         KLOGChg1NMe4STTVfl5+CM64KBApTjaBU6U0f40xorEKleorUCO/z568ftZX2IRoz7HF
         iC5x98yii+6pkSAig/61disoo+mh7BhtqMpp1MLGh64ku4ssdDn7vhp0MOZChuKx1xpg
         k6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376913; x=1702981713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKUaQTifCUm8ST0e2S2+QmUEdCAe8bP9ujD3SeY0DTY=;
        b=Zw+RdA1XUzXDo2x6POQlqxf31bcGsAitLgYWyVU6hzUHgkDTvUEGPXPUtdc6Oa16jI
         J5SDrdJhZ1QK6pxHRcpZsHFdR/kPzPcAnBf5RXN5ucs9QWECzIa1hxUd7kS37KoHLw0v
         zINAlMsrXqbPH+tUxOop4kNd34ov5w7uY/Zfpz5F6T0x9I1AkqhlcnM8fpKAkM1kYRKP
         Xn4/2XDzluVy7UaEibmVwebB5XnKV0JK76mLeT6eufMA2IyFP4URYvslRgyqmvrrzlnu
         kXj69dzZQ/pWgJKbqS3Ezy9wZoJXNBWINhS4zn7wU7ZUofIicxn+LhwR0cqq/p81lw5E
         iW3w==
X-Gm-Message-State: AOJu0YyerEC6v6go3t6rLKOnZ564sFRMqJel/Z5augNpfM/9bqZkt3GV
	DUv8DsyFIvSvgbmUPRAaICRZig==
X-Google-Smtp-Source: AGHT+IGUTd8hpkVwjOPslV+F0sKRnGFDA+7lnqmVoFqpCI0XzlwNXPKPPrzVhptIVL9CNEZ7lwNSaw==
X-Received: by 2002:a50:d61d:0:b0:54c:48aa:cd15 with SMTP id x29-20020a50d61d000000b0054c48aacd15mr5565530edi.37.1702376913355;
        Tue, 12 Dec 2023 02:28:33 -0800 (PST)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g4-20020a50d0c4000000b0054887e27dc8sm4705848edf.62.2023.12.12.02.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:28:32 -0800 (PST)
Date: Tue, 12 Dec 2023 10:25:06 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
Message-ID: <ZXg1ApeYXi0g7WeM@zh-lab-node-5>
References: <ZXNCB5sEendzNj6+@zh-lab-node-5>
 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
 <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
 <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>
 <8e45c28fa0827be2b01a7cd36aa68750ceff69f5.camel@gmail.com>
 <CAADnVQ+RhX-QY1b5ewNp_K9b+X96PZNbxG8GSpC2xfhwULRNqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+RhX-QY1b5ewNp_K9b+X96PZNbxG8GSpC2xfhwULRNqA@mail.gmail.com>

On Sun, Dec 10, 2023 at 07:33:31PM -0800, Alexei Starovoitov wrote:
> On Sun, Dec 10, 2023 at 2:30 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > How about a slightly different modification of the Anton's idea.
> > Suppose that, as before, there is a special map type:
> >
> >     struct {
> >         __uint(type, BPF_MAP_TYPE_ARRAY);
> >         __type(key, __u32);
> >         __type(value, __u32);
> >         __uint(map_flags, BPF_F_STATIC_KEY);
> >         __uint(max_entries, 1);
> >     } skey1 SEC(".maps")
> 
> Instead of special map that the kernel has to know about
> the same intent can be expressed with:
> int skey1;
> r0 = %[skey1] ll;
> and then the kernel needs no extra map type while the user space
> can collect all static_branches that use &skey1 by
> iterating insn stream and comparing addresses.
> 
> > Which is used as below:
> >
> >     __attribute__((naked))
> >     int foo(void) {
> >       asm volatile (
> >                     "r0 = %[skey1] ll;"
> >                     "if r0 != r0 goto 1f;"
> >                     "r1 = r10;"
> >                     "r1 += -8;"
> >                     "r2 = 1;"
> >                     "call %[bpf_trace_printk];"
> >             "1:"
> >                     "exit;"
> >                     :: __imm_addr(skey1),
> >                        __imm(bpf_trace_printk)
> >                     : __clobber_all
> >       );
> >     }
> >
> > Disassembly of section .text:
> >
> > 0000000000000000 <foo>:
> >        0:   r0 = 0x0 ll
> >         0000000000000000:  R_BPF_64_64  skey1  ;; <---- Map relocation as usual
> >        2:   if r0 == r0 goto +0x4 <foo+0x38>   ;; <---- Note condition
> >        3:   r1 = r10
> >        4:   r1 += -0x8
> >        5:   r2 = 0x1
> >        6:   call 0x6
> >        7:   exit
> >
> > And suppose that verifier is modified in the following ways:
> > - treat instructions "if rX == rX" / "if rX != rX" (when rX points to
> >   static key map) in a special way:
> >   - when program is verified, the jump is considered non deterministic;
> >   - when program is jitted, the jump is compiled as nop for "!=" and as
> >     unconditional jump for "==";
> > - build a table of static keys based on a specific map referenced in
> >   condition, e.g. for the example above it can be inferred that insn 2
> >   associates with map skey1 because "r0" points to "skey1";
> > - jit "rX = <static key> ll;" as nop;
> >
> > On the plus side:
> > - any kinds of jump tables are omitted from system call;
> > - no new instruction is needed;
> > - almost no modifications to libbpf are necessary (only a helper macro
> >   to convince clang to keep "if rX == rX");
> 
> Reusing existing insn means that we're giving it new meaning
> and that always comes with danger of breaking existing progs.
> In this case if rX == rX isn't very meaningful and new semantics
> shouldn't break anything, but it's a danger zone.
> 
> If we treat:
> if r0 == r0
> as JA
> then we have to treat
> if r1 == r1
> as JA as well and it becomes ambiguous when prog_info needs
> to return the insns back to user space.
> 
> If we go with rX == rX approach we should probably limit it
> to one specific register. r0, r10, r11 can be considered
> and they have their own pros and cons.
> 
> Additional:
> r0 = %[skey1] ll
> in front of JE/JNE is a waste. If we JIT it to useless native insn
> we will be burning cpu for no reason. So we should probably
> optimize it out. If we do so, then this inline insn becomes a nop and
> it's effectively a relocation. The insn stream will carry this
> rX = 64bit_const insn to indicate the scope of the next insn.
> It's pretty much like Anton's idea of using extra bits in JA
> to encode an integer key_id.
> With ld_imm64 we will encode 64-bit key_id.
> Another insn with more bits to burn that has no effect on execution.
> 
> It doesn't look clean to encode so much extra metadata into instructions
> that JITs and the interpreter have to ignore.
> If we go this route:
>   r11 = 64bit_const
>   if r11 == r11 goto
> is a lesser evil.
> Still, it's not as clean as JA with extra bits in src_reg.
> We already optimize JA +0 into a nop. See opt_remove_nops().
> So a flavor of JA insn looks the most natural fit for a selectable
> JA +xx or JA +0.

This seems to have a benefit that there is no back compatibility issue
(if we use r1, because r0/r11 will be rejected by old verifiers). We
can have

    r1 = 64bit_const
    if r1 == r1 goto

and

    r1 = 64bit_const
    if r1 != r1 goto

and translate it on prog load to new instruction as JUMP_OF_NOP and
NOP_OR_JUMP, correspondingly. On older kernels it will have the
default (key is off) behaviour.

> And the special map really doesn't fit.
> Whatever we do, let's keep text_poke-able insn logic separate
> from bookkeeping of addresses of those insns.
> I think a special prefixed section that is understood by libbpf
> (like what I proposed with "name.static_branch") will do fine.
> If it's not good enough we can add a "set" map type
> that will be a generic set of values.
> It can be a set of 8-byte addresses to keep locations of static_branches,
> but let's keep it generic.
> I think it's fine to add:
> __uint(type, BPF_MAP_TYPE_SET)
> and let libbpf populate it with addresses of insns,
> or address of variables, or other values
> when it prepares a program for loading.

What is the higher-level API in this case? The static_branch_set(branch,
bool on) is not enough because we want to distinguish between "normal"
and "inverse" branches (for unlikely/likely cases). We can implement
this using something like this:

static_key_set(key, bool new_value)
{
    /* true if we change key value */
    bool key_changed = key->old_value ^ new_value;
 
    for_each_prog(prog, key)
        for_each_branch(branch, prog, key)
            static_branch_flip(prog, branch, key_changed)
}

where static_branch_flip flips the second bit of SRC_REG. We need to
keep track of prog->branches and key->progs. How is this different
from what my patch implements?

If this is implemented in userspace, then how we prevent synchronous
updates of the key (and a relocation variant doesn't seem to work from
userspace)? Or is this a new kfunc? If yes, then how is it
executed, 

> But map_update_elem should never be doing text_poke on insns.
> We added prog_array map type is the past, but that was done
> during the early days. If we were designing bpf today we would have
> gone a different route.

What is the interface to toggle a key? If this is a map or an index of
a global variable and we can't do this via a syscall, then this means
that we need to write and compile an iterator to go through all maps,
select a proper map, then code should be generated to go through all
programs of interest and to update all static branches there (and we
will have to build this iterator every time, and keep track of all
mappings from userspace), while an alternative is to just issue one
syscall.

If this is just a `kfunc set_static_key(key, on/off)` then this is
simpler, but again, we will have to load an iterator and then iterate
through all maps to find the key vs. one syscall.

