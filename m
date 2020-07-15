Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C692217E5
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 00:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGOWlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 18:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOWlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jul 2020 18:41:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BEAC061755
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 15:41:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d202so4769412ybh.12
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aSU4Bs0Q2l7iGfbtpqfDDGNT0dqQhvTHqnXOF17Zkrk=;
        b=F7SPEUohE3HsmFaoxDiGmdi7AvIDvxiDvnfQu1nMBZkwP0p/6CQ2/BVoazmn3S+2Jq
         r4Fh7ph8qwysbFPPElb2XoBx+YMa4WjzjL+E/twPtyVuIFGkaEiAV9w9cCHTz+JWATdh
         0t1qL0cfGQUuGWwmzrWZWIsyl8xv1DJ3urC3QfmiDvZIWn1nA7LA4dgubvylQ3Kkf2k/
         nR8yofojpGihaPy4N6wr5S63MZBX7r4OH6XXm4b7SYvd9jQeQR6euGwfdtSLjag9F6dY
         6ITKL8l9DM2HC1OB52HIYJ6bEnUdBD36jcDJGePBscLpO1OLBJ7PCqfwDQ1gyEMzAQMR
         SNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aSU4Bs0Q2l7iGfbtpqfDDGNT0dqQhvTHqnXOF17Zkrk=;
        b=KIi7lczXeLgaEI/n5lbcquKHenWpL/xXCUd7KZ42d+anWJqsvS2NN47O19LywyjiHm
         4r+O6fGDeS1+3Tmz76yNXyQR+0m6v4lw1s/1U/bh/GEmxi3LaQW+OsGAb2helANj/aV1
         +b69ok1Smmi1QRZHJ/hfoeOgNAj+8Vy9gvj0pPGcSGT6cOOh0knUOjoUq3/1odWSL9j+
         Dmm4XJiWwLptsbNR73UNSVyItO19fkb5P+6ZpylFQ8BaJpNtf2vQcZ4Ebc5lrrZc8xvQ
         LE7+gtxy5MbdhKQ+OJs/QeOqE80ome+QFYJbGytmpP+lLBmXSOH3I753He8jrgJL71eN
         j+uA==
X-Gm-Message-State: AOAM533jlDV6UzBBIJ7gR7cw2etovPBItBdhEUXm9mCSJ/0ldZTQcLTR
        HwKaZLWTqud9ihh0kozMEj07oUs=
X-Google-Smtp-Source: ABdhPJyC3Gfw5x0x2bT4vx1BrrDQUHAjHWVkvT7gYBWbFuIUvf4eH5pg15CftZTfweshiZ+U2jFCllo=
X-Received: by 2002:a25:4246:: with SMTP id p67mr2083832yba.385.1594852869523;
 Wed, 15 Jul 2020 15:41:09 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:41:07 -0700
Message-Id: <20200715224107.3591967-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH bpf-next] selftests/bpf: fix possible hang in sockopt_inherit
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii reported that sockopt_inherit occasionally hangs up on 5.5 kernel [0].
This can happen if server_thread runs faster than the main thread.
In that case, pthread_cond_wait will wait forever because
pthread_cond_signal was executed before the main thread was blocking.
Let's move pthread_mutex_lock up a bit to make sure server_thread
runs strictly after the main thread goes to sleep.

(Not sure why this is 5.5 specific, maybe scheduling is less
deterministic? But I was able to confirm that it does indeed
happen in a VM.)

[0] https://lore.kernel.org/bpf/CAEf4BzY0-bVNHmCkMFPgObs=isUAyg-dFzGDY7QWYkmm7rmTSg@mail.gmail.com/

Reported-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 8547ecbdc61f..ec281b0363b8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -193,11 +193,10 @@ static void run_test(int cgroup_fd)
 	if (CHECK_FAIL(server_fd < 0))
 		goto close_bpf_object;
 
+	pthread_mutex_lock(&server_started_mtx);
 	if (CHECK_FAIL(pthread_create(&tid, NULL, server_thread,
 				      (void *)&server_fd)))
 		goto close_server_fd;
-
-	pthread_mutex_lock(&server_started_mtx);
 	pthread_cond_wait(&server_started, &server_started_mtx);
 	pthread_mutex_unlock(&server_started_mtx);
 
-- 
2.27.0.389.gc38d7665816-goog

