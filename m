Return-Path: <bpf+bounces-70414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00756BBD004
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 05:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA5C18930A8
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01DA1D63EF;
	Mon,  6 Oct 2025 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LXTiEwlS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51BF19F137
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759720136; cv=none; b=aytMBzOqXYPfzwk1BAGcK/dSM9X2OcfMCdBCcmIKk8g+t148phzO00l1nOTrcmAsH9QORBMzVXGADLPPThUYO5k7MgnQKDQRKPPeFIY9WNEreAUc4Y25BBzTlzQwzedQYsh+3sjIp3+tyGVGr19V9BvDEsqNsB91+qbFM+SxAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759720136; c=relaxed/simple;
	bh=0yLTIQwB9fdAyo7V92jyJastQ1nDJ7vd3FB/c9ABkJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pK9JtZntA0LoMw1u6qQvtGU6QegBRvZdLFMGQvzXgdVpC7E6X6DZT/FhTvcMfkHAMpvywk095w5WXTn9977OD95NzqQdmk/ANEzgt7yoOOxmHuuBRVjNDtPssnBVnlLYfg/1gvcHKHgRGPU89/3UT4Cu8uld9eOgbmE/PJgVrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LXTiEwlS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7800ff158d5so3676080b3a.1
        for <bpf@vger.kernel.org>; Sun, 05 Oct 2025 20:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759720134; x=1760324934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4aCWUxO2mzfHhufF1li6+1q6uq3SrP/tVgtenK/5tY=;
        b=LXTiEwlSkhHS3aTO73BnrqnbypaWvNVXofjFuQAxCWbr2t7jhz/2EDpCtn5nDn2GQB
         iGa7cmeeqxs0jbHq9guWadLak4Leh+YvSVodsEf5ssAAOOQcAa5LEZm2Mcf9EanQUlyV
         oBoD4IaPPc6VQn5Q2fRpa+9mxuKrqXE7e2wLzxqnE8hVC0XsQGuha02p1rxyDZ38zVEK
         Y9naHyB3lm22HV6yLAnpCSw3kogpr+mN42YBQD5H4IBkXVOfqAXaaQ4bPDLcCFAljqqy
         UEatF314GfOTMwDf8ZnNOdOlE1RW+3cH3qkZQdsvDhuAsY9YE0pyWTlgfk2PQkEGWkJX
         ImdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759720134; x=1760324934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4aCWUxO2mzfHhufF1li6+1q6uq3SrP/tVgtenK/5tY=;
        b=ko+Qn7ECtQm7P2cynnq/4uwKbUt2hjaTQSF6s0iccGTFH3vhmVn7bysZpLGaIUV3mD
         kN7KnYMkRC856CvfcELmKMV+hAmgs9uFZ7wws6kZWlL9O0NIFv1F2rv80/lr77H9KaYB
         D5NQWd+Zkkw6G4MwE4Nv8mTPMqlG1a8/TFocozQlkmjkhxDdc0HHK1EeQ1CgxUDN8q4f
         LLnfQOY8l1+gpDGQ1jc+fB89sKaXQugpMdEiKRdHMceTZVqwi0sEt3vAqlZ/muhc/20P
         fGPVEMQ+vfqNo/jWGsIX3GlSA61B51PNzrtPYjSR4RRgF+x9ZuIBK/YeiqVg1U9xSuF9
         F87Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvU96JedQuC4Gv4w6zU71y0GCXLchgL8oUVywyrLbjuBwzo71HzAIZ5Xs05Uz9OxX9cnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc62JNggzV0HHUW6SvyO6xYGVkkEYYzwFTR4ctgjNMBkzevM0L
	cgTkjnp55ILHJkd3vAKM7iSmgOza23HQcR1pcRaIDAYtwDYb4GgghGwC5/gzYLQplyAH+y4870f
	si3UZ2rxysOaFYvTdJ8zzN4JsyDTomoPlFv2ptgNx
X-Gm-Gg: ASbGncv4SALx7JoJWIxcwrzkyi8BYXQoOQ7BBNs7ZngskQJGtUElzDVHAog9ZYDPv5t
	sk0ftudI2qiiEhlhtgyzxe0WLMceGKWuSObYCS6fReBucEdAPw3aJSbtnruiM1K+4hqdHG5DUhg
	MmH3jMdDbwYzYE13OpjXfjoTDX/e+nsmPr/HXi2ERdJWeMB4P7W1pRgUjw5rdzgxkNnCBsKs3HI
	7Qcsg+8EmF6dA1UdS1gUeZ7Q1/l01o=
X-Google-Smtp-Source: AGHT+IFCt+RqLEVsQFIY8oIemcf7/RTIwLFh/UY2bk/g+f4xzzegJUjd56qDsi+htxyxujjoJkSTeFa0aprWMBHDJ8Q=
X-Received: by 2002:a05:6a20:7f8b:b0:251:9f29:4553 with SMTP id
 adf61e73a8af0-32b61dee067mr14223071637.10.1759720133857; Sun, 05 Oct 2025
 20:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com> <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
In-Reply-To: <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 5 Oct 2025 23:08:42 -0400
X-Gm-Features: AS18NWD9iszS-t206AjtPTSVskOtC0bQiQ4dny6sytJNEot7kKcj7Hg_pEaZ9SI
Message-ID: <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: KP Singh <kpsingh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, ast@kernel.org, 
	james.bottomley@hansenpartnership.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kys@microsoft.com, 
	daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com, 
	qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Fri, Oct 3, 2025 at 4:36=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Thu, Oct 2, 2025 at 9:48=E2=80=AFAM KP Singh <kpsingh@kernel.org> wr=
ote:
> > > On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:

...

> > > > To make it clear at the start, Blaise's patchset does not change,
> > > > block, or otherwise prevent the BPF program signature scheme
> > > > implemented in KP's patchset.  Blaise intentionally designed his
> > > > patches such that the two signature schemes can coexist together in
> > >
> > > We cannot have multiple signature schemes, this is not the experience
> > > we want for BPF users.
> >
> > In a perfect world there would be a singular BPF signature scheme
> > which would satisfy all the different use cases, but the sad reality
> > is that your signature scheme which Alexei sent to Linus during this
> > merge window falls short of that goal.  Blaise's patch is an attempt
> > to provide a solution for the BPF use cases that are not sufficiently
> > addressed by your signature scheme.
>
> I am failing to understand your security requirements.

I'll be honest, given the months of discussion on this topic already,
I do worry that claiming a lack of understanding at this point is
simply a tactic to drag this discussion out or dismiss our arguments,
but if this is an honest admission let me try and better understand
the point where you are getting lost ...

* You've commented on Blaise's patch, so I'm assuming you have a
reasonable understanding of Blaise's patch, if not, please speak up.

* Similarly, are you comfortable in your understanding of the
differences between your BPF signature scheme and what Blaise has been
proposing in this patchset?

* Do you understand how Blaise's signature scheme verifies the
signature of both the loader BPF program and the original BPF program
before the security_bpf_prog_load() LSM hook?

* Do you understand how your signature scheme only verifies the loader
BPF program before the security_bpf_prog_load() LSM hook, meaning the
original BPF program has had no integrity or provenance verification
when security_bpf_prog_load() is called?

> > > You keep mentioning having visibility  in the LSM code and I again
> > > ask, to implement what specific security policy and there is no clear
> > > answer?
> >
> > No one policy can satisfy the different security requirements of all
> > known users, simply look at all of the LSMs (including the BPF LSM)
> > which support different security policies as a real world example of
> > this.  Even the presence of the LSM framework as an abstract layer is
> > an admission that no one policy, or model, solves all problems.
> > Instead, the goal is to ensure we have mechanisms in place which are
> > flexible enough to support a number of different policies and models.
>
> Please share concrete policies you would like to implement, this is very =
vague.

Please understand that this is the wrong question, for all the reasons
mentioned above.  A better question would be to ask what primitives
are necessary to ensure that a LSM has the necessary visibility to
record the state of the BPF signature verification and make an access
control decision based on that state.  Blaise's scheme verifies the
provenance and integrity of both the loader and original BPF program
prior to the LSM call, your scheme only verifies the loader before the
LSM call.

--=20
paul-moore.com

