Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A662B0D3
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 02:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKPBzX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 20:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKPBzV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 20:55:21 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2C924F3B
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 17:55:19 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso460365wmo.1
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 17:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wXkkJq122w7Ffa1R0qJKiOOLU+naCLYxFOIuVFrBg0=;
        b=SKjb/nbEORxX/eq+FkbZYc+R5PR9sVlL7q8zh2EVuNNs41vIUGb9aSRqjepunzDCmS
         OuxFuwyK3kd0gRoMWYRqpCVzFeUfdP3djb7Np2MdyI3KIyPXvX+ophR1C8+1tGVDJrSS
         CMNLy29PuG7RYVTxJE7431a0GeZpKfM3/0Zokq1UrNvVW7tpQZQ4glHESTiU8JpMRPKG
         tiOa4jPqquUhqLKTd2ZXUOABSfq2GXsFVqV/U1l2Fm2rICAhEXslFuedk+rumvjMSPeP
         2BZs34QiLWZM/l1WS2TFSR1tB8dskOGnqb2t6Dk+Mdu5BYPGe3v+TThzAjqp0o67M4rm
         Fslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wXkkJq122w7Ffa1R0qJKiOOLU+naCLYxFOIuVFrBg0=;
        b=AGvN3lGMOzI4q8DLvKjumH7Rwc8PaCqFJ5UmgKkjqphqWjv6TGxsnRtUmIU0WTg7NB
         NLRYNeizbbh0YOtmIWXu71ap4w4rES4h3TjgJ+kv4WvB/b4GBqu5JY51JVc5sSXguG4g
         vfHy/6EXW/C/gmgYD7athM8g+onYjhj8YObmwwZYP802IcXlRt8NBHFEOau6e5wrDJHb
         Pg67msrcPjtmiOCX6GhUNRpWkj7GLEX9e2VYve6GOYSMVY6b46+c/clGjoQlGA6UUk6n
         54RhgJ57xeu8UOEkpukhM1zh2Ca3mAU/pE1i6U3TIA+/9pxieBv/eBKkS729XhSKpZv5
         YW1g==
X-Gm-Message-State: ANoB5pmP6tN2qZCO6N0ZIT3k8nsRK+CeUPmO/+GgvGN5SE95AXq1vo4l
        QBGVUEZu36Q5HC1XgKY2eASdBvVWG7ubHx95
X-Google-Smtp-Source: AA0mqf4402mw0G2YX6qe5tbBMTqDE72jgmaMs/4+53OTTmO/MpXh8ahZ4lRavrwDXZqSQxk9etzVVg==
X-Received: by 2002:a05:600c:4d24:b0:3c6:a8c7:755e with SMTP id u36-20020a05600c4d2400b003c6a8c7755emr508429wmp.167.1668563718245;
        Tue, 15 Nov 2022 17:55:18 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003cfd64b6be1sm521080wmq.27.2022.11.15.17.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:55:16 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: allow unpriv bpf for selftests by default
Date:   Wed, 16 Nov 2022 03:54:56 +0200
Message-Id: <20221116015456.2461135-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Enable unprivileged bpf for selftests kernel by default.
This forces CI to run test_verifier tests in both privileged
and unprivileged modes.

The test_verifier.c:do_test uses sysctl kernel.unprivileged_bpf_disabled
to decide whether to run or to skip test cases in unprivileged mode.
The CONFIG_BPF_UNPRIV_DEFAULT_OFF controls the default value of the
kernel.unprivileged_bpf_disabled.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 7a99a6728169..f9034ea00bc9 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -8,6 +8,7 @@ CONFIG_BPF_LIRC_MODE2=y
 CONFIG_BPF_LSM=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_UNPRIV_DEFAULT_OFF=n
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA256=y
-- 
2.34.1

