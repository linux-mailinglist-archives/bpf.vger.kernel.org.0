Return-Path: <bpf+bounces-60981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85893ADF52E
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 19:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CE140425F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3492F49F6;
	Wed, 18 Jun 2025 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DqNCnZ94"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E033085A9
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269166; cv=none; b=UBriWCDji/1jUTL3AL5xeU2q3pPlPv8WZthafkdOQjBKkWyDYjK6YRpN8Uc4cgPQDdhoGNTtLYIT+FC1XmCXhYYRlbnDE+AqLGCTKH5w+rUgoWyb1elZJk1qfGggSew3qVrHMIggjigkWluUWswHmkMiFzGKqxgX08cDnj9XvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269166; c=relaxed/simple;
	bh=y9H/LE+xIpHZ/6sGJEJkqEbtfi7uc50nx0i7lJUVD8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBwjVAQCCI03gpdpWdMJklqRol9Z2gWf4VAdTw3HNpiUZMPlQl4ZkNERV+iBnJP03GODPUU9VWZ5oCsWwZDBqfy8xDLyObXOP6eyjlSBsnPUvHRCN+bpaF9Yc49QAfuJZBDC48tNyNBTiroxtLD4StZrYLWWouG6fw01MawBB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DqNCnZ94; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adb4e36904bso1391492066b.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750269160; x=1750873960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kygiEEUFulB3nwwpk+ux/04z1+ZqdUaQ3pGhL4WTR/Y=;
        b=DqNCnZ94Z/il0GPjRQkFd0niZZ8DN2mhmADcVOUYhrbdi5XUdLGIhMfWLVrLwRk2GS
         /2PS/OBkUcD1ejiogLRtqP6yjEQ84prfKj+mxBfRIvcjTnO9Fb8+hzb247RNW6YpJ8WI
         ckVc8nYCiR+6U+vkRDuO/UhPoegsqQJJWn3rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750269160; x=1750873960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kygiEEUFulB3nwwpk+ux/04z1+ZqdUaQ3pGhL4WTR/Y=;
        b=WF7FaX2uNEUEl1n36l0kP5zktiSV9t+hCqx11tmCRVhEcohpPJf3f2py2qnn1FpIw7
         CeyuPFSaZe5tKSqqpTXQgALS0wQ880to4deHt+3HVA0L3dztQ0bYJox6EjlESaurLbGm
         8gyvRv2fMtMRRg/p5z2kraKM3F0BKOhee7rnJRYmtjWS68Q1ak6ETMwfqoK/QeHpVJ4z
         PFs3I5sUrIVWyJ0teb4R6kuYPnEScGWKDF39VabZZ//XqPx/E6QGs862FNb1AYEd5EP5
         zLRRTXUK9zJwemGXyjA8DyZJ5DjUKTrQK2Zbf1zoxcHfCVbt5nwE8VZlpXxEP1D7Us9t
         hk3A==
X-Forwarded-Encrypted: i=1; AJvYcCV0D6gqgns2QQ2YeHbIZWK0mk9XKK7tX3nQebRV29dfyfvVYB9blxNo9tT2AIHAHmiC/bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvskr/OXz5pZS/xQp0nA3RkcZN9Z2bHMS0PJJO6+xYgXgNe3ni
	ZFwV0I+khf4oY2bD0jMpwVI6TFxQGZ5jjwEJOLpQHx+Q5ZOFHSCyz/0gqlkPmmlTiBlHHMRZdHO
	+adJrF58=
X-Gm-Gg: ASbGncskYklIq4MGjsvVORn+ztgkakwAt95hdkPKoLW2cJPdfxJFV+n7rbSUBOh+6UL
	keHYiOACEFym2XMLvp3/EpJMxyApRpQE6PhgYrKmYiWeHOJTIrOefTw1PX0e25YsatQqb21lr2I
	Injet0rtC41UCz4iu1za5xJm7my70zc1IGj7lflYvqmWRb27/vQdQGJGBGSWXbEDCgaIXK2xHpI
	+AHaLjyRCX6hyGW+KeFFFJ0/am368xmyHQLy2deEEyF3exq8ea6TBnWkoKWZiuUP6oDif4PxqIy
	owg0voLFsPq5OA5KxcW29oSERhaAL2KJtWtQZ7ZRPMdebMX/Qk1AvJ0ZahB/wJ8327lGl+KQqQk
	KzqFrgX3tL1g3g/RsTX/uDn0A345TafpKh7A8
X-Google-Smtp-Source: AGHT+IFN0dYLYXIasQX3T5PG4yLT9WEBZh7U41H9ezgf1fd+r7vcNwT/0tHSKUdnR5pOFaanLEVANA==
X-Received: by 2002:a17:907:9813:b0:ad8:914b:7d15 with SMTP id a640c23a62f3a-adfad3ecdb4mr1910285066b.7.1750269160330;
        Wed, 18 Jun 2025 10:52:40 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae01288869esm245483066b.106.2025.06.18.10.52.39
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:52:39 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so14737427a12.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 10:52:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK+hLbRMizJAwdhTABmP9Uq1UyISMpnED0j694PK6uONp9c07Adi0TeSdeitDqDhTZb9s=@vger.kernel.org
X-Received: by 2002:a17:906:9fcb:b0:ad8:9e5b:9217 with SMTP id
 a640c23a62f3a-adfad60cb3bmr1891902866b.45.1750269159066; Wed, 18 Jun 2025
 10:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611005421.144238328@goodmis.org> <20250611010428.261095906@goodmis.org>
 <20250618134641.GJ1613376@noisy.programming.kicks-ass.net> <20250618111046.793870b8@gandalf.local.home>
In-Reply-To: <20250618111046.793870b8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Jun 2025 10:52:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGWM50Qq3Dgha8ByU7t_dqvrCk3JFBSw2+X0KUAWuT1g@mail.gmail.com>
X-Gm-Features: AX0GCFtVJDBhnv7J2rLeWOvRjD7ENnpnCnae_NwDFoiDlVyU_VzUYIzxqy3Sfo8
Message-ID: <CAHk-=whGWM50Qq3Dgha8ByU7t_dqvrCk3JFBSw2+X0KUAWuT1g@mail.gmail.com>
Subject: Re: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jun 2025 at 08:10, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Don't we usually shout macros?

Not really. It's more about "we shout about macros when they _behave_
like macros".

So typically we do all upper-case for things that are constants
(whether enums or macros, actually) or when they don't act like normal
functions.

But when it's not particularly important that it's a macro, and it
could have been a function (but maybe it was just simpler to use a
macro for whatever reason), we typically don't use all upper-case.

In this case, I have to agree with PeterZ that this just looks odd:

-       if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+       if (UNWIND_GET_USER_LONG(ra, cfa + frame->ra_off, state))

why is UNWIND_GET_USER_LONG() so loud when it just replaces "get_user()"?

Note that "get_user()" itself is a macro, and is lower-case, even
though you couldn't actually do it as a function (because it changes
its first argument in place).

             Linus

