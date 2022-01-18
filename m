Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8F491434
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 03:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244648AbiARCVC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jan 2022 21:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbiARCUh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jan 2022 21:20:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098CC06176C;
        Mon, 17 Jan 2022 18:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A151B8122C;
        Tue, 18 Jan 2022 02:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0723CC36AE3;
        Tue, 18 Jan 2022 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642472417;
        bh=J5+2k5Vu9FXtz194cQpO41gLQP387GfoIjXIZAfACjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LV87UHiCG2UXCsqwqyG5kY61SZR/3CBBfta5OeDx6rgBR7yyYWmQL4dHnUHbEOQhd
         kKy5nwj9aoKV7I94tTNytHucVNMYr59Twzrn0mLqB/VeDaclWOZL8LHYy3m5u2ra4N
         gDm2TSJ0jng/QSOc6l2cCHvVLwlZYYA5ync+ICSDNSfY6mdSosTdl2eEMG3r4gdaWS
         R5Imo3hsKLMR/WFBT81XA3JDzFq0bacQLW5QSQqYHGpKHyI2EwsWSbUHi9rfJzJKJw
         s7pE7p6+NHBtCGBDBrhKV88AzFqwehqwYXx0ZBTfLgl3HMwB+QiYxX2XMhsCuIEfCX
         fFDfCUw+VW8zA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        daniel@iogearbox.net, vfedorenko@novek.ru, kafai@fb.com,
        john.fastabend@gmail.com, ntspring@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 014/217] selftests/bpf: Fix bpf_object leak in skb_ctx selftest
Date:   Mon, 17 Jan 2022 21:16:17 -0500
Message-Id: <20220118021940.1942199-14-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118021940.1942199-1-sashal@kernel.org>
References: <20220118021940.1942199-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 8c7a95520184b6677ca6075e12df9c208d57d088 ]

skb_ctx selftest didn't close bpf_object implicitly allocated by
bpf_prog_test_load() helper. Fix the problem by explicitly calling
bpf_object__close() at the end of the test.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Link: https://lore.kernel.org/bpf/20211107165521.9240-10-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
index c437e6ba8fe20..db4d72563aaeb 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -111,4 +111,6 @@ void test_skb_ctx(void)
 		   "ctx_out_mark",
 		   "skb->mark == %u, expected %d\n",
 		   skb.mark, 10);
+
+	bpf_object__close(obj);
 }
-- 
2.34.1

