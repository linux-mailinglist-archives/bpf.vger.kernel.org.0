Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6A405165
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 14:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353548AbhIIMgP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 08:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354450AbhIIMa7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 08:30:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0B6B61B25;
        Thu,  9 Sep 2021 11:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188369;
        bh=opPQvsaqq05YFp1N638z2xloNORdfxIv4P6L3HMaW9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7klsRTYCZCB2SjnJLDlLmFP2TVb6E4alECdYryHePA9YG5bPDOGEyfsuCJuANZwa
         X6k4DDyV2CZ+kX74MpCm/W9D0iKthBOWBUg2aWV/Cx6LEs1BgRCTFddwY7CL55vdD4
         mD6Siv8LYJsIlPAKW97JntRNtAcVoNH8xmINuhySIBMKYWWQzt94mnwsawCakvr6Ms
         bR8IrcLXJOKUXvT7zVH9VCT360zUqIkEq+Bo9RoUUCw5VxfnuyQzyuKvE0N4lTq25y
         QW+Ddt023LkE4nwwYdOh37TSvzXd0x5QSq8Jo46Uc6Qw20lKmmL2kGJ8Z6r8zgmq46
         hQh5HdSKH8DDg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 071/176] bpf: Fix off-by-one in tail call count limiting
Date:   Thu,  9 Sep 2021 07:49:33 -0400
Message-Id: <20210909115118.146181-71-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115118.146181-1-sashal@kernel.org>
References: <20210909115118.146181-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Johan Almbladh <johan.almbladh@anyfinetworks.com>

[ Upstream commit b61a28cf11d61f512172e673b8f8c4a6c789b425 ]

Before, the interpreter allowed up to MAX_TAIL_CALL_CNT + 1 tail calls.
Now precisely MAX_TAIL_CALL_CNT is allowed, which is in line with the
behavior of the x86 JITs.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20210728164741.350370-1-johan.almbladh@anyfinetworks.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d12efb2550d3..f25b23fddbee 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1565,7 +1565,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 
 		if (unlikely(index >= array->map.max_entries))
 			goto out;
-		if (unlikely(tail_call_cnt > MAX_TAIL_CALL_CNT))
+		if (unlikely(tail_call_cnt >= MAX_TAIL_CALL_CNT))
 			goto out;
 
 		tail_call_cnt++;
-- 
2.30.2

