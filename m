Return-Path: <bpf+bounces-27463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC368AD4A2
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF8A281980
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D7815530A;
	Mon, 22 Apr 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dwPMWLCZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B5152180
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812990; cv=none; b=RzPdxKdHTHYIm6OHrX1Ub744kIilkdyMY0LUffox4um52gFmYdw4FM/2FX54O8kGty+ByPBylTLMDv4AUzqc3IwPML4uRXzt9ZrrWfMqvrKivMwumR6JUBMUhJThpKTJ+9x5KI5Zj/ywdiErR1hNvQ9yiTzi50wvQATow0oaWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812990; c=relaxed/simple;
	bh=OlU3mJxQc+bocO7bSNjNQAPOIR4kHzJDshxYV1a/Eak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cU7Mj30SFcMIWBws0HxYGhdpU7GAoHftrWh29wWLvw0LOgGKt94xuSPRyEwSj37+nCo2Ck5GeTcxoVstHMViwd/0KPgM66PvJypHbXX+plLEyLbd+OQvQ+TvZcSJ1LdgBUp2Yv28+G4E0RyIROql4Hu7/HNVVTKI+ubJgGXlIe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dwPMWLCZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ecff9df447so4598323b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713812988; x=1714417788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGOXjPZgt2q5MzYfPqLwFNnbtyA3bd/HxSwCsxXiUSw=;
        b=dwPMWLCZhtgagB8MH07puN+7PyxNG/ny2uVtV/Haj/AbyXr7gCEkHGsJgFR8BZjGYI
         cWj5wG3tbPzkERyXNGk7v2tEcuGxjJCsMvnKdFLJwJeQpf+lngKfHrDkN+UOwVKgbGnN
         yJk1bVfMkLuLdwDHTWww+1mrnmaDZfZo3s3UQjGtLLVmcHob0V/7hSQdFVbdPPVMOCSt
         WByyKD5RP2BYSHNg6zoy3FjUeSMk/BRviJMCmBY92An0tJbsxFHwNIujvGpI4gy5Pt6F
         hJ6SwW5YaCKrtOZdSqPE38/GFpCJ0kRJ0jhxCK4YEOhUZdYVkWrq2/uFeQtzaayus4vu
         krHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713812988; x=1714417788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGOXjPZgt2q5MzYfPqLwFNnbtyA3bd/HxSwCsxXiUSw=;
        b=RKdTdY/EQOpQIJlYuUj2sPIcUzyWnge2TvuAJ80LuZm8u4KSSvMtqnQQ6M4KKf0d4o
         b6wRFxAUjTL3dXanvda7HXcemvfLEXJOQNJ3B3Ed8YXuhLeFf6KIRz9s6JIkHS6uidNs
         +QOAZ0Tm4va7QKv7ISIdO4OItEdT6igWxDBuI/nBdWOGAJreqxxvwXpS/PXQ6FgTJJNP
         a0UvsjIu9UfQlqcJTD2W7/+ljQgr8SLxV0iaAYD5ItuZuq3dveFJsuiSIkTbFLmfCoCN
         craZtASBiinHY8kva/y5uj/g6oqLvri98VUP1fdSO0aHv+qu8wVkblBafbFXzqKck/jn
         PdBg==
X-Gm-Message-State: AOJu0YxCJVNjpeOnDmgHfJZdJn/JhSTcH2uAlQHtyf7uDUGt98R/r1lS
	OGlKaPmmTbceYv24anqXBFAxth+/9P9x7SHXWsusd+uViAxCLwc6sblAcKbp
X-Google-Smtp-Source: AGHT+IHQko8Ro7YvNU5/+0OIr+JEyl1KAqudpScEYzaSc1PVyruWduD9DCEuhC0WYEv+t3iVyfHw7g==
X-Received: by 2002:a05:6a00:310e:b0:6f0:c79f:cd7e with SMTP id bi14-20020a056a00310e00b006f0c79fcd7emr10363583pfb.0.1713812987762;
        Mon, 22 Apr 2024 12:09:47 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id v127-20020a626185000000b006ead1509847sm8448284pfb.216.2024.04.22.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:09:47 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Add introduction for use in the ISA Internet Draft
Date: Mon, 22 Apr 2024 12:09:42 -0700
Message-Id: <20240422190942.24658-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The proposed intro paragraph text is derived from the first paragraph
of the IETF BPF WG charter at https://datatracker.ietf.org/wg/bpf/about/

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index d03d90afb..b44bdacd0 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -5,7 +5,11 @@
 BPF Instruction Set Architecture (ISA)
 ======================================
 
-This document specifies the BPF instruction set architecture (ISA).
+eBPF (which is no longer an acronym for anything), also commonly
+referred to as BPF, is a technology with origins in the Linux kernel
+that can run untrusted programs in a privileged context such as an
+operating system kernel. This document specifies the BPF instruction
+set architecture (ISA).
 
 Documentation conventions
 =========================
-- 
2.40.1


