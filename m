Return-Path: <bpf+bounces-73516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12539C334E5
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A760426069
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7D4320A39;
	Tue,  4 Nov 2025 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg0VjCFy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F982FD69E
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296877; cv=none; b=pQ/OLJv80Z8mFtUFKiFQs4z1EWKYWNaHMuCP2fQ1TqhPYckmszJ/t4y3dq97nbSm6iBlm8Gv5P9BRIK2NBaImKJLSMU5SiQ3/UfFsfzT+X/YXf45G3Z8zmVxfFMyaA66vu+qlYuJCCkImEuZHWMCsSyYQiK7XfY4zyeGNbwI/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296877; c=relaxed/simple;
	bh=P71L4tqf3OdcU2sFt/goijRnAR9BiJADA9tvw1xfCuk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=blR8mD3jt46BSPzHycKfuH4jwjgrHQ8kwP8Q6jwfo/UHcRihlRfZbYl2lUrEk91e+opF24AMzPV/6bghHWbNELwEUshigK34P1siprZEPczUKz78xQnAYgknQ6yruCs1qoZGz7kvKpcSE8W3ar1PnyA8MHbRPLIlzCdOnaVjLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg0VjCFy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4283be7df63so3345165f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 14:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762296874; x=1762901674; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAhgs3cG6h2I6fy57UQkUA+0bLrTDgbh3ABuQi6E1PU=;
        b=kg0VjCFycQ22DcZ9dC1DFlVJi5N6vcI/+xGQNx0pgUOSDt5hgrwCGy3HVl5MMTqSXU
         wlg5iZPL5KqGDVfsvzbol7W8htouJGAnNluLAYE0z8QhK8p9pI4R6L1D4I6mr2XT1JXg
         0WGixYkrgMpy9MoUbB4WceMUuqZs4V27Ucher0EZr+G/pkZm2tA1rM7NlgL/zASnIbtv
         HArW/uco4cP7KKlt9xHITzk957NouKLPCY1l1FvdXDLPv5IM5yY8xvrL7Dk5MEGCd9xx
         5OU+ofWgb/tharbSbntU3ykKXh3hM8NnCmCV5h5g25eZJwYOt6AyS1bcboZGMWB+v1FI
         OkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296874; x=1762901674;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAhgs3cG6h2I6fy57UQkUA+0bLrTDgbh3ABuQi6E1PU=;
        b=v6ruTOmnTFhSOqEN4Q7NQwXtgMwZ34cPYqGy8qK/UHk+QXxZ0+0zkw24D96HDCCia3
         XRD2R86nxxgyqNjK0EXms4pT/4MoBQEC7+Uh1Lq1QXE3e+X5Eo2IW/55ZqY5y68JpE3K
         mo6qI00UNuiircjgDbsTzfgGgxikGUz18ASNpYxH1UqwdD0VlM3JLvt/ATzp1C/Euaxm
         yh953+CDHp8wX9uT/VzMZuiZwZ4+7EBCbOsEHMnB3fk7W8nfOIrUPmDqRLr7OdQIfLxK
         xmO223XLYfwhHu5tQYjy4g0Pqb2F3BybQEW9sBvfPL0KhugrJ6JYtROkJglPbcTWRMMS
         SeNQ==
X-Gm-Message-State: AOJu0YyyU2CFvtatNAwgXkc6jz9i5AygBYmYySmCGH8pzlaw2XGFPHsj
	7vK3U7vpJBCWtSdbFKM8EBnNBAe1YN59HssZjMA2vtehif41O4L+V+g2
X-Gm-Gg: ASbGncs7fxLyaZ77+ZBfRh95K67fV0NoRBYA86WLEwrvsnrv2NJcKLtsv9CBqI3I9Hx
	l0yuXTtua9H35nvQxsPuzJl0meQPXp6JRR7Ogeau3/Pv7eFBHn1rcf1i5koHgbPlIOULxaJbAyE
	7Va3mSQkdRR9mbi1onAi1fd31dOJ8NmM7ww8CN5l0JV35RK0wWPD5uTijrsDXdjOJQ69UKBlURb
	mY/Ud971tLP05G332AcuGD5XuUATr6sGRz/16oisAevDBc9G7i2PAsNhWi0rV1gfszE4HhHv6UX
	Xoyue8Qjys6DNlqnFQ8vgdqxUq7sB7CrOvcU2TYzLUFNNodkUybe3ztc5Jd3C5wOKUdGkqQ0hHf
	RIrAX9byBtoXZQDhyHRqzO4+zOy1Fv5q3nKQSfRUI4NoMYdPqjSYmcujQnPyDpfIUhZp43SLTM2
	BaLls=
X-Google-Smtp-Source: AGHT+IHppnSWO0ez6mDnTi1oFBH0byJXG88T9Ybj4KTXjHfauypopEjC4Tvk8dx9WQUBv8AsSQcxjQ==
X-Received: by 2002:a05:6000:258a:b0:429:b751:7935 with SMTP id ffacd0b85a97d-429e330da19mr767886f8f.56.1762296874231;
        Tue, 04 Nov 2025 14:54:34 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18ef99sm6466659f8f.7.2025.11.04.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:54:33 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: add _impl suffix for kfuncs with implicit
 args
Date: Tue, 04 Nov 2025 22:54:24 +0000
Message-Id: <20251104-implv2-v3-0-4772b9ae0e06@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACCECmkC/12MwQqDMBBEf0X23JS4mtD25H8UD5ps6kKjIRFpk
 fx7Q46FubyZ4Z2QKDIleDQnRDo48bYW6C4NmGVaXyTYFgaUqNpW9oJ9eB8orDb9TKiURA3lHCI
 5/lTRE+bgYCzlwmnf4rfKD6zTv6dECm1n0ynX3R3eBk/7dDWbhzHn/APWIyiFoAAAAA==
X-Change-ID: 20251104-implv2-d6c4be255026
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762296873; l=2400;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=P71L4tqf3OdcU2sFt/goijRnAR9BiJADA9tvw1xfCuk=;
 b=qR03k8jnQEFVQODPPCljGc5XhgsySweHjTDtKiyplPc0zRfaNTN8rJnakGwJtPwZXYvo2Jm+p
 whN8znyVYb8Dhj09QjRAynuyqdve/465A4poZfn7LPTTeblER6/+KTU
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

We have established a pattern of function naming win "_impl" suffix;
those functions accept verifier-provided bpf_prog_aux argument.
Following uniform convention will allow for transparent backwards
compatibility with the upcoming KF_IMPLICIT_ARGS feature. This patch
set aims to fix current deviation from the convention to eliminate
unnecessary backwards incompatibility in the future.

Three kfuncs added in 6.18 don’t follow this *_impl convention and
therefore won’t participate in the new KF_IMPLICIT_ARGS mechanism:
 * bpf_task_work_schedule_resume()
 * bpf_task_work_schedule_signal()
 * bpf_stream_vprintk()

Rename them to align with the implicit-arg flow:
bpf_task_work_schedule_resume() -> bpf_task_work_schedule_resume_impl()
bpf_task_work_schedule_signal() -> bpf_task_work_schedule_signal_impl()
bpf_stream_vprintk() -> bpf_stream_vprintk_impl()

The KF_IMPLICIT_ARGS mechanism is not in tree yet, so callers must
switch to the *_impl names for now. Once the new mechanism lands, the
plain names (without _impl) will be reintroduced.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v3:
- Fix commit messages
- Link to v2: https://lore.kernel.org/r/20251104-implv2-v2-0-6dbc35f39f28@meta.com

Changes in v1:
- Split commit into 2
- Rebase on the correct branch
- Link to v1: https://lore.kernel.org/all/20251103232319.122965-1-mykyta.yatsenko5@gmail.com/

---
Mykyta Yatsenko (2):
      bpf:add _impl suffix for bpf_task_work_schedule* kfuncs
      bpf: add _impl suffix for bpf_stream_vprintk() kfunc

 kernel/bpf/helpers.c                               | 26 +++++++++++---------
 kernel/bpf/stream.c                                |  3 ++-
 kernel/bpf/verifier.c                              | 12 +++++-----
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  2 +-
 tools/lib/bpf/bpf_helpers.h                        | 28 +++++++++++-----------
 tools/testing/selftests/bpf/progs/stream_fail.c    |  6 ++---
 tools/testing/selftests/bpf/progs/task_work.c      |  6 ++---
 tools/testing/selftests/bpf/progs/task_work_fail.c |  8 +++----
 .../testing/selftests/bpf/progs/task_work_stress.c |  4 ++--
 9 files changed, 50 insertions(+), 45 deletions(-)
---
base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
change-id: 20251104-implv2-d6c4be255026

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>


