Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A477219F53
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 13:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgGILwV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 07:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgGILwV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 07:52:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2CC061A0B
        for <bpf@vger.kernel.org>; Thu,  9 Jul 2020 04:52:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so1467884wmh.4
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2020 04:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgnLFkfDlMduGKE/ztPFGecYYc7s1DxZ/PWGRQJJLRs=;
        b=ZtbKjxMvYP/9FTODupwovxGroCNIJmYSlsUpzaQ0CEcJTMNqQB9k02e8gNtpuMlUGS
         YkOAXNIFqxplT/lIOV1voPg4Xw2jsXMdoOM5W+quL5iJp77pYnViJ+wsOj/m8VRnNOiY
         4lHtvYKQRtS7Msyq1+AbHrymke6YGaWmtisdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgnLFkfDlMduGKE/ztPFGecYYc7s1DxZ/PWGRQJJLRs=;
        b=GPRmZeWVOTg05CD5KQPK28w47SgJScLR+JXLYBOMuTC7c7CqqMKbJv2wiwLMwCCFw0
         yiLhJrowgRU66SDhj+FKpucFpeHY8ckf3OJIY3WHD02eu6p+SOpsu3cATuOZkWqS4e3F
         jngPtzZMNWZCgdas3aR32U6uRh4G72mktF4VJEFv2f87MzLRME98MhlEpRvbrNgop6GH
         kH5nXs4UXDqpmaoTUHiRG590BuH859sTmhQADfClBLXIRlDo+OsKOZ1W03MJGIQUdUZB
         oYyfEpbpw984SRp++boSN6rwcHsAk02RXmTF4L4KwhF50hWkNwX/aON+CSkaXFao6gl1
         1+qQ==
X-Gm-Message-State: AOAM533EHBfAxRMWKRK+mu0kn/5PVQ4BDDYZ2q0JPJgeB6XEov3b5oC+
        EMJaXvVtOoRZBRTRr8fzYrJk7Q==
X-Google-Smtp-Source: ABdhPJw2JnRN/XTa6+WZL2sIDnwotc3qUGVnnswUvYbo913hMwzPuzrdX231q7/X1v5wKPOQ0hYQ4A==
X-Received: by 2002:a1c:7916:: with SMTP id l22mr13271541wme.115.1594295539736;
        Thu, 09 Jul 2020 04:52:19 -0700 (PDT)
Received: from antares.lan (6.b.4.5.a.4.9.1.1.9.d.d.1.2.d.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8d21:dd91:194a:54b6])
        by smtp.gmail.com with ESMTPSA id u1sm6331001wrb.78.2020.07.09.04.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 04:52:18 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Cc:     kernel-team@cloudflare.com, Martin KaFai Lau <kafai@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf] selftests: bpf: fix detach from sockmap tests
Date:   Thu,  9 Jul 2020 12:51:51 +0100
Message-Id: <20200709115151.75829-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix sockmap tests which rely on old bpf_prog_dispatch behaviour.
In the first case, the tests check that detaching without giving
a program succeeds. Since these are not the desired semantics,
invert the condition. In the second case, the clean up code doesn't
supply the necessary program fds.

Reported-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: bb0de3131f4c ("bpf: sockmap: Require attach_bpf_fd when detaching a program")
---
 tools/testing/selftests/bpf/test_maps.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 6a12a0e01e07..754cf611723e 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -789,19 +789,19 @@ static void test_sockmap(unsigned int tasks, void *data)
 	}
 
 	err = bpf_prog_detach(fd, BPF_SK_SKB_STREAM_PARSER);
-	if (err) {
+	if (!err) {
 		printf("Failed empty parser prog detach\n");
 		goto out_sockmap;
 	}
 
 	err = bpf_prog_detach(fd, BPF_SK_SKB_STREAM_VERDICT);
-	if (err) {
+	if (!err) {
 		printf("Failed empty verdict prog detach\n");
 		goto out_sockmap;
 	}
 
 	err = bpf_prog_detach(fd, BPF_SK_MSG_VERDICT);
-	if (err) {
+	if (!err) {
 		printf("Failed empty msg verdict prog detach\n");
 		goto out_sockmap;
 	}
@@ -1090,19 +1090,19 @@ static void test_sockmap(unsigned int tasks, void *data)
 		assert(status == 0);
 	}
 
-	err = bpf_prog_detach(map_fd_rx, __MAX_BPF_ATTACH_TYPE);
+	err = bpf_prog_detach2(parse_prog, map_fd_rx, __MAX_BPF_ATTACH_TYPE);
 	if (!err) {
 		printf("Detached an invalid prog type.\n");
 		goto out_sockmap;
 	}
 
-	err = bpf_prog_detach(map_fd_rx, BPF_SK_SKB_STREAM_PARSER);
+	err = bpf_prog_detach2(parse_prog, map_fd_rx, BPF_SK_SKB_STREAM_PARSER);
 	if (err) {
 		printf("Failed parser prog detach\n");
 		goto out_sockmap;
 	}
 
-	err = bpf_prog_detach(map_fd_rx, BPF_SK_SKB_STREAM_VERDICT);
+	err = bpf_prog_detach2(verdict_prog, map_fd_rx, BPF_SK_SKB_STREAM_VERDICT);
 	if (err) {
 		printf("Failed parser prog detach\n");
 		goto out_sockmap;
-- 
2.25.1

