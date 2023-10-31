Return-Path: <bpf+bounces-13668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA87DC5A3
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE73128172F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098A8748F;
	Tue, 31 Oct 2023 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YAlwopIF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D596D22
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:04:49 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EFEA
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:04:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5b93ddb10b8so2814914a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698728686; x=1699333486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Td5LXO5YkgVEJxdEyh7D5feplwcwcXSuZuF8PTtqI=;
        b=YAlwopIFVAY2UQDQF3LD6oRW0gXY3Ix0but44YVctBTLpTfeRX1FgnW797HFSFmEwU
         ZQEQkTivAP1ViV/l90QKHaqYuSJehADazlw5zgzrnHOIP2hXpspKA88obheR/6iyst7B
         wdhpEmkhL9ibaAJ7jqO/kDkjdVJ9uzaDllGBt61Ywi1jhY6lzQNw3/TbpgNFT+IFKERo
         h2EfHnsWE4c5lc0JES4QmsjCqVZT+Efi4Z357vqjI077s0s3F4knTvR2kqF8kVwpBwiC
         ph5NP5w5kZhYuhap0Lust6o9ye/VNI3NAAW+YFU6AzlGgLHhYnldWCKuD29dO3aDoR9w
         uShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698728686; x=1699333486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1Td5LXO5YkgVEJxdEyh7D5feplwcwcXSuZuF8PTtqI=;
        b=g8YEZ4Y+GQ+JvnwPvdfXsp0LwsQcAHNaXVobh8Q+wea51A39XtPQhKcbvkNbvYnBM/
         +TPsmL4B2glDUSByyTsAz0vwVf1MojpJWWdEGhLIaGYFesq92gdd3PWSKdJM+8k+I7E8
         lWV1Za676lxn1EKbKV1WYTVf7TLv+PX8oDptrQG7dy0lLDNO5AJRgzzb2M15V8ZUW0bB
         mKRO4caQURJEFwwewORwJu+40kw1YG8MtFQHHrM0/0cXxRIDudxmib3kC9PJBnufQot0
         OwEAfO4Bsy8OEh7FJCj/Zq3+oZaArFfdDng2Vqy3pKNZssZpks8W6EDWgBE4szZhY4ek
         IgsQ==
X-Gm-Message-State: AOJu0Yy+XSUhUcRTDFA3QRv9x1GQ4Li1nxJ0BLEEYG/V3nDOmc5FsV9X
	d0Z8bSOmydRpXgJm/GD7R8IqLIyMpcnUL+xnlp8=
X-Google-Smtp-Source: AGHT+IFxFRJRy3zmrx0rzzLsmvqMECDJQCi1ZfRhGWYop+22lQBkDw1jALkaj66h9MwKzBXeciHsmQ==
X-Received: by 2002:a17:90b:1bc3:b0:280:299d:4b7e with SMTP id oa3-20020a17090b1bc300b00280299d4b7emr2107736pjb.19.1698728686688;
        Mon, 30 Oct 2023 22:04:46 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a195500b0027ce34334f5sm350951pjh.37.2023.10.30.22.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:04:46 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v4 0/3] Relax allowlist for open-coded css_task iter
Date: Tue, 31 Oct 2023 13:04:35 +0800
Message-Id: <20231031050438.93297-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The patchset aims to relax the allowlist for open-coded css_task iter
suggested by Alexei[1].

Please see individual patches for more details. And comments are always
welcome.

Patch summary:
 * Patch #1: Relax the allowlist and let css_task iter can be used in
   bpf iters and any sleepable progs.
 * Patch #2: Add a test in cgroup_iters.c which demonstrates how
   css_task iters can be combined with cgroup iter.
 * Patch #3: Add a test to prove css_task iter can be used in normal
 * sleepable progs.
link[1]:https://lore.kernel.org/lkml/CAADnVQKafk_junRyE=-FVAik4hjTRDtThymYGEL8hGTuYoOGpA@mail.gmail.com/

---

Changes in v2:
 * Fix the incorrect logic in check_css_task_iter_allowlist. Use
   expected_attach_type to check whether we are using bpf_iters.
 * Link to v1:https://lore.kernel.org/bpf/20231022154527.229117-1-zhouchuyi@bytedance.com/T/#m946f9cde86b44a13265d9a44c5738a711eb578fd
Changes in v3:
 * Add a testcase to prove css_task can be used in fentry.s
 * Link to v2:https://lore.kernel.org/bpf/20231024024240.42790-1-zhouchuyi@bytedance.com/T/#m14a97041ff56c2df21bc0149449abd275b73f6a3
Changes in v4:
 * Add Yonghong's ack for patch #1 and patch #2.
 * Solve Yonghong's comments for patch #2
 * Move prog 'iter_css_task_for_each_sleep' from iters_task_failure.c to
   iters_css_task.c. Use RUN_TESTS to prove we can load this prog.
 * Link to v3:https://lore.kernel.org/bpf/20231025075914.30979-1-zhouchuyi@bytedance.com/T/#m3200d8ad29af4ffab97588e297361d0a45d7585d

---

Chuyi Zhou (3):
  bpf: Relax allowlist for css_task iter
  selftests/bpf: Add tests for css_task iter combining with cgroup iter
  selftests/bpf: Add test for using css_task iter in sleepable progs

 kernel/bpf/verifier.c                         | 16 +++--
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 33 ++++++++++
 .../testing/selftests/bpf/prog_tests/iters.c  |  1 +
 .../selftests/bpf/progs/iters_css_task.c      | 63 +++++++++++++++++++
 .../selftests/bpf/progs/iters_task_failure.c  |  4 +-
 5 files changed, 111 insertions(+), 6 deletions(-)

-- 
2.20.1


