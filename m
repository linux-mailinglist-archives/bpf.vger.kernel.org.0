Return-Path: <bpf+bounces-66611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F11A1B37604
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 02:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51981BA0561
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 00:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6298821;
	Wed, 27 Aug 2025 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEUlw3Iy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43D801;
	Wed, 27 Aug 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253670; cv=none; b=HyENK/HY6MozyovZdtoSMjczkHunMXwLCo+VAmHPopf/HbwucYuxXdA30nNmL0XbcMdMZihIot/n8aMyBqMfe0586hPqAFq1dakLebV3qigH3pEnN2/nUr6yO6KH0Brsc0AGyqi6GzHvoaWsaOaGgnQyG9OWsYRQOnf8oNsyEpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253670; c=relaxed/simple;
	bh=VvK585F+Swuc/02QatmSZSNDAMcLA/B55yzGMGhBEb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+uLBaeQXHtZrCziw4otpMiX7klrkIUrKUCMdI6pVjF91hU9p8MgQAXYgmUJjM50fE2ErC0T76vN7VJMXGj6aJZc5NAcAkA1LvWMJZuJTggnNLPQi6iY9FqFOviEaDDwAU25wKiaS2i4sb1RGizi8kwHrtqlT1SVYAns3EiFGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEUlw3Iy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c79f0a5c5fso2603556f8f.1;
        Tue, 26 Aug 2025 17:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756253667; x=1756858467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvK585F+Swuc/02QatmSZSNDAMcLA/B55yzGMGhBEb4=;
        b=TEUlw3Iy+A8EALF21bfm39auwdYjEB+ImRgJyHmh4yLk9FQXSPDymfHYRZXMcrnEyU
         Irx6AsgqVbVPyHlJFXibGIN9udJzYdhJTzB6dzCrR6yb34iQDm1+2ud8I13vl/83279P
         y2Z8kR4sPJYILA4sVGce4IZsFQ6LWYphXwioDn7VjdsV8Ko9qglzDOk17pAlmNfqiJ/8
         g3qmM68Qfg2B39F+L1q0V6MoDRuM9rq83IvQhMAIvZInKgRgr1nus/5PzGUhKhDTDPjX
         jxRaJ5opK9AI5ipmdvNNAeWSVJyQmC9bWTbC+qSr4CwccgliV013RAC0l9p0/jCwpa8u
         BM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756253667; x=1756858467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvK585F+Swuc/02QatmSZSNDAMcLA/B55yzGMGhBEb4=;
        b=c63BoAk4PKVTLgcpQNVI2qpCqSM/yZQjAYi438BT/2PF2lBLpTuCzktSrxi0bpyF0j
         dSy/6onvvefw3ZglWtYog46mJ/91gLQfZEetXsSFuqm2umUZHmZMwxGGfoRIzVnYcGT8
         0lWaXicOdjGxje/RYES3A3pCMR7YS7/cSIXIco5xetfg0H+3RW7QoqvbYx3oK0a+sOU+
         d7UB7mLEBon82YwbknKKlrmzpoS51ZyQwsXw8yHllmtOOnJMPmJ9bRNTZhzORr+rGlN9
         DTeF0gf+p0SFl8XtGlBiWaGyo3NPJMFd6L4o0vPmbEkqlqm7cO5rC+wsrns6KYFEMCJZ
         2wPA==
X-Forwarded-Encrypted: i=1; AJvYcCWGntNtirD1yaHN6ShfvVQZBCbBYIKhojIKcGEZKZ7om4Y7M30A+Rfx4D9tQjYSxfQRds92NufwKg==@vger.kernel.org, AJvYcCXM1fZEYQQepQY9rnaQnCB3iGnzApcMufJCCn5dbX2Uw9w0oIkC6stbD/SQqPGTWbvGH90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJC+eZfMRGJdM7F1Nx9EEflof9pjTlzRSUpitd8VMliUfTtdFf
	GXNoHn7d+i9yQYS911OnQMTIEdgX9QwzaCejvQm34Y+ymbYjJt7HeR+HvhG6/+Nyk2ExMhAxpk/
	CGSbSDRR7cbWYOx1SwyJ69lqbgUUw9yA=
X-Gm-Gg: ASbGncu2jsqB2TFNgTK/efDnnuxI4Sqq8l8tuKjqub1lDb0LgTpsBefYI1rze4oipUk
	3bbuERuFm5yu1dN7IwnrlLGbECcdwS88YXg8kUA58M4tb9iYKgsA/UJg8Pg4zSMeX7DPvP7PxIl
	AWXPpoTcie2loXz71a7yQNXsbTU7lj5/+t3sI/qkEyZ+rE2Onf9A2k9dSretGAPAZguHfnxZhKo
	kGawyaYG0mr9EtUtwD7e1ltFNIwvd3WUuxbMOhF+34ylr6wkdegN2IA8g==
X-Google-Smtp-Source: AGHT+IHIt1MF+sPi5w5PzF3gz2j0/3rB6UOC0YpHCt1kNSwpDVRnkYSxvkKLVKEgRyK7sIxww5/smc1aEu+s4fwmE3s=
X-Received: by 2002:a05:6000:178d:b0:3b7:94a2:87e8 with SMTP id
 ffacd0b85a97d-3c5dae06602mr11417925f8f.18.1756253666884; Tue, 26 Aug 2025
 17:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807182538.136498-1-acme@kernel.org> <CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
 <b297444e23c42caeab254c90fa91f46f75212e29.camel@gmail.com>
 <8EEC78FB-CBFA-4DFD-827D-3D5E809ACA0F@gmail.com> <87zfbsici0.fsf@esperi.org.uk>
In-Reply-To: <87zfbsici0.fsf@esperi.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Aug 2025 17:14:15 -0700
X-Gm-Features: Ac12FXyyRmOp9PdbTDJh7Trg0qnnFpzrur1VUIWINyAS8L12E9Q0vedMqC86pJE
Message-ID: <CAADnVQKRuMzZWq5k3Z-QVCyLiR4Vin0zjPR36Om0fQbZ3RGYNg@mail.gmail.com>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
To: Nick Alcock <nick.alcock@oracle.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, 
	dwarves <dwarves@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:35=E2=80=AFPM Nick Alcock <nick.alcock@oracle.com=
> wrote:
>
> On 8 Aug 2025, Arnaldo Carvalho de Melo told this:
>
> > On August 8, 2025 3:28:13 PM GMT-03:00, Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> >>On Thu, 2025-08-07 at 19:09 -0700, Alexei Starovoitov wrote:
> >>
> >>> Before you jump into 1,2,3 let's discuss the end goal.
> >>> I think the assumption here is that this btf-for-each-.o approach
> >>> is supposed to speed up the build, right ?
>
> Generating BTF directly in the compiler certainly does, in situations
> where we can avoid DWARF. We reduce the amount of data written out by
> something like 11GiB (!) in my tests.
>
> >>I'd like to second Alexei's question.
> >>In the cover letter Arnaldo points out that un-deduplicated BTF
> >>amounts for 325Mb, while total DWARF size is 365Mb.
>
> That very much depends on the kernels you build. In my tests of
> enterprise kernels (including modules) with the GCC+btfarchive toolchain
> (not feeding it to pahole yet), I found total DWARF of 11.2GiB,
> undeduplicated BTF of 550MiB (counting raw .o compiler output alone),
> and a final dedupicated BTF size (including all modules) of about 38MiB
> (which I'm sure I can reduce).

11.2G doesn't match Arnaldo's 365Mb.
Frankly I've never seen such huge dwarf objects.
I'm guessing you're using some ultra verbose dwarf compilation
mode. If so, it's not a realistic comparison, since typical
kernel build is what Arnaldo reported.
That's what I observe as well.

> >>The size of DWARF sections in the final vmlinux is comparable to yours:=
 307Mb.
> >>The total size of the generated binaries is 905Mb.
> >>So, unless the above calculations are messed up, the total gain here is=
:
> >>- save ~500Mb generated during build
>
> For me, 11GiB :)
>
> >>- save some time on pahole not needing to parse/convert DWARF
>
> In my tests, a *lot*. I think Arnaldo has recently improved this, but
> back in April when I was comparing things, I had to kill pahole when it
> was dedupping an allmodconfig kernel-plus-modules because it ate more
> than 70GiB of RAM and was still chewing on all 20 cores of my machine
> after two hours. btfdedup (which uses the libctf deduplicator used by
> GNU ld), despite being single-threaded and doing things like ambiguous
> type detection as well, used 12GiB and took 19 minutes. (Multithreading
> it is in progress, too). allyesconfig is faster. Anything sane is faster
> yet. Enterprise kernels take about four minutes, which is not too
> different from pahole.
>
> I was shocked by this: I thought libctf would be slower than pahole, and
> instead it turned out to be faster, sometimes much faster. I suspect
> much of this frankly ridiculous difference was DWARF conversion, and so
> would be improved by doing it in parallel (as here), but... still. Not
> having to generate and consume all that DWARF is bound to help! It's
> like 95% less work...

Something doesn't add up here.
Everyone is using pahole and lots of people doing allmodconfig builds
with pahole. Noone reported that pahole consumes 70G and runs for hours.
Something is really not right in your setup.
I suspect the root cause is your 11G size of dwarf.
Pls use typical kernel build configs then we can have apple to apple
comparison and reason about libctf pros/cons.

