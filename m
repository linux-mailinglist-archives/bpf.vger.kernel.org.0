Return-Path: <bpf+bounces-66992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C0DB3BFCF
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA3B3A508C
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86080322DCB;
	Fri, 29 Aug 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cpTvFJ69"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D1326D4F
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482487; cv=none; b=B4eDoL/PcpOPvPjxiRQ7hhOR65di8N7mDASopTbMHNfI9SflEsJpHTw0nipLNbiArEhVNeH7oy9ulKOXC0fkMA4K16NbqQU2WXHLOuhtPzqPnhLx2+X4OwpISvOZDFPL02jMks3iXlAtiFARFxxxRVNKGMW/Nq4gzc33prC4V64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482487; c=relaxed/simple;
	bh=IvNOoAxgGRDV/pz/+Da0UiB1N1KkrY/4Hn+qpOfi20Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrHBTLBwbR+ljGwTwN0DkToNtknSdJlFzS3BvCI2FnBgZbhPdFFTwNldJfSSwmaespKWPNfukFxeWIusa+1YBXTeFwPHdQ2BVd3gfEgc0mAhtO4mumNVzphcCVU3a8Gd3JvSBDl/jVxObxH+X++R/iMEWKu8ojLWxxMMYDkEjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cpTvFJ69; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afede1b3d05so394402566b.2
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756482483; x=1757087283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQUhdimbGwdD8GQxXTeeb1UkXF/zoKTQKbXke/E9VAE=;
        b=cpTvFJ69fzSw53wIcLPnNB0fTu6iv3DM0IJvdbBqRmz792fUoHjkKznX8boNNSRUAn
         CTLKo8t4U7TFHE52gL686XJ/1d9mT2BO9DzJo7p0jI0H9Wu0UP7CdGajOkxP/PN/C5Sl
         CE4ZPy3Fau7d7BNhjfT10v75P51MV9mw55fLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482483; x=1757087283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQUhdimbGwdD8GQxXTeeb1UkXF/zoKTQKbXke/E9VAE=;
        b=pHpuqwGZ/9+J9pBz3w4XEzeamZHn5kvT73hHYyepvVUu9QiWPDCuvP6RmgQbJ19GNt
         bSZsRCBN2XJVR7Yosek7x5FdTxdoT56KpTwzIwChQaGiaxnEDE9OJNscSetSAaafotul
         q9/dx0FWtOJESQKf0OWzQYliEBnSgCrXEWZB2iIYu+zPMQ3rzlIbbaQu45gm8l5DE2zS
         3FqKzpLId4RzMmKS1CinHmNAXgatoTeFe092HvsKnVYuin+9LiGH61zbjqVV53i7nXN4
         aGwHMsdFu1wZ/ru9ZjGru3aw+8YVbhoGGqTccIEx8kJWaqA+L0kOeXW8yqOr8gWKDo3r
         MoeA==
X-Forwarded-Encrypted: i=1; AJvYcCVmTzkFckOf3MMdV5U+MpiJg5pX+Xqb4msxmkn/TdlauBpOQPGOdctHwZ3mHJJITA2KdyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOzNLRQwQgtCppW+U8V1vw/xqwGiprpXD7WzM2ZdJpfAQ8bLK
	8oe9mN+wEgIKJdA0x1fvWhDIdAWmsKJZvhrph9h/1TIUCblrST0tswfLzbwGENRhk5I16m0c95U
	P8XxJk5NsnQ==
X-Gm-Gg: ASbGncvlqdKauvesY+BfTAKLtCr4BBOnpS16rK1c9MZc9BvEgDgw5X8O/JvgQ2bQO3e
	NF5kmVu2h/Df1w8k6AnZ4nTYsfm0Zku1XyM/WBLymZNjxBgIukRRQ6KMYURhalzSWKM0wpJkPom
	qtabEErIyuczA8OOp14DDcyA/Q8xsgpWoOVfvUAWDJj12eyHtiuH3v3crD0GMvXpufaUg6Mtdua
	NKk5iPFybqBBY6Qty+X4lLvXgx6epcDJRtl93mB+rBo1NQrASSmkZodpwsvfLtlv+eV8/wZ26yF
	XJOWsZUoJjdgXo8bCf41ITtGZUk5cb4rNPA3QehDOCAyQF9UTKaZHIz3zB2qbdPvnxZqoy9X//J
	1C6SFPjm3RJOwDZmE+XmkChcKql4JI5NI+35+UCcnRKkc0a6CTLCSOkytjjzh4yUN1xwSZMt8Ib
	BccXz0I1c=
X-Google-Smtp-Source: AGHT+IHF73kN2F+frix1th/r/csxqMr2m4sDddoqSM+hzS7/YOGnkxuK1SNIvWq7uHNnIQacOqpMjQ==
X-Received: by 2002:a17:907:720c:b0:afe:ea46:e80b with SMTP id a640c23a62f3a-afeea479aabmr720941466b.10.1756482482829;
        Fri, 29 Aug 2025 08:48:02 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c5f7sm227957366b.79.2025.08.29.08.48.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 08:48:01 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afeba8e759eso342414066b.3
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 08:48:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkYWJoTwuPaAGZjkLMiOuSm78Ar0UURx/SxMhCic0yzB0UvTu/rWVwzRtHKwbVFs9GoCU=@vger.kernel.org
X-Received: by 2002:a17:907:1c84:b0:af9:4fa9:b132 with SMTP id
 a640c23a62f3a-afe29548f36mr2755239066b.33.1756482480512; Fri, 29 Aug 2025
 08:48:00 -0700 (PDT)
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
 <20250829110639.1cfc5dcc@gandalf.local.home>
In-Reply-To: <20250829110639.1cfc5dcc@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 08:47:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
X-Gm-Features: Ac12FXwNlyz00O8OVBJK4ieQwLO8cLGOqnKUasO_BCaKG_QlAegARW0kUgVHzi8
Message-ID: <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 08:06, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The hash value can actually last longer than the file pointer. Thus, if we
> use the file pointer for the hash, then we could risk it getting freed and
> then allocated again for different file. Then we get the same hash value
> for two different paths.

No, no no.

That doesn't mean that the hash "lasts longer" than the file pointer.
Quite the reverse.

It is literally about the fact that YOU HAVE TO TAKE LIFETIMES INTO ACCOUNT.

So you are being confused, and that shows in your "solution".

And the thing is, the "you have to take lifetimes into account' is
true *regardless* of what you use as your index. It was true even with
inode numbers and major/minor numbers, in that file deletion and
creation would basically end up reusing the same "hash".

And this is my *point*: the advantage of the 'struct file *' is that
it is a local thing that gets reused potentially quite quickly, and
*forces* you to get the lifetime right.

So don't mess that up.

Except you do, and suggest this instead:

> What I'm looking at doing is using both the file pointer as well as its
> path to make the hash:

NO NO NO.

Now you are only saying "ok, I have a bogus lifetime, so I'll make a
hash where that isn't obvious any more because reuse is harder to
trigger".

IOW: YOU ARE MAKING THE BUG WORSE BY HIDING IT.

You're not fixing anything at all. You are literally making it obvious
that your design is bogus and you're not thinking things through.

So stop it. Really.

Instead, realize that *ANY* hash you use has a limited lifetime, and
the *ONLY* validity of that random number - whether it's a hash of the
file pointer, an inode number, or anything else - is DURING THE
MAPPING THAT IT USES.

As long as the mapping exists, you know the thing is stable, because
the mapping has a reference to the file (which has a reference to the
path, which has a reference to the inode - so it all stays consistent
and stable).

But *immediately* when the mapping goes away, it's now no longer valid
to think it has some meaning any more. Really. It might be a temporary
file that was already unlinked, and the 'munmap()' is the last thing
that releases the inode and it gets deleted from disk, and a new inode
is created with the exact same inode number, and maybe even the exact
same 'struct inode *' pointer.

And as long as you don't understand this, you will always get this
wrong, and you'll create bogus "workarounds" that just hide the REAL
bug. Bogus workarounds like making a random different hash that is
just less likely to show your mistake.

In other words, to get this right, you *have* to associate the hash
with the mmap creation that precedes it in the trace. You MUST NOT
reuse it, not unless you also have some kind of reference count model
that keeps track of how many mmap's that hash is associated with.

Put another way: the only valid way to reuse it is if you manually
track the lifetime of it. Anything else is WRONG.

Now, tracking the actual lifetime of the hash is probably doable, but
it's complex and error-prone. You can't do it by using the reference
count in the 'struct file' itself, because that would keep the
lifetime of the file artificially elevated, so you'd have to do some
entirely separate thing that tracks things. Don't do it.

Anyway, the way to fix this is to not care about lifetimes at all:
just treat the hash as the random number it is, and just accept the
fact that the number gets actively reused and has no meaning.

Instead, just make sure that when you *use* the hash in user space,
you always associate the hash with the previous trace event for the
mmap that used that hash.

You need to look up the event anyway to figure out what the hash means.

And this is where the whole "short lifetime" is so important. It's
what *forces* you to get this right, instead of doing the wrong thing
and thinking that hashes have lifetimes that they simply do not have.

The number in the stack trace - regardless of what that number is - is
*ONLY* valid if you associate it with the last mmap that created that
number.

You don't even have to care about the unmap event, because that unmap
- while it will potentially kill the lifetime of the hash if it was
the last use of that file - also means that now there won't be any new
stack traces with that hash any more. So you can ignore the lifetime
in that respect: all that matters is that yes, it can get re-used, but
you'll see a new mmap event with that hash if it is.

(And then you might still have the complexity with per-cpu trace
buffers etc where the ordering between an mmap event on one CPU might
not be entirely obvious wrt the stack trace even on another CPU with a
different thread that shares the same VM, but that's no different from
any of the other percpu trace buffer ordering issues).

                 Linus

