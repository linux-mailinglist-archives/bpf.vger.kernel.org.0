Return-Path: <bpf+bounces-67547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5478B4553B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CE35C2564
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED842D7398;
	Fri,  5 Sep 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6uFc0oU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD430BF75;
	Fri,  5 Sep 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069192; cv=none; b=AxvS76ilbU4ub3e3S/MVz/LxuPe7WSKn/JhTsueaoskmhIhSarjA+6PR/lWeo2gGsBDRW3VV+HEr2yN86rD28obwKFr/NSLtTneyl/BEgG/lXsJ/l4fd2I0F/EDjnOBTp7KbQbjaPTmyRx1kepFT9P2NgNT4aWXD/fMa5N6syZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069192; c=relaxed/simple;
	bh=2jDfkRqUXqIeW8rjmLccCKlkfZ4pgZLPN7avonJFtBw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avdZNGSULaBshZWc9ptll65/kv8wRbwlyx2dZiBf6I9gieV22gd7WWsA2KcFaXLL1Us3fIXSOUv9P7jmMzlxPAKsB0Fro8BlO7ACbTAdIaMBcehdQEnCveu/WOmHCvHXkq7paq1JrV4FUoqI2MXG4bu5m/1UCW20+I47//di3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6uFc0oU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so2678262a12.0;
        Fri, 05 Sep 2025 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069188; x=1757673988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wi0gCQUeW9y8aeoflBmbq5YYWWP1GgOP5LlJZk0s3WM=;
        b=E6uFc0oUFBgmyK+cdiI2cndltCtNl5+ISk2DtroqjxcJDUeV0vh6nN7K1q3mO0x2i7
         B6L9pVSFQbOv5CqNWF1fOrfkilZz8UwhLCM1UtglHz1C3hRXE516dGOq41A4NUVt+CoS
         9aghnoPEpDcUSXIayY8p7k1RuN5Nlixd90y2r4YGB92hDiI9eQEJneF/wmBuLWfFX9db
         Me7lRdt2ovRKZrDoHoU0tXuwRCSWKwt2xoOjWZ5brvEf4L27lrARXQzR1+aShehoIp4U
         er0lZuCX1RY+CfAYTcz6aEGwhnE6nPGPPgJlkI8AKsi3N7+zB1MEY1VOsIHyYIuowoJF
         V3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069188; x=1757673988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi0gCQUeW9y8aeoflBmbq5YYWWP1GgOP5LlJZk0s3WM=;
        b=u8CrV6GYv96e65eL/7hHeyR6ALoVPsyURA2/Dk/YFa8X4Faqkmuu/C1UiRCV1dKkuF
         XesPAwwsvDdePAq3QaI8QWg23CyvUQbSWKWmVGok1KE9uwDi7TPdK27lqiEdu4yz4eM/
         tajZfYUP9/630hsAywXU/XzQ6Ji59YEItFzmuRs8MVLo+BAM0r0FMnSLx9ma8PuDVcmS
         2k5eI6SB7gIH+Qbah92fh/efFEjL0/Vp3QqGjeu/Cn99pZbRSRP95xMP/6F4mbjISrbw
         LPCwmInBo3RsDfOuYJeUdT7qHTe32DLcSzbum/+4Q82drnA00ZL5cTN1FDOs2aOkkoEk
         vr2A==
X-Forwarded-Encrypted: i=1; AJvYcCVsmIyLeWqUGO45zSErMPYFZoaeb8Eb1SwmQKGkDKwhB5n3tBEziFOULu3lpWbOGepzftX0cv159mEB2cka@vger.kernel.org, AJvYcCWDYhn3YF/U9NYTZ/UaQgb8KrbQLqB0z+sbuL5TbKdWn435VhbLsGYrON2iaBnj/j9MHfQ=@vger.kernel.org, AJvYcCXk+gDIDhmVNmR3gybfVt/LeH+U6xp09c+oedrWIg81x8UwXY2/zZi/Ydqx19dmftNsIE0+kg1plPID3cEXi+glXJLi@vger.kernel.org
X-Gm-Message-State: AOJu0YyHrWnDgG1lru3ejrpSA1SZtyJgHWJXHXyXHASg27Z+EK5P6hf5
	4uu4QjCmeXO1gXP8/QpDYFiknMj/hOU7RGhFP4EYcl1M7OSQQfc44DI/
X-Gm-Gg: ASbGncsOYPoac5anIz063Ej2F8mjauMVbigWzWPBjxXA4cHN4Z9FLt8R9wNc5YM9P02
	kGhgkerkocT2dt48RePySnzOwiFFWHqqNWD65B8MIkrh0K9k0XGrFh0S8KE4i/DwrEYkozM12dg
	PdRT8eGhgFe4Nww0aKskt5oYSRYFqnNVQkpsYlODr0PRD8JAoAPucA+RxezHlXO9gGA+EwZL522
	ZkE4PDLCXPqaHvq+oGYzrsUtpgmkGDbQiUDeEJCwWdhojHLiV9M552vkSwqj5Rc4MxZpMsSvFrC
	lYmRnSRTvxDBnq3BBJR/tzdyL0TPFxIllK30eWjkcJrYohq2NXscHPFwmBTGatERHReO1AsG
X-Google-Smtp-Source: AGHT+IF96or+JtjZxMIo+jN0zmKDj2Mk8YR867t+x8zz2+qlVl0kzvhAnG5KnysjAKV1MNgQPkV7Og==
X-Received: by 2002:a17:907:3e8c:b0:b04:5385:e26 with SMTP id a640c23a62f3a-b0453851563mr1417168366b.58.1757069188014;
        Fri, 05 Sep 2025 03:46:28 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0409bf055esm1517769966b.85.2025.09.05.03.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:46:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Sep 2025 12:46:25 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <aLq_geGpgBKKfI7e@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLirakTXlr4p2Z7K@krava>
 <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
 <CAEf4Bza-5u1j75YjvMdfgsEexv2W8nwikMaOUYpScie6ZWDOsg@mail.gmail.com>
 <aLlGHSgTR5T17dma@krava>
 <CAG48ez2BBTiDGT1NNK2dfZLiYMF-C75EAcufcVKWtP+Y4v-Utw@mail.gmail.com>
 <aLmcFp4Ya7SL6FxU@krava>
 <CAEf4BzbPSTEKs2ya6-d5ecR=wdsRtxRwLJO0r+oEm-_R-B2_yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbPSTEKs2ya6-d5ecR=wdsRtxRwLJO0r+oEm-_R-B2_yQ@mail.gmail.com>

On Thu, Sep 04, 2025 at 11:32:06AM -0700, Andrii Nakryiko wrote:
> On Thu, Sep 4, 2025 at 7:03 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Sep 04, 2025 at 11:39:33AM +0200, Jann Horn wrote:
> > > On Thu, Sep 4, 2025 at 9:56 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > On Wed, Sep 03, 2025 at 04:12:37PM -0700, Andrii Nakryiko wrote:
> > > > > On Wed, Sep 3, 2025 at 2:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > >
> > > > > > On Wed, Sep 03, 2025 at 10:56:10PM +0200, Jiri Olsa wrote:
> > > > > >
> > > > > > > > > +SYSCALL_DEFINE0(uprobe)
> > > > > > > > > +{
> > > > > > > > > +       struct pt_regs *regs = task_pt_regs(current);
> > > > > > > > > +       struct uprobe_syscall_args args;
> > > > > > > > > +       unsigned long ip, sp;
> > > > > > > > > +       int err;
> > > > > > > > > +
> > > > > > > > > +       /* Allow execution only from uprobe trampolines. */
> > > > > > > > > +       if (!in_uprobe_trampoline(regs->ip))
> > > > > > > > > +               goto sigill;
> > > > > > > >
> > > > > > > > Hey Jiri,
> > > > > > > >
> > > > > > > > So I've been thinking what's the simplest and most reliable way to
> > > > > > > > feature-detect support for this sys_uprobe (e.g., for libbpf to know
> > > > > > > > whether we should attach at nop5 vs nop1), and clearly that would be
> > > > > > > > to try to call uprobe() syscall not from trampoline, and expect some
> > > > > > > > error code.
> > > > > > > >
> > > > > > > > How bad would it be to change this part to return some unique-enough
> > > > > > > > error code (-ENXIO, -EDOM, whatever).
> > > > > > > >
> > > > > > > > Is there any reason not to do this? Security-wise it will be just fine, right?
> > > > > > >
> > > > > > > good question.. maybe :) the sys_uprobe sigill error path followed the
> > > > > > > uprobe logic when things go bad, seem like good idea to be strict
> > > > > > >
> > > > > > > I understand it'd make the detection code simpler, but it could just
> > > > > > > just fork and check for sigill, right?
> > > > > >
> > > > > > Can't you simply uprobe your own nop5 and read back the text to see what
> > > > > > it turns into?
> > > > >
> > > > > Sure, but none of that is neither fast, nor cheap, nor that simple...
> > > > > (and requires elevated permissions just to detect)
> > > > >
> > > > > Forking is also resource-intensive. (think from libbpf's perspective,
> > > > > it's not cool for library to fork some application just to check such
> > > > > a seemingly simple thing as whether to
> > > > >
> > > > > The question is why all that? That SIGILL when !in_uprobe_trampoline()
> > > > > is just paranoid. I understand killing an application if it tries to
> > > > > screw up "protocol" in all the subsequent checks. But here it's
> > > > > equally secure to just fail that syscall with normal error, instead of
> > > > > punishing by death.
> > > >
> > > > adding Jann to the loop, any thoughts on this ^^^ ?
> > >
> > > If I understand correctly, the main reason for the SIGILL is that if
> > > you hit an error in here when coming from an actual uprobe, and if the
> > > syscall were to just return an error, then you'd end up not restoring
> > > registers as expected which would probably end up crashing the process
> > > in a pretty ugly way?
> >
> > for some cases yes, for the initial checks I think we could just skip
> > the uprobe and process would continue just fine
> >
> 
> For non-buggy kernel implementation in_uprobe_trampoline(regs->ip)
> will (should) always be true when triggered for kernel-installed
> uprobe. So this check can fail only for cases when someone
> intentionally called sys_uprobe not from kernel-generated and
> kernel-controlled trampoline.
> 
> At which point it's totally fine to just return an error and do nothing.
> 
> > we use sigill because the trap code paths use it for errors and to be
> > paranoid about the !in_uprobe_trampoline check
> 
> Yeah, and it should be totally fine to keep doing that.
> 
> It's just about that entry in_uprobe_trampoline() check. And that's
> sufficient to make all this nicely integrated with USDT use cases.
> 
> (I'd say it would be nice to also amend this into original patch to
> avoid someone cherry picking original commit and forgetting/missing
> the follow up change. But that's up to Peter.)
> 
> Jiri, can you please send a quick patch and see how that goes? Thanks!

seems like it's as easy as the change below, I'll send formal patches
later if I don't hear otherwise.. we will also need man page change

jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0a8c0a4a5423..845aeaf36b8d 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -810,7 +810,7 @@ SYSCALL_DEFINE0(uprobe)
 
 	/* Allow execution only from uprobe trampolines. */
 	if (!in_uprobe_trampoline(regs->ip))
-		goto sigill;
+		return -ENXIO;
 
 	err = copy_from_user(&args, (void __user *)regs->sp, sizeof(args));
 	if (err)
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 5da0b49eeaca..6d75ede16e7c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -757,34 +757,12 @@ static void test_uprobe_race(void)
 #define __NR_uprobe 336
 #endif
 
-static void test_uprobe_sigill(void)
+static void test_uprobe_error(void)
 {
-	int status, err, pid;
+	long err = syscall(__NR_uprobe);
 
-	pid = fork();
-	if (!ASSERT_GE(pid, 0, "fork"))
-		return;
-	/* child */
-	if (pid == 0) {
-		asm volatile (
-			"pushq %rax\n"
-			"pushq %rcx\n"
-			"pushq %r11\n"
-			"movq $" __stringify(__NR_uprobe) ", %rax\n"
-			"syscall\n"
-			"popq %r11\n"
-			"popq %rcx\n"
-			"retq\n"
-		);
-		exit(0);
-	}
-
-	err = waitpid(pid, &status, 0);
-	ASSERT_EQ(err, pid, "waitpid");
-
-	/* verify the child got killed with SIGILL */
-	ASSERT_EQ(WIFSIGNALED(status), 1, "WIFSIGNALED");
-	ASSERT_EQ(WTERMSIG(status), SIGILL, "WTERMSIG");
+	ASSERT_EQ(err, -1, "error");
+	ASSERT_EQ(errno, ENXIO, "errno");
 }
 
 static void __test_uprobe_syscall(void)
@@ -805,8 +783,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_usdt();
 	if (test__start_subtest("uprobe_race"))
 		test_uprobe_race();
-	if (test__start_subtest("uprobe_sigill"))
-		test_uprobe_sigill();
+	if (test__start_subtest("uprobe_error"))
+		test_uprobe_error();
 	if (test__start_subtest("uprobe_regs_equal"))
 		test_uprobe_regs_equal(false);
 	if (test__start_subtest("regs_change"))

