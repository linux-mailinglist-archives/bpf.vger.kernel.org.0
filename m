Return-Path: <bpf+bounces-73450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E2C31D78
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 16:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFCC3A7A4B
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE127467D;
	Tue,  4 Nov 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI5F8Ha7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924D269D06
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270215; cv=none; b=MJTQLMaH35C7Yx7zLPB7feL6iikqSoxdA5F+6j6BoxR3YmJLPFQ27YZ3j610IUlJ2MG0fCJFJzKxm2WjVGtoYB5DUEHzkTVrprGhAGQ1sET8ztFQPWt3JVARNxYDDdRyOgw2uJmYYr+ytOjlyuMeFaQzfaRZ54tNt1kvxXCeOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270215; c=relaxed/simple;
	bh=57dj8uPvxQsBZBw1ICgfwNGGfh34CWNQ/xLOi/SZzTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O26OemzRosiNcsVoh8PR3NwMDOpEFpsg3eE41jdLWu89IVbnE3ehWgs5m065QkPL2eYd+nDvITuPO8pOn65fSHZUFVb8MJEENPjsl3KRMQXVJ4L7RVmqkhoxHmky9Zrr1zhcPpYfQq1NGAXVBaAhcuBcYaXJ1xI+we1tqYA/VrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI5F8Ha7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece1102998so3862636f8f.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 07:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762270212; x=1762875012; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTXW29oVq2rOGcxMO1TiwqrUFdRpJ03gDLwEIoLlbjs=;
        b=jI5F8Ha7OubSPEAnGcUuaxD1WCEt+VBEYwK0xIzT8+V5quuNjD2AhEnlZyE+Q74+6L
         JCvuvipMV9KSFXUcRkAYczaCJCHQa/R0vT03Mxeoloie67XNP859c3Ru+90+pmYZyUNZ
         RM1m67xuJgiTJcy/aQwtUJTRM9RBh95f3YzSujYNPpRZTDzmjV1bsNI/bkRc7Ep9YyJL
         gxVgGGvhh5iXjLwl/3l01Hb2RSRuWyteIzJ+uSZNpgkWPJjUw8JNRpq1DHJCRn1Eikg9
         YZpEmB4qyy7DV2ta6ySPTmYsKgcJC6ijZ5xtm03baRBJdi6KT+AyUnCGzY/yDypLdl+g
         Tm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762270212; x=1762875012;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTXW29oVq2rOGcxMO1TiwqrUFdRpJ03gDLwEIoLlbjs=;
        b=BoOzj+xO8XJO4bPSKTi8Tv9RbQTpdvxF1HB+IOmUzBH3hvFrG2jpKfdw9rSirkJXix
         r6CaeQ2VTvPnq3TfrSEEwxQXsX9omoIspnOFpiENn05Ex8+G5la9/m2S7jeSgDbhkdL9
         Cph8emvAaAV/pIRL5SIgiwjlk692ot3wJrC22IguREicKB8/jwoxpWadr1cENlzJ9ZRP
         KfWKP+/ArD/veFq0qJ7m3xEP2keW8QkCCwGylaonQezOne977MhSaDbzS36+jFZB0BHZ
         A2uCuPY3c/kB1sUMPve3ZyvWyiNMbpyOQDH11TEoFs8HR2JMBoGEnwM14Icpkdu1Y/6f
         r6KQ==
X-Gm-Message-State: AOJu0YzwiajZxQkkDqk4f+iO25lI3AhQAJ211Z0h+Zd/ORAzzTLqLKbP
	+laDe2+AMZY54/68I+QGf9LP+A/Tgme+nVzhEcnqEWIjRzGBx/1oQH71
X-Gm-Gg: ASbGncs7xy/kmimvnfbBwULNKfwjEC9nbns2S7EHW/LEOdqUAwZS6dmDM4GKLMMwNbl
	DbQBkA6EYa0QQwQPCGzrUVXMOcANx6VdFDN5nCJcRsphcBx4LAWpaKsGebLeTQTSS43ySGTmDUG
	NlZqCdZ1yDFoAtQ+L60x1+HeBHiJltJiKpdUe4eBeN5l0hnqUywG6UO5NUFCCvMCpxdGvAysQW0
	8A83x5clO3hcCe/FKGWt3oLc9YoEiz863MUnKCR3UHRp7jS4UKn1pgqWngrRrMkaiqLoQ8wrsO3
	p37SlJP2M1Yg6+bSuVUUhCAtTJwuFy1wANNRixihGDYxrCfMgmsVmdfIGsRUZyC8ml5Oq69EoLu
	sfB0/cI5bxPPvPQmxfSMvp6zP4lp098AxUvTFRoxClBYEJ/zfjIt0c7S1SxyE
X-Google-Smtp-Source: AGHT+IFzkzlg5qvwZtEZT8fzkcd3hd2rUaO5hm9g8vonrayjqjoRk3tCk4y+jncoR7uk4ktuUR/GJw==
X-Received: by 2002:a05:600c:64c6:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-477308303acmr125167635e9.18.1762270211867;
        Tue, 04 Nov 2025 07:30:11 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:9cb5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558e695esm20876385e9.2.2025.11.04.07.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 07:30:11 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: add _impl suffix for kfuncs with implicit
 args
Date: Tue, 04 Nov 2025 15:29:53 +0000
Message-Id: <20251104-implv2-v2-0-6dbc35f39f28@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPEbCmkC/x2MywqAIBAAf0X2nGCLduhXokPaVgs9REOK8N+zj
 jMM80CkwBShFQ8EShz52AtgJcAtwz6T5LEwoEJT10pL3vyaUI6N05bQGIUNlNgHmvj6Rx1YP0F
 f5MLxPML9zXPOL9eeyYNsAAAA
X-Change-ID: 20251104-implv2-d6c4be255026
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270210; l=2336;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=57dj8uPvxQsBZBw1ICgfwNGGfh34CWNQ/xLOi/SZzTs=;
 b=ZJ+6RmST390Yzk2dSbpHU45HZO7/6bcmsYZCkp9Ow7B0Zv+qX/X840sctKYZ5GVonMI3Efj8I
 fOal9IVcmqBC7w2QhYElUiV2VzX5noC/v0hMAuO6Rpp4msRfoKjA0oQ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

We’re introducing support for implicit kfunc arguments and need to
rename new kfuncs to comply with the naming convention.
This new feature, will for each kfunc of the form:

`bpf_foo_impl(args..., aux__prog)`

generate a public BTF type:

`bpf_foo(args...)`

and the verifier will resolve calls to bpf_foo() to bpf_foo_impl(),
supplying a valid struct bpf_prog_aux via aux__prog.

Three kfuncs added in 6.18 don’t follow this *_impl convention and
therefore won’t participate in the new mechanism:
 * bpf_task_work_schedule_resume()
 * bpf_task_work_schedule_signal()
 * bpf_stream_vprintk()

Rename them to align with the implicit-arg flow:
bpf_task_work_schedule_resume() -> bpf_task_work_schedule_resume_impl()
bpf_task_work_schedule_signal() -> bpf_task_work_schedule_signal_impl()
bpf_stream_vprintk() -> bpf_stream_vprintk_impl()

The implicit-arg mechanism is not in tree yet, so callers must switch to
the *_impl names for now. Once the new mechanism lands, the plain
names (without _impl) will be reintroduced as BTF-visible entry points
and will resolve to the _impl versions automatically.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v1:
- Split commit into 2
- Rebase on the correct branch
- Link to v1: https://lore.kernel.org/all/20251103232319.122965-1-mykyta.yatsenko5@gmail.com/

---
Mykyta Yatsenko (2):
      bpf:add _impl suffix for bpf_task_work_schedule* kfuncs
      bpf:add _impl suffix for bpf_stream_vprintk() kfunc

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


