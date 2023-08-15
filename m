Return-Path: <bpf+bounces-7833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751AD77D14D
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EFE1C20DB4
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA6915ADA;
	Tue, 15 Aug 2023 17:47:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E0E13AFD
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:47:33 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D3D1
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:32 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58c55d408daso11596957b3.2
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692121651; x=1692726451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Isfnt8xxQu2vEYSiPUbmnt9K0kd+VySH+bQvzCMsoUE=;
        b=FOSmcNW7mBrPD8gh690bc1oeIEGSCkYt43w6ClaUiYt9x8EajyPCeNCyemTIUapP/o
         QWlZndsor6pJJ33B3zeuyF657yCyXPtMamtr8vY8UzuC/W2aC7yXBKFFCGb0n19UBm7j
         w9arTGzgRDVX9GbfULoxn1a6Sa5S5c9Ws2mwFpnrK0wqocQ/sEZeyHqG617tWhUlcnCd
         QEh1fVkti6L22Eqed8pIAVqCYG4Q4STDwC5LUKtBZ5gmS3Ipal5eB+pqoh/Tp2vyvgXg
         tcGyUvR/dDNNF75MhcUeiqTE/5xi6BAu5NmF5vycKijOWGTWl4OyewOlsiiMJ/FqF8hz
         BDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121651; x=1692726451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Isfnt8xxQu2vEYSiPUbmnt9K0kd+VySH+bQvzCMsoUE=;
        b=Nrdyf3yR0NADtT9Dzag+eNm7Ei5+WQHykNwMGPaZ3Pc0yGtZCl237dHLazB9ksUbit
         M32Sp5H2YFOMb6713FFM2cuXE5F5V1u/QF1Wj6JznLoeLSQivawgeLLCp7susv0fg/fI
         iaAlgz9IjFzZk/I8J0kgq/cCG+kmWhMwgkfJafPHYrXSUhRMM0KxF/sWyNNZ9chM7tsn
         Vqx1W2T3xo+EbFuAUz8nxxBE7GmPjelnTHY/x+ADoE4c60oLHDKxEji6sRQ4aMkyjRSW
         70jsVx7Mt5+kM00koNHlR6WVrZ8sA/nh++yBBZHXohaNEpGLR2Y24Rgo9BoTHCzqvL/2
         eaUQ==
X-Gm-Message-State: AOJu0Yz7tj3FCFFAwqTIYutNGZMcqiS9P/0SO85uRfQIsTLhp8jSqLc+
	3NJvVeQu17GALhfVmHYDB3bsCQ3Va2bPHA==
X-Google-Smtp-Source: AGHT+IGYcr9s8MYSY/gqye7JI1nzjH9EU3RQnng2HT9I8ZPXhPEAWB8fPW33F/AdBj4o5vQnj4z0cA==
X-Received: by 2002:a81:7282:0:b0:586:9fb3:33cc with SMTP id n124-20020a817282000000b005869fb333ccmr14881740ywc.50.1692121651663;
        Tue, 15 Aug 2023 10:47:31 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:84ee:9e38:88fa:8a7b])
        by smtp.gmail.com with ESMTPSA id o128-20020a0dcc86000000b00577139f85dfsm3509404ywd.22.2023.08.15.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 10:47:30 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 2/5] libbpf: add sleepable sections for {get,set}sockopt()
Date: Tue, 15 Aug 2023 10:47:09 -0700
Message-Id: <20230815174712.660956-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815174712.660956-1-thinker.li@gmail.com>
References: <20230815174712.660956-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Enable libbpf users to define sleepable programs attached on
{get,set}sockopt().  The sleepable programs should be defined with
SEC("cgroup/getsockopt.s") and SEC("cgroup/setsockopt.s") respectively.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b14a4376a86e..ddd6dc166e3e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8766,7 +8766,9 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/getsockname6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sysctl",	CGROUP_SYSCTL, BPF_CGROUP_SYSCTL, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getsockopt.s",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE | SEC_SLEEPABLE),
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/setsockopt.s",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE | SEC_SLEEPABLE),
 	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
-- 
2.34.1


