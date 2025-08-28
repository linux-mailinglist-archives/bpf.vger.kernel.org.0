Return-Path: <bpf+bounces-66879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE452B3AABF
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E47AD771
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 19:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792026AA93;
	Thu, 28 Aug 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SZ7gLaOy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532C24679C
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408739; cv=none; b=ulWEo4hrJFFuJxbT36AyzPyXy+OAxtaijryOTPeH9XzW660aRzGxN2uJ21AqYWK1w3na29K6DH0DB3WU4Ix8Xcgzq0gHWoZ9X2G9fxf7OVPPqck6jvtpzWIZ9f5oYbL1bjcORCFzmagHpnDJi/GGReBsiSFNMgN+aL3wgSxOz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408739; c=relaxed/simple;
	bh=2IF4LwSznkIAWKigu6MO3g12tp2YjOkonuilJ4MG6gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ME3EUc9WuC662jZjQ6caR/yJbD3jTdU/X1bMCTDWW/m0AxHK79zSsCVKtFSBjOpDlJWQL+ry1P6BbgUtWtZFCi+lTHKrhYH8TzNSsGl9iLaiIDz3BtPZlUI2hYlXFisv9SCFtVpYnnoQgMmK7sTZeWsq1RLmo55hn+KkGhvc1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SZ7gLaOy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cd3748c6dso2415857a12.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756408736; x=1757013536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a9FvOgSym4EqR03gYaZF038ABDYjvh3jMsW76/lQsV0=;
        b=SZ7gLaOyE94Z7+REmfmjJVMP+S9/oTH+B9y4F75j9jMxbHe8u6sEQ93TYbCunwikO4
         YON7nRrTRzJa7gDkqWl3dmzu474grZa9D/LDjawdj1eFVcPG6EJ1r99NHkF+dNC3p3P4
         yVqxKO2CK9LgZKJrjd1R71OYPGBUeOzMBzAK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756408736; x=1757013536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9FvOgSym4EqR03gYaZF038ABDYjvh3jMsW76/lQsV0=;
        b=vmRkFUFUYN18qBi6Xnh7tWG8h4cWsamojp4nI1hy9YVBqD47ThS1Wrsq1eD7Lwv5bL
         EICzWoFFe7VWGaDqQEQ6PgK6zdxtPRWRfYnNmKFdNwXs+DhPI6FPe/qBcCNGjZ2DhyDw
         +ArewO2oCRkbb5R0eQo1qaaRLvs727bTk3rHik0/td36oF0IbAxKdZO1clUiey3jUiSU
         gTauCjVNZlDXhwwT5AMsIyAZjN+9nScj6OvVIUf1W0ferzst69N0hD1tX/+MAFts/4Mb
         LBEUhK6dgHZCyghS8D2Jn7DZja65ZNC3pUETXJ2jnNqKpm+RSSWiNfWokfstbA0OK6Bb
         SMEA==
X-Forwarded-Encrypted: i=1; AJvYcCVb/CIFhKRMU6ydXojiQFoCNMRznqiGEmBmVu6D8nqMKUBQmqF/DPpdf7JLTznoo4f//EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJJh/dJ7RRYm5QTO7wRbBCvbQz6+mPKl9C9uGxcX/v+BbqQ6s
	BleW477dloCviUf9Jyh8GsbBvGMuKAPukkBqhTSgKrxW0cIoBGGaru/qJVa5FrcpvPziB2NDBRw
	6BC42xjs=
X-Gm-Gg: ASbGnctLbZTpAl8HS8/FGU2aa/UZptNwZx6xFT7Y/WkDjQBKYX1RtCHyCOhwacqb2Bg
	hOTOn+TnBR4FQHAo57iSVwM24hb8+Zuv+HXGB+YV5fxHjeK24IoW1VbmID64shwexjdf7XXSziK
	sxfNVeR1Z4q8kJl7m3Vvb3oly9xHp5dNVByJ2Dm5r8c6N6VLiLFDBynKdMPX0DCX5PGJWfpJdpn
	fp1StOJQX4EqHR2a97Wop6qLEDA8N9M+EHLSoG5VfdSjMXv+tndjqv68vnOmxYlRIE02lkqjVAU
	brPc+G9HmtpiAynhTFEtJ3grtb3TgWJq/p49o+fea4ROUiJ918wr3yQyriG4s3jUQW62/gWGLmh
	HBgD5F2NeZVzGqRLVDLu2kynQPASgIdLmnaWjDf9YFXShHqXqwH8kmD8+lcG8IGNqrmpJlBPQ
X-Google-Smtp-Source: AGHT+IHiemdgXb1zlGbn9l8OswZFv5jkz6oCai0eBP5Fj9G1MAHdm6sBZqq2b8XkgrOk0O+PY0xkag==
X-Received: by 2002:a05:6402:90c:b0:618:196b:1f8a with SMTP id 4fb4d7f45d1cf-61c1b3b6658mr17690241a12.4.1756408736083;
        Thu, 28 Aug 2025 12:18:56 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4bbc2dsm234064a12.32.2025.08.28.12.18.55
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 12:18:55 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afec5651966so236431466b.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 12:18:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRYM2GXB+3fkPq958DsvB6vi2PtxRB6BDijBusl/s+jzchzUH8zq8CnJlaSVmiG22A7/w=@vger.kernel.org
X-Received: by 2002:a17:907:7242:b0:afe:9f26:5819 with SMTP id
 a640c23a62f3a-afe9f265912mr1037393266b.28.1756408735434; Thu, 28 Aug 2025
 12:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
In-Reply-To: <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 12:18:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
X-Gm-Features: Ac12FXyRk9o0Zpd1fgIo8tAfxDzyblfn9y2Gh_4SDmM8oOmqSsm_2faftGdE2CA
Message-ID: <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
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

On Thu, 28 Aug 2025 at 11:58, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> >
> >Give the damn thing an actual filename or something *useful*, not a
> >number that user space can't even necessarily match up to anything.
>
> A build ID?

I think that's a better thing than the disgusting inode number, yes.

That said, I think they are problematic too, in that I don't think
they are universally available, so if you want to trace some
executable without build ids - and there are good reasons to do that -
you might hate being limited that way.

So I think you'd be much better off with just actual pathnames.

Are there no trace events for "mmap this path"? Create a good u64 hash
from the contents of a 'struct path' (which is just two pointers: the
dentry and the mnt) when mmap'ing the file, and then you can just
associate the stack trace entry with that hash.

That should be simple and straightforward, and hashing two pointers
should be simple and straightforward.

And then matching that hash against the mmap event where the actual
path was saved off gives you an actual *pathname*. Which is *so* much
better than those horrific inode numbers.

And yes, yes, obviously filenames can go away and aren't some kind of
long-term stable thing. But inode numbers can be re-used too, so
that's no different.

With the "create a hash of 'struct path' contents" you basically have
an ID that can be associated with whatever the file name was at the
time it was mmap'ed into the thing you are tracing, which is I think
what you really want anyway.

Now, what would be even simpler is to not create a hash at all, but
simply just create the whole pathname when the stack trace entry is
created. But it would probably waste too much space, since you'd
probably want to have at least 32 bytes (as opposed to just 64 bits)
for a (truncated) pathname.

And it would be more expensive than just hashing the dentry/mnt
pointers, although '%pD' isn't actually *that* expensive. But probably
expensive enough to not really be acceptable. I'm just throwing it out
as a stupid idea that at least generates much more usable output than
the inode numbers do.

          Linus

