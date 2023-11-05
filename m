Return-Path: <bpf+bounces-14223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8597E13B0
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 14:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A591F214C9
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF05C8C8;
	Sun,  5 Nov 2023 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KfeVkXwb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A44C2D8
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 13:35:10 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA065CF
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 05:35:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso696947b3a.0
        for <bpf@vger.kernel.org>; Sun, 05 Nov 2023 05:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699191309; x=1699796109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dSl1NDctJPZ1SHMsjt6uhbSHlKCuHSvv/7KzmRIcyg=;
        b=KfeVkXwbzpEHBsUXa9pKqsDt24y+sJvD+d0YfpBcpATRhdhQnQmwgh/RTA349BBSUV
         PCuoukb5pQKbT7q5x3/f+hD8cf4QFqKXWEOpQJ4wH9ufetOHpS9zBVBQ64X+bsqzCR5n
         ApPfniNKFoOoZf891r1JAIt6ElfvtYh8e+oDfUCY3qP01AsEb48tFWQm7k+aKuxW6YD+
         DdzSdxNfnEPPYzJx22jNP3vKgghcxctjoFtq1vVvpBNaJMvtlxWuwlVQxJ4eKzBG9lYj
         4ScIDIfDT/+EMhBtsCyVuN+qQZHYreel1H8UalGhY6yavkkptdziHUsIjERhR+9JoLVL
         g/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699191309; x=1699796109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dSl1NDctJPZ1SHMsjt6uhbSHlKCuHSvv/7KzmRIcyg=;
        b=EGxqsH29dfsOpPXqITH/2PFviCoibL8OHkODuK6CUtEaCISa7PJj2bELz8KG0WO5Zn
         GwdkUHmxX7st9hjJr4wCJOoHJlmoQwBr/LRHoHc1iKbFdUBkfYDfYk844iFaEuhZwif8
         vFCQvruYgHqPmbxT9e+rkEv+06HmfhDitHo/3DXoG8h2jlPy4Gc7gPVkmTm7ynYpA9lq
         D+RBv2A+yskUVi15hfzzduo0sgaDnf5gDEoJ9fOAS/U3/M4xkg8TGxTYh9+DTUUCKa5J
         qePjjtauXjz7UST4BVJtBvWLDd6EY+sqigSMWio2o1L/cGnuDUA3omhl3ImsPM/xv07L
         sYtw==
X-Gm-Message-State: AOJu0YxZRCtCNQZRAKUopFa/IefRKxO4yXIafcrJj+d75vGCre5xxuUR
	/Jj3/YbiOSWFY01F1PbGsbHfPG5Ji4znqmO8KT0=
X-Google-Smtp-Source: AGHT+IHec+dRmOJ1A4LF3fopZqJQ6ruZ6wjxBRX0HxPuaINg3YB3/kNkIwRhIxvmiK4IFkOfwRS3hw==
X-Received: by 2002:a05:6a20:a4a1:b0:14d:5580:8ff0 with SMTP id y33-20020a056a20a4a100b0014d55808ff0mr15553421pzk.25.1699191308977;
        Sun, 05 Nov 2023 05:35:08 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b001c8a0879805sm4219711plb.206.2023.11.05.05.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 05:35:08 -0800 (PST)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf 1/2] bpf: Let verifier consider {task,cgroup} is trusted in bpf_iter_reg
Date: Sun,  5 Nov 2023 21:34:57 +0800
Message-Id: <20231105133458.1315620-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
References: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task) in verifier.c wanted to
teach BPF verifier that bpf_iter__task -> task is a trusted ptr. But it
doesn't work well.

The reason is, bpf_iter__task -> task would go through btf_ctx_access()
which enforces the reg_type of 'task' is ctx_arg_info->reg_type, and in
task_iter.c, we actually explicitly declare that the
ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL.

This patch sets ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL |
PTR_TRUSTED in task_reg_info.

Similarly, bpf_cgroup_reg_info -> cgroup is also PTR_TRUSTED since we are
under the protection of cgroup_mutex and we would check cgroup_is_dead()
in __cgroup_iter_seq_show().

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/cgroup_iter.c | 2 +-
 kernel/bpf/task_iter.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index d1b5c5618..f04a468cf 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -282,7 +282,7 @@ static struct bpf_iter_reg bpf_cgroup_reg_info = {
 	.ctx_arg_info_size	= 1,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__cgroup, cgroup),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
 	},
 	.seq_info		= &cgroup_iter_seq_info,
 };
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 4e156dca4..26082b978 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -704,7 +704,7 @@ static struct bpf_iter_reg task_reg_info = {
 	.ctx_arg_info_size	= 1,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__task, task),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
 	},
 	.seq_info		= &task_seq_info,
 	.fill_link_info		= bpf_iter_fill_link_info,
-- 
2.20.1


