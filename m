Return-Path: <bpf+bounces-13214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960E7D6451
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 10:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B987B21130
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C11C681;
	Wed, 25 Oct 2023 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S8YGpTrb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192263CA
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 08:00:22 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C25EDE
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 01:00:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b9af7d41d2so4642436b3a.0
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698220819; x=1698825619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5w2JCxpCxJDgHsk5AvbIbbA8aUN5teyyyczogE8i+0=;
        b=S8YGpTrbOaUfQJBGWTop+nwr8v8hpHtlUVaILVAy2FBM6oq+PsFOMpLwIvJiSvJFNn
         or1amWxSkhgFqeU7vtAwQ9S3JMP/una5ZLnhnkHNY7+L1Qv7nMhI9pStDM7LkB0rkLAk
         c8ydg+yQ4wiHdgCFlVnxaL1fW4qnAZX+Za1H+i8ENIUBLZdRU8NHQtBaWrdkI1Hhd11R
         UhERWizvDjpdrv/aUy3wJt2QNu+UgDphHWGwPA4TQePJ/JhnAIJPjq9dCBmWTKshDlyv
         /KkHDjfveeqAY/EmyWqEImoov7kDlW7S9cWrlTE8jkzOdOLanmCRGcu/fehyDlpeGC94
         b6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220819; x=1698825619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5w2JCxpCxJDgHsk5AvbIbbA8aUN5teyyyczogE8i+0=;
        b=LfJDiUHfeN6tL/G+XNqO+x0w0qZLq+rU4w4i/EdjGmO/mxYq2bwNt1/PjH15GdgEh2
         EElIjU6qLJVjpzgl1zqodIwjmb6KCdCgErcwBVDXea/CYVeG5PoOXDssTvevbDSbHkxq
         MYQCq6jmmupwKTdAEe6cpdSK+vW+1f+0TJ9p8QZBTD2vF26Gp99EweAlT0J0nxcLU9Pk
         FKsQSgSjHqghs5G8HsSfkCNXRhs0mOYFS28n381MdYnp4lFkIZG4TeHYynSekwNCQx18
         F+24+2FrV0adM/3/w6oQFCt7JcUNoVURDLkdEwyFeAuJXqE3z+B2qbu6Xi6ulG7BLaNS
         lfmQ==
X-Gm-Message-State: AOJu0Yy7DTM8rMV6/ZQXZRBRNjE8Xs1YTO8lKCFHJQwpyDCtXA8Avz1r
	90PA0Ke6ue4THPybZOQe8Tgh6izJ0nUDIwuymtg=
X-Google-Smtp-Source: AGHT+IEbzjzRZzqdTAncuAKumacZ4avf8DTylv/ZHeF++ePVRlKXmRityQGD3Sx+QpyaaIxOftSkAA==
X-Received: by 2002:a05:6a20:548e:b0:14d:9bd1:6361 with SMTP id i14-20020a056a20548e00b0014d9bd16361mr5420766pzk.11.1698220818930;
        Wed, 25 Oct 2023 01:00:18 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id 23-20020a630f57000000b0059cc2f1b7basm8118187pgp.11.2023.10.25.01.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:00:18 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 0/3] Relax allowlist for open-coded css_task iter
Date: Wed, 25 Oct 2023 15:59:11 +0800
Message-Id: <20231025075914.30979-1-zhouchuyi@bytedance.com>
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

link[1]:https://lore.kernel.org/lkml/CAADnVQKafk_junRyE=-FVAik4hjTRDtThymYGEL8hGTuYoOGpA@mail.gmail.com/

---

Changes in v2:
 * Fix the incorrect logic in check_css_task_iter_allowlist. Use
   expected_attach_type to check whether we are using bpf_iters.
 * Link to v1:https://lore.kernel.org/bpf/20231022154527.229117-1-zhouchuyi@bytedance.com/T/#m946f9cde86b44a13265d9a44c5738a711eb578fd
Changes in v3:
 * Add a testcase to prove css_task can be used in fentry.s
 * Link to v2:https://lore.kernel.org/bpf/20231024024240.42790-1-zhouchuyi@bytedance.com/T/#m14a97041ff56c2df21bc0149449abd275b73f6a3

---

Chuyi Zhou (3):
  bpf: Relax allowlist for css_task iter
  selftests/bpf: Add tests for css_task iter combining with cgroup iter
  selftests/bpf: Add test for using css_task iter in sleepable progs

 kernel/bpf/verifier.c                         | 16 ++++++--
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 33 +++++++++++++++
 .../selftests/bpf/progs/iters_css_task.c      | 41 +++++++++++++++++++
 .../selftests/bpf/progs/iters_task_failure.c  | 23 ++++++++++-
 4 files changed, 107 insertions(+), 6 deletions(-)

-- 
2.20.1


