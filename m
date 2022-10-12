Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776B5FC5BD
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJLM7I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJLM7H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 08:59:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E971B9783
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 05:59:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h10so16161748plb.2
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ1XB9BOt5ZTwJN6F6Xw2Al1/ocDwlur6F/M5WoF8aA=;
        b=OdCU0LHvVJQ1uJLGdzZQ3bTgQeqKV+V9Rj+IBC+7//58PaV8kS92YUfgswpOpn4hL5
         Wr8vKKcWCQNuS/nA67gm0LK7itGnGYjHpUHqxn3/SpOZKkKNnFWnd7F0NxP32dCEPk+y
         zN3c1AWz25R/gWXzIxv7WbliHXn7hpOVrynbwXvGwPNFmV0/QxC5bJ7KepNeGnojm19q
         FwXuTaqmWiqwXVKKdk9/YZ2o+DYeL33DH6d8+9SiKo6hLgkF6sHpjNv4r18zBziBmDYo
         4lwhoG+V1NuSf2NH8HAvZ3jhs4mHicMuThbKKODQ6ZAry8xxbJjzd2PbfFbCjwUOZaWe
         nAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ1XB9BOt5ZTwJN6F6Xw2Al1/ocDwlur6F/M5WoF8aA=;
        b=aDNySHBZSAOSvTDeUHoH7o2uHCZUmkCJSQGiAmVg3il7iKxasPHGk4LhMgevqG9/dW
         DXkzAr5SmqNJvbNHcMTzW8RH1ugCCboyrBq3no1YXtiST8axqrqgmOoem2jXY4QhnGKd
         7/VePWHTjzuMDPIy1JaamPQY6hfzCI5w7gnTllrwT0R+lz9gxlabPlaj/gLR156Is583
         wLKsZRrP1Z6nn8QfSmS6VtQ+ihNW6vYrbilMyhjp7ZUJ9B7zZXyBnoco1rA7OQtmqMxX
         GgTtzSwJraiHMNtPBRA+8Imrxj45b6+DcPw86aJf7NpHvpVc4LpSfbHHpKQWAqn2ubmF
         6D/g==
X-Gm-Message-State: ACrzQf1dDERUmBRRAs+9oro80wCeGk8Dep8JnCdwSN5lqXoEmMMUS2lG
        yHcyos+tpgMG1yqpd3c0ciy61TclRhk8Rw==
X-Google-Smtp-Source: AMsMyM44JDouPykzt5BE8CqpT+Nn7ZyQzG4zH14a2EfYR9yTtzntX1UZRfIXJx6hwiVqUZSd3cOTYA==
X-Received: by 2002:a17:90a:8b93:b0:20a:bd84:5182 with SMTP id z19-20020a17090a8b9300b0020abd845182mr5197324pjn.161.1665579545936;
        Wed, 12 Oct 2022 05:59:05 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b00562ab71b863sm10957168pfr.214.2022.10.12.05.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:59:04 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] bpf/btf: Fix is_int_ptr()
Date:   Wed, 12 Oct 2022 20:58:15 +0800
Message-Id: <20221012125815.76120-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When tracing a kernel function with arg type is u32*, btf_ctx_access()
would report error: arg2 type INT is not a struct.

The commit bb6728d75611 ("bpf: Allow access to int pointer arguments
in tracing programs") added support for int pointer, but don't skip
modifiers before checking it's type. This patch fixes it.

Fixes: bb6728d75611 ("bpf: Allow access to int pointer arguments in tracing programs")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..2b343c42ed10 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5316,8 +5316,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	/* t comes in already as a pointer */
 	t = btf_type_by_id(btf, t->type);
 
-	/* allow const */
-	if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
+	/* skip modifiers */
+	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
 
 	return btf_type_is_int(t);
-- 
2.37.2

