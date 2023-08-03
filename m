Return-Path: <bpf+bounces-6901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13776F608
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 01:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463682823E8
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 23:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D015826B09;
	Thu,  3 Aug 2023 23:12:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3ECEA0
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 23:12:20 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1771219B0
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 16:12:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-583b0637c04so22473867b3.1
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691104338; x=1691709138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8x9csw1rEee/3TsItbYVAXVJnXpKPSSQXphT6LmPAx8=;
        b=PgtV0/KxAMEEcmMwd4SAA5rWSwB635leqxO2xzW7CASL+QEMoJjVvPNqu206U2+XPd
         W8e8/YNTj1iELOR/5p3TYcfLol49L7v9ShiQFYhxls6V0qJfW+XMIcZr75do0RdSkf59
         2YmcEf6JwReB4mzmkBPy4JSqwA/tZn2BAmlgmTOFvtQzq2j0TznUBusMJF65jCuMIGYT
         RZF5ffdNywrwwbd2eVM5pm/sRr0yLASubkGYZNIMtKQEixaGmgFTKaqU4UwkflZs5yMW
         oPP0HvH3TnKT6fkMEtFGT/acXx0J7ww3SWGkmGugmeMjFJ8QpHGA3gAv7N0MLO249MEq
         nuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691104338; x=1691709138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8x9csw1rEee/3TsItbYVAXVJnXpKPSSQXphT6LmPAx8=;
        b=f2pt2UgBLPy7bSieUR/PtvWx499IsAOsXIK2ikJXUYIpx9EkceQeqkqZ4EhrRJ60Zp
         Z7FWvvI1LIna0bhawOilOFKo21ikac060ti/mOZ1Lvc0koMY4UZxeATEtyGQMm+P1K8S
         eAvSdwRa7mcM0THk6Ja00pR8tVKzNEXf4pu2f5eKXinqhM0FsEnGeZ7hPo9J3Oa3dY5+
         KAKeuvZRMqOUq0uieyUfAcan7oXidlEKraTG+AhFlFXDeIVmmNgO5/eoe5e0t6mEiIjA
         c1H6xMno/+Cmdq0HSigkNj014sQ9Ir8qLp8WpGCOmuUbUOrV7d11zi5UfzJeh29VNK7a
         gHeQ==
X-Gm-Message-State: AOJu0YztQ9usHT919OQ7eoJMEI3CPGYvsRzj7bL6dEXGe6qmjwD/ZzEH
	/an/mZBIi5qHE5C5bzlu+z9SrjR7/vynvA==
X-Google-Smtp-Source: AGHT+IEmzqDDU310qzsfOQL6yQbkUhiWBbq7TZeVAE7FHDEHx0RjltOTpIgFgL7DbzkpA1N3wA9LbQ==
X-Received: by 2002:a0d:ea84:0:b0:57a:8de8:e3f8 with SMTP id t126-20020a0dea84000000b0057a8de8e3f8mr136756ywe.22.1691104337968;
        Thu, 03 Aug 2023 16:12:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c07f:1e98:63f3:8107])
        by smtp.gmail.com with ESMTPSA id x6-20020a816306000000b00565d056a74bsm297262ywb.139.2023.08.03.16.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:12:12 -0700 (PDT)
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
	Dan Carpenter <dan.carpenter@linaro.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next] bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.
Date: Thu,  3 Aug 2023 16:12:06 -0700
Message-Id: <20230803231206.1060485-1-thinker.li@gmail.com>
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

Verify if the pointer obtained from bpf_xdp_pointer() is either an error or
NULL before returning it.

The function bpf_dynptr_slice() mistakenly returned an ERR_PTR. Instead of
solely checking for NULL, it should also verify if the pointer returned by
bpf_xdp_pointer() is an error or NULL.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain/
Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 56ce5008aedd..eb91cae0612a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2270,7 +2270,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
-		if (xdp_ptr)
+		if (!IS_ERR_OR_NULL(xdp_ptr))
 			return xdp_ptr;
 
 		if (!buffer__opt)
-- 
2.34.1


