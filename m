Return-Path: <bpf+bounces-21378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B724484BFC9
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED90DB256C5
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2471C294;
	Tue,  6 Feb 2024 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqUGOr/H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892F1C292
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257139; cv=none; b=MfHRXakU9sTRd5gWLxshHL1rxWCFAsFqf+qg0OP7LXJQdpcdyXN0YFA+zDFH3Ybi4R7p5hQeKHWJEQa1wUm312Zj3BDMgxbW0SADjZXnVHjNxgfHi1KYeM/wCS5m67+K9OfuE51VLNyKbeBbC0MS/NwwtvLE3x329AeHoFAT8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257139; c=relaxed/simple;
	bh=D/TrAhQWAcIDdh/oQnU+KCkH9OnP8LFJRj8yUjQYKhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z8uLwI+B+FyXwgVgJJBJYVEJQDdGocNojxd1TBYj3DNXL2BZczB/K7WDpOLv2YDECBuw4z4CCj3kpCq1uo0vYmUN2BOTToOWgtSpBS8P7LiZilk4m6RnZCbzHcZS3KKkH48PtN1coAl3z/Fdon2sodg7SDEiRNWqcOqT3R58J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqUGOr/H; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d731314e67so96645ad.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257137; x=1707861937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCIDfn6Q/Sj02IoZMnsUeC+cwQq+R0K4Vy6avN3EcgA=;
        b=CqUGOr/HZgmPRetvL5Npy7dbIWlfoLDqskgF9sAUC1g9LDeN1rJhtHSbXsHAv+FRfi
         ipUrgXx0TRpOWH7amOsfZiqxjcCtvqJqm1+w7hYUs9r8LPCamJZI0T4ZL6nklVG7Nu/c
         PwRWCoOiewRZv8zOcG2mQm7d2sQdeX3MFsgWmSnsSa+Iy3b3t4iyMiPyKi1bvgWFRQvY
         HdtySf0aaz0G6x9BvpBDv0PMI3gyC+J6692m6Bak0N6t3BQTSxoYcBzLHl1E3JY1q585
         b2qLRmS7Jf5BFsqJsVtyz70+OUYw7sTRV91oZtRNg0/rFzdNAPSLQ30w2re7OOIDtNJu
         FLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257137; x=1707861937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCIDfn6Q/Sj02IoZMnsUeC+cwQq+R0K4Vy6avN3EcgA=;
        b=fdNZ9fK62T1heibyf8TE98ULc/FTRk06+mAld7UJq76i5SFcOyP9d94Z563SfHbqDV
         ejXTETAfYksqSP8J4bIIs8GCiaD0QtfjcH+MXE18+ipWmsfTwyubAXtxN3UPFz2EAN3t
         DUnZ35YTCBXBDxew6BkO19C2ib1XiAlg9nFsbufghMgyEMscLI48Xq2x7B5aGIAmxk3C
         +ZJ//r7U472+m+SOwoDGa8gokh0fvh1pFad1qjZvKZxfS2i9N7yWDl9DRk2PSk+nwBYe
         paNAxIPZRufAVrLI7BK6lq92/t7PVOEZfCaa/6lCR/SzO100My6OpNfDRYcRjIR6DdOc
         r9zg==
X-Gm-Message-State: AOJu0YxYaNtcv5O0n/XF9vBA3izBuFyCzq0CU7fGTPoTYmzREK2Kcw6A
	MzdAoiX0S9QAb24O0PguxYWuLdmIBHQ3Tb9QwJXhA17KEAsra3VO0qLGNub/
X-Google-Smtp-Source: AGHT+IFC/8gaSn2ezfySvQY9fE+LjbzC6tGU3b69/lMAgjDuoKzugaxeFxuGwhXQP6FF6XydFy7cZQ==
X-Received: by 2002:a17:902:d505:b0:1d9:1322:5b0d with SMTP id b5-20020a170902d50500b001d913225b0dmr3444099plg.65.1707257136843;
        Tue, 06 Feb 2024 14:05:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0x5GbXUCf5LB0OoOZH0U0NIvJ4KFVm6E2YVqM7e7OdGPW+05tZ5DAXSvvES4yBjccZ+t5IUAp2y3ibsYajhe4yp9SVObP53SFLmqQJAkx7FyJme2n9iRr5USNt4OJlJqM8O2xXtKU+496radnUUCnB5P/KQPT6zgteLeYt5oGrVMYnpbH4/Dh7vDvJGTDyB8HeVf+n7M4FLc534D7uDs7Skwll/6R5u6HMOZl0XgdXeTx12OGxEAN58tNuRpgmiZPbXSDoBOkb+iBJSRun85q1Mu9578UYxyZ
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902e18b00b001d6f29c12f7sm4613pla.135.2024.02.06.14.05.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 13/16] bpf: Tell bpf programs kernel's PAGE_SIZE
Date: Tue,  6 Feb 2024 14:04:38 -0800
Message-Id: <20240206220441.38311-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

vmlinux BTF includes all kernel enums.
Add __PAGE_SIZE = PAGE_SIZE enum, so that bpf programs
that include vmlinux.h can easily access it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2829077f0461..3aa3f56a4310 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -88,13 +88,18 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
 	return NULL;
 }
 
+/* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
+enum page_size_enum {
+	__PAGE_SIZE = PAGE_SIZE
+};
+
 struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags)
 {
 	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
 	struct bpf_prog_aux *aux;
 	struct bpf_prog *fp;
 
-	size = round_up(size, PAGE_SIZE);
+	size = round_up(size, __PAGE_SIZE);
 	fp = __vmalloc(size, gfp_flags);
 	if (fp == NULL)
 		return NULL;
-- 
2.34.1


