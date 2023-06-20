Return-Path: <bpf+bounces-2933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE6273719D
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A302813AA
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDDB18C36;
	Tue, 20 Jun 2023 16:30:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C618C10
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:30:26 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC292172C;
	Tue, 20 Jun 2023 09:30:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25f0e0bbcaaso1336121a91.3;
        Tue, 20 Jun 2023 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278624; x=1689870624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzAEwWz2g31UMs4g4MUixj1iNbtJ/dM5TZGhqlQXR9c=;
        b=UQ6WFD4h9OxD0y4f9f3LdKVC6o2VYevQHKIdBZBY9ZsUWR0wlgh+hJFK7TFmZHxh3P
         5FmQjvBFlqgfg6B8OQLMLZb0ZJyuAthh38Y/k4FxqZJiBpfL9titLy73qAFOC+a+5dCJ
         Ulvyxi08lUcpnzw44NJRg1Q4n4CJPgJygHBjhJ0dcgW8CFFJ7oyOzdwmKkueUdfLji7R
         Q4OeI3PvjxGfi2CbSz8B34J+p5qIT0T5GowFiGJpUrZpqzWdogBxIb+Rc54qixkTpKEw
         PYCSEESKzutUXkwmc6NcZ/XWPupCooEEX6D/NQymlPDq7BVE+bkHupZ9y5/fGmflM7tc
         khVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278624; x=1689870624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzAEwWz2g31UMs4g4MUixj1iNbtJ/dM5TZGhqlQXR9c=;
        b=dnp5mxahvONCD1BIpQejKgzY58xpyJxtf8qtdpxL5z+/Ie9hVw3k6Ag9bbQzcFr5BH
         hF6k8EKQaj60UEodFulHe5Zy/WlHZY/UjgWOUautvfvp0GJKpb0B73xFtbIxhJZVk35q
         l9fYZATrI62oY0/yMmYTjuzeD4WLgADMdggQnyneNv0Jo2DOX/vMH9lRL9Yi6vRztTLN
         z+7kViw2i1/3r46YPcLF1PX/6l0/skUQcTl57XRoe5EtydwxQ4C9Zz8kiMlkRxeXJ0G2
         T3ig9CRC2Xn51ahgi5A3+pi8fH1rvxyHTFus40/VWYSvm15KumRUdM6N+5/vxVgzAbHY
         ycRg==
X-Gm-Message-State: AC+VfDyxnROwYVqXia6R2DoWbcfozGV88seEPtSW/y2CuX6zofSpT2Hc
	1TTX+ZBwho7lvzjs4NCHUPI=
X-Google-Smtp-Source: ACHHUZ7C0y/gigQKKulCdgk5D0IrXKAkn7+AtANMzbaiQVx00e4ZZnlvu4oc7X76Z0zcZ6Z9o86XhQ==
X-Received: by 2002:a17:90b:30c9:b0:25b:bff5:5310 with SMTP id hi9-20020a17090b30c900b0025bbff55310mr7291590pjb.14.1687278623951;
        Tue, 20 Jun 2023 09:30:23 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:23 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 04/11] bpf: Protect probed address based on kptr_restrict setting
Date: Tue, 20 Jun 2023 16:30:01 +0000
Message-Id: <20230620163008.3718-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
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
index 59cda19..e4554db 100644
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
1.8.3.1


