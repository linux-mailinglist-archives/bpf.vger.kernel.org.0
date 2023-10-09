Return-Path: <bpf+bounces-11775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB217BF092
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 04:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D441C20AAF
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 02:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4AA5C;
	Tue, 10 Oct 2023 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVRjKNZ4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB97F0
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 02:02:15 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6CD9D;
	Mon,  9 Oct 2023 19:02:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fb85afef4so3812885b3a.1;
        Mon, 09 Oct 2023 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696903333; x=1697508133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G34afWHNOwhQkHaOWVEojteMJQhFNbq7vLyYhiQh4xE=;
        b=CVRjKNZ40Z1DY4uH95SaiNsZoKX/R7BIDfW9kEISjVMC7i5Rx9FlDRtGpKV3NafkGx
         yzxAQmOxsSb7D0qX1v59bVX9+AUSUiCC7UnNvU/cfcEVzb1nioFU8ZHmlGrLgZD0EG5q
         D6zhZv0z5LUi6Bs02FYpMx+D5LHBCMFj6FKg5LNMpa89CclCokgsBsNOTzPx3mKr0Qtm
         EYJWN/M+r3Laep660XFvtP1y40j7jCvvuHwvbUrEK4JZMlgMd25BdG/pRUU4g7gIokPc
         HnlRSmqTupCyJGoCwcd0RvkEbTPNcKS+xEoMf+fyOG8CJO26jRxPYpZt8cE4z8g7rQDK
         NNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696903333; x=1697508133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G34afWHNOwhQkHaOWVEojteMJQhFNbq7vLyYhiQh4xE=;
        b=pQOnD4GBU3zeY9uJSzB+XxKsw8XKMqyA7UD5Cvne6XplecE4anhMNDC4agifwNxrmd
         Xvjcr3eZtddB1t1cT5NvOaPHC8spMyva6TBpG0o5HhlrGWxANCJh2dzPXWkdyjubkOuK
         50e/Yz693RwfuyC4xWaS5kYvE8W3088Lp7dIzM7BJ6AgXG9MSdRj1OqFE78AA1EK+H8W
         TnEwKmv0n33MY4k5qnSr8NhCAzZIrWkviRG2THvJoWxGADVlG+TTB9OU8f33GZJywuu4
         uKcz0WoFrrj8Q02rb0s1E7yAaF21+rZmH3AKyXuYpEDJoEXjAJZxPmzdaZ909iki81QB
         pafg==
X-Gm-Message-State: AOJu0YxR6OyXIAplm0MHEz82aKa4O8aM1PHhy6om7ZHAl6tx+uHqlGYS
	VI+kf9EI/bfDr+oEd18fFCt9p3xowWR+2g==
X-Google-Smtp-Source: AGHT+IHQ63R4vmkaKHN8hY5E++QdJbKIu4rVp3I2BIS4RZOL58qUJtWAmwmfm3qxyIoB/Qg6DlW3GA==
X-Received: by 2002:a05:6a00:1410:b0:693:3c11:4293 with SMTP id l16-20020a056a00141000b006933c114293mr15147453pfu.14.1696903333272;
        Mon, 09 Oct 2023 19:02:13 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.112])
        by smtp.googlemail.com with ESMTPSA id t28-20020aa7939c000000b0068a46cd4120sm7044809pfe.199.2023.10.09.19.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 19:02:12 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [PATCH 0/4] seccomp: Make seccomp filter reusable
Date: Mon,  9 Oct 2023 12:40:42 +0000
Message-Id: <20231009124046.74710-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset introduces two new operations which essentially
splits the SECCOMP_SET_MODE_FILTER process into two steps:
SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER.

The SECCOMP_LOAD_FILTER loads the filter and returns a fd
which can be pinned to bpffs. This extends the lifetime of the
filter and thus can be reused by different processes.
With this new operation, we can eliminate a hot path of JITing
BPF program (the filter) where we apply the same seccomp filter
to thousands of micro VMs on a bare metal instance.

The SECCOMP_ATTACH_FILTER is used to attach a loaded filter.
The filter is represented by a fd which is either returned
from SECCOMP_LOAD_FILTER or obtained from bpffs using bpf syscall.

Changes from RFC ([0]):
  - Addressed comments from Kees
  - Reuse filter copy/create code (patch 1)
  - Add a selftest (patch 4)

  [0]: https://lore.kernel.org/all/20231003083836.100706-1-hengqi.chen@gmail.com/

Hengqi Chen (4):
  seccomp: Refactor filter copy/create for reuse
  seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
  seccomp: Introduce SECCOMP_ATTACH_FILTER operation
  selftests/seccomp: Test SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER

 include/uapi/linux/bpf.h                      |   1 +
 include/uapi/linux/seccomp.h                  |   2 +
 kernel/seccomp.c                              | 184 +++++++++++++++---
 tools/testing/selftests/seccomp/seccomp_bpf.c |  20 ++
 4 files changed, 180 insertions(+), 27 deletions(-)

-- 
2.34.1


