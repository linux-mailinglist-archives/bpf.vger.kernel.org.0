Return-Path: <bpf+bounces-39989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9599979E3F
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D1FB22FC3
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501014A4E9;
	Mon, 16 Sep 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsJuCXQ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EF1494CF
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478301; cv=none; b=WIz4PjsR4XhD6eFIUxBpckd3/u7TkbVlIZ22rUKtuK7iHSt8cHCKBYzjUmelDXYrY5fFjtWk3hRC3ArddgacRHP/CNK3GYGIL4rf1qPMNtV8AZWC6CeCIp3wxmTNvqaNV5Pq0GyyOnDFfb1w+gGyaEC5EMEc9Yhtmw0+5pIcn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478301; c=relaxed/simple;
	bh=Ae9QwDopzJTnytsNNCMQdMvvJAR7HEi7/xjmZEOVzHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxUj/O33bubh9ZAz/OgzoPxtGEh52DF31Du/RaTaj6LapvJIwE6511uVJ/VMabbnsugXlj7cAXnZzmtDTv6B8mkb46yybZZi1h6O+dg2M7yTb8KzWN16QF/g7TTSo77Ny1qghZdwEeKcq/4hEGnyo7zbmTdzcJ5FmopCxT29zUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsJuCXQ3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201d5af11a4so47033585ad.3
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726478299; x=1727083099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wohpFGdgdGWZ71ddt6kBAYLO4PksGhnaccJ5XelkzB8=;
        b=UsJuCXQ3L4vZAdA78GAgcA4QeQCCwzF9er0krAQuSHzPD3O88j3GSdUsQ8Va/fUcs/
         Za/bxvijelzzWS6+MjOUwLI1o4sXVNKDnLsxd3a/+Yc7GtHMNjiqHYUXutXDtAiIguBv
         hwXWYwJy6Av9lC5u4q99ZmSUoqoVRZKSmuWX80ND+SPjKm5WhmHlQNAuKRQjkl0vbwBR
         zgsSFA+crdgiuE8Km5Qq1j0ZtPYfdfaKFl8vXqDkapNH3m3TwNnINkmAZ/viNBG/P3tb
         U4J1lC5Y9pGrIYQ5g9yobim4hhLr+qb9sE4kt6hcJ908IzjNFaMFgJLo7UJyw0yHbElX
         FF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478299; x=1727083099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wohpFGdgdGWZ71ddt6kBAYLO4PksGhnaccJ5XelkzB8=;
        b=V9aTxcbZbC1B4ImSX57fjfOVpchPVMs31zYIwYyBjo/D3bBylg0P9HO74aIUBzRviA
         DXYaKZ4agr6X28wqF94BaXgu4EbcgNVskKSd58iP5YRel+cAKizylpm0i/FISXcF2y8P
         yKYf3GL0AcfYrogE3EMV+/09UMMpiuUuxtLLcxdY1sSlwiZ1wxtiF5thZyVA7qUdk/Sp
         jiyjdCbN4gh6a8vBBBPs0tiipJWC0R1cmH9T+kg8/ouM8hsR61lyGynD2stIcbhcbX2I
         0DE1cuNVEzXt92J8lFrgyqpB1dvBzLkZIPaM0mjr2G0zmmD3/HqwkgCu6RIsosTQveT9
         XebA==
X-Gm-Message-State: AOJu0Ywot7O40A2VhhCfMg3jZGGCXbQukzEvCelJO1HcuKj+6Waf8Tkm
	QhG7rea3zXkDvkdMGCVSrEYMegHqpxV+0OlyJtP1qOuFNT4Z5nK1V26Cxw==
X-Google-Smtp-Source: AGHT+IGTYmjX01dC96m1VY9uAnIXrP4MVVn02LTpib0O/GsdsKtHkmh2u0uBV9ZN61w7uGKKvvE7kw==
X-Received: by 2002:a17:902:d2ca:b0:206:c2f4:afb7 with SMTP id d9443c01a7336-2076e36db8cmr194234095ad.26.1726478298736;
        Mon, 16 Sep 2024 02:18:18 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da63fsm32882195ad.38.2024.09.16.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:18:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	arnaldo.melo@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/4] bpf: __bpf_fastcall for bpf_get_smp_processor_id in uapi
Date: Mon, 16 Sep 2024 02:17:10 -0700
Message-ID: <20240916091712.2929279-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916091712.2929279-1-eddyz87@gmail.com>
References: <20240916091712.2929279-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since [1] kernel supports __bpf_fastcall attribute for helper function
bpf_get_smp_processor_id(). Update uapi definition for this helper in
order to have this attribute in the generated bpf_helper_defs.h

[1] commit 91b7fbf3936f ("bpf, x86, riscv, arm: no_caller_saved_registers for bpf_get_smp_processor_id()")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/uapi/linux/bpf.h       | 2 ++
 tools/include/uapi/linux/bpf.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c3a5728db115..fd1f59c6d1de 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1970,6 +1970,8 @@ union bpf_attr {
  * 		program.
  * 	Return
  * 		The SMP id of the processor running the program.
+ * 	Attributes
+ * 		__bpf_fastcall
  *
  * long bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from, u32 len, u64 flags)
  * 	Description
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f329ee44627a..22b041c81276 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1970,6 +1970,8 @@ union bpf_attr {
  * 		program.
  * 	Return
  * 		The SMP id of the processor running the program.
+ * 	Attributes
+ * 		__bpf_fastcall
  *
  * long bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from, u32 len, u64 flags)
  * 	Description
-- 
2.46.0


