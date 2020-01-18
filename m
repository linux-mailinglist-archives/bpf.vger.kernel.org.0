Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59792141554
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2020 02:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgARBFu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 20:05:50 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:44573 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgARBFu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 20:05:50 -0500
Received: by mail-vk1-f202.google.com with SMTP id k16so10358439vko.11
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 17:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h6UZKEGdiRrN83ws0HUMDIaa+g3hnaxBrJoxeBmwwDE=;
        b=Mqa+GIogWftqv0rXcHjdMD7tacWdZVv08hgfuWoWgOtkku2JFwEJ/bY6Y+brh5ivUD
         Xd4OU8IVWEKnsf/RN6IUNJMWVVxPrBpCbW67rduGi87B3IiBP6oHN275OPPLJFyppktO
         +oYzmZ4doRIC8g/Q2hOkILQyBD98bKuGCaUlIPwwsjZslya5hHTWCnUgH9ATeleRGOrB
         YMCHURy8DRTillA4A3TupVDf/Y4sIF5fZzfubQn4g/KBBgQCg2Hh4y+dtrJhmAmay/xN
         Dn0cBYvdW19hkJEwKdf2v3DcbL6KhA8b4q9OyTV50odnSk4Pxy0k+JZ66GGF614aVZef
         iGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h6UZKEGdiRrN83ws0HUMDIaa+g3hnaxBrJoxeBmwwDE=;
        b=fWv69GdLD4Pp45Vpobh0udNVivfyOU2FVzhW1g+cImtQPtaPfbop1jDgdZtlsYG7yZ
         M9vc6+efZvDrHx+ZOott0UMxkVR7YFdeSWvzeoCLjQnXQiHbH9MQeQbvsapvakwYMuMV
         gwubfqH5tB3xvNW3XqaaHf8YyQcBkL0r0fGr6ilg0Pu9zsdBKy3gba52W4qLDFWU8Yio
         AcUL/RAtvGJOjGxbqX53w0OiRnvmOms1X7lppoT1ZHklHbyC664PQHMnalKKzRnFhWDi
         GTWQG3fK4hd1HjUmlzq1V0tzqqs0wBXJRogzlkkClccRMUmufLYu8L47/nQT9sH40JTp
         3HDA==
X-Gm-Message-State: APjAAAW0nbmX2GzFprKQ8oY41EtqkHq1ThmdRmvfEGCA+QnMLmdYoLp4
        rxl7J792VW83aKcXEF52Qn9ShXU=
X-Google-Smtp-Source: APXvYqwegHDLxEN8dlTlm36QG9n4noUGaV8D7tdqv+KHgBxvPQ5tU4Qyf8clAtORan9eTdPpIB/VjoA=
X-Received: by 2002:a1f:8f44:: with SMTP id r65mr4070061vkd.8.1579309549321;
 Fri, 17 Jan 2020 17:05:49 -0800 (PST)
Date:   Fri, 17 Jan 2020 17:05:46 -0800
Message-Id: <20200118010546.74279-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH bpf-next] selftests/bpf: don't check for btf fd in test_btf
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After commit 0d13bfce023a ("libbpf: Don't require root for
bpf_object__open()") we no longer load BTF during bpf_object__open(),
so let's remove the expectation from test_btf that the fd is not -1.
The test currently fails.

Before:
BTF libbpf test[1] (test_btf_haskv.o): do_test_file:4152:FAIL bpf_object__btf_fd: -1
BTF libbpf test[2] (test_btf_newkv.o): do_test_file:4152:FAIL bpf_object__btf_fd: -1
BTF libbpf test[3] (test_btf_nokv.o): do_test_file:4152:FAIL bpf_object__btf_fd: -1

After:
BTF libbpf test[1] (test_btf_haskv.o): OK
BTF libbpf test[2] (test_btf_newkv.o): OK
BTF libbpf test[3] (test_btf_nokv.o): OK

Fixes: 0d13bfce023a ("libbpf: Don't require root forbpf_object__open()")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_btf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 3d617e806054..93040ca83e60 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -4148,10 +4148,6 @@ static int do_test_file(unsigned int test_num)
 	if (CHECK(IS_ERR(obj), "obj: %ld", PTR_ERR(obj)))
 		return PTR_ERR(obj);
 
-	err = bpf_object__btf_fd(obj);
-	if (CHECK(err == -1, "bpf_object__btf_fd: -1"))
-		goto done;
-
 	prog = bpf_program__next(NULL, obj);
 	if (CHECK(!prog, "Cannot find bpf_prog")) {
 		err = -1;
-- 
2.25.0.341.g760bfbb309-goog

