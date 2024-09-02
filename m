Return-Path: <bpf+bounces-38727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06502968D14
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39302825AB
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B568B1C62B2;
	Mon,  2 Sep 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vv+5ZrNu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419651A2640
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300635; cv=none; b=cOMieq5666n/a2hLWa3MyLw5g8fP8f7j49YBPQJhZTzxTGnLle4ItlXlbs7F1v8GSToSbYaELNmw8J5CC2zXXV9h1Mg6tZK0pvqm3c8DIUpUg+EQ41+ZsqlXJiwd+oxRiSfS0pcXZ7xZQCMEfWwcS02uu921zgH3nhAAk7KEzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300635; c=relaxed/simple;
	bh=HgOn/3IiUVhbrjJvM1lNiNzrymo/kFrhHrJKVu/yhaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkxGrkIy2ggcrivJ2FLiZY0ezraPPxuYsbW4Zv7lG/HiStdaGnStmv4kC5VigHyHAmUVEMeFamEp3vO7WwR/u82hSEkHmXHlV0uQ7ocipHeVgjw3EG4uWEv1Kl4AcpCe3ARbXP7ZRu7cK3iKYTNkFB9+ob+uAEoeW261y76YHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vv+5ZrNu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86a37208b2so518755066b.0
        for <bpf@vger.kernel.org>; Mon, 02 Sep 2024 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725300631; x=1725905431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tKnOa4A90IoF/EoF6/zH6Ks3lMs+xeYBCb2/giypxQ=;
        b=Vv+5ZrNuSqe6+OZ3IkTaUjHYIIa2QFrkcOy21ZW3mrK5MEC03QmVGLMEs4/Cx9AYhm
         WjET1WT09cz/qSS0j7IXl/JzzsYdRnlvuaz9L2OSyK9p1yXwarSta2I9w1BsWMosPozR
         ClzL9MCpGOjdw1bZr6n7kOkk4y/4iE2jYws0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300631; x=1725905431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tKnOa4A90IoF/EoF6/zH6Ks3lMs+xeYBCb2/giypxQ=;
        b=RLChOKEnp9dA2E9A67r/HzsQ0m5Mw+8bGli9ftcJzgYnM9eLkOd3Nom0KXfdjyeW2f
         szS+JICzrbaJ5UOYZK/+JFPlv2A+QA3V1J16hRq6l5XExxwHmAuoo/nsf5ZTChVsUT1a
         +f1esxk0sIfl9i4eZ7yzaJTxZgWVo0ZeS4OQHD4nPCUxZ46H/vjFM66jpBU5PaB3wQ1G
         EPdtPJH7dutUJyKbnt800FU01LFa9aC0H0HbalgbQ2BihMHFwSEcJDOwyV6L2qBh+hPn
         E6bYauLQjf3DdCezBv7gTGi9wwtNpYR5u1FpaiNIqNDDbyPMJXIFcq9kC0ZOfRsad951
         3AEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnDgKr6PBWKLOIt+ZbPP76CGPkw21H/rvn2aqGQzZFp61cpS1hJDzbwkfSIxZ3Ty5qq6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxN0uGls2g/wgl3WcmswmKNLhETp0eSbR9hqIOcMGzahJud/JK
	TuZIU/yub23fVX7zLvCD0rQ8BrZcGwglZwBGJFbA8ipEDJq/ERt8r9q3ftL6uDnEOHMgVv7gUMG
	yJbw=
X-Google-Smtp-Source: AGHT+IF1bAL4lMj57JOHP3A+Zqk1fgjbOSSHhbCJS7DPAUZrHos1rMn/yVagtwtRh2y6PxRavWlOcw==
X-Received: by 2002:a17:907:7256:b0:a7a:a30b:7b93 with SMTP id a640c23a62f3a-a897f77eed8mr1237792466b.2.1725300631137;
        Mon, 02 Sep 2024 11:10:31 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891968f4sm582572366b.106.2024.09.02.11.10.29
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 11:10:30 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so4369998a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Sep 2024 11:10:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvHdjWugZHLgUNwx0dj/s8e6w5ZWxy2PmaTxwD3Eg4khz0urkP3qBYOSs9y5ndc4uZmaQ=@vger.kernel.org
X-Received: by 2002:a05:6402:3595:b0:5c2:50a2:98a2 with SMTP id
 4fb4d7f45d1cf-5c250a38f97mr4049161a12.6.1725300629265; Mon, 02 Sep 2024
 11:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com> <20240902154334.GH4723@noisy.programming.kicks-ass.net>
In-Reply-To: <20240902154334.GH4723@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 11:10:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whef03dn8OWJ01L08hShVHCieVz7Rrzr1HJQOriVBvaDg@mail.gmail.com>
Message-ID: <CAHk-=whef03dn8OWJ01L08hShVHCieVz7Rrzr1HJQOriVBvaDg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 08:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> and Linus took objection to similar patterns. But perhaps my naming
> wasn't right.

Well, more of a "this stuff is new, let's start very limited and very clear".

I'm not loving the inactive guard, but I did try to think of a better
model for it, and I can't.  I absolutely hate the *example*, though:

  void func(bool a)
  {
        DEFINE_INACTIVE_GUARD(preempt_notrace, myguard);

        [...]
        if (a) {
                might_sleep();
                activate_guard(preempt_notrace, myguard)();
        }
        [ protected code ]
  }

because that "protected code" obviously is *NOT* protected code. It's
conditionally protected only in one situation.

Honestly, I still think the guard macros are new enough that we should
strive to avoid them in complicated cases like this. And this *is*
complicated. It *looks* simple, but when even the example that was
given was pure and utter garbage, it's clearly not *actually* simple.

Once some code is sometimes protected, and sometimes isn't, and you
have magic compiler stuff that *hides* it, I'm not sure we should use
the magic compiler stuff.

                Linus

