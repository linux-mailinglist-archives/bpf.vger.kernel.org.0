Return-Path: <bpf+bounces-66909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C2B3AD60
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 00:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1082A1C86CEF
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55C25C70C;
	Thu, 28 Aug 2025 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FfPtcLiF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA854DF72
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419557; cv=none; b=OV7DHdfX/DarwOGS7VZnCIngq6eBwH+i5Ju0Hk2uozv1+xj+Ordw76dKMKzxet0SRI6a/R3uf05odkz1QXZXMopdgxGvvM6lqURUqAVNy56b5ckSakj6fc03V97spDHIlmIwmUtCZmTBWwZUSmm5kx3oq1WW+qT7CzbSzv++DVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419557; c=relaxed/simple;
	bh=9WEGzCFhZV6sH6YxOCr5ztz6wxhV90gkoN+WpO2tJ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvL9iPExokQLofzTRMcO5iHNMEEHMHFvDeUbJ//0FlLL5H97UDHxm3IMVFZh1bIL5uV/eNGu09zzVGkusWQIyA5Bn8ybSMgRXpxhlQy8CLB8FPofY8WUvENL2YArsbISbYz7D4zMjQjTlozfE138g5b+mldq4U6zgZoWmSW/TC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FfPtcLiF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f6507bd53so911761e87.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756419552; x=1757024352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PvdilKb/k6sbi3O/WOYoC5wLcLE1gCyu//e95KE+Wa0=;
        b=FfPtcLiFzwE+9uO9dwvb97snXYxWjo+dbqrPhxtUQ5gLqq8o+Z+uo8evtuo8Lt8amP
         p51GMQ4eNAPQfyKuUT5ZOEUjuAO0kbb+KzBQAwzJP6WWcdPcEJAl9O/pEjeLRKy8SS6c
         j++p3PNCiFBjtkuALhAG0Fs9OWSx60hfLFeoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756419552; x=1757024352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvdilKb/k6sbi3O/WOYoC5wLcLE1gCyu//e95KE+Wa0=;
        b=h1njP9o6LQzUJ6HX56IGzL82jJrl4k0X/y+ruqnicWwQVqiZ1tXaeHiDMQimt8xR7S
         bW9AftO0m+EhqitFdfq6A47qFCNpe95F5o1H/AXwWgf31qgvRSfCLn88Jiki/5eNOqXl
         Sz+mSYMc/+oaDysaPlRL0aSw2BUkqV/ZdytGGp7iqPiCNBl7GS0oSlP3zSq+F+F2qkqv
         Y4wUaLMLJBM/6qW5LHzUGkojl9sH4WPaumkUl0pXgtt3q6V9+2yxCSuqbu5iR4D0iuLE
         HHdHjik/xaDNqeUaPfPd28ouxyF5XU1Uq4gCHB8BzujQ6EcDhGHUO4bOMOS0Enm3XwGI
         d6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6vRtL5slTRoWtWLu/vzi56+YIx1UBzMzVk1YSGILeF5e3bfZvCSyy0GsUw+kSzVtBj/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00naHWKoI3KZLeZUm6H6QUxuhLbhtl/Dht+1Cgg5UtiFUd6G7
	qp9r8vdtnQt6NeOoZHs+npvv3jUqtkYyTX+CUqYSOdYmWdPNrCbgPdpqqWdcGewuYIAgfoFRxb7
	I/nQLZ2uYjw==
X-Gm-Gg: ASbGncuYhp5govl+T5U6saDzPC6dzZoocQr7kPuYtNsJgsF961mJxJ18kxu91DgSYC+
	CKdjrIVx4CCi4/5q2YPd6NA7pyO41DfllcP8vjHj2SO1zsGMXg3TbAHUYPCaAH5rBiJoLTGNlzR
	cJ3d5ZVkCPIt3ZGvRVqSQaX98i2xR8FmzeKsewhdQyQc1AKkYfAc51xMkfzjZ3flDp5XvMraXqv
	uuauXJXSbN8PF4qVYjj99y+vjYmTar8QRBwxEnv6oTR6q79KkknorgnrzL+ZtZHs4T7IXbT1A1+
	RjQZvu361jqe6P7VlvkpYu4w493JLPmWd3qJQR4DeXwVKnvrLcyeJEv82EmjVK3IDJa3dkLs0cM
	aArz06kvW7rUq3N/NYO4SsbSjC6zt7ztSleIQkVj6O+IPp32YgIS/4e2gw6X4kudXlHCRAGntHS
	YWK35rC0k=
X-Google-Smtp-Source: AGHT+IHHLOf76OuhNcXYWp9ioBAWwRH9asfH2lknwgcqAyjSGBttNSafh6HcyylMyhSATr2M8PkjOQ==
X-Received: by 2002:a05:6512:61c1:20b0:55f:33d6:6d64 with SMTP id 2adb3069b0e04-55f33d66eafmr4486506e87.2.1756419551416;
        Thu, 28 Aug 2025 15:19:11 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676f537asm133347e87.35.2025.08.28.15.19.10
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 15:19:11 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f6507bd53so911743e87.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 15:19:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJadMbQrVggIxmtC9VRBwVobwMOEkVSe1Vqt+8pXvjC5MdSGziQsB7d6Z83tBW0TmCA9s=@vger.kernel.org
X-Received: by 2002:a17:907:60cf:b0:af9:3116:e0f6 with SMTP id
 a640c23a62f3a-afe296e6412mr2315793666b.53.1756419069671; Thu, 28 Aug 2025
 15:11:09 -0700 (PDT)
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
 <20250828171748.07681a63@batman.local.home>
In-Reply-To: <20250828171748.07681a63@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 15:10:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
X-Gm-Features: Ac12FXx5hAxpj7R5TefcskUP8HKtgWPbH5S6RidfTf_IcaWQCyRoB2repH8EaWs
Message-ID: <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
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

On Thu, 28 Aug 2025 at 14:17, Steven Rostedt <rostedt@kernel.org> wrote:
>
> But that's unique per task, right? What I liked about the f_inode
> pointer, is that it appears to be shared between tasks.

I actually think the local meaning of the file pointer is an advantage.

It not only means that you see the difference in mappings of the same
file created with different open calls, it also means that when
different processes mmap the same executable, they don't see the same
hash.

And because the file pointer doesn't have any long-term meaning, it
also means that you also can't make the mistake of thinking the hash
has a long lifetime. With an inode pointer hash, you could easily have
software bugs that end up not realizing that it's a temporary hash,
and that the same inode *will* get two different hashes if the inode
has been flushed from memory and then loaded anew due to memory
pressure.

> I only want to add a new hash and print the path for a new file. If
> several tasks are using the same file (which they are with the
> libraries), then having the hash be the same between tasks would be
> more efficient.

Why? See above why I think it's a mistake to think those hashes have
lifetimes. They don't. Two different inodes can have the same hash due
to lifetime issues, and the same inode can get two different hashes at
different times for the same reason.

So you *need* to tie these things to the only lifetime that matters:
the open/close pair (and the mmap - and the stack traces - will be
part of that lifetime).

I literally think that you are not thinking about this right if you
think you can re-use the hash.

             Linus

