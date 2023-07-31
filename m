Return-Path: <bpf+bounces-6429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A84769452
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 13:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B73E2815A9
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A31718000;
	Mon, 31 Jul 2023 11:13:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083511C94
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 11:13:18 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D89E53
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 04:13:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b2886364so25900595ad.0
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690801997; x=1691406797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3PBzF2jzIeuXB/EdcYWC0KR5W7g5DI5oF8jTIskfJh0=;
        b=TFrTFQ2fsu/7c7CzdFqmlpLgnaEP43Mew2sdZOBdyUBiRFqPGOYVX7gxsudzWBp5Nw
         UMWMUur90kHLEg4EMLpGbXZ2kr/J1nLQlubmhpivv93Xk1CqL5mWlnDGeWzrZJbASnaz
         GfVbgh/QK1KJKkNKPpEq+jW1LqDk/JNq+aHz6783qt3Q+s3SUNwf5ieEH8/xXbyIkk+8
         VIb0DW8FJLrDPavZMXLfODkHDESk7IH+uFasABxhguD48INtor5Ld50cIvfftiQkaSkh
         8qrSIS4s0zUEAHwwuPEngMk4fiC6hvmKxf6i6jJOf1ZNJK2uMsl6N68mF0ax9ze43lRJ
         uM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690801997; x=1691406797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PBzF2jzIeuXB/EdcYWC0KR5W7g5DI5oF8jTIskfJh0=;
        b=bO7LJt5qRECTif2sv6ccFZzhTdJwFm8jlyWDsMH2BUsHfs1wFe8DtQt9AqBiUvEOCM
         ycwCCZAGkRB7BEZ8nuI/4gHnbNxs+nCjSJbhIpRZy0ryYV1vBoFTFZzx1vIpm678Bdvz
         lBWkkyPPsvIBIPu/MNL7OHiQD3jJM5gorSyjLOQmJzE1x2X3d2/6YefO4d1lKzRNeMgY
         lkehX7sJiRtT5DkQvii2fUdpkw/eKRm7f8iZXBPsISIewfXG/A/fX5QiBRKsIg1Auakt
         KAj6i6KUy0Gbs1dpNaXVxsRHmzqIeagDbYosRp2yYJejXjVOAAl0H9oAK5qKf3WUtcvk
         G/mg==
X-Gm-Message-State: ABy/qLYC1Db/Em47bp+K/yF8d6TIyPMs31zZ3vhxPUOY/tgzFz+udbqr
	MsYCef1DzQ2th8NnTKYxy/c=
X-Google-Smtp-Source: APBJJlE22IfkUfanDnyWKucVSmImQf8yPTUSi7w0nUwe8fQxUhp/wc9kXsnOcs4TP7Q5NfBAluM0LQ==
X-Received: by 2002:a17:902:ce8f:b0:1bb:c87d:756d with SMTP id f15-20020a170902ce8f00b001bbc87d756dmr9889879plg.42.1690801997127;
        Mon, 31 Jul 2023 04:13:17 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:e1:5400:4ff:fe86:7b43])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b001b8422f1000sm8293862plh.201.2023.07.31.04.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:13:15 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 0/2] bpf: Fix fill_link_info and add selftest 
Date: Mon, 31 Jul 2023 11:13:11 +0000
Message-Id: <20230731111313.3745-1-laoar.shao@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch #1: Fix an error in fill_link_info reported by Dan
Patch #2: Add selftest for #1

v2->v3:
  - Comments from Jiri
    - Verify wrong arguments as soon as possible
    - Use CONFIG_X86_KERNEL_IBT
    - No need to make the test serial
    - Add test case for kprobe_multi

v1->v2:
  - Fix BPF CI failure due to the enabled ENDBDR

Yafang Shao (2):
  bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
  selftests/bpf: Add selftest for fill_link_info

 kernel/bpf/syscall.c                               |   4 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
 .../selftests/bpf/prog_tests/fill_link_info.c      | 369 +++++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
 4 files changed, 416 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c

-- 
1.8.3.1


