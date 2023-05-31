Return-Path: <bpf+bounces-1500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A71717D8F
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 13:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C22C1C208DB
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 11:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F14C2F2;
	Wed, 31 May 2023 11:04:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49440BE60
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:04:55 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E023A13D
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:04:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3094910b150so5761644f8f.0
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685531064; x=1688123064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NE3nsJLgCF5yLvfXFj33iNv6fC9dyYUMjyQeYIsPakc=;
        b=iaczqW4e4mFHRQwyzXvgZCmwp/HCL4Y7vPFNt9uavWbISjpEUVd9AAj5Puv4WCfvuE
         7Xpohh8TIly1luCcVXRVmM4tap982KYKJcsaqJnSzChG0wUg+IAIPtGH5MrZHs6VtNAe
         QXnBJOann52xvyMym80tS4k5yqqHQwkxODnNBSAZVbDtnah3BoBU8h6VdDFTaq/n7QyM
         erfK4TjHQpjjK1f3Z3OJX2VqCwA616HFyZn/KgfZIOs6VRU/KBSv+m6SS2tQMYpVsaPD
         CcjtZsad+sl+SQPMEVQILFv/qr8XOwgFXnq0ZZu7+RANZQ4diKdZhsgLWggKimZw8LsO
         Lsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531064; x=1688123064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NE3nsJLgCF5yLvfXFj33iNv6fC9dyYUMjyQeYIsPakc=;
        b=TA8tx/JRDyBwbw8I1oIiSuwTXpdFtayhQ9JOu8/O0ZedIjM2im2HV+dqIydtIzTo18
         QlceHTcc5T9D7l7OGDKkF8/yay9BVad8rjdLk0x3w0k7IZgZRcot6ELmPxbK/E7Kq71i
         hF7TltlzpI16aHQPwRv/sOYYjNm8M1DIZzgJ7KlYhf+sAQBTmQmh3s4vdpT7KWCgOHUS
         WRZ8qHY0C1U20Og84/RJKCGb5LQ+PBiPLsSGbN66LvAfCOIiFN3IegDE2x9vc7KDq2kA
         9u2Uce9XFEAZYClcls/75sqvbdq9xJRS07mhdKf1oloOCQSDpOG9l8U05jjg2P5Nkygo
         uBGQ==
X-Gm-Message-State: AC+VfDz6gGbIoipM1XZgp0FHwkwyoASzW/fjzs+70cs5Jlv/6nJIP8kv
	ddO0Ks11VyGGf8h/FPNqRcvYVB3/2u1pzguea6m5UQil
X-Google-Smtp-Source: ACHHUZ6UqK+MnK7olJeRlFl7LMpN9pKmezagJ1J/pmpmuTdhCcYBHaSwc7dxmbcFuNFJzPOmjjo/vw==
X-Received: by 2002:a5d:6684:0:b0:30a:9043:8f1d with SMTP id l4-20020a5d6684000000b0030a90438f1dmr3883442wru.5.1685531063888;
        Wed, 31 May 2023 04:04:23 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id b9-20020adfe309000000b003079986fd71sm6536029wrj.88.2023.05.31.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:04:23 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 0/2] add mechanism to report map pressure
Date: Wed, 31 May 2023 11:05:09 +0000
Message-Id: <20230531110511.64612-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series adds a mechanism to report "map pressure" (read as "the current
number of elements" for most maps) to userspace.

The primary reason for adding this functionality in our case (Cilium) is to get
signals about how full some heavy-used maps are and what the actual dynamic
profile of map capacity is. In the case of RCU maps this is impossible to get
this information anyhow else. See also [1].

The first patch in the series adds the api and implements the ops for all maps
in hashtab.c + for the lpm_trie.c (the maps which are of most interest for us).
See the commit description for additional details.

The second commit adds a new map selftest map_tests/map_pressure.c.

  [1] https://lpc.events/event/16/contributions/1368/

Anton Protopopov (2):
  bpf: add new map ops ->map_pressure
  selftests/bpf: test map pressure

 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |   2 +-
 kernel/bpf/hashtab.c                          | 118 ++++---
 kernel/bpf/lpm_trie.c                         |   8 +
 kernel/bpf/syscall.c                          |  15 +
 tools/include/uapi/linux/bpf.h                |   2 +-
 .../selftests/bpf/map_tests/map_pressure.c    | 307 ++++++++++++++++++
 7 files changed, 406 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_pressure.c

-- 
2.34.1


