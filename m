Return-Path: <bpf+bounces-2106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DEF727CE9
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77C01C209AD
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4AC2D2;
	Thu,  8 Jun 2023 10:35:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BFC12D
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:44 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C8A2113
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:41 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75b3645fb1fso108665785a.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220540; x=1688812540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj2TwWknXJwXQfH/U46aiBj+aCjwmGpqTDR3ryEZBYM=;
        b=AAkeq/D4CRCW+BArBUADS1u1VE2yj35/BFDnk4TrhYIS0vswf6Nq8YUeLlu1BQF9QI
         k68ZhJFEIxRD6vq1ASIoihlv3p6KsjvIXW+eJP2iVXRtK4lZrh2DNmkzBW25NWt+N5Xr
         SCk2Ic+N7UwHrbbhnZNf9fjMJOvgkgs5Yq2FzJ3UaGoq3YCucTFa4ICIyUJeWNvKGeaw
         npydQ6rIwBD1cWDKKgEGJggpOOzijcsay9m453RAJsXLN/cWp2jQ9lxEJuo/JA/i94kZ
         o2w2hsfTM2t7nEK+XQ6Gq3DhsCB32eXD4i4hHAHni0gz6V+zee2WyeXW0Ie6OmTt1rwr
         Y1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220540; x=1688812540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rj2TwWknXJwXQfH/U46aiBj+aCjwmGpqTDR3ryEZBYM=;
        b=eyb1hAJITJjR9HC66PaWFaYcrKbasU8S/1IyToSJ1ZB0pCcVsIgAKGTxCIxo0h2VNE
         hC12ANggfQgnG5YezyE2vS9IdoEklW+kkfDwsE42QqluqZNmuGFlKB1H+hwuiZaE1mjf
         GZJR62ELfZPJXRzz3c9Rf20cKZB2d+GPaqhyDnwSUbg9vNrwhuyoCUz+Dd+gGXVDhgDp
         woiZVVr24VqF4aXz8g5UbqifnhV8NFwH8j0jn32uxX0tLlf/3frQRBZPPg4WgCkAjL12
         YZ7CFjdr9lCzhbI6ou+ouh7J02oOlRJIUzJrGoGI2dzUKEGH/nXsBMcQ6WThEqP88SH1
         Atwg==
X-Gm-Message-State: AC+VfDwUucRmtZBP+E1Yr8dG0VcCJrbo5duigOVKiR9iJm8TXDDtYO5g
	Wwubq7WeMEtIAgOrsngloAQ=
X-Google-Smtp-Source: ACHHUZ4FgrxALPq4Mu4ZgnbEltCMKt0s971K5B22AtLRViOupJE3FzMEPh62XXhWVTxXBYQDJQHFlQ==
X-Received: by 2002:a05:6214:2a8f:b0:62b:6bc5:7a1b with SMTP id jr15-20020a0562142a8f00b0062b6bc57a1bmr866047qvb.15.1686220540107;
        Thu, 08 Jun 2023 03:35:40 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:39 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 05/11] bpf: Clear the probe_addr for uprobe
Date: Thu,  8 Jun 2023 10:35:17 +0000
Message-Id: <20230608103523.102267-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
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

To avoid returning uninitialized or random values when querying the file
descriptor (fd) and accessing probe_addr, it is necessary to clear the
variable prior to its use.

Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 738efcf..0cabd2e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2372,10 +2372,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-		if (flags & TRACE_EVENT_FL_UPROBE)
+		if (flags & TRACE_EVENT_FL_UPROBE) {
 			err = bpf_get_uprobe_info(event, fd_type, buf,
 						  probe_offset,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
+			*probe_addr = 0x0;
+		}
 #endif
 	}
 
-- 
1.8.3.1


