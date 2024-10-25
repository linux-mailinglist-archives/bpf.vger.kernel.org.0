Return-Path: <bpf+bounces-43166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74999B0701
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F831F23D8B
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A61494B1;
	Fri, 25 Oct 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdCMcX7Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B021B860
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868469; cv=none; b=ro7STBPbuWnNV6pePDqUlZpPittVd+QcMfiXHpNk+SCbZNFHQih6dN5c9WFv+iMWBt3FFjPz3l4LxE7X8I7OK3ZpY4NURoXptB1NnhPwYCPzEALyGCD6gnwKbB6zXBarqksbvdMKREhGyVapSDL6nKGao7vI6xHS51emKkB4Tf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868469; c=relaxed/simple;
	bh=JnDq/cXDweLg3Xq/lPIrdn2Qyfxu5cN+MQ9TiJRj/sM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LoEG701zvtyuxYqyB1pzbN5DY1VepZjSsbuSyDSPvzRvJKfSY7c8h1hjPxHd0CiZoo8kLYbpfMyXdCci+EUMTtx0FLsoUvr7Izc222RJECMej19DYlSlsQ0GzCyVCyzvIoqjL4KK1zdWik+RX2qyu/fdIw+ZRbMRVOn5WCzSunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PdCMcX7Y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35bdb6a31so44718267b3.1
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729868467; x=1730473267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbcaaMQgVIC0j7P3IOBL2keqvrSuEW3gZvvAWAWwf8M=;
        b=PdCMcX7YGwTreejC8wk3rQtEhl8OXQgnzmh6VSjy8Bv1UdGDnPGW3Uy6Ni9boKLI5A
         y4LWjBmTgBUegTk1df5mnU/gGXaseN6rnMhfoChHrx0Z+gdXckpGXca7d0ebc8xOLCB+
         7Op/g73JHbXx0EXXUmhIewg4q6wVbVpRid6Ga7+vmKHswiRzVmFNPspjE6lm0XSKA0VO
         t5A/0JBbM3sa/t06bP06pk40Kydh01CoufiJkjz3yww6nA2pEmCLkqCi8PRSzwj7j/18
         eJcmfpPiSz49lzBcT3itviIrYsIumfudtIYFntsN6N5LvUlsxt/PqZQbm6CONqM1wolP
         VTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868467; x=1730473267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbcaaMQgVIC0j7P3IOBL2keqvrSuEW3gZvvAWAWwf8M=;
        b=WrSd/3rdZnY2rjlQ/xbCXVNzZldlyq6kTDMqw/j2v2tHVfUon56JW22GmhhdUul7B/
         zbJpatKWgITmG/fbJ9fYpuzFPeUueFThvb8UJwSPWjPNIlDac6EJyXyFbT06aoVzZrVP
         /+iQbU45ptvh8MeYioJcdw8Fuj5xj6zyJY13cBStGCQvt/UeYABGUSvIosindR06miPp
         jss4yVcgYzADe8K0rekGvrNtraaVGHL101ntONyG95Lgi1Bn0cQNWY5glBsUOQ3vRPnW
         On5SoEUQ8KxSqh7AIlcxJOM54cm7QJmdh/EcZ1GNnwmM7zl1QhKSYzO2kbwAPxcLW87x
         iNMA==
X-Forwarded-Encrypted: i=1; AJvYcCWXpsl/D+FdpRCLYJlaNirUYZuCF47YSRLDJ/2aO53wRbr/HAOkA2O65tWiMpUtsVDCEEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUszLwzStVE5FgyhBa3h6Ey5qVch+2+NLcFD/eP8XUOmEn9yw
	ydyoJu2dMDA/C6oPQZa83WxYi0tOzAxbEbYlr1WcHJKQ8fBRzUNUnDzzcRy3UOkSYrlhSdH+nQ=
	=
X-Google-Smtp-Source: AGHT+IHTxnhOnZMjpPA9oXurqzuSlt3xx1/oPi27olT7Ce+WGo5Vk8FIGSdLkZzDlRRjWvtg3cTEW0MozQ==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a05:690c:6488:b0:6e3:da91:3e17 with SMTP id
 00721157ae682-6e858149d43mr1789177b3.2.1729868466633; Fri, 25 Oct 2024
 08:01:06 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:01:02 +0000
In-Reply-To: <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241025150102.2930213-1-jrife@google.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
From: Jordan Rife <jrife@google.com>
To: andrii.nakryiko@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, 
	alexei.starovoitov@gmail.com, ast@kernel.org, bpf@vger.kernel.org, 
	joel@joelfernandes.org, jrife@google.com, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	mingo@redhat.com, mjeanson@efficios.com, namhyung@kernel.org, 
	paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"

> One solution might be to teach BPF raw tracepoint link to recognize
> sleepable tracepoints, and then go through cal_rcu_task_trace ->
> call_rcu chain instead of normal call_rcu. Similarly, for such cases
> we'd need to do the same chain for underlying BPF program, even if BPF
> program itself is not sleepable.

I don't suppose that tracepoints could themselves be marked as sleepable
(e.g. a new 'sleepable' member of `struct tracepoint`), which could be
checked when initializing or freeing the link? Something like this,

static void bpf_link_defer_bpf_prog_put(struct rcu_head *rcu)
{
	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
	bpf_prog_put(aux->prog);
}

 /* bpf_link_free is guaranteed to be called from process context */
 static void bpf_link_free(struct bpf_link *link)
 {
 	const struct bpf_link_ops *ops = link->ops;
 	bool sleepable = false;
 
+	if (ops->attachment_is_sleepable)
+		sleepable = ops->attachment_is_sleepable(link);
+
 	bpf_link_free_id(link->id);
 	if (link->prog) {
-		sleepable = link->prog->sleepable;
+		sleepable = sleepable || link->prog->sleepable;
 		/* detach BPF program, clean up used resources */
 		ops->release(link);
-		bpf_prog_put(link->prog);
+		if (sleepable)
+			call_rcu_tasks_trace(&link->prog->aux->rcu,
+ 					     bpf_link_defer_bpf_prog_put);
+		else
+			bpf_prog_put(link->prog);
 	}
 	if (ops->dealloc_deferred) {
 		/* schedule BPF link deallocation; if underlying BPF program
	...
 }
 
static bool bpf_raw_tp_link_attachment_is_sleepable(struct bpf_link *link)
{
	struct bpf_raw_tp_link *raw_tp =
		container_of(link, struct bpf_raw_tp_link, link);

	return raw_tp->btp->tp->sleepable;
}

where if the attachment point of the link is sleepable as with BPF raw
syscall tracepoints then wait for the RCU tasks trace grace period
to elapse before freeing up the program and link.

-Jordan

