Return-Path: <bpf+bounces-11385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434D17B84E9
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 18:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 91D5E2818A6
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AEA1BDF2;
	Wed,  4 Oct 2023 16:23:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814411BDE8
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 16:23:45 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12011D9;
	Wed,  4 Oct 2023 09:23:43 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-69335ddbe16so1822437b3a.1;
        Wed, 04 Oct 2023 09:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436622; x=1697041422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJcPkTtQzYDODeSqUGSI+V2+1I2wYR9LJJZ2Ou20RpU=;
        b=Yql+nLSENlm/lWLdzws6WHhZuQpxVEW4TgpUMUr9vqTKksCdEwJmu/w167Mzk4+Sk9
         B4PkTPQokMkcQxQ0v6YlBq44gHkJQCXXHBCPQQuD34OYEfWle8pj9pI0iLrZ5iZYnyVi
         yfdaq361tlyZbn2BrMNxv4OBCFcsNOeItr0IxLNQ8LrelGF4pCHgFnyAJS0Hy/wtrsQv
         AmGyEYV6baPbinkIOEXg877v3m5GTYaWSkfaILR9SwccG7iBZlaJP/Ifv2g6v15MzOTU
         xqMDGBssOqz4LRNgVIXwYBLpvTglJDOzDGhopArlFOAKzyVXsK0qxG+BJYdP+RUVPowX
         DYmg==
X-Gm-Message-State: AOJu0YyI7R9rv8B+iOVbkt+9b8YNrnOzhpYeWMcyAJXs0vWIOpJUR6Wl
	0AGrnDAHWsCueDo2IMcKn1qZ2CztkblBWUgO
X-Google-Smtp-Source: AGHT+IHN6A4x8SqQzX7CSj3PL8J6IU6X9kV/9cDldk3rUEsSnoIxN7KMM6PZQxewOYcJT+M6l1CyOg==
X-Received: by 2002:a05:6a21:328b:b0:15e:986:d92b with SMTP id yt11-20020a056a21328b00b0015e0986d92bmr3134825pzb.16.1696436622065;
        Wed, 04 Oct 2023 09:23:42 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:3ce7])
        by smtp.gmail.com with ESMTPSA id a24-20020aa780d8000000b0068fcb70ccafsm3387438pfn.129.2023.10.04.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:23:41 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] bpf: Add ability to pin bpf timer to calling CPU
Date: Wed,  4 Oct 2023 11:23:37 -0500
Message-ID: <20231004162339.200702-1-void@manifault.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BPF supports creating high resolution timers using bpf_timer_* helper
functions. Currently, only the BPF_F_TIMER_ABS flag is supported, which
specifies that the timeout should be interpreted as absolute time. It
would also be useful to be able to pin that timer to a core. For
example, if you wanted to make a subset of cores run without timer
interrupts, and only have the timer be invoked on a single core.

This patch set adds support for this with a new BPF_F_TIMER_CPU_PIN
flag.  When specified, the HRTIMER_MODE_PINNED flag is passed to
hrtimer_start().

This patch set is based off of commit 93fb2776f43e ("Merge branch
'bpf-xsk-sh-umem'").

---

v1: https://lore.kernel.org/bpf/20231002234708.331192-1-void@manifault.com/

v1 -> v2 changes:
- Put declaration of soft_timer_pinned and abs_timer_pinned selftest
  maps on same line as abs_timer (Song)

David Vernet (2):
  bpf: Add ability to pin bpf timer to calling CPU
  bpf/selftests: Test pinning bpf timer to a core

 include/uapi/linux/bpf.h                      |  4 ++
 kernel/bpf/helpers.c                          |  5 +-
 tools/include/uapi/linux/bpf.h                |  4 ++
 .../testing/selftests/bpf/prog_tests/timer.c  |  4 ++
 tools/testing/selftests/bpf/progs/timer.c     | 63 ++++++++++++++++++-
 5 files changed, 78 insertions(+), 2 deletions(-)

-- 
2.41.0


