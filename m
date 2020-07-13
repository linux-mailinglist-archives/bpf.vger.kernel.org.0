Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B5621DF14
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 19:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgGMRr2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 13:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbgGMRr1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jul 2020 13:47:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E3AC08C5E1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so19004852ljm.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ybsptQ1uDuYH5yr/joHYcohd4KEboQtBfB059oe4Vg=;
        b=FxObrd5yQWq6ZMDTHzPP1ehrdv0JRCKwevvJG2XyGrLv25bYbEr+6GqSpjuI1zG91D
         KxRe1uM1CrJSHG7rcUGkJMK9iAu+Lrt2Nzz7ym2JT/fDxcn0kWz7E/UvqHQyvsRpX0PS
         XkW1OXMuCPdEEiGUCFfnCPzfoGu4qJ9aZa7FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ybsptQ1uDuYH5yr/joHYcohd4KEboQtBfB059oe4Vg=;
        b=hUQs6uVQAEoWaz9UC2vOSpKwR+MXkTM80zgoauPA/QgiXiSX6BXyBK7PbHMZ1yy1z3
         aqHwRn88NIs5NzNrJijGc5hXgZUvh0bZWsI1rYY3qJPDvva0vjemTuinCjSE0vG1Q5C+
         dRU7RBxLJGuaf2MHYSg95Z/d8eG0Oqj68JtDdJLvcZ3KGphVqKL5zC/ACmmMI9IuJiEk
         Q4cGaRTFaLIc4segJHsjvxiqi23FoY3Z7a6Ws+XSEQtFX4FKW2MeqAzLdnpZIePhvWkj
         vt6w0jVCSBybAn/7ZpKWNjlgOD39OlLXwl9WmPhYwENumFSfnPxxCCGG8LIFB+arIVsR
         cbqQ==
X-Gm-Message-State: AOAM531cr6980bcI6ABqH3bb5O7DMIbAIiHZfdw4benz79ViUt23fvbC
        dXP+ylVYFaSwQR8wczHz1N/rtv8fpVfhRg==
X-Google-Smtp-Source: ABdhPJw4XghKF8wejD8Baxl8SdCIahGaAt0NbnbabRhRsbM3aemz1CoXDjje9sYW2csvK2oOWdZlOA==
X-Received: by 2002:a05:651c:8c:: with SMTP id 12mr354416ljq.420.1594662443573;
        Mon, 13 Jul 2020 10:47:23 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id j25sm4737668lfh.95.2020.07.13.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:47:23 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v4 15/16] selftests/bpf: Rename test_sk_lookup_kern.c to test_ref_track_kern.c
Date:   Mon, 13 Jul 2020 19:46:53 +0200
Message-Id: <20200713174654.642628-16-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713174654.642628-1-jakub@cloudflare.com>
References: <20200713174654.642628-1-jakub@cloudflare.com>
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
2.25.4

