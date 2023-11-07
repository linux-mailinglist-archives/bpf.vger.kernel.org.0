Return-Path: <bpf+bounces-14401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC407E3FF7
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164D22810C9
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C530CE3;
	Tue,  7 Nov 2023 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EClb5Jim"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78AF2FE3B
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 13:22:21 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211F92
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 05:22:20 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-565334377d0so4198111a12.2
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 05:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699363339; x=1699968139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwZePJeoSr3O0bybFoYz59dDfNn8i1xg6Qpn6uw7YTk=;
        b=EClb5Jimh8pNWkq9fifht40o5OOgp7I9LqGnE3kDcb0MlWlFTMA0kf3PZEGG2Q7I26
         mSp8Ku9IjEq37gCeHKZXNjxjkAvVOBLYbqdbbq/x1mmFqd4JP58VSgNp8VHLqoKufaQY
         ByPe1hGtRqK7m8E1pzdPbJ6Udg0K0/pvvLlGxU3rjcCV+nBNgTQblmcb6LzIsa0hvbdr
         qc2hye82o8HP3oCnoIQpL4/9njluz3a9f2WIoPI1ScPrPHdCS9YxuP5upxvnUPvwq+Zp
         7Sd23Qj308btwUb9eyja+KGSfaCat6VEax6LwdtznntAc8aiwE/+5dPgKCC1tTnIFgd1
         ZTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363339; x=1699968139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwZePJeoSr3O0bybFoYz59dDfNn8i1xg6Qpn6uw7YTk=;
        b=B/VWqZPwhyKzvK/iQnlbSOCq3J+ueWKWHjSy+mE/4sM7+J0mWSd0Y8CwfGuE/0g1ta
         GiK1fxb2BZL5k5KCsUzcrEdnNYDpMJxPrCFibmeZVQAtseA5FxIU1QP6r+KUNf5Hq3Kv
         W4C3ctLXwjZ6hzyOZmdhxYNYfSmQI8h5mOsL8ZRQM9eenSIfluNzHFmXt62Uelp+muX2
         yppvYq4Ge9f87du7iH/TtWoMpX4d3+Mm1EWcnI3+q8AjKO1itFz527tlCO+zBRDTIy9F
         L/I2mBGTinAdV+wuVFZuY/gZvUr/PSK74s1Xdim7aBfy2sK59mltsh48vjgRrbnfxxJh
         k1qg==
X-Gm-Message-State: AOJu0Ywu43yHo41qO0HsQ+a37kF8dqWE2e5kJlDfn0oRSHYYBC6mYjFj
	PmU9WKtazIrE3YLiCtEMBueC3De4Zp9qNa/g9XI=
X-Google-Smtp-Source: AGHT+IFnw3uPBxos8gEWgBswMK40sWIfoR3WaKz8MQHNdtIwFSKOXiAcgm3UyTFJ9RKm4yI/OQ9VIw==
X-Received: by 2002:a05:6a21:4881:b0:180:ebec:da31 with SMTP id av1-20020a056a21488100b00180ebecda31mr24258179pzc.8.1699363339634;
        Tue, 07 Nov 2023 05:22:19 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.70])
        by smtp.gmail.com with ESMTPSA id y36-20020a056a00182400b0068790c41ca2sm7218881pfa.27.2023.11.07.05.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:22:19 -0800 (PST)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf v2 1/2] bpf: Let verifier consider {task,cgroup} is trusted in bpf_iter_reg
Date: Tue,  7 Nov 2023 21:22:03 +0800
Message-Id: <20231107132204.912120-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231107132204.912120-1-zhouchuyi@bytedance.com>
References: <20231107132204.912120-1-zhouchuyi@bytedance.com>
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

Actually we have a previous case like this[1] where PTR_TRUSTED is added to
the arg flag for map_iter.

This patch sets ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL |
PTR_TRUSTED in task_reg_info.

Similarly, bpf_cgroup_reg_info -> cgroup is also PTR_TRUSTED since we are
under the protection of cgroup_mutex and we would check cgroup_is_dead()
in __cgroup_iter_seq_show().

Link[1]:https://lore.kernel.org/all/20230706133932.45883-3-aspsk@isovalent.com/

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
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


