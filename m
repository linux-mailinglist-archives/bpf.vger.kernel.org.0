Return-Path: <bpf+bounces-5111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A591A7568D3
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8361C20A3F
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A8BA55;
	Mon, 17 Jul 2023 16:15:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599A253CA
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:15:41 +0000 (UTC)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8CBE76
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:15:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1b89114266dso37836125ad.0
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610537; x=1692202537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rBie/18DPqQopyZ3VTCPAJOrW0CvTtwHJ5meoXJrtX8=;
        b=QhjUBV4B2bHxnBWAOihyzkPHcW5KuS06/CwKUhV6ir572z/Lkw9udUst6zkfUQMQgV
         vCmCotZoAwKD+ztQ+8TkU3WGV8zJWX/TqSkaVthT2evYJXhdSxPTg5qG1+QKaZUt9ueY
         edPX4j11LbllNEcr6ZQwtjplm06n7mFmccmA15Z8DO1QNMWG3NCUB7Nc/13xEhwgYCG/
         K5e0f9DWskc4RqVIQmAZi4RW3OsS+jDnwNZP/KV5wgz2lylf3vdsBHlwUVX92voLPmo4
         CA7C88DVLu4YMJ1hP8q/UkOa0YjLNDtvUP9mC1fomVxawJL/5bpvPZPpv1vM8+4J6Xls
         m36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610537; x=1692202537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBie/18DPqQopyZ3VTCPAJOrW0CvTtwHJ5meoXJrtX8=;
        b=LBaMkqkwjDZ9vDwUJOltmePwuGjI7+u6U9qQ5NMBo5zw93aPH0Cao5VGMA+txJ1l9w
         lwh/k5hL5405HcNkaI7td4h+zwplf+lD5XivE+jMbaRWtkHCDv6GQvH3YvkhjjkkGl9W
         lERKpApW4J9wseCtlTNAXLZ5xqySY/8MXYB7yJuJwGWV5D09lPu+4taRyDOpG51UWVLW
         uUTbuXvfcN16lkuNPbnWRzc4wonUy+P3y6PlUi5UeIACNRZTvjr88u0cu3r74kzrmkxL
         DEr62sevXflybO+8SEko9svRq9J5XDxl9MXqrk1fytQ00nWxPxLJ9QMBWspMgpNqP6RO
         VuRQ==
X-Gm-Message-State: ABy/qLaIhd4/Yw2wQpOpNYBirVpW5xZmtVJrAle+yScj+ICy9hob26Hk
	CHO1Kn7U0Ie182biDXLJBT4zE49avQvFAA==
X-Google-Smtp-Source: APBJJlHfRhGqe13W8nt+tMusaDID8/rYlh2ZMojxXI2BiT7lDplAbSV/iKvW3oOu+AZEWg+ZycTKJw==
X-Received: by 2002:a17:902:ecc4:b0:1b9:d439:c009 with SMTP id a4-20020a170902ecc400b001b9d439c009mr15959459plh.57.1689610536854;
        Mon, 17 Jul 2023 09:15:36 -0700 (PDT)
Received: from localhost ([49.36.211.25])
        by smtp.gmail.com with ESMTPSA id u21-20020a170902a61500b001b80ed7b66fsm94600plq.94.2023.07.17.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:15:36 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v2 0/3] Two more fixes for check_max_stack_depth
Date: Mon, 17 Jul 2023 21:45:27 +0530
Message-Id: <20230717161530.1238-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=memxor@gmail.com; h=from:subject; bh=ygTuAMkRt6WU0WK006iLmd6dfKpm1ZWjbsNqzfbj32w=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBktWjfRvvnxv3ZL+/2wfCG0E3g7voOES/0YRRUO OGkGsB4hs2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZLVo3wAKCRBM4MiGSL8R ynO8D/4glVxMlOy4RVmC7qyTqvUxrnsWjrQWVOAhrB1vu1JlFT8v4bKGhW32sZqleqeaKJGhrq1 1pLWQlYMFH/X8EDLeNFbgT10lrSGm7xckBGi4zA5U0mH1Tt9zS5mFd8444p46ckM+a+DFgVCB6+ Afrm7qS7h0P5PW/5jR71SaeJ+bYeQvTKpNROS8iveV+TZKOltSUR0GOaDxZ9iI9GIo3zlggOL79 cnNJzsoyoRNBzy9VTPA/o6Zcatfcs1F1yGQeSPVn0LBHMXfwyTyZS5K88XdM/0u6YBaRrF+AijX Wu2TuLRy+BDQZgHw9Sm6jVSre3/fqautFFP44NpuVKLoGE/Aw/Y81H1S/dPW+M3G6aK2gg68NZw oRihSZu1mmbbxvrJhgTUus6tRVdml9L+s3yE9vPxywYy3OraOY0w6RpKYbY8LnpefXxwpaVNjwS jV4pU8HP6NbD+ExOTJdwK45BMOAhewkROBHPpkRWfdwAs3T9+U8ZkfHXfBYsnG/wUtdh1igScPy 7HQqvfA5BjYcnvLsyAd2exQ8cCFdg28OLI3j3/rZhOhU4yF+0kn0G41pzsEU2SgB67RzbBmMCf3 CksUNHNX1zbCO629uYiz5eWZLyLQQjrbA5cMw2wJ5mrNcQdQPa7I/LEOA/YTgwp8/YSHb5Iy3Sc g2joJ/9SATB0i0g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I noticed two more bugs while reviewing the code, description and
examples available in the patches.

One leads to incorrect subprog index to be stored in the frame stack
maintained by the function (leading to incorrect tail_call_reachable
marks, among other things).

The other problem is missing exploration pass of other async callbacks
when they are not called from the main prog. Call chains rooted at them
can thus bypass the stack limits (32 call frames * max permitted stack
depth per function).

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20230713003118.1327943-1-memxor@gmail.com

 * Fix commit message for patch 2 (Alexei)

Kumar Kartikeya Dwivedi (3):
  bpf: Fix subprog idx logic in check_max_stack_depth
  bpf: Repeat check_max_stack_depth for async callbacks
  selftests/bpf: Add more tests for check_max_stack_depth bug

 kernel/bpf/verifier.c                         | 32 +++++++++++++++----
 .../selftests/bpf/progs/async_stack_depth.c   | 25 +++++++++++++--
 2 files changed, 48 insertions(+), 9 deletions(-)


base-commit: 9840036786d90cea11a90d1f30b6dc003b34ee67
-- 
2.40.1


