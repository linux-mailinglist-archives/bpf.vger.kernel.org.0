Return-Path: <bpf+bounces-7431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8373A77728F
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 10:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47CD1C21154
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83E1ADFB;
	Thu, 10 Aug 2023 08:13:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296D1ADE8
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 08:13:29 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6912106
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:27 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a741f46fadso513540b6e.0
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691655207; x=1692260007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEx1EuEgk0xV+c+q+3VbaXrWwc7le6laBtvGOnu8wyQ=;
        b=ijsKmiltZmQUhQYUjGd7SHhsVtX8YNhhN6I8sy4n2JiRX3b1y7j5NWS2dVdpykwqCq
         54/qPpSLd1/T1rsZsIbrKz5gpF20u+I21TRZ0+CLmdPrLc/355ivsbhzdaV0baDn8fQr
         PL2D1DNPGuouhWTAZCfNORitelOUxt7AXL2OncZDVwL3dW9ghEu6FHBKVH8RFa+nLjOW
         67DKngKnv43zyUthGq5kwTChsSb3K1AokbfkHXxU+JKBxQ46ZxVTIq3MmdBbwUjFVL9m
         pyoSEJxRcQKKabPqKL94pHarAFDeuFhBIDQkMaNBR2i0yTA3xk/vQ0ydGLBkhWgzN8HU
         DFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655207; x=1692260007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEx1EuEgk0xV+c+q+3VbaXrWwc7le6laBtvGOnu8wyQ=;
        b=DrVidpYDvJ+jNA92N/oF55I+dqgisieh89gmSUOQaXbh0dG+P0zEHcCon6fs1EA2rq
         krTj3yTOlkAQErRuBOr/oSxZEFEv+oXGkEPgCn2qw6NURTQ85haS4Li6jA/mTRZ+avF1
         oQM/ktF2BSg1kusxPl+kHFtTigQ4cx+w7RN9m3U6R9wcdWcDnjXnBy2wfi9mWWyWPkda
         9ThTvmanUxl8hrIfhPexr7NXX3UIh90bNNsXda2vPooIvUD9iumj2rthP3Cs8OmoVUTd
         9daVl65zN4s3lDnmj7MRFmGnQevFUq9vrrUk3fWvlWiN/ZGRxRJCU+ANlMJWuLYgWquN
         uL/A==
X-Gm-Message-State: AOJu0YwPIODkmMlsGYTu5DkngpNWlA0WxSyCon6wgEsvMxtJv2zSFEsa
	DnCZ9AYijNICZNjxW6gEaB6f7yasbMb2SUaF9rc=
X-Google-Smtp-Source: AGHT+IE2h63tBYQsvpB8Jxhr0t4pd8l49Xn88nWC57GEvyMlWjF77/7EcfFdg1Yy5bCCML7us+EA5w==
X-Received: by 2002:a05:6808:30a5:b0:3a7:3ab9:e590 with SMTP id bl37-20020a05680830a500b003a73ab9e590mr2629027oib.9.1691655207046;
        Thu, 10 Aug 2023 01:13:27 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b1a2c14a4asm1019036plg.38.2023.08.10.01.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:13:26 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	muchun.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH v2 0/5] mm: Select victim using bpf_oom_evaluate_task
Date: Thu, 10 Aug 2023 16:13:14 +0800
Message-Id: <20230810081319.65668-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Changes
-------

This is v2 of the BPF OOM policy patchset.
v1 : https://lore.kernel.org/lkml/20230804093804.47039-1-zhouchuyi@bytedance.com/
v1 -> v2 changes:

- rename bpf_select_task to bpf_oom_evaluate_task and bypass the
tsk_is_oom_victim (and MMF_OOM_SKIP) logic. (Michal)

- add a new hook to set policy's name, so dump_header() can know
what has been the selection policy when reporting messages. (Michal)

- add a tracepoint when select_bad_process() find nothing. (Alan)

- add a doc to to describe how it is all supposed to work. (Alan)

================

This patchset adds a new interface and use it to select victim when OOM
is invoked. The mainly motivation is the need to customizable OOM victim
selection functionality.

The new interface is a bpf hook plugged in oom_evaluate_task. It takes oc
and current task as parameters and return a result indicating which one is
selected by the attached bpf program.

There are several conserns when designing this interface suggested by
Michal:

1. Hooking into oom_evaluate_task can keep the consistency of global and
memcg OOM interface. Besides, it seems the least disruptive to the existing
oom killer implementation.

2. Userspace can handle a lot on its own and provide the input to the BPF
program to make a decision. Since the oom scope iteration will be
implemented already in the kernel so all the BPF program has to do is to
rank processes or memcgs.

3. The new interface should better bypass the current heuristic rules
(e.g., tsk_is_oom_victim, and MMF_OOM_SKIP) to meet an arbitrary oom
policy's need.

Chuyi Zhou (5):
  mm, oom: Introduce bpf_oom_evaluate_task
  mm: Add policy_name to identify OOM policies
  mm: Add a tracepoint when OOM victim selection is failed
  bpf: Add a OOM policy test
  bpf: Add a BPF OOM policy Doc

 Documentation/bpf/oom.rst                     |  70 +++++++++
 include/linux/oom.h                           |   7 +
 include/trace/events/oom.h                    |  18 +++
 mm/oom_kill.c                                 | 100 +++++++++++--
 .../bpf/prog_tests/test_oom_policy.c          | 140 ++++++++++++++++++
 .../testing/selftests/bpf/progs/oom_policy.c  | 104 +++++++++++++
 6 files changed, 428 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/bpf/oom.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
 create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c

-- 
2.20.1


