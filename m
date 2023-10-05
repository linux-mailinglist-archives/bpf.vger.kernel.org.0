Return-Path: <bpf+bounces-11428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09507B9B52
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 09:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 08A491C2093E
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 07:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D85398;
	Thu,  5 Oct 2023 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="J0JYLqSp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572CD5387
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 07:21:47 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523607AA3
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 00:21:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68bed2c786eso583516b3a.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 00:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696490505; x=1697095305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bhehRkAcisDo+pGOQLMRxqAGq1y9OCFtpvbtY4rto2E=;
        b=J0JYLqSpzkCZ6BdEnoa/liu+LPdyncdMwXtORUAHCTgtF9y1ukvFH2a/3hIsR5kk99
         CulV63SjxX33xXR4k7f7jafPelz0m+6fgzaE689tUCBGn8LmH43LTyurDvZz9wD/zZwL
         e7BJeDBc9A7Kunv3JWnHKBDb9vzPrsqUkKp0yVCe3cv+z786ahRbxZFgw+bhcZMDK004
         xxwMlNbkDENZtrNfadB3TS+i58CmHjGx3sXHPwC8X8CNGFY7E75LFf+0J26uampkCEDv
         l2g9YZ3e/uZPLHD6dx7IueyZPg+AlDy+sNbCqPmuVb3b3UoXU4Ex+FVK0SyDwvmVvycJ
         7FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490505; x=1697095305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhehRkAcisDo+pGOQLMRxqAGq1y9OCFtpvbtY4rto2E=;
        b=Nmm/UpxCovXHR+R1QLc4ESCq++MnP8LgoVLQaHjFFZk3ul0EEO38vHRwSL6ioJoYaK
         NdlRfxQ4lL68teFwin+fAt8oR0UYx4fzUek27613Ayc6li+QDS2siZRZ4yiPKfHBoYWi
         aG0ak2cMuomvYavqgQS6CvQr7z/D3WApti2E7UBcX5lqHk0iSZSY5C5Zvrc5705ZtQmK
         9LuihbyC2/4f6OXNDK61WsdG+8RlhT89yoWnWw8iB27GIw7ZzdkwFmlFimPhNcB+94Mc
         hEwTeEWddM4WchQYiU3G04z5CIc5DtPyvKSndJIZowNz52DmEBOw54+nfw44OTvns95+
         AQeQ==
X-Gm-Message-State: AOJu0YxbMEZbh6gApXR+L9gix6qE6tiKARh8f9roKHbVm6HSgLrkzd+M
	7gICT4IW2JlKme73dPUu/C31oA==
X-Google-Smtp-Source: AGHT+IFhMnVxhJdAb97D0VwgSzeh+kZhImxe5gU+SeW/JS015eMWW9pRON/b9es2e93+oeGFnvtWUQ==
X-Received: by 2002:a05:6a00:1d8e:b0:690:41a1:9b64 with SMTP id z14-20020a056a001d8e00b0069041a19b64mr3737258pfw.1.1696490504720;
        Thu, 05 Oct 2023 00:21:44 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id j10-20020aa783ca000000b0068ff267f092sm663033pfn.216.2023.10.05.00.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 00:21:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] bpf: Fix the comment for bpf_restore_data_end()
Date: Thu,  5 Oct 2023 16:21:36 +0900
Message-ID: <20231005072137.29870-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The comment used to say:
> Restore data saved by bpf_compute_data_pointers().

But bpf_compute_data_pointers() does not save the data;
bpf_compute_and_save_data_end() does.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 761af6b3cf2b..bf7ad887943c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -694,7 +694,7 @@ static inline void bpf_compute_and_save_data_end(
 	cb->data_end  = skb->data + skb_headlen(skb);
 }
 
-/* Restore data saved by bpf_compute_data_pointers(). */
+/* Restore data saved by bpf_compute_and_save_data_end(). */
 static inline void bpf_restore_data_end(
 	struct sk_buff *skb, void *saved_data_end)
 {
-- 
2.42.0


