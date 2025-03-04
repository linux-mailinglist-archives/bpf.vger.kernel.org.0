Return-Path: <bpf+bounces-53173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31F9A4D6D3
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 09:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E822F188DB89
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671A71FC7C2;
	Tue,  4 Mar 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIDGOeLq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447011FBEB1;
	Tue,  4 Mar 2025 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077789; cv=none; b=rX8DGwKuE7qhVJLP0JWrNuqu408C+JugkihxNyouluUnkRQKXiJd3j9zD8T93oWrKpdwixhv2NtPHRYO7JTBEktDlO0dob+pXSzXgRqmojqaSuIbIXhSgR88I1HbJPuyIV8CL9Z47h9qCLeRedr+cUCeRXNvjs61u5UZJhwysZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077789; c=relaxed/simple;
	bh=dTtL6Jur3atffX/frcpKEb7wF2vN7b/LS2OXFn6lV18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXGmOE7nPabjxpT1Y/cLH9X/dS6RdOICbc9ZrNG3dzB+h7kE3uwn3Iv/XS30KiPQHfBzeyOcDVvz4cz1y54vUULtzS+ger8frHOwDW2fyRSmeDTiPXXER2BgxF/4oHF9yikWpLXQo6gUcvf+8GOdCEimi12Z2s1XEtqB9Ut/Zms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIDGOeLq; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6f7031ea11cso53378687b3.2;
        Tue, 04 Mar 2025 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741077786; x=1741682586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7DJBIx3iIusUVOEMB5nnJFYTmd3nur6e8lzlUxwqLk=;
        b=AIDGOeLqtovb2yr+ZgA+DOQLDoBpM+VLZLQ6LqQLe7ezhAUiIt/zM/qgq/qYacwoAp
         3Q8m8Hd3RboRGSrhWp5Ufsoci465g9q+/8E2trcnxrB/Ci9ZDAoITORfXJVTIhrtOvco
         Kia003XJ9G0Ok5Nmsc7q4ugPMFfbT9cPGRXmmvKr6YqFvpg1WIIQzRJ0EbTvpOA0ehOr
         4xXIo5CPzSshvoHiQ5gaj+5D/scYU7jNGESw+ovghUL+PC2etQ4yFaB4TeTVDKAfbHGq
         PubAT+Aprwx/B6J4lmT0JpPKwv+IkOzdxKbuEWUMsOmt8veB2ID7uQGfElkNhV2Q0xUM
         WA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077786; x=1741682586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7DJBIx3iIusUVOEMB5nnJFYTmd3nur6e8lzlUxwqLk=;
        b=n+U0UZ+EaIa8Sb27vgIcfGz7ReXhnBprW6X3ld2ZDVFpkBWWfOlSC41oiy0KE2y1Ae
         EGaF9KT6mk6gid/UPF1Gp2A4QZuYWN2kmKYsJxelCUTynJG+sZ/3ln3Sh2pu930eu6lz
         R/QWpDRRuhu/khajEtOTAXP3CjkIURGRg1lshCazzWJAFM/Hj9dKYv6QjDBJhNg4Vv81
         s3XJT6J7XxdNNx4lv6fTXsHKgwTwMQ5PG2l9nw3IlcFnzT5NXuY/IONlinOuh3X99jUp
         CQjeqQQij2hSBjVT51SsZKfBXwuMUZhi2CbM5o4IpZ/tIaCp58oKwBcxVJDkkKTMOSgS
         NJPA==
X-Forwarded-Encrypted: i=1; AJvYcCUEQVo23PidUQfh6JFWad3O8S4RzhMF/jlZcCJ/pUT+Y1Z7yx0GRiUP6kayTU3YeFa6Nh0=@vger.kernel.org, AJvYcCUmmj2VOOPZDRCVLXHgQq2oWipJ+Qcp4Wowv61q7Q94RV3E/wriIREPebbzx1W4lVZANgB1/y6HPuUTuuusI7NgYNVb@vger.kernel.org, AJvYcCWtbmerjTOG9ZlHCzx17spZfbkyFbnmeWDb10E963AlnC8/xaQlG94aWnbNxltv3c35c+5kZSDETyFLg/J5@vger.kernel.org, AJvYcCXfODhJq3pDxbor7egvnuhh7w81C/s4tSYweG0ffzqvWcqUPIcx4u+Z1BBZtV9PIB73BOgXg4CJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmefm+1N1fDeAWJhmlOETXER/fGGV6NporMvSKsWdlX80J8eeZ
	kaHc4dWpp4UmhKwWe1PGvXTto4IxifGJhpaHCDwsr77a9Ufgk2cxRxzfr55deMMRHGZQXREqvaj
	7QJYQLRvP7VpE8t4bkfk5RdpWhvc=
X-Gm-Gg: ASbGnctJeFSUghaZsn1bZ8wUQsn0YP60p91M0+a6EBKtu4qQR2S8jxY2Cq5p98q7Wgf
	3fuK4ydWBITqBG+xiCi+BC60JFgjZSzPdokyYDIps+u5kgnV90yPOdyKyB5jxNnOgNCHF1+PygX
	I16nNOly15Nb9uFvjGkgmLqm4s/A==
X-Google-Smtp-Source: AGHT+IFwKhleghfxmR4fo46mZcDQS529bArSvfkTfmrf2+HZom9bVtkcaUWWW29c+BaFyOYjznUloBGTXBdQLw3Z1i8=
X-Received: by 2002:a05:690c:6303:b0:6fd:3f88:e0a9 with SMTP id
 00721157ae682-6fd49e2a409mr227818067b3.0.1741077786117; Tue, 04 Mar 2025
 00:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
 <20250303132837.498938-2-dongml2@chinatelecom.cn> <20250303165454.GB11590@noisy.programming.kicks-ass.net>
 <CADxym3aVtKx_mh7aZyZfk27gEiA_TX6VSAvtK+YDNBtuk_HigA@mail.gmail.com>
 <20250304053853.GA7099@noisy.programming.kicks-ass.net> <20250304061635.GA29480@noisy.programming.kicks-ass.net>
 <CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com>
In-Reply-To: <CADxym3bS_6jpGC3vLAAyD20GsR+QZofQw0_GgKT8nN3c-HqG-g@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 4 Mar 2025 16:41:29 +0800
X-Gm-Features: AQ5f1Jq2_mS0v23bn6W1X-IWDb9MW8dDTnlwz6_dNKl9ybY4p55hAFXAjC92mhs
Message-ID: <CADxym3bS6XdGFhKeEm5TKD-_ubEQB+yTrd=7_L_CDn4xthe-Vg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] x86/ibt: factor out cfi and fineibt offset
To: Peter Zijlstra <peterz@infradead.org>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com, 
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

On Tue, Mar 4, 2025 at 3:47=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> On Tue, Mar 4, 2025 at 2:16=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Tue, Mar 04, 2025 at 06:38:53AM +0100, Peter Zijlstra wrote:
> > > On Tue, Mar 04, 2025 at 09:10:12AM +0800, Menglong Dong wrote:
> > > > Hello, sorry that I forgot to add something to the changelog. In fa=
ct,
> > > > I don't add extra 5-bytes anymore, which you can see in the 3rd pat=
ch.
> > > >
> > > > The thing is that we can't add extra 5-bytes if CFI is enabled. Wit=
hout
> > > > CFI, we can make the padding space any value, such as 5-bytes, and
> > > > the layout will be like this:
> > > >
> > > > __align:
> > > >   nop
> > > >   nop
> > > >   nop
> > > >   nop
> > > >   nop
> > > > foo: -- __align +5
> > > >
> > > > However, the CFI will always make the cfi insn 16-bytes aligned. Wh=
en
> > > > we set the FUNCTION_PADDING_BYTES to (11 + 5), the layout will be
> > > > like this:
> > > >
> > > > __cfi_foo:
> > > >   nop (11)
> > > >   mov $0x12345678, %reg
> > > >   nop (16)
> > > > foo:
> > > >
> > > > and the padding space is 32-bytes actually. So, we can just select
> > > > FUNCTION_ALIGNMENT_32B instead, which makes the padding
> > > > space 32-bytes too, and have the following layout:
> > > >
> > > > __cfi_foo:
> > > >   mov $0x12345678, %reg
> > > >   nop (27)
> > > > foo:
> > >
> > > *blink*, wtf is clang smoking.
> > >
> > > I mean, you're right, this is what it is doing, but that is somewhat
> > > unexpected. Let me go look at clang source, this is insane.
> >
> > Bah, this is because assemblers are stupid :/
> >
> > There is no way to tell them to have foo aligned such that there are at
> > least N bytes free before it.
> >
> > So what kCFI ends up having to do is align the __cfi symbol to the
> > function alignment, and then stuff enough nops in to make the real
> > symbol meet alignment.
> >
> > And the end result is utter insanity.
> >
> > I mean, look at this:
> >
> >       50:       2e e9 00 00 00 00       cs jmp 56 <__traceiter_initcall=
_level+0x46>     52: R_X86_64_PLT32      __x86_return_thunk-0x4
> >       56:       66 2e 0f 1f 84 00 00 00 00 00   cs nopw 0x0(%rax,%rax,1=
)
> >
> > 0000000000000060 <__cfi___probestub_initcall_level>:
> >       60:       90                      nop
> >       61:       90                      nop
> >       62:       90                      nop
> >       63:       90                      nop
> >       64:       90                      nop
> >       65:       90                      nop
> >       66:       90                      nop
> >       67:       90                      nop
> >       68:       90                      nop
> >       69:       90                      nop
> >       6a:       90                      nop
> >       6b:       b8 b1 fd 66 f9          mov    $0xf966fdb1,%eax
> >
> > 0000000000000070 <__probestub_initcall_level>:
> >       70:       2e e9 00 00 00 00       cs jmp 76 <__probestub_initcall=
_level+0x6>      72: R_X86_64_PLT32      __x86_return_thunk-0x4
> >
> >
> > That's 21 bytes wasted, for no reason other than that asm doesn't have =
a
> > directive to say: get me a place that is M before N alignment.
> >
> > Because ideally the whole above thing would look like:
> >
> >       50:       2e e9 00 00 00 00       cs jmp 56 <__traceiter_initcall=
_level+0x46>     52: R_X86_64_PLT32      __x86_return_thunk-0x4
> >       56:       66 2e 0f 1f 84          cs nopw (%rax,%rax,1)
> >
> > 000000000000005b <__cfi___probestub_initcall_level>:
> >       5b:       b8 b1 fd 66 f9          mov    $0xf966fdb1,%eax
> >
> > 0000000000000060 <__probestub_initcall_level>:
> >       60:       2e e9 00 00 00 00       cs jmp 76 <__probestub_initcall=
_level+0x6>      72: R_X86_64_PLT32      __x86_return_thunk-0x4
>
> Hi, peter. Thank you for the testing, which is quite helpful
> to understand the whole thing.
>
> I was surprised at this too. Without CALL_PADDING, the cfi is
> nop(11) + mov; with CALL_PADDING, the cfi is mov + nop(11),
> which is weird, as it seems that we can select CALL_PADDING if
> CFI_CLANG to make things consistent. And I  thought that it is
> designed to be this for some reasons :/
>
> Hmm......so what should we do now? Accept and bear it,
> or do something different?
>
> I'm good at clang, so the solution that I can think of is how to

*not good at*

> bear it :/
>
> According to my testing, the text size will increase:
>
> ~2.2% if we make FUNCTION_PADDING_BYTES 27 and select
> FUNCTION_ALIGNMENT_16B.
>
> ~3.5% if we make FUNCTION_PADDING_BYTES 27 and select
> FUNCTION_ALIGNMENT_32B.
>
> We don't have to select FUNCTION_ALIGNMENT_32B, so the
> worst case is to increase ~2.2%.
>
> What do you think?
>
> Thanks!
> Menglong Dong
>
> >
> >
> >

