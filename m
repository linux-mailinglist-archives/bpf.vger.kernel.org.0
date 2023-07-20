Return-Path: <bpf+bounces-5535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E52F75B8DE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B049E282034
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F74B16422;
	Thu, 20 Jul 2023 20:45:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B8156FE
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:45:25 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01D1737
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:45:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b895a9f4ccso7108955ad.2
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689885924; x=1690490724;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sPfwMswysg75ccrXvPNWLUihWhssyGFKntJaNPbUweE=;
        b=kI8Tv6Lz2q+u2u9S5z0ync7bSb3mFkDpNR3F1kzGtxg/vRdmeitBperBLgzsAEoUWg
         q0ZNu6sIPQ3dgdKBwVITyF2JfvP4drgmDFZ7QCZo7pUWSqsj555M6V8wFknEej8jUe6s
         PTw4VkIkYz0AAuuJwD3NzT5/9kbGpshTNUXQyQLZyHWQjxE2T/uqoq1uoOVbqLmg1mCG
         ohZcsJcj1n6C3qbNyM+iC1v/h7q1qiHd2w/i2PyxobNE6z/vdLmDp9DmbDFmTzYtdpku
         IpyertuYeLleLeoMCYLC1X0uPvtEtairVr+ioZN2oB0WYEirREYUC0hpc4GKYLv2HdJz
         K7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885924; x=1690490724;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPfwMswysg75ccrXvPNWLUihWhssyGFKntJaNPbUweE=;
        b=DHM/owFbX/PHMaJ2LmNVCDhL2QXpFyslO18968P8ILUe7L5bk0477JJPam1uhbCYY1
         rC/UbMAmreAsxSv/Vnqqcz6Je/ZJ/5EkcL9oLPUahDtC/0ge1U5quJDsrDlHLTrkCRKL
         t1T+mOlad1qVMuVK4KyrPx3k3nBZ28dQlQ1ltA4koF9jJkcfystfrAm+qE+vHGCvhs77
         QPK10MyGkklrtt+/Gm120LCPKbqPmDKssE8fOWzXZ0QHS/YzvZsLqVbL2jz5hTtf1kKK
         8frbd93+BCYBqn3QDhbkWaZ32I5Nnsfxy6w8qaHBzDNdk2HtRocHk8tjCql5wG06fvJ9
         wfCQ==
X-Gm-Message-State: ABy/qLYeWcAFrRIe4iW/cM4yyW5o/CYb5jmL6J3gNH98A8GS8KnXmGRj
	FN20MRpg31MYbzvIpBIftT2OzMXRcePR5sBnk+BSQQR19DjjjC9dcW8PJcmsqxSS3Sy8FA4ghWB
	QDmwciopsPFFLgyaWroNbybaTPKhkXC4APQtLD0TTJTiJswvKN8tlA5+kmbus3FI=
X-Google-Smtp-Source: APBJJlHMGVD/XT9JeZy0yaQlnSXOlY1zSOU2EihTraqo76oxzPAhQMWia1dzhhbkPuaJQ2DvzruaHxFU1ih09A==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:903:2441:b0:1b5:1637:6313 with SMTP
 id l1-20020a170903244100b001b516376313mr620pls.0.1689885923347; Thu, 20 Jul
 2023 13:45:23 -0700 (PDT)
Date: Thu, 20 Jul 2023 20:44:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <cover.1689885610.git.zhuyifei@google.com>
Subject: [PATCH bpf 0/2] bpf/memalloc: Allow non-atomic alloc_bulk
From: YiFei Zhu <zhuyifei@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Stanislav Fomichev <sdf@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In internal testing of test_maps, we sometimes observed failures like:
  test_maps: test_maps.c:173: void test_hashmap_percpu(unsigned int, void *):
    Assertion `bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0' failed.
where the errno is ENOMEM. After some troubleshooting and enabling the
warnings, we saw:
  [   91.304708] percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left
  [   91.304716] CPU: 51 PID: 24145 Comm: test_maps Kdump: loaded Tainted: G                 N 6.1.38-smp-DEV #7
  [   91.304719] Hardware name: Google Astoria/astoria, BIOS 0.20230627.0-0 06/27/2023
  [   91.304721] Call Trace:
  [   91.304724]  <TASK>
  [   91.304730]  [<ffffffffa7ef83b9>] dump_stack_lvl+0x59/0x88
  [   91.304737]  [<ffffffffa7ef83f8>] dump_stack+0x10/0x18
  [   91.304738]  [<ffffffffa75caa0c>] pcpu_alloc+0x6fc/0x870
  [   91.304741]  [<ffffffffa75ca302>] __alloc_percpu_gfp+0x12/0x20
  [   91.304743]  [<ffffffffa756785e>] alloc_bulk+0xde/0x1e0
  [   91.304746]  [<ffffffffa7566c02>] bpf_mem_alloc_init+0xd2/0x2f0
  [   91.304747]  [<ffffffffa7547c69>] htab_map_alloc+0x479/0x650
  [   91.304750]  [<ffffffffa751d6e0>] map_create+0x140/0x2e0
  [   91.304752]  [<ffffffffa751d413>] __sys_bpf+0x5a3/0x6c0
  [   91.304753]  [<ffffffffa751c3ec>] __x64_sys_bpf+0x1c/0x30
  [   91.304754]  [<ffffffffa7ef847a>] do_syscall_64+0x5a/0x80
  [   91.304756]  [<ffffffffa800009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

This makes sense, because in atomic context, percpu allocation would
not create new chunks; it would only create in non-atomic contexts.

This series attempts to add ways where the allocation could occur
non-atomically, allowing the allocator to take mutexes, perform IO,
and/or sleep.

Patch 1 addresses the prefill case. Since prefill already runs in
sleepable context this is simply just conditionally adding
GFP_KERNEL instead of GFP_NOWAIT.

Patch 2 addresses the refill case. Since refill always runs in
atomic context, we instead add workqueue work to perform non-atomic
allocation when the atomic attempt failed.

YiFei Zhu (2):
  bpf/memalloc: Non-atomically allocate freelist during prefill
  bpf/memalloc: Schedule highprio wq for non-atomic alloc when atomic
    fails

 kernel/bpf/memalloc.c | 59 ++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 18 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog


