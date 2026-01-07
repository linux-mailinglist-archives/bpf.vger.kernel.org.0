Return-Path: <bpf+bounces-78134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19BCFF423
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 269E63000B5B
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C0395246;
	Wed,  7 Jan 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed7IM7rW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2803939B9
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808183; cv=none; b=sOo8Uoh7RcVYSmIpgu6zPjRXehKkh+pgP5FyBN7GIxyj0pHfLVkpB1wNcpKNZrpwWFNQ1GyS6DwoEcDmzmUuY/JVIjVdI8KrSaw+iwr0rAyxTNb2lwo9nD0ZVfPJZP3n/KhmeC+GFJHZZzZ29wutIBgho2eROKpFulOwozbcpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808183; c=relaxed/simple;
	bh=cxJrrtEo6c0alZf6XlMc8ncFuIUtHOTGHEba5rnj6xU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qC0tshO3kPtZ4mqjFQ8Hiq6/kJD0bxc3USEeS1fLkVk8o/3O/dedoehLa+nD4F8tho92gtmJluF6y27wH62ABQIqwEaePEmv4tli9MOryiQ1jwZhDRmH+ruGAb12C9DAC1756v2KOYVnJ2RWkBeTpR2rmRufiLa4BC7n6Fspd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed7IM7rW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so11570195e9.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808175; x=1768412975; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qo58QnSkcbLMQOVT5hs9F0tFyxoRj8xk28LikESFlE=;
        b=Ed7IM7rWvts6cfCiAnoaCH22dVDvKiYgCstVJQfK+iGn4mW9dYXi7FCjytlMQW2QCw
         m3oZ70BE2hDAycT8BKi9EB4M9YoibsUuPzVKd2tu06+rIAvvaAVhx+W9Dql/ZQa+ZyCQ
         4C5jCtANxoii/s0PsFxFUX2AIeH1BmjkpHKm2RLQzks88qZpGCDbTMxrkvUjXwI0aVLQ
         wGKqe3RWY/KAIk6KG5TOh73zW4FL12YyP94eFEaPjiOD+4ySi4TfZiyUaDodRXoO9CwW
         VAw3y/ppM57Jls29JSm9RB5A+/3fCB6EsD/Eps/ZuHX/dPnbpwoigzV1sqXBYwFuaD7+
         is9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808175; x=1768412975;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qo58QnSkcbLMQOVT5hs9F0tFyxoRj8xk28LikESFlE=;
        b=B2onuJQDUeZ2pvIHTaE53fKVaNQ9HNt/qeLRr6my8QxHXNykG9nlpK2MVcWBTrj/As
         A+wwR5VeFkZvQPgIYJe4TH/pLjaEhaB6Q1DbbNxYXyrrz5L9linzWqjplIMYTK1u7AjF
         EJjqHid9+Tg/3FgSVgkW0hy+WOOM30dWvNf+hvdIu95aGAw2f/Klduh5UmpqLcj0avww
         EaUz0S0Kqe0iDqRUS5mpbd5uo7N4m3Ugoq480r4A7eKbaGY48rl+czEx6v0RWJSPtsWj
         miUbIdCrDHTvd5RBqnweygGoKh2zocSfvh3sWq/UKbn4eWjKov8it0XRDhBHkWMXL3g5
         /fbg==
X-Gm-Message-State: AOJu0YwavSeXS9QXmdHniSMxKBb6Mp+l2tTS/MbHXxVcSkhhecdWFRY5
	DNr6QNZ+HmvWZBDSOb+7pNoTQf8MLU2MjK0x2yIUri8fnAnHYzJMtX2b
X-Gm-Gg: AY/fxX4hF5PZWbEtWZMNQPG3s5zLtVlsO1peeynvnR6TNt/dx4yz9MWcU4Bnst76XoX
	oYvkRj4zv7cS1ycC5mts/J9nWK6uYCHkgOUPm1oQ+bi7PFNQnw1RnJKu5dZPtJABx+zNmADOGz/
	0ePnw+qX/SxgEwAvVuyd2P857A42b3vD0MgOjAwYGTra+wuJh2n/EFQJkMq594HnXYcDPq3u8ZK
	p2JnhHw6lL7aFBMMPW9HrqidDw0g3vsmOHt8GI4IMwGDzVWLXoiL3wCznqE7G6Lj9SAjHtpCxT2
	txzdeXy1lCAyPaay4FvUUCJN16JkOMqhWAv9rFAg3queJnsGD7XS41GCw1pV8EGNMTeC+2MuC2y
	wo9OlwpxAfR/2tkQIkAiEAjLRazrtzI5G7ndq/SBI79SiTK0HNNUKx0f8GimDQ2WjPqc=
X-Google-Smtp-Source: AGHT+IHWX3+vD0A2wt7vMomS6fuxVa1mF89ZeMaIiCCU0AgiFuEHZGrTaX4gpTbhiGj/FiYbV8eNYw==
X-Received: by 2002:a05:600c:3b90:b0:477:a02d:397a with SMTP id 5b1f17b1804b1-47d84b26cccmr39746125e9.2.1767808174527;
        Wed, 07 Jan 2026 09:49:34 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86641e99sm18245355e9.7.2026.01.07.09.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:34 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC v3 00/10] bpf: Avoid locks in bpf_timer and bpf_wq
Date: Wed, 07 Jan 2026 17:49:02 +0000
Message-Id: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NywrCMBREf0Xu2kgeTW1dCYIf4FZEkvTWBm0jS
 QlK6b8b4sLHcmY4ZyYI6C0G2Cwm8BhtsG5IQSwXYDo1XJDYJmXglEtGeUVG26M/D+7mzJUUct1
 KXTdKGYSE3D229pF1Rzjsd3BKZWfD6PwzX0SWp7dNsF9bZIQSTctCYUGFbvW2x1GtjOuzJ/IPy
 6j8Y3liBS/rqtG00q36Yud5fgEaBDfX6AAAAA==
X-Change-ID: 20251028-timer_nolock-457f5b9daace
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=2708;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=cxJrrtEo6c0alZf6XlMc8ncFuIUtHOTGHEba5rnj6xU=;
 b=YFzAqCN5VDQCHb9JeoGJ1jfMn93NkgS0eNilCF61EzdFaS8Pm9+05ALghpJN32AIGWZzXer9r
 V8MQhzVlq0FDpxm8TK5o53uLdl6hY98RXbQOfBFJZgj+dLCXbnrL22X
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
      bpf: Refactor __bpf_async_set_callback()
      bpf: Factor out timer deletion helper
      bpf: Simplify bpf_timer_cancel()
      bpf: Add lock-free cell for NMI-safe async operations
      bpf: Enable bpf timer and workqueue use in NMI
      bpf: Add verifier support for bpf_timer argument in kfuncs
      bpf: Introduce bpf_timer_cancel_async() kfunc
      selftests/bpf: Refactor timer selftests
      selftests/bpf: Add stress test for timer async cancel
      selftests/bpf: Verify bpf_timer_cancel_async works

 kernel/bpf/Makefile                            |   2 +-
 kernel/bpf/helpers.c                           | 409 +++++++++++++++----------
 kernel/bpf/mpmc_cell.c                         |  62 ++++
 kernel/bpf/mpmc_cell.h                         | 112 +++++++
 kernel/bpf/verifier.c                          |  59 +++-
 tools/testing/selftests/bpf/prog_tests/timer.c |  92 +++++-
 tools/testing/selftests/bpf/progs/timer.c      |  37 ++-
 7 files changed, 588 insertions(+), 185 deletions(-)
---
base-commit: ea180ffbd27ce5abf2a06329fe1fc8d20dc9becf
change-id: 20251028-timer_nolock-457f5b9daace

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>


