Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9D1E9652
	for <lists+bpf@lfdr.de>; Sun, 31 May 2020 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgEaI3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 May 2020 04:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgEaI3L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 May 2020 04:29:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D504C03E96A
        for <bpf@vger.kernel.org>; Sun, 31 May 2020 01:29:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p18so4946495eds.7
        for <bpf@vger.kernel.org>; Sun, 31 May 2020 01:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGqQQLJZNiH0SmZKXWhQ8n1ub32eRDUtUafh9Us+7UA=;
        b=CjyJFvhAsfVbQfOMeT6d0aTWjLYK8Apz/ND3Jzqa3QpIg3BGGnc70OC7O+P735czf/
         B07rnvj9E3XpINJplm30aEGCldCydqnPr+cD679+iIJ8OXruljp7xXHsmNwNCMCSZXzI
         ZpxZeOunaUYwccN6zUJy+ci9hUNGvvN+D/mbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGqQQLJZNiH0SmZKXWhQ8n1ub32eRDUtUafh9Us+7UA=;
        b=eKR87q+QPeDG0jn4oUisaImFbNj9bfLF2xfsIKPcmdiXYRtM9OczMsEu5t64jG1SZ4
         7YrJprGod2ukJ3Oy191hEfA0pvuFekDA039O9anq2nBRvG5ahs8IK2Op15OHUKpgdV94
         pYtb9YLiYnDZP3kgI1rFeOkuK2OqKoJ5V2lH5Cfs3HdHOmPe7+4QRnUodzGKKgI9SNQL
         J+bkrymzyFk1OeUTypfdS9U7+wflDL1ZAzT3d/ER9nbtDWCEMU2VN3ILna7YzQuY83O/
         k+elxScjzwRz7xXj0k2bShcxZlMYlqsGUAb+TNhwa+v9gKiNlkubp+BaAxTNUtlYzGgu
         eFpw==
X-Gm-Message-State: AOAM533Ee03CseyzlxuZdpfDftQBssEww+LDlZhdEw2IcYFaru0suZoJ
        FMcZjxP6chsGGedjx2CzhoXDXdOfkIk=
X-Google-Smtp-Source: ABdhPJw315dJM9Jh+mSn0n0nXJsaftPABoviI2ImZLzzPByCPXY23mX4dEj8/i/itn8f18M6vCg5ig==
X-Received: by 2002:a50:d785:: with SMTP id w5mr15813809edi.212.1590913748588;
        Sun, 31 May 2020 01:29:08 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id s14sm1117951ejd.111.2020.05.31.01.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 01:29:08 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next v2 10/12] selftests/bpf, flow_dissector: Close TAP device FD after the test
Date:   Sun, 31 May 2020 10:28:44 +0200
Message-Id: <20200531082846.2117903-11-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200531082846.2117903-1-jakub@cloudflare.com>
References: <20200531082846.2117903-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_flow_dissector leaves a TAP device after it's finished, potentially
interfering with other tests that will run after it. Fix it by closing the
TAP descriptor on cleanup.

Fixes: 0905beec9f52 ("selftests/bpf: run flow dissector tests in skb-less mode")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 2301c4d3ecec..ef5aab2f60b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -524,6 +524,7 @@ void test_flow_dissector(void)
 		CHECK_ATTR(err, tests[i].name, "bpf_map_delete_elem %d\n", err);
 	}
 
+	close(tap_fd);
 	bpf_prog_detach(prog_fd, BPF_FLOW_DISSECTOR);
 	bpf_object__close(obj);
 }
-- 
2.25.4

