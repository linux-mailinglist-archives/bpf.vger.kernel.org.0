Return-Path: <bpf+bounces-67063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDAB3CEE7
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 21:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77747C2EEB
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940B2DCC08;
	Sat, 30 Aug 2025 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N9xjW2FA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3D2D0C64
	for <bpf@vger.kernel.org>; Sat, 30 Aug 2025 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756580657; cv=none; b=UfG6SrZX97UUowgaPCgI0OcwBx4bQHwekayRN9P5+j4X7IIjKIYRL8zPRsgBmbOMaf8CroWG6A6RripHtwZj5Uu6hviZuXpzvGCe/LaGjpYmys1tOW0mLKpPQ+xkyBc92LxG2dpvkutTdQeoKONN+EY35D1wK/pBrVfOg2qgAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756580657; c=relaxed/simple;
	bh=APZRD3R5mQMFLWqOyeRR80xS4Xl7AJEaecu1Pv4PsOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV8msFu6L+1hjJQPZuOI6tVln7WGxARahIMXM3eHerNdNtd75TpqK9/DicXjYLe+jo0wXPMnr+p+nec8ojwljO3sRSOsWcXFu82QqfGrItSJRoH0aupfYPATTVm7GUfnQ8843gzitcTZ19Ci3K4yfuUPeulDg2+A7xHt93ExF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N9xjW2FA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afeee20b7c0so410898666b.3
        for <bpf@vger.kernel.org>; Sat, 30 Aug 2025 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756580652; x=1757185452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7C7HDDF1V0ye1jSQLTEXSfhzx7+YOYStSyUtu7nMWFg=;
        b=N9xjW2FAZLWTnANDMuuUTurweSJVg+W+cMkhqkeQ+jIvV0MqgoK9mCVkCwb2WM7+sx
         2bpgNSOQrLMtF9ygUXM3HIJU7oWNS+pTyBzHJeCPmJwRug+jAV2IHOxXTbg7w5SIVw64
         e6hqg0dPcFO5a55Fokww6K2l5rqiHJbdhK4As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756580652; x=1757185452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7C7HDDF1V0ye1jSQLTEXSfhzx7+YOYStSyUtu7nMWFg=;
        b=I+ajolIRjuj1DGs2E2PBv/mvHBl5oBejluqzjjxT94eVAswTmQm2cdVS1vzAHp8kaE
         uJRYTSJqpIypqIJM5DRdTu+mkhJ49HGZP493Jb146Lae505W0KM+N1BC3KUH1F2W56XF
         m+RbaX3m8jw/ezHIRQTkQN3d7IyfvOooHHTcUM0DgT3bG5kQhm1kLhX/yoVz/Y8MPYP0
         Wh+Mzgg3xDoPouLfztBpsJPr+WlA5DiUvie4JD3TdBQgGpoVA4R3Q5QXqcg3GUa9WVz0
         4KXsgFv1PSWpXbsSDn+R0iUqa3zjjTGmVGJTqFNyg2RJ2LnbA4v991a+HjIpS+91HlNW
         1azA==
X-Forwarded-Encrypted: i=1; AJvYcCVikcP+HKPFseuigRQWYIOSw+NdFYoKjG69bmlw3Rv+wWYyrI84SAjU74XEC38GCt9CylY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfam2TW2o43ojgrITtXyDJk9jNiRRSYqYKEmVAnR+UTiqFVXT8
	ZGvb+W7HNwlyabsXfvczu64n6QH4MfQpIpPwL9rGv11v5UhznL9QRNwWUPuzrTbo1aP8R+x9F8I
	Fvc2m3t2bKg==
X-Gm-Gg: ASbGncvYAegk/ix1hfk0yCeNQmMYpFskg0ppSKsB1vdX4KeeUllbQVPI108XNSKqwLi
	LNNZ9dWI07+DAE/feH7EfpI5t/WuN/zjxkcSiduFQVqXGR8VntIiL1aiDVSSv9LKaRiQ5qmul+P
	bh5gvA9qCRSWfIYyoTKWtk9cyllfwXtsA8MEUShEeHl/JGlyxxGJmkFu+8dfCjcyNUArSFDvhlG
	B/JwYSb0HvEEmvNlZS7LLtSsJxMeCINqYV2ylJY6KmDePaCUToh8UXn10O68W/JuVKo+1adaTV1
	FzDPy7d3017xIqvPySs+XqmcHIiuEw7tum8UNjRTFs11UQw/YzYjZjuE9bSqyCtqf/Hnev9wEJA
	bZMoQIA7XH/rr0bozBXGOT59MfsiclySBqWzAT+acjy8p/lUMOWU76ge6cEnHpZ1FAMuXpIunhK
	I71SfN8j8=
X-Google-Smtp-Source: AGHT+IHvJeiQwhd/O7C8A8z1XsVkosYka6VPgp/k7ku3I2MWlbX2AxDJkusyhn1tyWPVPxAWoAcCjA==
X-Received: by 2002:a17:907:c27:b0:afe:63ec:6938 with SMTP id a640c23a62f3a-b01d8a308b8mr269753566b.7.1756580652211;
        Sat, 30 Aug 2025 12:04:12 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0416e878a2sm27496666b.95.2025.08.30.12.04.10
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:04:10 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso4836927a12.1
        for <bpf@vger.kernel.org>; Sat, 30 Aug 2025 12:04:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcdxr8guZuzS1bFJpbgwaGzhzPSptmjCloFUi1ImhNAAMDyjllaGeaJXmgHbKHtpwfSLA=@vger.kernel.org
X-Received: by 2002:a05:6402:26c4:b0:61d:1cbf:bb4a with SMTP id
 4fb4d7f45d1cf-61d26d7904amr2319235a12.29.1756580650360; Sat, 30 Aug 2025
 12:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828171748.07681a63@batman.local.home>
 <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
 <20250829190935.7e014820@gandalf.local.home> <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
 <20250830143114.395ed246@batman.local.home>
In-Reply-To: <20250830143114.395ed246@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Aug 2025 12:03:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
X-Gm-Features: Ac12FXyz3WKCTj4mxXVo4xp6AMniUURUWjQ5DeVA017M_IaQp-7QOD-FOUdEOvk
Message-ID: <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
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

On Sat, 30 Aug 2025 at 11:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> If we are going to rely on mmap, then we might as well get rid of the
> vma_lookup() altogether. The mmap event will have the mapping of the
> file to the actual virtual address.

It actually won't - not unless you also track every mremap etc.

Which is certainly doable, but I'd argue that it's a lot of complexity.

All you really want is an ID for the file mapping, and yes, I agree
that it's very very annoying that we don't have anything that can then
be correlated to user space any other way than also having a stage
that tracks mmap.

I've slept on it and tried to come up with something, and I can't. As
mentioned, the inode->i_ino isn't actually exposed to user space as
such at all for some common filesystems, so while it's very
traditional, it really doesn't actually work. It's also almost
impossible to turn into a path, which is what you often would want for
many cases.

That said, having slept on it, I'm starting to come around to the
inode number model, not because I think it's a good model - it really
isn't - but because it's a very historical mistake.

And in particular, it's the same mistake we made in /proc/<xyz>/maps.

So I think it's very very wrong, but it does have the advantage that
it's a number that we already do export.

But the inode we expose that way isn't actually the
'vma->vm_file->f_inode' as you'd think, it's actually

        inode = file_user_inode(vma->vm_file);

which is subtly different for the backing inode case (ie overlayfs).

Oh, how I dislike that thing, but using the same thing as
/proc/<xyz>/maps does avoid some problems.

                Linus

