Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C06C9369
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjCZJWZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjCZJWW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:22 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793B5BB1;
        Sun, 26 Mar 2023 02:22:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a5so5875433qto.6;
        Sun, 26 Mar 2023 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1Zf6mBo0BAcs/anjiNOAvLM/6WnwvWROkn3ev6fwzU=;
        b=Xny1OUglEPhpvieEbLz2cvRjjAo5MlD0Obh5seAAppIv9GfutRhWTPb3tufsXZ53HN
         Yx7a1Uc79EAcYyoN4mTwOOzN5+508MyW09h2B5uau8cRtgZvtFz6pBpdIKBgUjjRPQo8
         9ylDg4S6pkddVF/NEvDaFoPvAFiDK29IqcMvXyMmWp0xTMQoeUKLayA/YbQ/juEry+Rl
         O5MRw7j66yPLjPeHE2IbpwWAl9HiPQbjd5ZFTBH9aVR2d6i3TouSRE+peWBap7JP2GYX
         RpgoHp2Q6M2cYXQgnekplpEh/isWECLBxnXZUhXeJkfYtWDZ3XqSG5Xulh9KpfZi3JUz
         9XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1Zf6mBo0BAcs/anjiNOAvLM/6WnwvWROkn3ev6fwzU=;
        b=ppFgc9aXn54xsrG/aN8/ZQ8QWSyg8spoIHiCrz4XeHCgDR3Rvj7UQEUyE9TL2rU40Q
         IH9cF6o7aVBA7d1uBdH7BhzquaMzjjjT9E4EU+nbiHZtF9USyOBbSE4F7/KOgCXvSAvi
         V1yukz/xEzxaNhur2qKw4IdmWxC/t4SVy+BOf3MCF/gq6FSB6SBnn2c89KNS7TBKCBB/
         ecGA3DtOuG8WMsJQG349Iq+KYj0S15yp6hzn0bkcd44rxwkMN3MgSkhQR1HaOre90lI5
         9azKfrhhrEyRoFFQ+LATtKeon1cRmE0Bq8o+/Tvu4u6Y32KVIKbCLl1WvG3Zz8Y6FSYH
         e2jQ==
X-Gm-Message-State: AO0yUKVyXjH1iKMfrYlk1WVyJSH5hdIlfQ6PErL/S2GY8VPwhJPf+unh
        Px26eupC66UZtagFIHWOlmU=
X-Google-Smtp-Source: AK7set/Mdsbpbyyu1gXXbwRaNg6VaZ5oBPUNVmPZTuM6CJhHyddJuTChzPQfKcLO6345fEsLP2qouA==
X-Received: by 2002:ac8:5c16:0:b0:3df:50ef:fafa with SMTP id i22-20020ac85c16000000b003df50effafamr14597478qti.4.1679822540545;
        Sun, 26 Mar 2023 02:22:20 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:20 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 04/13] bpf: No need to check if id is 0
Date:   Sun, 26 Mar 2023 09:21:59 +0000
Message-Id: <20230326092208.13613-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

idr_alloc_cyclic() will return -ENOSPC if there's no available IDs, so
don't need to check if the id is less than the start number.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e18ac7f..f3664f2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -387,9 +387,6 @@ static int bpf_map_alloc_id(struct bpf_map *map)
 	spin_unlock_bh(&map_idr_lock);
 	idr_preload_end();
 
-	if (WARN_ON_ONCE(!id))
-		return -ENOSPC;
-
 	return id > 0 ? 0 : id;
 }
 
@@ -2032,10 +2029,6 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
 	spin_unlock_bh(&prog_idr_lock);
 	idr_preload_end();
 
-	/* id is in [1, INT_MAX) */
-	if (WARN_ON_ONCE(!id))
-		return -ENOSPC;
-
 	return id > 0 ? 0 : id;
 }
 
-- 
1.8.3.1

