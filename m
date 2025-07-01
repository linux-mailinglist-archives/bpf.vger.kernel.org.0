Return-Path: <bpf+bounces-61929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30DAEEC4F
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 04:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38ED189D68C
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323E19D8A7;
	Tue,  1 Jul 2025 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FoUNe/L7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C4149DFF
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751335595; cv=none; b=aOob7ZNcgyyqhFC3Rm/LRSSzqZcM80MlZ+8dxP03pdS/9FgKjDBEBS136k6PMv0F2MpyR9li23uv0E6oObgKXl6qg2JMrTAExRAG6QQJrg3bdc1B1Dab0PKNQo16FOmBSj2X4otM7bjj/if++GG8oWh9xXWc6SYN5qaJnYxGr/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751335595; c=relaxed/simple;
	bh=XrwXszs+4CKh3uvk7NsR2H8vx1ReZK1MCq5Q7S9Pyfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVqfjCEXMZmqcj45yOP5jz5LQgGirfRJrVq7XAc9FQNRiDbeFI5OmjSwaxFtKRV3Zc9XZNzJ7J3ucU++gAGFpxceDL8KsVhp/tikKRxi4Po4XbrbwRTC3be2bWej0icWnpFVc6vJPGz2DY/yIS5PME2vovGqwtpdQl2RsZMBNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FoUNe/L7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso4655389a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 19:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751335591; x=1751940391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fN4lVWlc90R79Gu5dER97dXUSpIGy23I1H05DCfQFHA=;
        b=FoUNe/L77KQY/JcKHutwuE216lXD2ALSlzoZv6xF1E8HCibUylC1YE+eiHLxZDZbG9
         siEPqcZ+vhBXNfwS4SKR3NrIMi6uAdsWKzzj8NO/7p/D9Dx8HzmeJRFvZsCoTUpZQSIc
         I2dPxkMe9tvrpttFpJfQtKJj9VGcBB6NjZ0yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751335591; x=1751940391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fN4lVWlc90R79Gu5dER97dXUSpIGy23I1H05DCfQFHA=;
        b=CmEbMVqpZZ/yPibmb1u70CFh4SE7LZK+RJe/Jpe15rois/NbedFZaOSejEYm13lei/
         QhTZjf9bW8hz4toGgrAZB7oVXi5m8BDovWbxs5S1b9+gKA1+WQ4faA2ugH7r/It1dDJs
         5RAiagsYtiiIZ1nPB8all3jbqApEJgnfSg7R+ea2kQI8BtfbzXktsO0uK1Cn5M9W03iU
         VDxlafm6lPM4v3aC0xEpHKjiXHmVLi+l5Hvb+547Gcq0sJjMyxq7IRJojJsIdqcZKpy6
         /PiTUpCoukVqOB0WnWTy/hg3+5b3mEFxcSlQ2aIWHmGm4BMPeA9qV+JgYiyJlx3XJdiF
         uB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2rWPWRavUukebcwhZOl2fGKFULrUol5J6bssMdru+0NZ+zRTEiC9zuu5R03X/q+Pmen8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6B6oVHM68UwEwNc+UFF/GLb3BT5JXyi/yrX6gF24I6WgMwiv
	R8871sqBGYiCXz8J3xnlRBN9PGFb+fZbHFEqKy9l2aZOpt1cxDnFtR3cD3Y+ydCC/NWOhUTSKlf
	nXmW0C0c=
X-Gm-Gg: ASbGncsgKGI5n2DVBPkQPXLE8nTmQnHKiuf4V4kx2gMcVsuAmIoxZKN8a14DicWM7eY
	NUoYkxwFw6qztEPw3FXAw50DJH20zTh9gsfNIFcNI88lyzEm6081l/+u3tq7sVOMZ7iFvH3Ihq+
	P7GffhC16YBXU7A4czvt+PKRBH+Ks/q67wio5/7YjCftqEq3/yYf+NhTqAMWd9xrpP1RjY7c/pN
	gEAG0ejh6lGGHmlKWBVNCPjTZ7rwgJNj0hfIZJAqoZGE9IqjcrtM7m6PZx1EJ9+ZJ1yUAUgw8e+
	q5A1MaYWXj3kMH6C5iqFeSzFe/voU3EW/MKxgqE1hHnRBV0AhOOrwfA1/D1kwEoGGsHGcwjZVlk
	wGuqd433GZJPQhrgVHQSNjeA9B/Qa1Jct5egbjBqgmHSyPDM=
X-Google-Smtp-Source: AGHT+IF1OgY0RpZK+vKfF6mn3GuwTXS537CLGfYiFXAvct2ZxA992TZPfm6DBgvDMhtw4zgn6HGgpQ==
X-Received: by 2002:a17:907:3cca:b0:ade:44f6:e3d6 with SMTP id a640c23a62f3a-ae35011fc7cmr1477317966b.46.1751335591429;
        Mon, 30 Jun 2025 19:06:31 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b06esm780528466b.17.2025.06.30.19.06.29
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 19:06:29 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so3341933a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 19:06:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdnM+q6Umuaj61S7NG67yiaeW1K6dEoc9kluRLd51WwpQqDjgZgy1VrqRgmZyEEKVysvI=@vger.kernel.org
X-Received: by 2002:a05:6402:50cf:b0:607:2d8a:9b2a with SMTP id
 4fb4d7f45d1cf-60c88ed9d2bmr13448124a12.31.1751335588910; Mon, 30 Jun 2025
 19:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701005321.942306427@goodmis.org>
In-Reply-To: <20250701005321.942306427@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Jun 2025 19:06:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
X-Gm-Features: Ac12FXyRoMfhGWW7-qb33RWCFdUsK39k_kEcOT1weCLo6TBUE8tUjRhvy0zUkHM
Message-ID: <CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
Subject: Re: [PATCH v12 00/14] unwind_user: x86: Deferred unwinding infrastructure
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This is the first patch series of a set that will make it possible to be able
> to use SFrames[1] in the Linux kernel. A quick recap of the motivation for
> doing this.

You have a '[1]' to indicate there's a link to what SFrames are.

But no such link actually exists in this email. Hmm?

           Linus

