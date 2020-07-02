Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE0211FCE
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 11:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgGBJYu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 05:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgGBJYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 05:24:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC99C08C5DE
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 02:24:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so28466161ejc.8
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ybsptQ1uDuYH5yr/joHYcohd4KEboQtBfB059oe4Vg=;
        b=gSeEI8cQUCh9Chub/HLEFbCB1unWvLNij8kVX6/rIPneSZkht0ksnmozVCkE33wCEw
         Flc2SxfrzsuwnZBCzIOyYn4oPVzKul+ddqO5wWHfpOMEWPdnm+Tsu96bbCfrCJCUSbUH
         z9xzQq2FElY4yc+W2VNX2+Lt6zXqYzGMs/F8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ybsptQ1uDuYH5yr/joHYcohd4KEboQtBfB059oe4Vg=;
        b=EIIkrKzigWU+5/jUXpp25eByA8IZxF7squ3XpZ5VMGRTV7kfQsgi+8nGzLEK5Cw0gx
         tNkEFuDrreyqMWVUQy218HZUXYfXW8x5i/BSCmYDGvnqCMu5cOPO7y/w8u2t2f3C765g
         RPLMoxBmZRL5Z95dNzsekhAG9pGbvGQjh56W0kDb5rHtRSiV6wCtgqJjmzxQw/flHnMs
         eAVwAJ2OCBuj5YGh6pWvy1/3XGn+lWZHgAQ+mTIu+5kZC5Po96+Z+uVeAY8wglJUuJsd
         f078TpZMhf6a07d+x70KeDgzOlD0RpiwmWrNy1Q/gd7sVH8wAkYY3BRzzjAcH6Qe5m8N
         hmMQ==
X-Gm-Message-State: AOAM533I2+gp9WEBNSWfruGIO5iFGE5zHpgPlBtCRHTDKPrmuNX4AhLW
        XAulKTPyTHH7rJvHoXuQNJB+FsfRcj+2bg==
X-Google-Smtp-Source: ABdhPJzLGBXtzogWZ/UlSVZIMiV9loLF8MIVSP23mTF+TVAgJ2TBNZN5cFjAePuWK+5HFTwu4ly65A==
X-Received: by 2002:a17:906:87c8:: with SMTP id zb8mr26130500ejb.35.1593681884480;
        Thu, 02 Jul 2020 02:24:44 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id m22sm6519828ejb.47.2020.07.02.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 02:24:44 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v3 15/16] selftests/bpf: Rename test_sk_lookup_kern.c to test_ref_track_kern.c
Date:   Thu,  2 Jul 2020 11:24:15 +0200
Message-Id: <20200702092416.11961-16-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200702092416.11961-1-jakub@cloudflare.com>
References: <20200702092416.11961-1-jakub@cloudflare.com>
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

