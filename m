Return-Path: <bpf+bounces-1661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12AE71FCBC
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 10:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729C31C20A9F
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB5168AD;
	Fri,  2 Jun 2023 08:52:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D214266
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:52:52 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04041712
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 01:52:51 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75b04e897a5so203405285a.2
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685695970; x=1688287970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuzOX4XFKmJOiLjt9d1z+UYL8/sI/TO2hkUeE9dOaVY=;
        b=LVD7CSdNnL7X02JLfuOVQ4+gw4VcarH4cp/1Z3rRjhG+rnPnAb8C8VSXOljDgPFrtP
         BW5YeGOUshi9VPlm49dnU5lWcHCQAJVflylJCaJnHXMAwswgLLc2/Is1/Nqky3QLQWQH
         dHPuKFieY7JIMEEQjKKNLjzEktj+ZQRseSk2NcPWVOr3MdSA5WVmeMQSxzQ9JO8WqWfr
         +W1qYkXjv1sH0UeLnI9MxG/ZkuknIdBwwTxa4SJ0tdf/ToBhQedMzW2056ch/ByyAP40
         +O/dvovzG5sLVjlz6kLIU7CaOhqPkDWwp7tpzYbfzBtXz6OPHBcaLB0+6TOQ/bJfUyNN
         hTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695970; x=1688287970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuzOX4XFKmJOiLjt9d1z+UYL8/sI/TO2hkUeE9dOaVY=;
        b=XMU/0PLdoQxebKqWNxtQjWR7YY0QUT23m/JWtVP9yIoXbA7Oh5BJGohg80u0MP96Si
         mT2y0Ze01galrP/CwgYpive5gmb5HQB50a/swjendQFUtlNNnna0rg+vt0S9ABalCn+U
         Ku1lI7c83WscdNEJ0Ld4m+flg++x7uKtruoRTFd10K55vkvq4j1Hw5e18B2pEoJM+xcQ
         ehLW3LWcusx5VwC1SiytURsjWGI4A07Oun0hhyxnoGBs8r99859i1Ko+sbE5oJPIbIP6
         NLPZop6CNzFdMcJ64Yo3a+V5WuWiT/outfOD0vz01yL785rq1xnqpISsq4i5odby8wCG
         kdyQ==
X-Gm-Message-State: AC+VfDz1QVQQL8LaLAO4obHbC85DZ7VEDvm5iy+apzKWOnREBoFIiDYf
	BPjPKzb/WBk1zRUi0h5HBZk=
X-Google-Smtp-Source: ACHHUZ6n4s0wClGcQ8hYIIRNWI8mGYD5Ncf6q/MfzqH0H7hvLVsQHwn+QL8KSJYwDkWnb7NzW7TP+g==
X-Received: by 2002:a05:620a:8a02:b0:75b:23a1:35fc with SMTP id qt2-20020a05620a8a0200b0075b23a135fcmr11178123qkn.13.1685695970383;
        Fri, 02 Jun 2023 01:52:50 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5401:1e90:5400:4ff:fe75:fb5d])
        by smtp.gmail.com with ESMTPSA id b123-20020a0dd981000000b00565c29cf592sm289828ywe.10.2023.06.02.01.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:52:49 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/6] bpf: Always expose the probed address
Date: Fri,  2 Jun 2023 08:52:36 +0000
Message-Id: <20230602085239.91138-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230602085239.91138-1-laoar.shao@gmail.com>
References: <20230602085239.91138-1-laoar.shao@gmail.com>
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
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19..a7a905a 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1547,7 +1547,7 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	if (tk->symbol) {
 		*symbol = tk->symbol;
 		*probe_offset = tk->rp.kp.offset;
-		*probe_addr = 0;
+		*probe_addr = (unsigned long)tk->rp.kp.addr;
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-- 
1.8.3.1


