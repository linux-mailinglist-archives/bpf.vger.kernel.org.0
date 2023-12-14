Return-Path: <bpf+bounces-17863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD4D813664
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 17:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7158C1C20D15
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7660B8D;
	Thu, 14 Dec 2023 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XDnWQ0xd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F5E114
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 08:36:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-551f9ca15b4so2737189a12.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 08:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1702571809; x=1703176609; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cMppEdkYMd74yvLgS2ARZGB7OP/CCDMmyuNgPRwA/ys=;
        b=XDnWQ0xdbgpiEyawOSNbwd9Jcy+GZEGDZvRdGdqjAFkU6x6Do0T+PKJyGREDsoQdqo
         adjtsH83m5HlVQaeTGX/YEJunUNp4XoHGhzZtmpOEa3xXKz2J1nD+nDeildQ4znMLvpr
         B54cC+4dBE3QwPAT/F6YWImaviT+GBriCGpYo2Idl34vW5zGBtcUdAtLRr8/BJWd9t3j
         OYUAELSDZVOEYyb6P4DDN8X9Dpd2Cj1wyMH3J/W4BWvNKbfRWKh+zKyLkhV4ivedclPs
         9SbqryYB0wR+T/5SdzCJYRTG48LMSy9D5T/Yf0t/a9ffacNVSlOqMz/obxCKZTUuoRz5
         ccyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571809; x=1703176609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMppEdkYMd74yvLgS2ARZGB7OP/CCDMmyuNgPRwA/ys=;
        b=BOGeZTt6m0cCzs9UR0xcG8swTum42/t5E6ABkebEvrF+7xfwC0Hvo4dHplimOoDmk5
         WAN3+cAqWGkJpmIXEEbSYy4xyNpkcFQu1FdF5R+lyMxYwelLb5EOLmMtOHfWOrcZZdlN
         IKWJHK6PhRz38I+ZHPjj9s0GcBPMoYNo/2F420MFO80K692AtiWrFzv7lHpRUT672XiV
         pfkB9XPvoCeVYYY6G5ffjfZcZEv0HCcDffR57epGREPwGdKujPwc2Um6OPaa9kjXc4ae
         cZ18QX6V8tCFAvLQK26/LJ5//3TjpzKayCUKgEyZ03Ksou6A+Y1zE9K8p9iR6TZBVLw9
         JwxQ==
X-Gm-Message-State: AOJu0YzxrShWSW8B2MOTh2mnQyIFKRts23tXZfC+zYFnCTbNsLFurzCF
	jnsIJ7yBms/Vqs6jS09RCeuv2Q==
X-Google-Smtp-Source: AGHT+IHTHXP8wNGDp9AQ6g9Rq166mzsXQ81yqC3+5tgysNo2pZTjysNqixWiiEkInbd6D01VFADn/A==
X-Received: by 2002:a50:cd9c:0:b0:550:28c1:e018 with SMTP id p28-20020a50cd9c000000b0055028c1e018mr5327044edi.65.1702571809436;
        Thu, 14 Dec 2023 08:36:49 -0800 (PST)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ch13-20020a0564021bcd00b005485282a520sm1918567edb.75.2023.12.14.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:36:48 -0800 (PST)
Date: Thu, 14 Dec 2023 16:33:15 +0000
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
Message-ID: <ZXsuSxufwbzopFGy@zh-lab-node-5>
References: <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
 <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
 <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>
 <8e45c28fa0827be2b01a7cd36aa68750ceff69f5.camel@gmail.com>
 <CAADnVQ+RhX-QY1b5ewNp_K9b+X96PZNbxG8GSpC2xfhwULRNqA@mail.gmail.com>
 <ZXg1ApeYXi0g7WeM@zh-lab-node-5>
 <CAADnVQ+b3_5qzaR9pr6B23xDxCO10iz685tHfsakW3MnoVYMbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+b3_5qzaR9pr6B23xDxCO10iz685tHfsakW3MnoVYMbg@mail.gmail.com>

On Wed, Dec 13, 2023 at 06:15:20PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 12, 2023 at 2:28 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> >
> > This seems to have a benefit that there is no back compatibility issue
> > (if we use r1, because r0/r11 will be rejected by old verifiers). We
> > can have
> >
> >     r1 = 64bit_const
> >     if r1 == r1 goto
> >
> > and
> >
> >     r1 = 64bit_const
> >     if r1 != r1 goto
> >
> > and translate it on prog load to new instruction as JUMP_OF_NOP and
> > NOP_OR_JUMP, correspondingly. On older kernels it will have the
> > default (key is off) behaviour.
> 
> As Andrii pointed out any new insn either JA with extra bits
> or special meaning if rX == rX can be sanitized by libbpf
> into plain JA.
> There will be no backward compat issues.
> 
> > Ok, from BPF arch perspective this can work with two bits (not for
> > practical purposes though, IMO, see my next e-mail).
> 
> I read this email and I still don't understand why you need a 3rd bit.
> 
> >
> > > And the special map really doesn't fit.
> > > Whatever we do, let's keep text_poke-able insn logic separate
> > > from bookkeeping of addresses of those insns.
> > > I think a special prefixed section that is understood by libbpf
> > > (like what I proposed with "name.static_branch") will do fine.
> > > If it's not good enough we can add a "set" map type
> > > that will be a generic set of values.
> > > It can be a set of 8-byte addresses to keep locations of static_branches,
> > > but let's keep it generic.
> > > I think it's fine to add:
> > > __uint(type, BPF_MAP_TYPE_SET)
> > > and let libbpf populate it with addresses of insns,
> > > or address of variables, or other values
> > > when it prepares a program for loading.
> >
> > What is the higher-level API in this case? The static_branch_set(branch,
> > bool on) is not enough because we want to distinguish between "normal"
> > and "inverse" branches (for unlikely/likely cases).
> 
> What is "likely/unlikely cases" ?
> likely() is a hint to the compiler to order basic blocks in
> a certain way. There is no likely/unlikely bit in the binary code
> after compilation on x86 or other architectures.
> 
> There used to be a special bit on sparc64 that would mean
> a default jmp|fallthrough action for a conditional jmp.
> But that was before sparc became out of order and gained proper
> branch predictor in HW.

Consider this code:

    int foo(void)
    {
    	if (static_branch_likely(&key))
    		return 33;
    	return 55;
    }

    int hoo(void)
    {
    	if (static_branch_unlikely(&key))
    		return 33;
    	return 55;
    }

When the key is disabled the corresponding code is:

    0000000000000010 <foo>:                                                            
      19:   eb 0b                   jmp    26 <foo+0x16> <-------- likely(static branch), key off
      1b:   b8 21 00 00 00          mov    $0x21,%eax                                  
      20:   5d                      pop    %rbp                                        
      21:   e9 00 00 00 00          jmp    26 <foo+0x16>                               
      26:   b8 37 00 00 00          mov    $0x37,%eax                                  
      2b:   5d                      pop    %rbp                                        
      2c:   e9 00 00 00 00          jmp    31 <foo+0x21>                               
      31:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)                    
      38:   00 00 00 00                                                                
      3c:   0f 1f 40 00             nopl   0x0(%rax)                                   
    
    0000000000000050 <hoo>:                                                            
    <hoo>:                                                                             
      59:   66 90                   xchg   %ax,%ax <-------------- unlikely(static branch), key off                
      5b:   b8 37 00 00 00          mov    $0x37,%eax                                  
      60:   5d                      pop    %rbp                                        
      61:   e9 00 00 00 00          jmp    66 <hoo+0x16>                               
      66:   b8 21 00 00 00          mov    $0x21,%eax                                  
      6b:   5d                      pop    %rbp                                        
      6c:   e9 00 00 00 00          jmp    71 <__UNIQUE_ID_vermagic248+0x5>            

When the key is enabled, the code is:

    0000000000000010 <foo>:
     19:   66 90                   xchg   %ax,%ax <--------------- likely(static branch), key on
     1b:   b8 21 00 00 00          mov    $0x21,%eax
     20:   5d                      pop    %rbp
     21:   e9 00 00 00 00          jmp    26 <foo+0x16>
     26:   b8 37 00 00 00          mov    $0x37,%eax
     2b:   5d                      pop    %rbp
     2c:   e9 00 00 00 00          jmp    31 <foo+0x21>
     31:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
     38:   00 00 00 00
     3c:   0f 1f 40 00             nopl   0x0(%rax)
                                                                           
    
    0000000000000050 <hoo>:
     59:   eb 0b                   jmp    66 <hoo+0x16> <--------- unlikely(static branch), key on
     5b:   b8 37 00 00 00          mov    $0x37,%eax
     60:   5d                      pop    %rbp
     61:   e9 00 00 00 00          jmp    66 <hoo+0x16>
     66:   b8 21 00 00 00          mov    $0x21,%eax
     6b:   5d                      pop    %rbp
     6c:   e9 00 00 00 00          jmp    71 <__UNIQUE_ID_vermagic248+0x5>

So, for the likely case we set branch to JUMP/NOP when key is OFF/ON.
And for the unlikely case we set branch to NOP/JUMP when key is
OFF/ON. The kernel keeps this information, and when
static_key_enable(key) is executed, it does [simplified for reading]

	for (entry = key->start; entry < stop; entry++)
	        arch_jump_label_transform(entry, jump_label_type(entry));

this jump_label_type() contains this bit of information: are we
writing NOP or JUMP for an enabled key. Same for
static_key_disable(key).

Now, for BPF we do static_branch_enable(branch). To generate proper
JITed code, we have enough of information (NOP=0, JUMP=2):

    static_branch_enable(JA[SRC=1|NOP]) jits to ARCH_JUMP
    static_branch_enable(JA[SRC=1|JUMP]) jits to ARCH_NOP
    static_branch_disable(JA[SRC=1|NOP]) jits to ARCH_NOP
    static_branch_disable(JA[SRC=1|JUMP]) jits to ARCH_JUMP

But how do we represent this in xlated code to user? Do we patch the
xlated code? If we do, then

    static_branch_enable changes JA[SRC=1|NOP] to JA[SRC=1|JUMP], ARCH_JUMP generated
    static_branch_disable sees JA[SRC=1|JUMP], changes it to JA[SRC=1|NOP], but ARCH_JUMP is generated

or what about two static_branch_enable on the same branch? By flipping
I meant that we always do

    JA[SRC=1|NOP]  jits to ARCH_NOP
    JA[SRC=1|JUMP] jits to ARCH_JUMP

the primitive operation is static_branch_flip which changes
JA[SRC=1|NOP] to JA[SRC=1|JUMP] and vice versa. Then for
static_key_enable(key) we flip all the branches if key was disabled
and do nothing otherwise. Same for static_key_enable.

What you've proposed before is to keep this "third bit" in
xlated+jitted form.  Basically, we check the state of the branch
"on/off" like this: say, we see that xlated/jitted state of a branch
is JA[SRC=1|NOP] and ARCH_JUMP, then we can say that this branch is
on. How do we report it to user in PROG_INFO to we set the instruction
to JA[SRC=1|JUMP] in output, specifying that its current stae is to
jump? This would work, I think.

> >  We can implement
> > this using something like this:
> >
> > static_key_set(key, bool new_value)
> > {
> >     /* true if we change key value */
> >     bool key_changed = key->old_value ^ new_value;
> >
> >     for_each_prog(prog, key)
> >         for_each_branch(branch, prog, key)
> >             static_branch_flip(prog, branch, key_changed)
> > }
> >
> > where static_branch_flip flips the second bit of SRC_REG.
> 
> I don't understand why you keep bringing up 'flip' use case.
> The kernel doesn't have such an operation on static branches.
> Which makes me believe that it wasn't necessary.
> Why do we need one for the bpf static branch?

See above.

> > We need to
> > keep track of prog->branches and key->progs. How is this different
> > from what my patch implements?
> 
> What I'm proposing is to have a generic map __uint(type, BPF_MAP_TYPE_SET)
> and by naming convention libbpf will populate it with addresses
> of JA_OR_NOP from all progs.
> In asm it could be:
> asm volatile ("r0 = %[set_A] ll; goto_or_nop ...");
> (and libbpf will remove ld_imm64 from the prog before loading.)
> 
> or via
> asm volatile ("goto_or_nop ...; .pushsection set_A_name+suffix; .long");
> (and libbpf will copy from the special section into a set and remove
> special section).
> 
> It will be a libbpf convention and the kernel doesn't need
> to know about a special static branch map type or array of addresses
> in prog_load cmd.
> Only JA insn is relevant to the verifier and JITs.
> 
> Ideally we don't need to introduce SET map type and
> libbpf wouldn't need to populate it.
> If we can make it work with an array of values that .pushsection + .long
> automatically populates and libbpf treats it as a normal global data array
> that would be ideal.
> Insn addresses from all progs will be in that array after loading.
> Sort of like ".kconfig" section that libbpf populates,
> but it's a normal array underneath.

This doesn't work without the kernel side, as we change instructions
offsets inside the verifier when, e.g., converting helper calls to
individual instructions, etc.

Otherwise, this is more-or-less what my patch does: get a list of
offsets of banches inside the program, associate them with a map (or
ID of any kind), and then push to kernel.

And if you need to keep this list in kernel, then it looks like we can
keep it and access per key, not in a loop...

Alternative is to encode key ID in the instruction in some form so
that it is visible in xlated code after the program is loaded. But in
this case this makes users responsible to writing iterators and
bookkeeping all relationships vs. just loading a program with a map
fd, which is a well-established api in BPF.

> > If this is implemented in userspace, then how we prevent synchronous
> > updates of the key (and a relocation variant doesn't seem to work from
> > userspace)? Or is this a new kfunc? If yes, then how is it
> > executed,
> 
> then user space can have small helper in libbpf that iterates
> over SET (or array) and
> calls sys_bpf(cmd=STATIC_BRANCH_ENABLE, one_value_from_set)
>
> Similar in the kernel. When bpf progs want to enable a key it does
> bpf_for_each(set) { // open coded iterator
>    bpf_static_branch_enable(addr); // kfunc call
> }

Is this possible to use map like it is used in my patch, but do
sys_bpf(cmd=STATIC_KEY_ENABLE, attr.map_fd) so that it specifically
separated from map_update_value? (If it was not a map, but
just some "bpf object"?)

