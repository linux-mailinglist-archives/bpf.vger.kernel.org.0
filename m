Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FBB491E3B
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 04:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbiARDs2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jan 2022 22:48:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46150 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346960AbiARCkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jan 2022 21:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 655DFB811CF;
        Tue, 18 Jan 2022 02:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DC2C36AEB;
        Tue, 18 Jan 2022 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642473617;
        bh=Adkz8tW47vbwofh7NrAPeUglOkNTCxORjd0loYPv954=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GL1euMVLqEJ4bRV+YoXRBZdaMGs1r3aWBL7al51zKAAW/f4R9NJtYgdoKCnbDSRFo
         LHv+lFQgFiUmLPyqf2kI1Jm10/TUPyDMYqeyq7gw2JTQw3qHsTBsC9PI6WOf8azWBR
         0JlZ5r2V6ZIcNA12VMQdaNVB7Gf7UKBpW/vQuNf2+yscx3CdUYJleTtAGOfVxFstMA
         NIKpu/TE2weIc93999/KrZYKqzQxcUAYxspUC9Jjyhv8/UsPe+tdMLuCpdW3X00Lm2
         XwVxJuqAK1Ao2Y7lkTQrlVzE8NwtaAXe/YYXDWuM/G2MjchPXzS08auCz/1tsUBfRp
         krD3GdINLcgBw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        daniel@iogearbox.net, davemarchevsky@fb.com,
        john.fastabend@gmail.com, ntspring@fb.com, vfedorenko@novek.ru,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 005/116] selftests/bpf: Fix bpf_object leak in skb_ctx selftest
Date:   Mon, 17 Jan 2022 21:38:16 -0500
Message-Id: <20220118024007.1950576-5-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024007.1950576-1-sashal@kernel.org>
References: <20220118024007.1950576-1-sashal@kernel.org>
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
index fafeddaad6a99..23915be6172d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -105,4 +105,6 @@ void test_skb_ctx(void)
 		   "ctx_out_mark",
 		   "skb->mark == %u, expected %d\n",
 		   skb.mark, 10);
+
+	bpf_object__close(obj);
 }
-- 
2.34.1

