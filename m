Return-Path: <bpf+bounces-2411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268272C99F
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410551C20A5C
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F5E1DDCD;
	Mon, 12 Jun 2023 15:16:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE019511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:26 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B2810F5;
	Mon, 12 Jun 2023 08:16:23 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6261a25e9b6so31982256d6.0;
        Mon, 12 Jun 2023 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582982; x=1689174982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyYbQyqyiVM9g5n2rww2bISilT8aqkXPzSI5XyPezvE=;
        b=mNdCtj9HTCNGVDB4wtHyVm0PHnFgjWUZ0vWch1QTpbs0DvcxGmgOe66cb1MmjOKP7i
         PsadeQXCo7hGRbliJjrAxYW7/GnItLVLvHmyb5DmaNRf0eEPLY+sRIUyisbTxGW3zzHR
         cZWjPS6OJgEIIkrMmVEpG7zpGUu0iWgsxkzfb9z31/6yU/+cigFOHGAh9GwoCbwpFEw9
         aehLs7jHNvqrPCR91L3fCx1K5qgfe2OjX0648F2Uh/K2qK7pTpgO96eCEc85BGrNCwFV
         3Fd288aAzzNOqm3SHWJLgNaUeH3Hqa8JZsexxWM4cCiMMwAI6HnQXCWAo505kIzacJQ+
         rHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582982; x=1689174982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyYbQyqyiVM9g5n2rww2bISilT8aqkXPzSI5XyPezvE=;
        b=IcuOKaIDdi+kII59KH2Wu2pXCKOsg5JYLrvSzyU/trCqR4zvQm6ZIz0sjYxm+ODWTI
         CWIl83Z7NetB5GXzk8DP20d1L1BiG1q5swqASCyOHKmRR0Qq1Nb2mZiIW9ksjQ0DS6kj
         oSZUw3pviUzHwADhkGQlgMTtQrzQqQW5vfTVBGE4qeQ29jjbwLveV65KmxuG2+ZYeaSu
         R5fTpWe4K8/MaagMphXgv39FeJysZS1TPRc57q35wVtpSlnaI730yaUlqgX2hUHmuiA6
         l5cDpG00CFVeupk4EHA10Sy6TJarRUg6fyUrckFKR2jkLdH9G1H1anXVKaxgeNfJOWMu
         oThg==
X-Gm-Message-State: AC+VfDy01P0LPeqtOTVWCN7at3wmA5z+iICQN8TjcwiHuL0sx0bh37Nv
	H3QxxPUoPF0u3ETMUI+Yqlk=
X-Google-Smtp-Source: ACHHUZ7Ogx6+gYEyYuqUe7NK81bKuhCS0jLXpZ66kiJDgoEx8VCB2hFP64/nANJywQa3ydHBBTgcQg==
X-Received: by 2002:ad4:5dcf:0:b0:623:6b1a:c5f1 with SMTP id m15-20020ad45dcf000000b006236b1ac5f1mr10751548qvh.4.1686582982512;
        Mon, 12 Jun 2023 08:16:22 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:22 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 06/10] bpf: Expose symbol's respective address
Date: Mon, 12 Jun 2023 15:16:04 +0000
Message-Id: <20230612151608.99661-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230612151608.99661-1-laoar.shao@gmail.com>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
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
index e4554db..17e1729 100644
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
1.8.3.1


