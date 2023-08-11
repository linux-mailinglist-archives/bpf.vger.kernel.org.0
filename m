Return-Path: <bpf+bounces-7517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B90D778685
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA391C2111E
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00AE184C;
	Fri, 11 Aug 2023 04:31:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54E1848
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 04:31:37 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F612696
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:36 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5844bb9923eso18313027b3.0
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691728295; x=1692333095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYXmLMARaNSnqbsYlVhllcjiCNynLXQcD00yVEiyYf0=;
        b=MK9DDRLSL0ITsdY9yW9fyWUrK9xCSnuXYmNFkJRPd1+F8g1/6UPyZaCPBizSQjC9J9
         K0LOihpVd+m1i3W6rziOwVCOhs1arPQzDopjQXwNc7ioR0wmXXWrdlML7oXZJend6x1k
         88/b//Gb0ardsmOLJr9QVzjYkapQV9QxENTRqsJkSiPCj5W9NA2CipSnNek1XSaqwIoX
         0EU3401qvCwXUZ4Ysxy+zuNojhu9C8hf4x07CyjMOZcDdgz3C6I+Je+QrRMnHQXsvqDF
         kfxPznes7wM8dISrz1plyhWYNg0LRj5UVhoP3YuTe5yPP0Y9pnHCLCho2OCc9RkUHgIL
         /WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691728295; x=1692333095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYXmLMARaNSnqbsYlVhllcjiCNynLXQcD00yVEiyYf0=;
        b=FAMYcixqrYGREIgXvYCe9DYJT4e4PZnoRVXtYOnmEWttWUUFFVQgQyHHYd2TQejrIy
         DRI0wgBum4P618B3apNNuG6fFURoYt/XExh/1kRTrxRcCyygM218w3IzizFOmLyW8HRE
         Ba4B20XWbIILVWrcR/bPmTgEf2k7UaEnrdXvOyfq9amZjWGtHfjHHqUiZBC4y/Zgljts
         4gzpxXaea+s7nwoto0mVMiCHN3YsdtjCmw4ag9xgJ3pZfDosmPcquvn1qDT7zdc/cUx2
         KtcGkVM2ayQZUcE7bD5p3NdaKpPs63rZSJe7UBQ3/7hJtkjRnEYFnejt9UP/LbOfg96r
         rEjQ==
X-Gm-Message-State: AOJu0YzK8glOnPV90Rs9U0eNH3KZpT1zXQgDROzzpoTtszxOIM5PI8nm
	NeG40ltVbnxowkDqy+/OixktcDlPrH6FuQ==
X-Google-Smtp-Source: AGHT+IH/HXxVf8xv+PLK65aVs6Z6JTEDPHC4RiQfKZ/0/+jM9+P7Vs2sq8wJydFK6Nmw3IRgnT/6UA==
X-Received: by 2002:a0d:eb10:0:b0:57a:69eb:7a06 with SMTP id u16-20020a0deb10000000b0057a69eb7a06mr1204697ywe.25.1691728295629;
        Thu, 10 Aug 2023 21:31:35 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:16da:9387:4176:e970])
        by smtp.gmail.com with ESMTPSA id n15-20020a819c4f000000b00583e52232f1sm767961ywa.112.2023.08.10.21.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 21:31:35 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 3/6] bpf: rename bpf_copy_to_user().
Date: Thu, 10 Aug 2023 21:31:24 -0700
Message-Id: <20230811043127.1318152-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811043127.1318152-1-thinker.li@gmail.com>
References: <20230811043127.1318152-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Rename bpf_copy_to_user() to avoid confliction with the BPF kfunc.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7f4e8c357a6a..81b6e60cc030 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3297,8 +3297,8 @@ static void bpf_raw_tp_link_show_fdinfo(const struct bpf_link *link,
 		   raw_tp_link->btp->tp->name);
 }
 
-static int bpf_copy_to_user(char __user *ubuf, const char *buf, u32 ulen,
-			    u32 len)
+static int _bpf_copy_to_user(char __user *ubuf, const char *buf, u32 ulen,
+			     u32 len)
 {
 	if (ulen >= len + 1) {
 		if (copy_to_user(ubuf, buf, len + 1))
@@ -3334,7 +3334,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 	if (!ubuf)
 		return 0;
 
-	return bpf_copy_to_user(ubuf, tp_name, ulen, tp_len);
+	return _bpf_copy_to_user(ubuf, tp_name, ulen, tp_len);
 }
 
 static const struct bpf_link_ops bpf_raw_tp_link_lops = {
@@ -3388,7 +3388,7 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 
 	if (buf) {
 		len = strlen(buf);
-		err = bpf_copy_to_user(uname, buf, ulen, len);
+		err = _bpf_copy_to_user(uname, buf, ulen, len);
 		if (err)
 			return err;
 	} else {
-- 
2.34.1


