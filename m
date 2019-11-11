Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086C3F7893
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2019 17:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKKQRf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Nov 2019 11:17:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36120 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKKQRf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 11:17:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so14465565lja.3
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2019 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/+NFqs0F+NSUfd9yCmnz5NfQc9F7D35Qd2TZxptiX8=;
        b=jPTS9N+R74bh1Vi/8HgMkFBkvF2G9BvI1CqYFpl+82rzgOHZezGCUmSX2VxdSqFWbq
         924RyJmQL6IZYkVH6zP5yIGQL3oqEPs5cwD5fTKlsacctKGPRGzYILULOMuMbKwrTyo/
         GBVEkwPVCMHO3ievhZ1snWHQtd3eH3Y5BAP7nfD6zXnWKUOiwWNEQjYhGjd8zFd7WpSx
         KxmjqAoqqt6VApsZD6FOcWVteMvdyZAJybbgoRv9dqcFj8UF4VEdcW1SpMhVukV+lumS
         Hq6lVl2t9BDWQLFjzSD34jd91EMwY31vft5jmR+R2ft3JiVM7STO8Y/ouJfkSAWGJkQf
         6PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/+NFqs0F+NSUfd9yCmnz5NfQc9F7D35Qd2TZxptiX8=;
        b=KV68VlplMMPdrcaTLuKylgluotgfLqSkyUARqQ5Idgv8GU2t6EclbM3zMKECYqNr2g
         GALaWaqFii10YM0TdyyQariUfltAUM/QIMW3KZL0RCFUmkjZ17st+R4NHEVA/ORgHQgZ
         mQ0m7FsVAMsXQCM7rxemkt/baujOwVrrsSHH/BUILNKJaW9r/3yxvmD4h3zxD3GPx2Bj
         qdq0bu9vm5Y8JY4fK1zID50w1vSfoC+GLtgzW7gectn5P2/GI0R3rCMzBiftfYtCtDo/
         QUFoSeyzEeC8CPiYVTLD1vqk8GXvGiW2k6bcWNHU6JueGIKR9r7PmYsEjYJuJuuTH6RI
         7aHA==
X-Gm-Message-State: APjAAAXq7rSQFqZcIq3FMDGk+ZuEjvERwA5UeWshkOfBhBDlWT9C9pgc
        zm6xGRy5/awj/JAtw+/Tm9l0Gw==
X-Google-Smtp-Source: APXvYqxpxfjJ/s3M4kO1mxQa6K/91iX/y7vl00YTJOHXEqtqPK6JQW/OgzcB3eejbE0jMkgpOxdTFA==
X-Received: by 2002:a2e:9981:: with SMTP id w1mr16477357lji.205.1573489053004;
        Mon, 11 Nov 2019 08:17:33 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id 70sm3015191lfh.86.2019.11.11.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 08:17:32 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, songliubraving@fb.com,
        simon.horman@netronome.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: add missing object file to TEST_FILES
Date:   Mon, 11 Nov 2019 17:17:28 +0100
Message-Id: <20191111161728.8854-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When installing kselftests to its own directory and run the
test_lwt_ip_encap.sh it will complain that test_lwt_ip_encap.o can't be
found. Same with the test_tc_edt.sh test it will complain that
test_tc_edt.o can't be found.

$ ./test_lwt_ip_encap.sh
starting egress IPv4 encap test
Error opening object test_lwt_ip_encap.o: No such file or directory
Object hashing failed!
Cannot initialize ELF context!
Failed to parse eBPF program: Invalid argument

Rework to add test_lwt_ip_encap.o and test_tc_edt.o to TEST_FILES so the
object file gets installed when installing kselftest.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Song Liu <songliubraving@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b334a6db15c1..b03dc2298fea 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -38,7 +38,8 @@ TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
 TEST_GEN_FILES =
-TEST_FILES =
+TEST_FILES = test_lwt_ip_encap.o \
+	test_tc_edt.o
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-- 
2.20.1

