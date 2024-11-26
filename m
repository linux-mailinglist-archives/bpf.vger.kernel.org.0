Return-Path: <bpf+bounces-45633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0BF9D9D35
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84542283337
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1BE1DDC01;
	Tue, 26 Nov 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gXpmrlNF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4E1DD525
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644847; cv=none; b=Bf1Lgxlodq59F8eRqJEsoesbCdKhe0KtJnGQQBcRy+3VEqq/aEVMreqVzFwdMRDX6nPuqlPlDSGC6D2RCJoAaVgW4Oz8pjZm1YmAi/lD7jvn6YI5mFov7kWLhJspMNEZKRTntLndZLf/wNadLuJLmgvt2vWRkdILwoPvGr8qJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644847; c=relaxed/simple;
	bh=4wpJhlYdPmaupiMAB3djRyWBKlzCNM61MqWp9mDP/DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHZZOpVxdtcJugIRnFTa1W2hahg7z+zcP3N+CEqKu+ro8SXAIMvBgl+tFhx6nn7wOOC6z/xoddmAmHNIpHywXiUORk3wIELX2O23e7fT78M6L8+z1yJDQ64kHcwOcKWkfXVL2SlVRcP3P4qGkOVMlI8oQrQPaGiUp9l2Y0J4+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gXpmrlNF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso64893611fa.1
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 10:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732644843; x=1733249643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNamshPaCUTPte8AHmdb3Dr6lmIGJc8Mesv/4U+ExVM=;
        b=gXpmrlNFkianj/fnpR1Rbp7gzfbBxwA7QjUMA79XltjeBlFMK0d9db9T8EtuBi8A4/
         vhDg5sATpOtRpglvuN8hYEk2Pf2Qwl3YbsWY0t+F8y2YfgjIG5BxTCwJe3fY+1ie8B1f
         FtCwIdA1rmm+id4ebuqnoQy8YpH7gvYqgQcjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644843; x=1733249643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNamshPaCUTPte8AHmdb3Dr6lmIGJc8Mesv/4U+ExVM=;
        b=ub8z+3Djpaa20pRySs80yPno2D+9yoScd5C9nG0vclV/CWPyMMjEs+1LoZkRkYtVAm
         7QnvzPWuHZVS65s0icYzx/N14VAahyCScirW6jLU7rI/DQpKHeVWhAuCLw9QRwmb7cjg
         sXNZzkYTDh3i/yuQjDhQwKxKIIHSW3upIXqz+1CseL0/V+Dci/xl5z1jkUphhF9urEql
         vMUMaS9VbecyycR6ejKFXsVwmPe73idK9hV3RYykZnX2aSEBSwznfhigl3HqLlXfoJSs
         21+yUn5tTT4mdydO6Q9+kJj0O0X5+TPW0zV0CxE52hbhW7sceWKJNMSCfX2b1eiM8lok
         xV8w==
X-Forwarded-Encrypted: i=1; AJvYcCVrbSyZEwvvWmFLJmFbec2aBE+5F4cQjitTSk7Q143czuKZ6EzVvivkA8vsabHBmdvWfRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlu/jMdEQHIAY41hUwW6X6FYGJ4GiNcLm1HUc8F/CAOWnck/hV
	NzMaVfieYP2bfL7HyJFFfHyTjCJvnH3GDLH4C+kMTaUJYnJruiwExeTjSjPPOpS3RYihxk05/5h
	fN3U=
X-Gm-Gg: ASbGncsH0k2Y0YbPQAKeV0NVf2qeCGDez6NTP2dAtsbzoB88d+Ljm/NoIhDwR3r53mQ
	+bj/b/vpODvJC9k79tlJPjvE4m/qbZrLABt8PA5VvHP2oM64JA6F0IOVhJ4i/lSN5tsAplUMVUT
	7OWX4WzyTYnyQotH8cPRDgzKRMnfSOv4mDXfV46rUO+NbpUzdQSIzZIPuQXkFlop/CfldgJk1Bc
	XVkWxdLDm0Xf7Y7piLDautIWYQRCyUz9tk/4QEXJcTWQGG13Go/WyO/RH82/+hWZmGMClrNx4OI
	kixz9JlLmjnPFvF0q8ECMXAS
X-Google-Smtp-Source: AGHT+IHa/r6BbvZUBLZS4e6y9j8ddjiiWfsjDCK8r7NZaXl/TVCmoEGFnCX2t4JdtIeD+GseGuIY2Q==
X-Received: by 2002:a2e:bd83:0:b0:2ff:c4a3:882a with SMTP id 38308e7fff4ca-2ffd6059f80mr323571fa.18.1732644843257;
        Tue, 26 Nov 2024 10:14:03 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d170cesm19275261fa.1.2024.11.26.10.14.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 10:14:01 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53dde5262fdso3911123e87.2
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 10:14:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdkRT+y9qaHIBuIKZSQ8zcZ8vFKUwsLljO1iOTTL4cnxbl1wOGram/YKTd8esYifMZ8A8=@vger.kernel.org
X-Received: by 2002:a05:6512:baa:b0:53d:a95d:982f with SMTP id
 2adb3069b0e04-53df00c78a9mr44040e87.5.1732644840155; Tue, 26 Nov 2024
 10:14:00 -0800 (PST)
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
 <20241126084556.GI38837@noisy.programming.kicks-ass.net>
In-Reply-To: <20241126084556.GI38837@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 10:13:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
Message-ID: <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
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

On Tue, 26 Nov 2024 at 00:46, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Using that (old) form results in:
>
>     error: control reaches end of non-void function [-Werror=return-type]

Ahh. Annoying, but yeah.

> Except of course, now we get that dangling-else warning, there is no
> winning this :-/

Well, was there any actual problem with the "jump backwards" version?
Przemek implied some problem, but ..

> So I merged that patch because of the compilers getting less confused
> and better code-gen, but if you prefer the old one we can definitely go
> back.

Oh, I'm not in any way trying to force that "_once" variable kind of
pattern. I didn't realize it had had that other compiler confusion
issue.

         Linus

