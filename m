Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA31473A6E
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 02:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhLNBsE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 20:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhLNBsE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 20:48:04 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC6C061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 17:48:04 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p18so12443618plf.13
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 17:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvGpVpm3G0nv5mjsTkEvNIL1349P2knoT5FvjJzb6dY=;
        b=am3tpxnryz702pwMJivRAd8zyqHJLVRl2ogTCcgrMYZS37R5NBzMM82ZiSC3MeDXrD
         qmWWSxm0XMuabSOsGmQHHGUmx0Jt0uQz8udrCin/nVGG0v/GTQwmM6omG4tugx6TNwZX
         ZcgySdEut43QmzWBi7VT/BT9P1QBpwyl/0Vmp7WVii2aC1N15OUljdSIKSN676HZ8Zdo
         yWPSRQYANHlH268Ujcn5fHPUhqLqhL/zWMZsUPE/Kw1l5F+k4HI8XYom1xmzSBoCRrC3
         dbitwZVbB0bY7TidYACM/MWN2F+X55ozjiiRcY3DW0Yv9NqanKx5NTVqHafNqeXMFr+u
         hAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvGpVpm3G0nv5mjsTkEvNIL1349P2knoT5FvjJzb6dY=;
        b=Oj5iM5uhfpikwL8MeP2Tm1Fc1h8PoK8AH941RkJztcpBhJ3UcZb8TBIu1Iyu1ZCtti
         M0Sp8Wwq//jWwOK5sF0986DL2li984Pzp67At5wK/rXa/pm5I+bRImaXEv7Qj08fqssW
         yj2DJyZcWibNTNSerjx7NRA0W0MjA00a46BPTD6G227fU5y6z1Ri5IHKmoy8r2aTaSU7
         L8+FVmEthmtW2UHCRXa6lKMJrNvZP3W+oLcwOTsXx1lYQzpxp//6ZTCiTwSivEMHM5mD
         yxy9m3jSibxwAJlhHUj+BjJ8GfeXk2szLA5q/5GLonD96Y7dbMroEfcEcPI6EA/XEToq
         t9Fg==
X-Gm-Message-State: AOAM533bINzhG1jGwMwszke98zCgehnP8tAKkFB6ISpf7IkKTLb3jMvI
        8VArfVEiGizFRLmvxTw90AyNbep12SM=
X-Google-Smtp-Source: ABdhPJxkOoZzGHgAFUHzTSWCAElRncAiLF4S4zSXT70uFBIumwZnOK27WRZocuHFDJrfBa5x+MaRwQ==
X-Received: by 2002:a17:903:1105:b0:143:a593:dc6e with SMTP id n5-20020a170903110500b00143a593dc6emr2117521plh.6.1639446483394;
        Mon, 13 Dec 2021 17:48:03 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id p49sm12947136pfw.43.2021.12.13.17.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:48:03 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix OOB write in test_verifier
Date:   Tue, 14 Dec 2021 07:18:00 +0530
Message-Id: <20211214014800.78762-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The commit referenced below added fixup_map_timer support (to create a
BPF map containing timers), but failed to increase the size of the
map_fds array, leading to out of bounds write. Fix this by changing
MAX_NR_MAPS to 22.

Fixes: e60e6962c503 ("selftests/bpf: Add tests for restricted helpers")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index ad5d30bafd93..33e2ecb3bef9 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -54,7 +54,7 @@
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	21
+#define MAX_NR_MAPS	22
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
--
2.34.1

