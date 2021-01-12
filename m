Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D58D2F3280
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 15:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbhALOCt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 09:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbhALOCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 09:02:49 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D255DC0617A9
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:32 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d17so3638686ejy.9
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvv6LYFe9mpH/hRqRunavAEnNPwum4yHEeubUaepqPU=;
        b=fn2ddKJCzrB+l+1z5m6+nd4SmL9wKXkYV+xVkkUqLTNa4Gz0Bd7PZagGEkM0+Q7TeY
         t5XSjayvP+lEzr3klD/WCkA+RDf0RXTd+/MLvozm/DsrzqOZeWQVz870uCBMwCTeM8kQ
         S3RoufZj7egVsb1Bhu8vN25HMOJ4GFFb0IvssDiwCQ/1siQs5bg265M8zhwwRzszMvZ1
         ysS6R3KpZeaq8yrZROExzfBJKUToRGL+Ylm7U+s53fIfLwspoTw0NmrSQv4o4ddH2eaC
         JjGRAxMGu/MZNHleKPa+mP/bvCrKRXtFbw6PxiqVp72wgpHE7LFnyCsf6pmmL9Vb1vXW
         hvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvv6LYFe9mpH/hRqRunavAEnNPwum4yHEeubUaepqPU=;
        b=iX84cyEdQxOW+A6Kl53tf+HfREnp8nuWNbBHAXLq4EuOhG/SE+21Nxfh9oTZFoXFeu
         BFwOS+BcZWBpfRLNoNFNFbZ8L8G10OFLI4i3GWjXVzZQIPIVK87aftfQ8LeiGd1zNsV5
         qd2wXexCF/zOP9lwYTdpce+du4qAx/VvQv616jOWC9OfaQFtyVvdy/HqIc7DoMN9U9mi
         61j92B9ziy869zo4vhjCMxBNxLzL6/H8iU2NHJvqUYV69JfAXuGdRGX5uIuA9BvKKLQk
         dMFU3S+NqRm+roGXnc0JvHJu/lyvjTEA2b+clJ9efx9kp4pEo0L4/gbaIctYybundBBk
         +Hwg==
X-Gm-Message-State: AOAM531adPOY88QGIGLQ6HozjNZHGPL38BBjZY/Pc2z3eZUO23ibrokg
        wNniN0/K/Z1b0qa6ttKJ8B8dj33rZotjbw==
X-Google-Smtp-Source: ABdhPJwHhtArJNQO66nuPMhZ8rDohJ7fWuQZz4+N1PD7Jl5K4O463zt25M/pYaw97ww/zijrHaDCvQ==
X-Received: by 2002:a17:906:d209:: with SMTP id w9mr3259794ejz.211.1610460091282;
        Tue, 12 Jan 2021 06:01:31 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t19sm1227846ejc.62.2021.01.12.06.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:01:30 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 5/5] selftests/bpf: Install btf_dump test cases
Date:   Tue, 12 Jan 2021 15:00:00 +0100
Message-Id: <20210112135959.649075-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112135959.649075-1-jean-philippe@linaro.org>
References: <20210112135959.649075-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The btf_dump test cannot access the original source files for comparison
when running the selftests out of tree, causing several failures:

awk: btf_dump_test_case_syntax.c: No such file or directory
...

Add those files to $(TEST_FILES) to have "make install" pick them up.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index bffb4ad59a3d..fb8cddc410c0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -46,7 +46,14 @@ endif
 
 TEST_GEN_FILES = test_lwt_ip_encap.o \
 	test_tc_edt.o
-TEST_FILES = xsk_prereqs.sh
+TEST_FILES = xsk_prereqs.sh \
+	progs/btf_dump_test_case_syntax.c \
+	progs/btf_dump_test_case_ordering.c \
+	progs/btf_dump_test_case_padding.c \
+	progs/btf_dump_test_case_packing.c \
+	progs/btf_dump_test_case_bitfields.c \
+	progs/btf_dump_test_case_multidim.c \
+	progs/btf_dump_test_case_namespacing.c
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-- 
2.30.0

