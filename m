Return-Path: <bpf+bounces-43398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFBE9B50D1
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 18:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8091C22C90
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908820720A;
	Tue, 29 Oct 2024 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR1+W7fW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C78199947
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222840; cv=none; b=DKvnvqzm6DEr97v9zmPq0+fMzFCovKvKw+T5L5A3BIRrUdw6nwi0icVbeR0j6xSnnAMuTTCpvIYNRj7pnHYLDqO04S8knCFHdR/6HKL+Nz3jP3fLM36LsSfQ9xWOMFXQyq5ZJ/IBVL2uD4thhm80d9xCjaBJuxTBCHlKqTaEeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222840; c=relaxed/simple;
	bh=6zsTR/sGwfJMIJYKcf7itVpQHQ/TvwPHC4Q3/xdeBcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsczTfxUYB54dX9TOq+vtnVc7vb83LvvEgJiTrrvW845W7YliDcqq2WIcbJG5uamDq83Z6tlG2pkiVWuJ+nL08BrVvq7xlInzcmPIqhtgY6QPjhO80nZpT7AQvim+d8L81l3TnCvZApknNWHesi2P0ov7iyeathoIt+46H/CErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR1+W7fW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso2837902a12.3
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730222837; x=1730827637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QokhXn4PCbnv9TcXyPxlYOGZ3dPN4TP9Qe25Vi6hpw=;
        b=nR1+W7fWdOcrJ4wAkMj+Ia4pa9ktrJmmcCEiP2uFBPLZoViYpx2KrInk1NANFzgArO
         WAD753DjzcggfMWQQXa3cisQ0z/L7hCT9BIUiK+e5/TYfE/yYzJA52Oz+Nfe5VGQ6wzS
         FOezZ8O+HaabNF1QmdKHyQCz/vtOiiaMcxNslulgyFF2lnEGc1bXp3sBC2/HEUi96YBl
         q64zUJOeCA8XLlg7daN/avqcf+b4iZEWZ9WUo/hrPR0Sl7p+vY4eYRA62ScDypdpj8VP
         sZAa2sMvL6UhEFBnmXivajWCq4maMW6pP0UktTEDk9/kMoAptijLBOZ28vCG3HnmN3yT
         IpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730222837; x=1730827637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QokhXn4PCbnv9TcXyPxlYOGZ3dPN4TP9Qe25Vi6hpw=;
        b=a5enhhk55RfGeY2Mq0R5sIF2W0arrxzixf+6tqA/nq4IW+mjvAPE5QQRM8unq5c7ft
         JoXkrk1THza14w+RKoZmlNBeR9PRtghGZaxX2KDKN5T9dkd9kgdCkGfKtg/u+ZgB07Mf
         j93ByPXW+rYY2/wBn7o+IlfQWqOvh5tnLXLn1BqlEcOG3/kDKPm47ZZAb6km0nlcywHV
         im7AaZd7fIQlnFp880NffNPnm57CZY2X8Mw9RKYei5nvwygPtrp9JD+lEPL4pou1OYew
         KKh0FaSDfypjlcXNMpJg0yubN+KfXOELFgOhemTc+mj3ue97PVw6Ov2W5hnDb1uhKW/g
         oWEg==
X-Gm-Message-State: AOJu0YynpJcE0BcZDk3Gm0IOEjS+GbCgdK6UKgqwDFI/KfbRyrIVdCcs
	+Jo2ER5agqaW8TFvog6j95Eu8dF87cahLNvmv7NUBjrGReqCZAoukC8TOg==
X-Google-Smtp-Source: AGHT+IHNc2hfEH0HgLwTBCq3Z9/1w/HwG+zRY1eXRKHtur6eIFopOU6IfTc0mlnTiJVz9XQLZoloLg==
X-Received: by 2002:a05:6a20:1d98:b0:1d4:e4a9:c126 with SMTP id adf61e73a8af0-1d9a84da054mr16452916637.32.1730222837478;
        Tue, 29 Oct 2024 10:27:17 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc868c043sm7855855a12.38.2024.10.29.10.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:27:16 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: test with a very short loop
Date: Tue, 29 Oct 2024 10:26:41 -0700
Message-ID: <20241029172641.1042523-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029172641.1042523-1-eddyz87@gmail.com>
References: <20241029172641.1042523-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test added is a simplified reproducer from syzbot report [1].
If verifier does not insert checkpoint somewhere inside the loop,
verification of the program would take a very long time.

This would happen because mark_chain_precision() for register r7 would
constantly trace jump history of the loop back, processing many
iterations for each mark_chain_precision() call.

[1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.com/

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_search_pruning.c       | 23 +++++++++++++++++++
 tools/testing/selftests/bpf/veristat.cfg      |  1 +
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
index 5a14498d352f..f40e57251e94 100644
--- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
+++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
@@ -2,6 +2,7 @@
 /* Converted from tools/testing/selftests/bpf/verifier/search_pruning.c */
 
 #include <linux/bpf.h>
+#include <../../../include/linux/filter.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -336,4 +337,26 @@ l0_%=:	r1 = 42;					\
 	: __clobber_all);
 }
 
+/* Without checkpoint forcibly inserted at the back-edge a loop this
+ * test would take a very long time to verify.
+ */
+SEC("kprobe")
+__failure __log_level(4)
+__msg("BPF program is too large.")
+__naked void short_loop1(void)
+{
+	asm volatile (
+	"   r7 = *(u16 *)(r1 +0);"
+	"1: r7 += 0x1ab064b9;"
+	"   .8byte %[jset];" /* same as 'if r7 & 0x702000 goto 1b;' */
+	"   r7 &= 0x1ee60e;"
+	"   r7 += r1;"
+	"   if r7 s> 0x37d2 goto +0;"
+	"   r0 = 0;"
+	"   exit;"
+	:
+	: __imm_insn(jset, BPF_JMP_IMM(BPF_JSET, BPF_REG_7, 0x702000, -2))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/veristat.cfg b/tools/testing/selftests/bpf/veristat.cfg
index 1a385061618d..e661ffdcaadf 100644
--- a/tools/testing/selftests/bpf/veristat.cfg
+++ b/tools/testing/selftests/bpf/veristat.cfg
@@ -15,3 +15,4 @@ test_usdt*
 test_verif_scale*
 test_xdp_noinline*
 xdp_synproxy*
+verifier_search_pruning*
-- 
2.47.0


