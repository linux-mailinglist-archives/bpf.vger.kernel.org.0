Return-Path: <bpf+bounces-22351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFFE85CBCD
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 00:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C522E1F2281E
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 23:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD8154448;
	Tue, 20 Feb 2024 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j76EUGiG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3070154430
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470669; cv=none; b=YrmpugHWBQBly43jr2d5KvwtH6zYsygtKAe174oFI3Ig5Q8FKY51tmLJdHvng8WebY8YS9SLnjEH7xrpE8Es3rPnqyxb0F/XrgyzE0PdrRgb6+2We8xMSDuVovV2isFH429jccsQBRrGkm/sraan5EDt/6kX0nEuppgKXAwoXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470669; c=relaxed/simple;
	bh=LkdbOm36QysPjYLtq67KpcJDjpiUJF+G204nszTf6bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MkpjbmBBpcuMBvldbIlPKSQQNMgwb6GnUnJYDldmDehialryTy92FRMAYKMk3KO1F7fZCo7Y6kqB99Dr8IuXxLt9iNXv6ou4E68ttwopuXnFGRuDARjwPiFjuJkrNNajAovRnH1zD61TN9lE1NToZKEMjygmfyGlO0XZytC4rM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j76EUGiG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d8da50bffaso30647695ad.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 15:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708470666; x=1709075466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jG7Hi+rHfOvw7cn/uQ2bscnBUxIHWGYAFQv8wWWY8iI=;
        b=j76EUGiGlU4kYVV/W5S8tlEngLbH6bdXOJIlX2pauuSUoCtJTshs97RngnjtyndEsy
         1QP6Qo6ym7bi5LTwwCE00DEnIUxNxxG/G7q+mIh+NNCu0X3/lxvIx/K9CZ3ZWlfhOrnn
         5eLJG7gKpSsd0BFm1zADhqF9Q4FrknT7qLK6ezbKthqymI9IYL/Ak1BCtXCSKvXcLywF
         egmr0w/Ia7Br/X9HIvq4HNOQBqMBCo1eNk3bJAgAlC/4FukwAVs89Lg7uP4ugXcp/YKo
         ocFV5VAtTtW31TuiEGJWxPPtfwqfr0mz1UueXZ/zXpPE/Tblp9wo5NGCaPB7Z8FVFOCH
         BJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470666; x=1709075466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jG7Hi+rHfOvw7cn/uQ2bscnBUxIHWGYAFQv8wWWY8iI=;
        b=MMCPlEnw/MM+EYaAUmAdKGazIq6f2b7EaHyxaOKRudE2uezDDQ/xWGdAJhG7GhjN+A
         CpBtglviOf6IsPHn/nhlUjzGTX2ynIAv5rvQDvJipSqLT2iPBK/CI5uuddKcZHQ7FE6Z
         mIUB7OWO/+QqWq/pmD3fXulQYpPcq6otw/SBNISf2xF7FsI/zwWIHwYoA68sWiwnXAb3
         61U20C3QDsklP8DldPDNzKNaLQRoTzCGYp0piQDoG1gSpgvS1bTDEumNENj6cE8nAn+a
         PwWTBEvZBx5+m+YrmMbsOZOPz/+r/1VhsID89OvLC9i7Lr5QLdvA+knoRR8ji6mYag8F
         wZSQ==
X-Gm-Message-State: AOJu0YzOR0any3Dad5n7/rFriImXkJbZ7JmN2GlAlhXp/h4XtwLQ99GX
	+mHzpCmbzS9hdu4Cj4nSPPRxjCmuct83LSqJNJRreg3k4SWkz/o+leWUvaRB
X-Google-Smtp-Source: AGHT+IHD/3NUGAQDid2Mrx4KXCQGYgibvGPZgsH2yikAOiAquYRV1SjxGqivbJ/KJbdCOThgu9FNcA==
X-Received: by 2002:a17:902:e951:b0:1dc:1b14:dc9f with SMTP id b17-20020a170902e95100b001dc1b14dc9fmr2859712pll.67.1708470666280;
        Tue, 20 Feb 2024 15:11:06 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:b11c])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b001d720a7a616sm6705084plh.165.2024.02.20.15.11.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Feb 2024 15:11:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Remove intermediate test files.
Date: Tue, 20 Feb 2024 15:11:02 -0800
Message-Id: <20240220231102.49090-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The test of linking process creates several intermediate files.
Remove them once the build is over.
This reduces the number of files in selftests/bpf/ directory
from ~4400 to ~2600.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a38a3001527c..c06de56bae59 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -537,6 +537,7 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
 	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@
 	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h)
+	$(Q)rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
 
 $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
@@ -545,6 +546,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
 	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
+	$(Q)rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
 
 $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.bpf.o))
@@ -555,6 +557,7 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@
 	$(Q)$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h)
+	$(Q)rm -f $$(@:.skel.h=.linked1.o) $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
 endif
 
 # ensure we set up tests.h header generation rule just once
-- 
2.34.1


