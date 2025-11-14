Return-Path: <bpf+bounces-74546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5D7C5EF06
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0095E4F52CA
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3BF2E229C;
	Fri, 14 Nov 2025 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eje56H6T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D5287504
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146173; cv=none; b=UqgHP6MXvjlf4bcvN0fTnxPHPcTlvrTuLGlsR8JQl+BNFy2Hb7H6sh3k6H/OTTbdGiOmVQfOhP67kjxxQ5xjldKbCZMQd1Mls4Hc5NhWYLHymjwdiqqw3FOFC3LKeeFRMaRBkY2aAgBkp6YR3W4UHgAzl+dXGAQSNCWsg/yrN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146173; c=relaxed/simple;
	bh=rz7j/UJDrxKMl9ZSMZkRQVVJppyfO9y7PO+WsuJt37w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTwLgmxZ7FRyzsczwBIW25ak1FIdEx4QHXLmTL9zmrZ1T86VTv5yROJMGZOUxvPmOyRmntC00F+Lgcho9As6WljPsvTUCeGOtlsj9gqCV2jXjeOUm7ZvltbD8VfKLIHy70EoWd+cPVVzlzF+VXZbFcsmpuvB2xsYXWuQzFebUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eje56H6T; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29852dafa7dso18845ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 10:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763146167; x=1763750967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TufH33LR1+FbRs5TTnZXWGBvkJzQgtKHJFV9C+DmjZs=;
        b=eje56H6TdCGDBpPBlyNHa5/3U0RnNI7qsdNThMg9bzdq5OLFPkqk76cq+dtGZoPBHK
         hk2yr8+dqKDbcNVOm6N7cP3WGLqkC+V8KCUEsSIDfNWWsxM2x+6Pb2xlnV3Mk3GW02bQ
         jypkLTKT2iCYI3jANQz2/wGPZeYW1ZYbibty0A2+8XSRZZqSRLWWrzMP+RNn0Q8y71AV
         ypeBnxtXZK8v+ODMQXjTP6qDD9Xeki6qiFs/xOSQqJFEsh/o9UJ+0nu/FFh2Qyc2p+D0
         d2JaOddNhdpLIjankEVQjmraKPxQTiBjMXjN8nwxmk2uYy+TEkMcz1zCxujvDT8w7DX0
         PjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146167; x=1763750967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TufH33LR1+FbRs5TTnZXWGBvkJzQgtKHJFV9C+DmjZs=;
        b=Jt/+W7nkwIn+HwvJM7vb5VvG2HmeQ2Qc3B2BSE2AV/pSp/WKsALc2wnkeCybxMqd8N
         jNN5Z8gH7Z43DIHpcy6eJHwyIDbKvOJElQfsY/CoplZDZXGb7UOvudgIUbTHnMy4okLX
         97bGjEaQm1020KWBaL0Om4UnPAW4WIu/13FgeqZ+j45eAIoWv+QYZWOxEZeCos3j5VTg
         sPPLC5225szIn5OGPEDehE+vHovfWDoaXW4iDkOtkY83r1vX53T/BNuyo4Sa3+MoBzKZ
         JhXHX2XV4UceHm5Bfs2AX1sOL4+5E33LaQIb7VHM02KX9uktjR1nK6J4ZtyzLIc4awj0
         NYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI0pt49+mivJUxtvmrsTLaT2htvsz3HWHLg3p+7lkba1bLRe88HLJBtjWokV0zxkKYpkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyByAKDKGGSvMo11b8u4xXn2+aqZcorSzX0jXBgJw2OAyC1h4cq
	dPuobuEEMavxXj+ObYEbtgs/5aXdVTfqxWgnaDDg28/amsPX3YtY3EOXTISreMPDHx4K3kqHAtL
	Kl8yxkUdVwTkoVV2ViDMNM2cMVkEi3LU+/QBNhduy
X-Gm-Gg: ASbGnctiOOVlMg4HAE7BGBsdJzB6FJ1Cc8/Xd1Yxk1JZ4ZopBSicAZbWS8kDx/6quoP
	8r79++o+TMKZxD1aaQQu6M4bKgEoWnbAiXEwuCuslMoSO+ovB82MfLu01NhS+iBrPAUqYH2sV8J
	M/C2HEf9e+2szzU4HgnlH+OT3HlV/rXIjUENNQtdVe9sGxU03VP3rYkQK8gy3CWJDJzGVHPQ3kH
	WMuVVUp43nPzjz2krqX43RvJnsSlvTXcg9+LZd47SOfpAD1VcLt4L53bIY9NIDeM0fRQKlcxAmm
	zTJSHR8Tg+38Sju3iAT94CVfH2GXd7DxYQA=
X-Google-Smtp-Source: AGHT+IGgLMzFBg4dvat4vkWEc7+bSgPYzKPBYdw5lt+7F4/qZIFGnBSHgtP2NlwkFQJ5dDAQrZRX0fSaUJ3hA4n2Fk4=
X-Received: by 2002:a17:903:41c3:b0:295:1351:f63e with SMTP id
 d9443c01a7336-299c6b2473dmr179205ad.10.1763146167172; Fri, 14 Nov 2025
 10:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114070018.160330-1-namhyung@kernel.org> <20251114070018.160330-4-namhyung@kernel.org>
 <CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com>
 <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com> <20251114133009.7dd97625@gandalf.local.home>
In-Reply-To: <20251114133009.7dd97625@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 10:49:15 -0800
X-Gm-Features: AWmQ_blrNkkumPpA1qnlt2x-BsuC-2KXfWdvtWTL6qKsCtowllFahNliI9kmH3k
Message-ID: <CAP-5=fUF78K6TVnqa7gZoriTzymm1yjSY=jVuocZBn4t5aXS-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf record: Enable defer_callchain for user callchains
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:29=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Fri, 14 Nov 2025 10:09:26 -0800
> Ian Rogers <irogers@google.com> wrote:
>
> > Just to be clear. I don't think the behavior of using frame pointers
> > should change. Deferral has downsides, for example:
> >
> >   $ perf record -g -a sleep 1
>
> The biggest advantage of the deferred callstack is that there's much less
> duplication of data in the ring buffer. Especially when you have deep
> stacks and long system calls.

I've never had anybody raise this as a concern with fp stack traces,
especially given the stack snapshot approach being far more space
consuming - but okay.

> Now, if we have frame pointers enabled, we could possibly add a feature t=
o
> the deferred unwinder where it could try to do the deferred immediately a=
nd
> if it faults it then waits until going back to user space. This means tha=
t
> the frame pointer version should work (unless the user space stack was
> swapped out).
>
> >
> > Without deferral kernel stack traces will contain both kernel and user
> > traces. With deferral the user stack trace is only generated when the
> > system call returns and so there is a chance for kernel stack traces
> > to be missing their user part. An obvious behavioral change. I think
> > for what you are doing here we can have an option something like:
> >
> >   $ perf record --call-graph fp-deferred -a sleep 1
>
> I would be OK with this but I would prefer a much shorter name. Adding 20
> characters to the command line will likely keep people from using it.

Fwiw, with buildid-mmap we just (v6.18) flipped the default when the
kernel has the feature to use it. The kernel feature was added in
v5.12.
https://lore.kernel.org/r/20250724163302.596743-9-irogers@google.com
I don't oppose a shorter name, callchain option, .. Unfortunately with
`perf record` -d is taken for saying record data mmaps, -D is taken
for a start-up delay option, and -G is a cgroup option. Perhaps '-f'
for "frame" and have it mirror '-g' except that deferred is default
true rather than false.

Thanks,
Ian

> -- Steve

