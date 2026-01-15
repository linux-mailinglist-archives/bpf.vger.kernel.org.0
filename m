Return-Path: <bpf+bounces-79108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66893D27C18
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD53131DA1FC
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1D3C0080;
	Thu, 15 Jan 2026 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbVBY535"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F23C0083
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501748; cv=none; b=eJ27jChMTxZCVp2cr22tihnF4CnD+eMBQDPzI7taEYbLVC0yhJZYr12BuFjdTxm6j/+GPWAR9Q6idcDfxUwWUIYePw94Uf3PGuIGY22OtXgW2UmHtg+IHF9gAJCJMCvRxXGHDHskS+lk+PPnTU1nKnV7EVRwtksOR17bEPsqZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501748; c=relaxed/simple;
	bh=40oU5B6hHvT2ytQwd+DO5Qu25TCm9XA31Q5N4U8Rk0w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fi+BrhDLZ9AUrMVCvrx3a7C2xjOc3KHZnzNMCgjbCkWXYAq8taeWpIS5HP7Mz4NeQkrPMolbE5PAigMtGWD36nf4B6/xYxqyJwp2uqpZneGlfMmMLo0CYAcvx0sR4yW34sg3lFeObUOj2YntyIVr0AZaHsrN8uUxildcu9AL+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbVBY535; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso4736025e9.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501745; x=1769106545; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bm9ypXYgZdoUoJ7vWvtsWy0T9ueV15EXQ2KMaO3GsHA=;
        b=bbVBY535gEzsAOIfP/Gap79EQPk/IKp87Kj/KaumHQgsHOsI4e/EV7wMrK2umsJ5T6
         66vvZ/uN6i1ZUl3WNXEJJqFz8UdNDjwEpXBUNHHq2BoaB7ssuGJYYuNdvzAgPVJfvX0z
         7SOr5q/jmNyGgLd2rHUZCEZCSpZzrEgwgZV+n1sezscFfHrrrKGDfdzaUO0U7gjLUIrJ
         PRfKWybbiCB83hKhP22PHssw9tvIGrhNvxpU6z/0Lk/lhLkkzyyEnJ8qOyrVEO45k+js
         CpkalAHgUIoUfM1EVquLBZwCyWGF04QYou/SQSzKyLR1xMvVqb5AhvVYMMvVeuE9dJfy
         uTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501745; x=1769106545;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm9ypXYgZdoUoJ7vWvtsWy0T9ueV15EXQ2KMaO3GsHA=;
        b=rG3veKYxzYOebmIZMukFC6BtrX24PgNaG2BLIbxiAhjKKg5jN9+uSv0c9NTBPBveHs
         1q7Vt6Bj86H1EuupgQKu5xmjCcQBnWMylQKh/w8cUpekbRLgg4/hF0FEv9mGRPnXW7qf
         K0ccZSJMoqJF2XEo6JXWURWRkmRYOPRqh2omQARkpHcuvsPd7cN9ZfodArkBhXkHXbqA
         VaFRxIPpjyR0ZO9HsuGpPNoCUiIuqGLmCPSoEeHK4Tw8lJe6+iSJtmep7dxTJq/D/sRP
         0aGkBdj8AL74BVVPOer1IK2a6s2XOxDIWEVLoT9T43JhdRPTal4DX85+cI7eXkFfWGyK
         QG9Q==
X-Gm-Message-State: AOJu0YwzhdnC8gKjwrTe6wgROluIKtXjlTv1fGsGnq+kGE4jpXvKnx81
	XLF+v5m+Cn/6U/mVEogWphXknITVuKUBDqGLT7HfhaN0kvohNwh9IklJpKlakg==
X-Gm-Gg: AY/fxX6R9asNVQgK3Ln3i/iJPDEMwuelyJ1HsmqW0H15o+Hpb4dMaqIDFLByZSyn1D+
	AwjTeW3dK8h78um0LNzjjjmTYwfXfShZsZ2DomNvEHYD8RQIiP+d1UdnY8/+KiGKYAn01NHIUIX
	LY77g/8iiCo2/5KEJgFWmDrUE1+VD0QJt62yAFXRXBF3I1nyxLmVkUM/xMaeQlP08d71c9/JGZo
	aPDwyfpxL6uS/Lg+5WqknlVc4XkSC/e5VaGsq8/Jto2iWJeAhIBJEGpgn0H49Duftz4AvdD8zI9
	egj9md98v4fpegQqK9/7xZy4W3oXfush4nloD/Ebk2YGW2OehFzy2ObGvB+TSGBWKcccCHcxEmf
	21CFu4FGTvlL9rXH7rCQShtwv32UoqI5FlqhIRcxga8AVUUN1qVQei3npnRSdZut8iQ==
X-Received: by 2002:a05:600c:3b84:b0:47e:e575:a33e with SMTP id 5b1f17b1804b1-4801eb14eb8mr1131975e9.33.1768501745163;
        Thu, 15 Jan 2026 10:29:05 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569927163sm446702f8f.12.2026.01.15.10.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:04 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC v5 00/10] bpf: Avoid locks in bpf_timer and bpf_wq
Date: Thu, 15 Jan 2026 18:27:47 +0000
Message-Id: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13NS2rDMBCA4asEraMyeowfWRUKOUC3oRRJHiUis
 RVkYxqC717hUpJoOTN8/9zZSCnQyHabO0s0hzHEIQ+43TB3MsOReOjyzCRIFCAbPoWe0vcQL9G
 ducbao207YxyxTK6JfPhZcwf2uf9gX3l5CuMU0219MYv19FdT4rU2Cw7cQqUNaVDW2/eeJvPmY
 r92ZvmwArCwMlslq7bpLDTWm8Kqf1uBgLqwKttaQ6fIKULfFlY/WaELq7P1plKIHoU39ZNdluU
 XsuWNHWABAAA=
X-Change-ID: 20251028-timer_nolock-457f5b9daace
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501743; l=3785;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=40oU5B6hHvT2ytQwd+DO5Qu25TCm9XA31Q5N4U8Rk0w=;
 b=MGTtpahfhkNlDjLoIDI7EEERlXM93xrmVwRyWrAg3YKa+BcSkKUlt1sX3Rf32BWrYsEgaKQy0
 KYSDJG78x5FAgGsaY4CaP/vF4kKx7w2lqSh35w6jb4jUc8lytKgZybG
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

This series reworks implementation of BPF timer and workqueue APIs.
The goal is to make both timers and wq non-blocking, enabling their use
in NMI context.
Today this code relies on a bpf_spin_lock embedded in the map element to
serialize:
 * init of the async object,
 * setting/changing the callback and bpf_prog
 * starting/cancelling the timer/work
 * tearing down when the map element is deleted or the map’s user ref is
 dropped

The basic design approach in this series:
 * Use irq_work to offload all blocking work from NMI
 * Introduce refcount to guarantee lifetime of the bpf_async_cb structs
 deferred to potentially multiple irq_work callbacks
 * Keep objects under RCU protection to make sure they are not freed
 while kfuncs/helpers access them (We can't use refcnt for this, as
 refcnt itself is part of the bpf_async_cb struct)

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v5:
- Extracted lock-free algorithm for updating cb->prog and
cb->callback_fn into a function bpf_async_update_prog_callback(),
added a new commit and introduces this function and uses it in
__bpf_async_set_callback(), bpf_timer_cancel() and
bpf_async_cancel_and_free().
This allows to move the change into the separate commit without breaking
correctness.
- Handle NULL prog in bpf_async_update_prog_callback().
- Link to v4: https://lore.kernel.org/r/20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com

Changes in v4:
- Handle irq_work_queue failures in both schedule and cancel_and_free
paths: introduced bpf_async_refcnt_dec_cleanup() that decrements refcnt
and makes sure if last reference is put, there is at least one irq_work
scheduled to execute final cleanup.
- Additional refcnt inc/dec in set_callback() + rcu lock to make sure
cleanup is not running at the same time as set_callback().
- Added READ_ONCE where it was needed.
- Squash 'bpf: Refactor __bpf_async_set_callback()' commit into 'bpf:
Add lock-free cell for NMI-safe
async operations'
- Removed mpmc_cell, use seqcount_latch_t instead.
- Link to v3: https://lore.kernel.org/r/20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com

Changes in v3:
- Major rework
- Introduce mpmc_cell, allowing concurrent writes and reads
- Implement irq_work deferring
- Adding selftests
- Introduces bpf_timer_cancel_async kfunc
- Link to v2: https://lore.kernel.org/r/20251105-timer_nolock-v2-0-32698db08bfa@meta.com

Changes in v2:
- Move refcnt initialization and put (from cancel_and_free())
from patch 5 into the patch 4, so that patch 4 has more clear and full
implementation and use of refcnt
- Link to v1: https://lore.kernel.org/r/20251031-timer_nolock-v1-0-b064ae403bfb@meta.com

---
Mykyta Yatsenko (10):
      bpf: Factor out timer deletion helper
      bpf: Remove unnecessary arguments from bpf_async_set_callback()
      bpf: Introduce lock-free bpf_async_update_prog_callback()
      bpf: Simplify bpf_timer_cancel()
      bpf: Enable bpf timer and workqueue use in NMI
      bpf: Add verifier support for bpf_timer argument in kfuncs
      bpf: Introduce bpf_timer_cancel_async() kfunc
      selftests/bpf: Refactor timer selftests
      selftests/bpf: Add stress test for timer async cancel
      selftests/bpf: Verify bpf_timer_cancel_async works

 kernel/bpf/helpers.c                           | 455 ++++++++++++++++---------
 kernel/bpf/verifier.c                          |  59 +++-
 tools/testing/selftests/bpf/prog_tests/timer.c |  92 ++++-
 tools/testing/selftests/bpf/progs/timer.c      |  37 +-
 4 files changed, 458 insertions(+), 185 deletions(-)
---
base-commit: 46c76760febfb14618d88f6a01fca2d93d003082
change-id: 20251028-timer_nolock-457f5b9daace

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>


