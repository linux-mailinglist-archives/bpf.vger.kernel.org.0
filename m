Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54EE2F327F
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 15:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbhALOCt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 09:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbhALOCs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 09:02:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3CEC0617A6
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r5so2383120eda.12
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0YUj1+zjl+/xGU2slFlAP8CkLypp1CdWTvlwp1GroY=;
        b=I/9wyV1A3JsKrGZjPBsUfMhP4rl+e+p0AXnUvthIkVW5rIGUCd3nER7MS38cM9xtEa
         oJ7N098+ITPAOTtOn/9A6l05RZVXGMmFdt3QLjvfCDxiOXLIvZaa/0gPBtP1tV84W3Bz
         sce1BPEb2sYrwMR83wNMRX4wZLZ9GdB8ztujvwg6PL83v9t8sV/XNHlC5F84IssFds7o
         XNL7uFWPVjnGo8fJhTy/yk+qscito/aEXYyJGTMUo3q+WScfg35YJ0ZiBmKhd9+J81mp
         emob1lSxntMDSRHQ7c8Ec96ZIMv0H9GCV1AeULAdTaBG/rao6r6bpEEhCVub3+Z2sgGM
         076Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0YUj1+zjl+/xGU2slFlAP8CkLypp1CdWTvlwp1GroY=;
        b=qeD62aHfKnQ3Rj/n6aenT2iCFPF4e/jPb/EPrMndISc8cQWi5nzGEQEFW/bR21PaOX
         P653UVPrHw6hoji0hA616aZwc9UWmOFnUVfSydlV8sDrvOasEQWLycFyNWbF4lg/KmiN
         2F9XDX0EC/mtZrQAvael+yCM+Efk5yM9d5CMYbFtS/T8f/2TTXdytfdCZjBs+TtZ7MqY
         OOYnkHhedLuR1tcWS3xa4sqAEM6LcjgS8iQiGcEqoDQZ+w+YHxL2n2OUwIxEGm33DTfb
         QDyUTf0rzXH8KCl+lIHuHVA1wCed2EQ52QAyVeV+9hcZ8QxZWC1FkirxWZGWSTGOevRx
         z7eQ==
X-Gm-Message-State: AOAM533JQyJ6abbxWarGEhBpgcf+nGOgsYSGtMW8l0S+ehVQT/g91Ez8
        F7dkk/yhsdIlnNkMcbwqQ7ar1+1oLbjpDQ==
X-Google-Smtp-Source: ABdhPJyXw0Kj8q+RBw0xlDBiAfkrYa6nduRBvyDUPnzluIebbL9pnbrvbwlHWfGZmGNnlUN42X1p4w==
X-Received: by 2002:aa7:c253:: with SMTP id y19mr3471449edo.179.1610460090237;
        Tue, 12 Jan 2021 06:01:30 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t19sm1227846ejc.62.2021.01.12.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:01:29 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 4/5] selftests/bpf: Fix installation of urandom_read
Date:   Tue, 12 Jan 2021 14:59:59 +0100
Message-Id: <20210112135959.649075-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112135959.649075-1-jean-philippe@linaro.org>
References: <20210112135959.649075-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For out-of-tree builds, $(TEST_CUSTOM_PROGS) require the $(OUTPUT)
prefix, otherwise the kselftest lib doesn't know how to install them:

rsync: [sender] link_stat "tools/testing/selftests/bpf/urandom_read" failed: No such file or directory (2)

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 046848c508d1..bffb4ad59a3d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -82,7 +82,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xdpxceiver
 
-TEST_CUSTOM_PROGS = urandom_read
+TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
-- 
2.30.0

