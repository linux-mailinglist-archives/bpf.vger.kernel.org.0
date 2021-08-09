Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE43E4276
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhHIJUF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhHIJTF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A251AC0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y7so23516863eda.5
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3pxYYbBi2/gCRXiNDi9wFrI7NW3X0/LftzkQPFp/tw=;
        b=EcRLp3ibEwyiVsOCzHV8J7tfQaim3Z0otyWH3ncyOBDOzcSpYCkhrP0ijhwLRUDJZ7
         DVmTmDk5AHXM/ENVNWGaY6fYwhykrnKhIG4iPu+73eQX21k5aH8WDzJStUpO1Kd0bt3v
         ADbBaw7XWCCvc03HLNpUrMePRcx/ZQTpphKAzBC0gCw40OsABd/G9YARJk5VJ/oF4bZR
         eC+RH1B4se6hSMZTZzaChHUUGDvDFCxuyuP8LfGpUA89T05OcB5tPdgLnI2Rr87uIJSt
         sDdX1+4ywXc61Ev2Dhg/B/XBRvrY3VJXCI06z3M4kjXod5/mP3wzeVpatorVYLVT1VQ0
         mfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3pxYYbBi2/gCRXiNDi9wFrI7NW3X0/LftzkQPFp/tw=;
        b=rCAmBEV8NOWcNCf9MnKfFAase9wLso997QxJaqxuZpkq00qyUDgu9InFD4/akiCy82
         8OMrDVhq1qX4wlqorkkCR/p75rYzu/ttragHH2OE5Z9EGlvyxvSK9XY9r0o940ADpYJl
         TKVknTQfjMVgzCfH7Ojts+/ErkUVwNLL+QxvaByehjhN5/1x2vrgdtp2eCsPEpKlHHMe
         km8Rha4UOnRw/0AX9G7xeanUzvEdBh0E1PJlPtTO1BLuImr1JZk8hlwFhS077isr90ms
         f6IrMmPHwI9Y61nQqP/S8MksoMedMmQytBCUE9A95ZF1lMEloXuUivI0/q9S9glpm/Lo
         n5aw==
X-Gm-Message-State: AOAM533Z2kbMEkE4oG4RwI2CUPl7G0Jee1WKjZ1o9edLIB94TaDbayQI
        SAQ1tGiDm3Lv8C4Bs/sErOmszkRFAMziaRHRzak=
X-Google-Smtp-Source: ABdhPJxiprle9EhCPKpr+EFj5Rc+DUDMJSVjuV8X9txhqcqgJpnX8IjnwmBp6NH4AzAesXZrwileCA==
X-Received: by 2002:a05:6402:2217:: with SMTP id cq23mr7976883edb.56.1628500724280;
        Mon, 09 Aug 2021 02:18:44 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:43 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 03/14] bpf/tests: Fix typos in test case descriptions
Date:   Mon,  9 Aug 2021 11:18:18 +0200
Message-Id: <20210809091829.810076-4-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
References: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch corrects the test description in a number of cases where
the description differed from what was actually tested and expected.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 lib/test_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 450984433140..ec36a8bfa3f9 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -3537,7 +3537,7 @@ static struct bpf_test tests[] = {
 		{ { 0, 0xffffffff } },
 	},
 	{
-		"ALU64_AND_K: 0x0000ffffffff0000 & 0x0 = 0x0000ffff00000000",
+		"ALU64_AND_K: 0x0000ffffffff0000 & 0x0 = 0x0000000000000000",
 		.u.insns_int = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000000000000000LL),
@@ -3553,7 +3553,7 @@ static struct bpf_test tests[] = {
 		{ { 0, 0x1 } },
 	},
 	{
-		"ALU64_AND_K: 0x0000ffffffff0000 & -1 = 0x0000ffffffffffff",
+		"ALU64_AND_K: 0x0000ffffffff0000 & -1 = 0x0000ffffffff0000",
 		.u.insns_int = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
@@ -3679,7 +3679,7 @@ static struct bpf_test tests[] = {
 		{ { 0, 0xffffffff } },
 	},
 	{
-		"ALU64_OR_K: 0x0000ffffffff0000 | 0x0 = 0x0000ffff00000000",
+		"ALU64_OR_K: 0x0000ffffffff0000 | 0x0 = 0x0000ffffffff0000",
 		.u.insns_int = {
 			BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
 			BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
@@ -3810,7 +3810,7 @@ static struct bpf_test tests[] = {
 		{ { 0, 3 } },
 	},
 	{
-		"ALU64_XOR_K: 1 & 0xffffffff = 0xfffffffe",
+		"ALU64_XOR_K: 1 ^ 0xffffffff = 0xfffffffe",
 		.u.insns_int = {
 			BPF_LD_IMM64(R0, 1),
 			BPF_ALU64_IMM(BPF_XOR, R0, 0xffffffff),
-- 
2.25.1

