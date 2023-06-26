Return-Path: <bpf+bounces-3464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389A73E391
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6431E1C20859
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1C7C2EB;
	Mon, 26 Jun 2023 15:38:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF071C2C1
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 15:38:43 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E31B10E0
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 08:38:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b7e66ff65fso18603305ad.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687793921; x=1690385921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxc7Z+HEQTXBc9kfkLcvEGnJAkCr5DkjbEGDhT82zEA=;
        b=hahqqF0HKYT73VoAmAW/h+Z1Ow5UkDUZDzo5LNE1/aDSgJzLjGrQWa2R98mYK+5YWz
         rRg5fpvHk5Ul6WSQjeMBvXoq+slrDu9hAyH75VMIEhDXn+vKx/sIuoS/KDcb7mbxIh8b
         qy0Y9OCd3EJN5doLbHgCFf8vDkb/4GfYeGMvxpTpJaCGxAmeRcKgbgSzNNFfnL8Rzj3G
         MbwSmMyd/aEE0LY0DBM5XI0Yo1b2kbH52auhPPHH4Tt4yp90sZXHhb5amabg5NyJpx2n
         2w2GhoDBGX3QaZqHGU4iYOqEyzq4h44MEHWd9BMIeo/V73pmxiFfLZUIZjxu5mYj/vQS
         rEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793921; x=1690385921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxc7Z+HEQTXBc9kfkLcvEGnJAkCr5DkjbEGDhT82zEA=;
        b=Fq6dxrYF7glKM0Gv8uuy8ipdG+lRVCVc9EL6Z4HK90vjDZUO79jBnyR9x1KKIizBsa
         lk967ED8IGwRcnmt+DTqWlFXZhuaPNkduvjzMP6wab/UBAnPM92IqPUWcjRH1k04VaaU
         oroXAQpXaUv0hB1HZw2GIJfSFI+96v2kUP1xBw1d1rzNJVdbWfvn/T5sUI+89V4ZzyJh
         J2rOZzZxYMSF+0Bx8r6GFSvARn32q6uhuFwnHFUOLMCRA+3Ur4hKfvbDDAk9SZkzolqn
         LOYsZSQ8qzCnFDXTYQrUOpay1fg/PBMFKIoqST+vgrGgRTBP4N6aJWrFp/+0i3jo7UBg
         0hkg==
X-Gm-Message-State: AC+VfDyeNupZUrVlEkqChY78zxPV+q8sYD3xdfORmC6u8CgS2x8YTbgZ
	hzmhZ6UDaQQLI19cWhI5H6BjH7aEzOQ=
X-Google-Smtp-Source: ACHHUZ4NwZyx4nv/7Um0sp+EmQkimI0sVXt1Ta+eN0t3+LiJeS7tuDbXQj5dvWk2svX0EXg3/eNyeA==
X-Received: by 2002:a17:902:db12:b0:1b7:4702:5b67 with SMTP id m18-20020a170902db1200b001b747025b67mr9007521plx.15.1687793921314;
        Mon, 26 Jun 2023 08:38:41 -0700 (PDT)
Received: from carlos-desktop.lan ([2600:8800:7280:a54d::813])
        by smtp.gmail.com with ESMTPSA id m23-20020a170902bb9700b001b1a2c14a4asm4363673pls.38.2023.06.26.08.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:38:40 -0700 (PDT)
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
To: bpf@vger.kernel.org
Cc: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
Subject: [PATCH 2/2] libbpf: get num cpus sysfs path only when need
Date: Mon, 26 Jun 2023 08:37:51 -0700
Message-ID: <20230626153819.134831-2-carlosrodrifernandez@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626153819.134831-1-carlosrodrifernandez@gmail.com>
References: <20230626023731.115783-1-carlosrodrifernandez@gmail.com>
 <20230626153819.134831-1-carlosrodrifernandez@gmail.com>
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

Signed-off-by: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
---
 src/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libbpf.c b/src/libbpf.c
index e42d252..a2133b5 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -12629,7 +12629,6 @@ static const char *cpu_topology_sysfs_path_by_type(const CPU_TOPOLOGY_SYSFS_TYPE
 
 int libbpf_num_cpus_by_topology_sysfs_type(const CPU_TOPOLOGY_SYSFS_TYPE type)
 {
-	const char *fcpu = cpu_topology_sysfs_path_by_type(type);
 	static int cpus[NUM_TYPES];
 	int err, n, i, tmp_cpus;
 	bool *mask;
@@ -12638,6 +12637,7 @@ int libbpf_num_cpus_by_topology_sysfs_type(const CPU_TOPOLOGY_SYSFS_TYPE type)
 	if (tmp_cpus > 0)
 		return tmp_cpus;
 
+	const char *fcpu = cpu_topology_sysfs_path_by_type(type);
 	err = parse_cpu_mask_file(fcpu, &mask, &n);
 	if (err)
 		return libbpf_err(err);
-- 
2.41.0


