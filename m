Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC443B59
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2019 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfFMP2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 11:28:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46835 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfFMLc7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 07:32:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so20336352wrw.13
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2019 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF1205N89OZNViaP6acWXh6mHKPDql5m0Yi3tu1T8h8=;
        b=TbGt75o/WSp1OSUJTHNYCciigYJKAYY6solbnb+OPu7egwRHpZFyTp57t0BC1acpgS
         TAPKFVoWfjLIyWlG5lM6ccnEx04BY1qZTdskF0iD/gBFok1EC4Jb4k98qIWfHxkzKXFg
         UCMZerFSt04ZfSvT63r76NMFvJdbfCUTVST3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF1205N89OZNViaP6acWXh6mHKPDql5m0Yi3tu1T8h8=;
        b=K822hNkl2QGuvLiaOht1bUCFlARz1SAmuqhTjE/RJzhUTFF8oFLWs3LF+6CrD9l9AJ
         fyO0uq3nUjVpc2mrghnRR3oKqWJH6+Tt6KShXvdfQq98cvd4FDrbpDhePrc539Y9CbyT
         +wrnoNpbWP3AoXHZ96+jar8VBDZ98dwOJbJGXskPL402Y16iwBp8fxekl5ofY9PFn3qm
         xNeUP41kY5eBWDcG3lNLuj2+w3FyCTOya6XKE/bFJ1/9+g8H7uUYHUKv7GMkRxNN34kC
         O4OPMhNUmT+CTK9dogmbbPBpMF2ZQlpfrv0RezTejM9kinvm0ChGoj4a63VfiNmWh6CL
         rncQ==
X-Gm-Message-State: APjAAAUm7qS+rSjXZtn+fk5uzWmVBgMIKg4XXsz38gbugD5XD0JYu5i7
        Qbz4xB1FWleb7DqaCFsS1i+Iyw==
X-Google-Smtp-Source: APXvYqyrdLnXSnjStU6hbkGo3KfeeAceiBKHAZw2YLa7AT/MAbzkQIg0WRzmMIvQXvl4kd3Mo2rHUA==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr5748511wrx.196.1560425577814;
        Thu, 13 Jun 2019 04:32:57 -0700 (PDT)
Received: from localhost.localdomain ([147.12.216.9])
        by smtp.gmail.com with ESMTPSA id f2sm2646740wmc.34.2019.06.13.04.32.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:32:57 -0700 (PDT)
From:   Arthur Fabre <afabre@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH] bpf: selftests: Fix warning in flow_dissector
Date:   Thu, 13 Jun 2019 12:27:09 +0100
Message-Id: <20190613112709.7215-1-afabre@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Building the userspace part of the flow_dissector resulted in:

prog_tests/flow_dissector.c: In function ‘tx_tap’:
prog_tests/flow_dissector.c:176:9: warning: implicit declaration
of function ‘writev’; did you mean ‘write’? [-Wimplicit-function-declaration]
  return writev(fd, iov, ARRAY_SIZE(iov));
         ^~~~~~
         write

Include <sys/uio.h> to fix this.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index fbd1d88a6095..c938283ac232 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -3,6 +3,7 @@
 #include <error.h>
 #include <linux/if.h>
 #include <linux/if_tun.h>
+#include <sys/uio.h>
 
 #define CHECK_FLOW_KEYS(desc, got, expected)				\
 	CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) != 0,		\
-- 
2.20.1

