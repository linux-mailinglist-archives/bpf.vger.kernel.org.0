Return-Path: <bpf+bounces-43183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7000E9B0DFF
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 21:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AEB1C22441
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF720EA49;
	Fri, 25 Oct 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNaPU6kk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6520C324
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883344; cv=none; b=rvAFDl8GDi/dCgtcgBs26QlJ2xTegn2E9Idcggrm9o4aOZQoeOrVwPBwKKsXgqnwAptRw8pCBNr3L8KfsjbIve8LjDzgTizV95UQPKekUit/dqTwdyqIol6VeJZXoJZewPVwkz7o4Efgu0+l6hfx1sUteOarPW0zbq+koBT9gzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883344; c=relaxed/simple;
	bh=eC/AFAYbf2dDY+8QOFJqZMSAG5tIud/WX+F+rwJdJoE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X2B9IfZPyWm2QDQTkqrsZ8Oz9hYA1P/Sctq8chkcHusVr8kUbrHr1U0HIopSgdC5FiMixQs9J3/UPnNhcEQl69Vzegs7Y8PhGXu5fyzpEeNoU9xPnc5h70M4uNLtA+yJ+0jqWR/d7+xaYaFfCYuhFkq0Q9Qzqk0PobHAr9rDC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNaPU6kk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2e2e02817so2025186a91.1
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729883342; x=1730488142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVWRF1EhwqPVh068E6HWf23D6UaTV/C79XZYsswklao=;
        b=zNaPU6kkNmHrc/O8iwNiOwzSuvEcs8bcIIybPUegMzjT9ywdL0T78Xq4iEPSELBWF7
         eD49LCrvdRGcy9+mvMNr1XjhAywQySIOvXEUHQ4qC7RkQqJUdr9kuoEWLQiaIPKSewvo
         or7U+o0lB/4Vuoq9dOxxu1vUK9e18WwuoeKN8Y0iBOC4hXJHc0dTdpAO/syvjr1k3loe
         8PQF9SbHPudZ6k8Hvk6Nr33y+ALewy3up5b0GD59b1yo/QnJhOVu5EJcSisX/fETgZvZ
         ReOk2chyTWF34f5evM/xSEnKyBfQw2OC6OIqAJUrGaX/hUZic8HR2ZBOla9kH7hDsCxO
         txyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729883342; x=1730488142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVWRF1EhwqPVh068E6HWf23D6UaTV/C79XZYsswklao=;
        b=t6FqzqDyDgbZuN/Tfxar4jbsZ+GAHPB+6pnRBUnuCnLab9wy9doZPJSO138JdyGdil
         oGfA4MOhActkNgMGaXPFB35ejb+EQABilIh5OHlwdz+2xhi2J+kw4G+oIc3uvurnELNa
         Kr3+rKKD/KyI1dwP7SWBwh4NOgtY6zZSV1trwKGYX1gb9NzlDtewOrPMpBPjRVh95uZ+
         0qKxNrG99mC0XmMmT69xHNYILXZWrtDNcPV9I7CfmrN8xUAGG88/b/7+Y5CBjKQ2ftJQ
         EDmDsEXzZdtVQ3iwgJMUDYS3FZvwk1xxgeCUXfc6ONmXIQdG2fWsdpjNxTNG/gvBKglM
         EFbw==
X-Forwarded-Encrypted: i=1; AJvYcCW0WMrbs/2DIOSHh7do4hvxvWlzVY0hE1AE8MrBgVMc1tsLo9XxHaqXk8z31tmTvs5Qxcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0TFgejLv60QaL0PHvFEvS2xbrK2PjfrykEG0cJr2D6Td7NpSw
	FbvO5jr1rh27kChoRSbr93Ixtf3rO2/GGYIsAGb6FZWxHB2I8IxwyUjNGR09aE0lOATuBlgtVQ=
	=
X-Google-Smtp-Source: AGHT+IHJvRe9BLo2HN0m+AxXH/BvYMMn7BIpiifD1eWAlC2PY4kjjioOtPMWBI6grulhDzsPYO6sUfue7w==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a17:90a:c90d:b0:2e2:a810:c3e4 with SMTP id
 98e67ed59e1d1-2e77e90a214mr13074a91.4.1729883342024; Fri, 25 Oct 2024
 12:09:02 -0700 (PDT)
Date: Fri, 25 Oct 2024 19:08:54 +0000
In-Reply-To: <20241025182149.500274-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025182149.500274-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241025190854.3030636-1-jrife@google.com>
Subject: Re: [RFC PATCH v1] tracing: Fix syscall tracepoint use-after-free
From: Jordan Rife <jrife@google.com>
To: mathieu.desnoyers@efficios.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, 
	andrii.nakryiko@gmail.com, ast@kernel.org, bpf@vger.kernel.org, 
	joel@joelfernandes.org, jrife@google.com, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	mjeanson@efficios.com, namhyung@kernel.org, paulmck@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 59de664e580d..1191dc1d4206 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3006,14 +3006,21 @@ static void bpf_link_free(struct bpf_link *link)
>                 bpf_prog_put(link->prog);

I think we would need the same treatment with bpf_prog_put here.
Something like,

tracepoint_call_rcu(raw_tp->btp->tp, &link->prog->aux->rcu,
		    bpf_link_defer_bpf_prog_put);

static void bpf_link_defer_bpf_prog_put(struct rcu_head *rcu)
{
	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
	bpf_prog_put(aux->prox);
}

Alternatively, some context would need to be passed down to
__bpf_prog_put_noref via the call to bpf_prog_put so it can choose
whether or not to use call_rcu or call_rcu_tasks_trace.

> -static inline void release_probes(struct tracepoint_func *old)
> +static bool tracepoint_is_syscall(struct tracepoint *tp)
> +{
> +       return !strcmp(tp->name, "sys_enter") || !strcmp(tp->name, "sys_exit");
> +}

I'm curious if it might be better to add some field to struct
tracepoint like "sleepable" rather than adding a special case here
based on the name? Of course, if it's only ever going to be these
two cases then maybe adding a new field doesn't make sense.

-Jordan

