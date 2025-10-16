Return-Path: <bpf+bounces-71134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 419EABE511A
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDD619C24D3
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F36231858;
	Thu, 16 Oct 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxv+i9dS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A01223710
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639805; cv=none; b=di6bFLlpTfjGLXEXyfQZOTvjSwuyzsYSaanW0A59DRCxT+9X4wTuAZZo4tCURQTZaNaXZdVeQVn6RylyVpDljZQIE4XwohQms2C4BH2CjAO+sBCCFXDTLcVr+7/UASTJ9kRGb9Sq+wOVPeaMTU1IrnCOHLnVV8SmThf4JhWo3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639805; c=relaxed/simple;
	bh=nHcUZUzUu5CG312oo+zilyLpG40gzHJ+x0I2KtotuFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rta5N3P+5+XSPAQQoe3kj4CimYR4YEINaj4OAVLFZPcOkR9C8n08oS2JlBgR8nSaGJ7kkweL8E1HtLwKxGqSUFOXx6+9883sl29jAZjTe5kGLaWHO4yux8wIRBjjqXooe3yDW1WxK5KsgYSWxvwLVT0qcM0O53algHAek7gNLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxv+i9dS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1162177a91.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639803; x=1761244603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZxVygdfeVMO4IjGzjbdBCoi87lXLivpAkRSUnOwrh0=;
        b=cxv+i9dScMiVpMLnavmHoCbKQmcgCpNcRP/naxvLJGWZ9kVJmoxyijIIg3U1m4YKS0
         yyRml8KCXeII1tDHpEeYcss1/nZ7UEonm45pMpEdCl672Yv13q0nU8JZldcKApuJQkfU
         +Ee1zrrG7C6l/vsEK6iQTyaraMCvpzoVjGX4kXCDpKULUwKN9inJ8pEU19dvny/QTtK5
         J/9be6q3yezFDsbOgrKH1CAV2h790bkC0i4J7dfWSoEuc1ez8PXv5QVjJyXqPaykyFmf
         /T6+i6zSSxSv/Sx36tS77wBmA+xgaNE6MXZi+pPbnDOTJBfG5xkfY07hlO/PXorVt+Pu
         YXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639803; x=1761244603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZxVygdfeVMO4IjGzjbdBCoi87lXLivpAkRSUnOwrh0=;
        b=HWrSmZhQCO5VoExER0DSptSJrEtkMM25RexpCk0NstxrjyfCIScq60LFMj2LOHYbLm
         JorDomhNrgjl76OdEnS1IrQO8zC3Sjl8QzpiphXNZhEu8ZBSRCeUfhx7EeRcfdNCDis9
         nzetHRIHbp5y80fm5j4khSyjMmNEc1BJEtnNquk7tgPBjF5mDH81CDvL8qx6ycbhbYsq
         BJMWA/k2U+zZwAu2G8dXS+1QjJvKa7amoC3fUJrIkFKEKJJlKx2LS6+KurlWg8VcZDWI
         ZrySnhsMGidUlobQ0nMhVgxv0RaDr2/GqkZD64+QaXdTr9vSAtXlGG+owkba0h120+7F
         7Y0g==
X-Forwarded-Encrypted: i=1; AJvYcCWxYiXxGwRhEhCjP/PLPST0Kzqq2ti2PzuFyjIT6XcGpdWiQyqglg4v9EYBfFpd+7MRMe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPuiyqxpNVW4Xc/Dl5Oki04N9gn7CLff5G5RjapKGwHzYVYKn
	UrcoCsVTsRLnBsux7haCCtp0IttjPJ1FyIUbw6COIukj5dNuNc4gOA80CXVtQiKk+PlC8LyBDvp
	rOVPHtpiFph1sIgL9EhFy9rXivNinPZ0=
X-Gm-Gg: ASbGncvjleKxnjpbzNhGBMoWGe1l7TAHonn2Whm5w2QcP9d2fLxgXXloM4wc6FTDjF9
	yxguRIjtVg/xnll8eIuM0gfMdBQ4yjOq9PYO4FNjjtp+GXJLnRj1HJ7gySI/OsE+s19wqMFTBAN
	8m4tBTOgYv/JeSJ8FM+TPYeFGgYlv9IcbUtlrhcfzOQJ2gK+AQR29t4c0i7MJ4rXL3J7oF8Weje
	DK/yu2xsHGqLxEvyid8CR9POazaHeAlVFsP28q5OWC9ZmNKvun8zO+JwWoCy5W2r9UYuh7Ay7+g
	pBrSmwGFKFc=
X-Google-Smtp-Source: AGHT+IGW+8wRCef0FKinFZKUEI5K1hL19h1xpzguPTikvYH9nvU5rSKr4WNnE2DwtlS/6QjfoibG3kRtU7xaaTiaaQY=
X-Received: by 2002:a17:90b:52c8:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-33bcf93cf19mr814399a91.37.1760639803219; Thu, 16 Oct 2025
 11:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com> <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
 <4201e67c-5a56-44f9-ad62-897326d84a41@oracle.com>
In-Reply-To: <4201e67c-5a56-44f9-ad62-897326d84a41@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:36:26 -0700
X-Gm-Features: AS18NWBw9iUrV-nnSVGYwWn4ukXlVqOJgXnYsdjs0Tu3S__4s1loG-NnDUePPbE
Message-ID: <CAEf4Bza27n44nNcPUtQHMS9OR1BH_NafY1xcRqhKORJMNamP_w@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, David Faust <david.faust@oracle.com>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 2:58=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 14/10/2025 01:12, Alexei Starovoitov wrote:
> > On Mon, Oct 13, 2025 at 12:38=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >>
> >> I was trying to avoid being specific about inlines since the same
> >> approach works for function sites with optimized-out parameters and th=
ey
> >> could be easily added to the representation (and probably should be in=
 a
> >> future version of this series). Another "extra" source of info
> >> potentially is the (non per-cpu) global variables that Stephen sent
> >> patches for a while back and the feeling was it was too big to add to
> >> vmlinux BTF proper.
> >>
> >> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
> >
> > aux is too abstract and doesn't convey any meaning.
> > How about "BTF.func_info" ? It will cover inlined and optimized funcs.
> >
>
> Sure, works for me.
>
> > Thinking more about reuse of struct btf_type for these...
> > After sleeping on it it feels a bit awkward today, since if they're
> > types they suppose to be in one table with other types,
> > searchable and so on, but we actually don't want them there.
> > btf_find_*() isn't fast and people are trying to optimize it.
> > Also if we teach the kernel to use these loc-s they probably
> > should be in a separate table.
> >
>
> The BTF with location info is a separate split BTF, so it won't regress
> search times of vmlinux/module BTF. Searching by name isn't really a
> need for the non-LOCSEC cases; None of the FUNC_PROTO, LOC_PROTO and
> LOC_PARAM have names, so the searching that will be done to deal with
> inlines will all be within the LOCSEC representations for the inlines,
> and from there it'll just be id-based lookup.
>
> Currently the LOCSECs are sorted internally by address, but we could
> change that to be by name given that name-based lookup is the much more
> likely search mode.
>
> One limitation we hit is that the max BTF vlen number is not sufficient
> to represent all the inlines in one LOCSEC; we max out at specifying a
> vlen of 65535, and need over 400000 LOCSEC entries. So we add multiple

We have this, currently:


/* Max # of struct/union/enum members or func args */
#define BTF_MAX_VLEN    0xffff

struct btf_type {
        __u32 name_off;
        /* "info" bits arrangement
         * bits  0-15: vlen (e.g. # of struct's members)
         * bits 16-23: unused
         * bits 24-28: kind (e.g. int, ptr, array...etc)
         * bits 29-30: unused
         * bit     31: kind_flag, currently used by
         *             struct, union, enum, fwd, enum64,
         *             decl_tag and type_tag
         */


Note those unused 16-23 bits. We can use them to extend vlen up to 8
million, which should hopefully be good enough? This split by name
prefix sounds unnecessarily convoluted, tbh.



> LOCSECs. That was just a workaround before, but for faster name-based
> lookup we could perhaps make use of the multiple LOCSECs by grouping
> them by sorted function names. So if the first LOCSEC was called
> inline.a and the next LOCSEC inline.c or whatever we'd know locations
> named a*, b* are in that first LOCSEC and then do a binary search within
> it. We could limit the number of LOCSECs to some reasonable upper bound
> like 1024 and this would mean we'd binary search between ~400 LOCSECs
> first and then - once we'd found the right one - within it to optimize
> lookup time.
>
> > global non per-cpu vars fit into current BTF's datasec concept,
> > so they can be another kernel module with a different name.
> >
> > I guess one can argue that LOCSEC is similar to DATASEC.
> > Both need their own search tables separate from the main type table.
> >
>
> Right though we could use a hybrid approach of using the LOCSEC name +
> multiple LOCSECs (which we need anyway) to speed things up.
> >>
> >>> The partially inlined functions were the biggest footgun so far.
> >>> Missing fully inlined is painful, but it's not a footgun.
> >>> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
> >>> user space is not enough. It's great and, probably, can be supported,
> >>> but the kernel should use this "BTF.inline_info" as well to
> >>> preserve "backward compatibility" for functions that were
> >>> not-inlined in an older kernel and got partially inlined in a new ker=
nel.
> >>>
> >>
> >> That would be great; we'd need to teach the kernel to handle multi-spl=
it
> >> BTF but I would hope that wouldn't be too tricky.
> >>
> >>> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
> >>> make a lot of sense, but since libbpf has to attach a bunch
> >>> of regular kprobes it seems to me the kernel support is more appropri=
ate
> >>> for the whole thing.
> >>
> >> I'm happy with either a userspace or kernel-based approach; the main a=
im
> >> is to provide this functionality in as straightforward a form as
> >> possible to tracers/libbpf. I have to confess I didn't follow the whol=
e
> >> kprobe multi progress, but at one stage that was more kprobe-based
> >> right? Would there be any value in exploring a flavour of kprobe-multi
> >> that didn't use fprobe and might work for this sort of use case? As yo=
u
> >> say if we had that keeping a user-space based approach might be more
> >> attractive as an option.
> >
> > Agree.
> >
> > Jiri,
> > how hard would it be to make multi-kprobe work on arbitrary IPs ?
> >
> >>
> >>> I mean when the kernel processes SEC("fentry/foo") into partially
> >>> inlined function "foo" it should use fentry for "foo" and
> >>> automatically add kprobe into inlined callsites and automatically
> >>> generated code that collects arguments from appropriate registers
> >>> and make "fentry/foo" behave like "foo" was not inlined at all.
> >>> Arguably, we can use a new attach type.
> >>> If we teach the kernel to do that then doing bpf_loc_arg() and a bunc=
h
> >>> of regular kprobes from libbpf is unnecessary.
> >>> The kernel can do the same transparently and prepare the args
> >>> depending on location.
> >>> If some of the callsites are missing args it can fail the whole opera=
tion.
> >>
> >> There's a few options here but I think having attach modes which are
> >> selectable - either best effort or all-or-none would both be needed I
> >> think.
> >
> > Exactly. For partially inlined we would need all-or-none,
> > but I see a case where somebody would want to say:
> > "pls attach to all places where foo() is called and since
> > it's inlined the actual entry point may not be accurate and it's ok".
> >
> > The latter would probably need a flag in tracing tools like bpftrace.
> > I think all-or-none is a better default.
> >
>
> Yep, agree.
>
> >>> Of course, doing the whole thing from libbpf feels good,
> >>> since we're burdening the kernel with extra complexity,
> >>> but lack of kprobe-multi changes the way to think about this trade of=
f.
> >>>
> >>> Whether we decide that the kernel should do it or stay with bpf_loc_a=
rg()
> >>> the first few patches and pahole support can/should be landed first.
> >>>
> >>
> >> Sounds great! Having patches 1-10 would be useful as that would allow =
us
> >> in turn to update pahole's libbpf submodule commit to generate locatio=
n
> >> data, which would then allow us to update kbuild and start using it fo=
r
> >> attach. So we can focus on generating the inline info first, and then
> >> think about how we want to present that info to consumers.
> >
> > Yep. Please post pahole patches for review. I doubt folks
> > will look into your git tree ;)
> >
>

BTW, what happened to the self-described BTF patches? With these
additions we are going to break all the BTF-based tooling one more
time. Let's add minimal amount of changes to BTF to allow tools to
skip unknown BTF types and dump the rest? I don't remember all the
details by now, was there any major blocker last time? I feel like
that minimal approach of fixed size + vlen * vlen_size would still
work even for all these newly added types (even with the alternative
for LOC_PARAM I mention in the corresponding patch).


> Will do; just chasing a bug found in CI, once that's fixed I'll send
> them out.
>
> >> Sure, thanks for the feedback! BTW the GNU cauldron videos are online
> >> already so the presentation [1] about this is available now for folks
> >> who missed it. I'd be happy to do a BPF office hours too of course if
> >> that would be helpful in ironing out the details.
> >
> > Can you share the slides too ?
>
>
> Sure; thanks to Jose they are available here now:
>
> https://conf.gnu-tools-cauldron.org/opo25/talk/SBMUWN/
>

