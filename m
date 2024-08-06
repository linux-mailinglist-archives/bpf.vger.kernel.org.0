Return-Path: <bpf+bounces-36470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263079490E4
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AB2282524
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA01D1F45;
	Tue,  6 Aug 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNse4MKR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8071D1F50;
	Tue,  6 Aug 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950268; cv=none; b=PSoUjf/GiyJyktbDvNq58PO7BXe8c/4LLQi8yEXG79/Mw5NnR2Ay5hv7mk4dJS7HtGUuGrmxxDil6HB85oFnWxZtG54rVZwOMEzmxJTA3NQlDHwawA5wyezkkUsk78mRKPMCH73OqFBnnSqjSIWb1WE2ZrTI51eQnCTek2MqeVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950268; c=relaxed/simple;
	bh=GgjmkdUPZeZpAYLfxQbXQ8R7Bl5oHiBhZDy+dWxdHDo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shDTMxfWd9WWrRDJuOH7qNW78BlmqCAgda8t9oYc2S8yq1mNaKq3kwPwM1UsthZH916g+RUOLWbKNrFBmRhSZmcgkokxg+JHlcK0Ky1RIICM3o0tcNJbAUX6W7iFxbh3TCV9qE00eaGc7Ak3B69ChZ1AUErbxwmOxt9SncZOVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNse4MKR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aac70e30dso62215966b.1;
        Tue, 06 Aug 2024 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950265; x=1723555065; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ocCUNlG+q7/vW2Za5R6c93ENoxlDHlio7jUu/L0+TLs=;
        b=LNse4MKRXCq0WStZ3H8GvjnFQgyjZ+EENzCUL/qfrSGwVxlEmMiiJ9fwMMX2A3+NvX
         KIarUhYnBTvnqJsgCPkM9lECqYnguC5Jzf6dZk9nRzHnDtPlFpsAHWdlhiuzfwe1am7g
         h8OwA5qyRQJK6ZYBUofQ95Ru6A3M/gc9KrRmNlUlXee/TRq6TzNfgYVYkYEb4RGCEHpZ
         FRhnNct2/zlzrEjAgZGnzoEXnAHWaZ32isPK1QXdJDb0O9S/qpWjGi47kDJBgUAZaf4s
         6rnxJVtNXTnjaQddzRoxy0Xvg3Ljr4iGlTamgnG2xygVx0PuIcaFAYGfHXlLVGGOnxcv
         HP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950265; x=1723555065;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocCUNlG+q7/vW2Za5R6c93ENoxlDHlio7jUu/L0+TLs=;
        b=Tv8cTybY471gmfo2KZdg5q2Egel75kLoNUbnV8KD8mtK3TUL8j0gJugBlfrBgOO1zB
         2FUBjiERm6oaK5Y7SxCyhKrdg+zVr7cV8znw4N7fqvHWp4o834ffScil8VvWYjgE+Adu
         f4AyrLnBUVQAjU70Hbyu3nPmo75SJlIfUJLVEbl2tVpHdMjruv2ngjSu8GBKMYvDyv7F
         muPurmwE4Ax+bb/B8OlArdy7AQDI7BOprkDseQcPOTB9D5BmcinUbZ3tllb7fpFsdaXc
         lFQ0H54gRKkxYvGRKvfHWid3Tzs8Qs0yBLkWiX30sgSsqAFPTXjvU5l34gQ96l9oHq4O
         aJkA==
X-Forwarded-Encrypted: i=1; AJvYcCX+tCpKLTTbPcBPussE0xwytJxdqAJ/6ADdinGnhttCZ1FGDOlEXgU5E6nqE5vp3sREkM+ar8e8L01mj8YEhi81WwjFYbDVgRE80sOM+v0SMJp9OypnFtVWF1Io1xvgJNNK
X-Gm-Message-State: AOJu0Yypcrco68vlKWlf7TfdT60OmFpnt6HfiTv8xLnZezjPdOZtTZ11
	clmUDYUJJFtCn2wkghINhs8CROhiTEFgevpuYmAF+VXkSu9gxWKQ
X-Google-Smtp-Source: AGHT+IHxEcII4OlQFVnCMktSEztBe5ov7CYA0cUP0kAYGD8VPn9ly9nO4mNC1jhIp7lXp5r0aRVX6w==
X-Received: by 2002:a17:907:2d0a:b0:a6f:ddb3:bf2b with SMTP id a640c23a62f3a-a7dc508f8d4mr997125266b.41.1722950264303;
        Tue, 06 Aug 2024 06:17:44 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc9dabsm546423066b.39.2024.08.06.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:17:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Aug 2024 15:17:42 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZrIiduf3FOL6j4mq@krava>
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
 <ZrECsnSJWDS7jFUu@krava>
 <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>

On Mon, Aug 05, 2024 at 10:00:40AM -0700, Alexei Starovoitov wrote:
> On Mon, Aug 5, 2024 at 9:50 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Aug 05, 2024 at 11:20:11AM +0200, Juri Lelli wrote:
> >
> > SNIP
> >
> > > [  154.566882] BUG: kernel NULL pointer dereference, address: 000000000000040c
> > > [  154.573844] #PF: supervisor read access in kernel mode
> > > [  154.578982] #PF: error_code(0x0000) - not-present page
> > > [  154.584122] PGD 146fff067 P4D 146fff067 PUD 10fc00067 PMD 0
> > > [  154.589780] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [  154.594659] CPU: 28 UID: 0 PID: 2234 Comm: thread0-13 Kdump: loaded Not tainted 6.11.0-rc1 #8
> > > [  154.603179] Hardware name: Dell Inc. PowerEdge R740/04FC42, BIOS 2.10.2 02/24/2021
> > > [  154.610744] RIP: 0010:bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7
> > > [  154.618310] Code: cc cc cc cc cc cc cc cc 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 30 00 00 00 53 41 55 41 56 48 89 fb 4c 8b 6b 00 4c 8b 73 08 <41> 8b be 0c 04 00 00 48 83 ff 06 0f 85 9b 00 00 00 41 8b be c0 09
> > > [  154.637052] RSP: 0018:ffffabac60aebbc0 EFLAGS: 00010086
> > > [  154.642278] RAX: ffffffffc03fba5c RBX: ffffabac60aebc28 RCX: 000000000000001f
> > > [  154.649411] RDX: ffff95a90b4e4180 RSI: ffffabac4e639048 RDI: ffffabac60aebc28
> > > [  154.656544] RBP: ffffabac60aebc08 R08: 00000023fce7674a R09: ffff95a91d85af38
> > > [  154.663674] R10: ffff95a91d85a0c0 R11: 000000003357e518 R12: 0000000000000000
> > > [  154.670807] R13: ffff95a90b4e4180 R14: 0000000000000000 R15: 0000000000000001
> > > [  154.677939] FS:  00007ffa6d600640(0000) GS:ffff95c01bf00000(0000) knlGS:0000000000000000
> > > [  154.686026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  154.691769] CR2: 000000000000040c CR3: 000000014b9f2005 CR4: 00000000007706f0
> > > [  154.698903] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [  154.706035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [  154.713168] PKRU: 55555554
> > > [  154.715879] Call Trace:
> > > [  154.718332]  <TASK>
> > > [  154.720439]  ? __die+0x20/0x70
> > > [  154.723498]  ? page_fault_oops+0x75/0x170
> > > [  154.727508]  ? sysvec_irq_work+0xb/0x90
> > > [  154.731348]  ? exc_page_fault+0x64/0x140
> > > [  154.735275]  ? asm_exc_page_fault+0x22/0x30
> > > [  154.739461]  ? 0xffffffffc03fba5c
> > > [  154.742780]  ? bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7
> >
> > hi,
> > reproduced.. AFAICS looks like the bpf program somehow lost the booster != NULL
> > check and just load the policy field without it and crash when booster is rubbish
> >
> > int handle__sched_pi_setprio(u64 * ctx):
> > ; int handle__sched_pi_setprio(u64 *ctx)
> >    0: (bf) r6 = r1
> > ; struct task_struct *boosted = (void *) ctx[0];
> >    1: (79) r7 = *(u64 *)(r6 +0)
> > ; struct task_struct *booster = (void *) ctx[1];
> >    2: (79) r8 = *(u64 *)(r6 +8)
> > ; if (booster->policy != SCHED_DEADLINE)
> >
> > curious why the check disappeared, because object file has it, so I guess verifier
> > took it out for some reason, will check
> 
> Juri,
> 
> Thanks for flagging!
> 
> Jiri,
> 
> the verifier removes the check because it assumes that pointers
> passed by the kernel into tracepoint are valid and trusted.

ok I was wondering that's the case, but couldn't find that in the code quickly ;-)

> In this case:
>         trace_sched_pi_setprio(p, pi_task);
> 
> pi_task can be NULL.
> 
> We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NULL
> by default, since it will break a bunch of progs.
> Instead we can annotate this tracepoint arg as __nullable and
> teach the verifier to recognize such special arguments of tracepoints.
> 
> Let's think how to workaround such verifier eagerness to remove != null check.

there's probably better way, but following seems to workaround the issue

moving the logic into func__sched_pi_setprio function with tasks arguments
and call it with NULL from place that's never executed

jirka


---
diff --git a/src/dlmon.bpf.c b/src/dlmon.bpf.c
index 73c22d56a75f..5b99ff9e0a46 100644
--- a/src/dlmon.bpf.c
+++ b/src/dlmon.bpf.c
@@ -4,6 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "dlmon.h"
 
+int unset;
+
 struct dl_parameters_t {
 	u64 runtime;
 	u64 period;
@@ -160,11 +162,10 @@ int handle__contention_end(u64 *ctx)
 	return 0;
 }
 
-SEC("tp_btf/sched_pi_setprio")
-int handle__sched_pi_setprio(u64 *ctx)
+static __attribute__((noinline))
+int func__sched_pi_setprio(void *ctx, struct task_struct *boosted, struct task_struct *booster)
+
 {
-	struct task_struct *boosted = (void *) ctx[0];
-	struct task_struct *booster = (void *) ctx[1];
 	struct dl_parameters_t *lookup;
 	struct task_pi_event pi_event;
 	u32 pid;
@@ -210,6 +211,18 @@ int handle__sched_pi_setprio(u64 *ctx)
 	return 0;
 }
 
+SEC("tp_btf/sched_pi_setprio")
+int handle__sched_pi_setprio(u64 *ctx)
+{
+	struct task_struct *boosted = (void *) ctx[0];
+	struct task_struct *booster = (void *) ctx[1];
+
+	if (unset)
+		return func__sched_pi_setprio(ctx, boosted, NULL);
+
+	return func__sched_pi_setprio(ctx, boosted, booster);
+}
+
 SEC("tp_btf/sched_wakeup")
 int handle__sched_wakeup(u64 *ctx)
 {

