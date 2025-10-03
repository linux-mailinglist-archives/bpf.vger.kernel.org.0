Return-Path: <bpf+bounces-70273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142DCBB5CF6
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 04:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ECC421656
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 02:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710722D73B0;
	Fri,  3 Oct 2025 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="biJUscZv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC72D3A9D
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458979; cv=none; b=ogFypp6Pg6zfnfke+VCaxVteWzfTE1Rq0YBMtds9wPKX8s4cTkqTEkoQdJIst0aJGyQFSrgqA89IgMIBmrGUIWLW4LqO79IxrOg1MAE1X+BSaBHt6HqylTwOksJQS0XN8cBr+EE/p9GbH5VIkEHhlqX/96LUHjgpL+ilPK5zedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458979; c=relaxed/simple;
	bh=PDczC1UG00DKnp6JOz+u1xrR4XnhBXDaIWAvmub58IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCFGMvdXQBVVoa5/Z/5OAQq2GLyVFJXcm2vpQa0LeLgXR1NZ8eRHkQPhZV0/QC1kd8s7fhqhuwVylIyL7g08ZGmqbiR5/2tKiOubGIh5E3XsMbipYUw5rD5/q++7hEvbep7D3ZwS7NZ5RnbHlZq5gz5xuX1vCCdgymnw5Kyowco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=biJUscZv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1908520a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 19:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759458971; x=1760063771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbVUWWtfJTKo6/VAKXWaJ6AL71jAQxSRwAQukA729RI=;
        b=biJUscZvvNIKJCpLzURZQ6r1QAkRcRwrelgv4SpiUdSQ9LBWpoWUCXRKrTQpVmJjMb
         Iz0Pq6MiyENjlbFeywdBgvY9joRjgJgkvi0FJpSILzPwk6dPCMd4UTMxVikam82Ia437
         QRnMMGkj/KbsZ4CL+DM3EZna36333F0f55EOeD+RtR8Rd6sFOoI++YWk7ZMNS2dGi+k1
         ozVY03wm8/h7HTYFtEZrGRJtnvu+5xIXYzRp6KrPpt3qy59F/rKq+2BenX88qH35q0rO
         mmq5UmjoUUjk1VISpdPUPaWKkIEGvGm2fXWwMUiK8s4dLK/P+1CW+NKLt7k3JBGodC9/
         J0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759458971; x=1760063771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbVUWWtfJTKo6/VAKXWaJ6AL71jAQxSRwAQukA729RI=;
        b=JmZD/Ph+Uc+cco7cyLd8k9m1AjMQEyAycnOrXKMiUCaEzpTSMQjIfbh7htSXWodWNO
         NUjc5icYB00EPBskD0l+UMjcTB+iM+8dAgCRcyDywaMwuygFCmT5VDbKE7O+j23IXPsP
         cu5cGIOZhNXCcgLl5mEXaTdFVPsxMv/rejkwxAJ21lPpedeo1qmx5RuAfrk7MSNM+Z6U
         RHn8ZgDnAaMVbyUJkajFGtEaU9T0n82FVplqpOtYpjcc3xrzHnNf/O51egT8cC4GacZO
         gFEewDJMq1/jwY9wgfMnp8MndV2Tj2SB3lD/F5h9qT1r8W9ufm08shWiyOmOsX2WenaI
         LIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI94cmrroe2lCTn3Tzj3RxNH7MDXRZ108CbleJcxoSRNbPn761hdxMztAvSojy7YgBbNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQMc327Xpf9Q3kp/OeUOcr7uEU1K6GDsKW53hXD6tiP31BTmu
	mPzhPKHZ2XjxEtpnPHXZBgFh4QIaNDkz5NgRI1yT3n4tF9xbO+6zrFkGjrhsWDWlhspqd9g/oaW
	3CR3Y8t9Ib9f890ERJQdOv8sfDFvCr23NrrKZv0fv
X-Gm-Gg: ASbGncuBNaDEqgkrcS3J+/z8527adYaU1zIMsv1MGJBKkM4Sii0VjMC/HsjkEEMh4Zt
	E/+LM9iOI1nlr6R6MEEjeYWZBeAKv5yBFDWz2i0OqGtrYM7QIj5R5rZYd9yIU37mq9q3vZGu5yr
	Ww85bNhGXxwpThHbwT/dAhazT9OSk2qZJccXn0OgfYDux86IvLZEfwVeBstE2WFbXlnIsDIjAP5
	V0TxUXviFT9ZZ2jtknkdKdOJbt9hHb0qgJou5H34Q==
X-Google-Smtp-Source: AGHT+IGM7sxkAvHQCswLIRm1lmGJctyE4Z3LAYrg0SJpQyZKL7u/tjCU1lsl821OhhdvdwC72y4sBnfz78urQGkfowg=
X-Received: by 2002:a17:90b:33d0:b0:329:e4d1:c20f with SMTP id
 98e67ed59e1d1-339c270272cmr1798927a91.9.1759458971129; Thu, 02 Oct 2025
 19:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com> <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
In-Reply-To: <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Oct 2025 22:35:59 -0400
X-Gm-Features: AS18NWA5VOquYItqewfcLw0X1EfuA0hKyUTOPc-IPXqDwZgNXrJXoVU9Q8aukJc
Message-ID: <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
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

On Thu, Oct 2, 2025 at 9:48=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > With the lack of engagement from the BPF devs, I'm now at the point
> > where I'm asking Linus to comment on the current situation around
>
> The lack of engagement is because Blaise has repeatedly sent patches
> and ignored maintainer feedback and continued pushing a broken
> approach.

I'm sorry you feel that way, but that simply does not appear to be the
case.  Looking at the archives from this year I see that Blase has
proposed three different approaches[7][8][9] to verifying signed BPF
programs, with each new approach a result of the feedback received.

> The community, in fact, prioritized the signing work to unblock your use-=
case.

As mentioned previously, many times over, while your signature scheme
may satisfy your own
requirements, it does not provide a workable solution for use cases
that have more stringent security requirements.  Blaise's latest
approach, a small patch on top of your patchset, is an attempt to
bridge that divide.

> Blaise's implementation ...

I think Blaise's response addressed your other comments rather well so
I'll just skip over those points.

> > To make it clear at the start, Blaise's patchset does not change,
> > block, or otherwise prevent the BPF program signature scheme
> > implemented in KP's patchset.  Blaise intentionally designed his
> > patches such that the two signature schemes can coexist together in
>
> We cannot have multiple signature schemes, this is not the experience
> we want for BPF users.

In a perfect world there would be a singular BPF signature scheme
which would satisfy all the different use cases, but the sad reality
is that your signature scheme which Alexei sent to Linus during this
merge window falls short of that goal.  Blaise's patch is an attempt
to provide a solution for the BPF use cases that are not sufficiently
addressed by your signature scheme.

> > Relying on a light skeleton to verify the BPF program means that any
> > verification failures in the light skeleton will be "lost" as there is
> > no way to convey an error code back to the user who is attempting the
>
> This is not correct, the error is propagated back if the loader program f=
ails.

The loader BPF program which verifies the original BPF program, stored
as a map as part of the light skeleton, is not executed as part of the
original bpf() syscall issued from userspace.  The loader BPF program,
and its verification code, is executed during a subsequent call.  It
is possible for the PKCS7 signature on the loader to pass, with the
kernel reporting a successful program load, the LSM authorizing the
load based on a good signature, and audit recording a successful
signature verification yet the loader could still fail the integrity
check on the original BPF program, leaving the system with a false
positive on the BPF program load and a "questionable" audit trail.

> You keep mentioning having visibility  in the LSM code and I again
> ask, to implement what specific security policy and there is no clear
> answer?

No one policy can satisfy the different security requirements of all
known users, simply look at all of the LSMs (including the BPF LSM)
which support different security policies as a real world example of
this.  Even the presence of the LSM framework as an abstract layer is
an admission that no one policy, or model, solves all problems.
Instead, the goal is to ensure we have mechanisms in place which are
flexible enough to support a number of different policies and models.

[7] https://lore.kernel.org/all/20250109214617.485144-1-bboscaccy@linux.mic=
rosoft.com/
[8] https://lore.kernel.org/linux-security-module/20250321164537.16719-1-bb=
oscaccy@linux.microsoft.com/
[9] https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsoft.=
com/

--=20
paul-moore.com

