Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23C36B1823
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 01:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCIAtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 19:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCIAtJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 19:49:09 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A417301E
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 16:49:06 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id k3-20020a170902ce0300b0019ca6e66303so173421plg.18
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 16:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678322946;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0lYPLjfeUFZkJAIn0KL/uT/oO7vUQoNB9HowzjbK4Y=;
        b=antAMoRBmlFTcJd6sSa6uKuWEFhfTy0/VvIFT06YmvopuZYZ/BK+5VOh7/vjG3KyWx
         un9qiXpmgScWzrB5KXXU6x4w1tnkWy8eIAD6vBzSPM2mW8CENpEC+TjntA7qkzGaYNA0
         I/yNTmh8Eh60n6GJE/hL0hLhRQAAYQgppWP13EJ4TDnBTdd1g6VQGtmf3s16q5RYOFiv
         Hgy1L3+1GUHV/AEvUrh8y6pH59wWvYrsuv56gdix7KHq2l3R4B9q6XBR4RD84vXMQUKP
         qc2jigQ/pn/3Xl0W4979YpMH/TjM165wQYkaU6Dbonl0vVgv6HS7rqFpeiMPamsEUiMq
         aS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678322946;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0lYPLjfeUFZkJAIn0KL/uT/oO7vUQoNB9HowzjbK4Y=;
        b=PCJiK8LPm8phMYZ2LvJKhJfTiOSnNhYq4EMuvu+/SqYD4yHih1/WnFuzd1CfmOUzDJ
         L67ukNvZOcD8gkGQshE50qnuXZeMgS777Y4FH7B3ycZ3X2TFQryQ3AgVhrEyXvTaWOQg
         OHTGy2p2MGMQze/usU0RKS4BZb8eozTdcD/osGnBx9jvjcDRW8Z0ffeSoGdYazcuiZcZ
         w4qYHtITSMsto+ri2BRhgkZ6p9VThI+zHY9HBSI2uIHdMpEJbj0WJ2G2u20yILtJGykR
         5TtPFmsND6VNMgzm40T/8aD8EeV1pNkxpFN/BwObmb7H32PzRsIUSEoLHWSZeH+x80OD
         N17Q==
X-Gm-Message-State: AO0yUKWaD7jzVwJLMMEikvpjp9BlgK1jtVi2nvmoOfJC7tRS90gIQH3M
        06Uk4o0zk83uM6GmYBVVuhkH236jm0fiyDB0TJtDhUgojKtx9ov8yCWrcD3xnLCW/YIEj6PMBiC
        X0LEE82IljLNxYDD5B9FP/ZOLRizdooPsRTwql1EmJnZF5+vFkcNhMXVDiDFi1M+z8Q==
X-Google-Smtp-Source: AK7set/de2kpePlZ9IKt6XtFTY8xRVpT0XgZjfKtls9j1sa4HnQgzLthY7SOsodNfRpAk2RCWxaoCpBzIu1lgNg=
X-Received: from jesussanp.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5f10])
 (user=jesussanp job=sendgmr) by 2002:a05:6a00:1955:b0:593:974c:cba7 with SMTP
 id s21-20020a056a00195500b00593974ccba7mr8799200pfk.5.1678322946062; Wed, 08
 Mar 2023 16:49:06 -0800 (PST)
Date:   Wed,  8 Mar 2023 16:48:36 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230309004836.2808610-1-jesussanp@google.com>
Subject: [PATCH] Revert "libbpf: Poison strlcpy()"
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, sdf@google.com, rongtao@cestc.cn,
        daniel@iogearbox.net, jesussanp@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This reverts commit 6d0c4b11e743("libbpf: Poison strlcpy()").

It added the pragma poison directive to libbpf_internal.h to protect
against accidental usage of strlcpy but ended up breaking the build for
toolchains based on libcs which provide the strlcpy() declaration from
string.h (e.g. uClibc-ng). The include order which causes the issue is:

    string.h,
    from Iibbpf_common.h:12,
    from libbpf.h:20,
    from libbpf_internal.h:26,
    from strset.c:9:

Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>
---
 tools/lib/bpf/libbpf_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fbaf68335394..e4d05662a96c 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -20,8 +20,8 @@
 /* make sure libbpf doesn't use kernel-only integer typedefs */
 #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
 
-/* prevent accidental re-addition of reallocarray()/strlcpy() */
-#pragma GCC poison reallocarray strlcpy
+/* prevent accidental re-addition of reallocarray() */
+#pragma GCC poison reallocarray
 
 #include "libbpf.h"
 #include "btf.h"
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

