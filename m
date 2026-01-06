Return-Path: <bpf+bounces-78022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEDBCFB5B7
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 00:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54644300CBB8
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 23:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7B2FFFBE;
	Tue,  6 Jan 2026 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="WkTUKRUt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEDF2E1F08
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742631; cv=none; b=R1CXgu+BRPxhU2+qv1QgHyHsmhcNmfvMB2xCiFBqSWHf3UklyyJXq1nGXGQAxwGojEy0Byb3mUIpFnXjlSSIF09cjvTZjaB6iaCuKewWUaozSg9D5oduLIIo7RgLHmTeJpl58jR/YEyha3roQiLNJ4ZxlQSfEzEQXAxWMu4BaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742631; c=relaxed/simple;
	bh=MKhpMoCT26gN9N8XNquP6Safv1WlIXOcwA2RX84BRZ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sszy4M0Z9ZjYXnfTzFnFW3HG11ZEhholEiu9NKgSjxNwrCRtMMFlUMSblbX23wHtdXhsb3qI4S2Nl3UGYkJTWWvRI/I7NftYLuhPD56tLk3ohLb33kUFaso67evtobhiR3lnjooIDqMhT2uTltB3eKKA5rBUQzR/Zefj1PKeNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=WkTUKRUt; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88888d80590so17011596d6.3
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 15:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767742629; x=1768347429; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LP62EAq+P9/lxxyuv9oa+yCPENsH82yut1NvO1F8Wog=;
        b=WkTUKRUtwTVTfpr9+31dfoDtqLXIQMuJXcAtu3vu4fyIuPd56hrbB4ElFMOLQ31PVB
         vQK4X5non/1XqJVTEuyJckM8TVxbJBVwP6pFd44iI9Ryep/9m8exgGzOBbwlQrGu6GJE
         JKkspbwxZdrQ/QedS4xnLkMQ/0X2EmRiIzos8xlSntjInH4hCSMgijjHQuoxvCY46EaT
         C9cS1/CNxz8fJjO79VaKinIeSq2bAhnzaR0EWlgbv+G0bsnu4ZRpVxCNTRWiXnVSjuMS
         tKyVnNluqht7LXtRs3m90pl0yIBE39mm7S4tZZXuC5LH+2SHS9lLhGMAIXvZ82hmFnH3
         4ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742629; x=1768347429;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP62EAq+P9/lxxyuv9oa+yCPENsH82yut1NvO1F8Wog=;
        b=IUogb/BZodYqmhBwfyz0hFuIukrlGAxTJDQWr5Ux+YDZTnS+Wg1HhvD29gxac91eI9
         jqqt0VEacGA+HBjp+231ySQJGi1SaK4bJRrG7f3NY9k3aCsgFT8BzEIUf2iVZ/U84vvj
         SprQ0T5zL3gY2q5DwS52oCG+6d1ISH0RTJFntM5rNsauUCnMbxY3uiSpKwnLtiT32w5Y
         jmHxglxWLhIxB+LI3hmmWZF4GttBOdjzXByyWpD50783IycjPRYiDEJID/weG7GXhdIN
         3JQJn5Y/CS7Xs6vQo7rbn2ISwgGdxMfBh8Ymvt4UvfH+bv8GdpgTaJeMbs6N4xMkKX3c
         H4UQ==
X-Gm-Message-State: AOJu0Ywx4BO77zegfzCjDruFdPUnNCKRDJbldH1tWRpOT1pZE5tiQUNb
	2fVubtff8L4AQoSZAZF5T3XEvKAyzoo1vjtjpWG9xx/IRZvFMVKzDa7TtriBgM3luXE=
X-Gm-Gg: AY/fxX6GlBigR1OhVI0Z9nFKh/pM/RyqCenUVMQAquq8BOVdVq9nHIvFXuataHzbNua
	kZkvXZ1SamSJvqLn5KWNpjGod3E2oY+3BtGDGtWQ6xRwaCHOuHyqAfaIy3Hk1u8LRfHy18deLif
	Bk+CEwQ0/+hz3wdWvMPUriSGqMquMKcg7dtvKG2A1Kelm5GEWm755UPBASReiTf5iyFcTeJAdUO
	FNnOgHP44Qto6VCSRHlLtOB2dq9Timyg/vXRFOYlhFMigPlB4pA8uXQgyWd2c2gZY9C+G6RgnzT
	zBrPmbPam9ZnWBVxI+tjLzrz+AwAQg3oCIiY8pv0Dt+2D52pCxjUQQBAH6In6nl/wkk3v5bIzyf
	hfIBdJ8c+e8U4lhVDr2VhZli7PQYMyvEVwPVbYDDm/A19CDnA4HZ/TpfMB/Fpk9UcMHtHBmogjW
	7ZKlVUvWp8OOx/iTev
X-Google-Smtp-Source: AGHT+IH2vaxiSC0M5ZuAB48pnotkEf0QAgo28d3ugBdcMkQ7gkMxmcFEKXLfCXOB1QlDzk3OSIWing==
X-Received: by 2002:ad4:5963:0:b0:888:4930:797e with SMTP id 6a1803df08f44-890842f59f9mr11423946d6.70.1767742628738;
        Tue, 06 Jan 2026 15:37:08 -0800 (PST)
Received: from [192.168.0.7] ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907724ef8fsm22590116d6.42.2026.01.06.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:37:08 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 0/3] bpf/verifier: allow calling arena functions when
 holding BPF lock
Date: Tue, 06 Jan 2026 18:36:42 -0500
Message-Id: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIqcXWkC/32NQQrCMBBFr1Jm7UgmSGxceQ/pYkhHO1iTktSil
 N7d6AFcvgf//RWKZJUCp2aFLIsWTbGC3TUQBo43Qe0rgzXWGTIOOUtkfMZeMo4p3NGbo28dOfF
 0gDqbslz19UteusqDljnl9+9hoa/9E1sIDbrAPpClvrXuLHPhkSeetexDekC3bdsHqsA/EbYAA
 AA=
X-Change-ID: 20260106-arena-under-lock-90798616e914
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, ast@kernel.org, 
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
 eddyz87@gmail.com, song@kernel.org, memxor@gmail.com, 
 yonghong.song@linux.dev, puranjay@kernel.org
X-Mailer: b4 0.14.2

BPF arena-related kfuncs now cannot sleep, so they are safe to call
while holding a spinlock. However, the verifier still rejects
programs that do so. Update the verifier to allow arena kfunc
calls while holding a lock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
Changes v1->v2: (https://lore.kernel.org/r/20260106-arena-under-lock-v1-0-6ca9c121d826@etsalapatis.com)
 
- Added patch to account for active locks in_sleepable_context() (AI)

---
Emil Tsalapatis (3):
      bpf/verifier: check active lock count in in_sleepable_context
      bpf/verifier: allow calls to arena functions while holding spinlocks
      selftests/bpf: add tests for arena kfuncs under lock

 kernel/bpf/verifier.c                              | 12 ++++++-
 tools/testing/selftests/bpf/progs/verifier_arena.c | 38 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
---
base-commit: a069190b590e108223cd841a1c2d0bfb92230ecc
change-id: 20260106-arena-under-lock-90798616e914

Best regards,
-- 
Emil Tsalapatis <emil@etsalapatis.com>


