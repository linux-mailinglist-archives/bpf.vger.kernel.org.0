Return-Path: <bpf+bounces-6067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBA07652BC
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7121C2161A
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97815AFD;
	Thu, 27 Jul 2023 11:43:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66D156C8
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 11:43:16 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142011FDA
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 04:43:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8c81e36c0so5193035ad.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690458195; x=1691062995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KK4VZ9ruNwgHm88OPBjIEJh/h6mfrVuJ+BqfAsbCmMU=;
        b=EWyoZx6fEEshrCgJzhTs8LnM0Ewrgd3z9gxptICXxzhmYxOBd73QCGSwG4RUK/hZEo
         9Pas93BFIMcP9FpDi3LkJwHqJ5Z851+EFH2yk4IOvXRWcTEesCtqb4MZ7WMotzaNDz4F
         hTeSDcY+7JopzS28aZaxi3pBnvF9iZonjIjjMwjH1GgAWNJhGjWSiqC8tpRBs5GkJPQR
         ocNfJbvVGHVHpppzUOiU9beyqIokZpRjQka8X+BF73c5RiI4ruVH0xGpmHjkgEbD19cJ
         zkjiy9wVye7DL5dx9olOR5RFTqOke/qnRAukhzKcRFknJkmUYk14iNuLoF4jxbEtLDjS
         u6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458195; x=1691062995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK4VZ9ruNwgHm88OPBjIEJh/h6mfrVuJ+BqfAsbCmMU=;
        b=ipNiBvzpQmhfhp66Fp7swp7sgpB9krQ7bsS4Ho4bFCLItQEdFyNnt1Ml/ILcImmInc
         b2D/gOQX6Lzq4DIuiIZRcUowzaIscheZ/3dQJeN4tOEpn8YcuMeonLOExfGwxUbP5OLu
         etiDclsdRsbe4FBKKKhpmevQUADRz4KtcuWKyBR6pNX7FuXyXyootsaYfR2LSOBgeC4H
         jku9bXkbZxWvQ8P9KQugKjhGiQYuW0XrfroPKIIjg9VGNtJPzjA2pb4NoMKDoIzgB3H2
         CPAQschruKy0tlUQHzyUhzmEzgezN4ixJMn5+KAq/XKSg5atU9bq6YAUu/yT8o6ac3fo
         oQHw==
X-Gm-Message-State: ABy/qLbTC9K7Thd0DzaKmc0Q1mhQ4M5hJRLGfDp7ZgCvA3g+6BRUBgoQ
	DoFtbraNCgd7WpbnMi7a2YY=
X-Google-Smtp-Source: APBJJlFnXQdhPmkJQlBfqHjPLZUpcrGcjMKb2isSVPfHFPhowQ08O9bLQocU4Eqg9nM0gy2J/o+oqA==
X-Received: by 2002:a17:902:ec8f:b0:1b8:b436:c006 with SMTP id x15-20020a170902ec8f00b001b8b436c006mr4483645plg.12.1690458195478;
        Thu, 27 Jul 2023 04:43:15 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1e6:5400:4ff:fe85:7796])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b001b6a27dff99sm1419106plg.159.2023.07.27.04.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:43:15 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 0/2] bpf: Fix fill_link_info and add selftest 
Date: Thu, 27 Jul 2023 11:43:07 +0000
Message-Id: <20230727114309.3739-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch #1: Fix an error in fill_link_info reported by Dan
Patch #2: Add selftest for #1

Yafang Shao (2):
  bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
  selftests/bpf: Add selftest for fill_link_info

v1->v2:
  - Fix BPF CI failure due to the enabled ENDBDR

 kernel/bpf/syscall.c                               |  10 +-
 .../selftests/bpf/prog_tests/fill_link_info.c      | 238 +++++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c      |  25 +++
 tools/testing/selftests/bpf/test_progs.h           |  19 ++
 4 files changed, 287 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c

-- 
1.8.3.1


