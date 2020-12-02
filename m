Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC52CC9BB
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 23:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLBWkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 17:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLBWkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 17:40:37 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF00FC0617A7
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 14:39:50 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so5808520wrx.5
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 14:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZbL9ltkMDSrTa8UWNt4NTT0pJi1szO3pVPjHCV0axM=;
        b=DflXLPk2F3Au8ExOKLpAAgtZmdgDHKDzyBu+Kmly2DFprdCaPFoLK5+JX7oX75cM3e
         PGXmTriXBuq8bibuYHPO8vwmlmToT5QDqFcrTZR/fiP0RURxAyT08B79Knv4WG6mWu6L
         eggOj3aoIHMQtcHbxHOAIvDz6rDClf6d5aIU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZbL9ltkMDSrTa8UWNt4NTT0pJi1szO3pVPjHCV0axM=;
        b=r1tGN6NX09sSTK4bf+vNJKpexUhCZz0DQo/qBSxAxMIF74CPnhe6y7vlDm3+6of4Ce
         HqXFEwaznd2eODa503EspzUPihH6iihOO6g4wHVph8Zy4u0Otn81DUJV5qnG7X/4yZoP
         c95NPaRE1/lWEG6jIUFroMyz+0uJqixB+m3cOX4Q19AQBz3m/6FSXVOoQFxkj+ITgm9u
         yZgPqyJ8ryk/A33TTyE9O+6QIJ8ddTZsB+tFm+u2d0jQzNtW1Kxk/Mx66UclZW9G7dRK
         lMIvhhnPQttA95x9NgXfVVNk8t+afdiN4OfhWuTLV0EXRqHGROMkdane84N9yQ9GYiSw
         jWnw==
X-Gm-Message-State: AOAM5315GZHuohxR69Ceevf0J+HnSqkhvvUxOrjvdGzAym8LSyBxFnEs
        YgvR8sxSIeRnG0Se3jcC4DkzvdgC7NkyCBZA
X-Google-Smtp-Source: ABdhPJwa8DTZPR4e9yM/sVPi0bBojDRVVXrEwCVi5/FcJbsFVSSaEQgs05SIjVbnaZvU7hXpXBKL4w==
X-Received: by 2002:adf:f882:: with SMTP id u2mr283922wrp.271.1606948789250;
        Wed, 02 Dec 2020 14:39:49 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id c2sm113068wrv.41.2020.12.02.14.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 14:39:48 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add config dependency on BLK_DEV_LOOP
Date:   Wed,  2 Dec 2020 22:39:44 +0000
Message-Id: <20201202223944.456903-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201202223944.456903-1-kpsingh@chromium.org>
References: <20201202223944.456903-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The ima selftest restricts its scope to a test filesystem image
mounted on a loop device and prevents permanent ima policy changes for
the whole system.

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

