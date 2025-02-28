Return-Path: <bpf+bounces-52865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5194A49601
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 10:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A58F1622FA
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBE3257ACF;
	Fri, 28 Feb 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKP/S0eV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDED257AEC;
	Fri, 28 Feb 2025 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736481; cv=none; b=AXImvSTdlrVS5N9VCIO7V4P2FrUdgU1XY1Eesz5d0IR8nFzKymnz6V3uWskYSvyJKv9K7olm2hn4fVYczloVu7fN629s4WHRLLguMXSxQJRr65qgTTBszBN9KZ5V9/zPddyEeMAFf3yztbpBdm3fW7NxB5m/tUnvSC4vil0y21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736481; c=relaxed/simple;
	bh=WvLB4o8VqDbo0+yJXvdU93jyLfr8Tjsy9TVWiXEmjx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9H7ISHrPtHxFrKWu7wDwZJI+cLaph0op+jeLU1XEhRzwf3UiWqI4oYZNC6vIORE7lR5RxoE7cA+LZY601Lo7nlz+/A6VwyaQv6M5C0KIsB2+VfdnUITz/yzjOw5Fc+bX7tPyELc4NicrGJrg10Wfdw+kpSvSIz17KdTZS5gimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKP/S0eV; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6fb95249855so16416407b3.2;
        Fri, 28 Feb 2025 01:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740736479; x=1741341279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnSNXJUHBXvGzpVRG5KhgAWl885WHp27TpnkoxblTDE=;
        b=hKP/S0eVYnzR9+c//2DFK93LsJ5Qp2xD9Pn/k9hp6v9ALRy8kJHdZZY+7p5MHvRbAz
         AlQkV+np7kL6EglhrDTG7bgbNwzs6rJUxY1Yz8VtF8M6ASUdKt6mVCqZN09JidBGYEJ7
         IrpD+IzE8XhMiBi6VkpBBXPgK/LoX1hQP1rf+Ex5npY3MJ201VIE6ah7dGFUsNrefLCI
         BWNe8b0a3KRqjgYqm26FqKonzghCSc4/an8yTg/7Yt5KrtShOlplLOpW04xtflq+NWHf
         Ya+JsjyxzAsN4+4C6OZC3hmQdWr/rPfFlUK3hQvR4yxwX2JGDDw4NgA2jL7v+ch6Qwlc
         Y9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740736479; x=1741341279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnSNXJUHBXvGzpVRG5KhgAWl885WHp27TpnkoxblTDE=;
        b=eI4wRN14sDjKer/sswMsmY+uzSPEkUe7P2VzHlPymtGKLI+IyrqdQdQGtSimfn8qvw
         5ziLaEDrhJ9YDdCZp571NFeiAx57ysdtPWrNbdrmlnBrlV3pxsb2cZwXoyTp/FV/hd1w
         DazMfkmHuNGFboEbuZqr+NXkIQcs3qs4WEOW8iseNb0KTCEdJCbSt4n4ANW9tWFHKJNn
         j+Xavo8FC85CUf1toURwhHI2tT6B6TDq4h0xZC5t7vEvzlic/A9DRmBzd6QZ60erQBMQ
         vC4gVdM8dciG9qiHhinLBoi2Q2ssbee4ZSkeVUIRjqw1jpSSCq1/svXCVtFjMTjuuwnT
         OcXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgzC/CvMBtUDFmJQu+n9ks24/wZgufLT0FpxabZZgAONmoRcDdsNJN5WokTRH91nUu6aa42t/PBFKJiwR5@vger.kernel.org, AJvYcCWtG3bPGAoS1iw+lGNQBX9DIkAIMAqcRQ2GXXhvjOTtYB5Ru0J2WjBV6a8u0dejKk8GNLA=@vger.kernel.org, AJvYcCX3e0lqgaQL/i4k/USNJu014c4PveiixldD8ZwkXSNXrx8/KfLHCGVBjS6+QoHsG7yDZiCKQY6zJsOK95G9Kk8Hi8Pz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrcn1qsBEoaamDo74L1zSU7FvFfmlB/k3bIVv3tr8PQwRSkFug
	KVsoO+yxEnEvexeP4dGqsBVOUE/bJMlzqhhuiKX4wdNyvTFnJYiAdHFVv/yzVMOSUpawUhrQqw1
	dPFyCv73Cks6eLJ9RXMKT39PXhkw=
X-Gm-Gg: ASbGncv4OpSeFqsT1E01hVaIlr3MkgwBRTz8sUW+lDERj5gymabDovmUtDA541t8Az8
	/Eo+szb/zFTIVrRiKMVD01tZ1wej79p1u+e1oNsFOh01R+C0LuXPPznMyo4za28XRbAXlwUXM0a
	IBITBtfpc=
X-Google-Smtp-Source: AGHT+IGw8NvEA4HXOWd3rIajp2/eYgmEUIZNbIrBrY8Iu6/IP8jSbJYy+8uslfAXjg82JCBbu4fs1sAGNeU5oaGcBbE=
X-Received: by 2002:a05:690c:6004:b0:6fd:2ed4:14a3 with SMTP id
 00721157ae682-6fd4a12a14cmr33364597b3.28.1740736479127; Fri, 28 Feb 2025
 01:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226121537.752241-1-dongml2@chinatelecom.cn> <20250227165302.GB5880@noisy.programming.kicks-ass.net>
In-Reply-To: <20250227165302.GB5880@noisy.programming.kicks-ass.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 28 Feb 2025 17:53:07 +0800
X-Gm-Features: AQ5f1JoWhySTPkmaj1qPnc-nYUSHeu6CY0uMl7WEtgQouXZ_IyO9LsWxEjtp3pQ
Message-ID: <CADxym3YCZ5dqXMFesNaAF_Z2EWWCj0bJyKQ+BnNw2c=g39CRFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] add function metadata support
To: Peter Zijlstra <peterz@infradead.org>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	mathieu.desnoyers@efficios.com, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, dongml2@chinatelecom.cn, 
	akpm@linux-foundation.org, rppt@kernel.org, graf@amazon.com, 
	dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:53=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, Feb 26, 2025 at 08:15:37PM +0800, Menglong Dong wrote:
>
> > In x86, we need 5-bytes to prepend a "mov %eax xxx" insn, which can hol=
d
> > a 4-bytes index. So we have following logic:
> >
> > 1. use the head 5-bytes if CFI_CLANG is not enabled
> > 2. use the tail 5-bytes if MITIGATION_CALL_DEPTH_TRACKING is not enable=
d
> > 3. compile the kernel with extra 5-bytes padding if
> >    MITIGATION_CALL_DEPTH_TRACKING and CFI_CLANG are both enabled.
>
> 3) would result in 16+5 bytes padding, what does that do for alignment?

Hi Peter, thank you for your reply~

Yeah, it will make the function not 16 byte aligned, and this is
the most pointer that I hesitate in.

In this link, I tested the performance with 16+5 bytes padding,
and it seems that the performance is not impacted:

https://lore.kernel.org/bpf/CADxym3af+CU5Mx8myB8UowdXSc3wJOqWyH4oyq+eXKahXB=
TXyg@mail.gmail.com/

However, it may have other effects if the function is unaligned.
I don't know either. :/

Do you have any advice here? Such as, we'd better make the
padding 32 bytes instead in case 3 :/

>
> Functions should be 16 byte aligned.
>
> Also, did you make sure all the code in arch/x86/kernel/alternative.c
> still works? Because adding extra padding in the CFI_CLANG case moves
> where the CFI bytes are emitted and all the CFI rewriting code goes
> sideways.

I tested it a little by enabling CFI_CLANG and the extra 5-bytes
padding. It works fine, as mostly CFI_CLANG use
CONFIG_FUNCTION_PADDING_BYTES to find the tags. I'll
do more testing on CFI_CLANG to make sure everything goes
well.

Thanks!
Menglong Dong

>

