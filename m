Return-Path: <bpf+bounces-21570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371A84EEC6
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D701F21951
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB05258;
	Fri,  9 Feb 2024 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtLVjpvy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBC4C8E
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444060; cv=none; b=irrY5TY9dBHL3IntM4AJ1vxsuM3wtAbAwaJnUiq6HRcCVqK4lOwjiAReEJOqk0PzleHuLpGNntviA69URwv5plORJJAsIZgxGLACfvLnBkEtEYtEXBl+Eyq31sR3xNrhhmko04K5TqVdcTh+qsZno4h9Btlh9vTRQJUBMOTjeO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444060; c=relaxed/simple;
	bh=4UNGAiBlbIhXPVNFPusepQXSZLNoKdzsnPsjmEDsRNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7nOWo02eUt3lH6lM2QaA4tXVFV4uB2Em5SouMYUrAfXROH5dqiO/VyTh2Co6DNd2chU0ImzOFHeg3muSyuLOno0ZJVc0cXscM+mdyVwNv9jD9KdzxUiiTyv53ZWV2b8UujiSP6vps2IfMg0ETsDrLezC4boG/uHkC2p78R/aoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtLVjpvy; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-604a184703bso5518497b3.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 18:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707444057; x=1708048857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVXAYn+kBBkRE2GKj9qbQ7OXYLy6VKv4rz5z5iQMMZ8=;
        b=YtLVjpvyi4ApaNx8MaF4YJNa4yh6zY89C80QAAK8FeOOFDQFLTmNyVaE4eaCaexLqJ
         LX2HjGP2tn4NKBUENv0/wJnWa9Mzd39rXp/NaTFs4AhgmdO28yJ5hOs6g7XU2MHaSr7I
         FrrqZkXgMKJhJEXtcfyIqTOm8xoeZXhzaQ8hYFcuDGzPJ7sHyvdjNhZrZp/KP1JU6zPv
         pOWXrELL9dUTbi4GiPtiJpzXWRZo2YZYRjXAvuwgmpseqdmJ+DS8A1ShvJRfCS/JXK5i
         uxy1QJyyXvO5/1oFlw3jyifldnTT3ccePzQMQoRGw2kRsoVks6m7u6Z5CQk0/gfTHEgA
         dS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707444057; x=1708048857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVXAYn+kBBkRE2GKj9qbQ7OXYLy6VKv4rz5z5iQMMZ8=;
        b=b+sYhgR8D7c1wkQ1Lgg4vlbDFRFd14lNNelF5uhV/1UMbYnd7m+9m9dNeO/57HxbAM
         qkThi79jJlrH/FApeMeFhVqalTgVouvkb6uqzL4f3AXaxJ8m4FPznfBo3cnEhtObBnTh
         86dho2T1gc4lCiDPWRaNgBt5aZc1q18o6cSPZeiX9niONDn5J0YfR5SRsouNaCNYA/U7
         gB6ZjKz9kFEpt28BJjrSZVmIc24ijrDezc41VkAku+npyBesZB5sMZPfafwgs4Fci8jh
         E6rGq1uKvt0DtQQ6lLM8FjOndOC/KjkVq7WhUQbH1esiOl66W4u3HIoCgrIh2eMzViOk
         VzEw==
X-Gm-Message-State: AOJu0YwdwAv0efmlHrvkn5HYzlqsTJgbLWU8/vF8BKZ6YLojlvbpTKdj
	RkguEKwfg+XcWLZ0n7YcyQvvZ/NtpoyO54XuE9RWwB3S3gn2rcpjRVBF8h8fhIU=
X-Google-Smtp-Source: AGHT+IEhn37uTGKTQ80jI6TyeGX0PWA+kWcYCcEl4YuRu6chlXRY89/oMEV7U519kOn8BwPl/G1ztA==
X-Received: by 2002:a0d:d583:0:b0:604:57dd:4e9d with SMTP id x125-20020a0dd583000000b0060457dd4e9dmr262038ywd.21.1707444057121;
        Thu, 08 Feb 2024 18:00:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcsHJdDHowj76b7zNZAKFeNbpbXbWt/ElgCJXhQ7JLVJsjhQEN9lqnQiB2THu0+OGmqJhheBZz+5Yul0LA3BcAJx3Wu8TJVI1L/S/n8oRKJDLwrzurrifqnPhv9bkHSSilH8jRCmLoWkAtnqmWoloEt/52KrwnWS44Ze310MpiEEvYc89WqvPZyTIlVht4g7V73AFWc+u6JQD7PcvBvFDJJOro0Xt8UMC6udmxiVjryGtVx4ozktqUdOhYgX7wGnh3JBOGra0WyhMLHeqgCFZrQlyt95CWtDeDxKQtWAlMA1U=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id h123-20020a0dc581000000b006041f5a308esm134982ywd.133.2024.02.08.18.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:00:56 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 1/4] bpf: add btf pointer to struct bpf_ctx_arg_aux.
Date: Thu,  8 Feb 2024 18:00:50 -0800
Message-Id: <20240209020053.1132710-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209020053.1132710-1-thinker.li@gmail.com>
References: <20240209020053.1132710-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Enable the providers to use types defined in a module instead of in the
kernel (btf_vmlinux).

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/btf.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1ebbee1d648e..9a2ee9456989 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1416,6 +1416,7 @@ struct bpf_ctx_arg_aux {
 	u32 offset;
 	enum bpf_reg_type reg_type;
 	u32 btf_id;
+	struct btf *btf;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8e06d29961f1..7c6c9fefdbd6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6266,7 +6266,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			}
 
 			info->reg_type = ctx_arg_info->reg_type;
-			info->btf = btf_vmlinux;
+			info->btf = ctx_arg_info->btf ? ctx_arg_info->btf : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
 			return true;
 		}
-- 
2.34.1


