Return-Path: <bpf+bounces-3011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12870738285
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440601C20E3F
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98B156D8;
	Wed, 21 Jun 2023 12:01:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C53101C5
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 12:01:00 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B967186
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 05:00:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6687096c6ddso2106517b3a.0
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687348858; x=1689940858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XltwABZwvFGvcE/kHIXKv8G9X5d8eGE/UDYTIJZIVTc=;
        b=B2evHurfBynR0fvitAmIvgXoG+2IxXK7WtBYNI+IoJQ+lkmvl++HPfhE+txCZquGyl
         2Az58Ox+ZbLYzGF1E87u+a6mdEpf3QASJilmCAMlMRWKPxeN7ocjCWf82+zn8wkbhz0a
         lxYd9xRXsWeLFL3z1jpNBYPBqV2fuQHbdvWaBARTz8P63QYp3bxiLr3p4wmzydQPHFQV
         hxuWbVKE+kX2O77TkuQGUNHtxUhukjU0XLXEEWgTD2MunxSsb/HcCwG8F7OU0rQthD+c
         B2DQl0qxB7VzKGUuJPScZdwScoPvGmyNkFfB9vuiTperMXwoY2DLEquUUL8vgDW9n7+S
         6XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348858; x=1689940858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XltwABZwvFGvcE/kHIXKv8G9X5d8eGE/UDYTIJZIVTc=;
        b=HV0qRTEuV1ctIc6yg70u8v+oZHjPXdhebbwaxyhivY9xRI86cWwvRnLB2y82WSRWHv
         75u0+pwykpsYIIDeiJx33n3RURzOKALuw6lR7Iu7k96n/z9PaJ4aF2wiUOnGFUBk5uoH
         x+yqEPHVtIdpXq72wpz5TsU/sWP6pRwKjKpHdeZDgDJ6MihyrMpaDEafrE5x+oDqQkJ5
         2lAGqFq/f43FW055OIxB452v0pNOBus3NQq2yTTfxcDhtWPQGOfIl2SxzGoV4vKumXy9
         dDame90TMDcr4NZoJB1LAwm1CxvKo3LvNOdBi/rgBcNX+/MyPbZ+iwKMk28PTOaoQkfv
         16Ag==
X-Gm-Message-State: AC+VfDwXLfcrN6gy4gT0QE29B64L/EgWgGcceNqN3JOJeJP9IKjidnn8
	yYpsMzZYfdqVi/R/G9ayN6E=
X-Google-Smtp-Source: ACHHUZ5Z8caOsQKUkP5q6+mK13fk+WHfE3tW7iYtAz8TSFOW0dsdMxqtYl1/CzC2yxjjJR4zTy7mGQ==
X-Received: by 2002:a05:6a00:2e8d:b0:644:d775:60bb with SMTP id fd13-20020a056a002e8d00b00644d77560bbmr12921611pfb.20.1687348858021;
        Wed, 21 Jun 2023 05:00:58 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:32e:5400:4ff:fe7b:7461])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b0066887dc50easm2810620pfi.3.2023.06.21.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:00:57 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next] perf: Add perf_type_[uk]probe()
Date: Wed, 21 Jun 2023 12:00:41 +0000
Message-Id: <20230621120042.3903-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230621120042.3903-1-laoar.shao@gmail.com>
References: <20230621120042.3903-1-laoar.shao@gmail.com>
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

Add perf_type_uprobe() to get the perf_type of uprobe and
perf_type_kprobe() to get the perf_type of kprobe.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7..79dbc70 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1881,4 +1881,7 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
+int perf_type_kprobe(void);
+int perf_type_uprobe(void);
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index db016e4..075d4fb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10456,6 +10456,24 @@ static inline bool perf_event_is_tracing(struct perf_event *event)
 	return false;
 }
 
+int perf_type_kprobe(void)
+{
+#ifdef CONFIG_KPROBE_EVENTS
+	return perf_kprobe.type;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+int perf_type_uprobe(void)
+{
+#ifdef CONFIG_UPROBE_EVENTS
+	return perf_uprobe.type;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
 			    u64 bpf_cookie)
 {
-- 
1.8.3.1


