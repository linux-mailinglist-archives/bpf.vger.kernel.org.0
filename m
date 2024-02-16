Return-Path: <bpf+bounces-22151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29062857E8B
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3EB1C20FFF
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28F12C553;
	Fri, 16 Feb 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WiB65Rpm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36E12A17B
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092266; cv=none; b=iDd49Dyon/I+07qfcGwHUqi+98M6LfQFF+ZnHlQtuqMXUhuC/6OIBLdM5nThRekd/v/80eUuebV/ajzf+jmn+oGgvojwGIED+OWyGanBzONnGel/nhSQfQdZaNVVnyPv+3qNckbWNCtTvVxzcJe3kc+XebjEx3GFDTDYCwLLrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092266; c=relaxed/simple;
	bh=j/p24w4azTrDV+RjVkf7HQlAAQxGCyIfsto2qpiQ9OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQelcYy6M3XyEyoBN3sMf38ZUfk0lJnmrgabRyhI34EIfLIQz2zr+Gu33XQ4jr8Y5zDmQFrQF3UfEr5qDk+oBpV8CY2MyPL2ksmWAZC1/4ICi9J/xtGjljmba5qfKrkYrX2x4n6nEzEifrb9z0ulcFglKB0oXOztmtaAwQH9H1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=WiB65Rpm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so25796711fa.2
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 06:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1708092262; x=1708697062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lV81UaZ+Ide2ZRAp5jBjzjr+neXk2fnHqHTIRnfIbU8=;
        b=WiB65Rpm++LWClYCGrvZ9rQhXo+TfCRDey3Vka2K1Dr08Nw4hT9Y7uKHLVIHrywS28
         I5FVDcy1aSLs+oHQV58An+pZ7NdBePl2/wIBr9VJYC+ukcYeZj6XS8LWOpxekC9wL6lQ
         MtS2wApQy/I81Gxx0rD0hlNjzXY4892SW7Jrq3tOGjz/Iv/xVp+wB6dacV3a5Db+E7ke
         hbtLS032U1SMoJ5fOTQcRtfCmrbGX5yccYHSLnS8neEmPsZUgoQLRBVgXv54dNsy/Tsw
         vgufTRIFjZ1eFrxhOfGHMCUT5W7Hx0f1WzMDurS0vk4fWeAO1DIIXw+3UDABEGQD4pGJ
         1GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092262; x=1708697062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lV81UaZ+Ide2ZRAp5jBjzjr+neXk2fnHqHTIRnfIbU8=;
        b=XdmejFoIbdQC9iMcldJs5p7nQRXZJeOdmlCS6mqS9K5MsdXxhmqgkop96v9V/chmi/
         vcZS290ciPWbFqDgijYFa6bsNn9Urcc9a5HESm2Talq+QBZ9EJHzD1awPzltKMCcdKXi
         mfaquEQTMqyfDU5xUXL0zijmKgtXdYFMbTbgmQjWOHryNcMJ1sMIbi2DU+IZYu9e0FpU
         EKqQFWo33om7UsXotJ4yBt7+a+q47CNLzGqDC2/1oQhsYpmMgLRM6QOyW95Rt/IRbkl4
         y2kYkld2IV0+ZiFlrX0apLHckWD9J3f1YD4uvC0QqMAmftlAfLg3LTeofZLMUIfeV2SM
         i+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzC2GTcKaBrjfNuy2A5vXW/ZhQqd+SLdTDr7MkOJlE2ERUNN76RtJwEVEs4mddTb9KLtqtM4t71B3H2LnxmDTPKR3r
X-Gm-Message-State: AOJu0Yzg004wndnh4sdT3jvxsyXWTTzFAmfoty+2+klfCmfUg+M+ujBk
	xMBohwMtVgEXcvI82fzQ/TJybpMrvcFczt2u/vqEWyHLCUzntI3Y84AquIVkbA0=
X-Google-Smtp-Source: AGHT+IEjGHhsnoLMBLKuChzZLiQalcWJq0y8H3X8sU/OCZz5+GvdGjk56EaOl/eNWaDRIzZvwA62Jg==
X-Received: by 2002:a2e:7407:0:b0:2d0:d054:17df with SMTP id p7-20020a2e7407000000b002d0d05417dfmr3316936ljc.42.1708092262159;
        Fri, 16 Feb 2024 06:04:22 -0800 (PST)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000008f00b0033b728190c1sm2294153wrx.79.2024.02.16.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:04:21 -0800 (PST)
Date: Fri, 16 Feb 2024 13:57:53 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
Message-ID: <Zc9p4e1EccPkMnmY@zh-lab-node-5>
References: <20240202162813.4184616-1-aspsk@isovalent.com>
 <20240202162813.4184616-4-aspsk@isovalent.com>
 <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5>
 <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
 <ZcS1ZruKKZ1euzlb@zh-lab-node-5>
 <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>

On Wed, Feb 14, 2024 at 10:48:26PM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 8, 2024 at 3:11 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On Tue, Feb 06, 2024 at 06:26:12PM -0800, Alexei Starovoitov wrote:
> > > On Tue, Feb 6, 2024 at 2:08 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoitov wrote:
> > > > > On Fri, Feb 2, 2024 at 8:34 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > >
> > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > index 4def3dde35f6..bdd6be718e82 100644
> > > > > > --- a/include/linux/bpf.h
> > > > > > +++ b/include/linux/bpf.h
> > > > > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > > > > >         };
> > > > > >         /* an array of original indexes for all xlated instructions */
> > > > > >         u32 *orig_idx;
> > > > > > +       /* for every xlated instruction point to all generated jited
> > > > > > +        * instructions, if allocated
> > > > > > +        */
> > > > > > +       struct {
> > > > > > +               u32 off;        /* local offset in the jitted code */
> > > > > > +               u32 len;        /* the total len of generated jit code */
> > > > > > +       } *xlated_to_jit;
> > > > >
> > > > > Simply put Nack to this approach.
> > > > >
> > > > > Patches 2 and 3 add an extreme amount of memory overhead.
> > > > >
> > > > > As we discussed during office hours we need a "pointer to insn" concept
> > > > > aka "index on insn".
> > > > > The verifier would need to track that such things exist and adjust
> > > > > indices of insns when patching affects those indices.
> > > > >
> > > > > For every static branch there will be one such "pointer to insn".
> > > > > Different algorithms can be used to keep them correct.
> > > > > The simplest 'lets iterate over all such pointers and update them'
> > > > > during patch_insn() may even be ok to start.
> > > > >
> > > > > Such "pointer to insn" won't add any memory overhead.
> > > > > When patch+jit is done all such "pointer to insn" are fixed value.
> > > >
> > > > Ok, thanks for looking, this makes sense.
> > >
> > > Before jumping into coding I think it would be good to discuss
> > > the design first.
> > > I'm thinking such "address of insn" will be similar to
> > > existing "address of subprog",
> > > which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
> > > "address of insn" would be a bit more involved to track
> > > during JIT and likely trivial during insn patching,
> > > since we're already doing imm adjustment for pseudo_func.
> > > So that part of design is straightforward.
> > > Implementation in the kernel and libbpf can copy paste from pseudo_func too.
> >
> > To implement the "primitive version" of static branches, where the
> > only API is `static_branch_update(xlated off, on/off)` the only
> > requirement is to build `xlated -> jitted` mapping (which is done
> > in JIT, after the verification). This can be done in a simplified
> > version of this patch, without xlated->orig mapping and with
> > xlated->jit mapping only done to gotol_or_nop instructions.
> 
> yes. The array of insn->jit_addr sized with as many goto_or_nop-s
> the prog will work for user space to flip them, but...
> 
> > The "address of insn" appears when we want to provide a more
> > higher-level API when some object (in user-space or in kernel) keeps
> > track of one or more gotol_or_nop instructions so that after the
> > program load this controlling object has a list of xlated offsets.
> > But this would be a follow-up to the initial static branches patch.
> 
> this won't work as a follow up,
> since such an array won't work for bpf prog that wants to flip branches.
> There is nothing that associates static_branch name/id with
> particular goto_or_nop.
> There could be a kfunc that bpf prog calls, but it can only
> flip all of such insns in the prog.
> Unless we start encoding a special id inside goto_or_nop or other hacks.
> 
> > > The question is whether such "address of insn" should be allowed
> > > in the data section. If so, we need to brainstorm how to
> > > do it cleanly.
> > > We had various hacks for similar things in the past. Like prog_array.
> > > Let's not repeat such mistakes.
> >
> > So, data section is required for implementing jump tables? Like,
> > to add a new PTR_TO_LABEL or PTR_TO_INSN data type, and a
> > corresponding "ptr to insn" object for every occurence of &&label,
> > which will be adjusted during verification.
> > Looks to me like this one doesn't require any more API than specifying
> > a list of &&label occurencies on program load.
> >
> > For "static keys" though (a feature on top of this patch series) we
> > need to have access to the corresponding set of adjusted pointers.
> >
> > Isn't this enough to add something like an array of
> >
> >   struct insn_ptr {
> >       u32 type; /* LABEL, STATIC_BRANCH,... */
> >       u32 insn_off; /* original offset on load */
> >       union {
> >           struct label {...};
> >           struct st_branch { u32 key_id, ..};
> >       };
> >   };
> 
> which I don't like because it hard codes static_branch needs into
> insn->jit_addr association.
> "address of insn" should be an individual building block without
> bolted on parts.
> 
> A data section with a set of such "address of insn"
> can be a description of one static_branch.
> There will be different ways to combine such building blocks.
> For example:
> static_branch(foo) can emit goto_or_nop into bpf code
> and add "address of insn" into a section '.insn_addrs.foo".
> This section is what libbpf and bpf prog will recognize as a set
> of "address of insn" that can be passed into static_branch_update kfunc
> or static_branch_update sys_bpf command.
> The question is whether we need a new map type (array derivative)
> to hold a set of "address of insn" or it can be a part of an existing
> global data array.
> A new map type is easier to reason about.
> Notice how such a new map type is not a map type of static branches.
> It's not a map type of goto_or_nop instructions either.
> 
> At load time libbpf can populate this array with indices of insns
> that the verifier and JIT need to track. Once JITed the array is readonly
> for bpf prog and for user space.

So this will be a map per .insn_addrs.X section (where X is key or
a pre-defined suffix for jump tables or indirect calls). And to tell
the verifier about these maps we will need to pass an array of

    struct {
            u32 map_fd;
            u32 type; /* static key, jump table, etc. */
    }

on program load. Is this correct?

> With that mechanism compilers can generate a proper switch() jmp table.
> llvm work can be a follow up, of course, but the whole design needs
> to be thought through to cover all use cases.
> 
> To summarize, here's what I'm proposing:
> - PTR_TO_INSN verifier regtype that can be passed to static_branch_update kfunc

If we have a set of pointers to jump instructions, generated from
static_branch(foo) for same foo, then this makes more sense to
provide a

    static_branch_update(foo)

(where foo is substituted by libbpf with a map fd of .insn_addrs.foo
on load). The same for userspace:

    bpf(STATIC_BRANCH_UPDATE, .attrs={.map_fd=foo})

> - new map type (array) that holds objects that are PTR_TO_INSN for the verifier
> libbpf populates this array with indices of insn it wants to track.
> bpf prog needs to "use" this array, so prog/map association is built.
> - verifier/JIT update each PTR_TO_INSN during transformations.
> - static_branch(foo) macro emits goto_or_nop insn and adds 8 bytes
> into ".insn_addrs.foo" section with an ELF relocation that
> libbpf will convert into index.
> 
> When compilers implement jmptables for switch(key) they will generate
> ".insn_addrs.uniq_suffix" sections and emit
> rX = ld_imm64 that_section
> rX += switch_key
> rY = *(u64 *)rX
> jmpx rY

What are the types for rX and rY? I thought that we will need to do
smth like

  rX = .insn_addrs.uniq_suffix[switch_key] /* rX has type PTR_TO_INSN */
  ...
  jmpx rX

this can be done if for switch cases (or any other goto *label alike) we generate

  rX = map_lookup_elem(.insn_addrs.uniq_suffix, index)
  jmpx rX

> The verifier would need to do push_stack() for this indirect jmp insn
> as many times as there are elements in ".insn_addrs.uniq_suffix" array.
> 
> And similar for indirect calls.
> That section becomes an array of pointers to functions.
> We can make it more flexible for indirect callx by
> storing BTF func proto and allowing global subprogs with same proto
> to match as safe call targets.

