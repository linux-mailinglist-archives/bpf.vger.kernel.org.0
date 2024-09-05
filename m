Return-Path: <bpf+bounces-39014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DAF96D854
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999531C24EA4
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD4619F46D;
	Thu,  5 Sep 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFLf+KcT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906819E7D8;
	Thu,  5 Sep 2024 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538841; cv=none; b=MyPkrhnz3a/fgGkLVVUxnh3W1u+JYhUjJBhSR11Elnz6EZiJrm3IjBRVjjq/Bc82OLbNh1608mKrz26QW03AEFr2q8YJVJOV65PZlVbas0cXeRNFolaHoZxKMRvFEyJv7YqwEz40W3wc6uwq0SBObNCEprywXLWJcvTSf0LHVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538841; c=relaxed/simple;
	bh=fVm9Y/QOEUMr9rR39oqknRUYUU2nULL1YNvSqQyImNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqAR8fdS88InJkHRbnXolSsr+M8Ih7TPPmP3KQRKsahk0ETa4dD6QLJTUy2H/8ipl6KPrTXdEHiyNFTqH/jfps1z2++KwVhwBQbCTiOnxvK+VYjenAwpglyuAViTpXKtx3PO7Wofh0Vgubis8IPAHY0jioJKcZNQmeKtC/gcF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFLf+KcT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42c94eb9822so5596045e9.0;
        Thu, 05 Sep 2024 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538836; x=1726143636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4glM/3FKW/rcwhLCtH6pyVF0Iqx1WPdoTBExaKLwHXc=;
        b=VFLf+KcTOIAe4aFsfcURbJmSeuqVl/adN+DX4iQQMbILFN6Nkwdv/LftJ4ZPOVlt7A
         SJdatd3DAPNVKRTDPEKVuKsWDM5/ASIeuwAhQoI3cgWslBV2sC17ThgoQDoZR91XmQbo
         7toHmne0uL39l8gi+IXWacs4KkIhNw3ZxMTfNaR/qXYJsjUYTCMw7V6KG3wIGQqO5p88
         tcXF66pKdY+MZuFAfVAg6Z+RCBWA5XInZscU5nydVhA9qDvPFKHPqzuJ1zNAephOkKgN
         revYkrefLdY2UjtiGUY1KaLvAzv5sPakm5VrZYrmSpT5Pv5aJTyRnCMKYkHFGvJ89IJf
         3tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538836; x=1726143636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4glM/3FKW/rcwhLCtH6pyVF0Iqx1WPdoTBExaKLwHXc=;
        b=JSB6kLg1GiEiRyGMF05u/8haLOLNqfVirFZwZtlGt2iBQqMeeyR/auQ/+ko0AZJt/9
         eRvmWux74Q6xwr3v2KHkeDMO72g01QYeq42PJLAqydXC3h2AVGj83iAmWQ7dfPyN7EoQ
         uto1cmhUf/r9FRdC1U4nDjMrqgit0z1zYMCGZYADJVNfRawot6aSM5vIt4IG9dHJ94H0
         zBQZ0yWmcal6Xn4GW314eGPdWNkzBskDn2NaLFZbdvMalwP4POaAah/Uetuhhq2KLY5e
         Nv7xCZLgRlV1K1Ccgr05i/mz6KRycIb5A4nkRFsEyPb22iEymWBv3FnWdsF+Dy5EjSj2
         5hOA==
X-Forwarded-Encrypted: i=1; AJvYcCWG6/J3jrRT6oIo5+5ZS/LFXq5jao2hgJ541/rs9gmrxhbMYEpzskZ/503IaGFAQ9JyOUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywz/DLSnk7MrljEEnJ2xYo9k8xxl+fanLZBsHIuuEzrVCYopNY
	VmqsWcnNDEC+MzXoII3uG7wuKuS7SumzlgoJhW+0IwFgi3lMladLdDc3y+OW/3I=
X-Google-Smtp-Source: AGHT+IE6tJ2IaKVHuBEqFc37narZUGnnVfK/9FWMttcdTYXFXtxkPDCB7dPPNI0rwquU3G4uiS+W9g==
X-Received: by 2002:a05:600c:190f:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-42c7b5b3ed4mr109911685e9.17.1725538836397;
        Thu, 05 Sep 2024 05:20:36 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:35 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 08/18] bpf: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:16 +0200
Message-ID: <20240905122020.872466-9-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7ee62e38faf0..3f0d1eb7f5b0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -21,7 +21,7 @@
 #include <linux/filter.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/objtool.h>
-- 
2.46.0


