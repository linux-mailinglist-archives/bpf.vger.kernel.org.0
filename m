Return-Path: <bpf+bounces-45761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D39DAEF8
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C31162616
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF7B202F6A;
	Wed, 27 Nov 2024 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC6cEa7b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C414EC60
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743341; cv=none; b=Z2q+NdIqwcKcoEu3OSeAVQD601V1bfyiBOWKpudNz13Js3YOqNuq+Xs47qLOGPvCsUncpqNqPN1RK4/OZfWh6OwKupwapCo9VHBXoR17rXqhOfUASL22pd6E19UZVwNZojLUL9vKHgGAeUn6BuGBDtnPpo5D5mn9KSsnJYdiyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743341; c=relaxed/simple;
	bh=GHn/Er9401toK+nPE4nhutqJaqQfu4lkOXIMVJB56Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scPRNlps5jARiVVahgGhF1NGzMrIW20TpLtp40kQ1oDP3Ktr2a2rRXNEjwDX+WjQkrWd7IY/si10yYRHw0WkY6fxAhV3MFQH5CcazzBtKykerW/uj0JPFh8w0vy3P1/pQ5eRD0Kr92FH1q9GHBbRof+UXuEt5EStOqtb6eqQ7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC6cEa7b; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434a90fed23so1030055e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743337; x=1733348137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCiEmYIeRxtYD6uQVbKQOfGOI1ZFQJB3p7NCRZvqgzU=;
        b=CC6cEa7bxjB638VfLE3T4hxuiuu5mQoZYHQVEnh2YPD/H4hgUzHZp7Nh7ha2VFbLm6
         KlNJnJqO0Wj4Kbzu19yOZ1tPrFgn7YpYUIN7FXQg8hBG/M8DAQbPeh8ksbKY8Tc3aDna
         iQyH2twRu8PYd6hiGKxTsNGfz8xCgbhantNIgzROi3f5WJm0zwb1gSxVsU91umIOpFI6
         EsSuBBANtUBMmND4zeppFJN5L5V1B+RRVbin2vBDFDuTqQMov+zLeCtfK42XHKSVdV8h
         bMwJFLTPj6AIIzXJu9PCv6FsmSi+L34osdz3GF6uEkFqhe/zPdlsbmSNX4FhyNK2Lcax
         6cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743337; x=1733348137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCiEmYIeRxtYD6uQVbKQOfGOI1ZFQJB3p7NCRZvqgzU=;
        b=YcuCKLDQWUZiXI5/jFVjrcQ2OKcEaYUIRctSD8OnGJQ37nCE2jScmhTItt7h/sHHil
         zKXdOcPyZ9i6v0zVjY/JwYIQ15uN53w1wvrTwCqvQzXI68+HrR6nA5rWWP8G79bYx59P
         TjRLnBZ0WFNdDfk5dC/GozJQcbot/I9pA3g++9EYkesLdoHoaIHXovG5pHxrbCfdAEti
         fUY6Fhru7RVxdBHujMX9ivnePei/gCc8Ek3PUc35FowZxINb+Tf0lAkuEp6dpCPBEAjr
         u9NGasRImQ1hslw9otFbWvDazJoaK6NyMsFGNiPBCkPo7pTPzFZFmJQ7tMS98YqVxIk2
         bEgw==
X-Gm-Message-State: AOJu0YzGDwA4dxTjfBKoPbLSUj5QBA+RLSr3QlWhTcBq3m00a5qhTI6P
	EWgrTJxYVkIhYv3mNK0BsGbDISn5Ss/0Vu7gFZ4A6nTPP1lcWUivi2beedez9z8=
X-Gm-Gg: ASbGnctU2JVOQqYIvccvQ8R3W6iFltR/6veztyVh5akEGF5Loej3QdJ0D+9CT8ZPxEo
	DvT+WQFnMgUmYLmwm0kyGFL2aIQslMn61PRvWkG0G7xkX6hZV7IrZDnez7ELn82luwyBDsOXFZ+
	pIA+fAeduJrLf2hkI7rIkAneaE+2a0tzZRFvFAmoVG+irBeC+F7eF3/KIl6OySEcgQFfoUOhaN7
	q5JYsC6aUXFznxke5B/IsnCVOey2EapyHjC5f/p/ZXr5Q1eL3P2afU6e7OpxfToRub7ZSuVwaMh
	rg==
X-Google-Smtp-Source: AGHT+IE/RLEzM3iCkyI/lc5wrSgENfFPgYJyBQjwi9kM/MNxAJthPjgb7TSKP2RH75Fxp4Fvu+h3+A==
X-Received: by 2002:a05:600c:4587:b0:434:882c:f746 with SMTP id 5b1f17b1804b1-434a9dd00b7mr48868845e9.17.1732743336899;
        Wed, 27 Nov 2024 13:35:36 -0800 (PST)
Received: from localhost (fwdproxy-cln-031.fbsv.net. [2a03:2880:31ff:1f::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb53858sm17215617f8f.62.2024.11.27.13.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:35:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 0/7] IRQ save/restore
Date: Wed, 27 Nov 2024 13:35:28 -0800
Message-ID: <20241127213535.3657472-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3479; h=from:subject; bh=GHn/Er9401toK+nPE4nhutqJaqQfu4lkOXIMVJB56Ww=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR46thYjqSpMo5jOJMF1cg+vAEAjJG/Lm0aZRQcEQ CS2/mW+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eOrQAKCRBM4MiGSL8RymPuD/ 9tJ0las3OVHrw4HnBxsVhsNa+EXtOTccBee1QSvBMck8jjK1PHXJAgGkWL1zsQOmfBBkzHYO6JpHeQ H5T3BKXatp4rcT5/Gdc2/gSx4fhXh45CibuqBqf13PvMh6g6Gx+CLK8SGy6lVJ4UM0d5Y3Js7bWeOh bq0/9HVOrLTdgnDfQCkcjHPWS5J3yHzSkbSBABEEg76aVj8epSPhoFPyKtEtene9PWAhufvKvmc7Wm KQLhTVzC97dJKX0fhc/x/8P+t+A5kgxQFhFhrZBTdW3xUVildIvOkhvKmPeP172r0HqBQVlnbqsRl8 6rpOqnvn8jHuyaANJ1IKFZ5DPP4BqgaIqblvblVs/xItQtD1CiCBRZHk6EQ5dxlV3sYq2DqNFUL83C 3BjTqW8WHCX1quorp9DfhccVr4fBXDlKhfVXQszkpnmC6DI6kF0W+xNWm2miFNT7StOn8t7QY35J0M +GmtjJSwcGN2pA6BI/EJ4R4vJH+urgIUf5u41bMnpiW3U7JMTuMePMgLSa4FjGOAHwvwVW0LL+gwdP bqWxzYrnVnBZ7MwaJj8PAm0j+2UBsdVGB25e7Do7Mq/UGEQyUPeh6jOM3Oh3VijD4fj2Smk1nx5BxE 5CxpLVNQgwUA13pJEkgPkIoJ9gWIgSaTLbYX7X4Gstlgyle1vdaRoAZ2FULQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set introduces support for managing IRQ state from BPF programs.
Two new kfuncs, bpf_local_irq_save, and bpf_local_irq_restore are
introduced to enable this functionality.

Intended use cases are writing IRQ safe data structures (e.g. memory
allocator) in BPF programs natively, and use in new spin locking
primitives intended to be introduced in the next few weeks.

The set begins with some refactoring patches before the actual
functionality is introduced. Patch 1 consolidates all resource related
state in bpf_verifier_state, and moves it out from bpf_func_state.

Patch 2 refactor acquire and release functions for reference state to
make them reusable without duplication for other resource types.

After this, patch 3 refactors stack slot liveness marking logic to be
shared between dynptr, and iterators, in preparation for introducing
same logic for irq flag object on stack.

Finally, patch 4 and 7 introduce the new kfuncs and their selftests. For
more details, please inspect the patch commit logs. Patch 5 makes the
error message in case of resource leaks under BPF_EXIT a bit clearer.
Patch 6 expands coverage of existing preempt-disable selftest to cover
sleepable kfuncs.

See individual patches for more details.

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20241127165846.2001009-1-memxor@gmail.com

 * Add yet another missing kfunc declaration to silence s390 CI

v2 -> v3
v2: https://lore.kernel.org/bpf/20241127153306.1484562-1-memxor@gmail.com

 * Drop REF_TYPE_LOCK_MASK
 * Add kfunc declarations to selftest to silence s390 CI errors

v1 -> v2
v1: https://lore.kernel.org/bpf/20241121005329.408873-1-memxor@gmail.com

 * Drop reference -> resource renaming in the verifier (Eduard, Alexei)
 * Change verifier log for check_resource_leak for BPF_EXIT (Eduard)
 * Remove id parameter from acquire_resource_state, read s->id (Eduard)
 * Rename erase to release for reference state (Eduard)
 * Move resource state to bpf_verifier_state (Eduard, Alexei)
 * Drop unnecessary casting to/from u64 in helpers (Eduard)
 * Add test for arg != PTR_TO_STACK (Eduard)
 * Drop now redundant tests (Eduard)
 * Address some other misc nits
 * Add Reviewed-by and Acked-by from Eduard

Kumar Kartikeya Dwivedi (7):
  bpf: Consolidate locks and reference state in verifier state
  bpf: Refactor {acquire,release}_reference_state
  bpf: Refactor mark_{dynptr,iter}_read
  bpf: Introduce support for bpf_local_irq_{save,restore}
  bpf: Improve verifier log for resource leak on exit
  selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
  selftests/bpf: Add IRQ save/restore tests

 include/linux/bpf_verifier.h                  |  19 +-
 kernel/bpf/helpers.c                          |  17 +
 kernel/bpf/log.c                              |  12 +-
 kernel/bpf/verifier.c                         | 531 +++++++++++++-----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/exceptions_fail.c     |   4 +-
 tools/testing/selftests/bpf/progs/irq.c       | 397 +++++++++++++
 .../selftests/bpf/progs/preempt_lock.c        |  28 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |   2 +-
 9 files changed, 865 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c


base-commit: c8d02b547363880d996f80c38cc8b997c7b90725
prerequisite-patch-id: 39c773cdece7c5fee2459d6825c8aef069381581
-- 
2.43.5


