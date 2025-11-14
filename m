Return-Path: <bpf+bounces-74552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FC4C5F2AD
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C773A9FDD
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC2326952;
	Fri, 14 Nov 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUZfrBgQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA431A041
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150758; cv=none; b=tNJWPpeCYLhJdKgeiDiV32Bbu3Tzz5T3awvUysgulOnyhbuPZdozlTQMk9FK3Cit5xbFkn/DlWk4hqUXbyrM8Gx8sscO2V9+1Zm0hNFfiNX1DQftQy+hBlzZ0iDQxoqk9R/Ximtr3rgY4c+9++0DZGxq2IioH4VyFKU6/jGCTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150758; c=relaxed/simple;
	bh=sW7hjX9ke2KCKQ4QjFSY7BIkLDso7UnFwwsHYNjzU8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbgan8A3aAQbmhxr6/rxMHmTtS1xwksi+G9Tu2YJJcQkQma6/NcVrvFaMTn4T1ZZxwuT4LztrvFdq6/R5PhgdV9EVKIBAl77HXUV2RdFh7fDYgo0xCbsxBwdvnHhhAX/DK5n3TPibrrpt+n/rJSvG4szp0Wl6jcnKaBGJCIeOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUZfrBgQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aace33b75bso2224273b3a.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763150755; x=1763755555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/4za0pR1qzjcoskvf7OBgP77w3O3LYgwwtOK6cG6ug=;
        b=TUZfrBgQUZDm+Fkwy3nVS9d26waF/l+CUmBslhTwWFRoH9Ct+6E4WF09ZTlShFmVEC
         SqpywJpa4oOLJGbVtJfXUSkoyqFx7vfJeUJh/5fXjXh1Wx0XgwKmGvKBZiYOH1kQopQd
         SA7uwqE/7aWBYJybz/9te4PjV3IRYVGZ99OvekTEjY1KVzZ+t5J4Gbi7Od83NdTmmVo4
         kPvqo+SzEwYDUHy52zDFLxKuWEIWk5mFE6+HLu2xIiTPLMm0gYoVkLro4e6kZln+otFM
         Do2sIa/L8jLb8zFkMd6SAGS8rXIZ138warQoog+s7pACaoQA50zlC2CTGm0T/VMxEUU4
         88NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150755; x=1763755555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/4za0pR1qzjcoskvf7OBgP77w3O3LYgwwtOK6cG6ug=;
        b=IXvvPAP6KT/sLEiUFrH+4B4JZ9nqOidLMu6icqG51/e1sQV1e80sswRxMEZZR6WNDX
         XHyTdUggPKeuOWPPcpJ5o18j4lJw/E9OqU+ILHiwPQkSTCpUEf9wuIDs1EgSqBk+0NpF
         j1UjdYATJkfalW8F5qVQvNYHxRX3YeUxe4wTO00rOvC9yfuESlGkzTW7GmUk0SMu2z65
         DvMH+6s2ensHv1lIIrkotqfkeAmWgEb9tRzPw4ehbHZyeNLGdOwD/BDaPJtXviRPzeaY
         QolbN1/2kqJTZhp3I1dcO3i46hU9lbS/N1lH3QrPNCRnepazab/PZbspbcF4ykvcJOQ5
         tqyg==
X-Gm-Message-State: AOJu0Yw9zBzTki4AOeCMDqqJ9Ql8cDhAU7T2MTToi6eozZk+CoZIbeuC
	gkn+LZU0a51OGx4YtbQtoEM8Gvwa5PG5ep74ZM2lQiRUbwjM4cF5127OzBokQNiu
X-Gm-Gg: ASbGncszNlTZYxIiNe4CeI8zzZC6lhZdmrY8/ljJjnGyBroCHcbFX6pdtdtrm8ZmJ4y
	LiXuY4w4Y+ydYOPsteb3IPqZWZ/iCGnjj53w39I9Cqt2+bBtZK2Z1kD1jN+9uOyUkZpMEjpheTy
	Tgx/HpufslAajfuccQF1H86x2GKzcLqe5CzKTMWbbw+sn1yI2upLlT+Mik++KLvw1kQc3o3g3Bq
	03hu8/VfpNMIrKCCEoO+oK42U1YTMVYF8ojXcKHuThI0j+ERvUbaZtLYOxpo6WhKaTQy0fX5NPj
	4+sRB/qnl4Y+7nKpfQDOlPfR1dR+puXXj8r4xcobGmvyuhRHKb/2Jxyw8nXH5Cz6Aa9HluYMhho
	G6WCbMk5nhgg93oP7iZIRDf11ZniemPc23tEktCLpVm+sZfoty3Tfe3QeAM+PRXIn8+HbQWnTfl
	9BoXFxSYKiokOg
X-Google-Smtp-Source: AGHT+IGvXnAYBMpdTcBLKvoZdVw2jTMZsdEJ0c0d638hghKxx6Z2PVkrvHSS6tox7+WPdw/tpcLj6Q==
X-Received: by 2002:a05:6a00:856:b0:7ab:8583:9cc7 with SMTP id d2e1a72fcca58-7ba3bb95b6amr5434972b3a.16.1763150754893;
        Fri, 14 Nov 2025 12:05:54 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9256b9283sm6007412b3a.33.2025.11.14.12.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:05:54 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1] bpf: a few missing checks to avoid verbose verifier log
Date: Fri, 14 Nov 2025 12:05:42 -0800
Message-ID: <20251114200542.912386-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few places where log level is not checked before calling
"verbose()". This forces programs working only at
BPF_LOG_LEVEL_STATS (e.g. veristat) to allocate unnecessarily large
log buffers.

Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1268fa075d4c..99d62d765b24 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10720,8 +10720,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 		}
 
-		verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
-			subprog, sub_name);
+		if (env->log.level & BPF_LOG_LEVEL)
+			verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
+				subprog, sub_name);
 		if (env->subprog_info[subprog].changes_pkt_data)
 			clear_all_pkt_pointers(env);
 		/* mark global subprog for verifying after main prog */
@@ -19470,7 +19471,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			bt_set_frame_slot(&env->bt, fr, i);
 			first = false;
 		}
-		if (!first)
+		if (!first && (env->log.level & BPF_LOG_LEVEL2))
 			verbose(env, "\n");
 	}
 
@@ -23698,7 +23699,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 		struct bpf_subprog_arg_info *arg;
 		struct bpf_reg_state *reg;
 
-		verbose(env, "Validating %s() func#%d...\n", sub_name, subprog);
+		if (env->log.level & BPF_LOG_LEVEL)
+			verbose(env, "Validating %s() func#%d...\n", sub_name, subprog);
 		ret = btf_prepare_func_args(env, subprog);
 		if (ret)
 			goto out;
-- 
2.51.1


