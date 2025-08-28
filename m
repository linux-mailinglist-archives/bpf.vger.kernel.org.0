Return-Path: <bpf+bounces-66884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C43B3ABCA
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776BB567DC3
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA02C11DC;
	Thu, 28 Aug 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CR25SVWl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55711298CD7
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413536; cv=none; b=B8Hs0JuLDKm5mOKEudg+WLIAJwfxO1ypqbUKQY7zyz6L5ByQbH1yOBU81G3qqW/w789tiHFVU92YvVrvTUJHQ9P39uArmO01INxcnPW3Ls3ocojjSBfqJzWcMzaOrAN7Z4Y9Udv3dGSBUAwBV/Jg3vQfyTCFl5InMas6PwwKm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413536; c=relaxed/simple;
	bh=hNgqbG4EGq28u1EQouYSBUbpkt0arWTr713X7x0bHTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1E0fCrJFuf8z3sJVCld+N31qbfnSVlOEblhubotsO0ajBao7J6MmvdULM6Vu8e6zxoqnpS7IhH//TtFSEmglB+zCstU2ow93lDxe/9IRkeM98/sd+Zi+VzmerfFYTf442pa/289VfP1Tgvk9/5BVxOXB8RrDyttE+nzzGnyN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CR25SVWl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afee6037847so195835066b.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756413531; x=1757018331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWiKHYlJvcne9jpaEYcqWHC8AcX+j8YMHCgi+HL4MNQ=;
        b=CR25SVWllkSsQngPZ/qI1RjWfYWrvLm8VbzPm98VzjwaLjdRjNwDd13FTpR2RX7pGg
         mPFA3EpJxQBjP7Tx3twUGOkFyDt7c6lozMJnCWiFxP8VsWrGx1D0UKnZ4ZzchndZ0LWG
         wPQnNeB7izcMgfmzzXMqDh8Qganz7MjmOuOaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413531; x=1757018331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWiKHYlJvcne9jpaEYcqWHC8AcX+j8YMHCgi+HL4MNQ=;
        b=Ygp/pNPNYjyH09LQTSepYToqq2ThHLi9lp0GbAgamggu1tkJSi9FSNv/yYG5XIubPT
         AucB2cQPgP1B9sbIIC08wmN3K9YDUOzA/PvPExfIneYlXdSTV1c6EYHupi9722JncL+Q
         u+il6qBKY9fIUMDvWxxL1UBNvFKz2wCqH/Sb8Zlnz4YjgN8m5jKPWQIEVT6AEpQZbq4T
         /CdjLJ2248ymSLWwXPEJt3+k5GX4wkO0nb9Xx7jut4ibQgxniwOLFIF45jVEJ6gXZb5M
         BvtaaHBwYU+xU2JWs7BP5Yoc2Qe/dav9MsZ0SLyvUhr9uyoTnIhpKzpyiqYCkkf8+lN6
         Yk1A==
X-Forwarded-Encrypted: i=1; AJvYcCU6HLPIKsnwaz4vT/FfSUjpsi5n44AIPF5ypB277Pd6I90OAihkcznUWruHdSJN9mBzj/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOT14L1UAiOMPDzrisCE0K8uy/PProyFtmU5mPBe7KVH86l6c
	qtDJDN9JRfjYFCej3ye5Ja2+dTZ5yA9eqUVSHytpkheMutiIB0m+JI4gfAyloe5OyZnaw7KbtEh
	SuzzoTn8=
X-Gm-Gg: ASbGncuYx0PPqDlCy2JJlCrZ9dEZpCyuUxEOF1dNcxUQIarU8f5f8XobjUEEqyf4qo5
	b5xtG3YvROJB/CQD/cnyF7BUJC4uWHiB4C5jOszyB0ellmwiCP0076cvjdmKtI04lGMSnbq2Zua
	4ExSs9DigxJKf7JfsgW6UPhZkDy3jg3eWd98eW6xzsNN2RQb8zV/aKAJpknSC6grnRo/zZe2vnj
	mSXtejQN9cm1Sv8BpkFNmh3RiB+lf9mBEf4Q4jHZ2kaw0c6LHcbtdU8i3SVlcrre+EVW55R+MAZ
	lNhhpCOjZvttUGNhnIfh4+ZMZTfl7fQVKYF91eLcC0vy8kUYJawzS125QliuyA+fyKfNUWax8HK
	wViaspkRI4FlVJb01boTAVUYDmJl8GWNrOhcDd1vA+r5Ph+70pcEO5bP0h2oVadMR/wJo1lWf
X-Google-Smtp-Source: AGHT+IHXQkexsdlKkIheygmLsJ4x+w2kYwBdLOtRsFBlhfnVpIPpzXsDWIudtugUg5JFDQlDVB0CXQ==
X-Received: by 2002:a17:906:4fd2:b0:af9:76cd:d836 with SMTP id a640c23a62f3a-afe28f75ceemr2195825166b.13.1756413531485;
        Thu, 28 Aug 2025 13:38:51 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca08b17sm35105966b.35.2025.08.28.13.38.49
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:38:50 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afeceee8bb1so203999066b.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:38:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWUzUa+hhIbz6Zm+UVb+Vh6VYnNJ8PYcbHVdTFhifCfJCthKsddBMfYfmqiU8j7qPxpv0=@vger.kernel.org
X-Received: by 2002:a17:906:fe45:b0:af9:5766:d1e2 with SMTP id
 a640c23a62f3a-afe295f1a73mr1975930266b.47.1756413529327; Thu, 28 Aug 2025
 13:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home>
In-Reply-To: <20250828161718.77cb6e61@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 13:38:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
X-Gm-Features: Ac12FXy_trL7Swvm3pmfwOKxyHb_uZ8GQJCJzY2njmQb_NBdcNYF0cJIcpF5WXg
Message-ID: <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 13:17, Steven Rostedt <rostedt@kernel.org> wrote:
>
> >
> > That should be simple and straightforward, and hashing two pointers
> > should be simple and straightforward.
>
> Would a hash of these pointers have any collisions? That would be bad.

What? Collisions in 64 bits when you have a handful of cases around?
Not an issue unless you picked your hash to be something ridiculous.

               Linus

