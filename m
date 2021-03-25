Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5411E3486C7
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 03:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCYCEm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 22:04:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13683 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhCYCEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Mar 2021 22:04:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5Sz13xqYznTTn;
        Thu, 25 Mar 2021 10:02:05 +0800 (CST)
Received: from t01.huawei.com (10.67.174.119) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 10:04:34 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>
CC:     <jackmanb@google.com>
Subject: [PATCH bpf-next] bpf: Fix a spelling typo in kernel/bpf/disasm.c
Date:   Thu, 25 Mar 2021 02:05:11 +0000
Message-ID: <20210325020511.5891-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.119]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The name string for BPF_XOR is "xor", not "or", fix it.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 3acc7e0b6916..faa54d58972c 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -84,7 +84,7 @@ static const char *const bpf_atomic_alu_string[16] = {
 	[BPF_ADD >> 4]  = "add",
 	[BPF_AND >> 4]  = "and",
 	[BPF_OR >> 4]  = "or",
-	[BPF_XOR >> 4]  = "or",
+	[BPF_XOR >> 4]  = "xor",
 };
 
 static const char *const bpf_ldst_string[] = {
-- 
2.27.0

