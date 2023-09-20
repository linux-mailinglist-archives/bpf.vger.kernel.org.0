Return-Path: <bpf+bounces-10469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39A7A892D
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCED2820C8
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288663E46D;
	Wed, 20 Sep 2023 16:01:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635AC3E468
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:01:02 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44304C2
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:01:01 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59bbdb435bfso71406457b3.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225659; x=1695830459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3qNxCzDrd/TLneWHuUy+wPH3clJqJDs1/fAlFPsQ/4=;
        b=IQVaHHZtNu8BX2Uu0zM01vNaBa+HlEhrqq5VHDEbbup86Am1IfT4yVWSca0IgSQ9ox
         PRPKd3f8hjMHaCMNNsu/lrKuB8k+p8v2m6T+/sSJvpt/H0Ob/2RAs+KUG1W3M9hTGK3C
         PbZYCwLfUbP4jIaDX5VKNa+YMqC9BdkkRQG5LU/72Xxm2Bug50IcjY5+KCUNJjL+Ef5l
         kihMC1B2qga9nl6wYVz4YGycziPcL1P8ohnQrStN2QTtjSA5sXOESgrxxL9BHQC5oVn7
         WowjOF0TtzDsx/R9GOEf5WdgakGrug5t+m/ZJ6oHQkX0NlH5lRUT1P7Ka9zGss5csXL2
         Z0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225659; x=1695830459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3qNxCzDrd/TLneWHuUy+wPH3clJqJDs1/fAlFPsQ/4=;
        b=r+JsNAZq+cI2IW8PnUcs9tryFAGtiDR6wCtfU9vb65rNOYuHIOafhN8DlPDr18520Z
         Mgj5LDIH3gH2tq4/1+lmIT3T6JWzh/J7ueN7ZNO240sQ2QSrKc0++co2qirQQaiUDuBt
         ZW0ovZD9DpSkrec0wuYuUn01oLJBZdOe2WdnXlmv+XtLE438DabXUYBo6xLuRwB0e2Tq
         M9DeD2/gVbaHHRAiDf6eosRgfY/Lkd8nRn2qFLQpppfmLx92D2mZpuuNMHptJXVbB/KF
         vARLrv9ti5joO0PPYszpTuoS4aoO1qAV+cgAnGb2HgVSIIxC53gxbxBRX0RPCTJP4CPQ
         bTcA==
X-Gm-Message-State: AOJu0YxDWvWnDF5QtgtFDI9uU/aiuR2udRK9T6YOX2MAAxBFPqQw19dR
	7qIE+Jw2XDvExu6DMKtSk6rQbe/IgQQ=
X-Google-Smtp-Source: AGHT+IHiH/aU1IvhMzuxC+ad22hu8JefRmsGb/WW8fFXV2TgIuFRlttwCgD3lNntNzNb+dEii0KqCw==
X-Received: by 2002:a81:478a:0:b0:59b:cfe1:bcf1 with SMTP id u132-20020a81478a000000b0059bcfe1bcf1mr2882264ywa.44.1695225659686;
        Wed, 20 Sep 2023 09:00:59 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm3860490ywc.35.2023.09.20.09.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:57 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 10/11] bpf: export btf_ctx_access to modules.
Date: Wed, 20 Sep 2023 08:59:23 -0700
Message-Id: <20230920155923.151136-11-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155923.151136-1-thinker.li@gmail.com>
References: <20230920155923.151136-1-thinker.li@gmail.com>
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

From: Kui-Feng Lee <thinker.li@gmail.com>

btf_ctx_access() is needed by module to call bpf_tracing_btf_ctx_access().
btf_ctx_access()) is helpful to implement validation functions that
validates ctx accesses.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 73d19ef99306..c970a04b9142 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6141,6 +6141,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


