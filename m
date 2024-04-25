Return-Path: <bpf+bounces-27820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A7B8B255A
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E541C230C6
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2414B08A;
	Thu, 25 Apr 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ4JrZ5m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0A14B080
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059625; cv=none; b=crrLWsFawZnNapi/p+O/ochQnTv4olUY4GthdNuLlfn9lGhGeyhLQ2HPqQ97Rsz84T9PJijm7AhL0HsD33zbKbgiV6vXVSuibLepoW6MQWLVs2IHKTg8+yOU1T0/K0yvKrcs68iB1IbE6/aA5+qiVtKahFjwu5hMtbge+XZoH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059625; c=relaxed/simple;
	bh=U6OvUIS/IVp9v9x7FeI/F5/zX7E0sIlov/2+rD4i0vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWaXVJh64xgK6nuuBjIGdjcUnbg8n5fqO880mXDlUG9mBkVfyhz9AsqdkRZT9YQtVTjjn+7bP6Ui4/DWrL6gziep/3AL2q2db3OGa2BEAZvT/bD0ttoQw9Ot4PI8J0ToSAh629+LNrNg+hfFVM4gt++z9JK5+61b8qQ5mmN1SPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ4JrZ5m; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34be34b3296so1037496f8f.1
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714059622; x=1714664422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wb/HAqJpEY/M4fwh3sH16skV8S68XE1uMlZGlIJwJY=;
        b=VZ4JrZ5m/jP1/x0NdvQiIwUGku4+R9QSoe5G0U5bI9Z8l09X4fn+ZkgE9InFs7NV70
         qQfma9n9DdncgrclrrJjKcG6r/A05G7osqy+xqLbeJkQSpN3J9Q5KYFZmu/5bJlkvW+e
         KiahECLZK7rXcy2s9KwxN8Bqo0n5GoSMklO9nlbvGuQE4nTxMFS8fxJJvmYfeVi5sYME
         Ykdk32cjULyL+rPO+uBypczby6qtv/K4ekxosj4CzToCBzr90BpHoj+0pNLg2MpoUSw9
         ii+yq8VNK1mK0FN0ITbiAedZdHUAU6HNxq5sGKpyyP2zBupvArbryydbOh+czWn1CbS2
         RSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059622; x=1714664422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wb/HAqJpEY/M4fwh3sH16skV8S68XE1uMlZGlIJwJY=;
        b=KanYqFrNjK+jicHRHbkvbid5nZZubE7GVgZQfiSXXfsVZm93zJ7/euxbK29KFboMHd
         86lPLmO/ipx8X5j491us9kWr6+t9qCYHnJnblLv5zCG8d/K0YOINF9DTY1/h/7Nq5cDj
         tlW/GASmorELXCDvUCplXZkSpU+de6i7k6ckOnDvaadw4eAFuMn5pfMCmamNk/PIlXfV
         J71m/iyZEeRXczyTsGQAwLmmESFr0uPamOfNUQA6R+L5PDZDAUC31LPwXsAcMeYubKFR
         VRx8Eel3VgRlAfn1wL21JccvLfJVU/lh3oo/bkYw5Pnism8l7zziJ+9c9VxElJ245FkM
         d8qw==
X-Forwarded-Encrypted: i=1; AJvYcCX6wcUyZXa/RBhaVJZB63QVzNN/aQ0pY6vIHIMyO4bjE7XPPHskXHD9nM7fEdMeI4LArg5oBtUn8YKrZzuyfSDFrcT3
X-Gm-Message-State: AOJu0YyXq2DgHHk0tqqa3nPUiOA7cPaQUqjODr/Ez3W5WSvSEhzPSrXE
	0nOZk4zE3KG41BGKZ2n92HzqeVZqJi1SMj2Ld77CbOd1yGDMAR7W5xbHzVv2SowXoIek4zAeLmn
	fg/+kz5m2SBWDyOgX4h+1wdwhEE6qLQ==
X-Google-Smtp-Source: AGHT+IHI6MKFVriJf/Dj/yoO+YskMvRzkptygavZTcH+pw0NcInWCSUFr+zuHRRJifK30jjHZd6gzRWBHuWs5M/IkFs=
X-Received: by 2002:a05:6000:1361:b0:349:9e18:9f73 with SMTP id
 q1-20020a056000136100b003499e189f73mr5920259wrz.67.1714059622158; Thu, 25 Apr
 2024 08:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
 <744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev> <87v8465u8p.fsf@oracle.com>
 <CAADnVQJzLzrxtHeVcpNBtb-rnwWfApFEy_kv7LzWDee4pH1ezQ@mail.gmail.com> <87a5lh4o7r.fsf@oracle.com>
In-Reply-To: <87a5lh4o7r.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Apr 2024 08:40:11 -0700
Message-ID: <CAADnVQJJtNc=kqPby5bckOHzUFzdn_mD57c=0U7iyD23yrpKCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in selftests/bpf/Makefile
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, David Faust <david.faust@oracle.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, indu.bhagat@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:32=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Wed, Apr 24, 2024 at 2:30=E2=80=AFPM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >>
> >> Hi Yonghong.
> >>
> >> > On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
> >> >> This little patch modifies selftests/bpf/Makefile so it passes the
> >> >> following extra options when invoking gcc-bpf:
> >> >>
> >> >>   -gbtf
> >> >>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
> >> >
> >> > Could we do if '-g' is specified, for bpf program,
> >> > btf will be automatically generated?
> >>
> >> Hmm, in principle I wouldn't oppose for -g to mean -gbtf instead of
> >> -gdwarf.  DWARF can always be generated by using -gdwarf.
> >>
> >> Faust, Indu, WDYT?
> >>
> >> >>
> >> >>   -mco-re
> >> >>     This tells GCC to generate CO-RE relocations in .BTF.ext.
> >> >
> >> > Can we make this default? That is, remove -mco-re option. I
> >> > can imagine for any serious bpf program, co-re is a must.
> >>
> >> CO-RE depends on BTF.  So I understand the above as making -mco-re the
> >> default if BTF is generated, i.e. if -gbtf (or -g with the modificatio=
n
> >> above) are specified.  Isn't that what clang does?  Am I interpreting
> >> correctly?
> >>
> >> >>
> >> >>   -masm=3Dpseudoc
> >> >>     This tells GCC to emit BPF assembler using the pseudo-c syntax.
> >> >
> >> > Can we make it the other way round such that -masm=3Dpseudoc is
> >> > the default? You can have an option e.g., -masm=3Dnon-pseudoc,
> >> > for the other format?
> >>
> >> We could add a configure-time build option:
> >>
> >>   --with-bpf-default-asm-syntax=3D{pseudoc,normal}
> >>
> >> so that GCC can be built to use whatever selected syntax as default.
> >> Distros and people can then decide what to do.
> >
> > distros just ship stuff.
> > It's our job to pick good defaults.
>
> Yeah it was a rather dumb idea that would only complicate things for no
> good reason.
>
> The unfortunate fact is that at this point the kernel headers that
> almost all BPF programs use contain pseudo-C inline assembly and having
> the toolchain using the conventional assembly syntax by default would
> force users to specify the command-line option explicitly, which is a
> great PITA.  So I guess this is one of these situations where the worse
> option is indeed the best default, in practical terms.
>
> So ok, as much as it sucks we will make -masm=3Dpseudoc the default in GC=
C
> for the sake of practicality.
>
> > I agree with Yonghong that -g should imply -gbtf for bpf target
> > and -mco-re doesn't need to be a flag at all.
>
> We like the idea of -g implying -gbtf rather than -gdwarf for the BPF
> target.  It makes sense.  Faust is already working on it.
>
> As for -mco-re, it is already the default with -gbtf, and now it will be
> the default for -g.
>
> > Compiler should do it when it sees those special attributes in C code.
> > -masm=3Dpseudoc is a good default as well, since that's what
> > everyone in bpf community is used to.
>
> We will try to get all the changes above upstream before GCC 14 gets
> branched, which shall happen any day now.  Once they are in GCC the only
> extra option to be added to GCC_BPF_BUILD_RULE will be -g.  Will send an
> updated patch then.

Awesome. This is all great to hear.

Thanks!

