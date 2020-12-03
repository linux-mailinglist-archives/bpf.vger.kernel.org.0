Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9912CDE98
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgLCTPY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgLCTPX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:15:23 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E2BC061A52
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 11:14:43 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so4983767wmb.5
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 11:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghTVsKbpZtfvZg6e/7iBLzacUWdh3E9D77gh2ZJibOg=;
        b=BDBaOL8JjCil4947zzS2FpfPmY2/Z6W3FN8b7fFNQqzKjfMCgvrnw0krFdO8wZceEl
         JA7KbU3VEXOhSIDDvB3GvEdvSTSwelDgKNimGTVheSQstTyPRBDCmUqhanMLo1HA5H0n
         hDzV6BwEAaCx+cev39/Pyeip5uyjUAA/T3bzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghTVsKbpZtfvZg6e/7iBLzacUWdh3E9D77gh2ZJibOg=;
        b=apgjW1FwbX7ZqODYXVlUGouDkU77Bjkeo3neqdPZApEWQRhfxW3pkaIvxdEM34oA7E
         Gh2jO47/iI7zkSQ8Pe51+07ZZqs0QuKAQux4NeOX26PmphMU2nyTgXVfD9wm58f/sEaf
         duGbuhCo1L7rjLpjfdwwaFs7pXZhlrJv6SNQC2nPcZem4eymi9SLPpQkOKWwW6eC7Use
         g8Q7RWXa5t/9zoYGQXr5SVSBg+MmmgtWQM+yx3bM8IgKwJ8x+TRgCNsoARSvb1f6uJXH
         U6DNm0UKX4lGSHvSsna45iHGXCBQTAvmL8496UKbl+4J+1qucTwD5Z7vzsQ5etN3qwoF
         yG3w==
X-Gm-Message-State: AOAM531T970j+5gQR2A1CZDSXbeyTxPdvJKpvgKgORLCZFvZKVJp6iDZ
        ZFbLYi8nk9n/dLWKstXaMB01tyuRcM04M0NY
X-Google-Smtp-Source: ABdhPJwN7DbOSyngEKjpLH4FJqcOKZ8BwUMgzQT8Dqczado7MMsshe0Nu33lEQ+bn1k26XZm1Y83Iw==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr308167wmf.59.1607022881894;
        Thu, 03 Dec 2020 11:14:41 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id q17sm516480wro.36.2020.12.03.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:14:41 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 3/4] selftests/bpf: Add config dependency on BLK_DEV_LOOP
Date:   Thu,  3 Dec 2020 19:14:36 +0000
Message-Id: <20201203191437.666737-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203191437.666737-1-kpsingh@chromium.org>
References: <20201203191437.666737-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The ima selftest restricts its scope to a test filesystem image
mounted on a loop device and prevents permanent ima policy changes for
the whole system.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 365bf9771b07..37e1f303fc11 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -43,3 +43,4 @@ CONFIG_IMA=y
 CONFIG_SECURITYFS=y
 CONFIG_IMA_WRITE_POLICY=y
 CONFIG_IMA_READ_POLICY=y
+CONFIG_BLK_DEV_LOOP=y
-- 
2.29.2.576.ga3fc446d84-goog

