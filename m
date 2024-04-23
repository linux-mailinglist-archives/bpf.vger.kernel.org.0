Return-Path: <bpf+bounces-27502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887458ADD6C
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B6E1C218AD
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 06:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0524A0E;
	Tue, 23 Apr 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cadJUtRM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BDB2261D
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853167; cv=none; b=njmp/6Gj4/R6h93y8krBlF5JaEX5G4sif1dw31ruDGWlj9ajeMRlPiUXjb3R1KSgPB7/IW+fJrYhIvEcSvF8mnWXCQFydaNda0peg6QMfra7YfiYS1HbPsXE2DprRF/fLcKRSKGMoScGoCR2N7YoXgIvGx87D9Pr2GP3Tk87wIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853167; c=relaxed/simple;
	bh=S36Fzmec2+uKcqgzRUF3t31TtuRo4v7NN1SKcI4fmzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1wEUcigWcoK1Gmfd4HSN7/qPEeDO3ZXw228dHFg/cKTt0dIZwYPupvTgHOw8CoBwoBD6US+q82D+Q5wHOuyWF10OYfeVi4AGX7ERRn8fAt6RsKGvoWN2cVMptzsmS8wVWSzPZM02fz6U3AheKS7Am99VH+akMH9/Kl/dnnVugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cadJUtRM; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso6478679a12.2
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713853164; x=1714457964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IaJW4cPZ9Kiqt6W+J8mOtvIlBUT0FbjOY3qfd2Ucxxg=;
        b=cadJUtRM8X5pI8h7GnMTTAmvLFcNX34PYFWtvBpquUrp6BfRNryz8RygZFSKbEdmyr
         qkgHz9jJMvYOeBOiB7+4uPK1+9JZt85GZiXtlXuZXpD83l77Gm1PKXLjvPc5NZEqH6ii
         9sdfMFRaSEpzAgBo+SAlqzm+QOYgKcGnxPUK0F/D4kAbSVXG8Ojuz3SwRvr9jJRJyu20
         5uD+1wbEpzC5LQWNVe0wt3VQmUOcrzMfedQ+goEp5E4KZ21GYMvbulX2672oXIEIxqu7
         d9EWF86H6eUYXRnq0iNV5+fPAFDpX17qJpxWA9JreF6k6GRGTltUCDjl8MMBSr8qS32K
         7mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713853164; x=1714457964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaJW4cPZ9Kiqt6W+J8mOtvIlBUT0FbjOY3qfd2Ucxxg=;
        b=i5DPdmiJjbSPm0VFwqeAj0hFXX0DYJGwVLJOEJN62CtZ6PJhrt1YCVtESAL3lzymX7
         QAI53kEY5CytP6wbR82kcUkSTc9zOibAU3aUb2x57HPK4dVjKw8vDL44CYfORct/ao0Y
         LPO9V2kfO4AcioNmXYVRlZOeWAEg9JhJM/jR8zNiRAWHNdZRUtLJ5MUoCwRXx476lz1I
         XaN9E250CBgGEkpOdMhDnBswEirO1CJ4T2v/9b8s7xjbVFFnX9q4r+/tMMuMpHMn3ktC
         nnVzv03qSBBxThOCbz5Eglp97yjaYslA1CphkLjYhbxBpON9+42aa1r/h88EuJIqphl6
         XD4A==
X-Gm-Message-State: AOJu0Yz4rJfZ9VZJ4Hwib618Kdr4E3+8Hca0NrBALvetQ5k2RGSB3g2e
	fo7JRMKr0qMDsk6OQ4JEJHo3DnMEZyXEKLh8knonZF/+/J+jNtqNvj3AbMVN
X-Google-Smtp-Source: AGHT+IEYG8klHp2djz/BL4n1k4EdnpTdo5K1MEcjFSxqiUIK5HH6FqbRSQ6QnoHWnNVkEPIcGKVxJw==
X-Received: by 2002:a50:8d55:0:b0:570:374:fbf5 with SMTP id t21-20020a508d55000000b005700374fbf5mr9239268edt.39.1713853163583;
        Mon, 22 Apr 2024 23:19:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b00572224855b8sm212125edb.27.2024.04.22.23.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 23:19:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v1 0/2] Introduce bpf_preempt_{disable,enable}
Date: Tue, 23 Apr 2024 06:19:20 +0000
Message-ID: <20240423061922.2295517-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=memxor@gmail.com; h=from:subject; bh=S36Fzmec2+uKcqgzRUF3t31TtuRo4v7NN1SKcI4fmzA=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmJ1KgrY31fwkOSCayQfep3AcTqpLXB+T3e4cFb KKMrvVt/ZyJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZidSoAAKCRBM4MiGSL8R yjgDD/95gh+mlBPIB6d2gnDvMPaHdZahgqgC3QrN6dYOrUFqRcLmbkuFLd69wnWgTBIxJBX0aEw bzLv23feg9anLAZmMPtAbpFDSIebOEqzQCUnHyRhcOpkEu300D060nGjMQZIv3R2Em3j0nUXKS1 /ppDLFrIM+VCKAbKGDsxNc1w35fb9PhBucPWZ5yPEDql1XZoe70fhVVAgXguGHZZI7LG60QLsl4 qgq8zotJONfs9qOODx/dL0Nvu1WgtWaazFK0Ao2unDeqs+mqwdBnGtOflMEhpirIzibJKZAWNn7 XhI3qpw5tevCR6eI7Qe7ccdmazL7VQPHnPJOj094VrErTkMMF+KXD2B18D/NqE9KbEpVzaX77OG OhZQOELTsvS0UE2mWNtEDRxNHte5UckwdzuvQeHcjl6Oj5KAIWFGqEHQzsvOjZrFf2aFc0/uzfb Abjaexvs4VAT/AAwFauQqhlAGFMMYYEOqhSbpKSiaY+qLL2zl77XhidAB9uBRfftFZ4xqC0fOie NEuKzFB4GIoKh6oBelyoaBPulviazQHc3BLh2iUxvYzDL7cbQP2lLMIQ2DO/BvlNCR9OZ/O+K64 lQfRJEwxxD2JUsZLr7aXHkAPhvfghJDcTCNRRcj8WfHmGbw97ozMPHJ4QbkS9CM6RjG8/uuZ2EN r/87bRkAY8xU7EQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set introduces two kfuncs, bpf_preempt_disable and
bpf_preempt_enable, which are wrappers around preempt_disable and
preempt_enable in the kernel. These functions allow a BPF program to
have code sections where preemption is disabled. There are multiple use
cases that are served by such a feature, a few are listed below:

1. Writing safe per-CPU alogrithms/data structures that work correctly
   across different contexts.
2. Writing safe per-CPU allocators similar to bpf_memalloc on top of
   array/arena memory blobs.
3. Writing locking algorithms in BPF programs natively.

Note that local_irq_disable/enable equivalent is also needed for proper
IRQ context protection, but that is a more involved change and will be
sent later.

While bpf_preempt_{disable,enable} is not sufficient for all of these
usage scenarios on its own, it is still necessary.

The same effect as these kfuncs can in some sense be already achieved
using the bpf_spin_lock or rcu_read_lock APIs, therefore from the
standpoint of kernel functionality exposure in the verifier, this is
well understood territory.

Note that these helpers do allow calling kernel helpers and kfuncs from
within the non-preemptible region (unless sleepable). Otherwise, any
locks built using the preemption helpers will be as limited as
existing bpf_spin_lock.

Nesting is allowed by keeping a counter for tracking remaining enables
required to be performed. Similar approach can be applied to
rcu_read_locks in a follow up.

Kumar Kartikeya Dwivedi (2):
  bpf: Introduce bpf_preempt_[disable,enable] kfuncs
  selftests/bpf: Add tests for preempt kfuncs

 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/helpers.c                          |  12 ++
 kernel/bpf/verifier.c                         |  72 ++++++++++-
 .../selftests/bpf/prog_tests/preempt_lock.c   |   9 ++
 .../selftests/bpf/progs/preempt_lock.c        | 119 ++++++++++++++++++
 5 files changed, 211 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempt_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempt_lock.c


base-commit: a7de265cb2d849f8986a197499ad58dca0a4f209
-- 
2.43.0


