Return-Path: <bpf+bounces-46047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF99E31C3
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C46166704
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4E757F3;
	Wed,  4 Dec 2024 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDo7nK4Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0BFC1D
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281449; cv=none; b=b00lBADZ16PSlZd9y13Iu17QjA9tVUe5uzmMPgT1AOmDreWRsjXECAyG9Zul/iQGCCYaDg0lZDEdumJmV2iHAW2Y4XFs2+WGDhfS51raHG1X9Kxmf/Jjt1l46z6nzR18MKWQCnmYCq7ls1spQvn0MvryVUBsMv7ZEldrlaJqdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281449; c=relaxed/simple;
	bh=CDFs4LP1dVQhlYKmJ1TYZzm06LgtB934CTTYD3hJua8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4kXY8PL4lK+7EoO8cy1wQtY3CQ5dV4uqCfmYCRYmGOriFi2WZmZLEPAa1VmGIS24PVs1l63LF/UFnsVqnOqIxLZKsQOVQP0jZmkTtcL6p9aIN/6CLoEVK6W4ti5cem8k++th2td2tlC8KukFKJrgWk6tXciidtre/0biIMjuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDo7nK4Y; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-385f4a4093eso1972241f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 19:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733281445; x=1733886245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4jr5l6GNfwEXSpJaEKY6fhLISzfpVncSjvUxPx++VQ=;
        b=nDo7nK4YPJ8U9EDUHrayiTBYlZcXH3AxkOGFWMjGlyYtsvieIo/kTPRdY9Pe8iQcxW
         4LyLZgl8tDhllIfhQFb9zQxrtJQdSqRPqWR6hzrpsMGkI/cYYruhnj66Ir6T709E5ou5
         +cHMQo3T0gmEG8uDGN3rIxBE9011ChioPFBdZ/zCEKttsLmAlOZUY4zROvKL79GLJvXb
         lAIl4iSQN1IP/bNeUrErwqXOQu3sC88hd3xfa2958R35pCLTtO6EpiDhFcjKNuABzBhg
         qqGlQn76FCaVs7GMUYQ5TpDgWyIbKG0gP2ZuGFYW8BoSDnk0KlwB44FN5TSLsoZtB5Bv
         i7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281445; x=1733886245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4jr5l6GNfwEXSpJaEKY6fhLISzfpVncSjvUxPx++VQ=;
        b=SgKhAoF6MgKo57KjDbWCqSm/fPXexyI+UNYboGAnNnGNKSxs24cEux1a32NTXPmkxw
         vHnthHdh+Mvjp0g1/n484+iiNPBSsLhFjGidZ95swQiA3RDpKNy/ZhQY65wXch9jnRrN
         n18PKOZ0faVQrDPytpBUjZOVPuExbVe2VvB++vBxynXdWLJ03Pp3RfiMgZCUSoAASvao
         rF3qKIZ40i0PCcaAgjlgM1eDGDX1kM+S6ApWyR94OcvQfefdnV4mEuCu7cbrFthaB/O9
         1Sg5s9xQVx9fgVWkh5876LzfB8mCNc1nKf/c7+r4W1rn3RCqP1e6FNEUuBQH0giNOgUu
         fJQA==
X-Gm-Message-State: AOJu0YwuOIQLir2nDVLjoOj79URJjME2bIWFV6fHM40x2b43qCXVnxNQ
	4tA7BtHe1v+GiMTsWErjn/p1HfGFILsyoKQP+hwW50n81gZ1kDQ7cCtvuY5WdKY=
X-Gm-Gg: ASbGnctyNpAO7wFblMzDFPjYcHgyfJotQGtJ+7nSL3As2Sdwwuljj0w2DL+rI8OwKZC
	fXObm1RiXHcXeWxjevur5+CplW/NGKz4QM/ntZ2pMic851I0KLmKqD691OPZXiqgPs4DDf5ny4W
	D5vnqSJ6DeylMcLephUzB3G/zunffaO0N6ryPfP7OJqWY6m97S1DCFeo/VfyGqxMfUXOH0xhlk2
	SZQGNERuMqEhIrkQlZs9sIPET91wyizpyMX7ASGsS5L3RbEQ2EBTlxYx2DSOS7nlxHeQ4wHj8xw
X-Google-Smtp-Source: AGHT+IHvoKlf22KZIBcnWklfwQffAepO44D/RxhTpe9gxjZykQYS9MpuNwYTsIsEvUfHJt4srvDDYw==
X-Received: by 2002:a5d:64a8:0:b0:386:8ff:d20b with SMTP id ffacd0b85a97d-38608ffd369mr1702915f8f.27.1733281445398;
        Tue, 03 Dec 2024 19:04:05 -0800 (PST)
Received: from localhost (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36b80sm16858308f8f.29.2024.12.03.19.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:04:04 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 0/7] IRQ save/restore
Date: Tue,  3 Dec 2024 19:03:53 -0800
Message-ID: <20241204030400.208005-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4400; h=from:subject; bh=CDFs4LP1dVQhlYKmJ1TYZzm06LgtB934CTTYD3hJua8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8Q+WvqRJWhtKtW3EhsXm/UF5L/IUWyLXdnFEmxR dNhdWK+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/EPgAKCRBM4MiGSL8RyvShD/ wJgHRZffkukWr6PMvW078yTLJIkKRCpp2M9GKtunJDS9/YdrHiSmFDuEepE5UIUnPRS0Aeb8TWqDWG 0S74V7UzN+OZmbISkHakgonCbggqYlzI5/N3tqu1hKdNAviQnkLE14r7ZWdJULfdDQre68j8HZbgBV B9hPkMeXvu31jCTyi9ulipUKX63xihnBALN4Fhik5zyK96QMED1aBvLOQCMCT/QQm3+cz+OPjCpWqA ZsYKXzuP2kT8L4FlzMyEMlVgmI8SHKA82FEDTur75YLubSlRzlbfughrKF5Dv0Jd3OWnuxCEphhf/d GK/WBE8dapNjXX+/Jy3UpqmDHlbqXh0lTKHrRbg3AR9WdjzHP51Styw0j/b/DHrIIKy7cBVeq3xuKH mqqJ7dj7DrcA7WTJTZa+L9kGume44Nkrubb1RirPHymuhKwOrPulQERb3YID2dlHkilKHC/xVL8quy eEFWEZirjqhNZeytCrrxOQI6vStrg3NSQusFe/h+eIn6VMM/OWBp0J8qY64ctaxR9Rg83szKKMsSUM pwfNHwIn9XvGGhvrNaZbuS6A+92RWN0xW6j0xUNiNbng0lux73K4wbee7Cth3B5v76tGUvASrEGiMM fXO7Fp0IWwEXwRIaBYja/vVFbUB95yQE7tsc0EYz9m1q7pIFtOrerfoBSzfQ==
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
v5 -> v6
v5: https://lore.kernel.org/bpf/20241129001632.3828611-1-memxor@gmail.com

 * Add Eduard's Acked-by on patch 2
 * Remove gen_id parameter to acquire_reference_state (Alexei)
 * Remove space before REF_TYPE_LOCK (Alexei)
 * Fix link to v4 in changelog

v4 -> v5
v4: https://lore.kernel.org/bpf/20241127213535.3657472-1-memxor@gmail.com

 * Do regno - 1 when printing argument
 * Pass verifier state explicitly into print_{insn,verifier}_state (Eduard)
 * Pass frameno instead of bpf_func_state (Eduard)
 * Move bpf_reference_state *refs after parent to fill two holes in
   bpf_verifier_state (Eduard). The hunk fixing that bug is in the
   commit adding IRQ save/restore kfuncs, as it is only needed then.
 * Fix bug in release_reference_state breaking stack property (Eduard)
 * Add selftest for triggering and reproducing bug found by Eduard
   irq_ooo_refs_array in final patch
 * Print insn_idx and active_irq_id on error (Eduard)
 * Add more acks

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

 include/linux/bpf_verifier.h                  |  26 +-
 kernel/bpf/helpers.c                          |  17 +
 kernel/bpf/log.c                              |  21 +-
 kernel/bpf/verifier.c                         | 573 +++++++++++++-----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/exceptions_fail.c     |   4 +-
 tools/testing/selftests/bpf/progs/irq.c       | 444 ++++++++++++++
 .../selftests/bpf/progs/preempt_lock.c        |  28 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |   2 +-
 9 files changed, 949 insertions(+), 168 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c


base-commit: c721d8f8b196285a59ed5c940e856bce9890523f
-- 
2.43.5


