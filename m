Return-Path: <bpf+bounces-70074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95419BB012C
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 12:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3343B7130
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 10:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2072C11F8;
	Wed,  1 Oct 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzHFmtNw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47493296BDB
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316315; cv=none; b=Epv+62pPEw8bVfvxWVUv/mDJPs9X1QvLCvilrQ/aWtreJgpRh+t6KzNI5I8kc6/XzKGPmAtksUC7L1yH4AJ2gfnR5PhkaDfnH/8BZqk7mtMdJp2RH/y5AFE2hvpevcBjYbsmrBxREMgwnstadKDi+Ig2Jd08hzOuVUeEEK1Wdzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316315; c=relaxed/simple;
	bh=/IYSV63F/1m3PQjyG9fAEJ3srxPO2l7np0mTFe5/Tzw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvDU/tgyO9lViitCXpNhvKqYNiX++tGVqgJANvuP9j8b3NFomb572hs2GcetXocjBtMabojWpbAD/3WriFqQcVBMN+LcxzlUNkpaKYBUJjaImPGYPSiSrx/u0DW0cKNeNnyNX+IeTnIyMHD5w7z+EANPiIg9T3rlBkNODhMyiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzHFmtNw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so47460855e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759316312; x=1759921112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgTf8OFmZbVt9M6n37Tqho0gXB+F57yDDcMKmNn8RI8=;
        b=FzHFmtNwD1xd+ZU9W0RowK5UoDpwXGWhkptj9C7LBvnuhRGGJ6ER9AeJLwNmycQuaI
         KsMquDpdqa5cTwHD8mLsGJLfZebRAw1G7KXjqCxvUXwWOwab+y8OlM5M4gcTtG8fu8Di
         rnZEgZFdeBywNpCxv7Zug4A1u6oWiec0+Yt7Qn7Kjhiq+e0kLSI3nSihXN8e9KPuFmqK
         +Rqc17FS1EnBGXGR0cyt4Ic8o5xnUa3F+qrI9zo2omtru4SiRyr6gyLNAEc0ncRBXv0q
         /+i3/RxMQfO45KXh8SWsAzA7qMjzge9u7Zeps8lK/9E+Z9Ku8uCxRa1XN2Xo6QLwxyEy
         DoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759316312; x=1759921112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgTf8OFmZbVt9M6n37Tqho0gXB+F57yDDcMKmNn8RI8=;
        b=CDVSjfhdCZ5PmD3AIOgHS0bNbF7vABCMvs0ooQ2JVtWdc1uPvH5Vqq27JTp+SvpTIE
         tSKaK1IsImoue4TPK4688WnW8WYSRvJSU3fGrChrSrKnYqE1dTIWWVUgHGnSj9GwLo+V
         OE8xV+Sxy7BW5VmVfFm6qHPOI6nEDdjXCzg4ApJaOiDxDM1OJ02cpYCFWSTOrZsJI6jO
         Ip2GhiloW34+gWgv1dKd7BDqJ7Yysv/wKiGzE0yKpAKi00PbXTQUBL2HJqU1WMpmLGSx
         WLFsplU/4Ubsk9tkJo9Qoq4OkJVpBa8kGKDQKOv992Kets0PIV2sBjbzmVNpMxKuFXoD
         LVxg==
X-Forwarded-Encrypted: i=1; AJvYcCWA4IO1DEQB8dwiJtR/aNA8TVT2GSefC1JdI3QB0WUcHVqlRAtGX4fJjt/jqslQ/nK8JZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx2LrUhd4MhL+4+yfL1WL6QrwWJHxKaFt3c1Y+ZDSZ+JLQZuD9
	3RNF6jwZv+mJv/ScYGqnap+PHXLEg/43knRUsA1eSr6J3cOiZ+2bNeze
X-Gm-Gg: ASbGncvtRuCSxC18o2t4xIck3KyUD+QvzBwObegV5r1FRFaV4rDrKQL1AtW2dLvDB7c
	6EtWVGekMHPQdHQZEtMNvABK2Qqj4Jpk0ZsdOFN7a0Zp+ZJZU5seDdugscwfNXK1Z8RqRR5AuLO
	Hl7BgYsQILsbzwhSBVOa7rvgYtodd5frRXwfv1f652kO1f9/df+LRwqS9qTEr4spY9nX9qGKM2o
	3N+IK/72xmsyLUw2s7+WOMIYRRATqEZztwXmT0HFg7pGqJNE5LGmylPKQwJmOBUrFUmp6fEng1/
	suBnyNdsnkKKVs5BAVvRlFQ2piQnF7xKmw24unmX88fJKyA8wyyVA1F44OuYzu6UMtDXW77izPR
	G9FFfj++7MeUGfCusWCxn
X-Google-Smtp-Source: AGHT+IETvY4nPwFmCDnck2+Me06qm/+E1HwxuuyzfVMchJwNS3fwOfFmJvBmtJ4GPxRZiTy3sRbd6A==
X-Received: by 2002:a05:600c:820c:b0:46e:4882:94c7 with SMTP id 5b1f17b1804b1-46e612cb269mr24565545e9.28.1759316311314;
        Wed, 01 Oct 2025 03:58:31 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a0204fsm34308255e9.14.2025.10.01.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 03:58:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Oct 2025 12:58:29 +0200
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	peterz@infradead.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	mingo@kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] BPF changes for 6.18
Message-ID: <aN0JVRynHxqKy4lw@krava>
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
 <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>

On Tue, Sep 30, 2025 at 07:09:43PM -0700, Linus Torvalds wrote:
> [ Jiri added to participants ]
> 
> On Sun, 28 Sept 2025 at 08:46, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Note, there is a trivial conflict between tip and bpf-next trees:
> > in kernel/events/uprobes.c between commit:
> >   4363264111e12 ("uprobe: Do not emulate/sstep original instruction when ip is changed")
> > from the bpf-next tree and commit:
> >   ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
> > from the tip tree:
> > https://lore.kernel.org/all/aNVMR5rjA2geHNLn@sirena.org.uk/
> > since Jiri's two separate uprobe/bpf related patch series landed
> > in different trees. One was mostly uprobe. Another was mostly bpf.
> 
> So the conflict isn't complicated and I did it the way linux-next did
> it, but honestly, the placement of that arch_uprobe_optimize() thing
> isn't obvious.
> 
> My first reaction was to put it before the instruction_pointer()
> check, because it seems like whatever rewriting the arch wants to do
> might as well be done regardless.
> 
> It's very confusing how it's sometimes skipped, and sometimes not
> skipped. For example. if the uprobe is skipped because of
> single-stepping disabling it, the arch optimization still *will* be
> done, because the "skip_sstep()" test is done after - but other
> skipping tests are done before.
> 
> Jiri, it would be good to just add a note about when that optimization
> is done and when not done. Because as-is, it's very confusing.
> 
> The answer may well be "it doesn't matter, semantics are the same" (I
> suspect that _is_ the answer), but even so that current ordering is
> just confusing when it sometimes goes through that
> arch_uprobe_optimize() and sometimes skips it.

yes, either way will work fine, but perhaps the other way round to
first optimize and then skip uprobe if needed is less confusing

> 
> Side note: the conflict in the selftests was worse, and the magic to
> build it is not obvious. It errors out randomly with various kernel
> configs with useless error messages, and I eventually just gave up
> entirely with a
> 
>    attempt to use poisoned ‘gettid’
> 
> error.
> 
>              Linus

I ended up with changes below, should I send formal patches?

thanks,
jirka


---
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5dcf927310fd..c14ec27b976d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2765,6 +2765,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	/* Try to optimize after first hit. */
+	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
+
 	/*
 	 * If user decided to take execution elsewhere, it makes little sense
 	 * to execute the original instruction, so let's skip it.
@@ -2772,9 +2775,6 @@ static void handle_swbp(struct pt_regs *regs)
 	if (instruction_pointer(regs) != bp_vaddr)
 		goto out;
 
-	/* Try to optimize after first hit. */
-	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
-
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 6d75ede16e7c..955a37751b52 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -661,7 +661,7 @@ static void *worker_trigger(void *arg)
 		rounds++;
 	}
 
-	printf("tid %d trigger rounds: %lu\n", gettid(), rounds);
+	printf("tid %ld trigger rounds: %lu\n", sys_gettid(), rounds);
 	return NULL;
 }
 
@@ -704,7 +704,7 @@ static void *worker_attach(void *arg)
 		rounds++;
 	}
 
-	printf("tid %d attach rounds: %lu hits: %d\n", gettid(), rounds, skel->bss->executed);
+	printf("tid %ld attach rounds: %lu hits: %d\n", sys_gettid(), rounds, skel->bss->executed);
 	uprobe_syscall_executed__destroy(skel);
 	free(ref);
 	return NULL;
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 4f7f45e69315..f4be5269fa90 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -142,7 +142,7 @@ static void subtest_basic_usdt(bool optimized)
 		goto cleanup;
 #endif
 
-	alled = TRIGGER(1);
+	called = TRIGGER(1);
 
 	ASSERT_EQ(bss->usdt0_called, called, "usdt0_called");
 	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");

