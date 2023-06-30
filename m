Return-Path: <bpf+bounces-3760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BCC743700
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD58B280FE7
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7976E56B;
	Fri, 30 Jun 2023 08:24:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA6E55E
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:24:21 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1C6129
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313fb7f0f80so1801590f8f.2
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688113457; x=1690705457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbGQvR9Vtz7tsWKTPVK91YU2Blr3lMvTchLltgVmnWs=;
        b=aR6LHbmjUff7gljkFirEO3fCRO1/EufXxwyUAfYOWX41wEQ5/BoSxuprP+4edXlZuq
         BWVksyqgbKydbYhv/TgVZQWtIM4Io41THo76HVTWCOxt6BTjHWYmsHsILnukkGiCy5UJ
         dAaTZN7LsqWXYBFLbNwRis13BFxMKGfsiCWlP+OPBHbtln4fPOQFeeXX2Xe4e7JwGSwU
         UG4lS+hfzGqeP1S6T/sfqxY3WmQYQqU6HxJRVaBor7OCr0NAVsCdR63Eud2T2Nxe0u+A
         Ao36H3Mms12FylUAIzU2PxanleBqF1WP6x9U23GCusspPz+gJ1iqRJp0u5B4VOW4BBbl
         cvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113457; x=1690705457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbGQvR9Vtz7tsWKTPVK91YU2Blr3lMvTchLltgVmnWs=;
        b=QM0IlUx7UpO/IoYWSDtGTM5vMSMOZ3gfF3KKV2VVhtjLn7t53SalCG3RSfdekLiIe9
         eQkt566pdQgzl8lvCVY1jBGdKRmlSEN7x2ohFR9uhvJHwhapxdsjAiJTfl6f6khlgwfp
         6kbh3Zh+rQ9wQea/9VKtFGWMemxzWCayfLKQPiZ9W5KvnzYHsxD85MkpzbzGUm0j5qlE
         jjo32ZApLx0uhlGAwEBf3Gw2neJ9IDRtfweA0MTYMWdRZTnCa+T7nqYI5KsYSHgbU5kj
         chMy2txMUN83mTBiJwP2RUaWFtjqzsW2JaAqptKUnQ4bWjoYV1eX7JvM6HDuxZsc9zlW
         I5Rg==
X-Gm-Message-State: AC+VfDxXpGo50exBoOvplpWpYPVWY/3ljUN5NoyO0k3p1py20NKDNN+h
	YqoqirAAsiMLOqnHgusxD2KglQ==
X-Google-Smtp-Source: ACHHUZ4uxyQsT/BA5e0PH6RD49UPBkdiKxKit0qiLyzbRJiMf7iGotTuen+UuhH/H2W+40wYFjw8yQ==
X-Received: by 2002:a7b:ca48:0:b0:3f9:b7cc:723 with SMTP id m8-20020a7bca48000000b003f9b7cc0723mr1296067wml.21.1688113456638;
        Fri, 30 Jun 2023 01:24:16 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm18189941wmb.26.2023.06.30.01.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:24:16 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [v3 PATCH bpf-next 0/6] bpf: add percpu stats for bpf_map
Date: Fri, 30 Jun 2023 08:25:10 +0000
Message-Id: <20230630082516.16286-1-aspsk@isovalent.com>
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

This series adds a mechanism for maps to populate per-cpu counters on
insertions/deletions. The sum of these counters can be accessed by a new kfunc
from map iterator and tracing programs.

The following patches are present in the series:

  * Patch 1 adds a generic per-cpu counter to struct bpf_map
  * Patch 2 adds a new kfunc to access the sum of per-cpu counters
  * Patch 3 utilizes this mechanism for hash-based maps
  * Patch 4 extends the preloaded map iterator to dump the sum
  * Patch 5 adds a self-test for the change
  * Patch 6 patches map_ptr selftest to check that elem_count was initialized

The reason for adding this functionality in our case (Cilium) is to get signals
about how full some heavy-used maps are and what the actual dynamic profile of
map capacity is. In the case of LRU maps this is impossible to get this
information anyhow else. The original presentation can be found here [1].

  [1] https://lpc.events/event/16/contributions/1368/

v2 -> v3:
- split commits to better represent update logic
- remove filter from kfunc to allow all tracing programs
- extend selftests

v1 -> v2:
- make the counters generic part of struct bpf_map
- don't use map_info and /proc/self/fdinfo in favor of a kfunc

Anton Protopopov (6):
  bpf: add percpu stats for bpf_map elements insertions/deletions
  bpf: add a new kfunc to return current bpf_map elements count
  bpf: populate the per-cpu insertions/deletions counters for hashmaps
  bpf: make preloaded map iterators to display map elements count
  selftests/bpf: test map percpu stats
  selftests/bpf: check that ->elem_count is non-zero for the hash map

 include/linux/bpf.h                           |  30 +
 kernel/bpf/hashtab.c                          |  23 +-
 kernel/bpf/map_iter.c                         |  39 +-
 kernel/bpf/preload/iterators/iterators.bpf.c  |   9 +-
 .../iterators/iterators.lskel-little-endian.h | 526 +++++++++---------
 .../bpf/map_tests/map_percpu_stats.c          | 336 +++++++++++
 .../selftests/bpf/progs/map_percpu_stats.c    |  24 +
 .../selftests/bpf/progs/map_ptr_kern.c        |   3 +
 8 files changed, 726 insertions(+), 264 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_percpu_stats.c

-- 
2.34.1


