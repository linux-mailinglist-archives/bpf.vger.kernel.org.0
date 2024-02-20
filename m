Return-Path: <bpf+bounces-22282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E4285B1AD
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 04:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C2A28224F
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E94757332;
	Tue, 20 Feb 2024 03:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ie7uavN8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6E57316
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401086; cv=none; b=oDF5n219Qo2ZrQbJPJNTrxGdtYR8IzuruptW/DE2EO9bfPF5XLkbfPdyBsT6iJKo9L3/dMjsI50qOVTmTAaR5DdZnBsVcjkODvjck8gFxEBv78j2pb3yVeTsbsjCBmBiG9MrgvAUr0mHi6Lkzo4w2Uf98H9m5Ge7S+f2AA635TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401086; c=relaxed/simple;
	bh=xa6vI2/sky4WmfzJ7YKtx++yDTvsili9mip7x/cutc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/bXJJFGL7EikfM0BiRxkBTvy+Hll/Z6nl5HaIBqG3Ge1tQ++75+e52dbiRN87AhNaRSTe6Lou/GzX7YJWiAQzSSYGeP5E7JxBRh4XzEJ8Bu7MyHw7WOoR0xXm/kxqgqDL0yPE0UKm6NuVTswU07SFbV0Tpla3W5PjFaGc8kRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ie7uavN8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d73066880eso48157105ad.3
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 19:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708401084; x=1709005884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAc3ZPxMOkJPGWpWg+vGXamMVExiMG/0L8fGFtmgr8k=;
        b=ie7uavN8uSClt/TGncDB3TdnAw4Tvf0txv0yIiJdcQX+NgPVCwqTL/kmpM0V8tslCa
         3YbV2X87SVV7njw4CNJDujdr4miqy1hvBOXajkNH0D+GQwuYsJ5SggFntej9nv+xyGFM
         1CUSgRfg+JiAABgmaO8RV8GZ1KLuBlmHM/uTSHK+sj2AWb5xjuURqjzdW2qukDp2tBqg
         YD9m9/vprWf+oEnHrhRN1lAt0RA1cBTX3EKq7I6Vg44BtQlsn2D3AX3HMQJEuadhnNtd
         EhFd7gS17z5nob6bA2g1lBr4gAXTBQKQBzyzj961GpxarQCe8Q3g7E81ykCjstua4ugD
         2bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708401084; x=1709005884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAc3ZPxMOkJPGWpWg+vGXamMVExiMG/0L8fGFtmgr8k=;
        b=fSvAzZYuBdDGzRxKMbPX3u7319ZJvYha62Cu+xs+w5MKaGSP2RD8GbgKXK09ORfOwf
         lRa4hhmz55oukrV0F04XFT+DIJ7i9RTFfM2mkp3YztcId/EnQbaPSpTF8F29Tjj61GyS
         uatqVTu30c0YAqOwy0VYtp7v4FeFERD1Az1bSZW/ocWx2kz3mzRIL8iZr+wVhDcDMjVl
         t5WYltUZUh/jyTY6znzx1Ql8D/fGx/7ieenZTnkco4zWFKmMN81ubo56l13Id8i4istq
         cJCOJnsNlLje9W5W6Psexg5jpzvSufHvkgAeBnOF+SOalLEhEuX0pJEc+5c2qYQMSU69
         mepA==
X-Forwarded-Encrypted: i=1; AJvYcCW6aS0kruDJyd5Mnnin0hLtcxGg5qY9rIKUDRb9ikYdDWo+h1SKWfwoQ6S+ZfnjY6WBErznh8JN14vwMUOIVpcBJJx4
X-Gm-Message-State: AOJu0YwRrbBqq7Vjs1oggn0ZJcb+H/KDPl4SkjWol1DYNYi+fmIUn/tt
	mvgSBYbXlXPHKlk4wEBbKSLyVfv581xb8kYsNThnZIKks0JDgRo6vRMLyQSCgHs=
X-Google-Smtp-Source: AGHT+IHQpCxkiwyqn6Zm1Fes4enjMkFx89FgEyyFQDO3dIDdg+gKRtfhqWsxDi1vxYhI5FVDAqsFHw==
X-Received: by 2002:a17:902:e744:b0:1d9:c367:201b with SMTP id p4-20020a170902e74400b001d9c367201bmr18728920plf.29.1708401084154;
        Mon, 19 Feb 2024 19:51:24 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id jz7-20020a170903430700b001d94678a76csm5131723plb.117.2024.02.19.19.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:51:23 -0800 (PST)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	dongmenglong.8@bytedance.com,
	zhoufeng.zf@bytedance.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 3/5] libbpf: allow to set coookie when target_btf_id is set in bpf_link_create
Date: Tue, 20 Feb 2024 11:51:03 +0800
Message-Id: <20240220035105.34626-4-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As now we support to attach the tracing program to multiple target, we can
set the bpf cookie even if the target btf id is offered in
bpf_link_create().

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 tools/lib/bpf/bpf.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 97ec005c3c47..0ca7c8375b40 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -737,23 +737,15 @@ int bpf_link_create(int prog_fd, int target_fd,
 	target_btf_id = OPTS_GET(opts, target_btf_id, 0);
 
 	/* validate we don't have unexpected combinations of non-zero fields */
-	if (iter_info_len || target_btf_id) {
-		if (iter_info_len && target_btf_id)
-			return libbpf_err(-EINVAL);
-		if (!OPTS_ZEROED(opts, target_btf_id))
-			return libbpf_err(-EINVAL);
-	}
+	if (iter_info_len && target_btf_id)
+		return libbpf_err(-EINVAL);
 
 	memset(&attr, 0, attr_sz);
 	attr.link_create.prog_fd = prog_fd;
 	attr.link_create.target_fd = target_fd;
 	attr.link_create.attach_type = attach_type;
 	attr.link_create.flags = OPTS_GET(opts, flags, 0);
-
-	if (target_btf_id) {
-		attr.link_create.target_btf_id = target_btf_id;
-		goto proceed;
-	}
+	attr.link_create.target_btf_id = target_btf_id;
 
 	switch (attach_type) {
 	case BPF_TRACE_ITER:
@@ -834,11 +826,10 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 		break;
 	default:
-		if (!OPTS_ZEROED(opts, flags))
+		if (!target_btf_id && !OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
 		break;
 	}
-proceed:
 	fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
 	if (fd >= 0)
 		return fd;
-- 
2.39.2


