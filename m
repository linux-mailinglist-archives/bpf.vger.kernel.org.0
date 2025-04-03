Return-Path: <bpf+bounces-55232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B423CA7A594
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F7616515F
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F824EF86;
	Thu,  3 Apr 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nak5jeFS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4541F3FC1;
	Thu,  3 Apr 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691462; cv=none; b=qLDqr+FYZKUGpBuaLkmsxvmsZ3AQg/2uVfoVyQIrCqMYHWm7sRxfOhWwY30MwK4GVQf/mPspkccQ7retOQPdb5eoqe1IzVlbfdAHU11UfZHo3/f3w/fl7N4ybffYeqZEaV18eaa7OgKguY34NtzhXIufVMOfEteS+6N9EXpoBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691462; c=relaxed/simple;
	bh=2cenGHJaJGL+33Upo6ZJCogd3Tf5hF2FAnQzfieBmaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFKpXe1oFqFNJLUA6b7uJwgS8vRmZ+IzCOTj6YAqDPlV0q+Ry+K41RK1XgTt1sfHjf3QpPA/zVyXaeLTvP21vgMHA6fxnDHeFnE6YgPERdClm00iefwLbAALwQtLI1JfvAko5BzsaoSBoAIBHfRLXufO9DdTdl58kgqHgF1Ie1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nak5jeFS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913958ebf2so722527f8f.3;
        Thu, 03 Apr 2025 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743691459; x=1744296259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJcazkIEDozvWk+30oCrM412gCrQpqbZCL64NnE+en8=;
        b=nak5jeFSg5JQLsw1HBnmhh+0v7bCsRaaZCyAd29X4be6iWCiil/oKyYXXLaFCcXK9G
         rFoHSDpeJ3NXmjZAb/IkiWSuoFEMByV6kzEpoLWKG4sG3G32cUC9CBE3Q4aRKK9Cm2eG
         ICdjbb2LWfP5QMOF5Yms15tc9ng8g1PPlxaINbhl3BwUSS/q2+apN1iuuRCNB50qerhL
         FzVjKd2/gQczQ8jzZ+S9/v+FfCgOJEhvUBLfKm/eXjdfJ88Afqwfva9+fbWSThmFdpqB
         VDVaeS4+r00eHT5riSqnLryhkipazv9yxcN4mfHpx2/RPhscvlhCcaEeJgrxycNzyRfl
         qKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743691459; x=1744296259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJcazkIEDozvWk+30oCrM412gCrQpqbZCL64NnE+en8=;
        b=j+WidikOQFkL8zh3+U3BHCvLGYBUImoA1YWh5AWthFV8WikXklfcfSA6LOWu1JMnhv
         rfvUJDewtMz4dgSKn4rDADzYwza3peZ1tkaTJOkhUjHx9NQSE0sLuWj3j9XqHtRbfK5y
         w2D6h3kC6nZskD42hPEKSDdD2AiBrMx2P3a+Z0X4S54TVIPItgwwA03jH3gx5+qNOaqa
         KM2u/SoTFtpJU4q95QIEx6VsjPk3losppjKaS0zUzIFdYIztFFIGoDsfJTmeXNB+6ZcT
         b/A+0SHLyfUaQ9lFHMaYvFyfNY7hgUZBzfeJSF2Ot/NEQfPxlaCNsK46tbLVfWAnKbC3
         H4XA==
X-Forwarded-Encrypted: i=1; AJvYcCWBbtHdaeC+jJsNWv54t0CtmGb2jP9zAADGOCzj9fH4QASIX/MDGNLLxSTeTQ6i2+JcKJcJWeDJQMiB/xUs@vger.kernel.org, AJvYcCWQvnSnf69p74pPGab32YX3uUFX4tjq3hrere5OH3t6RVtDiM6LePJIC+/Oru8goOtlp1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrxMuTZQJZl/8s3MB/vtW6lbqhpaelsng1Y6ctqsI4yZIhm0d
	t6qLCwWfpsIiDsODxhpdDDfExtdtXyP7wisQ83Oi+UjwNqg7W0bQ4Ss2TXrSXPebJhBNGq5hlCA
	iREKMSC9WXFgvHEhAic3Wzdmkoh7jD2Jb
X-Gm-Gg: ASbGncu7t3OY0S5OceGPWf3h0NanTMye34LlFVbQnuwf2BHQ988tf4eE5jwk9nFH014
	MsrDulF5o+JXLJCqUIUt/siagKZ9OKqe8LsQYrnRnWuUiwsEGO30vDb39z9u5L/8T6fnWyiVCT3
	js5X7nhI7SMcQvds/cJYv5boq49F/MEMXL/PE7kV+gow==
X-Google-Smtp-Source: AGHT+IG1/M8yu7tmeJXQ7SghT6j3qDvLYNL6+WbZC5IEfpB9M3/7fb17gQW7XBGvptfcI4aM9iAfofQzu15/qT5TjjA=
X-Received: by 2002:adf:9cc5:0:b0:39c:2c38:4599 with SMTP id
 ffacd0b85a97d-39c2c3845a1mr4322657f8f.48.1743691458671; Thu, 03 Apr 2025
 07:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401005134.14433-1-alexei.starovoitov@gmail.com>
 <20250402073032.rqsmPfJs@linutronix.de> <62dd026d-1290-49cb-a411-897f4d5f6ca7@suse.cz>
 <CAADnVQLce4pH4DJW2WW6W2-ct-17OnQE7D8q7KiwdNougis2BQ@mail.gmail.com> <5feaf4c7-4970-4d9b-84a2-fcba2cbe0bc4@suse.cz>
In-Reply-To: <5feaf4c7-4970-4d9b-84a2-fcba2cbe0bc4@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Apr 2025 07:44:07 -0700
X-Gm-Features: ATxdqUG6OgL8s8t0wshh5CPMfg0m70fYQKXAvaU1p72IqliIQzRiFFQlOQq6XRQ
Message-ID: <CAADnVQJjy6fFGpPCm_bo-MmpgP136jxtn6De-AiemL28de91MA@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 2:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 4/2/25 23:35, Alexei Starovoitov wrote:
> > On Wed, Apr 2, 2025 at 2:02=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >
> > This is because the macro specifies the type:
> > DEFINE_GUARD(local_lock, local_lock_t __percpu*,
> >
> > and that type is used to define two static inline functions
> > with that type,
> > so by the time our __local_lock_acquire() macro is used
> > it sees 'local_lock_t *' and not the actual type of memcg.stock_lock.
>
> Hm but I didn't even try to instantiate any guard. In fact the compilatio=
n
> didn't even error on compiling my slub.o but earlier in compiling
> arch/x86/kernel/asm-offsets.c

The compiler will error compiling a random first file in your build process
that happens to include local_lock.h.
In your case it was asm-offsets.c.
Try make mm/ and it will be another file.
It doesn't matter that nothing is using guard(local_lock).
The static inline functions are there in that compilation unit and
they have to go through the compiler front-end to be discarded
as unused by the middle end later.

> I think the problem is rather that the guard creates static inline functi=
ons
> and _Generic() only works via macros as you pointed out in the reply to A=
ndrew?
>
> I guess it's solvable if we care in the future, but it means more code
> duplication - move the _Generic() dispatch outside the whole implementati=
on
> to choose between two variants, have guards use use the specific variant
> directly without _Generic()?

Unlikely. _Generic() works only when the original expression
is preserved all the way to _Generic() statement.

> Or maybe there's a simpler way I'm just not familiar with both the guards
> and _Generic() enough.

There are options.
Here is one:
diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 1a0bc35839e3..e053e187d99d 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -124,6 +124,9 @@
 DEFINE_GUARD(local_lock, local_lock_t __percpu*,
             local_lock(_T),
             local_unlock(_T))
+DEFINE_GUARD(local_lock_for_trylock, local_trylock_t __percpu*,
+            local_lock(_T),
+            local_unlock(_T))

and it can be used as:
guard(local_lock_for_trylock)(&lock)

Naming is hard, of course.

tbh I'm not a fan of guard()-s because I see it's being used
in cases when open coded lock/unlock would be more readable.
They're useful when there are plenty of cleanup code and goto-s,
but not universally.

In case of local_trylock() the guard is likely unusable.
The pattern, so far, is something like:
if (condition)
   local_trylock_...(&lock);
else
   local_lock_...(&lock);

so guard()-s don't fit.

