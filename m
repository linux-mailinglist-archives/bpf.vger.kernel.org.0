Return-Path: <bpf+bounces-77002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5452CCCFF6
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A883B301A1BF
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E1313E2D;
	Thu, 18 Dec 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeAVe+HR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D82FCBE5
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079647; cv=none; b=FhBD2P/sScUGIN3llS0vQ+pypeZkiYtd/Ts+03PXGOK4h5y7dXrj3fsurdanMa2+wmZQXgOKWFc4PLze1gS7II0a/zpMrIz68455DgnG7zDUw2oFgzKhsHDBgnYRGVMA89ZCbcXXEyFumYvHJnmn6YlSj2xbug9+Hf+mY5P68QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079647; c=relaxed/simple;
	bh=76DOHh5woYV0UnKHUm9yPfjZMy2N+QEGCZd9dXKIa04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK4lQ/bcJieMElQbTP3ItcJ0CrbZSrKlEphlRzr2SXZBqCY1OaE8fWVZZS5wEF8aDHp3g2VLXEQMFCF/b/hUWDwfnFG4Z7HLvemIJz1YUzF12WNz0UDXfIMokJOF/9nXTp4CQW++iFMk+JnVaZjdMPVZK5Z06cs25Enx9VIPggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeAVe+HR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34abc7da414so847924a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766079645; x=1766684445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jrjlt/iGNNCo/YYSDSZW1rUpJUDWoV/i2JFPWjGwsI=;
        b=FeAVe+HRnjhoTJZfmiByN9pTRoQYCBfz1/sD+EBDZV55+93J8JRYnnY53l0Adr+Sco
         BA5jvhswgWnCXVkSFCyTPLvnOa6QKiAmF9Q8vXLXhnA1TGWCfSPlnlya3S8J1PK6hNs6
         k7DI8Mu9LVJ13186oY8MjCwn5lRYdpw2Xs3JXQ9dbrEhTomfAO3vwq92sQ5NAq8DRPHW
         4iTPCeFqUm6KGUWt53Fos78ydtWCt/afwcaHGdk/KUqW0P5sbcMkAuMGihA8P07TsHSI
         qkW1NpI3dKJUB6BVZNio/oRivHwfnqKCNx22zF+SKlwvMx2leQV8BGbRj1jBS0ZntXAU
         85tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766079645; x=1766684445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jrjlt/iGNNCo/YYSDSZW1rUpJUDWoV/i2JFPWjGwsI=;
        b=GIcXmJ2GJk0qLzkWz8yaqRpiIwFMsH3XezhAU5FfIqhgRxy8e6XGQvpclg1DVxx+aZ
         iAijGdRLAyNp2B+gBx/Y0J7T6CMvtzia5lS/FXa+U8j6TfC+50P7M82apjIUMgSRuhXD
         roRcX5FnspMTJfOtkhkGB9IcIWD8izV8rXNalsqqtn4wut1U68iKUUJomX1Gz2K9ouXR
         gRwWaL33xKHca1GS8S5RfNigCtC1E99tV1sJ5lAHXEtCawOr3Ej8Ryko9vSHv9HOfpBA
         cmA8HRjHuFNdxCZrfQQjf1KfuJVNSgA90bV3yE+a7Ctmbh+8W2Vzq1IiSLRx9b/SGnZV
         g95g==
X-Forwarded-Encrypted: i=1; AJvYcCVS5VRaGyVmAlGAn4wq78PuW1g6mqGOLFguxs/lC0ZQ4Hrl3oqzO/edOX2RBUaNXTxCNWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WUZgaXvyv4ka/glZhHEOiMPuQ8SnCMV2StyL7o737RyLLxJX
	GCtH9Wv/6lpZEx/cIfoahbJo6ESQdX2V21VUxnHX0jcJx3YoX55QmOWn5o9G0fgroUf6qKHvnwt
	Qf5S/du5Bf3e9Bs0NZANsEpZkE4S8jKE=
X-Gm-Gg: AY/fxX4bvkb4NxMDeYAa/BGO2Kmb9/Z7b/uU/pRGDYaltGeZ3sw5QLfYhjAGM1jER8i
	v892qVgnL0W1OL2DXid3J3hzgFwRorP8cIQzs80mvQrGJKs6mqjBpBbasiE+tXW0pBF/iW16LwJ
	/EXZ7EsYysN3fZqDwaXQeBOZn7Z1uooML2QuvMZRhCgfzAq8BoUSkKAOANMVmKJjiSDfF2k7WuS
	UcAhbDGifwgrSoiCTvd/wv4zq+IQ/tNYMfjlW5KqxDLCv5Si5tu6tk3w/madD9enTVneQhPyUlM
	nR+Lnr+rJhz2qNyNCFyRLbbMhyg5vTVaJDUZpdqCApYucNjM8JY=
X-Google-Smtp-Source: AGHT+IGZxOrOa47brG46M0MtYHWndTn0lfrZidL7/W2PPWvA8LJSTJwrhVcEshiQ32enfNYo3kSQ53r5ZD4xODqn4pc=
X-Received: by 2002:a17:90b:2f47:b0:34c:3501:d118 with SMTP id
 98e67ed59e1d1-34e9211d455mr145781a91.1.1766079644838; Thu, 18 Dec 2025
 09:40:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHtS32-Zh3knxSdR=DUqQH4rX4QU8ewgu+KHGq6Af3qs9S0FAg@mail.gmail.com>
 <87v7i4hpi4.fsf@microsoft.com> <CAHtS329aD5DyYSUkcuZXXjZKywqqTHe_1pA6uyaQH=Zwi9kydw@mail.gmail.com>
In-Reply-To: <CAHtS329aD5DyYSUkcuZXXjZKywqqTHe_1pA6uyaQH=Zwi9kydw@mail.gmail.com>
From: ryan foster <foster.ryan.r@gmail.com>
Date: Thu, 18 Dec 2025 09:40:32 -0800
X-Gm-Features: AQt7F2pWi3NWvO0tQV8cjd-0T99ySge_U9MedSd_1j4tPvIggUAVTRhDTP69saE
Message-ID: <CAHtS32_TPrURNQkn+a1RrJRhUm7sPBWz37CPX81sG-LnYGuh5Q@mail.gmail.com>
Subject: Re: [RFC 00/11] Reintroduce Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James.Bottomley@hansenpartnership.com, akpm@linux-foundation.org, 
	bpf@vger.kernel.org, corbet@lwn.net, dhowells@redhat.com, gnoack@google.com, 
	jmorris@namei.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux@treblig.org, mic@digikod.net, 
	paul@paul-moore.com, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul, Blaise,

Thanks for clarifying, that matches my understanding.

My read is Hornet's semantic goal is load-time provenance and
integrity: validate the user-generated inputs once the kernel has
constructed the final in-kernel program instance (post-relocation,
with any integrity-relevant referenced inputs accounted for), and
record that result so LSM/policy can make decisions based on a fact
the kernel can truthfully assert.

Attaching and linking are separate runtime policy/capability
questions. It makes sense that SELinux, IPE, or a BPF LSM program
could choose to gate attach/link based on whether Hornet recorded the
program as verified, but that enforcement is orthogonal to Hornet's
core integrity/provenance objective.

Thanks


On Thu, Dec 18, 2025 at 9:39=E2=80=AFAM ryan foster <foster.ryan.r@gmail.co=
m> wrote:
>
> Hi Paul, Blaise,
>
> Thanks for clarifying, that matches my understanding.
>
> My read is Hornet's semantic goal is load-time provenance and integrity: =
validate the user-generated inputs once the kernel has constructed the fina=
l in-kernel program instance (post-relocation, with any integrity-relevant =
referenced inputs accounted for), and record that result so LSM/policy can =
make decisions based on a fact the kernel can truthfully assert.
>
> Attaching and linking are separate runtime policy/capability questions. I=
t makes sense that SELinux, IPE, or a BPF LSM program could choose to gate =
attach/link based on whether Hornet recorded the program as verified, but t=
hat enforcement is orthogonal to Hornet's core integrity/provenance objecti=
ve.
>
> Thanks
>
>
> On Wed, Dec 17, 2025 at 11:33=E2=80=AFAM Blaise Boscaccy <bboscaccy@linux=
.microsoft.com> wrote:
>>
>> ryan foster <foster.ryan.r@gmail.com> writes:
>>
>> > Hi all,
>> >
>>
>> Hi Ryan,
>>
>> > I want to confirm I understand the current semantics, and specific iss=
ues
>> > this series is addressing.
>> >
>> > In the signed BPF two step flow, the LSM makes decisions using what is
>> > known at the time of run hooks.  At load time, the only clear fact is =
"the
>> > loader is signed".  However, if we really want integrity for "the fina=
l
>> > program that will execute after relocation, and any inputs as part of =
the
>> > contract, matches what was signed".  The fact exists after loader runs=
, so
>> > the kernel could end up allowing and auditing based on the signed load=
er,
>> > even though it cannot yet truthfully say the runnable payload has been
>> > verified.
>> >
>>
>> Correct.
>>
>> > If this is the right understanding, perhaps we could consider a design=
 that
>> > moves enforcement to the moment the program becomes effective. E.g.  L=
oad
>> > can create a program object, but it is inert by default.  The kernel s=
hould
>> > only allow attach or link creation if the kernel has already recorded =
a
>> > verified record of the final relocated instruction stream plus
>> > referenced state for inputs, is included in the "integrity contract".
>> >
>> > If the referenced state is mutable, then either state must be frozen b=
efore
>> > the contract is verified, or any mutation must invalidate verified and
>> > force re-verification and a new policy decision. Otherwise the state i=
s
>> > susceptible to TOCTOU issues.
>> >
>> > Is this the semantic goal Hortnet is aiming for, and is attack or link
>> > creation the intended enforcement point for the "cannot become effecti=
ve
>> > until verified" rule, instead of trying to make a load time hook repre=
sent
>> > final payload verification?
>> >
>> > Thanks
>> >
>> > Regard, Ryan
>>
>>
>> The semantic goal for Hornet is to validate the provenance and integrity
>> of all the user-generated inputs when they are loaded into the kernel,
>> in order to allow users to make intelligent security decisions based
>> on that. IMO, attaching and linking are orthogonal run-time policy issue=
s
>> that are seperate from provenance and data integrity concerns.
>>
>> Allowing or disallowing linking and attaching based on the completeness =
of
>> signature validation does make sense. That kind of decision would
>> probably be handled by selinux, IPE, or a custom BPF LSM program most
>> likely though.
>>
>> -blaise

