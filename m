Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D82F5020
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 17:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbhAMQgO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 11:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbhAMQgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 11:36:14 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B40C0617A6
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 08:34:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id e18so3917921ejt.12
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXQ6vMa7f3RRXc70uOmWKXVZ59ITEzz6ydYPgh3UHMU=;
        b=Fs6aFm7FeMEyhEFtBLTnCCPm+UPC7JZRY20GjPnEBNQ0PXAkirddbeguIhxj3rgg1g
         dHfbOhgYsvDN2q4fdgmr4g46+DiDnR+8T2Ef9V4YtSOU9U1ondfDaTGpDxU/B07rdQ5/
         DJtbGcPX304Nyq1IsxCg1YdYLChvlzmdo2zq0M8n5111u4cXTeG1Mxx0jY0yKVeIXzd6
         r3QZMaVuFkZ8v0ChFHBf5CslxlZ2KhrbcP/an0PPA2BTFrba7l/tz22a40QgYfqbHw8d
         zIn8DhVGxXk00DZ5mNb24Y2MxlZukJ7YaMz2nrn6rRsN/Cvk+N2EIen7HctUv7R+hKrc
         HJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXQ6vMa7f3RRXc70uOmWKXVZ59ITEzz6ydYPgh3UHMU=;
        b=pQVigpJH4X8b38s5rRcsCDt6ttZQmFofhVo89D9Y8xZWFjUOn8vhNCGdqHinkqQL7G
         GT3MJOhOk9bizbIXXxtbWTnttM+EPAPcqM09sVjttpaVJRg/L7MyJfq6LqL+ZJ4uxB2n
         Q/ae7Fnq4eHlww8dWeOdG/IGGOgBEK4mqsg/2ehzK7U+NmgADRs3qyMNbpn/gPgggPZU
         /Bls4H9byMwkjya0FOS2FStfVEx4sl8oZezuJLTHRLW+ELcL761aahzsQ/mQlmkksZXA
         6VCF2uj8j+M8kQo+C/3mR7W4LAkMhPz0o1LoxFM3b0AMSvpUgcst6kBVDJyEvnFlTuN3
         2EXQ==
X-Gm-Message-State: AOAM5319Wj5L7Cjta4Hu2j7dqkOt0eSt3ngrMvDDUw+8R1LScwOL2BDM
        WmFT/ozRzmrwgr9gUQhW10Eo0ptJupE5Kg==
X-Google-Smtp-Source: ABdhPJzNuHI7XdRTYgxqmmWaFsNDoP1WAofc8B682yrTxmEVHj14bMrSFLKbrV7oq+fH4/GitlPR2A==
X-Received: by 2002:a17:906:39d5:: with SMTP id i21mr2066874eje.339.1610555695624;
        Wed, 13 Jan 2021 08:34:55 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g25sm923943ejf.15.2021.01.13.08.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:34:54 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Fix installation of urandom_read
Date:   Wed, 13 Jan 2021 17:33:19 +0100
Message-Id: <20210113163319.1516382-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113163319.1516382-1-jean-philippe@linaro.org>
References: <20210113163319.1516382-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For out-of-tree builds, $(TEST_CUSTOM_PROGS) require the $(OUTPUT)
prefix, otherwise the kselftest lib doesn't know how to install them:

rsync: [sender] link_stat "tools/testing/selftests/bpf/urandom_read" failed: No such file or directory (2)

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 67cdf858f01f..0fafdc022ac3 100644
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

