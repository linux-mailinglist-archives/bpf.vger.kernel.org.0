Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8882D4055DF
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356178AbhIINOK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 09:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357496AbhIINBD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 09:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F269C6326E;
        Thu,  9 Sep 2021 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188761;
        bh=sD6Zjz4XgFnTkzsdkW1tFoWkAVvIfgF0vNhuksybvbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPpFxxfD6hgdwsJV/WqZVWVVXeV1K0i3QjyYhkVL67Xj3FVVIH4KmTVw9G/C/ylWI
         T8Us8E2fob6iZII07yAXSpIGpqoRAFcKkzHbVrrnk0GjwJoSQ87mwcFE7pbnTMU+rB
         2K6FaPGc5PaOTPahccEO/Gq/GLB2vKoT0myWkdiS5mV91n0bn68O4sFQcX6B41aK1V
         B5BFRjJPBfVp3J4rXk41NhrFNa4l/HHOLfwU5RXdKiwm6TrINyqXa2KAJd1RUSiUlv
         wHGsQAWcmwA1HoI3RyMMc+5j3TwsG7JEFjm2WkwFzZ1jN/Cha1Z8gEaFcXQyzBayq7
         PHVGTHwaYYuBw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 16/59] bpf/tests: Do not PASS tests without actually testing the result
Date:   Thu,  9 Sep 2021 07:58:17 -0400
Message-Id: <20210909115900.149795-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115900.149795-1-sashal@kernel.org>
References: <20210909115900.149795-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Johan Almbladh <johan.almbladh@anyfinetworks.com>

[ Upstream commit 2b7e9f25e590726cca76700ebdb10e92a7a72ca1 ]

Each test case can have a set of sub-tests, where each sub-test can
run the cBPF/eBPF test snippet with its own data_size and expected
result. Before, the end of the sub-test array was indicated by both
data_size and result being zero. However, most or all of the internal
eBPF tests has a data_size of zero already. When such a test also had
an expected value of zero, the test was never run but reported as
PASS anyway.

Now the test runner always runs the first sub-test, regardless of the
data_size and result values. The sub-test array zero-termination only
applies for any additional sub-tests.

There are other ways fix it of course, but this solution at least
removes the surprise of eBPF tests with a zero result always succeeding.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20210721103822.3755111-1-johan.almbladh@anyfinetworks.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_bpf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 4aa88ba8238c..9a8f957ad86e 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -6306,7 +6306,14 @@ static int run_one(const struct bpf_prog *fp, struct bpf_test *test)
 		u64 duration;
 		u32 ret;
 
-		if (test->test[i].data_size == 0 &&
+		/*
+		 * NOTE: Several sub-tests may be present, in which case
+		 * a zero {data_size, result} tuple indicates the end of
+		 * the sub-test array. The first test is always run,
+		 * even if both data_size and result happen to be zero.
+		 */
+		if (i > 0 &&
+		    test->test[i].data_size == 0 &&
 		    test->test[i].result == 0)
 			break;
 
-- 
2.30.2

