Return-Path: <bpf+bounces-66905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F1BB3AC78
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 144264E4AC6
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ECB2C2341;
	Thu, 28 Aug 2025 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="euzMExpv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A12299927
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415222; cv=none; b=hZWqfWK0alBMKGKP1EXO5lDyUhWwtHcsrMNPVVOPhiBK7yGatJHn1+SXDib/iyKQYjX/jTWTfPBRQ8A/jthuco51g2WNM/na931AOF9KmwwULXjSVze34aMQh+RfmXVwfYV7q1UZUr/SoSOVfg2kO+do1b0wof7IFNSXesywUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415222; c=relaxed/simple;
	bh=cWHgJuZ/T8lTpVPF9prtZYdk90QnV1fPX724zcPnR98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq7UB+6bmwXAVHeRJXGJpWnBe0uC1w19j+QIFJA5Hi/jYe0VHwEciYZiXqrG4H6LkUd8EfjKcDopIUoREyOy9UCg2HZwQtIjfhfZ56YkW3jRR4bxI2kJj4F0JRi1aguo7tr5YcAH1MBX/G1FzhB9x99GWefP33L6xtpX/1zIXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=euzMExpv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afeee20b7c0so147027566b.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756415218; x=1757020018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5t8lKSzWiJZ7o8aEHR2Vpuj8q+DwYY+2z0chiLgF/uA=;
        b=euzMExpvdifDom5KT1AHVWL6Zn6PSi26XXP4n3eUiXyOWQStkc/m4UA9sAAls/C6fN
         a3MrdffCSrnZ/MzXAJy9JvN075YOmlZY4pc3cJxd+OO6751bXVN/laSQgnPRQ87n7VJX
         GUkQLaCGNGjyhXDsUrvdieJgF4ZNxdXn86zs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415218; x=1757020018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t8lKSzWiJZ7o8aEHR2Vpuj8q+DwYY+2z0chiLgF/uA=;
        b=BcV0IWJh03rTT1Mn6FW+RsUrdJ2FwbJbD7NEy08MMs0hiAUYLT1RrJ4SSNN767aoNU
         rm0SGz/d2XcEOqDyKSym7pRcD71cCrmh3PJeWT8HK+OPMqwdVy2tGteZa3N/dUlD0446
         G76kHSqzziymaLz01NQG50KunBL8PUJ/q3SX1j3NtMiJSwQPNtNOmqNHfO+keb433GgJ
         SAB6D7odIR99xXht7Lj6bQz3TFLjyiK72PmSVt/SUnWOSv2GExdxVrZ84tZqu4mzfvTg
         /f8HVNQmIc0QLUYOyZ7PDPGuJdsy+kVWHjmsMGHqUx6Cd3cca2lrVlc8gwdMQlkOkVYG
         7vew==
X-Forwarded-Encrypted: i=1; AJvYcCXqlBS84i04/PoNaKIiMGf+TISrYlHgl5uPR7SAn/Ng5e5e1rP2m35YDuEkbz5FdbSikMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4onYTfgKEQR3Id9X+i1P+3QbfuG0Essmie3QMTkq1mkFT4Sh9
	euPzAJpki9iHCIA/+kDrryegOaBZ/MD460AG1iPXKq9KtOayHQbg1V/91X/orkHU3/5dw6aB8pb
	tVPeBl5KWqg==
X-Gm-Gg: ASbGncu22VeW45xZsdn2prjganZc0dG7olzCuE8mcLy4qUo7dxWY2UXrJkUN/yxS46Z
	J+VI38J1egPXC5b4OQgG0xMScrqkggQf+arwI/lgcu2VX+iOZ3l5trQsdMn16e3kuYP08a5I5n9
	IWHqdMXLxL85z+hZNPq8F+qdsbWiuTij5UktSVxtMaAQNVDNb8HXzg4X5A0EPFrw7JjwXiPqn/2
	4DcL6GKdXJ+skbHnVbvKb9NAZMJhoHA240HxPINSKVErg0jjV5t4No7zDhZEn0SjK9jTSPsQIed
	7TPBgYoErgmxTwwYc8bLAiSNaU+nwK7COO+iUHhoD/MfoGjV6l2dvKeVde3Rw4D1A6i+B7f1Cw9
	Bzs6GtFEMAzduiFfx+XoOcfM/XuwyjOvpk8Q5QTOAzQX2dr6zX/v69FZmnWJz+Hwe++okpzE0
X-Google-Smtp-Source: AGHT+IFPrRINiDmqqI5iLZ6M9jQGh+TdnmsEukid9f9RP/C/jSc2CuN0L7ukTscPXMDGDKkQ2DHa2A==
X-Received: by 2002:a17:907:d87:b0:afe:b3be:90f3 with SMTP id a640c23a62f3a-afeb3be960emr1036963766b.10.1756415218274;
        Thu, 28 Aug 2025 14:06:58 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd874bsm39430666b.57.2025.08.28.14.06.57
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 14:06:57 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78fb04cso238129266b.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 14:06:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXScHxPoOJlHGxNWzhNzY4qVvbX0hloqgHrRuYHsUjYP/GBzKOmkz66nZuqlnBLKqz0to0=@vger.kernel.org
X-Received: by 2002:a17:907:9813:b0:af9:6bfb:58b7 with SMTP id
 a640c23a62f3a-afe28fd4320mr2202132466b.5.1756415216712; Thu, 28 Aug 2025
 14:06:56 -0700 (PDT)
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
 <20250828164819.51e300ec@batman.local.home>
In-Reply-To: <20250828164819.51e300ec@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 14:06:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
X-Gm-Features: Ac12FXyJjA2H7p5DkIaJHtdRMPBRP_-Unlm26ZIlq61PFiwHqxH_2EVP3LfoiLk
Message-ID: <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
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

On Thu, 28 Aug 2025 at 13:48, Steven Rostedt <rostedt@kernel.org> wrote:
>
> I could run it through the same hash algorithm that "%p" goes through so
> that it's not a real memory address.

For '%p', people can't easily trigger lots of different cases, and you
can't force kernel printouts from user space.

For something like tracing, user space *does* control the output, and
you shouldn't give people visibility into the hashing that '%p' does.

So you can certainly use siphash for hashing, but make sure to not use
the same secret key that the printing does.

As to the ID to hash, I actually think a 'struct file *' might be the
best thing to use - that's directly in the vma, no need to follow any
other pointers for it.

               Linus

