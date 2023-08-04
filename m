Return-Path: <bpf+bounces-6910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DEB76F6A9
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 02:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE222823DC
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF6A4E;
	Fri,  4 Aug 2023 00:51:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25CA625
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 00:51:22 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ED910D2
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 17:51:20 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-583d702129cso17102527b3.3
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 17:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691110279; x=1691715079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xL/1MQQJLit9EQUWZft+jBLUhC5YOvnXNyrVe5ZIa0=;
        b=P/miysn7/CYr5CzXsBAjyX1R3zU9jmK6ClxaFnIk+Qtc5sw0iY2gpaYhHqnv5y3KWH
         M+RatZk8NH9Ue2SOBVglQ/UQxTAjyRyADQ+bP6YWXXdyUTWp4aSuFAJmKR+OR8rLe6C4
         q0fSY07qBcZqLzpFe5j2XHN8Z1cSS6qOHDovlpKOgvltTSfBJJ+xjhNzwbHFfubU/UJf
         iW1R9D8hQnQARtu704JwLJb6QCjAkHE9dvn9Tnn4lh8EO/MVm+9pCIYSA3MwqnevGj1j
         tvHglbUuzbD0A470zFz+quKRRGnP4LBUMfCEUJuX4yFunm/Yp4z8TeYEZ9/T6Wav7ivL
         NHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691110279; x=1691715079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xL/1MQQJLit9EQUWZft+jBLUhC5YOvnXNyrVe5ZIa0=;
        b=GDljPR6wdRUrhysxEqoEIOFcaeHjOlKFYlmut5aXDtF7fPbNO23BsDsbDK2TJvYg9I
         kc00sTS3a+Cn0++ZOnTQmp+2DCe+1ietVumTpfNsfp6v7DIOfN7f4Z7S9wQV7AcQC5DJ
         dXCT3ckFsZ+9xziF/TEnZQODW0+gprCKo0ExM4wvICkX3uBfFUIkQym1vmzr7sVXxuK9
         xlzFoIHF+JagUn8gtWONfEs/JGWt/UQQeAAATE3cvFPUWfLtY3QdKuAfD6bn9VDTDIb/
         LPDLEXekwnjrIcaoZdI8JWyfsmS/1IPtsgBmXLd3UCUqVg958BZdK/nWXZlpYOIOFkbu
         o8pg==
X-Gm-Message-State: AOJu0Yxb4iD5UY8n93HFw/qYXDrSjYRbaWlVpwHx+tq672D7CJUQFdZh
	RshahPS/sEtWCLZCFVGt93RAyatqr94=
X-Google-Smtp-Source: AGHT+IEmvCdY7JBs+YAelNdPzGjqhLug16DM9nbQNNnUQfeNOLwo4op2VNfsRwjaW2qB0YnMK1JFPg==
X-Received: by 2002:a0d:d608:0:b0:586:9fd4:6a9f with SMTP id y8-20020a0dd608000000b005869fd46a9fmr177436ywd.46.1691110279320;
        Thu, 03 Aug 2023 17:51:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c07f:1e98:63f3:8107])
        by smtp.gmail.com with ESMTPSA id h125-20020a0df783000000b005869cf151ebsm345065ywf.144.2023.08.03.17.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:51:18 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next] bpf: fix inconsistent return types of bpf_xdp_copy_buf().
Date: Thu,  3 Aug 2023 17:51:01 -0700
Message-Id: <20230804005101.1534505-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Kui-Feng Lee <thinker.li@gmail.com>

Fix inconsistent return types in two implementations of bpf_xdp_copy_buf().

There are two implementations: one is an empty implementation whose return
type does not match the actual implementation.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/filter.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2d6fe30bad5f..761af6b3cf2b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1572,10 +1572,9 @@ static inline void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
 	return NULL;
 }
 
-static inline void *bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, void *buf,
-				     unsigned long len, bool flush)
+static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, void *buf,
+				    unsigned long len, bool flush)
 {
-	return NULL;
 }
 #endif /* CONFIG_NET */
 
-- 
2.34.1


