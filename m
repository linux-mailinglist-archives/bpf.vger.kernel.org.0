Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E143E4262
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhHIJT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbhHIJTM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A395C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id by4so4773668edb.0
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fm12DraEWoE7puz5c35azjA8N98QYZo8v/VXZs4ufrA=;
        b=sjJa7/NakDrOn+oR/kZx4NGdpRCDIC0TtBMmd/NK5kdhUJb9odtKUCmH1E+W7isdTD
         idFxPxo3CfeLV0hWGxG3N1J91JZJKsRrnmL9wzHnB9IgSSHLXwo1hmjv18a11n1SzF/A
         Qqozj14ErUOiG8Si8H/I/7nT2kVDj2+MbHJOl/QaCDXTugdBKBVPr+kFg5z/AwJ27+Ty
         tXJQl0egr41ok8GDyZD+oblgScm9QNa46etYz210vNHirt7r0xMpaq+H4L1Qcp/9TmCD
         94WEopz7ir90T8x7ydnXMN2K9wm8hFY9Tr6TmVYtW4t0kNQKFVDoabbGvHFf5Vei8F/4
         K2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fm12DraEWoE7puz5c35azjA8N98QYZo8v/VXZs4ufrA=;
        b=mxGceOY62iLR46uUGO2onb2sxXSSaChu6DGrVR0tdyCfnHaYy+hfeYnK6kJj0l/19H
         GiJ8L+440caC8VovEPotdMPcxI75+W8e+e5UnxQWVTY3zPCdnojViu21LmO0jdAyBPGT
         EAf2d7mDz0cgGO65Li2wz7hg12nxQ4KHaPZmf+khiFbjxusG/rv8fVUqduDXEW2Ct7Rc
         I5MC2oJJSi6q/EHZ3Ks+uYBsPz6+a2GAwpsTwp3ew+yNr5ki0yaFW/i98GE7qYVxPxnk
         00WcDQSKwkxHBzEKyLQ8pxQiaVP9v2CFg03xMHBnqtf8rbGYnyNNf8sDssiPcBGL/xBS
         5zvg==
X-Gm-Message-State: AOAM532iJa9ry7XvuEUoE7xzlCmmKzKkWH2HCh9PkmHXPuS6rtN7XtYN
        jurMEH9iEPtSK6zkblNdiVRhyQ==
X-Google-Smtp-Source: ABdhPJyPQRkN6OIvShIvfyv/CvhWOBi81mMFi5wEwjSc4cY0NZcPAPXcvpKQeZKIls6IjGK/0psQTA==
X-Received: by 2002:a05:6402:42c7:: with SMTP id i7mr28271482edc.161.1628500730970;
        Mon, 09 Aug 2021 02:18:50 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:50 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 09/14] bpf/tests: Add word-order tests for load/store of double words
Date:   Mon,  9 Aug 2021 11:18:24 +0200
Message-Id: <20210809091829.810076-10-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
References: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A double word (64-bit) load/store may be implemented as two successive
32-bit operations, one for each word. Check that the order of those
operations is consistent with the machine endianness.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 lib/test_bpf.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index e3c256963020..402c199cc119 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5420,6 +5420,42 @@ static struct bpf_test tests[] = {
 		{ { 0, 0xffffffff } },
 		.stack_depth = 40,
 	},
+	{
+		"STX_MEM_DW: Store double word: first word in memory",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0),
+			BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
+			BPF_STX_MEM(BPF_DW, R10, R1, -40),
+			BPF_LDX_MEM(BPF_W, R0, R10, -40),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+#ifdef __BIG_ENDIAN
+		{ { 0, 0x01234567 } },
+#else
+		{ { 0, 0x89abcdef } },
+#endif
+		.stack_depth = 40,
+	},
+	{
+		"STX_MEM_DW: Store double word: second word in memory",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0),
+			BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
+			BPF_STX_MEM(BPF_DW, R10, R1, -40),
+			BPF_LDX_MEM(BPF_W, R0, R10, -36),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+#ifdef __BIG_ENDIAN
+		{ { 0, 0x89abcdef } },
+#else
+		{ { 0, 0x01234567 } },
+#endif
+		.stack_depth = 40,
+	},
 	/* BPF_STX | BPF_ATOMIC | BPF_W/DW */
 	{
 		"STX_XADD_W: Test: 0x12 + 0x10 = 0x22",
-- 
2.25.1

