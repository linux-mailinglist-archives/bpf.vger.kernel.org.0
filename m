Return-Path: <bpf+bounces-67007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34854B3C125
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC927C8040
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63532BF55;
	Fri, 29 Aug 2025 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X3pZ8Mmf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADC1D5147
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486234; cv=none; b=Dong6K8QQCc2t6rwX0alrLhCwTXoWvgiNezLZcdELZFzoMPv9ftaFu9sU5qUjH9vutolMeqB0arP0IVBDr1cGxyWfDK/gTEqOnH4jpGy7H5DtO8DFhXW+PIJjcQbxHxXny09E/Oo2AWzeVeB8RzDBYmS3bHE7isfgO5tI+TIrMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486234; c=relaxed/simple;
	bh=h7kL/4uMpyKF5NccHp4ZNI0Wmfvu40JouRjLRpItj7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GH8K+oTxJxzFk4Fc6//lXkCUo91/b2n761GmeFaeWXi9plBnqw847X7JvLDwwEWwgrv5k/6SoAO5I6au9j94eXRM6qwBgHk0bZDbdyPV0B0//6VP9vZANqyoZBsYCZX1Y07TZat5IQAD8HbaDTNxjLMJlP6x8DBkiTTvttoPwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X3pZ8Mmf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb72d5409so398247966b.0
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756486230; x=1757091030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YuhPIWx0Vj7KfkidRYFQ7OP6ebYW22eg0BlKIYspAk=;
        b=X3pZ8Mmf041jqiE5y1CcmG/rALrO27jmWfiS+mhVx6viixq1hOqgXb8ebyVp5Eu0ON
         6wix6Bn2qTSI5ChEu0ma2GEtZ1ojmiJlcQApVpNkfXdtMx52+xm8RiNU7AJXHSNoaG0h
         l8a41rOxPmogukZL/ks+kV58sGpE8zyjxJ+BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756486230; x=1757091030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YuhPIWx0Vj7KfkidRYFQ7OP6ebYW22eg0BlKIYspAk=;
        b=wdiVHqUP6qPKsKu17rCEhscrb8G4mKJNjwLytfhfDnm6zYS4RTcetgTyTz7hbzGF0n
         t/9QqIy0RX6vFsr40776ej8/7qRTIAzD6rRgyXmdp6XyWfckJXgCsDkWgpZnizJGIBVf
         Sv04vdFwMctmFpWVTXKfs9ZlVbu7vQMskjVXrJ92OI3kxmwzCR0LQdYEsyr1gEAuoL8g
         naQ/fBAggK4Mi8fXP0M1rK/4Its6ujo6d62E8NXyD9YRdQ9thH2cSlRWL0fDyPDGlkvt
         f3jqQ2qH+IA6rwkZlPxrkaU6KNaSZ66aE1Q+nCnnvcdnINxcqv4sq0dllEF7ng6EQaW6
         D+qw==
X-Forwarded-Encrypted: i=1; AJvYcCV1DvCM5tyMXdumBxXR4p/6G/wkCW0lhOHdW8aHO8uVgLXf3xWk3zQQP64zB7Il86egZqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8btDWRkUjJYuxLqNWrxi3+xRuQ0ghIxtHpOjWPkF0bxWGQv3Z
	7sEMgr1mSi7TQtxkc0IvjP7+d4v0UU+Y69FtAggSh/5HXmKC6kVgbi7pW7Z6mweirLXs2wRnpFb
	b95x5H4lsmw==
X-Gm-Gg: ASbGncv40CPlS78JW7lEYDDnkPvi2THaVNsklx7bk8PM+lziCEWpbMUx7NrUicDvBfg
	QjQ9fg2Qed1h9shhi8qRnDmvm3eIopLZE1L2/vGar8uh9A1Cz+TW/Uc+jie9ym5p1dxN3vhRlNJ
	PJ5XPyCG0fvl745GY63sh8jTUk0zP6D7lYLYdbhkkDzjmYp2VsUPH1rGdPH+zW+aH0TsjiOdRqt
	HXhbMg/LY6PIlHc8kK4Z8JsUJb/JjRqkzZmQ1af9VvJPLqSxl4Uu7/Ynz0SRtD8yyOj14hZduGO
	tQxnXw1YpbBp8gb9DTnIzgcyrpve7cezs3feL1Re20+a9GOyqqpv11vMubGdv8AzIvIuW4snLPZ
	vWvoH6c8mdDO0+I1Xx/N4O1yIQJ+hLgK+d/Spaq6xlzfDZg+LRyvmtVRhod4nSOVgmMavzj9aP5
	GAJH3XNHc=
X-Google-Smtp-Source: AGHT+IGpkm0n8e52QMv9E4P6rniFZTo+GIIr8tuuBiP0YEBkMwVpttVAfQGjp5b2QdM3x/Q+JkkmHg==
X-Received: by 2002:a17:907:9281:b0:afe:a83a:87ce with SMTP id a640c23a62f3a-afea83a8c21mr1388735866b.2.1756486230285;
        Fri, 29 Aug 2025 09:50:30 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca0f238sm237395966b.43.2025.08.29.09.50.29
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:50:29 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afe84202bc2so345428166b.2
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:50:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrHXcweREbPAcQWvU34HCf7eHacmjbVlM1D0mJBeNd5Ts5PJOQ3YfOyldj2G0xQhx+P9c=@vger.kernel.org
X-Received: by 2002:a17:907:d10:b0:afc:bcfc:b3b7 with SMTP id
 a640c23a62f3a-afe2958afa7mr2671499166b.38.1756486228847; Fri, 29 Aug 2025
 09:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
In-Reply-To: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:50:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
X-Gm-Features: Ac12FXwTdaKGwKQQrcvfZIpWu9JvQChz-8oubMdWokhEh6BbzzxHD6kJcwqyw4w
Message-ID: <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 09:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Just use the hash. Don't do anything to it. Don't mess with it.

In fact, at actual stack trace time, don't even do the hashing. Just
save the raw pointer value (but as a *value*, not as a pointer: we
absolutely do *not* want people to think that the random value can be
used as a 'struct file' *: it needs to be a plain unsigned long, not
some kernel pointer).

Then the hashing can happen when you expose those entries to user
space (in the "print" stage). At that point you can do that

       hash = siphash_1u64(value, secret);

thing.

That will likely help I$ and D$ too, since you won't be accessing the
secret hashing data randomly, but do it only at trace output time
(presumably in a fairly tight loop at that point).

           Linus

