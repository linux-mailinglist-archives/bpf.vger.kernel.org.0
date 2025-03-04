Return-Path: <bpf+bounces-53158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407AA4D1E9
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 04:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673B9188409D
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 03:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DDD1CEEBB;
	Tue,  4 Mar 2025 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8d4hQDi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F013792B;
	Tue,  4 Mar 2025 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741057714; cv=none; b=B+g72xpk2g3E76XBxI/gUuIZ0KTWW0RMVEtvuGNzBKUHkYyACmQApgwcP9OnPDRJl2NtDyoccZ2semlBZpxc1Hr5rLFg2YKuRrsLakW1/NlLS57Kmq9DVuMjFX7hepizKYfVhqr6wenHIc9AVXFxsY5kTuERR+JxQjkAzfPD6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741057714; c=relaxed/simple;
	bh=zd2kXp2LW9rFB0BwWOdHQwKVUln9e8unlctAyne2dUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGuR6jm3ocsXTyJi58xxSVkDKB1Ld2Y5glZDdhgGv4u3oK3SSF7QYSBa9qjrO//9NvzrdJXX1fPwr2R0XSoFHMUw3p37v6BEFgdD+tl7p6e0WwAsJJ/sjuhdvrI6F8X+9Szh7UtNF6L3T03bWRfbeSdsJGG3x1wJE5NhHNSrf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8d4hQDi; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6fd2587d059so31426207b3.3;
        Mon, 03 Mar 2025 19:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741057711; x=1741662511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJdTuc12hE8xNboldJDtY0tNQVyNe2iG7pRWAnla1E8=;
        b=N8d4hQDi5m5CspWv5kmBWUdEx5Ys0U1utbMH6QixtMF91nRIxLqIuoYfnBgPUe8uqI
         7kJ6+XVVCd7Zm1l/Bcx8vfgRVZ4XzPragdTP4sqMff2h56DfUrhj34pvLfYtQxdrfwyR
         gNOBu26FcL6rbrZc099Onkrzz7lO+ASm31U+VTEttLcF+lxoxmdJlKx3oS4snth89naO
         wbaEmjA89QffnoIzwg9eQDh6Di2+bjAZh6B9giilt5sJpH9FODFNi+xJCQ//oQJ5vCu4
         2Sbeyh4RBlyK/AglK4vFv+3EfMFs7hcvBzWeGCCaRTRU3D/2CWEdWh57cxYzXWTct892
         9AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741057711; x=1741662511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJdTuc12hE8xNboldJDtY0tNQVyNe2iG7pRWAnla1E8=;
        b=af7lo7If/DiFrz59f6SuHbzAoD2KAKfo92E8HC54Gw/BvhKxZMUKVjkqxQ4gm8zLCf
         zGdxvVCNTWpytpUxEM9vWcZxdUMpIhRJ76RzsbAQAzeCIRYpyESdebo9WCQ7SF2VvJfK
         QW1AHsmPeFeRdt8RbhlK7HWT6ztPVm+9ptXfJQNPpTLnWqZQUjW81XEKBJXRj8mgybW/
         h7KGU1J02yMGJiabLDEx0p/YE8dcAiSe2EfQQlJAlON0bTPXN3+33/v8bA7pzVNHDnnH
         uHz1BsbJLLoVBf09gbJ10G0QjaN4jg46N3TPwKkY/7irgwn+Ms91LUuMJeicCpJ4O8vH
         L+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpi+Fp8/vSw2K3af+qWf+td42aZux6h4PnNXXPPJV3RsnGL+VjXO993RC/xsG5F/Y3+YRu5LEygUYsc+fa@vger.kernel.org, AJvYcCWaIwWzC30o3byCbLOzALLQuH+9HlrfeMfMT69ZjPELTA+/dnOyqVocIjTWzyqC/FUghw+eBP51@vger.kernel.org, AJvYcCX1gfFzUvvc9RM5ScMv21VjJ9TRMlZF0QiVWckbxbcQVo9zRd1PEHCeSAspoNM8ZB6To1s=@vger.kernel.org, AJvYcCXNA/UEstwg7qRetXLK9dl4zbomJjC610e3zdIMCsssjj3m6eUksjYtPj2/T1WUHiphq3EvdeDf9hmp22n0gPeCkWiK@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjw00bNAii2sd1ThLraJOg81y7QfWmEJwO4OaK2/VuE22svmY
	GzKLKux6VWuEXLQrd9GOlEVK1ikkOopUbR9GJHmrxcPo9YRfa4kkBQyueALNeMNoSvOwjYt2+oC
	0GtYw+7qA39eTp5JX5LDyjQQDkB0=
X-Gm-Gg: ASbGncsAReIxP2ZaWslADapeEpdHls8AhY/LD0IWmpMxXPs+bD6pqf83vz2zSY9k7mA
	J36w7ZbIeXwoY7Rjt8cHDJsHPbaWJG0WZG8zuk46WCvLywCBuyKrPOprSwqTfuTPSTlULE0Ag3r
	nnvsAhUaUOlskoz64EtJz0h2lFDQ==
X-Google-Smtp-Source: AGHT+IGjpE37/D8VFUXwtx1+vTlIBKGMhPsHyscBlEpff0BYVERCrQfJXRrs4afpX4s/+1NgBA8mJU+Be8nzIuYC69Q=
X-Received: by 2002:a05:690c:3708:b0:6f9:447d:d1a2 with SMTP id
 00721157ae682-6fd4a1b56d0mr207861007b3.29.1741057711592; Mon, 03 Mar 2025
 19:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303065345.229298-1-dongml2@chinatelecom.cn>
 <20250303065345.229298-4-dongml2@chinatelecom.cn> <20250303110559.5a584602@gandalf.local.home>
 <CADxym3ZJf3TEMwCy4JVT1gs9GP=U1n1qss3ycnuMZVyp9TfDdw@mail.gmail.com>
In-Reply-To: <CADxym3ZJf3TEMwCy4JVT1gs9GP=U1n1qss3ycnuMZVyp9TfDdw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 4 Mar 2025 11:06:55 +0800
X-Gm-Features: AQ5f1JrQ2Vfag3gyvkNKHuCTcxmUnHFiO3c2filqEDv803CK-Q1LsulYa_DCrkw
Message-ID: <CADxym3bNxGb-FPtkbjiLfEXBRnVT7HBM8nbQBWvcHoLhYrKKgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] x86: implement per-function metadata
 storage for x86
To: Steven Rostedt <rostedt@goodmis.org>
Cc: peterz@infradead.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, samitolvanen@google.com, 
	kees@kernel.org, dongml2@chinatelecom.cn, akpm@linux-foundation.org, 
	riel@surriel.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:07=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Tue, Mar 4, 2025 at 12:05=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Mon,  3 Mar 2025 14:53:44 +0800
> > Menglong Dong <menglong8.dong@gmail.com> wrote:
> >
> > > In the third case, we make the kernel function 32 bytes aligned, and =
there
> > > will be 32 bytes padding before the functions. According to my testin=
g,
> > > the text size didn't increase on this case, which is weird.
> > >
> > > With 16-bytes padding:
> > >
> > > -rwxr-xr-x 1 401190688  x86-dev/vmlinux*
> > > -rw-r--r-- 1    251068  x86-dev/vmlinux.a
> > > -rw-r--r-- 1 851892992  x86-dev/vmlinux.o
> > > -rw-r--r-- 1  12395008  x86-dev/arch/x86/boot/bzImage
> > >
> > > With 32-bytes padding:
> > >
> > > -rwxr-xr-x 1 401318128 x86-dev/vmlinux*
> > > -rw-r--r-- 1    251154 x86-dev/vmlinux.a
> > > -rw-r--r-- 1 853636704 x86-dev/vmlinux.o
> > > -rw-r--r-- 1  12509696 x86-dev/arch/x86/boot/bzImage
> >
> > Use the "size" command to see the differences in sizes and not the file=
 size.
> >
> > $ size vmlinux
> >    text    data     bss     dec     hex filename
> > 36892658        9798658 16982016        63673332        3cb93f4 vmlinux
>
> Great! It seems that the way I tested has something wrong. I'll
> compare the text size with "size" command later.

With the size command, the text size with 32-bytes padding is:

  text    data     bss     dec     hex filename
48299471        14776173        18345936        81421580
4da650c x86-dev/vmlinux

And with 16-bytes padding is:

  text    data     bss     dec     hex filename
46620640        14772017        18458396        79851053
4c26e2d x86-dev/vmlinux

It increases about 3%, which I think is acceptable in this case.

I'll post the message in the commit log of the next version.

Thanks!
Menglong Dong

>
> Thanks!
> Menglong Dong
>
> >
> > -- Steve

