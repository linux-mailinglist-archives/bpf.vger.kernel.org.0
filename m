Return-Path: <bpf+bounces-73163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30667C25C79
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 16:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4801B24429
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055411D88D7;
	Fri, 31 Oct 2025 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK3oM/fy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BC1DFD8B
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923116; cv=none; b=uUiK+Oy2Um9Qo2zg1o09NLme8ijDNqbnC40CSBsZNuPYoEh5MP62c+SOPNNArTHIlhYct7+seygp27jT8V8o5a3ya/3WMypeyTtgDgV+dcxOQtB+fsvpxZpqz3bSiyqb70NIgQsbwJWM4fShe55sqB7cG5yPtY/p07XChoeTYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923116; c=relaxed/simple;
	bh=RK6Zcy9NFY96uRzC7PBZ7s1ei36s6Mq2VwJufU3jbYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ol8uYK5QtqhXac4Elu8r1d4885xfACfFALdsUiieE2tPIsWYkbCODhEpE2RjwXwPOi+3J0MTDqxKm7ImcY5hrdgL7lumAn0/6UwQo87DurOXehiEP9Yp73BQTIutZ+UCVaJ9fQghUvdb+OXejlZN9W4Rbn7ss+dE9tzIiaWgPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK3oM/fy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2191462f8f.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923113; x=1762527913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O3c82++KWdDvCpzIe8TLBFxNUHsbtIO1HGRVwZvWPA=;
        b=aK3oM/fyudEhRy1GIFpXKskeJuLpOWMQ0hRERZ2h5WkPvP0fwM2vlC66OYI/DouVR1
         nutiQiq1Kge1QDbAoJl0WE/c0PMc30bpFxT2c+P2rDLZP/qm4NQ8jGat77fBGdQNrXLB
         YfsPofPi8C6aSsdAH2i8OOiDlH4ZB4SqiIP1x6eoOajuK5Cgqxv0vTqDsyha1tH5HIpo
         pZWOOhBsOUCxYjRxfXoVragDoAr9DNKjGmORNNc1hJI1zTMtF1vczbUq8k1T2Cwnl17q
         oR4ITXAZLNx4p24yJwMF0wzaui8AAwfolIBCEVgsxy1WNI4Q6XBjhkT/XHFwmhOXHDYU
         UOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923113; x=1762527913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O3c82++KWdDvCpzIe8TLBFxNUHsbtIO1HGRVwZvWPA=;
        b=fgsKb/6vPLQFuuqG+zc0TiSp+n6u383lvOibjC3OZKPSuJMDrp75M49aErYzjj+Nic
         mL+zEiATDaz3FRyNeaqZwiA0lg8LMeA2M8Eqa+EENdwcPr7Xu2gwM9RB09y3VHZDWevN
         amNJ1QIkBbuODm9yYiyVsox3JU+mfiPkPxmMrhZBL+nzyWmmZ/ss25D65gopQXfQ+9oj
         /Dcmc+MLNb6AOTpCLvQaIz0c8QCYjvSW2yfnjaCfTWwayXqVkHUkEVJafk94voNuvm/+
         sElCRO5/jA4u8uM7G9E942Uhg+Zeo3Zt6WKlG3yBBwQO6FumYF0xLPYAEPtFkofTW2BO
         N+wQ==
X-Gm-Message-State: AOJu0YyT7EUjKTcTdvIHxQqksKheC+qq3+zPScBnb36mOunZV5sMD6Yk
	q4i2gp+Elax5461KeOObesw/WtGpyWY0qBXn/PEoo+VC1zZWiNT8HxiPm5898BuoitrtIW+wH3b
	9XoLXCyv4F7zHeoKGY3zOjSdbvku3byY=
X-Gm-Gg: ASbGncu77Gc2RHMvLz1IFjeKGMobdVOZ6fiHBk759fO/7UScFaSe/aXmIZ9JEvCXP/1
	78v9TuxRi3qslJEM7MvM8wbhaY+dhB/cCbQ9omCATYvhzwR+dJchH1yWoMf9Dn5M4ksXuy4Uu+C
	FbzULVi1Lqs8ro7Gv7/In6hPeFHWXfk3Rr5G5EXW1c/ptsQHg78g9QmaPcJXKBt0Ki7jnwgF96O
	iro0x1J0jzgVQe4HdPS2+T3DYgLbD9XgT+1MIESirvIPNGcZ2efaucxVRmIu4fkdbZBMGjToSJn
	9tw9g0Kw0eoVkhjLvrmO97z8AAnL
X-Google-Smtp-Source: AGHT+IG5pX7UQItM29TTj/XoMRmE0wLUXn+oNWuHA+OlVVNcUPYtde9UaAqfz3m2P+LdQKkRp/5mpAiAE8/6e4IUuQA=
X-Received: by 2002:a05:6000:2f88:b0:425:852e:6ea0 with SMTP id
 ffacd0b85a97d-429bd6727cdmr3025404f8f.2.1761923112807; Fri, 31 Oct 2025
 08:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
 <20251028142049.1324520-2-a.s.protopopov@gmail.com> <CAADnVQL1nznRsfdSgFPxSf1Rdhq7hpQMcmT7BKaRn9KHwD=P6A@mail.gmail.com>
 <aQRj4bxjbrECVIb9@mail.gmail.com>
In-Reply-To: <aQRj4bxjbrECVIb9@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 08:04:59 -0700
X-Gm-Features: AWmQ_bls0Ebp-V0FxwfQ-Aea7xSQ7xNdagNNyeT3o6OM7MtL67ImUl7vtOY_Yls
Message-ID: <CAADnVQLbhmGXzjpvt0fQGRbVd=MFTnWkZxub6RPBfD+mfLB=-A@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/11] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:16=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/10/30 03:50PM, Alexei Starovoitov wrote:
> > On Tue, Oct 28, 2025 at 7:15=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >                 }
> > > +
> > > +               bpf_prog_update_insn_ptrs(prog, addrs, image);
> > > +
> >
> > I suspect there is off-by-1 bug somewhere in bpf_prog_update_insn_ptrs(=
) math,
> > since addrs[0] points to function prologue.
> > addrs[1] is the offset of the first bpf insn.
> > See how it's called in other place:
> >    bpf_prog_fill_jited_linfo(prog, addrs + 1);
>
> So all the maps I have in all selftests tests point to a wrong ip for
> every goto, and still work?
>
> In fact, addrs[0] points to right after the prologue, see how it is
> initialized in do_jit:
>
>   addrs[0] =3D proglen;
>
> here proglen is the length of prologue. The loop in do_jit startrs
> with i=3D1, but all addrs are referenced with i-1:
>
>     case BPF_JMP | BPF_CALL: {
>             u8 *ip =3D image + addrs[i - 1];
>
> The bpf_prog_fill_jited_linfo internally also does the -1 thingy:
>
>     insn_to_jit_off[linfo[i].insn_off - insn_start - 1];

I added that '+ 1' in
commit 7c2e988f400e ("bpf: fix x64 JIT code generation for jmp to 1st insn"=
)

Please add a comment to explain what addrs[] are and
that bpf_prog_update_insn_ptrs() treats this array as
offsets to 1st byte, while bpf_prog_fill_jited_linfo() is offset to last
for historical reasons.

