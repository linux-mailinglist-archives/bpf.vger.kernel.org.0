Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818C140AA90
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhINJUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 05:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhINJUX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 05:20:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2533CC061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v24so12594756eda.3
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lLX1fHB6jaPieI1cPC3xc4QwmyAR0d5okYwLH3KQR4=;
        b=IOtyXgrMiTJfRYo85ReSyTUxldt5LjhcLWmtxvyXiq/lbNceySnHAed0D47Ca5KpEE
         xuOx0sXzNrXJUe1PaYIqGx+xLSnmbWqVzIMnUXjmyGV4pyRLasTFuBWsbhV2JyY62KBm
         BtIyAGdqjwU60tX1QGKIDpAOVcfX9Kt+xb+49ahudnAbPy5cz0QlCXG8eDVFAyaLpKcb
         VrKA8+Cf4PmJ0DgMJX0rY7AOKyrzXzmdGdqciqJHv1QvSrKqqizn3ImA97PWazgyvuAV
         8KoUIPJ00kMiGxSTZ3aLaN16SK4hNTWiEY6CJ6+Ii3IJ5hdYJkW0d+QGN/bmYG6Au4/0
         coBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lLX1fHB6jaPieI1cPC3xc4QwmyAR0d5okYwLH3KQR4=;
        b=F/X1tamGfY7jU3YgaDzEGByF++d9892Ar3FdmDgJTXNXRzn7nF8weuagRYnqhebdkF
         qNrGhAIFomVhPZz2hEy5fD4JgFd2q11KWYTmWD/ESrIVLS85jI2EsFpXy1aKqzu8Sgbn
         +MWLfIyXaw2sYyUm9x7hvewVVoKjzUyJ08LonUcQMmMTk3HFXciDCHw72rM75jIupQR9
         J119iq/eGpyyuVZwbVDz5wV2VNUMUN8jybJB0aKSLyzmJxuEAVKt0vx2/AT7EVmetIQV
         1FXB2Wo/3L9vUr5R7bdszy+AH6I2e0LuU+F2JR9guheuQ2UjeR1Scctt6zrEIUq9M09A
         ll9g==
X-Gm-Message-State: AOAM530aBWq6Zx5DFU3snhVvgfSLXIQOTFd3b/xbZ9Erpp7LTONbC3O/
        VYJ5TIDncwmAIHlYkOY9nm0ZuN8YmyiGFlQb
X-Google-Smtp-Source: ABdhPJwIASC1PWDPaUUl945yOTo5rurpNt479RGus3BqJ0SrwWoUpv1Yehg+e0fANjDUSA+3zPys6Q==
X-Received: by 2002:a05:6402:1c87:: with SMTP id cy7mr6898098edb.311.1631611144789;
        Tue, 14 Sep 2021 02:19:04 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id h10sm4615915ede.28.2021.09.14.02.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:04 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        paul@cilium.io, yangtiezhu@loongson.cn, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf v4 01/14] bpf/tests: Allow different number of runs per test case
Date:   Tue, 14 Sep 2021 11:18:29 +0200
Message-Id: <20210914091842.4186267-2-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
References: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch allows a test cast to specify the number of runs to use. For
compatibility with existing test case definitions, the default value 0
is interpreted as MAX_TESTRUNS.

A reduced number of runs is useful for complex test programs where 1000
runs may take a very long time. Instead of reducing what is tested, one
can instead reduce the number of times the test is run.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 830a18ecffc8..c8bd3e9ab10a 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -80,6 +80,7 @@ struct bpf_test {
 	int expected_errcode; /* used when FLAG_EXPECTED_FAIL is set in the aux */
 	__u8 frag_data[MAX_DATA];
 	int stack_depth; /* for eBPF only, since tests don't call verifier */
+	int nr_testruns; /* Custom run count, defaults to MAX_TESTRUNS if 0 */
 };
 
 /* Large test cases need separate allocation and fill handler. */
@@ -8631,6 +8632,9 @@ static int run_one(const struct bpf_prog *fp, struct bpf_test *test)
 {
 	int err_cnt = 0, i, runs = MAX_TESTRUNS;
 
+	if (test->nr_testruns)
+		runs = min(test->nr_testruns, MAX_TESTRUNS);
+
 	for (i = 0; i < MAX_SUBTESTS; i++) {
 		void *data;
 		u64 duration;
-- 
2.30.2

