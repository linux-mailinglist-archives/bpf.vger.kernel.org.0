Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C4620356
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKGXKH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiKGXKF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:05 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D52018E
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:04 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so16271845pji.1
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNUXGrsIBZA47dfMoUXlsA9DJrJBOE3oKFjyxYnaenU=;
        b=KG2tB+J4CDuVHyz0XZ62AmbeoCSHuKqEV5RAWO2SoLuDn9+4JAwsLPbjWY70WME83M
         A+N/4QVwkXli11nK4f4LMwyAxVsG9u3f1T1VrMFzixnoD576Jb+pTU0Ve3lkNdruNBVF
         dNUuoZp2/jCmQBgqiC35mz2kfdNgSxYTTcQprL6vg+gKKiCbE9t7bsevfjplDAl/7xVK
         8xlGulGgNP3R0RN3usRv0ev5PnllMPtqGHhhF0EjDbyrZBQ+BVasiiEm1G+Ne7zcJLtj
         lIinF7wv4meZJyyKogw6KouI0I2y8bpe5dy0vsCWzgF5InN54fSWLGgfdyU6mQcbJrwJ
         2hDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNUXGrsIBZA47dfMoUXlsA9DJrJBOE3oKFjyxYnaenU=;
        b=az+eHx3yM0CcFzq4a9tPO9EHU44qzD2JpX+JFOM7qAr9/rMAlCEfVv0a3/0Ih1QT0q
         AdMX2yA5HtPmnMOlJTKcuBOl1kNJnP6TmPX7eJCn697ZhY84W1WdYhV5TsvuQW5iDZBF
         1gEcxl/+QAuKVvp7KfVQcYyVc8/hwWfa+NK5U+7G3qENKc02l+TmMQ62WESeFeMmz5hm
         hdZ71GTxYL6U0p4gpmNYn76hTmRgx8H5e5T+WAqJwFX375DxC1g5RMpcNrxnnvnfJ6eA
         jahanZwL/bJpuuqDvEuP0aWpMfTn9C2LNsZUaYvWZ4HRFguIun9IScUWrnM5dXhNtiHx
         ufZQ==
X-Gm-Message-State: ACrzQf3wadkhV+tMT4k8UAl5CTrFZ1ru81oqzHnvjYKluaKenb/e0ms2
        mzUAbxhTKGC7S9gK/Jn9ZA3vpDyV/jCyqg==
X-Google-Smtp-Source: AMsMyM5Umn6tYQLm8jIhvKK+bsk5pDCd2cFXxDl9qVdhqdSmQMcR10YsCvK0u05dDV7mk8bHDs5y0w==
X-Received: by 2002:a17:90a:b897:b0:213:d66b:4996 with SMTP id o23-20020a17090ab89700b00213d66b4996mr47372847pjr.3.1667862603628;
        Mon, 07 Nov 2022 15:10:03 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id p13-20020a654bcd000000b00434272fe870sm4645240pgr.88.2022.11.07.15.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:03 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 02/25] bpf: Fix copy_map_value, zero_map_value
Date:   Tue,  8 Nov 2022 04:39:27 +0530
Message-Id: <20221107230950.7117-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=memxor@gmail.com; h=from:subject; bh=6RvsvjttmdEULzDCNignBfVVDaAhe2Uld3KegARQNKU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+1NLiBPyhOAGswnMZ++VCv2z7GCXT00P33PG8B xurXpGSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtQAKCRBM4MiGSL8RyoMnEA DCi33aLtqfapRge7eNVXAvdMgKMcxopbacWGncUGX4eWoJ4HU1A9ZMPf8fOBxV3+w3oIA7gGc8L9xO yQAu1K+sAOUMrtpqGyImkYqs8kgHNncE00gciCzz0yNOLpJXuwnaETXG0Ds/y751yz6SahHW5FX6gO HrUoRpD5PuETPy91cYHs3SlH30uCgy1CCLfrhUtrjVvH7gLACfbU1/PlNvYoT+6oERG+HdAm6ZGDpB Dgan6q7SniwLj+95TguzuxbMi0C4xXQ3kda3nMHdUe9/rLpieUhffziU1W8b4eV6qrenyWCWjm+yPd 1dIW2eJucbRWEgOVB176kNEnCgjl7oldOYgbwrWJmpR02l1fTA/nnvSLHZB6RMWT/jkSd3qXkiXGIs KNqG81iwp+kS+hKJO6hWTOrxcbjmSpDle13xrOt7b8diRL5pkAdcq0FdYLatgVvOoBY9Kzhf64lcVb 0C4sdPHCGithExsN1Fj5//utwSDEI7OkJbjIqL+slfPNdLfUDFZ6ONOGUFiEsV8O3qTrjVMJj94tdx +W37E3HK2hvZVddcrvltg2uRpcXm9kvSEl4LzCS0DOTDGfHWc+hCyzKmXi40/AfA0tcOEYAbB5PToW kS2X4i/xJM6/v2En9iFXU6eWv6/tkQY/QQ7yU8cEBKXrEJFFK+uoLJlhV86Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current offset needs to also skip over the already copied region in
addition to the size of the next field. This case manifests where there
are gaps between adjacent special fields.

It was observed that for a map value with size 48, having fields at:
off:  0, 16, 32
size: 4, 16, 16

The current code does:

memcpy(dst + 0, src + 0, 0)
memcpy(dst + 4, src + 4, 12)
memcpy(dst + 20, src + 20, 12)
memcpy(dst + 36, src + 36, 12)

With the fix, it is done correctly as:

memcpy(dst + 0, src + 0, 0)
memcpy(dst + 4, src + 4, 12)
memcpy(dst + 32, src + 32, 0)
memcpy(dst + 48, src + 48, 0)

Fixes: 4d7d7f69f4b1 ("bpf: Adapt copy_map_value for multiple offset case")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1a66a1df1af1..f08eb2d27de0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -360,7 +360,7 @@ static inline void bpf_obj_memcpy(struct btf_field_offs *foffs,
 		u32 sz = next_off - curr_off;
 
 		memcpy(dst + curr_off, src + curr_off, sz);
-		curr_off += foffs->field_sz[i];
+		curr_off += foffs->field_sz[i] + sz;
 	}
 	memcpy(dst + curr_off, src + curr_off, size - curr_off);
 }
@@ -390,7 +390,7 @@ static inline void bpf_obj_memzero(struct btf_field_offs *foffs, void *dst, u32
 		u32 sz = next_off - curr_off;
 
 		memset(dst + curr_off, 0, sz);
-		curr_off += foffs->field_sz[i];
+		curr_off += foffs->field_sz[i] + sz;
 	}
 	memset(dst + curr_off, 0, size - curr_off);
 }
-- 
2.38.1

