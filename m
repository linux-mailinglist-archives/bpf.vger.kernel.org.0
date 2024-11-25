Return-Path: <bpf+bounces-45582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7749D8BA5
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 18:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4974016342F
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DA41B4F24;
	Mon, 25 Nov 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QKZdhA/i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC441C92
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557125; cv=none; b=Xi8bKeyWbLi+uf8zeNUKfJT+1K74d1Zh5LvC764iH+hSoFEYVEl0z56F2Kw8vZkZUPPkBpQpo93CCawsOI3dx6eA6/uq2rVF8/WOTaAFWsW5C95S0papVOegDi3Y6fbDcDXlDooUk3DTM02imbeSLMjK5xwxXtJoZTeqCFeJErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557125; c=relaxed/simple;
	bh=iqPKUKL9ELh3ItkoROVJPLFbP84xRrkUj8+Scx+N17c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5XNAroO1GTOrIrgjSOXMyjQTmAiGq1sqSCOkbJM9CCuyw1Yu0aseHNMqDV2cC+2d+Vltk4Pk1Xk0RPcd0fZwoq5VzXxI/ZR7NDRae9SEaZn5Ou1wsmtA6Gka9x/R/aTC8QI4l7XeHPaBQaK8lPMp8dCQa8gS/8Zt6HUdXg8Ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QKZdhA/i; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa53a971480so285648166b.1
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732557122; x=1733161922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xXLqvBkzwwQHV9WjuiXet8nTMU/3s9BgOxGDDiZ4odc=;
        b=QKZdhA/illhBsNRN8UzfrZ8A0LE+Qub8twEonry7Dtbr0sLQnm7nm3v6FVRjlapwYs
         Qel8970mEzQy2N2XBFd9PKfJmcO3DTU3cwskLgzCS6Bf3wmm3LQN3PnhXttgeV4PfHim
         oFWUVLrStsJtWM2iUYr0u5eG9tszxLa/00UoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732557122; x=1733161922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXLqvBkzwwQHV9WjuiXet8nTMU/3s9BgOxGDDiZ4odc=;
        b=TDclBaef5mdJ0uVizXyOzgX6kWWUI6V8pBqVXEXHrndA6yjec3oUT5h9MXZLhuMmUa
         fyXcMBrMhNV8Fi83HJ7s92TjlF5GMaLD2Tn2JuQBwwrb/PdJnrtgLGOhmeABGDyEtt5I
         +oq4qpIR4GWlw1r7MZASJpt9aXLolcI50LBCqvsXLBVH3J3PlNIjGIOqOBYA//l1kfvA
         tKNtmjHDWYRuzJYBigG3gwMY8udt3L5bLLpFQ82wlNO1BZ2fRt8S4Y+fY3gTnm7Hvnwj
         PvcanbSdLJt6tAQi2+3i0gv5xY34HTB6sUZBqxMQCEXxoKGIiRezbruNzDaHwmXceEdv
         BQRg==
X-Forwarded-Encrypted: i=1; AJvYcCW6pSVdrSjknjIeKADaFW/fZcTd5TvnMm85mQ/UAA4aV0fItAypRDwm3n9bqTx6UD67+3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NDx4QjVOe/RaiX8e+mAkwBaUA9M4FF0qMjKvDAJiXoQ3Rp01
	0fg9agYtlmnVype2BE5YuS8CDgHDXSorjVhUBoYU2q9BaCMShQePS1e7xQTukYokUJzotmg4hd+
	pLtSu7w==
X-Gm-Gg: ASbGncthGwDTs6kPOjazhrxX8ffMRBVGPtgFbM6YG/wUbhOlAfoNxogp94b2uw3JDOP
	IcM6gSucMEmONOCT1L/Aq2IYdg5TZ7CLC1KY1wZYPthM3uRjP2Rt2S784nmOLKDn0s+/cJ2ZLnm
	5l7JK4V/4XZ/WBu43IFv+7GTmbfVxNTxcZ+299bdQ4kVcYkorv4axiHrdIGpRe0beokOgmFhMcb
	TBEDBQYT2Rk9ciQ9po2mCZtnBYS2FwaWpfcq9VWFnpltmlYwUEc3hVKQbt5ONdYkHDjlSuyYZm+
	8Xe7rQkU5k/glYczoJWsix8W
X-Google-Smtp-Source: AGHT+IHS5F60F6rsPdqG3mubNnOHKbn2Ks3IbRDKvB2TE5YRYs3mPHth6gZvGD0GT5saWg2BGKmD4g==
X-Received: by 2002:a17:906:cc1:b0:aa5:27d4:980a with SMTP id a640c23a62f3a-aa527d49829mr825988766b.49.1732557121938;
        Mon, 25 Nov 2024 09:52:01 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28f88bsm490355166b.2.2024.11.25.09.52.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 09:52:00 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so5872247a12.0
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 09:52:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIhv7JCgt09t61zzNAAY/1MuombNCK0I4LJpSCX4d3L8RshZpHIjPIHnBpJJlEZoaMxR4=@vger.kernel.org
X-Received: by 2002:a17:906:18a2:b0:aa5:3b5c:f640 with SMTP id
 a640c23a62f3a-aa53b5cffafmr703474466b.54.1732557119666; Mon, 25 Nov 2024
 09:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com> <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com> <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
In-Reply-To: <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 09:51:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
Message-ID: <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 07:35, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> At one point I had a version that did:
>         if (0)
> label: ;
>         else
>                 for (....)

Well, that is impressively ugly.

> but it is goto-jumping back in the code

I'm not sure why you think *that* is a problem. It does look like it
avoids the dangling else issue, which seems to be the more immediate
problem.

(Of course, "immediate" is all very relative - the use-case that
triggered this is going away anyway and being replaced by a regular
'guard()').

That said, I have a "lovely" suggestion. Instead of the "if(0)+goto"
games, I think you can just do this:

  #define scoped_guard(_name, args...)                                   \
         for (CLASS(_name, scope)(args), *_once = (void *)1; _once &&    \
              (__guard_ptr(_name)(&scope) || !__is_cond_ptr(_name));     \
              _once = NULL)

which avoids the whole UNIQUE_NAME on the label too.

Yeah, yeah, if somebody has nested uses of scoped_guard(), they will
have shadowing of the "_once" variable and extrawarn enables -Wshadow.

But dammit, that isn't actually an error, and I think -Wshadow is bad
for these situations. Nested temporary variables in macros shouldn't
warn. Oh well.

Is there a way to shut up -Wshadow on a per-variable basis? My
google-fu is too weak.

Did I test the above macro? Don't be silly. All my code works on first
try. Except when it doesn't.

          Linus

