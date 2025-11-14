Return-Path: <bpf+bounces-74553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F29C5F2FB
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AF53B83F2
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BED346766;
	Fri, 14 Nov 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1mK0we8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E27342536
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151101; cv=none; b=TzE6vgysCUaaK0ai9nEklHq+roMmPFen+qmuEEQzvISp8f/lDihVoE7bY7gPdMpTTpe3MFaFoCx/YoP7Ng4IPMBkY3xhL4VYTiMFDFJHDticCCHpJE8u526qJa0891AjQFFGhkvvfXUneNEmeBgMbbo+1H51UjKsXo3rcI1ET68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151101; c=relaxed/simple;
	bh=vtl88/SUGzItkoSORAcBzHLbaUzEvO0ygrs0OsHxtUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=te0be6QVHpvDDxfRJCxs/on0KXYVAzGc6L1tZ8rHto0sLsV/VX2WEaFlgVU00fwU9p6dFbCsLtpD8Nm868YvVd5mxLHrBXnnEyoT7K2SrfLTwbPwhd1e/JcTi+euMXdWAvVDH8L72Aa3fBEneHNqi6IqCeXqHJ5HHoyLtEllii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1mK0we8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4711810948aso16339465e9.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 12:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151098; x=1763755898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+sk+wUeSdzl8C1mhfSK/q6SFW6AvwE8e4cYhONZ0/8=;
        b=E1mK0we8RHvKXOTQ+Q7YDD0uqfko1C3fG6SsAlIUI1AhFdBmwYM+/A6Ts4DRyf99pV
         WCAiYI77lldFmg10XmhAu+k5sy1mwJHLYYTyqWiJI5/b+Pfd5rmuu/b1CcH9GYCcugZg
         vid42Cc/k2NdkB+1QjaSwgENJC5IYeKNPQZ7sEZz3KtImLsgYAfqXFubmDNwbHXzRFw/
         6pZwRJjCfFaW8jU+zZlpY5Mz9kJzNRBDSA93/uRPPkCiOnChJO2tdFSVcx3SxHDAemBv
         chTmmT4AIuDi2vAnKxSbdVVAfBt2hk7FNyPNA7rVD0NJgrPYgCxrnfqMsF138Tc808Dy
         1S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151098; x=1763755898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+sk+wUeSdzl8C1mhfSK/q6SFW6AvwE8e4cYhONZ0/8=;
        b=d5lfOqa9ZdygNfukBq2lnxj9mPKOGW66nyZcxnierTrEZSKA2UI7NZ0yXvtl4yIoH5
         ZWTZI3rUFu94QBvj2fffP7Qvpc1ppkp6ACh6+jNCZ+DRIbAU6/wGU9g/O5EPVuKPIxfa
         9ixo52gcXHY2MkdnSntxOm6Aej5WFnybcRYSSxFO32WIf5OQhcbR0whpgVvCnFzzvPsn
         ZKFDojDOaKVOtlpR4M7ZFx6C0/zrAv8uf4VtV+HThVt13D6o2mabPfTOUoBkcrLu7Q73
         dk+2lZtaxmlwpRPBDWjEwIerHUArtVgyxgxb/vfBuFTRehCzpkt8V8gFAjLZg5o3B+FS
         yZRA==
X-Forwarded-Encrypted: i=1; AJvYcCVy4xETByaXcO8TMGHGTuCnFDwm5NzCbuuTZkhelpKXdiFo6hD9SSV38RJhSdViHDrOhug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfiIJFFb8NJp1c/fCU40fUrBn2TetUP1L5OI8Vr98pcZA111Ck
	GJZT3wgWEghGmgbPjsRWlNHvJKCtQdQvM/AItiJYOM4/7wni6eC4NEQ4zettFeDyDVyA2hr+y06
	gHMDCugsZTphTLgwY4QAtkgy3Jf26RoY=
X-Gm-Gg: ASbGncu3mumtndZ/DjGu0cwaGFl4N+o1WOrY4VwkmDJp990Fi/S0MTh5HSRO5bU9jce
	zaCzrvBbTQBTdOEZWXrbHTHITO2/yvldU8mg0Z2l5b2PUmKKSkaHRNnPLZfsTUia0wG+NdVhvih
	Oi/DVYg+4cdrUiDwS/3k8QtVPRE+P2JuNPMG+IgPwuJEXAFGpOZ+Uvk7MDmXcty5SPW2N8bn5Lw
	pPeifidppp//5G4i4LJjHDJTsOpNA1vjTEJxjsJNznFotln6suCLWOhD3Nslm0RGdDObmSTga5+
	eaXEveWLXx4GulW2YlpBCMz60v1r
X-Google-Smtp-Source: AGHT+IFjAukxe/zPQvsH437kULtVpRYaHhgANnAvYeh1Nt5rknazLyVLjWdmDAt/IeJc1QUgl9yaV46z23wWfBq2CIU=
X-Received: by 2002:a05:600c:1f8e:b0:471:989:9d85 with SMTP id
 5b1f17b1804b1-4778fea2d11mr43055055e9.19.1763151097690; Fri, 14 Nov 2025
 12:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111170424.286892-1-yonghong.song@linux.dev>
 <a9ebf236-78c8-439a-b427-cb817efe23ae@oracle.com> <CAADnVQKr+9gneG4ZZHBKWjTo-AiqPCf_Mxv_sCi9acqEKkKShw@mail.gmail.com>
 <3f95f01b-9cc4-499b-a18d-5c4975f0b0e5@oracle.com>
In-Reply-To: <3f95f01b-9cc4-499b-a18d-5c4975f0b0e5@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 12:11:26 -0800
X-Gm-Features: AWmQ_blaX0s0-tdmmyqbJUySguPhJdMYoeHGu3cAhdCeWLT-I3oeXZdWcHCTb5E
Message-ID: <CAADnVQ+M4CB_afuL7K0w-Kb9ii8a5bhKaf+sU7JVO7ektX6PvA@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/3] pahole: Replace or add functions with true
 signatures in btf
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Faust <david.faust@oracle.com>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 7:57=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 13/11/2025 17:36, Alexei Starovoitov wrote:
> > On Thu, Nov 13, 2025 at 8:45=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> On 11/11/2025 17:04, Yonghong Song wrote:
> >>> Current vmlinux BTF encoding is based on the source level signatures.
> >>> But the compiler may do some optimization and changed the signature.
> >>> If the user tried with source level signature, their initial implemen=
tation
> >>> may have wrong results and then the user need to check what is the
> >>> problem and work around it, e.g. through kprobe since kprobe does not
> >>> need vmlinux BTF.
> >>>
> >>> The following is a concrete example for [1].
> >>> The original source signature:
> >>>   typedef struct {
> >>>         union {
> >>>                 void            *kernel;
> >>>                 void __user     *user;
> >>>         };
> >>>         bool            is_kernel : 1;
> >>>   } sockptr_t;
> >>>   typedef sockptr_t bpfptr_t;
> >>>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> >>> After compiler optimization, the signature becomes:
> >>>   static int map_create(union bpf_attr *attr, bool uattr__coerce1) { =
... }
> >>>
> >>> In the above, uattr__coerce1 corresponds to 'is_kernel' field in sock=
ptr_t.
> >>> Here, the suffix '__coerce1' refers to the second 64bit value in
> >>> sockptr_t. The first 64bit value will be '__coerce0' if that value
> >>> is used instead.
> >>>
> >>> To do proper tracing, it would be good for the users to know the
> >>> changed signature. With the actual signature, both kprobe and fentry
> >>> should work as usual. This can avoid user surprise and improve
> >>> developer productivity.
> >>>
> >>> The llvm compiler patch [1] collects true signature and encoded those
> >>> functions in dwarf. pahole will process these functions and
> >>> replace old signtures with true signatures. Additionally,
> >>> new functions (e.g., foo.llvm.<hash>) can be encoded in
> >>> vmlinux BTF as well.
> >>>
> >>> Patches 1/2 are refactor patches. Patch 3 has the detailed explanatio=
n
> >>> in commit message and implements the logic to encode replaced or new
> >>> signatures to vmlinux BTF. Please see Patch 3 for details.
> >>>
> >>
> >>
> >> Thanks for sending the series Yonghong! I think the thing we need to
> >> discuss at a high level is this; what is the proposed relationship
> >> between source code and BTF function encoding? The approach we have
> >> taken thus far is to use source level as the basis for encoding, and a=
s
> >> part of that we attempt to identify cases where the source-level
> >> expectations are violated by the compiled (optimized) code. We current=
ly
> >> do not encode those cases as in the case of optimized-out parameters,
> >> source-level expectations of parameter position could lead to bad
> >> behaviour. There are probably cases we miss in this, but that is the
> >> intent at least.
> >>
> >> There are however cases where .isra-suffixed functions retain the
> >> expected parameter representations; in such cases we encode with the
> >> prefix name ("foo" not "foo.isra.0") as DWARF does.
> >>
> >> So in moving away from that, I think we need to make a clear decision
> >> and have handling in place. My practical worry is that users trying to
> >> write BPF progs cannot easily predict if a parameter is optimized out
> >> and so on, so it's hard to write stable BPF programs for such
> >> signatures. Less of a problem if using a high-level tracer I suppose.
> >>
> >> The approach I had been thinking about was to utilize BTF location
> >> information for such cases, but the RFC [1] didn't get around to
> >> implementing the support. So the idea would be have location info with
> >> parameter types and locations, but because we don't encode a function
> >> fentry can't be used (but kprobes still could as for inline sites). So
> >> under that scheme the foo.llvm.hash functions could still be called
> >> "foo" since we have address information for the sites we can match foo
> >> to foo.llvm.hash.
> >>
> >> Anyway I'd appreciate other perspectives here. We have implicitly tied
> >> BTF function encoding thus for to source-level representation for
> >> reasons of fentry safety, but we could potentially move away from that=
.
> >> Doing so though would I think at a minimum require machinery for fentr=
y
> >> safety to preserved, but we could find other ways to flag this in the
> >> BTF function representation potentially. Thanks!
> >
> > Looks like we have a big disconnect here.
> > To me BTF was never about the source, but about vmlinux final binary.
> > Compile flags, configs change both types and functions significantly.
> > For types it's easy to see in the vmlinux BTF how they got transformed
> > from the original types in the source. Some source types disappear
> > altogether. Similar situation with functions. They mutate.
> > Partial inling, function renames are all part of the same category.
> > BTF has to describe the final result, so that tracers/users can
> > actually debug/introspect the kernel they have and not an abstract
> > kernel source. pahole was conservative and removed functions that
> > don't match BTF. loc* set is going to bring back these functions
> > into BTF with their arguments. True signature support is complementary
> > and mandatory part to loc* set. We need both. Compiler has to
> > store the true signature in dwarf and pahole has to pass it to BTF
> > along with location of arguments and actual name of function symbol tab=
le.
> >
>
> I don't object to having a representation tied to the final binary;
> however I will say there is huge value in _knowing_ things changed from
> source to final representation. Now if we encode function names with '.'
> suffixes that is one way of knowing, and it may be enough,

Right. llvm will use '.llvm' suffix to indicate the change,
and imo it's enough of the signal. I don't think we need to store
original func signature in BTF. It feels just a waste of BTF space,
since tracers cannot use it for anything. It's like a historical artifact.
Nice to know, but it's there in dwarf for people interested in history.

> but I think
> we should think about mechanisms to ease overall developer experience in
> that new world.

and that's exactly the purpose of Yonghong's llvm patches.
Without them the dwarf is missing the final function signature.
They will improve your loc* coverage too.

> When I write a BPF program for fentry(), it seems to me to be deeply
> inconsistent that I can make it work across multiple kernel versions
> from a data structure perspective via CO-RE while also having to worry
> about the risk of compiler optimizations transforming or eliminating
> function parameters. It is a step forward in some ways that we can trace
> such functions at all, but I still think we will need a better story
> there.

Quality of debug info in compilers is an afterthought, sadly.
All optimizations are trying to preserve it as much as possible,
of course, but "shrug, it was optimized out" is deployed too often as well.

> For example it is often the case that a BPF program only uses one
> parameter from a function signature; if we don't access transformed or
> eliminated parameters, can the verifier accept the fentry() even if the
> signature doesn't exactly match? We don't need to add these things
> today, but I think it would be good to discuss some of the consequences
> and how we would possibly handle them.

Yeah. We can relax the verifier. Menglong had patches for
multi-attach-fentry where it solved the case where an argument
with the same type is present in multiple kernel functions.
In that case we can have one fentry prog attach to all of them
and access only that arg.

>
> > Re: whether to strip .llvm or not, I think it's better to keep BTF
> > matching symbol table which is kallsyms. If it has .llvm suffix in kall=
syms
> > it should have the same name in BTF. Tracing tools can attach
> > with "func_name.*" pattern. libbpf already supports it.
> > And thanks to BTF the fentry prog should match what is true
> > kernel function signature. What was the source signature is secondary.
> > The users cannot write their progs based on source, since such
> > source code doesn't exist in the binary, so nothing to trace.
> > While true signature with actual parameters is traceable.
>
> Yeah I think if we are passing through the changed function signatures
> we definitely need a way to know such changes happened; the "." suffix
> will tell us that.

yep. gcc needs to be improved too, since it will add a suffix, but won't
update dwarf sufficiently. I think it will only strip args
of location info, but won't update func signature.
While llvm now will store new actual signature and update locations.

Note the whole thing mainly affects LTO builds. There are lots
of .llvm funcs in them. Kernel doesn't support gcc lto yet.

