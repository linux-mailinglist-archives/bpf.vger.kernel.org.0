Return-Path: <bpf+bounces-12944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64EA7D2399
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 17:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CE2281596
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718A107AC;
	Sun, 22 Oct 2023 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G8WkM0iY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122FE33D7
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 15:45:42 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E47A7
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 08:45:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9a1762b43so20188915ad.1
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697989538; x=1698594338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8nUSkrqP1LIry5a+Vy86unFLe045AhC2A2H9e3CWTY=;
        b=G8WkM0iYyUz4A+xgnVAPkFeIW5nGwIPQKAnmAjBw6V6yutEDoUi0nOfA8MzN4zu+Wd
         615IWWgpK8cZOAOySQISXzMmPSTnzlBT9kVIAYYBRaxceT2BSefFKxs+9/At2xfN4ImY
         eKjLkr+t5mB5wRfC/OWQCwHZZiNJXTaMdziSAQ3Kj7UuHdS0q8zKCbP/ity4uMnJmIsJ
         3qx1YKKA2rNkWFPiU0p0eIRsQdufnrFBOdtlnCfi7Y23PIl+8q5zbPGw6J46WLNmA86k
         FDBtbADj+Py/d68puev/vbVa8FQksgP4TdgiVE1cA5ILFY85yQ/TWTgnSBNVXGvZC34r
         i51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697989538; x=1698594338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8nUSkrqP1LIry5a+Vy86unFLe045AhC2A2H9e3CWTY=;
        b=qMLcevqo9xg1pHwtnbVAVCd9HXpN92WOqbgx7NySVvYM0NoAdraxh9yf7+FLtTYCtY
         4hZb4UTp7UuR5kFyQM6MLyanu36PVlbd/4mewmkqzlnAlp26fjDmTK6oiiaWr3/1dEwr
         rMGMQkjF73RsMy1QSscSlhYqA/Yl38/IYQ8NaErrcaZUuU5BbX+mmFHDDdBZHZaZTTRO
         8KzEp3ltrtmUcRGr9Jzn7u5LPfVUkKBqa4g+QARvfOzNL/B0L+A3BULX3f/+vhZnDIJF
         rZCWOPJHOymdfoqvCuUd9S5HS/WNynvbQAA/6phVH5VsoS3AbVu8x3nha+JobCT8sU7Y
         DaTw==
X-Gm-Message-State: AOJu0YwQGe/KdjwOKoOXc59QA6xU4Mxbq9pk5cgs3xNrKYTVEh+TPUEg
	jZ0tNt85+2w8NveS7l7g7tZT2UZmL99SxI5rJsDEiQ==
X-Google-Smtp-Source: AGHT+IGdS2sMioBYj3fLI0k16tMn7gnOe0bCjofVOm+8Vo29PFPR57g2Ntavy8LDDjMGRpyfL0VrFw==
X-Received: by 2002:a17:902:e5c5:b0:1c1:ecff:a637 with SMTP id u5-20020a170902e5c500b001c1ecffa637mr6272338plf.15.1697989538362;
        Sun, 22 Oct 2023 08:45:38 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.49.4])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bbdd44bbb6sm4551996plk.136.2023.10.22.08.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 08:45:38 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next 0/2] Relax allowlist for open-coded css_task iter
Date: Sun, 22 Oct 2023 23:45:25 +0800
Message-Id: <20231022154527.229117-1-zhouchuyi@bytedance.com>
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

Chuyi Zhou (2):
  bpf: Relax allowlist for css_task iter
  selftests/bpf: Add test for css_task iter combining with cgroup iter

 kernel/bpf/verifier.c                         | 15 ++++---
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 33 +++++++++++++++
 .../selftests/bpf/progs/iters_css_task.c      | 41 +++++++++++++++++++
 .../selftests/bpf/progs/iters_task_failure.c  |  4 +-
 4 files changed, 86 insertions(+), 7 deletions(-)

-- 
2.20.1


