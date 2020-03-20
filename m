Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67118D8E2
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 21:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCTUPh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Mar 2020 16:15:37 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39586 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTUPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Mar 2020 16:15:37 -0400
Received: by mail-pg1-f202.google.com with SMTP id g8so5370575pgr.6
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2020 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cYz23g/CFLbPXVzWejmKrzz74ArcrCY1kvAUgiU4uy0=;
        b=PEvQAtpo7XHDm4al6HAo+lHajq8y4KX7ib2M9Q7D994L5ZSfIUkcucR0IwxnmHoVQJ
         /97KHzawCGbxfP6/M5HUq8Mf5YrIScvEN8pDh/VnQLWVWHbwqozimVr1b58+ZQYz3THH
         Op+5fiRkC04tOgnG6JGj/dwHU1idIsSO3PlbZYpuHdkTKrMRL90UHGmZepSxutvnPCG7
         QPprpi3WBbwCGRqh2uNX7EyTjXhPmCkb6txSb0vyAnPeCWmTUEMYtl6U7p2cC/ze+ds9
         WgISA8nNjuP3B5pEbwaD29/CqxQxbpUaUK72qPZDSi3eXDEQf+4kWJrdHZYsdjcM939T
         IEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cYz23g/CFLbPXVzWejmKrzz74ArcrCY1kvAUgiU4uy0=;
        b=YyI2Y460Y2OzNVrWIhI46zLk4G7+uAdtRwOb6fXL/x9bkTZolsicEk+KF0NQKaHrTS
         NMza77hbUFAgOdgz/IpQFGWmA1Qt68APc9APQ8JrpY/67CetDzSHvlB55zmjm+5Aa9ZC
         D9snmXzknhLz+8xm5sSWTb4KOCZRgjXE43a2+tij+BpZ6NkJw0Qvu5F7tG6fiYNf43yM
         /wJWZiqVLvx2mLr020Y7lFNkpJYd9hYhQPJR5AqNhDX2P/FiJG/70EiOFsT6e/TrUxvz
         Z6CjAQ+SkwzT4uqgKwwGaKvNQKNKaw/BBPL08Ir+/3VpwjmEBs+F5n1YxP1ZhKvT6FeA
         lgLA==
X-Gm-Message-State: ANhLgQ1gda0IkHPFUJD+89j8V4wjTCo1Wk23EIrP78UdkpIP7jmwv/HL
        LD97X6TTBk4WiHcOQID50ubckrVThkkcoFzEbajdOT9gqcgXGoaZb6N7g0jVr5D8kz2oldZBFPT
        0YjhB4+roekwkuiKQcdIq5gEMGrMXMuU4tov7pjOaoXeUiVM5LcESuQ==
X-Google-Smtp-Source: ADFU+vs+6xS6vTWj6W25cCzNkm8MLwFQBji1PIQgkK+k+OktNjESbZzgpJGL5iIy8wzIhD25ha+/oDqizA==
X-Received: by 2002:a17:90a:da01:: with SMTP id e1mr11752469pjv.100.1584735334220;
 Fri, 20 Mar 2020 13:15:34 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:15:10 -0700
Message-Id: <20200320201510.217169-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH bpf-next] selftests/bpf: Fix mix of tabs and spaces
From:   Bill Wendling <morbo@google.com>
To:     bpf@vger.kernel.org
Cc:     sdf@google.com, gthelen@google.com,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clang's -Wmisleading-indentation warns about misleading indentations if
there's a mixture of spaces and tabs. Remove extraneous spaces.

Signed-off-by: Bill Wendling <morbo@google.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 7390d3061065..cb33a7ee4e04 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -125,6 +125,6 @@ void test_btf_dump() {
 		if (!test__start_subtest(t->name))
 			continue;
 
-		 test_btf_dump_case(i, &btf_dump_test_cases[i]);
+		test_btf_dump_case(i, &btf_dump_test_cases[i]);
 	}
 }
-- 
2.25.1.696.g5e7596f4ac-goog

