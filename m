Return-Path: <bpf+bounces-36431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5369484D5
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 23:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0FA281550
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 21:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E0516F850;
	Mon,  5 Aug 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dTZT/y/B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48D16C69F
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893324; cv=none; b=TrQ+dHCSkkeuMh5ymtyuCi1qn9lbI8V44oBr0OVknTftiKLROxxJzHvX20y6nOOMOl8LYxljLtn9gjYXEHP7rSgBqP6y4If3T3KzcJMWVRRBdEzRQuEWAkvpPZ5RMjqUQ1byJQlH8F73bTcJQ08NaO/0Kx4+//kA0csPgOGflQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893324; c=relaxed/simple;
	bh=CTTjcSVZh00GG8bK8bn079xIUwIcu3ks1xC9HUn/WHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnX65Hnqii4fmT82UCO9erH1tMiKRsDk6FSI3nGZJ8vQwcmX9UutA/FXAQ1avKD1GkSBxcgCnYStzR4Tplt2o8Y6tTYONXQ/q+IClaHtb8UcZEuMK9MbuDeno7wWsGfBg8YjyV610agfeWceNUuJH6qgDARhY2/fQ7UD3i4fQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dTZT/y/B; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so13546729a12.2
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722893320; x=1723498120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=dTZT/y/BmtXDpNcwqQMY3r3ejI4e59QXjXxyGeNXYZD6tW8wNuCQ4kCQQBZn0lvYBO
         DmXZRZ/73uIhMLyk1j5H8HTMiGkEJcEXqN1L71oINzOYy4qxj7xqtXPeA+horB6a5PC8
         UALAjaTOlI0ZqPh9wNw6eezhLySxTMLWvYomk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893320; x=1723498120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=Wjfrh/JMZ7GCelQHMiuHxw+mvQiWA8VZ+ufUDLulcSjDekqRg4rLmCGPBeBYPdt+k/
         W3jtStiQMq5HX993P21ByfPZdFrqmbFsrQu+tqrre2aBGZk01fw2rBtOxd55YdN5m9ru
         ctpdzsyjSWQGvYomZ5dJ7sGnRsLKf0FEw9pM3A/STc7IaH+sHmeOoWrv8IHry3Q+WXdP
         tpD6AsHiYnWhgmq4nHNlGnqxiyFDK4GniELoYHbng2U97Xl3iBpaDAcWDLLGvF7Ha333
         tskfaewxOOYAiYAeQ/8OGJR0vSu+9/hyBTfPRlOTquDeGW4htR2JIzvjV9dkaQR/d4zU
         LOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUunMHuAz3LqO0DHWkLybQOphVVrXmuFT1BVdprB6VycyWWMmyKL8Z1CiRScx4TkO3JXrurNFBuOlO7KaGBg1a8+fNw
X-Gm-Message-State: AOJu0YxYL2W3BbTQt/z7nq8d0JS2nWvESg6B7B1HdcXlr+vfGUpV/zXn
	g8DGbmtPXL1DaReElsBv3/DWit5LwX4b/ocKh8CPK4FsAm6ULi+otM4ooW2ZLUuq90z3PBhjfVM
	ikE0ozQ==
X-Google-Smtp-Source: AGHT+IELJtwI/w1l1yqWmVdnoSYi5QgcUAy104R0xcO5ybzuyS8JNDjaqwbARgIDWZ03h0/FGftlgg==
X-Received: by 2002:aa7:d501:0:b0:584:8feb:c3a1 with SMTP id 4fb4d7f45d1cf-5b7f36f8e9fmr9645703a12.1.1722893319897;
        Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf3ad38sm5327064a12.84.2024.08.05.14.28.39
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so10095239a12.3
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcQYGC1B79uNJy01g6KHMWNegsqnRR6tyXrpvu97mJMns9WA1CZ9/OoPTvCpUknyfzq1kjXSsRA2KZs5Quvc5L4r88
X-Received: by 2002:aa7:df97:0:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5b7f0fc7f1amr8956337a12.0.1722893319128; Mon, 05 Aug 2024
 14:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com>
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 14:28:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 00:56, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> There is a BUILD_BUG_ON() inside get_task_comm(), so when you use
> get_task_comm(), it implies that the BUILD_BUG_ON() is necessary.

Let's just remove that silly BUILD_BUG_ON(). I don't think it adds any
value, and honestly, it really only makes this patch-series uglier
when reasonable uses suddenly pointlessly need that double-underscore
version..

So let's aim at

 (a) documenting that the last byte in 'tsk->comm{}' is always
guaranteed to be NUL, so that the thing can always just be treated as
a string. Yes, it may change under us, but as long as we know there is
always a stable NUL there *somewhere*, we really really don't care.

 (b) removing __get_task_comm() entirely, and replacing it with a
plain 'str*cpy*()' functions

The whole (a) thing is a requirement anyway, since the *bulk* of
tsk->comm really just seems to be various '%s' things in printk
strings etc.

And once we just admit that we can use the string functions, all the
get_task_comm() stuff is just unnecessary.

And yes, some people may want to use the strscpy_pad() function
because they want to fill the whole destination buffer. But that's
entirely about the *destination* use, not the tsk->comm[] source, so
it has nothing to do with any kind of "get_task_comm()" logic, and it
was always wrong to care about the buffer sizes magically matching.

Hmm?

                Linus

