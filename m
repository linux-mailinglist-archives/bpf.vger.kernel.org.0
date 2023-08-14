Return-Path: <bpf+bounces-7724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9377BBBF
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 16:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE391C20ACF
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428FAC139;
	Mon, 14 Aug 2023 14:33:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FBBA34
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 14:33:57 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB31E4
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 07:33:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26b51d4c985so588636a91.3
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692023636; x=1692628436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfmfYuK3h1PWtmYdohsUHU5+4gvI6M0fjo7fbdpTz7I=;
        b=g2uYCkqZpoTD4jcO2bcD0TQiKJnOLI4CZBurFbLB916Cn8tq1Xfi3aPZR1CSlT2FcK
         Mt2+IsalXWiNgfqLoJ2UsKIgDfuXPXm1kXsKlRIQimN9e2k4gU1XRzSW/qaDKlrDwxsG
         4mNpsckTMjZPZEwjtXVuXdMa1Gpy3A4C3IPbFSx6GKBDpx/1bTmiIqzDAKG89OBIhgV0
         bxUCy0T0LLiYzA6tyC52iMNr4GZIijoHS/ZSz0lxUv3TDXjbor1nG+IA3khAQNTZTk4M
         PgN2ZZt0XWCvNpRk93L/PoGHz3ar93jI3yuJQXuGWbU+xzPjUn5z2SlbQEXPnotrrfqq
         /GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692023636; x=1692628436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfmfYuK3h1PWtmYdohsUHU5+4gvI6M0fjo7fbdpTz7I=;
        b=Am7VLVB5zzWuIGWY6ydHa90dNomETVLBkljhUjrfy5z38AXBOm51j+1HBt8dL85kBI
         jJFx+vc4EO+MudD7Uypo2sbQudjAd/CQcvhIjq3zyLVvhFLp6nH1sQ0/SERDNjPltH2J
         dh4tOODKyLHf3cdEJVXdH0yyuUydjAH3u+5gLWqy7U50r7MhiJtq2LH/iW1H68FZqPUW
         rf1w4alupxTnPhLqyUgnlGwcmfhzJeSPmK1Bf+yP5qcWfAvRPfbMzH8fhyRHnFRVLsfj
         CLhusFsKvTIF3TNKxK3hrBMaWwdWLVHgtNPG1AM8A2ba0K8N2ne6kfAuhv4j0rVr2LKN
         niAA==
X-Gm-Message-State: AOJu0YwEFnsiE6+D5FNz2s68GmeAFk/R9w5WseyGmjkizZeGDFSLlyBh
	/BYNmFNUP8WgLtfLFnxV8u4=
X-Google-Smtp-Source: AGHT+IFpHhdkMyFLONbLvcR5AqtEfQgR7VeOhXl8SxCE1FqouAwF8UlvWOwMhF4SBfSFc0svxQ/8Kg==
X-Received: by 2002:a17:90a:760c:b0:263:f7ce:335e with SMTP id s12-20020a17090a760c00b00263f7ce335emr6785987pjk.43.1692023635590;
        Mon, 14 Aug 2023 07:33:55 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a031300b002677739860fsm8640390pje.34.2023.08.14.07.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:33:55 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
Date: Mon, 14 Aug 2023 14:33:40 +0000
Message-Id: <20230814143341.3767-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230814143341.3767-1-laoar.shao@gmail.com>
References: <20230814143341.3767-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new bpf_current_capable kfunc to check whether the current task
has a specific capability. In our use case, we will use it in a lsm bpf
program to help identify if the user operation is permitted.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb91cae..bbee7ea 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 	rcu_read_unlock();
 }
 
+__bpf_kfunc bool bpf_current_capable(int cap)
+{
+	return has_capability(current, cap);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2456,6 +2461,7 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_current_capable, KF_RCU)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
-- 
1.8.3.1


