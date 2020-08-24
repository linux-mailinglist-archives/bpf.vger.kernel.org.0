Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B163924F90D
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgHXJkj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgHXIpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 04:45:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A23C061573
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 01:45:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so7513082wmi.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kr1c3haT1yhxfl33XmTaSeXi33h/k6BkkvRpBNN6lwQ=;
        b=MB9S7b84pla+BcD84lZT3P3lcWv5hFKe/OmZWr/j6lT3iPORefJiqMEKXuN0fjX0xo
         ND+USgWsApxiI9xGI2VhDWpIYbX/HiS74u8N7aHlhlcrts7l/eBG5rGzARwbAzT99Wyi
         HUPOiI6wQa8vHsP3vDYKDT2SOHe8XPwliUqhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kr1c3haT1yhxfl33XmTaSeXi33h/k6BkkvRpBNN6lwQ=;
        b=ONcsfcSj+AFHxllvDtD8OW7FTdWMEsRsJvRNBYMaGJHLIJlDuPNsHGt1TWQUZ1nt1J
         dwWJpYSy3+vDQFVzgIwWIzi5x5x9qoUh8FkW7dhh7n3vSvspdNsx77b/aIe+oXQNUzdN
         E0ruNHOlDFUK+KGqinQQdkt1e9VOUMdVbxOpo68QO2wk+IIrd/uDe2rIKyRxdGMVxOlD
         XQaL2DVQeQu0ZzfDzhktSgsJhUF8TKHr/+4qyXLDx+Dv24tynTDEZFUs5kzok4hxbVfo
         98C0OzFV/xF9kLuD1hkKbRKDxKS+aezeTvrhHhjtjMvN++dsU9v8XuxD0a87WZDcNHQX
         mZyQ==
X-Gm-Message-State: AOAM5322jFMGl1iZ1ePC1Uvd9fL7sfqgK9cIJlg/qRO8tCo90HZ7d0qo
        HuHdsEVexv0OqWvcHk4RBgzRog==
X-Google-Smtp-Source: ABdhPJx8dImHvW2WWOV9cX7FzTbLm1HFOCVVN/8wMcBEsm4gnokQEx+mxngPfhEVF1w1Nmd0+jGx+g==
X-Received: by 2002:a1c:818e:: with SMTP id c136mr4802397wmd.170.1598258744015;
        Mon, 24 Aug 2020 01:45:44 -0700 (PDT)
Received: from antares.lan (f.b.d.5.c.0.0.9.c.8.0.f.d.9.d.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:d9d:f08c:900c:5dbf])
        by smtp.gmail.com with ESMTPSA id t70sm40377848wmt.3.2020.08.24.01.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 01:45:43 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next] selftests: bpf: fix sockmap update nits
Date:   Mon, 24 Aug 2020 09:45:23 +0100
Message-Id: <20200824084523.13104-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Address review by Yonghong, to bring the new tests in line with the
usual code style.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../testing/selftests/bpf/prog_tests/sockmap_basic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 65ce7c289534..0b79d78b98db 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -118,10 +118,8 @@ static void test_sockmap_update(enum bpf_map_type map_type)
 		return;
 
 	skel = test_sockmap_update__open_and_load();
-	if (CHECK(!skel, "open_and_load", "cannot load skeleton\n")) {
-		close(sk);
-		return;
-	}
+	if (CHECK(!skel, "open_and_load", "cannot load skeleton\n"))
+		goto close_sk;
 
 	prog = bpf_program__fd(skel->progs.copy_sock_map);
 	src = bpf_map__fd(skel->maps.src);
@@ -158,8 +156,9 @@ static void test_sockmap_update(enum bpf_map_type map_type)
 	      dst_cookie, src_cookie);
 
 out:
-	close(sk);
 	test_sockmap_update__destroy(skel);
+close_sk:
+	close(sk);
 }
 
 static void test_sockmap_invalid_update(void)
@@ -168,8 +167,7 @@ static void test_sockmap_invalid_update(void)
 	int duration = 0;
 
 	skel = test_sockmap_invalid_update__open_and_load();
-	CHECK(skel, "open_and_load", "verifier accepted map_update\n");
-	if (skel)
+	if (CHECK(skel, "open_and_load", "verifier accepted map_update\n"))
 		test_sockmap_invalid_update__destroy(skel);
 }
 
-- 
2.25.1

