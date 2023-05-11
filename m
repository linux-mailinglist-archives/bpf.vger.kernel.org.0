Return-Path: <bpf+bounces-336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15D6FF42D
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180711C20CAB
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA71D2BB;
	Thu, 11 May 2023 14:26:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C01F922
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 14:26:47 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4AC1161A;
	Thu, 11 May 2023 07:26:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so15770603a12.2;
        Thu, 11 May 2023 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683815194; x=1686407194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MLvCJECEpiR/gI61O4GG27R/3uA2bLpDgI5SluFLTA=;
        b=N68pkqzbvbgbZoltAtubUv7rw9JDXyqdkHGdeKmUKjGpn+E5r4zpUDvVnJnAQ8q/TY
         nswT/PA0t6FiilhbAjs2ZA920mxwXyD7SPZTe7HZNbzTny4MzUzAmNvhHHV66wy8snLx
         133de9nuoDoyUqThzedi9BsiMhYhtTdzwgVSciKF5qTuT6oJJsuGF27/VMHe0X56VIIk
         TwicLhuN0EsOIppLFg+9pJM4liuIKAxwv8n5eVI+mkQNQ2mlq7LvRyBDbf8JRgmqTfO7
         lcYKKtolCRyYdFmOIAklkRShS3Ku0tT6icHA08d77cjRjtZaOJjtu2NwGCVMoJJKg9E7
         ZhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815194; x=1686407194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MLvCJECEpiR/gI61O4GG27R/3uA2bLpDgI5SluFLTA=;
        b=bQeLQbs/hGeQuIf7/9PVgM2IAje2zH8TKSITp0UdE3zE2DwvMRneblejwZCsnzu28w
         MHBhYxbaIcwl2Lgs88dHu9i62qmVlYznHhEi3Wf+02h13ragHeNq8zl0Z4weEpyzpLn5
         5kg+kOpv64Gh1srARmIXiQKmrfcZksGpgnHxuaPsOMhx4bSRmilFx320OcacfrTWxST4
         ap8IZ80kxHl6Wr0XmZXd02p6Hd5Y1niYMj/XSu/gyxJx9NjRUqI4d3BXYUzi1QGd31fa
         f8eXJuJUamhquCnPwmHxvoNpTCFfBGwtw/Xd1XQwhvQih97HwUJTbtrbIqT91ssWJhwK
         bn+A==
X-Gm-Message-State: AC+VfDyGMDGgV5k9ee9OajuoUKh/xQTtC3PNDLcfuGr3pgx5N/VTuGkO
	tYuaJDnDg4GMjEHFcnYtw3d9ZY2VqnXmhw==
X-Google-Smtp-Source: ACHHUZ46hOkfDQhmJnGL2G54E94Gis8MlvJwgbU2cj9cJ39h0TTPpvN63Du9gpl7pzhrlXMK+ihZEg==
X-Received: by 2002:a17:907:868b:b0:961:57fb:10c1 with SMTP id qa11-20020a170907868b00b0096157fb10c1mr19859592ejc.63.1683815193736;
        Thu, 11 May 2023 07:26:33 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b0094f58a85bc5sm4056647ejc.180.2023.05.11.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:26:33 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Alistair Delva <adelva@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Serge Hallyn <serge@hallyn.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 4/9] block: use new capable_any functionality
Date: Thu, 11 May 2023 16:25:27 +0200
Message-Id: <20230511142535.732324-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511142535.732324-1-cgzones@googlemail.com>
References: <20230511142535.732324-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Reorder CAP_SYS_ADMIN last.

Fixes: 94c4b4fd25e6 ("block: Check ADMIN before NICE for IOPRIO_CLASS_RT")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
   rename to capable_any()
---
 block/ioprio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 32a456b45804..0a7df88bf6d9 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -37,14 +37,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			/*
-			 * Originally this only checked for CAP_SYS_ADMIN,
-			 * which was implicitly allowed for pid 0 by security
-			 * modules such as SELinux. Make sure we check
-			 * CAP_SYS_ADMIN first to avoid a denial/avc for
-			 * possibly missing CAP_SYS_NICE permission.
-			 */
-			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
+			if (!capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN))
 				return -EPERM;
 			fallthrough;
 			/* rt has prio field too */
-- 
2.40.1


