Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6447341A
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 19:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhLMSdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 13:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhLMSdo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 13:33:44 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21218C06173F
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 10:33:44 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so55558189eds.10
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 10:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l54QX6ZqsqzaIAhDWIb2TsE/J94vVTdX5D7itxHjGpQ=;
        b=wqnOIeLzW77hxRGWI9MlgAopTLU9EwXk7wSC7XyJNrOKSP/fThhH6Svx7Ms04R3XCr
         QfWyQIpGLQPnlOLLb9QztDr8j+QcuCniDCEInbix77Wf7y/ForeXYQvit2z/Qa/Ja7+M
         V2EyQfq5Wcvj+OEKc/DOwKkTHBH49IYMvMjVxXF+Yqnq/I4Bn3FRgBvWvRNzCltQd+ui
         8oHxMHtTmOnEizUCGlmH3e6YF3+cvniHXSATKNCQE783nvh6c5laNjuh8XrU8qzs5P/x
         5sTxQE7UYL/a0rGU8y22cl0f1Ir0ImxIILXxueFQkq4RGxiBZvdm4n6RaLrGKGlVINze
         WK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l54QX6ZqsqzaIAhDWIb2TsE/J94vVTdX5D7itxHjGpQ=;
        b=prMbzXOFb+FM5tUJXKnRCjmhcEach/dNrpTWOSAL9eo21M+o73uVgn5tIuzPtjupvq
         MlQlae587mtT9dwBvw1MZy8noTaiGGcjp6l8NkGFpxVQEnf+0I1aPluL24sQn2/xMoUO
         gl02LXHetucTQNDaSwqeERYF9m0kfeUh0vPcSpyLFhYO2yyfNYsly2cduuAgknHWP4rC
         vvZYncU800AOesVXWTXu7MnM8dGD22gcMuAai4TpbzrcT9FBJnsWAdl9H9eICmeokWMB
         isyVYytHPIxGL4Z9NyV1iWUd/iXPgIO7CR/PtosspSnrIXaysILCKTduNDdbWRVTnhNK
         dl+A==
X-Gm-Message-State: AOAM532sCavCoBUyfPJT6O8+xXxj4kr1xL4Zd28rDHf+bdgnNVB6yMhD
        0k5aGo71C/RslyH3lO9UO8gxqQ==
X-Google-Smtp-Source: ABdhPJwKDgfD6khDlfnWbz+hSt8bhO+VKmwoRRH3J9d2xhRUXkZwJOxiB1Yvh+aNscusOPUQOg8DdA==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr660743ede.236.1639420422445;
        Mon, 13 Dec 2021 10:33:42 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id sh33sm6316648ejc.56.2021.12.13.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:33:42 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     shuah@kernel.org, andrii@kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix segfault in bpf_tcp_ca
Date:   Mon, 13 Dec 2021 18:30:59 +0000
Message-Id: <20211213183058.346066-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since commit ad9a7f96445b ("libbpf: Improve logging around BPF program
loading"), libbpf_debug_print() gets an additional prog_name parameter
but doesn't pass it to printf(). Since the format string now expects two
arguments, printf() may read uninitialized data and segfault. Pass
prog_name through.

Fixes: ad9a7f96445b ("libbpf: Improve logging around BPF program loading")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 8daca0ac909f..8f7a1cef7d87 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -217,7 +217,7 @@ static bool found;
 static int libbpf_debug_print(enum libbpf_print_level level,
 			      const char *format, va_list args)
 {
-	const char *log_buf;
+	const char *prog_name, *log_buf;
 
 	if (level != LIBBPF_WARN ||
 	    !strstr(format, "-- BEGIN PROG LOAD LOG --")) {
@@ -225,15 +225,14 @@ static int libbpf_debug_print(enum libbpf_print_level level,
 		return 0;
 	}
 
-	/* skip prog_name */
-	va_arg(args, char *);
+	prog_name = va_arg(args, char *);
 	log_buf = va_arg(args, char *);
 	if (!log_buf)
 		goto out;
 	if (err_str && strstr(log_buf, err_str) != NULL)
 		found = true;
 out:
-	printf(format, log_buf);
+	printf(format, prog_name, log_buf);
 	return 0;
 }
 
-- 
2.34.1

