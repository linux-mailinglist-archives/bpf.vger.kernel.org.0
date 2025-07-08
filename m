Return-Path: <bpf+bounces-62694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED4FAFCFCA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 17:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA61516913B
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E302E2647;
	Tue,  8 Jul 2025 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ef4TnyBY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C62E1C65
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990057; cv=none; b=FPcXM1j8GJgfGoFofByEuhedP8zoSuxpj1e0201mswJSAzE5OHIU01vE0PdNZgYZxusi8nYEpbwBGmNqvz4HRSu08psLfPlhXpDFIsm8SMue/wLvYE8ZzYvkMUvzB80fT+o6/xl6C9He1uUuDA3+WAWcdh/0P8c4IxfTXCTajsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990057; c=relaxed/simple;
	bh=gjZLHGLmfbVObDGOZ4Dg5r0jve/c3K3iH7rC6rix6b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMiI6cPKlNEx2UkI4K0rfkiaRRo+epZWAeU1fnNSYxdzEFJrWK1k3tYutsm8JenuYAOyXmCzstEggTJJYSFrtkJwTdzb/0IwoShnjPwTux726LiZ7dIXQ36fNQzls0LUr+18yD9AYoa+T9z2BgoI4I0AKUx/CHSG1SBnL9jhzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ef4TnyBY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so8469562a12.0
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751990054; x=1752594854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JviNfoY/DbOqb7IBhvcbJrjlb0wZveDxGuzjGFCnAdw=;
        b=ef4TnyBYTj4iDNrEIclbT9tK1giFtWOLDdEwzLM1+HYwwUHO9PyEMleMNFxSIxsmmv
         lUovRuQd+9tWda/QsNynUMklonaEFih2HMA89xSx7CBvZ3PHAvkuIaddqAolPfSspV8N
         B8jRtLcOn0qoMVfPH2sWThM2yJY187m0krAnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990054; x=1752594854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JviNfoY/DbOqb7IBhvcbJrjlb0wZveDxGuzjGFCnAdw=;
        b=pIJQeWSZ/Fpxx5jGkpjHaECfY4334nLtVjPnGC0kd4ML8BfhLKmjcK1kSoR2MqehKa
         ubRARg6d1zjrVfYZiEsOhVXUc0XuVq4BrhM+x+4itR4ZhGuogAjqOAv/326yW7XRUYZw
         9qivm/itShWJE+y/7MVSO0pvBfj1kLunMtLgTaaBvXhaatju2it58uDvyWOd3XVN78Jf
         h9QzomsGt84a/tVY7msBQQlctirgpa9D2SS83KwSra2NBuIwBD3o2e7PC4SjNRdipgJj
         rFEsUTEBae3Q+y+iKPN44U1sJqsCq+P4BgY/+MlElxczBTEqz/rGsgzyR4hdkX4a3ZgN
         F13g==
X-Forwarded-Encrypted: i=1; AJvYcCXRASudSmhPCTPTY5oJE/Bx3ZQq+SdvHkCMQB013zJtwXN8mHBvoBzxk3ztlQxVZT1vO4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS2utwWRkZEaD+dEm0QB7LYqCIwAEVBqGFWvNc5o5J3MEMEx80
	8h9XCQgvGixSE6dS4+rQcsYPC2Ns/ZtUzc/UWAircaiXRPL/ixTJ7PZCxApLDoR+RriXTiDC57x
	H6+zapE9Ftg==
X-Gm-Gg: ASbGncvvH1/e7mIRGIASBb1cnVlkrkzVuADbiyiV7o8cwodUDGXaUojYFotVrc6x7T1
	f+/Hzxeb1XDBlM/5doXfrF68Xy8m4ev/B+hQ4nhzn+Ue064I5tr5zqVzSVI430dGpz5p7lqsnMV
	vuSHpwNEQC3FXU4BQgi0fkt81HygHittTY2Zz6FTOmydO4H5fNimh2oXI+ldgGVXC/Mop8LnOYy
	b1GhnaTpYP2O8CjaoMOt1DhY24vIbmLZx0Ssso9+h6sqwViMe/+7Wk8F49lWW7w9QfKuefanHu5
	Ai/P0Oqq0Tw0DBQNKuomObvg7ItTzng6tJx0KE0LQXXjNiPVIBNveLUM9aUJg8gQ+CHD4zfcM0q
	I3bTRHMIk932aUoVLaRV5HIt1EVXvyabfG2sS
X-Google-Smtp-Source: AGHT+IE3eQHD954+PEaxKN66+PRSLh6fA7e6QBqDKrhylsHvI1vkw1S2vyV6//RnBZ3DohLJDKykYA==
X-Received: by 2002:a05:6402:5206:b0:607:eb04:72f0 with SMTP id 4fb4d7f45d1cf-60fd6509742mr16105626a12.4.1751990053636;
        Tue, 08 Jul 2025 08:54:13 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1f7618sm7391785a12.55.2025.07.08.08.54.13
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:54:13 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so7398281a12.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 08:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxhBgroo/BKCEATIENlwybeI0R/BSxS2cbjiUk7FV13LAcenf7z1wwMZd1Su/ccywnApg=@vger.kernel.org
X-Received: by 2002:a05:6402:27c9:b0:607:f64a:47f9 with SMTP id
 4fb4d7f45d1cf-60fd65092eamr15258834a12.3.1751990052924; Tue, 08 Jul 2025
 08:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708021115.894007410@kernel.org> <20250708021200.058879671@kernel.org>
 <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
 <20250708092351.4548c613@gandalf.local.home> <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
 <20250708104130.25b76df9@gandalf.local.home>
In-Reply-To: <20250708104130.25b76df9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jul 2025 08:53:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXcc99EXKfK++FEQzMQc8S16WOwvn=1DcP_ns1jCCYeA@mail.gmail.com>
X-Gm-Features: Ac12FXxjWw7PewHMCf7vpGhvfipJRiRQXNVSUY5qO5rT6dy-QSSufIBM28NP0Kw
Message-ID: <CAHk-=wgXcc99EXKfK++FEQzMQc8S16WOwvn=1DcP_ns1jCCYeA@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 07:41, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Would something like this work? If someone enables the config to enable the
> validation, I don't think we need dynamic printk to do it (as that requires
> passing in the format directly and not via a pointer).

I really think you should just not use 'user_access_begin()" AT ALL if
you need to play these kinds of games.

               Linus

