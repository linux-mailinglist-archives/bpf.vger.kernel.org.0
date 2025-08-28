Return-Path: <bpf+bounces-66877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED7AB3AA75
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DE31C8059C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C29530F7F0;
	Thu, 28 Aug 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzcgLb8w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50A24A046;
	Thu, 28 Aug 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407519; cv=none; b=I0qgnbItE+ZzpWW59GnbM8W+5Sosoe5HhLNdXxK/vGI4Zv3Nfcazcwc0pQkZAsDsrCuzZTMrEwQ80Tkb9NHo2a1Zt/zP9JKx1Ki6dfLG1ow1GtnmH6Je1up+wH1pI4wWqvtvGAB5yoZajx/qR2q33SjFJXQSriyhlhN9/lS/DaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407519; c=relaxed/simple;
	bh=IxXZLW5YRaQXDKsKqhMccCfVWB0cOQeXz11/xBaGb4U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KoT/iWNBgvPjW+A/baaK4OvnlXeMWx8Y7ffvjf6SSAa0C41iNQuTY/swcMnXmWjb9QCKwHMXYVsejyWacO38SXeKS4rN15R1DP6M7y7/rvZu5j1koOWBVyvb477E7yC4bJdEiqMCV5s5U9tqFryhLHcDbJA3iP5hLR8Yi/BX2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzcgLb8w; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c51f0158d8so1238264f8f.1;
        Thu, 28 Aug 2025 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407516; x=1757012316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V2A2T1aBXvS6raiA5m6JInWztUvuG91mbi2N6+NgQ7k=;
        b=WzcgLb8wnv3P5zjtuOo9SXwBY1BbwyChr2WApfgR1G/8utyngT4NyfRTOoA9U/Fiir
         v4+nAiJUMS3r30i29yc1fapaYbtHjroxbnzINwOeEuyeogoCa06dmMnmk8V+xdqvHe6L
         rgObVII/0IMKmCHasjJU9aX9C/sT/2i0tPeWoTHeKOYPvJdLjb4dcp2utahAvNw+KAw1
         ih88rzT16zfiMxyV40KbY3Otlnl3tTTMeri1K4p36n7MXah3cBKqp14/AJdy6kJCojpB
         8EBjpWujgIEx5YOBf4ShXm+aMyYnHnH4teGV7gOgC3alruOWuKblqlR4qyveYyO5eEH6
         tN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407516; x=1757012316;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2A2T1aBXvS6raiA5m6JInWztUvuG91mbi2N6+NgQ7k=;
        b=J26oI/2O2a811FdcS+hVNqCM5gbfl5O0d0DpcDT7vnSXU0O2LdGjNhmC/kiQ5+SAey
         MlqKrnoIercJ1UFiSR1IcSa2g/itc7JDvpxKEG7bwvI2hDN4E6Z6SLeTm43KW/BV8Z1Q
         xKcIBGUyhEd/CeahcILW5utqnvZzSxdrCaUtiP9df22OKNt/UCGbNbabTC3A76sV4XSF
         0th+B4wfGDOeIVoGYUxVur6TNXObrtWDJqCOSnnBF4wV2WC6QXY6MqDmldKzWWkGOcIl
         T2xEKCDMcrGI6RJiVmjYD9w16W2UlE+D+741iuupNaHfiFH6EU8MFE4sFYIM9TOJhrsD
         mxrA==
X-Forwarded-Encrypted: i=1; AJvYcCWdlto9axYTfdQqqxfpAXg8GkZfUJh9XZO04QNRXnnwTKRkZgALVXZgrukpok5HVIYTuj0=@vger.kernel.org, AJvYcCWqUr3MvJdnwz0EwGFNGaGHZxnXl/kxwIk5FBRb4IF9WKq7St+H25Jy4mhntTR+7XN4X3VnZR4EOo46K8cEgYA0RMe0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Zcrg9ilJdiivN20xpvAwEf+zPDt4FidoK04+ZJ9YAoKKjUNu
	w+jq2FtwD9xZ5C3RsLIW9gTAR6RoZ4bT8Qp6J1HRHmUeOHiOrC06+SQe
X-Gm-Gg: ASbGnct3x7OoR5wNgYrO/JtfRYdFK8CJZXQCMWII+CUsXfTuoUNLFee/1c9NQrAJkWw
	MDPFqzi7RjW2JylMPdrS67KyXq7mg4TXCDsEg3MggYs8s2iA1/zZlMjA1F4ev2DXghqn6oi+Yzd
	WZYVgaZ043g/usJo454umKZHFWeW59aNDdAslx2cIJMZWlyQlIoTATRoeDok/81ZJ/5oZeVejt5
	q8wQgxwv/GuC2nSAQ+JiV59jIxzMft9SO5gYaqmY00LDlI+IugP1V6Xfhuw2S4nLPtXxFTHCsWE
	frTkFsWznNcVdACKMu/b9Zn4qW+EPB3mb08RSo2wLZnGN+QNbDwTOfP8WnA/5JxT6Mipps03ThY
	FRlnATiPiTydJjOkmb0MVDVO3NzoR9FtbnvrRVfCwE3mi3ROA
X-Google-Smtp-Source: AGHT+IGnV+jYxlnwCv2UjdGqX4kvgDjdhTU+rkDe75AiD/ts2ftz02g63tOQa4OP1Ou2UM66jQP90w==
X-Received: by 2002:a05:6000:2c02:b0:3cb:2fbb:cbec with SMTP id ffacd0b85a97d-3cb2fbbcfacmr9045552f8f.2.1756407516132;
        Thu, 28 Aug 2025 11:58:36 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.255.128.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33adf170sm372473f8f.33.2025.08.28.11.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 11:58:35 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:58:31 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@kernel.org>
CC: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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
In-Reply-To: <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org> <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
Message-ID: <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 28, 2025 3:39:35 PM GMT-03:00, Linus Torvalds <torvalds@linux-fo=
undation=2Eorg> wrote:
>On Thu, 28 Aug 2025 at 11:05, Steven Rostedt <rostedt@kernel=2Eorg> wrote=
:
>>
>> The deferred user space stacktrace event already does a lookup of the v=
ma
>> for each address in the trace to get the file offset for those addresse=
s,
>> it can also report the file itself=2E
>
>That sounds like a good idea=2E=2E
>
>But the implementation absolutely sucks:
>
>> Add two more arrays to the user space stacktrace event=2E One for the i=
node
>> number, and the other to store the device major:minor number=2E Now the
>> output looks like this:
>
>WTF? Why are you back in the 1960's? What's next? The index into the
>paper card deck?
>
>Stop using inode numbers and device numbers already=2E It's the 21st
>century=2E No, cars still don't fly, but dammit, inode numbers were a
>great idea back in the days, but they are not acceptable any more=2E
>
>They *particularly* aren't acceptable when you apparently think that
>they are 'unsigned long'=2E  Yes, that's the internal representation we
>use for inode indexing, but for example on nfs the inode is actually
>bigger=2E It's exposed to user space as a u64 through
>
>        stat->ino =3D nfs_compat_user_ino64(NFS_FILEID(inode));
>
>so the inode that user space sees in 'struct stat' (a) doesn't
>actually match inode->i_ino, and (b) isn't even the full file ID that
>NFS actually uses=2E
>
>Let's not let that 60's thinking be any part of a new interface=2E
>
>Give the damn thing an actual filename or something *useful*, not a
>number that user space can't even necessarily match up to anything=2E
>

A build ID?

PERF_RECORD_MMAP went thru this, filename ->  inode -> Content based hash

- Arnaldo=20



