Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370B52F3284
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 15:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbhALOCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 09:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbhALOCx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 09:02:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBC8C0617A4
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:30 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n26so3654830eju.6
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVnHIa5MKIrkM7yQ7+elQ2gqys62rHElWs015noXyHE=;
        b=DF5ZMmdb3jZoY4pEbqX1uelmAk7NcR3nJR6yDml7uEpzoztdllkzC7j+8pUkL8yjSz
         JyTOXA0W80PauKvsFCV6KfkGAhFccPQ5eQbjAUo9oA1R3Er0VQNTYq8Av2fQBNxdts8G
         Y1GB7O6jsiM8fOk3T1RegNNQ+lfEhqbe5XZLKjPGW6+goc4C0TzOyjDJEQT+4GHji/fv
         kM0QaAvJO6mi70+zYycP+Xe42QZeYHUXNJQbcIxBVoILMYdAMLkYFJz34yCpjAGAbnM0
         JOz0Z7rHwQuvCN7hHlYx8xarA3QnEGzVrKdVmFC0myaz0cCVFL4wKxCKqwLxtV+GdNRn
         8ftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVnHIa5MKIrkM7yQ7+elQ2gqys62rHElWs015noXyHE=;
        b=uGaAapr0iAjiemxotS0BaVDCjQe0AVbM2wf9kmgPxXlxhQRnclte1CAyio2rENAPVa
         nha8MLN35IT06RfxH6+NS+RMziMxPnwZx649TRBDr0+UdKf0PbzwcqL/0TTgIorA4E7N
         znHMZYrAUR1JAHFUopugEFHXzUICwv42ZDYrHBWiC18s9TVf+Ep5vSFW+mXs3hdSAAQz
         izlQ9Wv3Vp9+zK3fyP8RrmuNB/Svy59tZxLh91893jzYMfCvl+oLAVOsO7e2k/ZDbWpB
         7uyqXWLVyNXr3Ls5jdJvrHoGN4bYc1KJaqGJ5R8lU/dU8okFkIPKIjLn7fCPPJlKmuaG
         fuAg==
X-Gm-Message-State: AOAM533jCJXlouF4UssAFn33bEsmdGPYXKpK8H7K2nN5ERyulIt80YSW
        HNhXOvhpwrVkcrm95non+v+uP9iHtysU/w==
X-Google-Smtp-Source: ABdhPJzFoQB6KPlQ6aSDFWMIEiNXeeFs+7Yv+hnopfnZsq+8P31aROYWtLreexou2fixGiC+q1K3UA==
X-Received: by 2002:a17:906:f85:: with SMTP id q5mr3358548ejj.105.1610460089144;
        Tue, 12 Jan 2021 06:01:29 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t19sm1227846ejc.62.2021.01.12.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:01:28 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 3/5] selftests/bpf: Move generated test files to $(TEST_GEN_FILES)
Date:   Tue, 12 Jan 2021 14:59:58 +0100
Message-Id: <20210112135959.649075-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112135959.649075-1-jean-philippe@linaro.org>
References: <20210112135959.649075-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During an out-of-tree build, attempting to install the $(TEST_FILES)
into the $(OUTPUT) directory fails, because the objects were already
generated into $(OUTPUT):

rsync: [sender] link_stat "tools/testing/selftests/bpf/test_lwt_ip_encap.o" failed: No such file or directory (2)
rsync: [sender] link_stat "tools/testing/selftests/bpf/test_tc_edt.o" failed: No such file or directory (2)

Use $(TEST_GEN_FILES) instead.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3ff7e79cc497..046848c508d1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -44,10 +44,9 @@ ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
-TEST_GEN_FILES =
-TEST_FILES = test_lwt_ip_encap.o \
-	test_tc_edt.o \
-	xsk_prereqs.sh
+TEST_GEN_FILES = test_lwt_ip_encap.o \
+	test_tc_edt.o
+TEST_FILES = xsk_prereqs.sh
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-- 
2.30.0

