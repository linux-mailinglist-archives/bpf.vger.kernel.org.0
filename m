Return-Path: <bpf+bounces-73548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13445C337F7
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB2F24E9125
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D49E224AED;
	Wed,  5 Nov 2025 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKg+xjRu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62A24B28
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303451; cv=none; b=mfUXDQkAFqiH6yHnJvcpBsEFX7KLiRTitsLQ545/aE070gTtzfdsQlTCh4R7vXgTEgyqkZUY3+EFlF1tE95t/vvdjDrC0vHSRASmdloJQMvJr8qGGOvphsZffbWeWV9FuZ1Yxbt/iI67gFGudJSV+GqQhLLSRxWSCGwlf2IgtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303451; c=relaxed/simple;
	bh=dnZ22gMTJpvm0BFtHPge4QdB6qX0zzBXPAKGujJwbtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCj3OePC4gyYe1ndktq2AKLSfo093TmvYxPiCCw+h23vVibO7+Q96L31EAFoFG8IONb8Yfuj93WxeZIuL3saZSMtgYSGVa6yFFcosNOY4Z/rd0pKJCwKvybinHTl1/obm2c9jQ4Rh3oMZ3zocr+6dfUvC9nfpytWuV0/QTa+g1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKg+xjRu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso6078134a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762303448; x=1762908248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcrLQiTzbg0Vl3V4jiTtouN0ZvPPzgeCA1Rl0FuV2jQ=;
        b=OKg+xjRuQyZ392j2FVbS9YK1HMA6L5ELEjaRdMqDeVfhyzZXnNRUCaFleG6twuiNpd
         9xy754VDWin1D26XW9jRn3aHtnGC8V4xcuplwGF6Yze4/y+o+9wTBjrBqBAxvm7eGtNu
         0zwEv4QRelhE4+6QBuQPh8DFZvx+N3jr2jyMxyOkEIEY7WV7vK5hHNBrSxeUFTdqXQ56
         GjQePlvEixwPtJtaRPzv38poV7yYiQvUUy5UeNi/8agf590a884kg63DEKA8dp/RuCfW
         GhN5kSVEsTqYaHH8aFHa2Z+uksmkU7iiWB+ldCXnNSpjSbUax2zJexdQJFCGwnrCCqVQ
         n8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303448; x=1762908248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcrLQiTzbg0Vl3V4jiTtouN0ZvPPzgeCA1Rl0FuV2jQ=;
        b=VOSQZqzwdJMCtHk0wftrcQl/3aZfhR1cJG49I97fzsRSoXIPuHAGYK/WEyZCj0IHX3
         04y2/WxxYdj7mxg5fe2w6gSrtxguy0fkY4mt/V8KN4WqXGsHI/XUyU8i75P+xoTGWuUb
         fDkmkJF41irw3GqleVcyciOrHO1+QPXCx+JXmrq3Qnp2y07aESG+AOCQ2WaXxvgSqJOS
         Km0D+M3B5Zt42WC26Q7zPXksopjteB6Drdg9Y8QJ1mtuRC/HdtplmjGaA3uqbxwZBZNx
         lTDvwBMxVlTlHJDvj86KoVNkOyXOoeXuKB/IOFrXMgQ6adP1uWJu1P+bdJ7RP9FOoFd8
         k4jg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Edi0Va0rqx2RNC1a9YYm5rHBzAZ+6Lg6N7cOHmdM7U/JrmAmX2Umxiz+pA2Qr8NOUcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOPRBbhh4SLeES6ytH8nhzB7BKOcEZ2/fuB273CpmBIoynJOM
	/zmI+J+hSJLWeLAA4aCtyWzJrHN5YfxprYhbJxiY24aZNnqEwGVlaV+oZt2zpm63oBSmkjEAr97
	8Lzcmn1a0DgV72+gTqYbKU4+UPAc63LQ=
X-Gm-Gg: ASbGncu7EfHmVEeKEGBLFlXhJu1w/+lBZTTxhn0uMFlb3zOqwbvci6u5HugBmGLOST8
	PfkF4SR+qrXjxbTrUD/M8Wbk8SPdEXzvy38Mhk/0TDhFxhEDUhtib/OncdmrqzXacBhfMVkV1/Y
	lvhhoyABxxpA8ArU+0UPqfTriPnIL8r8zrql4heMEoayznZIstXQkBVL6dVknXvoLfdSmqqpoYa
	oV0C3TgFHYviVp0AgCLPnsUc8MrtNiHvXiA3BUqbbyq/21H511Mp+AYa/rSH00VOxbLxZdlbMms
X-Google-Smtp-Source: AGHT+IHkZxVxX7oIveIHs/NfSMQ39Tv57f/wdO/a0GUAxsHa6iQBFubysjA6aME+9Xc2JurICrX4LNzU7K5i/9Ax/rI=
X-Received: by 2002:a17:90b:3501:b0:33b:bed8:891c with SMTP id
 98e67ed59e1d1-341a6dc8cd8mr1443523a91.23.1762303447568; Tue, 04 Nov 2025
 16:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-2-alan.maguire@oracle.com> <CAEf4BzZ-0POy7UyFbyN37Y6zx+_2Q0kKR3hrQffq+KW6MOkZ1w@mail.gmail.com>
 <f2e1fd61-7d3a-4aa6-9d36-a74987d040fe@oracle.com> <CAEf4Bza+zCKVHPHFDnNtKoYNGfeq+y7Oi96-+GGWOb8kop8tHA@mail.gmail.com>
 <3bcad9a2-5765-4db8-9488-f9cdaed7719a@oracle.com>
In-Reply-To: <3bcad9a2-5765-4db8-9488-f9cdaed7719a@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:43:53 -0800
X-Gm-Features: AWmQ_blK3Y94pMahCdx_1l-46de5yPDVC145UOpd87SM31p0ePiPy3tRzlAMKfI
Message-ID: <CAEf4BzaaJC4CvaxmBEAeb1wN9Y75cF13z2FEV4Mn6KWOqKWysg@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/15] bpf: Extend UAPI to support location information
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:17=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 20/10/2025 21:57, Andrii Nakryiko wrote:
> > On Fri, Oct 17, 2025 at 1:43=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> On 16/10/2025 19:36, Andrii Nakryiko wrote:
> >>> On Wed, Oct 8, 2025 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> >>>>
> >>>> Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
> >>>> to help represent location information for functions.
> >>>>
> >>>> BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
> >>>> location; either via a register, or register+offset or a
> >>>> constant value.
> >>>>
> >>>> BTF_KIND_LOC_PROTO represents location information about a location
> >>>> with multiple BTF_KIND_LOC_PARAMs.
> >>>>
> >>>> And finally BTF_KIND_LOCSEC is a set of location sites, each
> >>>> of which has
> >>>>
> >>>> - a name (function name)
> >>>> - a function prototype specifying which types are associated
> >>>>   with parameters
> >>>> - a location prototype specifying where to find those parameters
> >>>> - an address offset
> >>>>
> >>>> This can be used to represent
> >>>>
> >>>> - a fully-inlined function
> >>>> - a partially-inlined function where some _LOC_PROTOs represent
> >>>>   inlined sites as above and others have normal _FUNC representation=
s
> >>>> - a function with optimized parameters; again the FUNC_PROTO
> >>>>   represents the original function, with LOC info telling us
> >>>>   where to obtain each parameter (or 0 if the parameter is
> >>>>   unobtainable)
> >>>>
> >>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>> ---
> >>>>  include/linux/btf.h            |  29 +++++-
> >>>>  include/uapi/linux/btf.h       |  85 ++++++++++++++++-
> >>>>  kernel/bpf/btf.c               | 168 ++++++++++++++++++++++++++++++=
++-
> >>>>  tools/include/uapi/linux/btf.h |  85 ++++++++++++++++-
> >>>>  4 files changed, 359 insertions(+), 8 deletions(-)

[...]

> >>
> >>>
> >>>> +
> >>>> +/* helps libbpf know that location declarations are present; libbpf
> >>>> + * can then work around absence if this value is not set.
> >>>> + */
> >>>> +#define BTF_KIND_LOC_UAPI_DEFINED 1
> >>>> +
> >>>
> >>> you don't mention that in the commit, I'll have to figure this out
> >>> from subsequent patches, but it would be nice to give an overview of
> >>> the purpose of this in this patch
> >>>
> >>
> >> This is a bit ugly, but is intended to help deal with the situation -
> >> which happens a lot with distros where we might want to build libbpf
> >> without latest UAPI headers (some distros may not get new UAPI headers
> >> for a while). The libbpf patches check if the above is defined, and if
> >> not supply their own location-related definitions. If in turn libbpf
> >> needs to define them, it defines BTF_KIND_LOC_LIBBPF_DEFINED. Finally
> >> pahole - which needs to compile both with a checkpointed libbpf commit
> >> and a libbpf that may be older and not have location definitions -
> >> checks for either, and if not present does a similar set of declaratio=
ns
> >> to ensure compilation still succeeds. We use weak declarations of libb=
pf
> >> location-related functions locally to check if they are available at
> >> runtime; this dynamically determines if the inline feature is availabl=
e.
> >>
> >> Not pretty, but it will help avioid some of the issues we had with BTF
> >> enum64 and compilation.
> >
> > um... all this is completely unnecessary because libbpf is supplying
> > its own freshest UAPI headers it needs in Github mirror under
> > include/uapi/linux subdir. Distros should use those UAPI headers to
> > build libbpf from source.
> >
> > So the above BTF_KIND_LOC_UAPI_DEFINED hack is not necessary.
> >
>
> Ok sounds good, but we do still have a problem for pahole; it can be
> built against an external shared library (i.e. non-embedded) libbpf. It
> might make more sense for pahole to include uapi headers from the synced
> commit in case it is using non-embedded libbpf (in the non-embedded
> libbpf case we don't even pull the libbpf git submodule so might need a
> local copy).

In the years I've been around the BPF ecosystem, I haven't seen a
single case outside of systemd's super dynamic plugin-like setup where
libbpf as a shared library would make sense. I don't think we should
add random #defines in kernel UAPI just to make such self-imposed
painful setups easier. And yes, I know how distros love their shared
libraries... :)

>
> Thanks!
>
> Alan

