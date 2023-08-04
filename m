Return-Path: <bpf+bounces-6981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E254976FF13
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE2B282462
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3379AD41;
	Fri,  4 Aug 2023 10:57:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9158F7D
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 10:57:49 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C316D4ED3
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 03:57:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-687087d8ddaso1778974b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691146656; x=1691751456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UL8MkoXOfwG26pirKO6m6C8z2icQry1K095zSCO6FKs=;
        b=ri/qUIqxx4il9j6Bq3aLbJ/bAevWRMjh4Yb6+3GemjJ0dlMjlcCPqwgSi6o3E4Qc1E
         4KnSypxrLZ0plSvQC8fJwxdIGKvZH5Ld6hLFHOob+vas6cPGl5B5Vzsc0M+9tzwF1JaR
         Z0vJSvyBWwsbBV9xOyrB+1Ig7JSu2cscFyeq2PZWEpesLk/0z1NS0RPa1jFtu0QD8MKD
         Cu8w6CnHpGdi8RYc+YhMxrzm/K9oeMe2NOaH2RX+XONjQUYmVATDWTp4O5yVxnBL3OEr
         tigJJWnqP/sntQ7I4dRhtPjLi3yYRRwoofrI+kt9TX4kiBgDd75iJha81jaz8zmtqx/A
         /uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691146656; x=1691751456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL8MkoXOfwG26pirKO6m6C8z2icQry1K095zSCO6FKs=;
        b=AE+ahdl6nyB9cs/5wghxN3WYRFyPzxGLHMb8+QUJ+iJue+igZ89ZTnJxSsCFiKJtQL
         PB+L6cOhNiDOmz4Pa2iKnpvDsJ6Wvf6Bk92BYHgp0QOC6x8x5gNA9OtkColgePNsC6Iz
         em0TGQrel84UhEP5Aai9qMRc5QVv+pxnArUNq8fgZHEQEqeIK9esGWshMtlI47nd3pBm
         geu0I7Ri/9qPN7MlcMqGL/nxyLUwqFh5ui/zGD8uyrMqgXVEXJqi4H84B5fp13UuaujZ
         +CgJa7QAo+rwj43x4sTgjTZlQmfIc7I2xJqKnehtQ9eTQnQYNnas2gKYos82uADZbnB2
         UG7w==
X-Gm-Message-State: AOJu0Yxn7N5DV7qDe6R5YzUxGEDae5Tey9tlvlniLOBQpztIYAkvnujD
	7A9cqR0w0625NRkSYr5O4gg=
X-Google-Smtp-Source: AGHT+IF4ND8rX9Ja238O5GNoF6iKEQJjN4LyxR+uZWL9HK4ZDHo00tLK4QX//YeJGvmeGPhWydSzqA==
X-Received: by 2002:a05:6a21:3285:b0:133:71e4:c172 with SMTP id yt5-20020a056a21328500b0013371e4c172mr1875686pzb.15.1691146656146;
        Fri, 04 Aug 2023 03:57:36 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:c27:5400:4ff:fe87:9943])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001b850c9d7b3sm1457691pls.249.2023.08.04.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:57:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 0/2] bpf: Fix fill_link_info and add selftest 
Date: Fri,  4 Aug 2023 10:57:30 +0000
Message-Id: <20230804105732.3768-1-laoar.shao@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch #1: Fix an error in fill_link_info reported by Dan
Patch #2: Add selftest for #1

v3->v4:
  - Comments from Yonghong
    - re-word the kptr comment
    - Avoid unnecessary switch statement 
    - No need to check the return value of bpf_link__fd()
    - offset is always 0
    - Return directly when test_fill_link_info__open_and_load() fails
    - Cleanup skel when load_kallsyms_refresh() fails

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
 .../selftests/bpf/prog_tests/fill_link_info.c      | 337 +++++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
 4 files changed, 384 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c

-- 
1.8.3.1


