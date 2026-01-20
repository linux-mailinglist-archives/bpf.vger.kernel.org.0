Return-Path: <bpf+bounces-79644-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNnNC+m+b2kOMQAAu9opvQ
	(envelope-from <bpf+bounces-79644-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:44:09 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C712248C3B
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE90B50D5EF
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D4F318B8A;
	Tue, 20 Jan 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVsgLs0N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A528980F
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924770; cv=none; b=gkgXrKdHJuITQvubmnnpLk/2XjyhuyIwSwVrACUPgS/z+XazQQw1/vjN+rSDd2Qm/NfkgWPzU1y1/VWTEXUlfvDZfAGnl1Hjuihz8xwewhym9Y5wXY/M86NaewE3kRL4Rv9Vrpjwdr3KFQfHOCGK9/ew0JETq64Ee6TWI6sWdAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924770; c=relaxed/simple;
	bh=1FVC6ShuVsFDaJyw3YTLWFLLhxzbVIvUBBjW5vfVY9Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uJCmVh+tAX7i943ek1atfpLkKR7f4QZtbmJODiLTfPmPDCf7VI7Cnmk6wzrZPw9HYdfhtKk/3cyqSbRa0XouFuS3oTuC8QFkRQJ5tw0Nk3gYAqMIcEo7KgLXJ2Vg2uXzRcf7V3p3u8fIZGvJ7JkBfv4vL7iKcZLXHAUs2DoE32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVsgLs0N; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so4875075f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924766; x=1769529566; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/1yIQ84CJEUv83yfA1YA7JUk5Lxp2ls8/75tB0kQIQ=;
        b=aVsgLs0NvFDijHMubYdwqOoQfrnIYPIItfLy9UzIJm9yuvfXeXGYfTHgqtR4qjM7f3
         zsVu7dSZ8126PYU1nh0VaxH7T12nBDgFsKvRTAd5Kj6mjhp+LVJDQDLesHYs+JTUOIyl
         uQxdmcWLW6Tni3a5kFCOOC9JQeQ03rd8PmyzXjZ4d8DwzVNIt3bW/Jws/nkv2osZuLkE
         PDRUbKYO17Mw/zwcJWQ2Qd/rplR+ebOHGa3sWIx0QSWwD6+AoKA/U98iKx7ZsjtFa4zF
         qXtrVWdxf4KjM5R3wqyTog6GT/zZ6pRVAMQRuEL0ABSxss8jvNEZYpbwfQtQhO+wdAwh
         ldiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924766; x=1769529566;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/1yIQ84CJEUv83yfA1YA7JUk5Lxp2ls8/75tB0kQIQ=;
        b=HkLLfRXWs9alEECWB32GuO8Q+SJIFaSvRpzAdjOqly7b5qqpSOj8rdbTzZIlRVWs/T
         GEJBaC2Sx4T4g8FedrYe2LT1xBsJSZD6U5klr+ojXg5bFlCZa/mSpToTH/X839QV5mPC
         AMyl1UM+6xXHCx0ql1SZ82O9espRwDX2FP2W/JoxzIXRZAUY0zxcxit71yhz/LlUKhBv
         sB61yKsZ4O0Kaxemz9oGJUK6yLbHhQAv5JT0Hfu+uyNojRLklQM5d1uGSNSI73J5LUJD
         rDXVJRl5PBbhXi/2qdqWjYQmM4M6H8VD0MnP4nL+6bgL2Car1gqWRYHvgUrdjrT9BTeZ
         tHvw==
X-Gm-Message-State: AOJu0YzIkkBS9jc3zVbW8QdA7j6ktcKZVGV7WNk7J+o7SZDzbCk66Umx
	jz2xzuUHD4xhK2SNfc8OPjEnk/6+1pnYN5sPi63NFKUYfCMne8KA0yCo
X-Gm-Gg: AZuq6aK47tuWdnZak9jP+Doblg6X1QbBLgVZcbSOdBNbNux3cvzaBaqmCit6/W+4YRJ
	osJA0YdCfEszlxQvIIqyK3Khkiv3+1MlukZbBeyV0T4/aBHwiNZuB+hHgzDctZ5akxdlypTF9UU
	9DzFdv61zed7kza5qxbt53sqzmb7+/BGcqZtAnEb7YKeAyNhfj7Z2iXnhZVASzxOxbNderXVa8W
	3rPMxC+yk/S7b+e9cGBsQ6hbUlliBS8talYznrt7cZjC19VcPcaV585toV2OUiC9VDdSSTUzbl8
	f2s+FNofp6HbW2DqgUAp9bFXikfVHHVSzHBxLh4bAHyh1aS0af5fHCU+V463/bQZXKNqk3b+hzr
	34taHHp+++2e+yjzBnxZGndVBB1soD5y6fYCOBQI2tWpoK10o2t+7VZ+y3zcJ9PCHqbsFtTY0a0
	73pZ0T/6ElW9kmWA==
X-Received: by 2002:a5d:5f93:0:b0:432:851d:217e with SMTP id ffacd0b85a97d-43569bcf1f3mr18778321f8f.44.1768924766132;
        Tue, 20 Jan 2026 07:59:26 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435966322a2sm1274451f8f.38.2026.01.20.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:25 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v6 00/10] bpf: Avoid locks in bpf_timer and bpf_wq
Date: Tue, 20 Jan 2026 15:59:09 +0000
Message-Id: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13O3UrEMBAF4FdZcm1k8jNJ65XvIbIkzcQN2mZJS
 9ll6bsbKmLN5eHwnZkHm6kkmtnL6cEKrWlOearBPJ3YcHHTB/EUamYSJAqQHV/SSOU85a88fHK
 NNqLvg3MDsUquhWK67XNvzF8jn+i2sPfaXNK85HLf76xi738mlfg/uQoO3IPRjjQoH/3rSIt7H
 vK476zyzwrAxspqlTR9Fzx0PrrGql9rQIBtrKrWagiKBkUY+8bqgxW6sbra6IxCjCiis43Fo21
 /xmoFknIUpQUVDnbbtm9qZPK/oQEAAA==
X-Change-ID: 20251028-timer_nolock-457f5b9daace
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924764; l=4158;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=1FVC6ShuVsFDaJyw3YTLWFLLhxzbVIvUBBjW5vfVY9Y=;
 b=IyWnBK9kT+ftc+GNSBnTguUBtYI3LUxzjWalZIti8iWTOfyyiwHpg9tTTXHtZ90JLMBBG/2Ur
 K85++pNwRBfA+c9LMKZpcM5J+026VmNaIzY5Y0YRIuP3eTRhn2WUTdt
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79644-lists,bpf=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,iogearbox.net,meta.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,bpf@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[bpf];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C712248C3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v6:
- Reworked destruction and refcnt use:
  - On cancel_and_free() set last_seq to BPF_ASYNC_DESTROY value, drop
    map's reference
  - In irq work callback, atomically switch DESTROY to DESTROYED, cancel
    timer/wq
  - Free bpf_async_cb on refcnt going to 0.
- Link to v5: https://lore.kernel.org/r/20260115-timer_nolock-v5-0-15e3aef2703d@meta.com

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

 kernel/bpf/helpers.c                           | 526 ++++++++++++++-----------
 kernel/bpf/verifier.c                          |  59 ++-
 tools/testing/selftests/bpf/prog_tests/timer.c |  92 ++++-
 tools/testing/selftests/bpf/progs/timer.c      |  37 +-
 4 files changed, 464 insertions(+), 250 deletions(-)
---
base-commit: efad162f5a840ae178e7761c176c49f433c7bb68
change-id: 20251028-timer_nolock-457f5b9daace

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>


