Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7391D2F56
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgENMPi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 08:15:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37903 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgENMPi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 08:15:38 -0400
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jZClt-0000he-HV; Thu, 14 May 2020 12:15:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftest/bpf: fix spelling mistake "SIGALARM" -> "SIGALRM"
Date:   Thu, 14 May 2020 13:15:29 +0100
Message-Id: <20200514121529.259668-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an error message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/bpf/bench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 8c0dfbfe6088..14390689ef90 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -242,7 +242,7 @@ static void setup_timer()
 	last_time_ns = get_time_ns();
 	err = sigaction(SIGALRM, &sigalarm_action, NULL);
 	if (err < 0) {
-		fprintf(stderr, "failed to install SIGALARM handler: %d\n", -errno);
+		fprintf(stderr, "failed to install SIGALRM handler: %d\n", -errno);
 		exit(1);
 	}
 	timer_settings.it_interval.tv_sec = 1;
-- 
2.25.1

