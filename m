Return-Path: <bpf+bounces-42903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E30B9ACE0D
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8697B1F21A74
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3D1C3050;
	Wed, 23 Oct 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNbHzR+D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E744C77
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695410; cv=none; b=NSal0D66IVClPhC5UBKYeyFY23vcbvioaTk7lfXcgMPQRpyb+FxaZ+IOgh3EjZrdfyUed9so9ySLZYAeHZOOgCDXQInMI9ceXR6RlO6js1mUxHorwyAQx/V0TUF/XrhpqSyC9WgVLZugvD/f7vGFQNXs8r3YA9W6pg/AJC32DEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695410; c=relaxed/simple;
	bh=ptmZDvkwk1dlZZHF3sSEJb23B+Vm+jVnM2oEGeFa8n8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=thb8VXTrTzrWbGhnKkU5ytduZFuOiphkLbcSOs7zEN6eWxaEDyyVwVLnqEZhRbMp7XdnQ9CsFvBpTE5g4fgbyi0/ekNo1eMzBeN2IvLgqorlDKhQfVeDYee/kcJ6RkNAzv172B9bw+BZ+ftKRvRC7AJvXzc4Oib3UudcL/EWs8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNbHzR+D; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32e8436adso101137637b3.0
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729695407; x=1730300207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgaswDr9377UgJkF9RUwn/JbwOmuFoGsuXW/UAuTh4A=;
        b=dNbHzR+DngKSNyMpj7YNlmhXoNiSfUeDYL6aDh/ih94KOrAqoI79HRtofcBE4d5x2m
         VzdOpUc4dlFvn6O0oefegeJ+QHp1VCevxjpqb8/b1cnjnTKN5dYYeljRh2JSro0tdhsx
         t6lyfIfxp16izAoY3h62rFLC5App08y3zSYRl513JU4FKXa9/Hy6Pv03fHM6PBbkDwTN
         eny1Vfv+lqNJ764x0a/yw+nbcfecRYgr3u5CyDJgxCZ0YuDgcH4tMIZjijALfOfm0uzL
         W6j0lYbyOGQjvpZgp4Vr1ahl0Au8+IFT0SlKUqz17+PCXLuT59+H0PE8TRLWjd7pn2BC
         qY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695407; x=1730300207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgaswDr9377UgJkF9RUwn/JbwOmuFoGsuXW/UAuTh4A=;
        b=ZZsQkO2OtPnub0gunJ4S0pNREb4STM/NBFoxEAeJN2wrda5lbtsDYcwiHd+upxlOK+
         KFxl9c6srvdWIcFoS49i9w20MncdxdirPF69pP+S3x7sreFW+wKvP70VX9yuPB0cvA5G
         V7VN8aOoiCjCsDiJH9Kbyw758x+N178ENygbLEIjCBuUq31P/C5kGOhhPh3ZQfmQVkjN
         clVpbtUjg5lqbt/HtIw/ttVV8HYUR+vVv4VHS2Hr03+LROu0h5Fyk2Iv3xLSgwyINRO6
         gZhjzzxQX4qyUlay6fnysCOBWcjYTJ7vFn/avHCVB4a5VFt9EbkREPJcqut7wXUR2pCt
         qt6w==
X-Forwarded-Encrypted: i=1; AJvYcCVMQAFdXyhzFnh/MPN7xhzOva4nOLevJldz4iAKvQ8T+LGe2ai2JTIJbVS9AbkRsYDx0sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhF08fKgxIJIPPSA1Z7V2FD7ND3K4nqxXPczjPJMtOeRQgVECl
	sYyMwdSlRzWthnKhFYOfd6ytuZqQYibadet5igDCBmXF340iFbbbVha2NXwwrzLn1pHdor2h8A=
	=
X-Google-Smtp-Source: AGHT+IG2dlK1Ev/Vsqg0a9+y2Ar7sngcF/YsF2Rx55eSC0VVg/FSve6nPnKDv6D/OGPYOVXh0bDBCSBe6g==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a05:690c:4b90:b0:6e3:2693:ca6b with SMTP id
 00721157ae682-6e7f0db7b71mr1156627b3.2.1729695407531; Wed, 23 Oct 2024
 07:56:47 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:56:40 +0000
In-Reply-To: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023145640.1499722-1-jrife@google.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
From: Jordan Rife <jrife@google.com>
To: jrife@google.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, 
	andrii.nakryiko@gmail.com, ast@kernel.org, bpf@vger.kernel.org, 
	joel@joelfernandes.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mingo@redhat.com, 
	mjeanson@efficios.com, namhyung@kernel.org, paulmck@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"

Mathieu's patch alone does not seem to be enough to prevent the
use-after-free issue reported by syzbot.

Link: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google.com/T/#u

I reran the repro script with his patch applied to my tree and was
still able to get the same KASAN crash to occur.

In this case, when bpf_link_free is invoked it kicks off three instances
of call_rcu*.

bpf_link_free()
  ops->release()
     bpf_raw_tp_link_release()
       bpf_probe_unregister()
         tracepoint_probe_unregister()
           tracepoint_remove_func()
             release_probes()
               call_rcu()               [1]
  bpf_prog_put()
    __bpf_prog_put()
      bpf_prog_put_deferred()
        __bpf_prog_put_noref()
           call_rcu()                   [2]
  call_rcu()                            [3]

With Mathieu's patch, [1] is chained with call_rcu_tasks_trace()
making the grace period suffiently long to safely free the probe itself.
The callback for [2] and [3] may be invoked before the
call_rcu_tasks_trace() grace period has elapsed leading to the link or
program itself being freed while still in use. I was able to prevent
any crashes with the patch below which also chains
call_rcu_tasks_trace() and call_rcu() at [2] and [3].

---
 kernel/bpf/syscall.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 59de664e580d..5290eccb465e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2200,6 +2200,14 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 	bpf_prog_free(aux->prog);
 }
 
+static void __bpf_prog_put_tasks_trace_rcu(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		__bpf_prog_put_rcu(rcu);
+	else
+		call_rcu(rcu, __bpf_prog_put_rcu);
+}
+
 static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 {
 	bpf_prog_kallsyms_del_all(prog);
@@ -2212,10 +2220,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 		btf_put(prog->aux->attach_btf);
 
 	if (deferred) {
-		if (prog->sleepable)
-			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
-		else
-			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
+		call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_tasks_trace_rcu);
 	} else {
 		__bpf_prog_put_rcu(&prog->aux->rcu);
 	}
@@ -2996,24 +3001,15 @@ static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
 static void bpf_link_free(struct bpf_link *link)
 {
 	const struct bpf_link_ops *ops = link->ops;
-	bool sleepable = false;
 
 	bpf_link_free_id(link->id);
 	if (link->prog) {
-		sleepable = link->prog->sleepable;
 		/* detach BPF program, clean up used resources */
 		ops->release(link);
 		bpf_prog_put(link->prog);
 	}
 	if (ops->dealloc_deferred) {
-		/* schedule BPF link deallocation; if underlying BPF program
-		 * is sleepable, we need to first wait for RCU tasks trace
-		 * sync, then go through "classic" RCU grace period
-		 */
-		if (sleepable)
-			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
-		else
-			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
+		call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
 	} else if (ops->dealloc)
 		ops->dealloc(link);
 }
-- 
2.47.0.105.g07ac214952-goog


