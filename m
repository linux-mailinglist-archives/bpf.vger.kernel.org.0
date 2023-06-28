Return-Path: <bpf+bounces-3657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9674107B
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1984E280DF9
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA2EC146;
	Wed, 28 Jun 2023 11:53:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE3BA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:46 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EDE2D73;
	Wed, 28 Jun 2023 04:53:45 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b0249f1322so3391030fac.3;
        Wed, 28 Jun 2023 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953224; x=1690545224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dm7pO/6+qxvPQQpsQkwQoR93+im/Lo0h88DmF+ABvA=;
        b=U7J8fVp398GAWteiO7JTBXQZHvLFEOTG+erYy8n/5dg6R2Y2LVvzBCrfiyCQD3c4l5
         QSzgP3V3RxXAxLeKzK8UUjqE5OW/QBwE5FJksCNphHvJPC7WIHtP5ShiHv+OqSryP4ls
         OyIxP/qMV7st8DVSK4efsKd/Tbgr7A1P4WNIltv+H9HCkXp1tr7L2VxUx2S2t6lMHZNL
         AWDoYMVm3ZpVlH0SC3t8YARb+pyrwpmsEv7ejJjBg4gk6DplUtfwZs6Or/I/GcdW+ebb
         M8cFt6qv7m12iPYJguitoRbhL1Vj0/ji/63oUa0Vgl1FVWJtpeXnWvTRdLAnl8d6WCfV
         diLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953224; x=1690545224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dm7pO/6+qxvPQQpsQkwQoR93+im/Lo0h88DmF+ABvA=;
        b=JGQ3ALSuyGhfdYTgIGBhk3GiKud+XYRh0A/aSkWudEyahplEOVxhvND1aRkueHJGDe
         TsWs+2ZjhoiiFeGTBUF+a6dEfTfHxg+YE5/8xZpvxfmcVaWtSGPaAM3cj8VW/Dld6Zu3
         Vi/YOkcBEK+q4LbOAG0PMJPQZUcenJa3Z1M5T9Fo5kYztnrUX/PSkG6Q8vBdKkXmPxXl
         A1eqTiMYYL6kZAIxtHY58oe7y1ZCOVzzQbqRu0k8UICcqCjCMCS+mMqorTt17DS87Lbm
         o1C4pcLluZZj2BPa8MHXsDpe5SE+4+jobwEy3/wA0dw3oaj8bL6WbyhDeYbjUAbKKERG
         GOHw==
X-Gm-Message-State: AC+VfDxAXcN7aVx5sbvgAOL4sn44yvpg/6I7kainZMRlj46HaOuAZAL6
	ITl4LswvePqGzm2y5e0Pvqc=
X-Google-Smtp-Source: ACHHUZ5rXVONLDPnfmFRutS6OSqlIbi4t+T4OwL8iUMPdKJJLR1T+fcZIg3IVETVxpmWf4wrPwpMdg==
X-Received: by 2002:a05:6870:e353:b0:1a6:d839:928a with SMTP id a19-20020a056870e35300b001a6d839928amr23174323oae.8.1687953224602;
        Wed, 28 Jun 2023 04:53:44 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 bpf-next 06/11] bpf: Expose symbol's respective address
Date: Wed, 28 Jun 2023 11:53:24 +0000
Message-Id: <20230628115329.248450-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since different symbols can share the same name, it is insufficient to only
expose the symbol name. It is essential to also expose the symbol address
so that users can accurately identify which one is being probed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/trace_kprobe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e4554dbfd113..17e17298e894 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1547,15 +1547,15 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	if (tk->symbol) {
 		*symbol = tk->symbol;
 		*probe_offset = tk->rp.kp.offset;
-		*probe_addr = 0;
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-		if (kallsyms_show_value(current_cred()))
-			*probe_addr = (unsigned long)tk->rp.kp.addr;
-		else
-			*probe_addr = 0;
 	}
+
+	if (kallsyms_show_value(current_cred()))
+		*probe_addr = (unsigned long)tk->rp.kp.addr;
+	else
+		*probe_addr = 0;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
-- 
2.39.3


