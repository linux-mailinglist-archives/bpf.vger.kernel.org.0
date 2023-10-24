Return-Path: <bpf+bounces-13093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C8B7D45A7
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 04:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48FB1C20AD8
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0C91C35;
	Tue, 24 Oct 2023 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M6nXuk7d"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA41396
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 02:42:59 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640B98
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 19:42:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ca74e77aecso36638995ad.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 19:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698115374; x=1698720174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GX+BG8UKoAAbJOw+QfuTWpFqhJG+iqzRLAl5XHOzgZc=;
        b=M6nXuk7dHsiaOys1adbjp+A2gDdsAQyU7jLyRZWwNDnQ/q3Rz2hKWwOaj04o5WElJ2
         c5le9N98qUBQWohkdoQae0FC7JMspMPfN3yJk+JGiLtovXorUPu8jAYgG434kxJTV0bA
         Ifuo0e3VLJpQvoldz4op9ghqkTXMC4c06mim4u0AtlamW3NR4kwnSFGlfPRaiY/ME5VW
         C70mIqIqBi+teXROmMaeVKcrA4CvYG95HnIm7aQvqdKU3MwptAqPS5yRuJshNvUQZ8j+
         bor/69lHAsYvdXH+ocxMvVmmTI4qHcKeOu0IlT4wF6wKhM3nzBC8vAVWd+/ceGfd/Cme
         RCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698115374; x=1698720174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GX+BG8UKoAAbJOw+QfuTWpFqhJG+iqzRLAl5XHOzgZc=;
        b=WWnk0dbgO5aSbPN+R12xI2E9nQ9bDUGd+raPYaumW2htmfA269/tWK5epYIM3rkzb0
         zpLyntO7LjtK2gO+xrwSmPskP/1FqlIAivtfILDUKceTFKzfRcU5LnKt7BpU0MkNNeVw
         uMGbLMGkHiAqBn35CbWbDPR4rEkvewa6tl3bkddFmxh28ZNhjsGjerj4+kNxIJdNl5GH
         jIAQvJViWPhkjFdm9vwD2sZHkWz59hvC0aKny6ohDR2vgTbn+jlK44L87dmCGRK6htIL
         /VbvqrxT+uPSZo+J0ZXDqoHuXUhkZJ8/W1dSMiukf8JsJ1bj6np0V1y4ILBdxhwokRWY
         bpgg==
X-Gm-Message-State: AOJu0YyNorFyq4Y34tBWA91deMYqdEIdReCtx+XRHqKr7YnN9SxWPRNh
	hM63y5dE3++0BJ/pb8Ke5rB0nI5fsKCBRuGECqA=
X-Google-Smtp-Source: AGHT+IHp8TZ1Paw0F0vVoAiGmL5kbd225QIpG6NlDRp/MX4XgTyYxIrsqilWAoe6PT1QZ0nfTzZweA==
X-Received: by 2002:a17:902:ce88:b0:1bc:1e17:6d70 with SMTP id f8-20020a170902ce8800b001bc1e176d70mr14902128plg.24.1698115374543;
        Mon, 23 Oct 2023 19:42:54 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.70])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903244f00b001c62b9a51a4sm6619539pls.239.2023.10.23.19.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:42:54 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 0/2] Relax allowlist for open-coded css_task iter
Date: Tue, 24 Oct 2023 10:42:38 +0800
Message-Id: <20231024024240.42790-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The patchset aims to relax the allowlist for open-coded css_task iter
suggested by Alexei[1].

Please see individual patches for more details. And comments are always
welcome.

Patch summary:
 * Patch #1: Relax the allowlist and let css_task iter can be used in
   bpf iters and any sleepable progs.
 * Patch #2: Add a test in cgroup_iters.c which demonstrates how
   css_task iters can be combined with cgroup iter.

link[1]:https://lore.kernel.org/lkml/CAADnVQKafk_junRyE=-FVAik4hjTRDtThymYGEL8hGTuYoOGpA@mail.gmail.com/

---

Changes in v2:
 * Fix the incorrect logic in check_css_task_iter_allowlist. Use
   expected_attach_type to check whether we are using bpf_iters.
 * Link to v1:https://lore.kernel.org/bpf/20231022154527.229117-1-zhouchuyi@bytedance.com/T/#m946f9cde86b44a13265d9a44c5738a711eb578fd

---

Chuyi Zhou (2):
  bpf: Relax allowlist for css_task iter
  selftests/bpf: Add test for css_task iter combining with cgroup iter

 kernel/bpf/verifier.c                         | 21 ++++++----
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 33 +++++++++++++++
 .../selftests/bpf/progs/iters_css_task.c      | 41 +++++++++++++++++++
 .../selftests/bpf/progs/iters_task_failure.c  |  4 +-
 4 files changed, 89 insertions(+), 10 deletions(-)

-- 
2.20.1


