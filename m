Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3E64291D
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiLENRI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 08:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiLENQx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 08:16:53 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518D21BEB6
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 05:16:46 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay40so1979886wmb.2
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdZuj82BZT6mPlDHtQ+58LTPmT/m/OiCbGS1ws3X7Xg=;
        b=QgOJNN30hBPkomjzW8VSUTHCuxDK5ynAc2oTApihykC4XVEdD9WG/0c9gdRU/72OG0
         x9nnI7m8fGdUfoDRvCZHij6PAhxEIxUbitgr4jGGGKBtwGRvRKXM+wQ/2y7huIAxiCrh
         gbD6pP0d9bOhjLWs+8/JALFRlEecTd5gqlg445cN5sCRHfjEZQegp+f2qsZ8k6Kc5e9j
         O8dTCqcHB4MjrSs1a/+vLi10u8tkPYPh1AVlP+C97Aj2IP4je+obUd1RXdD/GEicm7ih
         qvGFy4Hq5nLTulbFGAGwtskL30M/WsEqgzRry7aTz5hvIAiAbA8QDKzmCphStjo8aX2q
         BNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdZuj82BZT6mPlDHtQ+58LTPmT/m/OiCbGS1ws3X7Xg=;
        b=BhbHd6SL+crFxGgIMMDGJvIRVIO+rn/iJO9j+Zwf4+gBot4Fv0MvBiGVPu4E8GpZv0
         myTbDMl9+ZolmRUbBXDqHzM7o8G/Rutt62qioTn/S0mwdlTbGtPEAZHZByw8VGUSAQGh
         Xb013wtQNg6EWMXUYa8dNfqca86m+kzlsCa0goUzukZLnfuR224kBBZrmlbZWPbWhQsg
         3EhQA4l0KKiMUoZ/aI+CBtgwtzhyarn3k+UxWPsNN8WTCvc4gTecoWz3Go8BR39tGi8G
         G8kOFy3CkbOjjQ8U2Z2woSElAWOiLp7uyP/y8iIW3ONlFLCz/9hMtlfKB7GjC/5Rs8Pe
         WEjw==
X-Gm-Message-State: ANoB5pl61DE+bEU97F+PTrC+JDqsmGvwvezepLzyTSKHw3IiIc6w3ZLk
        DETKJ0JuVzt14ASwCsmv6e/z4woof+X0erdV
X-Google-Smtp-Source: AA0mqf6jTTYNBbHgLGiUwsjSlT2b3a5s6Ig2zu7XAnYNrGHT+0P5l+VIigTrR45YuXfm/jF6rFs/5Q==
X-Received: by 2002:a05:600c:5254:b0:3d0:75d5:c64b with SMTP id fc20-20020a05600c525400b003d075d5c64bmr16671611wmb.12.1670246204553;
        Mon, 05 Dec 2022 05:16:44 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:48e0])
        by smtp.googlemail.com with ESMTPSA id fc13-20020a05600c524d00b003d04e4ed873sm24710492wmb.22.2022.12.05.05.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:16:44 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Use "is not set" instead of "=n"
Date:   Mon,  5 Dec 2022 14:16:17 +0100
Message-Id: <20221205131618.1524337-3-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
References: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
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

"=n" is not valid kconfig syntax. Use "is not set" instead to indicate
the option should be disabled.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/testing/selftests/bpf/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index f9034ea00bc9..3cbdbf57a403 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -8,7 +8,7 @@ CONFIG_BPF_LIRC_MODE2=y
 CONFIG_BPF_LSM=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
-CONFIG_BPF_UNPRIV_DEFAULT_OFF=n
+# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA256=y
-- 
2.38.1

