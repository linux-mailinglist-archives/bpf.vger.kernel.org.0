Return-Path: <bpf+bounces-64456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57FBB12D1A
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 01:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8E317CE9B
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 23:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5978D22CBFE;
	Sat, 26 Jul 2025 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eTLtIXgT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28922B8A6
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753573074; cv=none; b=OaHlB4JxVfoLf6UmabYEAOG7opvWDZLjYqkpUzebJp1zH6RvJLJJj9IpyzxNxwjZiGpUtwo1LSyyVUUDRnDcdu9xtROsrvNA48r7+7rOF+ZTmCaYuQqTUZ4qBgckl65MZ9dh2tBLXEC7+VriSYRd4yv31Nmb4hXTAJG+jzQk7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753573074; c=relaxed/simple;
	bh=7B24QJDsbG9O9xyrIOj7H/k5Wjt7NkdzQ2ZYcADPiko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQbknXTmRx1uIsMnN9F2yOMbFt/xCfVDPe/f7IFhSehY470K1nXPAqoA2PCHZU8TxjCjB+LtI2L5GkVFN3SLJ+hZJM8yxNDv1J6Lhq5CE+VoAjvUx+acpGwwMmW2noyytiHIfBJR2q7UqWTfcy5ab3pNgSUcSeYgArWbX3I0O8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eTLtIXgT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so5444083a12.1
        for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 16:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753573071; x=1754177871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=eTLtIXgT0zbAfXDRgiRTBv4ioN1hvrP4L3ImXMowXnQYMmK1QSZmAjXbhCEFTdXOl/
         /GJmCRliQD056zT9kndf+Rp2cdmHgFIk32h6uXtxTqC/K9PediVqd7r8GY/V6vitgVWM
         7Vin2WRj12D5Zz7ws8u9Cb9vHk6ehzko0+1HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753573071; x=1754177871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=OkaMlVjlnXXh/MszLDDO8cQD++Zmbm+SAKijZs5QZd7EsVjVIIAxcGajc8CcYXDTDX
         VjEXH/VMIZzT2FQkMOO6sdrZk3iA4J58JYfthTiJnNZngKZnpGWsgYk8c7v6lc1TJ9Ac
         +55WFuZm1edQMaAOuseA8UoKPmIQTQnGFJmGhVPvOlb9uC63P7Vsymtvpdhb84zmXvU6
         1dqH8MvlbryczHp563lTkl8Yb4UoW4uk5rsSf8i7p4+agGllbI+SgouZY+cijAiX34YE
         e86atAa+GVEelv82o9mHkABUcJ7wlU7mth5kY87GHaxcjWiYHN5yz3cn1H83Sj6mT3lV
         CYTg==
X-Forwarded-Encrypted: i=1; AJvYcCX+38nhYulhr+gG15hY1/9Ff55I5MRdbBL34QOwIO3WevvtGHj1O07wJ4L7C0/audhS2YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN41hmYN5ZAQlKjkWH+AekbasUQf2KzPhPS9kUJSwz61lpygDu
	7ONRSvITrzjC0n9WUnFmRJH7SsHVTzpTCRkJO5LelDi8vTbtuiHX5LJTNJs/FDLfnwrUT9wXnGu
	nT7NAdg2tFA==
X-Gm-Gg: ASbGncuNiuxqO0c8bQjByzN7tWSxHufJH7iOlMcNTMbo4X64QujGfAH5NNECMlT3XK0
	zmxWnJCUZLBNhlLH5q1F0xO4ot8CdOI9FtjYEetjGUMyRNIQ3FsbJYaGTHMLOD4Vbs3EDHHpU2y
	v3AZ9V+ur1cpG5YLGicdWrG4nFoeITAjd8MVTm1aoHa1XSN8RcHS1bsOFknjN3i23lAnDaoDnrk
	llvMvCbjqO+hPIEJXF/qcRB4Z+U28e+88QWhwzkc46z1rqCBaxtnE23B03EJ+Q+FIYr/eWHFo4c
	l7DwXjgTxLkL5IjffvrkU4qauIuv4KbdgG3swgHWanwJw1bPz21KuUR/HQvgTSAl5xkarhFBMOZ
	RNsfaT8EbNnNENNtVbKuPkdxwakNE6jGIdM52TZDuvoQ5ftciW2t3VOcqqtM+JJPkQdkNIi57
X-Google-Smtp-Source: AGHT+IG24cKFfwtpGOqBCOt9iZV25P8tm0BgvDJdPm5iDHaaKC3XdbVV2D7MVl9Ip6CLMEMpV37nDA==
X-Received: by 2002:a17:906:fd86:b0:ad8:85df:865b with SMTP id a640c23a62f3a-af61e14609cmr698836766b.33.1753573070798;
        Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635b02a4fsm201179766b.137.2025.07.26.16.37.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so5555773a12.2
        for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQ76CfBT5Qbv6aXr0FrmniZiXa/tkxuf7tVmYJdP6juLxaRXW2AwAMCNbyj4qTbOz+OIU=@vger.kernel.org
X-Received: by 2002:a05:6402:483:b0:611:f4b2:379c with SMTP id
 4fb4d7f45d1cf-614f1dced8amr5514831a12.20.1753573070075; Sat, 26 Jul 2025
 16:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook> <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
 <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
In-Reply-To: <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 16:37:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
X-Gm-Features: Ac12FXwLhT2VoOEv9kNeOdgouvN4zZ9YLvHzVMPIsLMuRmQFnkSkLFn13r5tjO0
Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Jul 2025 at 16:19, Kees Cook <kees@kernel.org> wrote:
>
> That works for me! I just get twitchy around seeing memcpy used for strings. :) if we're gonna NUL after the memcpy, just use strscpy_pad().

I do worry a tiny bit about performance.

Because 'memcpy+set last byte to NUL' really is just a couple of
instructions when we're talking small constant-sized arrays.

strscpy_pad() isn't horrible, but it's still at another level. And
most of the cost is that "return the length" which people often don't
care about.

Dang, I wish we had some compiler trick to say "if the value isn't
used, do X, if it _is_ used do Y".

It's such a trivial thing in the compiler itself, and the information
is there, but I don't think it is exposed in any useful way.

In fact, it *is* exposed in one way I can think of:

   __attribute__((__warn_unused_result__))

but not in a useful form for actually generating different code.

Some kind of "__builtin_if_used(x,y)" where it picks 'x' if the value
is used, and 'y' if it isn't would be lovely for this.

Then you could do things like

    #define my_helper(x) \
        __builtin_if_used( \
                full_semantics(x), \
                simpler_version(x))

when having a return value means extra work and most people don't care.

Maybe it exists in some form that I haven't thought of?

Any compiler people around?

                 Linus

