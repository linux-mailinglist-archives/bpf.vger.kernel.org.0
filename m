Return-Path: <bpf+bounces-66903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B227B3AC60
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB20E3B108C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DE35335C;
	Thu, 28 Aug 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIXy+EWr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F7352090;
	Thu, 28 Aug 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414831; cv=none; b=eI7mY/9PTzn/YLYUZPRo3qyRih2Zddtt6T7bLT05gowOCjEpV5DFVtx702hJcUf8ymgAPGBmkHPT4zAEdd4o90uzxO9NAkoUopZVv7dBXOwQapKwHrKKCjjaow3pJ0JNTn8yH0pmx4fSbpXEF+5QKCoxsP7Fg5NZCDJNDOTAciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414831; c=relaxed/simple;
	bh=UrtKpeO3llBQn6sGqd9y8iFW/cjpJgGXJC9q1AX2zbA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uhXkRmRGMF4PuInHjyUqyokdmI5t5SmodWW3OWtGD+V70fXMQSk2vBu25k/hsGr4dWSFtfLr2aHPlxax0dEtGhFS1wKGSaMJ7Z3YUpyGjfhYV1LV1o95n5VMuAG8xRqkaKJYyCFXkfnDCSRgDEx6x6EGo8GeQA8sTnz3lDlwq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIXy+EWr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b618b7d33so11626615e9.1;
        Thu, 28 Aug 2025 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756414828; x=1757019628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UrtKpeO3llBQn6sGqd9y8iFW/cjpJgGXJC9q1AX2zbA=;
        b=AIXy+EWrUucJcLRYtTx8+OHAN4177XDPks5BBckGdwE+zFA4/vSv3pLuHS/zBZIyq0
         hAisY745rqvD4LQ1Xssub2MRiwvMNZG+DrYpRDRON2YSH3kw+2I7EiDeJHA0pysvS0OY
         dRJGKccpXLnpetW44TG0Lcr5u95P9rVC1vsK8Rf4owGgDCmww3rgFqz8ySYLFYZP48ji
         gW2D/2ZazMiz86fGkx8LI7+miogmb23eO1iyLLa9Lh1vMMq/TbIGlusFjR/aNJUBDOcZ
         Jrlms6Gs/E39+VUFTZgwZy5wspibPLsHHriwP3nCJ4Gqx0/cndwxZzuMCfETNegyAIld
         vw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414828; x=1757019628;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrtKpeO3llBQn6sGqd9y8iFW/cjpJgGXJC9q1AX2zbA=;
        b=aklKClz7pqrzBOm2VZyf5rXirQW8x2qtr8uGG5AjjYbwQIloA/RgxKYYku4CuTcOtI
         VOaHuarPiVj9UAJO6ORzA3DSX+VSuzSns/34DgO9mnIXLMY7Zs08LTmFN8/1TsBqigT9
         srJVLslVkGOyJvkSAwnZCsxWwSjqF7kWPSUjbKsxQWy/7J2K/l+TSDy5o48l4zy0NnlB
         vZqMfUjMJAEy03A2zEZplcJanejWDLMJ3h7TnTAuGbLWeIWDsvxhmu3LGKJup1hgRwMS
         aMcP6Gv4Q2FnG+fadGjQVK5p/pOVPZjeSt95lsJCfnYR7jf799g4KQts00UVMH+k3Y3t
         cOyA==
X-Forwarded-Encrypted: i=1; AJvYcCVNjZpGKJkT+g8Nzo3RmjgJXcmF/VYTRDUxJgEGimROmF/VlZVIkg/DboudFjkms0oGrXc=@vger.kernel.org, AJvYcCWPh3HXTJYyp+CWw9D5vrAw5TGyTDUE5SRu0ThWuyH4ehrvGCVyPf5gOVGe29Q28OZdXm30O9Moh3EWkkoV@vger.kernel.org, AJvYcCX5QOK8qijc2PxWMz2YKMRdIfGIxpLrjR8h9khXh5/sVgycsYEnOQZjKPQc4SsppHOB2NEp9VATsOoyOOmI4K5U1wx+@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+EY0hTTx/z/JvliS3AYh0aEVTlObFgfhd5fQ0r9ln9F53TU9
	jE+AFaIkOUglEI9LSXNhkPtNjpxUTPab2LXbeItE2dsyatwJUymUYlOQ
X-Gm-Gg: ASbGncu0GNyy6i+RLBDjiE9msO0ZYzT3obrnIbpTnQLKLmpS8emTGpX/JGsYLpTX2P5
	MlCMRH0aD99OT3A3zD1VP9omZWIVZn+rs5l4F2wHT6Hjh8lhGQSXRSGbtu4F8BJrlbExjIoIb6x
	VZScicsp0rqvG4nGUXhJilfIBsBronEhH3bvjzk5LK0fBQZgkDzfKl1CDRFpVUNK8ryjHBdoR1e
	7yGvnQ6RTphnttETtn2HobJ8Gjt/IETY6F7m5Ob1Tie52phXq0Lh21kM+JgpWTdsgKoiIfa9pJt
	AQ7INTZ6BF5BUcE9g9Y6DsQc/9GUljlcB80QTpxPocM9XPW+9gAJRjOjI4bqoqXiqNNLglOKkm9
	w6olPhsgvSG11xtk5HB+PKnR91WE78m0ZG+RdsxwLcJNccbXK
X-Google-Smtp-Source: AGHT+IHm01eYfbSzPrRUG/fxP6I2oxrrCmv9eiKXNm7/Hz/jeQZpSNVcECbSVXjHrS8axA74wdvFxg==
X-Received: by 2002:a05:600c:154f:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-45b5179cf31mr205890405e9.3.1756414827621;
        Thu, 28 Aug 2025 14:00:27 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.255.128.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7f14bbsm9520155e9.8.2025.08.28.14.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 14:00:26 -0700 (PDT)
Date: Thu, 28 Aug 2025 18:00:22 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Steven Rostedt <rostedt@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_5/6=5D_tracing=3A_Show_inode_and_devi?=
 =?US-ASCII?Q?ce_major=3Aminor_in_deferred_user_space_stacktrace?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250828165139.15a74511@batman.local.home>
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org> <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com> <20250828161718.77cb6e61@batman.local.home> <583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com> <20250828165139.15a74511@batman.local.home>
Message-ID: <F8A0C174-F51B-40A4-8DC5-C75B8706BE74@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 28, 2025 5:51:39 PM GMT-03:00, Steven Rostedt <rostedt@kernel=2E=
org> wrote:
>On Thu, 28 Aug 2025 17:27:37 -0300
>Arnaldo Carvalho de Melo <arnaldo=2Emelo@gmail=2Ecom> wrote:
>
>> >I would love to have a hash to use=2E The next patch does the mapping
>> >of the inode numbers to their path name=2E It can =20
>>=20
>> The path name is a nice to have detail, but a content based hash is
>> what we want, no?
>>=20
>> Tracing/profiling has to be about contents of files later used for
>> analysis, and filenames provide no guarantee about that=2E
>
>I could add the build id to the inode_cache as well (which I'll rename
>to file_cache)=2E
>
>Thus, the user stack trace will just have the offset and a hash value
>that will be match the output of the file_cache event which will have
>the path name and a build id (if one exists)=2E
>
>Would that work?

Probably=2E

This "if it is available" question is valid, but since 2016 it's is more o=
f a "did developers disabled it explicitly?"

If my "googling" isn't wrong, GNU LD defaults to generating a build ID in =
ELF images since 2011 and clang's companion since 2016=2E

So making it even more available than what the BPF guys did long ago and p=
erf piggybacked on at some point, by having it cached, on request?, in some=
 20 bytes alignment hole in task_struct that would be only used when profil=
ing/tracing may be amenable=2E

- Arnaldo=20

