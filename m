Return-Path: <bpf+bounces-16882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF48F8071FA
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D691F2123C
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637BD3DBBF;
	Wed,  6 Dec 2023 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="cMkbhZ6x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C940D69
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 06:13:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso38811475e9.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 06:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701872027; x=1702476827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRv7xiM70JnOFaj5pW4OpSWpKutp6o9jAADHES/rpZQ=;
        b=cMkbhZ6x0Dhb/gt9E5ybkqSuSDxhlhJjd66dw6erDDbJERtsPk1etgZ47Pui7rBICT
         c6YPjDRV1KP5lUhMQHD0HHWvRQOBluAXF1+s9F8Tj0dOUmDmZYjplIIYDG+vJFiMDaUx
         +4uxq4PiY0CcRjfqC268/6VkByNr+6QKuMYhVzfroyokeEp9yn/GzF/Q8W12I55/wBPs
         SgvxCbZUM6q/RIlo3ZA0wV9BwDCU0wdrsB2urJ1BIESWc3xoZpGYdAwVcY/C4yIeNxgp
         UkrKboB+5ACTrjjYYCUFJM5BldC9KmKJfLvK8bd4BvxeZgKuEDcTv09Jf9VaZ5pRJY4v
         0gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872027; x=1702476827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRv7xiM70JnOFaj5pW4OpSWpKutp6o9jAADHES/rpZQ=;
        b=YJZNs8b9Gau/X2lgqgyWndqHhfDfAl1e/0Z/HLSqYNwqUyDat3TXiDUL1XOdI9c4F9
         s4e3XnppH5c/Dv2LCAr15zu7ccu1HPfo15k6fL2vBioqd6Ziz8oV6UXHst0HMLatqCUN
         S7PgAaaMXaVnZae+uE24OoKLhB37NKpT1v4MPB6kCyrDOyTn9rQSy0E9oSJ56/cxjod3
         /SIKJJcfmn+e7OzjuHz7gH3x8lwYCAoARkRsJRnPaDpBLniY5Ooe4hytuc52s0pl2L1g
         CKob2NjMXozGMCoOiMaQ5K8EdHzo+33v6yd0z1ZNIvI+9/CbXyowQ6IZT6p5aVujzybU
         BOcA==
X-Gm-Message-State: AOJu0YzWhCRy4eKa4eGxUmcNtPXB6uBU6RW+rPF4+Ciaz79fZ9YXOuke
	nXJYRIKvIoQhHCzUl6ALvHLBMQ==
X-Google-Smtp-Source: AGHT+IExBgDjw4jkQqNG5XM7TK8Ssj8lFeXVV6lS0VyjT534UTHPUmAFSPHRAqfFYLyQSUz0tCrFjg==
X-Received: by 2002:a05:600c:a01:b0:40b:5e21:dd48 with SMTP id z1-20020a05600c0a0100b0040b5e21dd48mr672705wmp.118.1701872027523;
        Wed, 06 Dec 2023 06:13:47 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040b42df75fcsm22140330wmo.39.2023.12.06.06.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:13:46 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 3/7] bpf: adjust functions offsets when patching progs
Date: Wed,  6 Dec 2023 14:10:26 +0000
Message-Id: <20231206141030.1478753-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206141030.1478753-1-aspsk@isovalent.com>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When patching instructions with the bpf_patch_insn_data() function patch
env->prog->aux->func_info[i].insn_off as well.  Currently this doesn't
seem to break anything, but this filed will be used in a consequent patch.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/verifier.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf94ba50c6ee..5d38ee2e74a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18181,6 +18181,20 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	vfree(old_data);
 }
 
+static void adjust_func_info(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	int i;
+
+	if (len == 1)
+		return;
+
+	for (i = 0; i < env->prog->aux->func_info_cnt; i++) {
+		if (env->prog->aux->func_info[i].insn_off <= off)
+			continue;
+		env->prog->aux->func_info[i].insn_off += len - 1;
+	}
+}
+
 static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
 {
 	int i;
@@ -18232,6 +18246,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 		return NULL;
 	}
 	adjust_insn_aux_data(env, new_data, new_prog, off, len);
+	adjust_func_info(env, off, len);
 	adjust_subprog_starts(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
-- 
2.34.1


