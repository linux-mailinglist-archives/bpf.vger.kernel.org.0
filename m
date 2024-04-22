Return-Path: <bpf+bounces-27457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A872F8AD463
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1241C21135
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F7156241;
	Mon, 22 Apr 2024 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb64hmta"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C91474D3
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811792; cv=none; b=YGpYiwZZNVxarMd8pULbD0Zdc1DccLxf5zlwS2wAObSo5DGiDDkow7ir6g6HU6Q72he7kbVaru2+DfXu5bbtE+wfyA+zIANHIaqQHVzJKrWDXjpJuYs2jZP92m3i8/6TQLRdr4SRrW/V2NO/EjZEobJPOLy3hURQ0muSdSC96wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811792; c=relaxed/simple;
	bh=su6EuNzqHh7/H9omvrTSC6HD5fEKMCABV8DyYcRflj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gW+MpXz8OvJyi3Rf2n4yV9HGpzxHaA+vBVEwqUUEXY9wBbCqWA/kenn3xS3XfS7dZXUAURThDIGZjVL32Z6279hsbcOhfGCco/iqb3SH28Zdu8Fo4TF5ckbcvFCLSb90wlRm8AK9zYPCzwj3gFNOfg9doscYMvCU7uT0Ggj9xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb64hmta; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-347c197a464so3569944f8f.2
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713811789; x=1714416589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiRNn7upgUuaQsU1pt0QfK+J1fpewc+eaCfhpu3qwxQ=;
        b=Hb64hmtam9Tzdk/8XePgd2WxNqP94lrAQQtj46BqOKqMfEGYhsDXKCtqReLysXYsSE
         b4h+eqP7MKzzL4OiZPp8+0Tb4vJsVRRTHoR65cFGBByDYfPOKwXMzqPBl0yIWc6taAJV
         ui/rYjOBmGSlCDSfgULPsSgt4EBOLSVNW9BXGMWnl/UqcYhBRo4aGoVsgu9ROepgrnlw
         HfCkILgfVhOO7Z1xp9GknkpGrnLOeA1sIM2RztuzGljn4wK1k7V22QkF5iHTO2JiRM1B
         Vgg4vQ7wVnwmocux6T0qP/u57HoAc7I+ulGfxQtPlcXy1LnA/xKoW4PTqBSKgDVaFKZ+
         0rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713811789; x=1714416589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiRNn7upgUuaQsU1pt0QfK+J1fpewc+eaCfhpu3qwxQ=;
        b=LhXDXmRMTt8fc5GyGNPzqUN0QMMANpO0mJyLGkCePL/0fDA9uljMGV7wMpfSjPrUAa
         P6IPSjCiufOBsMx9UDWabIa/t8i7Uu8MbC/de2EnVD87p7PYsb6dE5VVdGpi9ewxaJQr
         Kbq2mmgr1IqU8RXp24EHTKBA/mtdWJb1WSMWcpRgpuyAlMLHxiUN/4QlFEpD7LiyaaIx
         VJtezurWKjVVWvmOKOrIAuo7O6sSM72/F0B3YEFyOjNB++Qs9Nyt68UvxgoDnODBMkV/
         pB8GtKiuP1U7q7RwhJwKNQcSYYYXv2y3jFwropeNxYrf7oLdrHgFy1YSnj6RYLubEBM8
         y/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5VkhEPS6PdOvV9nao387mWswZHcaT5u4u92XYFqNiIOihr8BNBEA462hjQVD18kR19SJQRvrEKudOpEbhG+VWzOqz
X-Gm-Message-State: AOJu0Yz93fArAIfmamhbuAp5dg5c25YGnB1jBYmvTqkNWAloGOS8BsE2
	HRPU0nTPouUV+PHP7pwl00vXb6obM1r1HPfZVVF3S1eNlglevn8y0HI5gxrPVCFNZGi6CM5KqCN
	+5bKnnZEWtFnTQAr6CqsWmPwnq5o=
X-Google-Smtp-Source: AGHT+IGTvAfNLSVHGpQ5tStl2kARL1suXWhd5DzQJ3IOVDwg2mmVui3cBUl0Kba3l+dw6zo4NFMCiuvFW0Il0am9ER0=
X-Received: by 2002:adf:e743:0:b0:346:afab:9702 with SMTP id
 c3-20020adfe743000000b00346afab9702mr7158667wrn.13.1713811789113; Mon, 22 Apr
 2024 11:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <093301da933d$0d478510$27d68f30$@gmail.com> <20240421165134.GA9215@maniforge>
 <109c01da9410$331ae880$9950b980$@gmail.com> <149401da94e4$2da0acd0$88e20670$@gmail.com>
In-Reply-To: <149401da94e4$2da0acd0$88e20670$@gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Mon, 22 Apr 2024 11:49:37 -0700
Message-ID: <CACsn0c=H7e_G_X=L4i5mnNpZJPB4U4wZCYkg9N0qrypQUzKmPw@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA Security Considerations section
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: dthaler1968@googlemail.com, David Vernet <void@manifault.com>, bpf@ietf.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:38=E2=80=AFAM
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
> David Vernet <void@manifault.com> wrote:
> > > Thanks for writing this up. Overall it looks great, just had one
> > > comment
> > below.
> > >
> > > > > Security Considerations
> > > > >
> > > > > BPF programs could use BPF instructions to do malicious things
> > > > > with memory, CPU, networking, or other system resources. This is
> > > > > not fundamentally different  from any other type of software that
> > > > > may run on a device. Execution environments should be carefully
> > > > > designed to only run BPF programs that are trusted or verified,
> > > > > and sandboxing and privilege level separation are key strategies
> > > > > for limiting security and abuse impact. For example, BPF verifier=
s
> > > > > are well-known and widely deployed and are responsible for
> > > > > ensuring that BPF programs will terminate within a reasonable
> > > > > time, only interact with memory in safe ways, and adhere to
> > > > > platform-specified API contracts. The details are out of scope of
> > > > > this document (but see [LINUX] and [PREVAIL]), but this level of
> > > > > verification can often provide a stronger level of security
> > > > > assurance than for other software and operating system code.
> > > > >
> > > > > Executing programs using the BPF instruction set also requires
> > > > > either an interpreter or a JIT compiler to translate them to
> > > > > hardware processor native instructions. In general, interpreters
> > > > > are considered a source of insecurity (e.g., gadgets susceptible
> > > > > to side-channel attacks due to speculative execution) and are not
> > > > > recommended.
> > >
> > > Do we need to say that it's not recommended to use JIT engines? Given
> > > that
> > this is
> > > explaining how BPF programs are executed, to me it reads a bit as
> > > saying,
> > "It's not
> > > recommended to use BPF." Is it not sufficient to just explain the ris=
ks?
> >
> > It says it's not recommended to use interpreters.
> > I couldn't tell if your comment was a typo, did you mean interpreters o=
r
> JIT
> > engines?
> > It should read as saying it's recommended to use a JIT engine rather th=
an
> an
> > interpreter.
> >
> > Do you have a suggested alternate wording?
>
> How about:
>
> OLD: In general, interpreters are considered a
> OLD: source of insecurity (e.g., gadgets susceptible to side-channel atta=
cks
> due to speculative execution)
> OLD: and are not recommended.
>
> NEW: In general, interpreters are considered a
> NEW: source of insecurity (e.g., gadgets susceptible to side-channel atta=
cks
> due to speculative execution)
> NEW: so use of a JIT compiler is recommended instead.

I am very confused about the substance of this recommendation. I've
also got other comments, but will put those in separate reply.

Simply put JITs aren't magic. Whether a bounds check is put in by a
compiler or an interpreter executes it directly, it can still be
speculatively bypassed. If anything JITs may simplify the matter
compared to interpreters as the execution path maps more closely to
the BPF executed, and the BPF will have tighter control of paths and
layout if e.g. it is injecting branches to fool the CPU later. There's
a wide range of execution technologies that go under the name JIT and
interpreter, from threaded code to complete compilation to trace based
compilation with bailouts to even more complex schemes. All of them
have Specter issues.

Sincerely,
Watson Ladd

>
> Dave
>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf



--=20
Astra mortemque praestare gradatim

