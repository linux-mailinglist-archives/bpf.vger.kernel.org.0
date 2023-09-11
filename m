Return-Path: <bpf+bounces-9685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C9079AB17
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 21:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A304281287
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54E15ADA;
	Mon, 11 Sep 2023 19:47:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94A15ACA
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 19:47:36 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37CA1A2
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 12:47:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e8bb74b59so4831961276.2
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 12:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694461654; x=1695066454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Robs93eAoqMN/3G2VLEnNwo2y4CH5jznTkw9WS7BNTQ=;
        b=fla/hC5ywxI7pyKmixgtSeZKJyuWNJInSbzqYkPE/k+nOaf0xxXhctmH1qem+M1fEC
         29X96oGk0RyvwXmVbXmY+s50BCjbKa08n3zBz5p20o4VK4ptPQTDM4DTF0ZcH7l/Q5LO
         mlTYBYKfrcxrCi7ld+ouxTX4r+2DE0M3//3wIux/a8KLwi2o9+p6bKuOMBBaDPgmoZ8r
         R4kRtHF1hxSRtVWwHojY2A29li1Yag1nelW+MQoYbtF2f7dIhLK1XY8BJo7vPFcdVVs5
         BikUnN/XwC+wnHzxOklnye2ObPa5gRe2fSNY60QpP8bP4Or725NH791SV9tVr8ZNxlLP
         Bm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461654; x=1695066454;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Robs93eAoqMN/3G2VLEnNwo2y4CH5jznTkw9WS7BNTQ=;
        b=JRXRDxPYysidRZXm/C4Lb2ax17ERGHc7jjEWigwR8dxnN/WnrtFVhiafT3AkHH/trm
         uOjoOdgtC0G7tgPE7LVxF/viB+b/lTCF/FUAJ45Zu+u5eo260YK3gziESoIuJhuBN1Am
         PiMqH9UAXOLgKNaTIFCL0kIskJuVv264SoRh8mRa5W6deTEEX5eERNB4idVA5ubQu7qO
         lS/TzdmS3OFDf60ImxJme1fxSmRF8B5qdE7YjO/KdW4v4c+YBJb5PCyV4NH8inC0rCov
         qyBk7Jkg37p5H//Ao7DV7BD/eTqGrcsT7NPrRZ5ByWbMHMvBpP3CNoYqT06+6xdecruo
         UwQg==
X-Gm-Message-State: AOJu0Yy8xKGI1OMAYdUGjcIItZlKFa0Utgd3v+1MunWFBsnH6qb7LpkO
	Po8iY+p7z1P2jn/hCZhRq3a9nOhLudUCGElc9kkpNP3VOChVo0AQr/Y/jif4S+pHZ8aZNhs5n95
	kM208Nbo3fT8HMqgU+JhJE5YB9LrxSi3hUhQZUQwbf3StgzDQhQ==
X-Google-Smtp-Source: AGHT+IFeV9B6dzeFisFaDh56E1FMW33OUG0fbSjgOb5lrFHXQ5NRmvTX0ta76zqrIu9GXXVU8TLgzbM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:77cb:0:b0:d7e:752f:baee with SMTP id
 s194-20020a2577cb000000b00d7e752fbaeemr253288ybc.10.1694461653400; Mon, 11
 Sep 2023 12:47:33 -0700 (PDT)
Date: Mon, 11 Sep 2023 12:47:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911194731.286342-1-sdf@google.com>
Subject: [PATCH bpf-next v2 1/2] bpf: clarify error expectations from bpf_clone_redirect
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
packets") exposed the fact that bpf_clone_redirect is capable of
returning raw NET_XMIT_XXX return codes.

This is in the conflict with its UAPI doc which says the following:
"0 on success, or a negative error in case of failure."

Update the UAPI to reflect the fact that bpf_clone_redirect can
return positive error numbers, but don't explicitly define
their meaning.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h       | 4 +++-
 tools/include/uapi/linux/bpf.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 73b155e52204..5f13db15a3c7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1969,7 +1969,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Description
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 73b155e52204..5f13db15a3c7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1969,7 +1969,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Description
-- 
2.42.0.283.g2d96d420d3-goog


