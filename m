Return-Path: <bpf+bounces-45665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E0B9D9F48
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 23:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA628589F
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D091DFE1E;
	Tue, 26 Nov 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U2ckVatM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE781DF984
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660866; cv=none; b=IUVRFTyU9QVapS0AjIcF8yTWf3CVaR0SAQFZT9gwMlBvh4bm8c9DpEsDo5oOMi5UXlqW+BLcKZpMte3BU38HKkpK0eZsvRljbSTkIdaUiqPD2AsqvMHbtH4cX9LRNa6n4GRpDQmPjLpa6Mv4n4kStHRKLZBlvV4AgXLhTpKFR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660866; c=relaxed/simple;
	bh=51rqWKa/9fOh6GQVlexs1p8suWSnLeJOxOeaHETGV10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AU2a6pWeRaGeKw29Ht/z2/cDwdWjIkQFasJ/fuG0DCJsbXDocBPzA+7SC9er9III2utLe51VRuY0K9ul4sNrTs/ZIXIZJZMZW22oTUuVSkoousytWazAXVTWnCkJlFelWNb+cK5sUIjOC/sYr8SSX1tDmZdnAqe0jnvKeMalONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U2ckVatM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfd2978f95so8387013a12.0
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 14:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732660862; x=1733265662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7pbYi8XVvPynSRXkVpkfjziZ+aTH3WZhoGNDgr1HVmU=;
        b=U2ckVatM8s54eP+2ercybb6a4NPbI4fkGFdQ8819E+XtXwm/VnenMUi68VE+rqqE//
         oSTC+Lsc4ob7tlMOkaqGe3wI6PQHDVECN2kkS0QDsnqo0ZBrhBJBKAny49bidT7H/X0d
         QEocyz6gvgU2aJcpTJ9vyyAZDPh0L3c1Bfdw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660862; x=1733265662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pbYi8XVvPynSRXkVpkfjziZ+aTH3WZhoGNDgr1HVmU=;
        b=DfrVJCHfS8bGd8hWx6GEWTjZ/MZTbO2KgPzISFTvd/R6IgYkesarLJoMdBTeYG8ycq
         iRkHWN40iHw50Adustj0JSsSK6l0bPHsQiadpTXp/md5wHZEPsqd8N+pnMPTgKjK7ZSr
         73Kn6HB4Tgu5oKSiPOYzbWxcKEmWwlgYIlXIGaBvx3ndBPZKc+t9cibuQLtO+Pr7MdXV
         IQ4fHj7WBgnbI/FNZXF6ER9rgpLhaT5+yBhHCpGhV7Cmt0R+UajFFTM0Wd52Q+ISTdwE
         x7qsWG/zFQD8xuyOECipCDLr8DRGHw2J4JXs10apzu8LSN34cwGdYYHdm2UesJyEA51j
         iUiA==
X-Forwarded-Encrypted: i=1; AJvYcCVFUzn6BIr/4mIaLTBGOz/JmpoBE0NnwgOdjNdgDX5Um9qqnxx+1o3p/ugM1Mb8tNmoUmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3b9HTkFI4HqhSM2LORSKbBqDWD1HFZKzgS0PTNlVFQH1bI2q4
	0V0tN5XKobg03TmpL9i9B7rTVNoqrwp9SX7pkvrwjacWMAOgq85FEX46+gFwNuiujZyhnh2KXIU
	5ARCx+Q==
X-Gm-Gg: ASbGncvLZV4Ub5zOVCt2Ql3ug0rSlFmtkkiix3jgOEH7h7iq3vr22ZRhFL7Jis6xsVV
	huOO3icF5qfy6po5br0D++wKIwTz3+lTNxOYxOzFROSSq6kN99QTKm+0HJAwM+sXm+cquI9X45y
	xRS01wJJry9yzFeqiXgCmy1+wKEz2ZsMbKUsP+cwlhDxsbj75Kb0PlwVSxhEPdopFVNZiyNl7wE
	YCO0zqdPyWHCFNPUlM+nYWZQ+55NyMpMj52r7S3MfMNS3vZJrUa/7dpoUQMTOBpN3uRogAEfAvl
	SO3MrSZOozsbqeQEnG9TvwIq
X-Google-Smtp-Source: AGHT+IHT/RA6ksN7JAktBgG0Jsk2AwU5lP0tuXpsLPqk9OCeawWS/FsrKMdnlua0E5/Zsj0lshioaA==
X-Received: by 2002:a05:6402:2687:b0:5cf:e28b:147c with SMTP id 4fb4d7f45d1cf-5d080bb8411mr1225879a12.11.1732660862607;
        Tue, 26 Nov 2024 14:41:02 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3fcf86sm5506283a12.63.2024.11.26.14.40.59
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 14:41:00 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so998814766b.0
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 14:40:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzojdeWBx54CchXyEbRXQa30I46yWepRXtoDJ+frVeqYjDBytvbcTuF3+cUYOmkiMAHM8=@vger.kernel.org
X-Received: by 2002:a17:906:3090:b0:aa5:1ce8:e4e0 with SMTP id
 a640c23a62f3a-aa580edfc21mr68092966b.10.1732660859315; Tue, 26 Nov 2024
 14:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com> <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com> <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com> <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
 <20241126084556.GI38837@noisy.programming.kicks-ass.net> <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
 <Z0Yz6xffDjL6m_KZ@google.com> <42ef4bd2-0436-4a1c-b88c-73101dbbf77a@intel.com>
In-Reply-To: <42ef4bd2-0436-4a1c-b88c-73101dbbf77a@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 14:40:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAesttDd8qj6m9Ns-Xz6+44N4MsOnyROw5YzzhV74W7A@mail.gmail.com>
Message-ID: <CAHk-=wgAesttDd8qj6m9Ns-Xz6+44N4MsOnyROw5YzzhV74W7A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, 
	linux-trace-kernel@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 14:32, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> BTW shadowing of the goto-label is not a -Wshadow but a -Wfckoff level
> of complain; I have spend a few days to think of something better,
> including abusing of switch and more ugly things, -ENOIDEA

Yeah, I think you need to do that __UNIQUE_ID() thing for labels,
because while you can introduce local labels (see "__label__" use in
the wait macros and a few other places, where we do it) you need to
have a block scope to do that and the goto needs to be inside that
scope, of course.

Which I don't see how to do in this situation.

        Linus

