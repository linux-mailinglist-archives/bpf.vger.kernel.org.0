Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF701C710F
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgEFMzu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 08:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728792AbgEFMzl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 08:55:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F5C061A10
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 05:55:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so2082950wrx.4
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DCoKl1/gaqXVRh80rwnARoKd5SOhiqEFIXtMsss+EA=;
        b=Zx2p/C9hj15+qgcVJRFWGUkWhPZBmn7s3xTUeUlwAFGrbu69FjVxlJOezY+biAfdrm
         BYyu/VuT3Dfl+StE+iSN2PvixBf88F3i8noAtwPCSUhANnvshvTCSWIs/IqPIT5pOZDS
         P+UZ6TR4AB6R8T+kxR7yuBQkH/+sJM5ZhmY2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DCoKl1/gaqXVRh80rwnARoKd5SOhiqEFIXtMsss+EA=;
        b=Ya3xHePhjBlELGaHNAA3jgWzexNDgZSVD0U71xLz3kk1Q5OxtMa8sT6Qhjms0Ao9vH
         oTQzPx0b9hlu+Nu+c4zD+PljHWOn5dTOp/UqbfrWskQh6rmze6TFDPXmcxjrvDOTtba1
         EdKWbobtb5tuvlMuOv1AIMCVtM9c0+o7k4kyY6aGyxG9tw8HSTfPcmKcBdd1KSjTKxnV
         4ive+XHXNqhYw3K1Mbff80/uNYpCtBGb8S9U7WEWIqYoz4eWb9e1pav0nbalAKb+3MzI
         nlkjtpXPslSUxcp0EeOMkdhmKFseI6eHoXG4bD8qx9dyRbTrIVn/73y2ZLdZfyCakjwl
         ED9w==
X-Gm-Message-State: AGi0Pub9zEoBLb1Fo0TqJNT9zLWUScqSGe4EjyAlAH8wpPJsheJjKqZs
        mRn6+Wiw/vElPtHJMxX320lH9Q==
X-Google-Smtp-Source: APiQypLBOnq5gamj0J8plk0NnUuN/zwsYh5Hj7hWEu/0YXLir2P+QthCsBdoqAAh8D0iUEovO5kuHg==
X-Received: by 2002:adf:b301:: with SMTP id j1mr9265960wrd.221.1588769739725;
        Wed, 06 May 2020 05:55:39 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id p7sm2776520wrf.31.2020.05.06.05.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 05:55:39 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     dccp@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 16/17] selftests/bpf: Rename test_sk_lookup_kern.c to test_ref_track_kern.c
Date:   Wed,  6 May 2020 14:55:12 +0200
Message-Id: <20200506125514.1020829-17-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200506125514.1020829-1-jakub@cloudflare.com>
References: <20200506125514.1020829-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Name the BPF C file after the test case that uses it.

This frees up "test_sk_lookup" namespace for BPF sk_lookup program tests
introduced by the following patch.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/reference_tracking.c     | 2 +-
 .../bpf/progs/{test_sk_lookup_kern.c => test_ref_track_kern.c}  | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/bpf/progs/{test_sk_lookup_kern.c => test_ref_track_kern.c} (100%)

diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
index fc0d7f4f02cf..106ca8bb2a8f 100644
--- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -3,7 +3,7 @@
 
 void test_reference_tracking(void)
 {
-	const char *file = "test_sk_lookup_kern.o";
+	const char *file = "test_ref_track_kern.o";
 	const char *obj_name = "ref_track";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 		.object_name = obj_name,
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/test_ref_track_kern.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
rename to tools/testing/selftests/bpf/progs/test_ref_track_kern.c
-- 
2.25.3

