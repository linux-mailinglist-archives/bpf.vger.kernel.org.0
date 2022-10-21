Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48E2608085
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJUVHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJUVHi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:07:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7AC2A1D9C
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:38 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n7so3456240plp.1
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZipgOaqVPJvYNPVt+g/MBMEIjOBL/0dtLxHAV4k7HPY=;
        b=qXGs2TrMR877Wk0bT8nZ6nBEIMaj+LQmvvTTQvmmHuF4gZxYTG+WtEvXY6yCIlJApW
         TnX7D1AK5AbCGG14Pe4gWvmhVLt4qeIY7VOzmDOCcMQ/y6v6hzwgUZA4046is+AIEvgi
         AkELzZBzdIsoRtdhc6VUrsLnggu2DiTQY/piIkTTZ/S3pxkWgQg8yAMvw6mf6sI82egW
         lSYlhkPTwiSMhI+bA9I4RMOMQPkAtFdr07HuqTtYFPM2up9gLkG1Kb60FQ4m5PsQlZGg
         VHX/3GtSDJHvkPMIh/rpUg/oeJS3yy70T+SWHY+GgZK/4mXnwS9QtTdeJID9bzv5sm9u
         hE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZipgOaqVPJvYNPVt+g/MBMEIjOBL/0dtLxHAV4k7HPY=;
        b=qzQ98OAZ5iFzHkdOimBbBUhR1qZYS+dTis4fLWzU566Q05BEQtYZ2vg50m2bM1s5LG
         5A5wcTJlCW8xvclb9iOShFWGCRxnOt4AFs1G/k6Pq7zSZYWGk/HgEZmQNUso1EXFyaay
         f4yz/mBJaZvJVVzlDf15ECtUZWALehQHJtkLq3S1Gf0ix7pnTGi8mFIRdLMbqEBNlh9U
         4wUfWLVmlZcTC/Q3EJZZrndz/j9HQt/J48gEZYgl0O0XIyNCruLHl678xFExgNmDs8EF
         XVlYkrS5Q4FgBNZIZEX+yKJSYBJ2GH/24Y5U7MJlw68nmB4CeujK4jtgPv1UL++RacYR
         ZNLQ==
X-Gm-Message-State: ACrzQf3kG+ZYxZXI18gSDSLVCiVzgFhvRjz1DX2rroMwFb8mRmrekOv0
        H+O+4+Z/md4d+QKBP7j7bDM=
X-Google-Smtp-Source: AMsMyM748mu3rCIF36GoFkGh8VGQ/+s+vnVe407GCgw/ucxVHsz6SUhwGBAoQCBa6FRVZHAtvo7DRg==
X-Received: by 2002:a17:902:c942:b0:180:3f94:2975 with SMTP id i2-20020a170902c94200b001803f942975mr21098254pla.50.1666386457460;
        Fri, 21 Oct 2022 14:07:37 -0700 (PDT)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0017300ec80b0sm15083246plk.308.2022.10.21.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:07:36 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     chantr4@gmail.com, bpf@vger.kernel.org, andrii@kernel.org,
        mykolal@fb.com, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
Subject: [PATCH bpf-next 1/4] selftests/bpf: Remove entries from config.s390x already present in config
Date:   Fri, 21 Oct 2022 14:06:58 -0700
Message-Id: <20221021210701.728135-2-chantr4@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021210701.728135-1-chantr4@gmail.com>
References: <20221021210701.728135-1-chantr4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

`config.s390x` had entries already present in `config`.

When generating the config used by vmtest, we concatenate the `config`
file with the `config.{arch}` one, making those entries duplicated.

This patch removes that duplication.

Before:
$ comm -1 -2  <(sort tools/testing/selftests/bpf/config.s390x) <(sort
tools/testing/selftests/bpf/config)
CONFIG_MODULE_SIG=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
$

Ater:
$ comm -1 -2  <(sort tools/testing/selftests/bpf/config.s390x) <(sort
tools/testing/selftests/bpf/config)
$

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/config.s390x | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
index f8a7a258a718..d49f6170e7bd 100644
--- a/tools/testing/selftests/bpf/config.s390x
+++ b/tools/testing/selftests/bpf/config.s390x
@@ -82,9 +82,6 @@ CONFIG_MARCH_Z196_TUNE=y
 CONFIG_MEMCG=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
-CONFIG_MODULE_SIG=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULES=y
 CONFIG_NAMESPACES=y
 CONFIG_NET=y
 CONFIG_NET_9P=y
-- 
2.30.2

