Return-Path: <bpf+bounces-78942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C28D20D16
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B79EA309E473
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E734732B9A7;
	Wed, 14 Jan 2026 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATZr/a7f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B3334C35
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414987; cv=none; b=TQeWgPOdRAl9o6aLzgPDGZOiXXU0SMpR3wjyXfj2LbCBCHmqK7y9zVEXbWmGeW0BMVTRoa3FE1IEgufElOmvMr+3QnHmRJWPt+D63NGjsMzQXYrwGFe+UJ7S48je/o9ltd9b1Kt5vrX71TLKcLgnQgjbKepS5E3sR8VCzoKWd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414987; c=relaxed/simple;
	bh=9YcRnErSalLVkXST+VSkIHRr62hFd/lI1C9DTTVo8yQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cXkhGk6TV/SecaR9qGEzKvLDpdiLVsLwrg6oMTytrdFc1sF55ys39h3ffki8eRk0Q8Gc7zdEKcD+OZc0QDylG9kAtGVxI495Bc6A284q3dqORF2yabAFtyUPM/kGhlpsJSoG/yRCZBJfCRaEnjgi6q1rqZ1Rq8nfqBna1P7kzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATZr/a7f; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ed9b04365so1018875e9.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414984; x=1769019784; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0DgZqAfZe09rmaw6w4UmNLk+ARPKEpg29gFjOZLKnM=;
        b=ATZr/a7fG5ClzRa1iGJyLY3TxX/XK2eEAhd+4aw9GXPa+JYl/iWrqeN+jwJR9y+B1j
         7KNV2831Tjs+3lxvMoVY8nXa3MyQmjEaarlOZmPjpGsJUzxI/WQOYK0e42oif2FaQAqc
         YN+g09k20kL+SVQYPl7dFs8uZ111YvzQdzebSQ6JjNlZdygtBuYSTsMMeXZsoTOa1CQq
         hjerYU+TpuTp2IzlqFIZrMDo0hmkJySUNSK31PgLwZrm7PQfMcgo4tCM5oASgVQp4PfO
         tY4+0f6yANgZOPx0qvCH/fvk2FGSt8J4oxW82BcxOyHnJPhlsFNZPbTp68PAWCaNfgHJ
         05Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414984; x=1769019784;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0DgZqAfZe09rmaw6w4UmNLk+ARPKEpg29gFjOZLKnM=;
        b=JqIXhSzwc+WxrS2NX149MaW+kD07+SF6gnqvYs5z12dcQUOtcNCJdoapsntDQug2Gt
         ryWeiQPMpmNymaua3KW3p9MqUJdzF0RgXpXeD+5Q7Rj2A3n7+adEqP0Mpqv2EcdZXAYZ
         I+UHkFVgIRvhtDOlVQPM/fNoxzq8Mo95exgBoKh8eRP8Vij41UXcgolQjpLRPPQhG8AV
         5m3jAC10oF/ulr3KgWWsYR/Me8BB9m8ou7rkWwzEtudpJndfCRJYp9C0KMK1Cr+sHu+R
         TKfyArA+vXZDqwjkDdelaO1zS3w6bwZ6TgArnmFt6RM4vsIt8vMX6gtU6+gsmeK9maCZ
         u/hg==
X-Gm-Message-State: AOJu0Yzot4dJ+e51/dVT29sj5yak2ReEDyw223tOpBr+TXsoTjP9gRyP
	8mQUvskpwigf6n2EhaUeVJErVtJVZc2AQQRwAf9I6Wdz9W7R1ott9WkS
X-Gm-Gg: AY/fxX4BVnNf0Uga5u+e/JYtNrwxCh5dJVqrbA5GiRCKnqfIKfZKw0BGgozP/doaih3
	j5lE6qqnErIzhrqckfrMJhWM+f7fDcb2P/QwB6BwDaenTRfMTSTN8WZhk4Fvcinfei2DdNEG0ml
	p3/pDgG2rVbq00N1N2Uv4Ki2O3KT5g63FvA+UvFC29zDM8e0HqY4WS+S+UQIh5FPkf5no6EZNWc
	ZmqPQJWAVMhyfLSiPa4snBwXKmjl9KjSHaLXhuMvVPfRZ0kFm6a37j3uIPsl8vFuYN3RZ2DjZtr
	tu45Ef5keAwFNQL58Wjg1i/Xo5Trn/W4btF7WQ8WuI06OY/CT1yk8Ih8893bOk1dCxTNEwXwmUS
	m05tzrOu7+UvRfnUm/M2mbinrKyutkCDRVcgciCuddtcAFhklCVSyh0NyTw5NbR/KJW80tbD24J
	NgKfLMEptxRg==
X-Received: by 2002:a05:600c:45cf:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-47ee3373056mr47045875e9.26.1768414983728;
        Wed, 14 Jan 2026 10:23:03 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee0b8de06sm28527285e9.1.2026.01.14.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:03 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC v4 0/8] bpf: Avoid locks in bpf_timer and bpf_wq
Date: Wed, 14 Jan 2026 18:22:44 +0000
Message-Id: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13NSwrCMBCA4atI1kYmrz5cCYIHcCsiSTrRoG0kL
 UUpvbuhImqXM8P3z0BajB5bsl4MJGLvWx+aNMjlgtiLbs5IfZVmwoErBrygna8xnppwC/ZKpcq
 dMmWltUWSyD2i848pdyD73ZYc0/Li2y7E5/SiZ9PpXRPsv9YzCtRAJjVKEMaZTY2dXtlQT52ef
 y0DNbM8WcGzsqgMFMbpmRUfmwGDfGZFsrmESqAVqFz5Y8dxfAHFyLYxJAEAAA==
X-Change-ID: 20251028-timer_nolock-457f5b9daace
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768414982; l=3125;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=9YcRnErSalLVkXST+VSkIHRr62hFd/lI1C9DTTVo8yQ=;
 b=O8TgkDxzYXkGwEklRZt5XkUth0ePw4FG+szK+1Yke8kW/LeK3lGDKGuomVclkUUBGkRqtLs6+
 ObodIckuMQ3DYTxEbPXlZzuFSGapLV5DYopiolKvIWbcySBVRQH1R+6
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
Mykyta Yatsenko (8):
      bpf: Factor out timer deletion helper
      bpf: Simplify bpf_timer_cancel()
      bpf: Enable bpf timer and workqueue use in NMI
      bpf: Add verifier support for bpf_timer argument in kfuncs
      bpf: Introduce bpf_timer_cancel_async() kfunc
      selftests/bpf: Refactor timer selftests
      selftests/bpf: Add stress test for timer async cancel
      selftests/bpf: Verify bpf_timer_cancel_async works

 kernel/bpf/helpers.c                           | 441 ++++++++++++++++---------
 kernel/bpf/verifier.c                          |  59 +++-
 tools/testing/selftests/bpf/prog_tests/timer.c |  92 +++++-
 tools/testing/selftests/bpf/progs/timer.c      |  37 ++-
 4 files changed, 444 insertions(+), 185 deletions(-)
---
base-commit: 46c76760febfb14618d88f6a01fca2d93d003082
change-id: 20251028-timer_nolock-457f5b9daace

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>


