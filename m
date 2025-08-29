Return-Path: <bpf+bounces-67022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFDB3C1E7
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92F916D050
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052B35AAC2;
	Fri, 29 Aug 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EYFPPjAv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF635AAB3
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488842; cv=none; b=flVqN8Py+JHijPisBJu2Jt1erU7WHy00kDECJNvgX4uwlMLBPv+P7UmH4gW8E9pcW1Wkh4OZ/P/YxXr8bxwvpBdVK16SnNc8FKkV8Vu989Q9+IamUdIx87JbZSUdjzg9P7KCqqsuOBrRSMd1U3HNCBZuXKLrTCdCacPBkjGPHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488842; c=relaxed/simple;
	bh=0Iwk8kojSYVfnDLAmzrwi9KHqF0f7PplXnNwNjdrHA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Os+50GVseQcXtDd7T2ikcgkpkAB9ekfQ6CqP0TU/3O6CKwLuSTYYWAPWjgwEcT3+DaMeP3drwNPppPKF9UeZL2sMpr/ShDCXsE8Sz0IXxiB2R0BPE4xLIULYGfbc+G/55ce5pN3bWjf0P3OhJkFv60u0oapcUaSQbpfEiufgHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EYFPPjAv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afefc7be9d4so182125166b.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756488838; x=1757093638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JzHs6USaZca2JuAKnnFeoU743SczkPKj5+4UqlxGdQ=;
        b=EYFPPjAv8HPt6SOLB83d88n2ATVYt6h1hA+eZ/4c0lKj/90V8GPjl3gyrkUbAt0g6J
         H5QYjTSEbSW5kePswh+TJqZw2DpWHEpr5Qdq/QizV+QeWYVj3d46ilBLXnvAVrLnk/aw
         8NEPsAbx3MQ+OkyTvteWHw3h17IlzfczD+Krk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756488838; x=1757093638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JzHs6USaZca2JuAKnnFeoU743SczkPKj5+4UqlxGdQ=;
        b=N+V0bpiGtByyMfyFShTFYStizV+py20lhpInh8K9BezAwxjgCXtjUWeZUGfVw6Gcab
         EUoPS3ZP+TmE6/xz/FePB88rZ3QUsH97Lzd2/SmupSLLnWPskFNjI0dnnjiOZLSq/fMX
         9dM3Yda8tgDZ1fpWVrGgypN+PSVS699MhOmA8so09x0fiLLHsWshrYpEgl7GqVCIN1Nl
         /B1DEkfRIseJHE089kMzw/yrW5hsKmaxzSHy4zAwEpLanrJmXcssa4mva7TSDu6zpXic
         DSL60VJoBTqJwxAZj8bvMUZbIXShdPgCey9bCdlbXFoSoCJ1dCO/XLmnWvN3pr3xXx+Z
         aHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3g1ibrwbuFVZ9htonO5VtartxccWXf6V0BeBvOrfpSVEUeTL8s3tSO7tCqFlgPSH6wXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gk36LITUNRkgiTv+1l6enhxVxi4w3cUk2/sAzGL6cCP6ht9O
	f3MCavkefTHtVvRi+xVeq3cO27+TO6A8oGXuw1m2BAcWud9tyWNZjKNtn24DVILs+UerCy5kIVn
	BRrwpQJc1zg==
X-Gm-Gg: ASbGncs9fEugljpNyBE3vIkp89XER6W+sKNVYU+1R9KStcAfsXL5HGdLD0ieOD2Kzs5
	dpSZ1/eAQdy9bRJ/OXo1P9S8/S4SYHDGB4WHo2vjauJ3JzR0NNFJEiHOaxzdHM1W0oGYpGAIxuY
	Q4IoiQOYuxgi+5gWnu3/JIOUZRIefocGdkJ1CkCnFtHG34c9a6t1+dMHn3DpAIf0FbgGliioL3Q
	P+6ugk1A/6PIXUpjVuyfw5Of6JJLaBqY6pcuG8DA0rDZoFz4bMwEwnyrbDdnzjG/6KprxZbKsCZ
	zUp8Md+0oqmX7wJtS53+nbWy+Tk+hZJ0xJA9He2N46gZ2Y6QyJZ5iUfPU3Y2HOnRRTPCrNbDEpG
	+mCQaVxoXyaEQ2V8K44Z96PJ11DGl7lPzcOTP2nRmWQknLBfNvOdHpGPYmyZYgl9qXPzXc9mD
X-Google-Smtp-Source: AGHT+IERrKb04hUlasY6HwvDdydxsnafHZWpRRSR9k9Tdnlk39C1v1TiXrcqsTo3HMbYpyMLaJJMpg==
X-Received: by 2002:a17:907:3d0b:b0:afe:6648:a250 with SMTP id a640c23a62f3a-afe6648c396mr2244229466b.17.1756488838507;
        Fri, 29 Aug 2025 10:33:58 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc22b594sm2181247a12.21.2025.08.29.10.33.55
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:33:57 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb732eee6so393797666b.0
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:33:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLiZ9T40C6oITGI7HiuQewEIuSgEJnH+nyMO7sEadveJogVFg3T0w6yJAceXYFTlu0FX8=@vger.kernel.org
X-Received: by 2002:a17:907:7286:b0:afe:d24f:fd70 with SMTP id
 a640c23a62f3a-afed2500115mr854960366b.43.1756488835450; Fri, 29 Aug 2025
 10:33:55 -0700 (PDT)
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
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
In-Reply-To: <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 10:33:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
X-Gm-Features: Ac12FXy9v9IJY2LXrpDvJU9dj4Mt87wFmaIDhMj9zyTfDwA5B4n7cidgQycVydY
Message-ID: <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@kernel.org>, 
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

On Fri, 29 Aug 2025 at 10:18, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> As long as we don't lose those mmap events due to memory pressure/lost
> events and we have timestamps to order it all before lookups, yeah
> should work.

The main reason to lose mmap events that I can see is that you start
tracing in the middle of running something (for example, tracing
systemd or some other "started at boot" thing).

Then you'd not have any record of an actual mmap at all because it
happened before you started tracing, even if there is no memory
pressure or other thing going on.

That is not necessarily a show-stopper: you could have some fairly
simple count for "how many times have I seen this hash", and add a
"mmap reminder" event (which would just be the exact same thing as the
regular mmap event).

You do it for the first time you see it, and every N times afterwards
(maybe by simply using a counter array that is indexed by the low bits
of the hash, and incrementing it for every hash you see, and if it was
zero modulo N you do that "mmap reminder" thing).

Yes, at that point you'd need to do that whole "generate path and
build ID", but if 'N' is a large enough number, it's pretty rare.
Maybe using a 16-bit counter would be sufficient (ie N would naturally
be 65536 when it becomes zero again).

That might be a good thing regardless just to have some guaranteed
limit of how far back in the trace you need to go to find the mmap
information for some hash. If you have long traces, maybe you don't
want to walk back billions of events.

But I wouldn't suggest doing that as a *first* implementation. I'm
just saying that it could be added if people find that it's a problem.

            Linus

