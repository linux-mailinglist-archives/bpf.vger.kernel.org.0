Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8F3FF37B
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347172AbhIBSxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347157AbhIBSxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 14:53:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA0C061575
        for <bpf@vger.kernel.org>; Thu,  2 Sep 2021 11:52:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id e21so6661608ejz.12
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vMJ3l66MA4Xk2XsGDPJ11b5ddQG+LbfDZ98V6KBPYQ=;
        b=HMshDyA5AD2hzHbjOCXy+ZX8jQU060ulH3rVR+47CBw7XoQ7zmY/IBExe/BbX8UH9v
         aUAOF1PqA3Y9CXwCD3hxC3YoveRJCtt/GH9G+ez3ibwnELWu7ZMeSs4B/dySVlXOcHQq
         p05Gpp3jGLJgN1Lbu8tQP39Y13g7EQwxOzmytwR+rDpXEYhbcyoMZFmKHnVgXkPYyg3h
         aFDQhiPieTJ3tacvJ79z0fZPPgdMIhAKm4apOjSEljpQd+qJTg/pr5O36giI/fe6cKx5
         5zfj4xJAGgxAhOd/79398xGmaiI+wCDkXEQuLmKIqxR4XbtPg6wPbVbOwbfL3PjSD9WS
         LBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vMJ3l66MA4Xk2XsGDPJ11b5ddQG+LbfDZ98V6KBPYQ=;
        b=nI5X4QySZ7SoAyKsrAgmZ6qkZJi+96HAbXt2ywtwv6J0V5GveHITjaL3kszZP7eCfB
         tbHcY4OXmjX7O9rhdzVouo/DwzXSxTN6tzIBBkRyfuu1v+fGteVX80UBTf9blVWfdsrY
         PWqjD8uh1ORRwTrjURUV5NpgSEqNxtxlgGU8vsdMp5r8qmaOL9FZM+pNxn2TxEIwMLuq
         +WSY0Z5f6fv1yICPYqyRXjvbvmx0zNb83CI7peHJLNH8vb1eaPGEcfj/qzc5MZ57NZ4J
         VmHqw1StA/oMHQD0Bmk2Bz0YFuIMPnsCP2mHOl1ebzx5QM5/B93x/cpJupBV9yY52etJ
         +xKw==
X-Gm-Message-State: AOAM530pOJtVMb4lXerVrow3nn0ZUcrfhTlFjkFKQFSrShYWUSw+Xseu
        Os4CRDJ+FIrlLOQKQxXP37EB8A==
X-Google-Smtp-Source: ABdhPJwHXzuRomUNgWnX5fbnDPra+1Pll++a+DHLVw0EsYl+havcPAg1gUth3b/1lkzS48I9UzsIFQ==
X-Received: by 2002:a17:906:318c:: with SMTP id 12mr5196301ejy.28.1630608758791;
        Thu, 02 Sep 2021 11:52:38 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id mb14sm1592235ejb.81.2021.09.02.11.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 11:52:38 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        iii@linux.ibm.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 01/13] bpf/tests: Allow different number of runs per test case
Date:   Thu,  2 Sep 2021 20:52:17 +0200
Message-Id: <20210902185229.1840281-2-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902185229.1840281-1-johan.almbladh@anyfinetworks.com>
References: <20210902185229.1840281-1-johan.almbladh@anyfinetworks.com>
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
2.25.1

