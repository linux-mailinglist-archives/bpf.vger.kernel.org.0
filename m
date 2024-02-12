Return-Path: <bpf+bounces-21758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A527A851D86
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562F9288368
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A3B45970;
	Mon, 12 Feb 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb3IIlLY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48241206
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764524; cv=none; b=DzGJ5yJK67/XcEN9WNrJbvTYceFsjeMBndZ5jRRzmaaH+S868chwMKkxXojPMqHWN8DrYZEpJBNWmpd9ZbUP+rIvHyeJ4vJ7tyvAeq7UfMRaXUBl1TT1wAoHlmws4Nw6fy6KLY3Ejn/hQ36NnI6MAT6uCuRT6bMjQzNUpULo6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764524; c=relaxed/simple;
	bh=fpyI/wk9UxuA0eASFLHRQvr+n9HbzGvxdRv1OaS3Dz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hor6pYC2k8uBFHNbD5NzULSjgIgmAtrQeBz3UP52Eplw4NveefZanZnmji98IQkg0NzOdMSRTYV2hTD/3xGfrDsqne1C7XUzoxW92XLO3mU+qUVs3eScizdM4hSKVWcedeQTVTsHiiYpfq5RgQx9WH7syGeW6QWLyAN2oatvaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb3IIlLY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso27416715ad.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707764522; x=1708369322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee3OmApGGxROBDlK2MKC2RYXp0IBoseonzGeOcm5gTU=;
        b=Nb3IIlLYa3RHbdKvESD5Vm3gvyicX1oCgxfZjYita3alFvtHwtDq+3Ii/DKrubc9qk
         jZLkyP+Wt0IFOXeCjFlRNNTezd6jWRyTZAa9q/WrhLY9LjpzTn9XBymvLJb07jAzcZ09
         LluosxBqjyEL2RZWSw0NEcw1hn9m+RkohYCT7MSPr8Ya7cMlLAPMyONFQTHGVuXOKrvh
         xR1n6xV2vpUPSMfclyL1ufII77r6ZiAu+vbuGrQ1e8tKby7eSTMfgdpXJLDDo7yZN63P
         CaGsXeABfkQvyq7lhzY2AtMCChJqpTggKjD2R1sfypvexYkp6NE9HK41SVbnm1cjPfT9
         8Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764522; x=1708369322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ee3OmApGGxROBDlK2MKC2RYXp0IBoseonzGeOcm5gTU=;
        b=sZE14iw7VQ5PxCYESbQ7oOUAUB8FOssDGQhI6wmMsZ8LxRzen6vq7tjGXSeUCoaHco
         CXKhotF8/qdbauH7o/hOxjCBe/eIkGvl0VJKosMZZyFuat0UTWJyIGDGimoMFgv6n8KX
         U4Z3eWPOL1cwFI3jLUHR4RxNzYIyGlPqGHb5o4XA1jgrHenaDHhhru1OVV6AMUJfh5nE
         X01AHmbwoDWwhi7VDXGr3jbFmQWQOUt9+AjTvz6cpycy09O2HiAWSc/Q/DWohvchx2Ve
         k/Y1a5qUUt3ZuMPlQlAdai6ThPadYiDXwtZKZEyYQskir4OpOmWUCniXtNZkiCM72KKY
         DHEg==
X-Forwarded-Encrypted: i=1; AJvYcCUgOCLW/NbOIU3xmGdJD2A81d1zlFbGiid3OIJ0KJJDIlOpPZJhh6m6Xf0IABWPRIuVjVcKB+i7xs+Mi8PuRFWQ+rP2
X-Gm-Message-State: AOJu0YxuRzErfvdruXYjjtix05fkQclLlA9jHv42bRsk33mAnCij/ts3
	RSNFhq9BI3a+bS9U77uGRIPH0M54E16IfY2SE5hcrN5kFESj/xy5LKn/aHJutEM26OjSE/hJHvM
	a9Zc5fzCYMLwvURXrJBbM4ABKfZM=
X-Google-Smtp-Source: AGHT+IH0oRFoVAaxbiH9JgOTd5ofoeo4A0hrz5aAvOj9fYY0dUAGhCk0S7PVZXoKhsEHk31L5/IiqY75MDy0LYLS5vo=
X-Received: by 2002:a17:90b:1498:b0:298:9883:c3b with SMTP id
 js24-20020a17090b149800b0029898830c3bmr469698pjb.16.1707764522188; Mon, 12
 Feb 2024 11:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210003308.3374075-1-andrii@kernel.org> <CAADnVQ+yvpZ=-gWtU_4w4wJ52ULZcqVRq+4E-BGNZmTjfKPYRA@mail.gmail.com>
 <CAEf4Bzb11hQw9DX7c+AKcCjTrsh8yAcEPvUotCBwZv=1B3Su2g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb11hQw9DX7c+AKcCjTrsh8yAcEPvUotCBwZv=1B3Su2g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Feb 2024 11:01:50 -0800
Message-ID: <CAEf4Bzb0KajZt85zgRJSeSJazFDFFXmJyhQd64zZUc5phqBUFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: emit source code file name and line number
 in verifier log
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:59=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Feb 11, 2024 at 11:43=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Feb 9, 2024 at 4:33=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > As BPF applications grow in size and complexity and are separated int=
o
> > > multiple .bpf.c files that are statically linked together, it becomes
> > > harder and harder to match verifier's BPF assembly level output to
> > > original C code. While often annotated C source code is unique enough=
 to
> > > be able to identify the file it belongs to, quite often this is actua=
lly
> > > problematic as parts of source code can be quite generic.
> > >
> > > Long story short, it is very useful to see source code file name and
> > > line number information along with the original C code. Verifier alre=
ady
> > > knows this information, we just need to output it.
> > >
> > > This patch set is an initial proposal on how this can be done. No new
> > > flags are added and file:line information is appended at the end of
> > > C code:
> > >
> > >   ; <original C code> (<filename>.bpf.c:<line>)
> > >
> > > If file name has directory names in it, they are stripped away. This
> > > should be fine in practice as file names tend to be pretty unique wit=
h
> > > C code anyways, and keeping log size smaller is always good.
> > >
> > > In practice this might look something like below, where some code is
> > > coming from application files, while others are from libbpf's usdt.bp=
f.h
> > > header file:
> > >
> > >   ; if (STROBEMETA_READ( (strobemeta_probe.bpf.c:534)
> > >   5592: (79) r1 =3D *(u64 *)(r10 -56)     ; R1_w=3Dmem_or_null(id=3D1=
589,sz=3D7680) R10=3Dfp0 fp-56_w=3Dmem_or_null(id=3D1589,sz=3D7680)
> > >   5593: (7b) *(u64 *)(r10 -56) =3D r1     ; R1_w=3Dmem_or_null(id=3D1=
589,sz=3D7680) R10=3Dfp0 fp-56_w=3Dmem_or_null(id=3D1589,sz=3D7680)
> > >   5594: (79) r3 =3D *(u64 *)(r10 -8)      ; R3_w=3Dscalar() R10=3Dfp0=
 fp-8=3Dmmmmmmmm
> > >
> > >   ...
> > >
> > >   170: (71) r1 =3D *(u8 *)(r8 +15)        ; frame1: R1_w=3Dscalar(smi=
n=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff)) R=
8_w=3Dmap_value(map=3D__bpf_usdt_spec,ks=3D4,vs=3D208)
> > >   171: (67) r1 <<=3D 56                   ; frame1: R1_w=3Dscalar(sma=
x=3D0x7f00000000000000,umax=3D0xff00000000000000,smin32=3D0,smax32=3Dumax32=
=3D0,var_off=3D(0x0; 0xff00000000000000))
> > >   172: (c7) r1 s>>=3D 56                  ; frame1: R1_w=3Dscalar(smi=
n=3Dsmin32=3D-128,smax=3Dsmax32=3D127)
> > >   ; val <<=3D arg_spec->arg_bitshift; (usdt.bpf.h:183)
> > >   173: (67) r1 <<=3D 32                   ; frame1: R1_w=3Dscalar(sma=
x=3D0x7f00000000,umax=3D0xffffffff00000000,smin32=3D0,smax32=3Dumax32=3D0,v=
ar_off=3D(0x0; 0xffffffff00000000))
> > >   174: (77) r1 >>=3D 32                   ; frame1: R1_w=3Dscalar(smi=
n=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
> > >   175: (79) r2 =3D *(u64 *)(r10 -8)       ; frame1: R2_w=3Dscalar() R=
10=3Dfp0 fp-8=3Dmmmmmmmm
> > >   176: (6f) r2 <<=3D r1                   ; frame1: R1_w=3Dscalar(smi=
n=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R2_w=3Dscalar()
> > >   177: (7b) *(u64 *)(r10 -8) =3D r2       ; frame1: R2_w=3Dscalar(id=
=3D61) R10=3Dfp0 fp-8_w=3Dscalar(id=3D61)
> > >   ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
> > >   178: (bf) r3 =3D r2                     ; frame1: R2_w=3Dscalar(id=
=3D61) R3_w=3Dscalar(id=3D61)
> > >   179: (7f) r3 >>=3D r1                   ; frame1: R1_w=3Dscalar(smi=
n=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R3_w=3Dscalar()
> > >   ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
> > >   180: (71) r4 =3D *(u8 *)(r8 +14)
> > >   181: safe
> > >
> > > I've played with few different formats and none stood out as
> > > particularly better than other. Suggestions and votes are appreciated=
:
> > >
> > >   a) ; if (arg_spec->arg_signed) (usdt.bpf.h:184)
> > >   b) ; if (arg_spec->arg_signed) [usdt.bpf.h:184]
> > >   c) ; [usdt.bpf.h:184] if (arg_spec->arg_signed)
> > >   d) ; (usdt.bpf.h:184) if (arg_spec->arg_signed)
> >
> > Great idea.
> > I would drop parenthesis. Don't see a reason to wrap a text.
> > Since we already use ';' as a comment I would continue:
>
> A bit worried that it will quite weird for any source line which ends
> in ';', like:
>
> ; x =3D 123; ; my_file.bpf.c:123
> r1 =3D 123;
>
>
> E.g., here's a real excerpt (I cut some register states for cleanliness):
>
> ; if (i >=3D map->cnt) ; strobemeta_probe.bpf.c:396
> 5376: (79) r1 =3D *(u64 *)(r10 -40)     ;
> R1_w=3Dmap_value(map=3Draw_map_heap,ks=3D4,vs=3D264) R10=3Dfp0
> 5377: (79) r1 =3D *(u64 *)(r1 +8)       ; R1_w=3Dscalar(...) R9_w=3D10
> ; if (i >=3D map->cnt) ; strobemeta_probe.bpf.c:396
> 5378: (dd) if r1 s<=3D r9 goto pc-5     ; R1_w=3Dscalar(smin=3Dumin=3D11,=
...)
> ; descr->key_lens[i] =3D 0; ; strobemeta_probe.bpf.c:398
> 5379: (b4) w1 =3D 0                     ; R1_w=3D0
> 5380: (6b) *(u16 *)(r8 -30) =3D r1      ; R1_w=3D0
> ; task, data, off, STROBE_MAX_STR_LEN, map->entries[i].key); ;
> strobemeta_probe.bpf.c:400
> 5381: (79) r3 =3D *(u64 *)(r7 -8)       ; R3_w=3Dscalar()
> R7_w=3Dmap_value(map=3Draw_map_heap,ks=3D4,vs=3D264,off=3D192)
> 5382: (7b) *(u64 *)(r10 -24) =3D r6     ; ...
> ; task, data, off, STROBE_MAX_STR_LEN, map->entries[i].key); ;
> strobemeta_probe.bpf.c:400
> 5383: (bc) w6 =3D w6                    ; R6_w=3Dscalar(...)
> ; barrier_var(payload_off); ; strobemeta_probe.bpf.c:280
> 5384: (bf) r2 =3D r6                    ; R2_w=3Dscalar(...)
> 5385: (bf) r1 =3D r4
>
> VS
>
> ; if (i >=3D map->cnt) (strobemeta_probe.bpf.c:396)
> 5376: (79) r1 =3D *(u64 *)(r10 -40)     ;
> R1_w=3Dmap_value(map=3Draw_map_heap,ks=3D4,vs=3D264) R10=3Dfp0
> 5377: (79) r1 =3D *(u64 *)(r1 +8)       ; R1_w=3Dscalar()
> ; if (i >=3D map->cnt) (strobemeta_probe.bpf.c:396)
> 5378: (dd) if r1 s<=3D r9 goto pc-5     ; R1_w=3Dscalar(...) R9_w=3D10
> ; descr->key_lens[i] =3D 0; (strobemeta_probe.bpf.c:398)
> 5379: (b4) w1 =3D 0                     ; R1_w=3D0
> 5380: (6b) *(u16 *)(r8 -30) =3D r1      ; R1_w=3D0
> ; task, data, off, STROBE_MAX_STR_LEN, map->entries[i].key);
> (strobemeta_probe.bpf.c:400)
> 5381: (79) r3 =3D *(u64 *)(r7 -8)       ; R3_w=3Dscalar()
> R7_w=3Dmap_value(map=3Draw_map_heap,ks=3D4,vs=3D264,off=3D192)
> 5382: (7b) *(u64 *)(r10 -24) =3D r6     ; ...
> ; task, data, off, STROBE_MAX_STR_LEN, map->entries[i].key);
> (strobemeta_probe.bpf.c:400)
> 5383: (bc) w6 =3D w6                    ; R6_w=3Dscalar(...)
> ; barrier_var(payload_off); (strobemeta_probe.bpf.c:280)
> 5384: (bf) r2 =3D r6                    ; R2_w=3Dscalar(...)
> 5385: (bf) r1 =3D r4
>
>
> Can't say that either is super nice and clean. But when I tried e)
> proposal, I realized that semicolon separators are used also for
> register state (next to instruction dump) and they sort of overlap
> visually more and make it a bit harder to read log (subjective IMO, of
> course).
>
> But let me know if you still prefer e) and I'll send v2 with it.
>

Goodness, gmail made everything even worse. See [0] for visual comparison

  [0] https://gist.github.com/anakryiko/f5e9217f277b0f8cd156ceb6cb641268


> >
> > e) ; if (arg_spec->arg_signed) ; usdt.bpf.h:184
> >
> > Note that that fragile test needs to be adjusted again:
> > Error: #137/3 log_fixup/bad_core_relo_trunc_full
>
> yep, my bad, I forgot to run all test_progs tests this time, already
> fixed locally
>
> >
> > pw-bot: cr

