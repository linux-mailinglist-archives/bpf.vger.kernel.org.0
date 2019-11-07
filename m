Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F156F2E85
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbfKGMwm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 07:52:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34593 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388702AbfKGMwl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 07:52:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so1532029lfp.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 04:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wx4mNjMFyM/tBCetl9PoO1sT6W5jcZPQW0WwQCBdqWI=;
        b=HzpSICQRrj53FhQ/Vk1rFJ4Anx8mvt3pW0xbR+agtZ07z5LD0owoTGfwr36NsnMM3V
         utkhWcjnEipIBMe18nq45WWqky0Vbq0RdmEq1+OqTCspcWQUUZqBSfs+uIhnt+pMiiYo
         bqRO3tw9sWC3kcsfme03aUcxZwdK9IfrlGftX+vWVo9j08nluvUoiva19wHtukyTr3ON
         Werf8wryuxHmw+L5p7RbGi78q9OxThD5tTJVN7jXiQEgFIxeVL+W4Wt/70fBkLkq8KQZ
         9oitBemRGOxga2jRO7FAoOubAnPVc72JOJGewWgxNfJ4sj+vP+yMisuIeNv2iYe0cQK6
         ePmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wx4mNjMFyM/tBCetl9PoO1sT6W5jcZPQW0WwQCBdqWI=;
        b=g5yUMa4pZ0nm8OMfqy7tgKQmy9qwVDZoKt2vxgnGkSLhBeBfGq89nY+pOi/k72aLK7
         4yEpPekAhlUqyLsyV4Z58qSCngCwtdurn/h8nA8khy5jW/P/noNnlaVsgMsUQKUwz7Ds
         5W0xzlxk2R/tRCplW80UHQWMuI35yMZyuBUICxy5mX3l56Q5C5AAftgFjyEHRNpwRJsV
         U3SLv7irprMw/4Rz1HsH1UwuDtM7DBy2YDjGE8hKTsMS7pr4z6uDeL+W1QRnfId3lDgv
         z22wmNWi5x129++0ikMNUEXfK/4r3NlTqbc40Rs1uDre926FdZqEnOGqZOtH4d1MeslL
         cGLQ==
X-Gm-Message-State: APjAAAX3CvlXImV798PaAYs0cKYWHkAfXIPJz8Fvc/Q1UbcGpZhn1P3C
        qNsrEHJNDHpPWyhGxl+YvsJk7Q==
X-Google-Smtp-Source: APXvYqzKkkvdDA0TgR9ZO/wpF8r/cY5uQlCc0mYt6uD5YtAqvUxbVyqkEO4xkyY9UV6Lwh0vmuCStw==
X-Received: by 2002:ac2:5deb:: with SMTP id z11mr2441628lfq.35.1573131159315;
        Thu, 07 Nov 2019 04:52:39 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id t8sm999889lfl.51.2019.11.07.04.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:52:38 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] selftests: bpf: test_tc_edt: add missing object file to TEST_FILES
Date:   Thu,  7 Nov 2019 13:52:24 +0100
Message-Id: <20191107125224.29616-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107125224.29616-1-anders.roxell@linaro.org>
References: <20191107125224.29616-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When installing kselftests to its own directory and running the
test_tc_edt.sh it will complain that test_tc_edt.o can't be find.

$ ./test_tc_edt.sh
Error opening object test_tc_edt.o: No such file or directory
Object hashing failed!
Cannot initialize ELF context!
Unable to load program

Rework to add test_tc_edt.o to TEST_FILES so the object file gets
installed when installing kselftest.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cc09b5df9403..b03dc2298fea 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -38,7 +38,8 @@ TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
 TEST_GEN_FILES =
-TEST_FILES = test_lwt_ip_encap.o
+TEST_FILES = test_lwt_ip_encap.o \
+	test_tc_edt.o
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-- 
2.20.1

