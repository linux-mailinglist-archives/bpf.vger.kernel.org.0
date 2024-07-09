Return-Path: <bpf+bounces-34186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89192ADF1
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 03:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529201F220B5
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 01:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAAA37147;
	Tue,  9 Jul 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVxJrf06"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37094A05;
	Tue,  9 Jul 2024 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720489830; cv=none; b=MSuA0lSgRWJ60IyUl9zEFM8WIOe3Eubh+Q9A6p70iUeGQBzvUTvx31T/LFKn6G6g3x9n8gsQT44C5ntEFHSFVnVz6ikQNktrXVBxJITmJ/X71XjBnJxT6U8It/2Dn40wXGynZnHb/UxKLleel0wmsEgg7GOee3oBP7SAS2EyIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720489830; c=relaxed/simple;
	bh=M6cS16QMz6Hrvgl7rAQaNBeEcshb0kw/FrzzIecUx7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srKhl87r1FqfXFIxxsWHMAdF3Jz+BhmrtobKw6INR2V6+NvXk7pfL/Et750L6UEULss09i5aFxIhDk82bYx3Rqhudi6kWLOLwJtFAIt1Un1PqckLpnbVy/2re8isCAuYLoBTdHqbs056DQAtBYqX8Gz3W3iANuDSWZmnK7QB+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVxJrf06; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367a2c2e41aso2267750f8f.2;
        Mon, 08 Jul 2024 18:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720489827; x=1721094627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoRxfxZC2umnUAdRXzYjlBWMFWTXr82v6KUXXwyLie0=;
        b=hVxJrf06d4UMs3NETms1iXopOFNl9iYxsCB9fNdlp/Zwtt0ew/ahp0I/9sMdNxn7Pj
         hBQieDYkX6Gli9XFmP/UlO3guu6HHclblbpNUC9xcksR7t4TuHsg65XGpEVCsCjwZNOI
         7hONA6lDP7sPN8Ut2eZkYxqWMZqIwPqrdKV9gG4tw7LuKloOnUXWMygDc2N4gGT95FWQ
         1wMLZ/uyBUEKk8l8GP3SOjPAdIKTDzuCOZeFBAhS0+2gzbznZfJWQ7DCS2kDGHCsEDER
         I0Y6kHibAXCwdHCGbFsVoguOz6rC/3hZRkZqw/1ojGG8XL+8pNTLMIoXIAAv7DX1lLjN
         vCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720489827; x=1721094627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoRxfxZC2umnUAdRXzYjlBWMFWTXr82v6KUXXwyLie0=;
        b=nBXr5Wq+2NCkqJ6+XMXBPaz3phK2ehIdcX+UVK0ylq3xX9ngBph7NN02p+x+SUFox4
         4cAAkLvx1YNKzQNR3FOQWFKwe042m6HLkZ4Tu6N8zSAu0AQ1w9SsvJtVRMljDbk/9v5E
         3T25gsjhDRRbhXHKSYoQ7JWfQMxNzkL6OxQTH9NE2SA5wmyhqssLm5vGsUwK2NB/DLb0
         T/srI+V5vw2ADWH8wh7ek6mYnm3Fy/1vfAUJj4a4HhdhsO8uFBOgFnDDHCKZQN431BWV
         V1Fj9tk8qkIy6AB99WMQTNwV0NjG4PpN5K8ywfK5XfZhE45pQPBge2YSoVhhA322OoYR
         bL2A==
X-Forwarded-Encrypted: i=1; AJvYcCUjrMdpnX4KasZFKpxGgg7qwaibG9AR5Zll53mW/sJyGbOw2/+A4fGYk8jHxKdrsBHJDWAgIxJcZBUyBNBtziFolNvPCDgHx7p2bZhlwF5AWlDmk0RKmIJiR7XPPxT8CHCl
X-Gm-Message-State: AOJu0YyBn7RPL6VcPqoOksaxlWeD2HF2GI+AkkusAVR0ynsZEgwQ3C0B
	TWV+5X6+6RJMaTfWky7Z1gM+l0//gZY5Bqu4+isk4zEG60Yl70VOexfsA/nGfO4uVpt3NiuhRel
	KSwfY5PaDp3yiiWei9JS82grhVpyFu5t7
X-Google-Smtp-Source: AGHT+IEw8tlzxgkgYOkRQ5jGNoH5QqZ/HHxJWiORnI8zGpiNcp12hk0rKj326WdMMNdpHAMboUswblJgVPN6t7l1Hlk=
X-Received: by 2002:a5d:4848:0:b0:367:94ff:6835 with SMTP id
 ffacd0b85a97d-367cea67ecemr772662f8f.18.1720489826753; Mon, 08 Jul 2024
 18:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zn9oEjsm_1aWb35J@slm.duckdns.org> <Zoh4kp7-jAFZXhe6@slm.duckdns.org>
 <CAADnVQJ6o-ikfnHiatbNwS8+MKi44kcBfVtnDQkYLdDUZ80Rtg@mail.gmail.com> <Zox4_MHR9HiwmtHt@slm.duckdns.org>
In-Reply-To: <Zox4_MHR9HiwmtHt@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jul 2024 18:50:15 -0700
Message-ID: <CAADnVQ+e6xE-KNVfe2mDrg2y4FmXkKnpFG-Z-S2nwt=4gQwsyA@mail.gmail.com>
Subject: Re: [PATCH v4 sched_ext/for-6.11 2/2] sched_ext: Implement DSQ iterator
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 4:40=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
>
> > > @@ -1415,7 +1487,7 @@ static void dispatch_enqueue(struct scx_
> > >                  * tested easily when adding the first task.
> > >                  */
> > >                 if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
> > > -                            !list_empty(&dsq->list)))
> > > +                            nldsq_next_task(dsq, NULL, false)))
> >
> > There is also consume_dispatch_q() that is doing
> > list_empty(&dsq->list) check.
> > Does it need to be updated as well?
>
> The one in consume_dispatch_q() is an opportunistic unlocked test as by t=
he
> time consume_dispatch_q() is called list head update should be visible
> without locking. The test should fail if there's anythingn on the list an=
d
> then the code locks the dsq and does proper nldsq_for_each_task(). So, ye=
ah,
> that should be a naked list_empty() test. I'll add a comment explaining
> what's going on there.

I see. Thanks for adding a comment.

> > > --- a/tools/sched_ext/scx_qmap.bpf.c
> > > +++ b/tools/sched_ext/scx_qmap.bpf.c
> >
> > We typically split kernel changes vs bpf prog and selftests changes
> > into separate patches.
>
> Let me think about that. I kinda like putting them into the same patch as
> long as they're small as it makes the patch more self-contained but yeah
> separating out does have its benefits (e.g. for backporting).

We split kernel vs libbpf vs selftest patches, because libbpf patches
get synced into github and it's released from there, while
kernel patches get backported, and selftests don't have to be backported.

> > > +"  -P            Print out DSQ content to trace_pipe every second, u=
se with -b\n"
> >
> > tbh the demo of the iterator is so-so. Could have done something more
> > interesting :)
>
> Yeah, it's difficult to do something actually interesting with scx_qmap.
> Once the scx_bpf_consume_task() part lands, the example can become more
> interesting. scx_lavd is already using the iterator. Its usage is a lot m=
ore
> interesting and actually useful (note that the syntax is a bit different
> right now, will be synced soon):
>
>   https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_lavd/src/bpf=
/main.bpf.c#L2041

Thanks for the extra context.

