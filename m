Return-Path: <bpf+bounces-45717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B039DAAD5
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442F7B21C5C
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575961F9AB6;
	Wed, 27 Nov 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiQ5JXcW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13B2B9DD
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721591; cv=none; b=C5snEohr/WTIUiCuFCI6IrhT3J0UsHpNdEI754uHzL2eB0DrsGl2QC/FRSMOudmd9lf54j4aMPAT8+oAMmb9gnr1iA7tudicP38FNrlGg83ZJq7j4LGgGmEvCu4QWvOEfmCvir56xcQ+BzSbJxdiwjxKY9BbnvfOlni33PSVlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721591; c=relaxed/simple;
	bh=KQqUePtP45BPxniMuA4KE3lwktZS/U782kiQAI0AQiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULLGeqtpWrafUu+a41tBuYt3LH57PhxTe/KGtls3NcxOFjmz8Y1Spb2E60e6HmJNIygBWgp35KCwI7YSTcSGwh0uKm0N8HE68DgjG9g8gVj0eRO7h+4x8OU0NG3KTK9tewg5RSZZo7vpiPLrFVRIw/l3SS4WEEjS8IJge4Ye/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiQ5JXcW; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3824709ee03so5025186f8f.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732721588; x=1733326388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kuc4XtNqjuJpvH55sAyUJ6uQBgEgiDFTwaYOPfhaxcw=;
        b=NiQ5JXcWeOkzjFBH5p6QCxZIKSBiOdnW9NZDUShbc9k6hBwOA7EP4/n2fZ7mvRt0bd
         kc8mgE5YWsq5PQI+FJ3g01JSYZFXOnlG5y4pbqecPW+Q9RL613f1q6VDvWhaJtkvfds/
         o/94W+jmUTwC1I7+jV3zJElkmTbyKjkFZKhqGQRihUSXiF0/Nu0g7FekDtm+dbajCUHW
         FIXO99k0OoPlJVHf+kD5TmUs+IkGbKOsWoyrl4z9hKq7YYVijv8pS1EQk3g6yy2jLynB
         JvYw8IAJb8MOw+y5TsMEwsnysTYuVtNC4Na9wd29O7Eu4blcwyuxwXNlcnCpSwY+iSC8
         R8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721588; x=1733326388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kuc4XtNqjuJpvH55sAyUJ6uQBgEgiDFTwaYOPfhaxcw=;
        b=hCYIuqGd8cPUxlehftcYpM+XbaTlBVdqII2Uu/hjHb9K8EIshjaXpQEqi68tZuit8+
         57DGqlTXczdoYHoKhHspnVZRNMIXNWbcFbvNG81bh50ouE6Tq7t2k3LgWDBmfBviXN9n
         g3v68tGBjZtV+PNPKSHJXkAiH9u3EK1s6/3BFr7FIbXJxrwj3N4p5HUr4CHmslkM4mii
         0GiQHE/T5a/xD5lMpIgN4qBLx81Gt3g54JGxN1YGUHZcANVyOF79QgN5ZWXoWkOq3dJs
         lclg9yLeAefXDDuyNIqAEYGxkQpQr9QRVDuAHANmkfKkGqxM0yjjngviHAAXqOEg/l2D
         yBTg==
X-Gm-Message-State: AOJu0YxXG5H9B0xccfGc86oi99kLkIYb4sFYwqfZj9jriCOMDcZzJZci
	v8gKgWI62+jOswbDPoyxAwMeuU7YCkxXGvK7U5R+wmsZ54liq0ljCB2lUH4aWqY=
X-Gm-Gg: ASbGncu9F5xLQvrc6h+w67o5qRgPZG3At+XGmOA9D/Wr9sWA1+jh6f4wmLYFz2jqZUQ
	P9c6V4xdhPF7h9/rrl8gnAfSMKqulmPkOWBKuTMpOYXjmrM+0VidKs7aSXTEfnnnrhRO1dzwAxf
	QEm/AS1NLqX5aUmYL/eYjR6k6yJhNdcD+ZJFbkOOYGy7hR3wh64hDcr+W4tPBt45KfJXoyPiPto
	3/rdX8BdnAgcqQKEd1hnGfBOH6fRrBJK7j3647HsKVPtoetmQVNXHtG7hrAWrIP+PT2iaHyTw==
X-Google-Smtp-Source: AGHT+IF2XwaY3ZHzvqpmxKiIXUretY+PT/y+ie1wm2ItfyhqLgrae2phopvXHAlHzF787OZhJcW75g==
X-Received: by 2002:a05:6000:21c1:b0:382:5010:c8c3 with SMTP id ffacd0b85a97d-385c6eba982mr2183595f8f.28.1732721587530;
        Wed, 27 Nov 2024 07:33:07 -0800 (PST)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad658esm16998328f8f.8.2024.11.27.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:33:07 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 0/7] IRQ save/restore
Date: Wed, 27 Nov 2024 07:32:59 -0800
Message-ID: <20241127153306.1484562-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3078; h=from:subject; bh=KQqUePtP45BPxniMuA4KE3lwktZS/U782kiQAI0AQiY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnRztZyIRKT1mETj0N/+KB8sz+m+ZQcCoQa2qr3S6d 5FNN7wOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0c7WQAKCRBM4MiGSL8RyiqPD/ 9YQrjL4dYy8VVblRb07UEd/TEnzur6L3eFoY6o2zPoEci5G6MFFKTuw8Aps/ZU/qsUyzUb0ZsUwIXk DQuPn+sWRXnNGxpo5qp8v9yn6QaP3Sfo2czgltZDvuh8IIMVzt+5ezCCp8ZTN3B185KLrGR1smrmjW 2ZKU8Tz1DL+IH6dg08AOO+HoFeaMM4DCNfnBNhV91d/h2pMsnPh6QS5L4WyKvdkPmnudkTCAq/T+lT OL/P7JKq88tzaH61ZBSnFg55xHhlhxvNnbNBkjNysFkNWeW1XgdXJ3uOkIEW2ahQv+hEgaFdSrQrUU X55UicNOm/1MnFMR/UuKr6NgHZjl7OVk1vqrvggig7CTfk4daVPXrQFW222ul23cYFHr0VriV3Yg9T fGWBPddapfanNat9o/xp7NGR8rQVjIoiAOgfSRQKP2vvjjcLUEO45copWYzQ7AGsycEcnFTGhnlboi b5jerSkJOr964AXpshkGc/nA2AbKKifxNVhz5Ac108wOnEzIYf6zE0jNgUHOuPKw6kX2E8JlPivLMO XVmpTXq5d3klCA79Wqc+heA9xlBj+vPc7jzMMrombNHCxTlxzuiKHu8jWt+m+OftYGFNEOtCpYc6SX w119waAvjSFeuwDzFdUp0eoaKT0i4oAz6DUy8It/gh8/aATs2HObPwHk/cwQ==
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

 include/linux/bpf_verifier.h                  |  20 +-
 kernel/bpf/helpers.c                          |  17 +
 kernel/bpf/log.c                              |  12 +-
 kernel/bpf/verifier.c                         | 531 +++++++++++++-----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/exceptions_fail.c     |   4 +-
 tools/testing/selftests/bpf/progs/irq.c       | 393 +++++++++++++
 .../selftests/bpf/progs/preempt_lock.c        |  26 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |   2 +-
 9 files changed, 860 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c


base-commit: c8d02b547363880d996f80c38cc8b997c7b90725
-- 
2.43.5


