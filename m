Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C92CC444
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 18:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgLBRvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 12:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgLBRvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 12:51:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6724BC0613D4
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 09:50:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i184so2756962ybg.7
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=2BTQ0AJrFDxH/WMJtNujxQ6Jk2xi3yntXIn1/+/rMXI=;
        b=ralNzdZBrE/ynxoVTUNngfeXctDKAMr7C4Ru4EhNRaoOHC4UlDNujHEVMBf+iTYDze
         KpU7IQ+9rf/L+AZOM85SfqB8rx6fGglN4Sspa2yPLwLIiYN/g2PqbYFonUJ6r2t4oE+0
         Ndup+/7nmjJmBe7DN7TwwZHvU1fKdza8PoeD8mVVVYcMYWS8Kt9h6AExHBltiIB9UXC+
         uTzLpGLsONsQ63H+Lly56hmM8T1pHbZNgyD3mfYKv1rPIQdYwfOneapkDhQ5YP/l6ZkA
         RmzVVtQMVHh0T+9pN6m2+d9jLKWJpOb96MHXKBqr2lFKiV80wxcYRqDDCp2adOg4aJPT
         8d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=2BTQ0AJrFDxH/WMJtNujxQ6Jk2xi3yntXIn1/+/rMXI=;
        b=A5sX3/tCuKpsZawaWIHI/WZ42om7aG12rjBvCwYcAz9X9Tw5rqwfZl/ANsP4d5mdxt
         DNy/y8hidNGRw69uKeSYvdX7J+wGY4nikR9vtteHxyL8o3VrbbHB/Cfo044nUQNX5wNP
         tokOPZPGLV7hAtl/4s2KOdKiasVijOiWEy44fUJwZVOPAD8Tr7EKAMPHxbIlb3NouqzF
         XCw+SWEvl9IVnwq2hegPXUWeARy0poGEasXk54P1m+AZDbckVl6UQG7LjNHcmTR65CGq
         ARF/LxDtdV0qoZCms3Ilw4Zbyg1YEjeQL+LrCipPK5vwEJ5GYgIk+nTpAGfdbCto6Hby
         y9gQ==
X-Gm-Message-State: AOAM533iZy2MRNTTZOF/gqm5UObPmKh644FxrL5sxV5IdG8oM0vhf60C
        nVJ35EsZRn85dhXQzQV47Z2Zc1M=
X-Google-Smtp-Source: ABdhPJxD3hXY7tZrRfT1pfemQ32+nTCPfIEX12LY3pVfDfiaooJkR1EIM9bELBtRgJ/IKXMzcdbwDck=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:41c5:: with SMTP id o188mr5742500yba.185.1606931441650;
 Wed, 02 Dec 2020 09:50:41 -0800 (PST)
Date:   Wed,  2 Dec 2020 09:50:39 -0800
Message-Id: <20201202175039.3625166-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next] libbpf: add retries in sys_bpf_prog_load
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I've seen a situation, where a process that's under pprof constantly
generates SIGPROF which prevents program loading indefinitely.
The right thing to do probably is to disable signals in the upper
layers while loading, but it still would be nice to get some error from
libbpf instead of an endless loop.

Let's add some small retry limit to the program loading:
try loading the program 10 (arbitrary) times and give up.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index d27e34133973..31ebd6b3ec7c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -67,11 +67,12 @@ static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 
 static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size)
 {
+	int retries = 10;
 	int fd;
 
 	do {
 		fd = sys_bpf(BPF_PROG_LOAD, attr, size);
-	} while (fd < 0 && errno == EAGAIN);
+	} while (fd < 0 && errno == EAGAIN && retries-- > 0);
 
 	return fd;
 }
-- 
2.29.2.454.gaff20da3a2-goog

