Return-Path: <bpf+bounces-66297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A703B321FB
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09107AFA80
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448232BDC10;
	Fri, 22 Aug 2025 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKpBU1U6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356C214A78;
	Fri, 22 Aug 2025 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885975; cv=none; b=ivwwxCtPYeiOOBjSzOhYd3mvoy+t7fa9mfuDKuAYdzwVXxfAdGdLyVqmYb74tFELXYMfl8Kay/scNWZGMK8gY9fsX0lrYpB5l+gqlsOVB4DHPvZkYRqnuXE8zUIGF7twg+rx0OKDX2M1IVv/11kPtsp+B+oS0z05dskWhR5yZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885975; c=relaxed/simple;
	bh=UD+NDBzOOFKP0Ldz8mQ9Lp6ee4T6073Zsmxqgs2rCR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XS0Z/WTwWFEMlK+RYA8fGxRycVqN10T1gwwcN30x32LXzyGx4QbPMzJN6RRhL4RamJbaacYFXOye3XyLI94KQAD+Bp5holqg/05DAtYe4HZ2jLL0l5eciRinaXzRVk+vsMBsdVDJO6RRtf9PwYtXOytvB0s0jRPvVN06iVUdN2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKpBU1U6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so2658604a91.1;
        Fri, 22 Aug 2025 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755885974; x=1756490774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGbuZpjNy2mydNzS32UDYUsfLRx7izubX1ZCwH1grG8=;
        b=dKpBU1U622Z4jBQs8PDL66/f1mIw9vHUEh9bkEwJsrCbwMjz8B5NyjgvBvZwcgBvs1
         8CTI6TTvGhQ2a9EBObZITxhq7gxZ/7ljh5tJWZGdUelOQfM9wgPhvABQ8ImwEHYapAjN
         ikuXUoT3XV3ONKuSYsrGqW5RlaHPYsncdRmmOeqOU7GkZH0QdE//FPo+nKZeFZSff899
         cQkFACUsZrct5+oYnntI+MenHHD9Sr+P7a6zIkNvp4VAgVKEHvQjNRhLm/DqyHGixDCk
         Kv58V+8SUi3nVI6ezNF0tI9R7/AvOWflS1g+NjhvkEUxGj4un9VfKuPUqJSWD2Qux7GB
         FpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885974; x=1756490774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGbuZpjNy2mydNzS32UDYUsfLRx7izubX1ZCwH1grG8=;
        b=whyY4JNPmPJ86eAWSR/rmLCrjVKtGDq/xQ7WDnyVCflBYCCDGCrDIRsp4njDSRnfhC
         TEqCoCV1VydwvM6aIqRg6ehy1D+tbsuJzhOotzVMnA7SmoXBDt/Jf6KJErNWVzQf1X6d
         qEzEQo2OuAIBJP/Jt7XzL6ZQSsvZ1HkEFXQISWRYwitpgpIIiP0kaLTXP2hIeSg06M25
         ZOoAsmWqk+P22Im2jmDhkrptQGF+y1fg/lBpbMoVCdJRgSXWFP8NRo+x5CaNLzqOGNFm
         x6tnYYQ+5EGjw81cFhQFgFI0z2g2YEMUweRQhXcJVS4BiqHc/7vtmdW4BHMKHpmOmS+n
         RaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNpgjaWwaaUqzDCYozXvBpyyB9sDugkVi2Tm4AFE/AWng+j5Av8uXAmBfxsEkExlynFnPetE4pdi+1vtu5cbtxHoET@vger.kernel.org, AJvYcCXPpg0Wzsk2QVWJrE84czouiVuTSUcMZS9E+wvzuQ7hafSF3wZs0aV7zloKH8PF2YvL0R5uFP4FehdIj6z+@vger.kernel.org, AJvYcCXypcseFVP5uhDl9ze9Tkeua23vulLc6d5Ni58WcROAX/Q1ykaCWTzNoUHWV754wBdQFmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kx3mumUkYiRuDmihasqTvHUnU/UIV5JLZELgl2Smcv21ETqh
	Gq8KQkHzQC2VoBgfSGBWdARP/ku/2whZY7ICdGD/lluQmpPrUIECHqiavCPRMbBHUyShtZQaS0F
	o9dQU/DgfgKonnt4mNkWKZFpEb65u3DI=
X-Gm-Gg: ASbGnctpGNEluRu8WxeCPNqYOP+452D8eMIynuqxWaAvrTZoqUBRlEQFG4CfyeAQnXW
	LAZXc9L7fOW94qlyNqtzKzN9ENHw/fOIvW0J+0Q3R0OUFh1daPkHHbxXVhzpYAAnJlguQvbYe+M
	o+7qaVAnBxLuZur4lcyPuDti0awVdOyq3+qsgM8b58tf3T35ujsJl6Dfe+y/hGm4GH4chXR522g
	dnKV2TydyI5++WuOe0yxCI=
X-Google-Smtp-Source: AGHT+IEKP3ji+tVqY2bw0xHuOLuE8k4b1SlsawGnIcY6c1SzPnAnTKNsiwyGtUvIvwWQ4vZzU9e0f1w9UJc/bwM5peo=
X-Received: by 2002:a17:90b:4b4d:b0:31f:252:e765 with SMTP id
 98e67ed59e1d1-3251d492f0bmr4749271a91.6.1755885973496; Fri, 22 Aug 2025
 11:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821122822.671515652@infradead.org> <aKcqm023mYJ5Gv2l@krava> <aKgtaXHtQvJ0nm_b@krava>
In-Reply-To: <aKgtaXHtQvJ0nm_b@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 11:05:59 -0700
X-Gm-Features: Ac12FXxeC-KsZyreT3czhyiPwAUFcHkIFRPzz5QyW-vmpZTqIKYJ5J9cnPVS0S0
Message-ID: <CAEf4BzYg9jsEK1XdKW4dKFdOSrY4CAspaCAAv6ZJZScHxkHSyA@mail.gmail.com>
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, 
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, alx@kernel.org, 
	eyal.birger@gmail.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, songliubraving@fb.com, 
	yhs@fb.com, john.fastabend@gmail.com, haoluo@google.com, rostedt@goodmis.org, 
	alan.maguire@oracle.com, David.Laight@aculab.com, thomas@t-8ch.de, 
	mingo@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:42=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Aug 21, 2025 at 04:18:03PM +0200, Jiri Olsa wrote:
> > On Thu, Aug 21, 2025 at 02:28:22PM +0200, Peter Zijlstra wrote:
> > > Hi,
> > >
> > > These are cleanups and fixes that I applied on top of Jiri's patches:
> > >
> > >   https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@kernel.org
> > >
> > > The combined lot sits in:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf=
/core
> > >
> > > Jiri was going to send me some selftest updates that might mean rebas=
ing that
> > > tree, but we'll see. If this all works we'll land it in -tip.
> > >
> >
> > hi,
> > sent the selftest fix in here:
> >   https://lore.kernel.org/bpf/20250821141557.13233-1-jolsa@kernel.org/T=
/#u
>
> Andrii,
> do we want any special logistic for the bpf/selftest changes or it could
> go through the tip tree?

let's route selftest changes through tip together with the rest of
uprobe changes, it's unlikely to conflict

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> thanks,
> jirka

