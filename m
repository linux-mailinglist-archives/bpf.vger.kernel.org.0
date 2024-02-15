Return-Path: <bpf+bounces-22064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08600855AB3
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 07:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292061C2A0F2
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A098BA3F;
	Thu, 15 Feb 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFB4BMjl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E54610E
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979723; cv=none; b=HkliTk36icSWvfT7OIH+vsW1hcgAQVCuzw3F6m0FM4Rttsw51eErkQSa7WAsxSII/2twgd2N5KZiULv8aUgS79qpFIy3sex+TexDJ/gvkFL4A5NDBqb0ly0tvLb3Pq3vr94e4wxyB8ZDadSqdZ4hcg8e3tR9Q075ir4rNyNV00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979723; c=relaxed/simple;
	bh=5fKuC+IV8LrMdw6MmF+REJD3OVz+f72u9wA2lYSjXzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIrDJeBsizJlC96U8qUfrPViv+NLvlDoU9svYPJkDuU6R6H7VneUAW0otl6si3JI8vV8XuR+IwxLcikF7uYRkP3P3UoRd8t2EwdGt4mDnIWSTIolrFmqwlig+fuPdBTeMZUij4MXbmLq1OkSMLknu3PVjsiExl+7By+kuf9t3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFB4BMjl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ce55ab993so272874f8f.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 22:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707979719; x=1708584519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAf7VgT8AwZwneM1k2siD1yHWNFCgNHU0S7uqeTFTAY=;
        b=GFB4BMjlF3TSmlb6SVTIbGMaDK0VUqcMvew9rYilNgaYFB4x2IZyo4RIHUj6T3/v/1
         h9JOaxGBlD+geYcN5sRsJmPiqFSUVmsWeceFWwn2JhDsfDdZ3OjPZf8u6iu6p9PDyn27
         pBwYZPD60YFfSRHOLBfjzNV1MFPcSaIrzKCsFm7gd7OjhCGM8PDw01JPtfZaQwV+l6pC
         IgAAg91OmmKyhdI5yq4XBX2ADNaiIcGRNIO6KgoDvkmJ8hx0Aq5FxvFWRK7NvWV57K4R
         p4GLdXvnw0QEgnNIpn0/aF0KJpOfNLpgLJIQq0+fOdtbVYiFwAqNiU7xqMxXf/v/O2lu
         EU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707979719; x=1708584519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAf7VgT8AwZwneM1k2siD1yHWNFCgNHU0S7uqeTFTAY=;
        b=bNXxVvVoQxIDJ7e2hvBE/DLt3jpo85CWavWYVqGmiWKk67TucSkH0nC3Kd4Naru2V0
         y4hpz31oKhQIhI78TBijda1nAKhZX5WN2zcwHbsdFajGemGvthiYqbA/WFbIUczj4zCE
         Jjb8AA+N6M4tilcUnTbVNZ/fNYAFTQRyAuuF7WbT6fecRdT8TVNgK+TBjKzovThWbWCs
         nlTp7ARvJyjknLnKV/+UiT5O1k4qPWwdA3zwMrGzOqAWP1rz4ZvteKqK3C5hEjmAErhO
         nBW+dwalGBKIwqvT0hnWcJXb/aZmHx9ZksQAk9Z6gFmDJbPGUW8JVdI2PLDYvgGB4og4
         r2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWx11XZiUQ4fnYvGrmbe/xf8iwbUhI3/DHdLcxMXgMnaYtriXFT07yJCZdh3XAo2ydJKBdytYnzIb7Rgo+ctv3Q8SVT
X-Gm-Message-State: AOJu0YygcD/CS2OZPZhv6QQ2odvpi+v1f3Rr3NQeahQQbl5Pg/wSVDcJ
	CRRMzPKVp8d3H2VDNSNv8GOdyxauwCbK6LAcgI62o7+hbFkOiPI0Vx8I7IP5YShy1nqC9Txj91z
	zMME91O1pkg9xzFlxxeNdcj4ADfn873DYtoQ=
X-Google-Smtp-Source: AGHT+IGUSf9zjglrFsaRdexWNwCFtnjuS4wu3ayeMrGeh7C7jWwIHFv4W33esuda5gEkFRaHE5mhuPds7/Q+d7gCWV0=
X-Received: by 2002:adf:a315:0:b0:33b:794a:8a79 with SMTP id
 c21-20020adfa315000000b0033b794a8a79mr664165wrb.47.1707979718718; Wed, 14 Feb
 2024 22:48:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202162813.4184616-1-aspsk@isovalent.com> <20240202162813.4184616-4-aspsk@isovalent.com>
 <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5> <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
 <ZcS1ZruKKZ1euzlb@zh-lab-node-5>
In-Reply-To: <ZcS1ZruKKZ1euzlb@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Feb 2024 22:48:26 -0800
Message-ID: <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:11=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> On Tue, Feb 06, 2024 at 06:26:12PM -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 6, 2024 at 2:08=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> > >
> > > On Mon, Feb 05, 2024 at 05:09:51PM -0800, Alexei Starovoitov wrote:
> > > > On Fri, Feb 2, 2024 at 8:34=E2=80=AFAM Anton Protopopov <aspsk@isov=
alent.com> wrote:
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index 4def3dde35f6..bdd6be718e82 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
> > > > >         };
> > > > >         /* an array of original indexes for all xlated instructio=
ns */
> > > > >         u32 *orig_idx;
> > > > > +       /* for every xlated instruction point to all generated ji=
ted
> > > > > +        * instructions, if allocated
> > > > > +        */
> > > > > +       struct {
> > > > > +               u32 off;        /* local offset in the jitted cod=
e */
> > > > > +               u32 len;        /* the total len of generated jit=
 code */
> > > > > +       } *xlated_to_jit;
> > > >
> > > > Simply put Nack to this approach.
> > > >
> > > > Patches 2 and 3 add an extreme amount of memory overhead.
> > > >
> > > > As we discussed during office hours we need a "pointer to insn" con=
cept
> > > > aka "index on insn".
> > > > The verifier would need to track that such things exist and adjust
> > > > indices of insns when patching affects those indices.
> > > >
> > > > For every static branch there will be one such "pointer to insn".
> > > > Different algorithms can be used to keep them correct.
> > > > The simplest 'lets iterate over all such pointers and update them'
> > > > during patch_insn() may even be ok to start.
> > > >
> > > > Such "pointer to insn" won't add any memory overhead.
> > > > When patch+jit is done all such "pointer to insn" are fixed value.
> > >
> > > Ok, thanks for looking, this makes sense.
> >
> > Before jumping into coding I think it would be good to discuss
> > the design first.
> > I'm thinking such "address of insn" will be similar to
> > existing "address of subprog",
> > which is encoded in ld_imm64 as BPF_PSEUDO_FUNC.
> > "address of insn" would be a bit more involved to track
> > during JIT and likely trivial during insn patching,
> > since we're already doing imm adjustment for pseudo_func.
> > So that part of design is straightforward.
> > Implementation in the kernel and libbpf can copy paste from pseudo_func=
 too.
>
> To implement the "primitive version" of static branches, where the
> only API is `static_branch_update(xlated off, on/off)` the only
> requirement is to build `xlated -> jitted` mapping (which is done
> in JIT, after the verification). This can be done in a simplified
> version of this patch, without xlated->orig mapping and with
> xlated->jit mapping only done to gotol_or_nop instructions.

yes. The array of insn->jit_addr sized with as many goto_or_nop-s
the prog will work for user space to flip them, but...

> The "address of insn" appears when we want to provide a more
> higher-level API when some object (in user-space or in kernel) keeps
> track of one or more gotol_or_nop instructions so that after the
> program load this controlling object has a list of xlated offsets.
> But this would be a follow-up to the initial static branches patch.

this won't work as a follow up,
since such an array won't work for bpf prog that wants to flip branches.
There is nothing that associates static_branch name/id with
particular goto_or_nop.
There could be a kfunc that bpf prog calls, but it can only
flip all of such insns in the prog.
Unless we start encoding a special id inside goto_or_nop or other hacks.

> > The question is whether such "address of insn" should be allowed
> > in the data section. If so, we need to brainstorm how to
> > do it cleanly.
> > We had various hacks for similar things in the past. Like prog_array.
> > Let's not repeat such mistakes.
>
> So, data section is required for implementing jump tables? Like,
> to add a new PTR_TO_LABEL or PTR_TO_INSN data type, and a
> corresponding "ptr to insn" object for every occurence of &&label,
> which will be adjusted during verification.
> Looks to me like this one doesn't require any more API than specifying
> a list of &&label occurencies on program load.
>
> For "static keys" though (a feature on top of this patch series) we
> need to have access to the corresponding set of adjusted pointers.
>
> Isn't this enough to add something like an array of
>
>   struct insn_ptr {
>       u32 type; /* LABEL, STATIC_BRANCH,... */
>       u32 insn_off; /* original offset on load */
>       union {
>           struct label {...};
>           struct st_branch { u32 key_id, ..};
>       };
>   };

which I don't like because it hard codes static_branch needs into
insn->jit_addr association.
"address of insn" should be an individual building block without
bolted on parts.

A data section with a set of such "address of insn"
can be a description of one static_branch.
There will be different ways to combine such building blocks.
For example:
static_branch(foo) can emit goto_or_nop into bpf code
and add "address of insn" into a section '.insn_addrs.foo".
This section is what libbpf and bpf prog will recognize as a set
of "address of insn" that can be passed into static_branch_update kfunc
or static_branch_update sys_bpf command.
The question is whether we need a new map type (array derivative)
to hold a set of "address of insn" or it can be a part of an existing
global data array.
A new map type is easier to reason about.
Notice how such a new map type is not a map type of static branches.
It's not a map type of goto_or_nop instructions either.

At load time libbpf can populate this array with indices of insns
that the verifier and JIT need to track. Once JITed the array is readonly
for bpf prog and for user space.

With that mechanism compilers can generate a proper switch() jmp table.
llvm work can be a follow up, of course, but the whole design needs
to be thought through to cover all use cases.

To summarize, here's what I'm proposing:
- PTR_TO_INSN verifier regtype that can be passed to static_branch_update k=
func
- new map type (array) that holds objects that are PTR_TO_INSN for the veri=
fier
libbpf populates this array with indices of insn it wants to track.
bpf prog needs to "use" this array, so prog/map association is built.
- verifier/JIT update each PTR_TO_INSN during transformations.
- static_branch(foo) macro emits goto_or_nop insn and adds 8 bytes
into ".insn_addrs.foo" section with an ELF relocation that
libbpf will convert into index.

When compilers implement jmptables for switch(key) they will generate
".insn_addrs.uniq_suffix" sections and emit
rX =3D ld_imm64 that_section
rX +=3D switch_key
rY =3D *(u64 *)rX
jmpx rY

The verifier would need to do push_stack() for this indirect jmp insn
as many times as there are elements in ".insn_addrs.uniq_suffix" array.

And similar for indirect calls.
That section becomes an array of pointers to functions.
We can make it more flexible for indirect callx by
storing BTF func proto and allowing global subprogs with same proto
to match as safe call targets.

