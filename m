Return-Path: <bpf+bounces-42856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AEB9ABAF9
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 03:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2D41C21657
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 01:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5C22318;
	Wed, 23 Oct 2024 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P586qSRp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C231804E
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646700; cv=none; b=VpM6aR3rD9AMdScbZg5I94r4hIPnOJwIScUpJGB+W/d4f9xc8Ze4OFWgvRIH0T5rgzOohYGNrRjV8AK3+ofr5NoAMg9EsG0W3qPQquePYD+ZvarcOiCKy5sflc9Gej5vxE4K0vnr5LYlu+Y3csZRjNzBGLYkG40Q77w0sUOblK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646700; c=relaxed/simple;
	bh=hPWs2qQh8r49+Ow5gsWflRrQ0jnnYKu5fAj6FvRi9Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aH2RRfPnGjDIfzNgcmwnVKyppsxr9PRQERwAdDCXnvsMM7EiHK9O1cRbUJaHCICwLb1szY4k/ZGmN3QqMB+W3iGv0XptgbmuiGY3l2GhsW8VWTXclIcw8CU8Wv8JvqwHJsPDiu3FQGEHEC1+RoR+JbgWi0PEwzQ17kY207IWBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P586qSRp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca4877690so52855ad.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729646698; x=1730251498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPWs2qQh8r49+Ow5gsWflRrQ0jnnYKu5fAj6FvRi9Cg=;
        b=P586qSRpw7BnARK5IckGTLrmJ+bDPMBDEKIxwFTqF7gQY9pjkw2GVTloJU1eXFlH2I
         iihW3jEqBCKYRY8Buc9rrWci/8HKrX1As0AIM9OG/3/mb92DBm32grP2b5LJ+YleHkYg
         WB/cNxzdPvWIPvCLJ7MM6JUSlF5ny2nJDKtxCHB7ZLmazu75FaTYP90kr0/mPT+iYX+F
         lFY16Hh65YzDm9+YH5XMmk6t6A4A+84eQ+R4yp11/9JWH7NyGhXHAPzmKyvcTtnq9NF0
         qnN6j60t9kAM3qWdo2zJA/jvGXvkxKbSXeGFhSFyubMQbwWWC9oUjEsGxnpS2GZz9fA3
         q3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729646698; x=1730251498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPWs2qQh8r49+Ow5gsWflRrQ0jnnYKu5fAj6FvRi9Cg=;
        b=oH5pCcBmuCAoO5GW/5b8FgyarrKMA13/GycwqBspIp5qkeTzmd/5MG8BnzbdpcaBxB
         klOBqj6fbPmLU2EVpjip7DJFlSpsFKaOAsoXEKaIWDm42wRiYvFxxNCkaDIy0ycYt2W3
         lxjdEXE9kiqZXXb4GcwkLpvNd+hsVO3v0vQeQASvoH8R8S8vLtZAE8qJcg6oyamWl8/B
         QLqS/dgNNWYClgeJFyvzTdqmtZEg+Lcw2qTo0vsEG7iOy59L3JTT985SHWKqYa4rxdKn
         1Z1lteMHFAv/LFJUagKwPmF5gRaeg3a3Kv0+tzzAHqw8zQiPkxV79gltan+g1FdVyRJ/
         W80A==
X-Forwarded-Encrypted: i=1; AJvYcCWrUZkgzqRhXj1AFMvAm0czwc+eiJuIdSdpXSUL77jfHlyatLKKFVatxtb1ZQTV1DCcveA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGv4MBB3ZLkwW4qxAxuyry8SYOQJGzLgYPXYRdhl7qv/6SVbe
	SL7zRzc3aU2jn2Jibt3z3Dl1xgswdwBEAU5zQM+KZPwbiI32xKqB68cAXMRQQWwHg9uP7QskIjf
	6eZwelxYxVSSHzH1+1av5axwBgXYEzJbdJS2e
X-Google-Smtp-Source: AGHT+IHtySnFJ/wtMH4cToWtpISPBhwLBbeMZltDNENstDI3IcoaCBw3MqxqjBlZ4ARzkwwBl3+JFt43iAl+k0Nhiug=
X-Received: by 2002:a17:902:f54d:b0:20b:13a8:9f86 with SMTP id
 d9443c01a7336-20f92f581dfmr1420365ad.28.1729646697873; Tue, 22 Oct 2024
 18:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
 <CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com>
 <3362d414-4d6f-43a7-80af-1c72c5e66d70@efficios.com> <CAEf4BzYBR95uBY58Wk2R-h__m5-gV0FmbrxtDgfgxbA1=+u0BQ@mail.gmail.com>
 <1ab8fe0d-de92-49be-b10b-ebb5c7f5573a@efficios.com> <20241022202034.2f0b5d76@rorschach.local.home>
 <134aa32a-f498-4111-940a-2f79af70878f@efficios.com>
In-Reply-To: <134aa32a-f498-4111-940a-2f79af70878f@efficios.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 22 Oct 2024 18:24:45 -0700
Message-ID: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	linux-kernel@vger.kernel.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

> so we should at least get a Tested-by

I could apply this and run the syz repro script on my end if that
helps, since I already have everything set up.

