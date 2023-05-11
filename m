Return-Path: <bpf+bounces-361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5076FF844
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EF92816A3
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D468F63;
	Thu, 11 May 2023 17:21:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0E8F55
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 17:21:00 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477CD198A
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:20:59 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643fdfb437aso30409662b3a.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683825659; x=1686417659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp1waDrS2hxbI501GisptczSjMpLepW01T/hYzu1Nz0=;
        b=LK24k0GciM2A6SKdjLfjy96vWorqMdxz8DQap6mhpdHZ0gEtRXr9QUEwQ61l7noqBh
         nxe99onU21b9M8ejzm6gBZcw0dm1CSyptaIK+rsM7dhdvEfyV5fEAU+WBdmHrPK7y1dg
         BbW1x19cSh9CxKw3/Bp5SQRgMk5a4WZn+v3UoTsdqkPIlT3TZ5uGBD87zWew/+SsdGqr
         Iat2T7GRS4Z3Ms/tGAndch6208fVPfcDloclj5aM9Z1EKliU6KlSoqI4DsCh9rqLho6m
         XqaRIEGIfKQ9D9vethObG2RAOaQxOQW0Ep2yS7Q2ezPrsx8xQ5acaGhelEwa5f5EMX6l
         GFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825659; x=1686417659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp1waDrS2hxbI501GisptczSjMpLepW01T/hYzu1Nz0=;
        b=hBXMI3lo5BjW7PgMa+X/aAOloLX1ja1wgmbrvpm+Bhm+9PykRtQKXF8hxVGsOCfPWx
         jQUyepbdULRAlvf0DzYBjjfr2hYMT1EWlFsTGImhNhIZr37sUhsGwAJcsLqc4c76G+xT
         xJ07jPin+yMKtVpkICLyjpqlTt2h+QtmW+hh1a9uDpJhbkHAiaujUaB1kWw6Cof3CVtn
         0t4bSyzTydMqtr7QBfbAZfceQZPhJuEr9Ytw184xEyfrGV4zPeFH/Rx5Fq95rjT5AbAE
         rYmk5BtmkcBAFb3T27Ha8ROvxuGzV5InJB+t4tOPDvuj/8Zt9MTIHKNE/h/2JGpm5Ouo
         gZOQ==
X-Gm-Message-State: AC+VfDwQuxFqohk9N+P9W+zUPcRX+tPUYtELNj2HlnyFC/u2wYbInvW3
	OqcvCAog7QLw7NAWEjRtoMAH7QLQwTP92Ll5I5plBdMH4YUbVlW/zSd+AJBD+ZT29gl4MnW63Q7
	frhzNNslHDdMyuJ9fxR25uqa9huRcdzxiCucSviLCeXXNdXww2w==
X-Google-Smtp-Source: ACHHUZ5YIuriG03CjX244fli52c3dLFTWJsD9qPMtbqneGFi3r8ZPHdS9a0RXWVaugXFfiwNxxWBp0o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:2b54:0:b0:52c:c0ba:22c3 with SMTP id
 r81-20020a632b54000000b0052cc0ba22c3mr5495277pgr.4.1683825658707; Thu, 11 May
 2023 10:20:58 -0700 (PDT)
Date: Thu, 11 May 2023 10:20:51 -0700
In-Reply-To: <20230511172054.1892665-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511172054.1892665-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511172054.1892665-2-sdf@google.com>
Subject: [PATCH bpf-next 1/4] bpf: export bpf_prog_array_copy_core
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

No functional changes.

It will be used later on to copy prog array into a temporary
kernel buffer. I'm also changing its return type to errno
to be consistent with the rest of the similar helpers.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/core.c   | 14 ++++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 456f33b9d205..b5a3d95d2657 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1779,6 +1779,8 @@ void bpf_prog_array_free(struct bpf_prog_array *progs);
 void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs);
 int bpf_prog_array_length(struct bpf_prog_array *progs);
 bool bpf_prog_array_is_empty(struct bpf_prog_array *array);
+int bpf_prog_array_copy_core(struct bpf_prog_array *array,
+			     u32 *prog_ids, u32 request_cnt);
 int bpf_prog_array_copy_to_user(struct bpf_prog_array *progs,
 				__u32 __user *prog_ids, u32 cnt);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d4..5793d6df30c6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2306,9 +2306,8 @@ bool bpf_prog_array_is_empty(struct bpf_prog_array *array)
 	return true;
 }
 
-static bool bpf_prog_array_copy_core(struct bpf_prog_array *array,
-				     u32 *prog_ids,
-				     u32 request_cnt)
+int bpf_prog_array_copy_core(struct bpf_prog_array *array,
+			     u32 *prog_ids, u32 request_cnt)
 {
 	struct bpf_prog_array_item *item;
 	int i = 0;
@@ -2323,14 +2322,14 @@ static bool bpf_prog_array_copy_core(struct bpf_prog_array *array,
 		}
 	}
 
-	return !!(item->prog);
+	return !!(item->prog) ? -ENOSPC : 0;
 }
 
 int bpf_prog_array_copy_to_user(struct bpf_prog_array *array,
 				__u32 __user *prog_ids, u32 cnt)
 {
 	unsigned long err = 0;
-	bool nospc;
+	int nospc;
 	u32 *ids;
 
 	/* users of this function are doing:
@@ -2348,7 +2347,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array *array,
 	if (err)
 		return -EFAULT;
 	if (nospc)
-		return -ENOSPC;
+		return nospc;
 	return 0;
 }
 
@@ -2506,8 +2505,7 @@ int bpf_prog_array_copy_info(struct bpf_prog_array *array,
 		return 0;
 
 	/* this function is called under trace/bpf_trace.c: bpf_event_mutex */
-	return bpf_prog_array_copy_core(array, prog_ids, request_cnt) ? -ENOSPC
-								     : 0;
+	return bpf_prog_array_copy_core(array, prog_ids, request_cnt);
 }
 
 void __bpf_free_used_maps(struct bpf_prog_aux *aux,
-- 
2.40.1.521.gf1e218fcd8-goog


