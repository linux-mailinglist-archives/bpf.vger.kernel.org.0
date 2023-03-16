Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989946BC222
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 01:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCPAIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 20:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCPAIE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 20:08:04 -0400
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00705CC02
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 17:07:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678925257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPw6xw1b4jxGffhayCMauj7aFETYWgoH1iHiKreyEYk=;
        b=spvhnXL0RctEQE2O4PHePKj8OvsLsopKXvYr78DvbChBCOWT0ooQD2OcCRdh/wiNH68wlX
        vC0IS/bPv+dLieVfteVulqL1waPLMV3xuqCU1optGr7vET+2lwB+By+auZ7SsU4fiQEV0y
        UDigEjqCAhemBrfKg1cW+oETkicV49w=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Fix a fd leak in an error path in network_helpers.c
Date:   Wed, 15 Mar 2023 17:07:26 -0700
Message-Id: <20230316000726.1016773-2-martin.lau@linux.dev>
In-Reply-To: <20230316000726.1016773-1-martin.lau@linux.dev>
References: <20230316000726.1016773-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

In __start_server, it leaks a fd when setsockopt(SO_REUSEPORT) fails.
This patch fixes it.

Fixes: eed92afdd14c ("bpf: selftest: Test batching and bpf_(get|set)sockopt in bpf tcp iter")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 01de33191226..596caa176582 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -95,7 +95,7 @@ static int __start_server(int type, int protocol, const struct sockaddr *addr,
 	if (reuseport &&
 	    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on))) {
 		log_err("Failed to set SO_REUSEPORT");
-		return -1;
+		goto error_close;
 	}
 
 	if (bind(fd, addr, addrlen) < 0) {
-- 
2.34.1

