Return-Path: <bpf+bounces-38112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C5895FD78
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1D91F238E6
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B719DF8C;
	Mon, 26 Aug 2024 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXZhNSwj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312C19DF81
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712517; cv=none; b=Anyw+JRINTB/rb7Ir4NBHHfIRFR0B242ZFd2DxocbAOllDbWw0X4Jeppw4XMPNGHCbzp+h30SHssNfyaP2qpniozn0jerShJ7c75/clQSD1iYjXbhGXgKWg/do1W82nT3DWcAqNeimRKhKuTqZCuYq0QWXGmVxhOHhl3K4Ew+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712517; c=relaxed/simple;
	bh=9xKlfpFot22U5gqjjQOK2mI3/7fvoUTb1ZrOuqiYTFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuCNas45U6+7LhoXqFY+8+xpdQEFJn1mzZGt1HLRlQR0GJj9Hx+ZwNsWlx7qsbh34LkLaZRPj5PM7ZZSgdfYu61j5TaheCPa+ZYg0JDSG7nxuVsmcA9pOBdSgdJ+b9Y0N2q28ucFba41o7tJiRr30gAQlV+Zz9maRht4xlIAKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXZhNSwj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cda0453766so1533352a12.2
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724712515; x=1725317315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NpR7sn9OYZ2aPx0CXsAWfuEcgGzMBxKsHHcmLUzgHc=;
        b=TXZhNSwjM+ikX0zU7MVE0kRs1bCSX+Xsr1jwrdoIxz0p2IrIiE/z+Wpl5J3XJ1lNEx
         pGWgMqBIDD0bgCCGFDCwEitpwO85I9b3CprIkRL1hm9isKiODYFanjY0rU6BnyTYSEfZ
         dTy4eEaL9RsQIxAsr+ua88xgpy8iNLZcukGzLyFoUO98/rA1z8eRKkUSF0T4PMfY/rnM
         0vYA5LYUIOptelzlFU9RtqJpHoDhc2xbr3MnPq0W9ANVzO7M2w/lnJTr4ppXCPBIl0Ss
         SPTL3kMYHkBgAMDQVfnNol1IXRYo9Gq13XCd0qR5A3WNZb9Lm2zZwkUhpBdQAUWBL5Nm
         J4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724712515; x=1725317315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NpR7sn9OYZ2aPx0CXsAWfuEcgGzMBxKsHHcmLUzgHc=;
        b=MES+DuMAMnayGMbCMvyc1HuDVrx90DeTziADGp51mrRiGK7/bGpC9pP3HzBKknlcbD
         FrlsggagT+yITTjGrVryqYHAxob5TVcWssBD9DbWIC2HkGo3HuAD4siV/150tOPxg/Ec
         foR6ao9Z5h0yJQXxzT9QzytHWOxl4bFJmN3beyOTnVV1n1KQA1Rj9i6ywAzR8KIJaqFt
         L6/thnfixDZiSwIBOA7ctJlvnyTP2WNVAFDDRedxtKaqF1A+Zdgdqs444ftZONbvlnWw
         NLS2/LUCUTllY1IsNuNSxE7HVBIWr3aP1K7RP/WLg1imKlaDQrZk97BgrOUiLw4JQoWc
         0Iiw==
X-Forwarded-Encrypted: i=1; AJvYcCVolU/On0qthDSHOrQ4w34AlfBNSGVPklAdLx8SFRYQNswyNkpLjtm5uaoKeG//iYdxlxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhq/Og+vVji15Fc8gd2B4w8UfZvWEAIi9FrkghRdQzoU3icAbi
	rLLYf6AGIPXRotcj774/N5LJ68zsscB4Bj+NEAkMejLoZ0BSY1GY
X-Google-Smtp-Source: AGHT+IER0bh65YbBfRLKX3Nw+t2aiySxHcptZstAUOkrzDbhYbRTkT51/5Vqa31Ao5bBqxetyaO9Tw==
X-Received: by 2002:a17:903:190:b0:201:f5e3:e36d with SMTP id d9443c01a7336-2039e495133mr112789015ad.25.1724712515219;
        Mon, 26 Aug 2024 15:48:35 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855808a7sm72128895ad.72.2024.08.26.15.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:48:34 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 2/3] bpf: register additional prog types with cpumask kfuncs
Date: Mon, 26 Aug 2024 15:48:13 -0700
Message-ID: <20240826224814.289034-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826224814.289034-1-inwardvessel@gmail.com>
References: <20240826224814.289034-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the cpumask family of kfuncs to be called within tracepoint, kprobe,
and perf event programs.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/bpf/cpumask.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 33c473d676a5..30b0164a2212 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -475,6 +475,9 @@ static int __init cpumask_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &cpumask_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACEPOINT, &cpumask_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &cpumask_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_PERF_EVENT, &cpumask_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
 						   ARRAY_SIZE(cpumask_dtors),
 						   THIS_MODULE);
-- 
2.46.0


