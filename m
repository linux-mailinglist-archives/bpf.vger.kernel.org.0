Return-Path: <bpf+bounces-34275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4A192C387
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADC11F235AD
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B43180045;
	Tue,  9 Jul 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvhjbADz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2880BEC
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551290; cv=none; b=pNm7z6juacOlnEwqW0s7YsQYVJBJAtR5BpSq0/Naap1K2Dlktu2ExZIKoyzswMGOX6JxFijRzFJNUfUL6tY3iOZ87JDq99A5St4xg1U5lNqKdNxdw9hP+FVomy3xiIpETK/+pTFwsIQqjZctwEbGyKf6wvspk+7+fZ1+274Yo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551290; c=relaxed/simple;
	bh=RahUBiBUflntvQSG5uX0jwQgMYvTRitArUq49NX/pmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5ZKmmpVucrNgauVTlW2/a6Ok7FHd5pImEX1xAwGjoFtr/NESMLtF+ir9i82+0zz1I25xCXMm54EiUPg47b0p6QC7024UWqWTuuN1s+U06X5GicFX+carMVmjvgyKjeck0RZVKBYqqKRDbVssMYCjKBFF7zAEk+u1l0O6hUB9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvhjbADz; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso1121187a12.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720551287; x=1721156087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+fw1e5SH9nIbK2cUJKSrmY4kRz68P658pM9I6xknIc=;
        b=GvhjbADz8m4Gl2DYWRRLwZl9sg8pI6ji9RS+CULIMMiEbSkVtzPrnvC+ep1JfNJdjO
         q5zeeZNr2azyH7yj+FwUaS3kGni23sPO4c2DRNsOkWSuy3sIAoPsWdLfiWlwHDJiezVI
         yY9HkyUmT3Z/ZZ2ENxSYbpV2+KwgjfuBhGOJb9m/czUPdyQF5pxH4MzdvBoeadGs/zXu
         Z6QaYRpGBfaIZbgOvh2RBaVvP2Bk4M9bScexqBAWtrW/gEzWvjOKAjsY0zyopXRKvYRv
         ie9sKgexiud1/AIpsDGJaYtqS/9yQsHKh64rBIWrymri/XgKc8zDD+zMpoWJnlXrJtN8
         ChzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551287; x=1721156087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+fw1e5SH9nIbK2cUJKSrmY4kRz68P658pM9I6xknIc=;
        b=OS2A37EsDAvWPK/yAICFiuYN6PY9Yp0Dr+dEk/V7lx1vq4KghciJi9zcJ3FiCVmFUp
         voQkcthVkrKxY0CBpQ1V1mpiljcW4qfoRUKtc7TS34c8Qlm+BCF/fZu3vrnIX+7MK5Yd
         5de2F3UG2WHnEYxhYhwrxGBRG3SEQbsCgX7bggq6pwCdKRf4wU8VLZuJTiHWOcDjSSFY
         0Z0bxrRg7GfYG6NlW4mmu8HHcTNb0sWycQvUqYnbKiMPjpxsptdO2nbrZoeQfK7tQZRw
         dGMSlyVdZIzquqOSJW7yGGNbBCqMyUtvIWbkwL4Oj2uf5DJ1bukNR70lgNxiO9fQd/Z2
         wRXw==
X-Gm-Message-State: AOJu0Yx/Qle89EoSPoAp8+exzG8y1bkt7eRFmuqsPfQ6VF1H+kUG1LaJ
	jlr4pJHIrk67ZyL0fyv0d1LQVhRVRl6mnD2d0C4qDbkYLVYJyXQ6dGPcXpGw
X-Google-Smtp-Source: AGHT+IHmEude5iSrT1sGFBcq00V0xZSCp2gKGGMJWJqnM8Fc0n9W0TiMbnJeHUd7J99PuHEFdOfm9Q==
X-Received: by 2002:a05:6402:13d6:b0:58b:b864:ec77 with SMTP id 4fb4d7f45d1cf-594bcab03a8mr2960298a12.39.1720551286760;
        Tue, 09 Jul 2024 11:54:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2cc76sm1341735a12.21.2024.07.09.11.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:54:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Dohyun Kim <dohyunkim@google.com>,
	Neel Natu <neelnatu@google.com>,
	Barret Rhoden <brho@google.com>,
	Tejun Heo <htejun@gmail.com>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf v1 0/3] Fixes for BPF timer lockup and UAF
Date: Tue,  9 Jul 2024 18:54:37 +0000
Message-ID: <20240709185440.1104957-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2675; i=memxor@gmail.com; h=from:subject; bh=RahUBiBUflntvQSG5uX0jwQgMYvTRitArUq49NX/pmQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmjYULdOf/bSpTzmLMdV3jU0LvfFAsYRvuFhibR N1IM4OlQ0aJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZo2FCwAKCRBM4MiGSL8R yp2pD/wJOntxilJZ0D9S3mMLlNVZAXzZ4SnUbiWtc2yd08LEqZBIENcsombZA+a6hxqWdCx3MUj aFx77LZpWupcI4RwHpDTIAUJrmbjxTz8ZXyfI2Utfj7kevtxo0sPQhqv1Ql8YXna4VbBxRB/zSy G4qbW/nFKsg2enherh0DAQcHTrY8Evga1mofQHPjFJDSpm77zD6Lr1fE+CzgrRpgI4MuwesaqhX 1YJERVQtk27g+DLeNixD0hWoZzw5tQy826jSWrt5U137JuWGz0n057X+qsmJ0M1qZwtJXbTGWd6 EHgZoHGlXr4MSuUdnn4+YfLcw6KOmnQEFONoSUhR87S4wkT8D/irKBEtJFsg2OKmk9O0/cHBCaT n1oHVipns+apoDtpqSre89dajsPk40h/UEcN5tvYq7z6ItD3FsHZWJINTvmKD/bYTqN1vqoBEpw /lPUZa8AY6RUDDPr/kpTBq8NxiqtSl3oLWOFMatzbt9/OcFoMkFNH48ao3SZ83fOQa4WbZ/Te6j IEZvTh4aT/Hs4D8ZqoNavQAhEjvRUBTrzlGbLGlCCanSqf6+FRzo1obwtgslqu8uoli0/uR4TZF h96k1VxdJkgn1HK55SmVqeywfrEL4rRCuirWDEO/lTes7RDp5ZFtO3X6gkFGcX4illc/8GyCaEz 18uu2C6jUNLrTow==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The following patches contain fixes for timer lockups and a
use-after-free scenario.

This set proposes to fix the following lockup situation for BPF timers.

CPU 1					CPU 2

bpf_timer_cb				bpf_timer_cb
  timer_cb1				  timer_cb2
    bpf_timer_cancel(timer_cb2)		    bpf_timer_cancel(timer_cb1)
      hrtimer_cancel			      hrtimer_cancel

In this case, both callbacks will continue waiting for each other to
finish synchronously, causing a lockup.

The proposed fix adds support for tracking in-flight cancellations
*begun by other timer callbacks* for a particular BPF timer.  Whenever
preparing to call hrtimer_cancel, a callback will increment the target
timer's counter, then inspect its in-flight cancellations, and if
non-zero, return -EDEADLK to avoid situations where the target timer's
callback is waiting for its completion.

This does mean that in cases where a callback is fired and cancelled, it
will be unable to cancel any timers in that execution. This can be
alleviated by maintaining the list of waiting callbacks in bpf_hrtimer
and searching through it to avoid interdependencies, but this may
introduce additional delays in bpf_timer_cancel, in addition to
requiring extra state at runtime which may need to be allocated or
reused from bpf_hrtimer storage. Moreover, extra synchronization is
needed to delete these elements from the list of waiting callbacks once
hrtimer_cancel has finished.

The second patch is for a deadlock situation similar to above in
bpf_timer_cancel_and_free, but also a UAF scenario that can occur if
timer is armed before entering it, if hrtimer_running check causes the
hrtimer_cancel call to be skipped.

As seen above, synchronous hrtimer_cancel would lead to deadlock (if
same callback tries to free its timer, or two timers free each other),
therefore we queue work onto the global workqueue to ensure outstanding
timers are cancelled before bpf_hrtimer state is freed.

Further details are in the patches.

Kumar Kartikeya Dwivedi (3):
  bpf: Fail bpf_timer_cancel when callback is being cancelled
  bpf: Defer work in bpf_timer_cancel_and_free
  selftests/bpf: Add timer lockup selftest

 kernel/bpf/helpers.c                          | 99 +++++++++++++++----
 .../selftests/bpf/prog_tests/timer_lockup.c   | 65 ++++++++++++
 .../selftests/bpf/progs/timer_lockup.c        | 85 ++++++++++++++++
 3 files changed, 232 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_lockup.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_lockup.c


base-commit: 528269fe117f3b19461733a0fa408c55a5270aff
-- 
2.43.0


