Return-Path: <bpf+bounces-67062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447CB3CEE1
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 21:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756D01B22E4F
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBC72DC32A;
	Sat, 30 Aug 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/pPmuIJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F4C2FB;
	Sat, 30 Aug 2025 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756580596; cv=none; b=rMDeCFJTnOlPTg49IYq1m0Fx/mBuAGzs4i9CwjMLGEYcLnw/5XtlK2zdGNtMjUeSWIJZtERO5HWj169/9TYgcFbEf5DqsZkFQ3rhc6DXcKz+sVX57emC3WXp+NiAeOiKwGHWyKj63V4jrLezUvIe2OIQuvZmssyiaMlGHcfW2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756580596; c=relaxed/simple;
	bh=YTNFschPfH/jDG5tOrUG+B9YN7ZX8G68kfbBR+8ijUo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oYMnE/rHB/94H5LcYT6Wb0PCvNgc5GP1lcEA50GnwNVVawcddbQDLt4n6mDIyospKGlds+/EJ3q5aCoGIZ7hR53/ZsJZEINjuR1QFYblorFiq07XoXVi6C0Oxql3+Vn01g/8q60jp5LSh2TXlnW0+f5qJ8djn6K1LZ96N4A92YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/pPmuIJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso18462555e9.1;
        Sat, 30 Aug 2025 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756580592; x=1757185392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K5NU/Gvwk+CqRadGeXJpHmePNxgFh/tdJ2PWInOkOFo=;
        b=l/pPmuIJvYNFZzder8+OZ6aEsQd4adEl8VUq3yMp+4ZYhu5W6XPVjLWY3ZpEV9bT17
         Q0f07BKLP9/cE91mU6h4zs7iw+pLSxeeWatN3uj+AaxAav82qXoJWOUTGvhG6X2uTjwv
         I6keCl8zq+MQ5w9n3gCpOaKBzwRnvxDG5zQ61pplMtyRuKoAGZvVhYqyvEBUIOrha3DL
         2zr9qkGFnrChTRYUHteJK/1UaBZ58l7w4SQl1vXKy2ro1MrGZGJNM+mCHeE9PIjP/PqL
         4rnRxKdv5zbKmPw/8sa9kGH8b52SxJaWLghp2AINuH3V4aI/HiiFRQrLT7yljE7vaIbA
         WCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756580592; x=1757185392;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5NU/Gvwk+CqRadGeXJpHmePNxgFh/tdJ2PWInOkOFo=;
        b=oLW6FE66+Ww27sEs5yfxAljxzGM8gI/vkCXTIV9OY8Bi+afcmndXzm5P7G/s2cI9C/
         9rLPvtQ1vxQ7RDJF8CduxYDFhiDFipWCGF6/Ggh9ahG+5mF6cN8M5FCdhlIkv77mEV2I
         kzJPjK1Uh6kCXB8Zc6iJjQoTviW04EFbHsFZwgY+4CMC+6qh3CVtkrisVB3KA7Dsw/s6
         wVqFRhWK6HRMI/h66D4efsKkyyHegkxZkYDYepQIk/zIVSYSzCkZWt2Qc4HThgegpJzW
         5HPm9OcJKnhe3TAFElpIR3qC/RXoCCBU8Y9hM5BzQc6Cy914XRC3a+lWOr7eMsRDOWFP
         vosw==
X-Forwarded-Encrypted: i=1; AJvYcCUbClG1GoNRqPAUGZIOzOnCczGnR1S2/Brv+9+h6qsOjtdn7P0sefep+fnvKcW7C8q0iQi3HhnFyzBiXVrv@vger.kernel.org, AJvYcCW6ZZ9/ASVPSybKYb0qFgDk5VKwcv52GVQ8klPJRaRRQj+NxW2ij+F1x6QONdlpICZdcUM=@vger.kernel.org, AJvYcCXjUj5B0MqFiFbMUBzUrPy/AwBlEabF35bQkNhRYGZRtS2WUlTlmgkvlJk8dvZrkjUoEyQgPLBSWAnqpgsQykswy5un@vger.kernel.org
X-Gm-Message-State: AOJu0YwOspWiWfE+kAIdz4YLQ9UOhHo1HWBL56XDzEKNqmqEXfKioXRJ
	8RwkxAVVgVPOcesU/M8SzZ3ZPq2EGdopSMEl3aTgpyZ6a0epH8B05P9f
X-Gm-Gg: ASbGncs3mCrKQ+wkJmtVxXE+IqzU/V+v9u/x5bwH+D0olfuG5bKifqmJtMHPmWmnGDe
	oyeqOCUK6R9h+vEV12gxTSIuFiJnDwz3ShkA2JmoeGuH7n7zw9RmRWYrkJeZH2UY/AQcDaA/YSw
	8vegYzFqwocElxIBpl9530a/mYFBEk3hgFFmp2XeRCR8qJZwa1cuRYNaFqJBsBzSBvhhcyG/Z6y
	9oQ+RXFHS7N+MHHow1WnyN1o1IZaKg4op7lWQ5F/eT2cxz2gMshmtPZXNl7mBtpaoVOOfnSuqf0
	cNhcVF8n5nmujk/BUMFUti/BhDkxQlJG0cb2cN4xufBBLt2pvoQ0vyux24Jcxa+48C4HT9NKFPX
	XT6pcBtYJ8C112dEbGYN1HYlbrWDXW8oRtV7/fQ==
X-Google-Smtp-Source: AGHT+IFtHqK6ujFCTl/T3SxQDwHxkgkPlI1kLgKhwvnpMSp2W3wc5REag99t5jc2Pvi2rJIxfuXgNg==
X-Received: by 2002:a05:600c:1f08:b0:45b:765a:a8ff with SMTP id 5b1f17b1804b1-45b855333e7mr21495905e9.11.1756580591492;
        Sat, 30 Aug 2025 12:03:11 -0700 (PDT)
Received: from ehlo.thunderbird.net ([176.223.172.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9431sm8190341f8f.44.2025.08.30.12.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:03:10 -0700 (PDT)
Date: Sat, 30 Aug 2025 16:03:04 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
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
In-Reply-To: <20250830143114.395ed246@batman.local.home>
References: <20250828180300.591225320@kernel.org> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com> <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com> <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com> <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com> <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com> <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com> <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com> <20250829190935.7e014820@gandalf.local.home> <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com> <20250830143114.395ed246@batman.local.home>
Message-ID: <F8B2968D-43DC-4D89-ADD4-A92455050570@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 30, 2025 3:31:14 PM GMT-03:00, Steven Rostedt <rostedt@goodmis=
=2Eorg> wrote:
>On Fri, 29 Aug 2025 17:45:39 -0700
>Linus Torvalds <torvalds@linux-foundation=2Eorg> wrote:
>
>> But what it does *NOT* need is munmap() events=2E
>>=20
>> What it does *NOT* need is translating each hash value for each entry
>> by the kernel, when whoever treads the file can just remember and
>> re-create it in user space=2E
>
>If we are going to rely on mmap, then we might as well get rid of the
>vma_lookup() altogether=2E The mmap event will have the mapping of the
>file to the actual virtual address=2E
>
>If we add a tracepoint at mmap that records the path and the address as
>well as the permissions of the mapping, then the tracer could then
>trace only those addresses that are executable=2E
>

PERF_RECORD_MMAP2 (MMAP had just the filename);

<https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/include/uapi/linux/perf_event=2Eh#n1057>

>To handle missed events, on start of tracing, trigger the mmap event
>for every currently running tasks for their executable sections, and
>that will allow the tracer to see where the files are mapped=2E

Perf does synthesize the needed mmap events by traversing procfs, if neede=
d=2E

Jiri at some point toyed with BPF iterators to do as you suggest: from the=
 kernel iterate task structs and generate the PERF_RECORD_MMAP2 for preexis=
ting processes=2E

>After that, the stack traces can go back to just showing the virtual
>addresses of the user space stack without doing anything else=2E Let the
>trace map the tasks memory to all the mmaps that happened and translate
>it that way=2E
>
>The downside is that there may be a lot of information to record=2E

It is, but for system wide cases, etc=2E Want to see it all? There's a cos=
t=2E=2E=2E

- Arnaldo=20

But
>the tracer could choose which task maps to trace via filters and if it's
>tracing all tasks, it just needs to make sure its buffer is big enough=2E
>
>-- Steve

- Arnaldo 

