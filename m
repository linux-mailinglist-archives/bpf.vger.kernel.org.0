Return-Path: <bpf+bounces-42796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C529AB3A1
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005E6B20FF9
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0DE1B86EF;
	Tue, 22 Oct 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7YqV452"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311171A76D1
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613686; cv=none; b=fTeZamA/tACFUXxXQUjyF2r/6AA7gauEJlJx96jjRd+h9wbkAbM6meCEUjdOnO//yMvzdYMRkfatG4T0Nkr/wHhHeFoFZzaVOpea1Py1pkkhjYCuV0s6U93qV46l6aOxX4eB0LEHj4JTBb0wQQGTa07AF6yopJ2l3WbsABCSRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613686; c=relaxed/simple;
	bh=uQyLKf/KjMGIsuCylbyZv2NLqsDYwh8/jixtnFeFZ+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEtuhSRu14hV3/8o30fJ2fi2sbYWe2J52qaM7UN5a1xsm1S593MhScqLKBQWBna5hQxdpV+jegM6CGbhllwD5HOivr+P5+Mg5X9fmrF4V4121x0lWnNmmaFHmxybeHCFY/af1tpDB0EYZynKQu0+0p8lltBmFb0a+aGZISWGCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7YqV452; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c87b0332cso199935ad.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729613684; x=1730218484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uQyLKf/KjMGIsuCylbyZv2NLqsDYwh8/jixtnFeFZ+0=;
        b=I7YqV452NoPx1tk48NK1iezUpnwGQuuQPryJ/EUgtJcf84f4m2voI7Wieiu5pEbSxj
         PlgWvWl0tsw1jA7V/2RJsCqwDfnzwMhj7kYZleuCRgS1ncFb6kkd3DNjtnBI8aH+BfcP
         T4lijDP/12uc3RJ/+uTXQzyOjgXHI0/xUoA1+5OlevdTOBSSe5gZkwQ5o6OMERk5vWer
         Nik1IXCqubLRI4KmV0Dypgt0IdcG4k5PNQUQiC1BpLY+kIIaxEDNGjH+YFZ1JtC62dIk
         LoIeP+EaFVKuF1mpC+oWrswuw/EJbnHJ+jkxQdo6Dl5VtCZIoe3kdVBgClZQ1UQu1VT0
         Oj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613684; x=1730218484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQyLKf/KjMGIsuCylbyZv2NLqsDYwh8/jixtnFeFZ+0=;
        b=rvwsg1maB4aDh+BVemKINw00ScrdfuyVBfKl19Lrh4sN8UPSYwHwhzSmZFHvSPkog4
         aShqn5TJQp9qJVm2sNXGHht6vuH+GOr7b/xN6GhU+iGaU8vfYTCrojOa3gjJ7w6kBjYM
         NMWvEbB947kXA4YQIt7F8ZTnqkkve7a+X/L8ru+JhD/VroqXSvQu56PFY/IwxhoC1W+z
         ZgqUPgfkfNq3rgbpH8P8DsNEab8VqsKvyO8+g7afjm8oM2hyftYHcahfBzsgOvspADXo
         odr/IgOCS4xRs6gq3HPB/Gj0F/WGP1V2ZRvv3MDJmqWMAoyV0wNoMDuZjMfHn7/XjLOU
         ghYw==
X-Forwarded-Encrypted: i=1; AJvYcCVf3eA/vxIKKHZdmu3ISXAns5HOKcmqCc2nZg8P+4Nbhq/wt0y4/5K+a8W6CmzO2GZiUJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0QoZzUvpHzw7I+EJib9KZF8kkbG28t1e2JiK9yEAKrU29TP9r
	CYni848eRcnL8pTEfzf2iD5ToabmErt1sBY5EENZGdiTnN7u/8dl33K0U8+YTt2QHUTytS3rrRk
	7TYjWDoYjaZ5qzDp44wbWd+8U/0wmt4/Zh8/0
X-Google-Smtp-Source: AGHT+IEk2C5VN5OQSxU2RTl/uiQOLCjAufw/n0qpTfSTknlIOJDwl1tjcDLh9OBuWTOSWITRPJuHGqKMAHTJwO/i8Xg=
X-Received: by 2002:a17:902:d486:b0:20c:e262:2570 with SMTP id
 d9443c01a7336-20e97fb41fcmr3516165ad.8.1729613684229; Tue, 22 Oct 2024
 09:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 22 Oct 2024 09:14:32 -0700
Message-ID: <CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

I assume this patch isn't meant to fix the related issues with freeing
BPF programs/links with call_rcu?

On the BPF side I think there needs to be some smarter handling of
when to use call_rcu or call_rcu_tasks_trace to free links/programs
based on whether or not the program type can be executed in this
context. Right now call_rcu_tasks_trace is used if the program is
sleepable, but that isn't necessarily the case here. Off the top of my
head this would be BPF_PROG_TYPE_RAW_TRACEPOINT and
BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, but may extend to
BPF_PROG_TYPE_TRACEPOINT? I'll let some of the BPF folks chime in
here, as I'm not entirely sure.

-Jordan

