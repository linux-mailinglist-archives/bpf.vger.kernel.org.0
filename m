Return-Path: <bpf+bounces-3655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E25D741077
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4041C204E8
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC7C12F;
	Wed, 28 Jun 2023 11:53:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D037BA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:43 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CD730C0;
	Wed, 28 Jun 2023 04:53:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666edfc50deso640260b3a.0;
        Wed, 28 Jun 2023 04:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953221; x=1690545221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD54nl0tOaqxtRArUwGCrqE7+SLaOuUCTBVw8Pj94ZQ=;
        b=Ck/Oyqucls5A2gz6ohWfwj3yUV74SNLKfFiqCy0xl+x2opGjfXkCPiK8Jess2jsUoq
         Qll9g3GIGJfSkDTXiidt9DDXJKM6EQv4EuiXjQv+DDZ8rcror7R4OjvUTw8e+EW18Pqj
         T3prp0A+iiiBs7BfmfNRANdVrTsPLBGlR7VKE+ZZEbLWXpJGOup/Z7o6c9Spo3PhyaCS
         OHLqAOeBqAKDhIJgZNjUUD7dwHNfE0rBe/XEa75lYyBK/i+t/eJmMup5BIcYXN81LLkK
         Hz53chHSQOt5FjNjCRscRNqIbK4OMI6DUf+KUR7hzsE6TSSDoOdcxRBWP9vJRm0dibde
         IM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953221; x=1690545221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD54nl0tOaqxtRArUwGCrqE7+SLaOuUCTBVw8Pj94ZQ=;
        b=KfCCKz/HQq3hyBizadgnG3RLJ4/6FU2KDhObqwfWwKgUgoG/AkmOnX9ixTgrsu/bLg
         N4buURtdltELOlKnEndnp0NSvgGE4/7JEJ21BOnXzigwsqxuT3dSEdlDHNttWe5J7auM
         s5v0mnROjFaYj127S1BMEzsp5y3PnXozyFc5rrid2Q3QvEqRh8bn7vonli7ZZ9TNQ0Ly
         0zv7staRYqCBXXaF1IpvSCx040FC9u0shv/F7y60le1gez2c3tqH7eDiSJKVOOdmv3uN
         h9Qn8I7ICHUqbPnHzwfnraY5LWL87L9ELkQhxw36ZbCN9YTDyI7zeApgohUkfnwrHz/l
         cotg==
X-Gm-Message-State: AC+VfDz/oj0hAorGFuzBRbo5IrxHfXP4UueGdK7AI0jASjSSohvZ9opM
	zxX7EW3hPKGBQOF8AutI7wQw42cEgTRk3JSV
X-Google-Smtp-Source: ACHHUZ6dOWYrmqWXX+3dceqgNI13RhFyDhA2sVh82e9Dy0bRaGjxkY9G4PK/+CpiRe3BWBK/l10Olg==
X-Received: by 2002:a17:90a:c56:b0:260:ba1e:9590 with SMTP id u22-20020a17090a0c5600b00260ba1e9590mr1500061pje.3.1687953221615;
        Wed, 28 Jun 2023 04:53:41 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:41 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 04/11] bpf: Protect probed address based on kptr_restrict setting
Date: Wed, 28 Jun 2023 11:53:22 +0000
Message-Id: <20230628115329.248450-5-laoar.shao@gmail.com>
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

The probed address can be accessed by userspace through querying the task
file descriptor (fd). However, it is crucial to adhere to the kptr_restrict
setting and refrain from exposing the address if it is not permitted.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/trace_kprobe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19a9033..e4554dbfd113 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1551,7 +1551,10 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-		*probe_addr = (unsigned long)tk->rp.kp.addr;
+		if (kallsyms_show_value(current_cred()))
+			*probe_addr = (unsigned long)tk->rp.kp.addr;
+		else
+			*probe_addr = 0;
 	}
 	return 0;
 }
-- 
2.39.3


