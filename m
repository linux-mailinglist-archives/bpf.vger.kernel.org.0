Return-Path: <bpf+bounces-5070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C0754F9D
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361A4281401
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15078C09;
	Sun, 16 Jul 2023 16:13:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6181FB7
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 16:13:57 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD9186
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 09:13:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262ea2ff59dso1758032a91.0
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689524036; x=1692116036;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIao1VcArH3W8DDSG/GnVwhJIIFZxJMzOD8LUPapLn8=;
        b=Rsjn8jCGMaLBJSDIkYLC190vn3g3T3h8Yiu5qbL7mmWnquMVjns8jGMQw2vKvjN510
         KF5jvChiHt4zfgJlOhqi3YQt0QmbfjJt5PGCOqzfrfSpl/pCM5xs/M8bJn1VvsfyECXX
         vV+wuZh8RZ0SNJn4MC6eosMUniAiMB7WdlsTdLKhR8e6r2PF/zfENlPxQm1AJzMVcqjY
         utsdIinv7RP/jkbjMfCldYp1egOa7CAeZ5ZR6B+nLtm+HOid2PZWgT+PioIQ7r74Q7PP
         jaNRJk9QMJMTnlBoHsddlaKy/A1maHqOVa3GhDILFgXxF6ac77nJocJYdMxY4xBMPMBA
         D9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689524036; x=1692116036;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NIao1VcArH3W8DDSG/GnVwhJIIFZxJMzOD8LUPapLn8=;
        b=fL/DieMQKtyObXt6Fdz+DHju+vnn3L5CVD3sd8Kob9f1cAqPzgpgYLSOWlvbF99ZXM
         9CZiiSX6eMPbvuA4+wHw5DdFIcX+Frxf7wtviRg1wvWNWGH2j9eVxm2BYt+WvYA7wV9q
         Ff2rmtav+DxsUQniwSrgvW1vUCsp2hJVUPPRBTAKRkgStzrPBMWYxxDtstJQLNT0N0up
         lLExRc1CeXCWkvXpGBU1Lpl7p5wgviycuywW7JcuIH0NhYLIeYKiSS9tvF2YzsnETib3
         7lRfsINk6iELIaLazrqh1V4/flj8d/jf2rJq2Pbc4xelD6NsqAXYZkxsLaENIIbU+g8P
         YHAw==
X-Gm-Message-State: ABy/qLZ6RbuQ7WIgSbKLLPGEJEHrh/bIu0kl9ox4dqu7DpOMn5HReSer
	GqUoi4X2kR6exNWnQJgGmQM=
X-Google-Smtp-Source: APBJJlGlOFP8plcY5j6FI8jOqcmGP4t7lDcCGrwLeCJgLOKgylJchFJk5s4QpPDui7VTQKK2uJ27Xg==
X-Received: by 2002:a17:90a:fd06:b0:263:30a0:643f with SMTP id cv6-20020a17090afd0600b0026330a0643fmr7443576pjb.21.1689524035716;
        Sun, 16 Jul 2023 09:13:55 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id a2-20020a63bd02000000b0054fe7736ac1sm11205263pgf.76.2023.07.16.09.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 09:13:55 -0700 (PDT)
Message-ID: <aecaf7a2-9100-cd5b-5cf4-91e5dbb2c90d@gmail.com>
Date: Sun, 16 Jul 2023 23:13:51 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From: Anh Tuan Phan <tuananhlfc@gmail.com>
Subject: [PATCH v3] samples/bpf: README: Update build dependencies required
To: Stanislav Fomichev <sdf@google.com>,
 Khalid Masum <khalid.masum.92@gmail.com>,
 Siddh Raman Pant <sanganaka@siddh.me>, daniel <daniel@iogearbox.net>,
 andrii <andrii@kernel.org>, ast <ast@kernel.org>,
 "martin.lau" <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>,
 linux-kernel-mentees <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update samples/bpf/README.rst to add pahole to the build dependencies
list. Add the reference to "Documentation/process/changes.rst" for
minimum version required so that the version required will not be
outdated in the future.

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
Changes from v1 + v2:
- Remove specified version numbers for each dependency
- Add the reference to Documentation/process/changes.rst
- Add a hint for kernel configuration to tools/testing/selftests/bpf/config
Reference:
- v1 + v2:
https://lore.kernel.org/all/bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com/
---
 samples/bpf/README.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 57f93edd1957..f16fc48e55a5 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -8,11 +8,14 @@ Build dependencies
 ==================

 Compiling requires having installed:
- * clang >= version 3.4.0
- * llvm >= version 3.7.1
+ * clang
+ * llvm
+ * pahole

-Note that LLVM's tool 'llc' must support target 'bpf', list version
-and supported targets with command: ``llc --version``
+Consult :ref:`Documentation/process/changes.rst <changes>` for the minimum
+version numbers required and how to update them. Note that LLVM's tool
+'llc' must support target 'bpf', list version and supported targets with
+command: ``llc --version``

 Clean and configuration
 -----------------------
@@ -24,7 +27,8 @@ after some changes (on demand)::
  make -C samples/bpf clean
  make clean

-Configure kernel, defconfig for instance::
+Configure kernel, defconfig for instance
+(see "tools/testing/selftests/bpf/config" for a reference config)::

  make defconfig

-- 
2.34.1


