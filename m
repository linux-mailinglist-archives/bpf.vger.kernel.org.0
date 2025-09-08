Return-Path: <bpf+bounces-67815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB84B49D7A
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843593C0EDE
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 23:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF630276F;
	Mon,  8 Sep 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B37s5tly"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E92F8BE8
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757374035; cv=none; b=QNrlEo3qCaW3/UT6odmGPBq2Tnj0VfhT/Bq2xRQDn2XfXgb4jfHYEAVZbrpTlU948I4rE49n8g3Qh76s/9ijJK2ZQvjChAIjw8gGj1W1rQ6a/tTOevX7SIVkwITHQ87lqkSqU0mAJC5Nye5HXAwD9bM9lcu+MZVQM4/MjY5V0HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757374035; c=relaxed/simple;
	bh=9j1F9Hlgq0izFEcvkNVfyEGzv++lE2ro3SvVkZ0AdfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVyI74Z5BCvrWyMvUAMTCUQJwGSBnwcIC6KfGcWURBpPE+Sl2s9PGc1Ro+d9eCAW36iuuuzrrERK4fEELgGab20eZQbVsCU92uTs8Pa5QSgE3cJyLCgm9Y3JDlY2wpDulB2VeNtJwt520PqxkOBLAnNE6Lucq6wjN0yU9VRPnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B37s5tly; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-623720201fdso5206109a12.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 16:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757374032; x=1757978832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsrp6f7rC2KY8hXQre2m5AM/+TH/nwxi0ROAfuOjXMY=;
        b=B37s5tlyjWLaZcRArjJg3ErLyl7tJr8WWnl9ecRj22Rzh6ti5AbbapWuLwYqtAZEBW
         9kGIvptJJSJpbIq5r7TlthoSU2kVgmIIEI0z9KJ+J4Sdy7qVDKJIeAkOcWevp1qs9w1r
         PzXQkEczFqSAl4rGulf6mIuGg94W7sBMIMA7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757374032; x=1757978832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bsrp6f7rC2KY8hXQre2m5AM/+TH/nwxi0ROAfuOjXMY=;
        b=cLe45779Fy9JONghjbh2h47UwmGLrR0KjHHOGtIshlhssiwtXDjk2/fRl6TIlKOL9s
         fNgzqtwVU97QzOaYIaKOdgE3iJ/fKxHkDaz7cyoLZdsI7/eww0Ny8y/33zMGfRktSTNp
         gCr8DuYj1Yx8qtYCzR+OlmHzOvtbwkiK8uJ0di/nnrOkkQ4fQ7U/5HOAD7vc0BarcMBX
         OXHbRORlFPMxQw9/5CssPmeZtmunMXiIdMkLNISqcEtNyUOzK5o0atdx+rqskRdZG8Jp
         kLym4DUZ5GU/U/5Wu11HJWceiXuGFx8z9Bl+4fIQkZtqdXm9mDHsV+/cN9zQNEZIl38Y
         eOag==
X-Forwarded-Encrypted: i=1; AJvYcCWMUVxzxprBQOs1K2GBMfvWm0Jn48rEORNiijq2H4ygYWCL4fPRX1hYxEX84VQsSzRydnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5N4ZK063bSHV1764Wb/vqeJGQiRYBSjSQY0nYfIAANuvgiAs
	9KlCTN0NXoR/DymdUe8cGMs9FdfNx7S3wsrwbp6CsOy3oFNIUvbP5qev+b7022hzhEcQLOaQtwN
	kc5uYc20=
X-Gm-Gg: ASbGncv26M5TEWAUu2Q5kbeOpvmcCMV8xyb29SL+WgSqYZhEsmi2QMN6C7fC4uOL9uy
	WnZ1/3biX0wqoJi0MJX2hOVXris86BA/t4JmB7AECZk2wlm+8Z6+9RwfOxUkMgxzElB1ySoEpis
	NKNQVucIIoCjRMB5yOEXY5Hg4yqdpecUgfH3EQj9OE4Pr0DKVA2+zcU+/DhkXgVJPLvQKecsf69
	lUFpB0b2naKP5ppmJ+GU0rIjnygmuuI7N4doN4zGLOqs2GQGeebE7OD3Jj/XFGah1y3Z6qmsBbk
	TCqJ3J+Jvek+4H1uqnTFDatg88cLpQ6ARBhSklBUKLXkl2HF+DgIKmk3yxIitQZ8g5Zj1Pnlhbn
	Eo7r6ZBB+lqlVcJk6TZY0Km43pvflaFnfU95qEdseCletRe82/GjEe0vebpcaIy61ttiEWhlWhZ
	96+KNVs0s=
X-Google-Smtp-Source: AGHT+IH/qRIdV/Qbw7Yhrb0nBG+8tRMFvjacB4pN6w7VAsuhlBl/CPJhdfThNPEvPFLoZ6WDKI3QFQ==
X-Received: by 2002:a05:6402:2553:b0:61f:167:7749 with SMTP id 4fb4d7f45d1cf-623725ed9f3mr9859379a12.5.1757374031800;
        Mon, 08 Sep 2025 16:27:11 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe99ffcbsm58391a12.3.2025.09.08.16.27.07
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 16:27:10 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ace3baso867211966b.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 16:27:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKhI9sjdLN4jHSAuG4XHWzNgYRiXpkUZikBwWzEnZQxQYw24Vj3Ru1h9pKf3Rm1L3KPc4=@vger.kernel.org
X-Received: by 2002:a17:906:f597:b0:b04:ad1c:59e4 with SMTP id
 a640c23a62f3a-b04b13cfa09mr966785466b.12.1757374027292; Mon, 08 Sep 2025
 16:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250829110639.1cfc5dcc@gandalf.local.home>
 <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
 <20250829190935.7e014820@gandalf.local.home> <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
 <20250830143114.395ed246@batman.local.home> <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
 <20250908174235.29a57e62@gandalf.local.home> <CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
In-Reply-To: <CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Sep 2025 16:26:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyry=1=gabJ0iw_HbqrHkg84gCvKQXi5Qg5u6pq=vwzg@mail.gmail.com>
X-Gm-Features: Ac12FXw_TEqw3uAfoUb6rds-8PBZlK9wEtfwraJcwLFCTgjp6oxAH2_abLFrQqY
Message-ID: <CAHk-=wgyry=1=gabJ0iw_HbqrHkg84gCvKQXi5Qg5u6pq=vwzg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
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

On Mon, 8 Sept 2025 at 16:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Make the "give me the expensive output" be a dynamic flag, so that you
> don't do it by default, but if you have some model where you are
> scripting things with shell-script rather than doing 'perf record', at
> least you get good output.

Side note: you could make that dynamic flag be basically "per-target",
by having the *tracer* open the files that it wants to match against,
and guaranteeing that the dentry stays around by virtue of having
opened the files.

Then - I'm handwaving a bit here - you could have some "hash the
dentry pointer" model.

In that model,  you couldn't use the 'struct file' hash, because now
you're matching against different 'open()' cases: the tracer that uses
sysfs would open the executable and the libraries it knows it is going
to trace, and keep them open for the duration of the trace in order to
have stable hashes for those files.

All the tracer would need is some simple interface to "give me the
hash for the file I just opened", and then it could easily match that
against any hashes it sees in sysfs stack traces.

The advantage of this model is that now the tracer not only has the
hash, and controls the lifetime, it means that the tracer also can
decide to look up build IDs etc if it wants to.

The disadvantage is obvious, though: this requires that the tracer
know what the files in question are. Of course, that's usually not
that hard. You might literally just know it a-priori (ie just from
what you are tracing along with having run 'ldd' etc), but for the
'I'm tracing a running process' you can use that /proc/<pid>/maps file
to start populating your hash information.

I'm *not* claiming this is a wonderful interface, but it's at least a
*fairly* straightforward way to give some kind of cheap hash ID for
the user space traces, and it puts the burden of "hash lifetime"
clearly on user space, not on the kernel having to try to maintain
some kind of hash map.

In other words: if user space wants to get good information, maybe
user space needs to work at it a bit.  The kernel side shouldn't be
made complicated or be expected to bend over backwards.

          Linus

