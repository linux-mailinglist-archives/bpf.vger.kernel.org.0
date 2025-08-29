Return-Path: <bpf+bounces-67019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41834B3C1A1
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE237A6284
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B12033CEAC;
	Fri, 29 Aug 2025 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvrTh0QK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C2221D9E;
	Fri, 29 Aug 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487883; cv=none; b=ei1qhNK4R85yFg8+1qRXsAJjFhtIJa8JzEp7fefvHyaMNwCokiSmWBMupB71w9poOhxXcJnR+Eo7uj9MSjKUFp0jQsrnUd4Vmc7Dkzy0UjQUSaoiH1pSXNQRcSNY6mhIOKeV1GG9TJs6uc+aFVj7tFj8j7+JcaP14jWQe65P210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487883; c=relaxed/simple;
	bh=ZN03sxhjmicQosWeGmY4JnLGwOZXXH0G5tX2JHrs4Yo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Mc2tsocf+zUln1RCtlJ2qIZsdZXCAFwaud3Q/uUrvNjyIypz9dLpvvsNOQeMJ9L+ZKqoOLeLcrBkOtHsOqceju7Oc46F6GXEof3z0TbI9bOxsAO8K/+SHElaMfnFvijwrg82p2tPd6smMwsAVkF1rCDKY3ByPJ0xjARkOeETIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvrTh0QK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so361399066b.2;
        Fri, 29 Aug 2025 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756487880; x=1757092680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xrzuRNSlyqmubW3zh5/hhg2Gt+wTZOmIedHD4WFNRfs=;
        b=hvrTh0QKBKwUISs8thiPN+QAtnUf9e0VpQgfLYR46hyYOmnbTGKrOYnDyjW7qJabah
         03T3KdvQgMa3g9WLBd27uKdSSodp09fu83Erhw9WWV3WZZPg/cjbGACQuFUocJcndNwo
         yVIRZe/8u2dQRjvhfNoX4C+vA453ky32Hovy2tEUTz+JgtFmVxbDs3aOvP34HcA1lOBK
         jihDPT1lNttFd9bzu71NI5k+0QXWdWParHd8aHOSOo2LS6V6cAFOw6z1j8gUVhNQGX3K
         CTFWQsiD+HkS9sTxbltXt+NBP/wCK9xsQJZRBVyBaxU3J2CurIRyzUGmcVZG+IUWIqmO
         Fi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487880; x=1757092680;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrzuRNSlyqmubW3zh5/hhg2Gt+wTZOmIedHD4WFNRfs=;
        b=MoUg+bd8pwXcpzSrMAoIm8K9E1Dw6GlELppbj0rIAHn9I72j0x1r7uDgmmykZsWoIX
         DUrDdJVeN7qoWLDd1WxOIiwYq+BcBqdHN21ZWWx1fDd0ruF5AMrIOqNSTpvhbUcgJ0fo
         uDfl8bcjcgHbsUEH1G9XQRbtKw9vnvfvCn0Vv0eWlDULmNMOvd01JKs9xorrz0VHLIvl
         w+q2wNfJdIgZWTjzElFCia2jZiNagfE1lebRdeks4Pa4eTMNZ25NpaxVmVaBITWVjkEJ
         D+3fqH4aIKbcH4wbxU9f21SSmNtCAmpIy9WmX8cZ2NbWSeFPISoXgG7+EFG3kCiPjbXF
         iT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZa2twsitgSY9OaMPRq83SkvZUSBsPKha6k+Svto871W5ciGsDFAnafM9yveZrTEIDGYQ0fK+qJOLLXffSwiG+eE6b@vger.kernel.org, AJvYcCVxQArDHXtqx7NpC+QAJe+Kg+RwtKQO8dLZsE7lbxy4rHk26aTfCZXD0iucXsx9Tt3ViA5SOlbNSq8DpGXY@vger.kernel.org, AJvYcCW4DjNboXTbgg4zw723nuSfgP9u2dL6iVbrzRUiHxKcD6BrUkDoy3XRkl/qIeVM5MzbBho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6SBpUprKR1gFLCzVeN7ebBTpsjajyR9fiAGoCcnBu/rNCt8ES
	UAi0OgGOSjsNTVAh0oymKz/4yKPbOmrybqfIgpb1URBM6bFBwqdk80fy
X-Gm-Gg: ASbGncuvoccJycuex1wMjohY0WJ6QXxkZ/bTHHy5t3Vgi50iBQBzuYdnlZ5uAEQyA9i
	JF3NV9UFJjDdM7eVjDXzB+wCt6AvS/KTCgFSvoclhuvXtdVdY7WfU36EEOsCm7s1eEYSWra78gn
	9mjTJWMXWYuosZ+mbdtPNUIFyOtXIyca9SteZ9jFnq+ewju2QQKIpr+3j0IF9ZE599VkrLfexoH
	OjpjgRLUF6FRpJyNOaKvC8k/uYlmZ8i92/q6zUXoSewUvFwlRL4BxHLl/KJduND878gA3ImYRcr
	ORWxT3z8cwtYSz+PjiYTuPT68n9xyVLuhhccn+9ng8TXTfW33ngbZFeDcdKFS8DkijgVUFD/766
	aEwN2TXb/PNsOxHR4PojtPDMkhggBKoQj66xvOSiH3kE/
X-Google-Smtp-Source: AGHT+IFolD4Novq7SEQgN2iErN14DtXsvntBpVAJMgWA0Dt3VXGsPTSQaYEnIZc9sb/n3S4QKp1fxw==
X-Received: by 2002:a17:907:1b1a:b0:af9:c321:7e01 with SMTP id a640c23a62f3a-afe29043210mr2312160166b.41.1756487880211;
        Fri, 29 Aug 2025 10:18:00 -0700 (PDT)
Received: from ehlo.thunderbird.net ([31.40.215.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc2d50dsm232774366b.93.2025.08.29.10.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:17:59 -0700 (PDT)
Date: Fri, 29 Aug 2025 14:17:55 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
CC: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
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
In-Reply-To: <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org> <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com> <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com> <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com> <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com> <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com> <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com> <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
Message-ID: <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 29, 2025 1:59:21 PM GMT-03:00, Linus Torvalds <torvalds@linux-fo=
undation=2Eorg> wrote:
>On Fri, 29 Aug 2025 at 09:49, Steven Rostedt <rostedt@goodmis=2Eorg> wrot=
e:
>>
>> What do I use to make the hash?
>
>Literally just '(unsigned long)(vma->vm_file)'=2E
>
>Nothing else=2E
>
>> One thing this is trying to do is not have to look up the path name for
>> every line of a stack trace=2E
>
>That's the *opposite* of what I've been suggesting=2E I've literally
>been talking about just saving off the hash of the file pointer=2E
>
>(And I just suggested that what you actually save off isn't even the
>hash - just the value - and that you can hash it later at a less
>critical point in time)
>
>Don't do *any* work at all at trace collection time=2E All you need is
>to literally access three fields in the 'vma':
>
> - 'vm_start' and 'vm_pgoff' are needed to calculate the offset in the
>file using the user space address
>
> - save off the value of 'vm_file' for later hashing
>
>and I really think you're done=2E
>
>Then, for the actual trace, you need two things:
>
> - you need the mmap trace event that has the 'file' value, and you
>create a mmap event with that value hashed, and at that point you also
>output the pathname and/or things like the build ID
>
> - for the stack trace events, you output the offset in the file, and
>you hash and output the file value
>
>now, in user space, you have all you need=2E All you do is match the
>hashes=2E They are random numbers, and user space cannot know what they
>are=2E They are just cookies as a mapping ID=2E
>
>And look, now you have the pathname and the build ID - or whatever you
>saved off in that mmap event=2E And at stack trace time, you needed to
>do *nothing*=2E
>
>And mmap is rare enough - and heavy enough - that doing that pathname
>and build ID at *that* point is a non-issue=2E


Or using a preexisting one in the DSO used for the executable mmap=2E

As long as we don't lose those mmap events due to memory pressure/lost eve=
nts and we have timestamps to order it all before lookups, yeah should work=
=2E

- Arnaldo=20

>
>See what I'm trying to say?
>
>               Linus

- Arnaldo 

