Return-Path: <bpf+bounces-67285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FBB41E5A
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0884C684CE8
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946CC2FD7A3;
	Wed,  3 Sep 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsXJB2rJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CBD2FD7A7
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901172; cv=none; b=ipeoUrrFsb8j/ZVqiWRHdm7uGg5l65770m1vAe3TqaK/FiGWDPhTtBqZxeZOPoUOdsi/dAB+mAq1Nyg4YixvBmgeUso04dOs2NOPi67eizMAiYZZc5Rs6Ybw8FxrEuROipKtbrVyKJsIIw5M0/3y4SB+Y6LJ7A85+SQdx6FMcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901172; c=relaxed/simple;
	bh=pW8hgdFY7Zy9b2sPuqrh0HAZvrw+j2HcAcMu/yU3uEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/yi195AefrpB9gieIayUrHttCby5KDDuAxkMcVPe58qIbI0B6B1kssrHDGOUuuYeh0O8qPRd7ehisRvfPg+94l2MpUVPCVjJ+ac2kaXNfAf7n9FGIMzpa0bwMdyBk5hucpJmPEllMgdWXw+vUrYBMeFIl+hXPn1udzkpgu8fxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsXJB2rJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7728a8862ccso9157b3a.0
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901170; x=1757505970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe7u+orzOvLVezCU9OlBjTeCccmJExoTEHJ48lrVKZc=;
        b=EsXJB2rJnHOfbM1lVXbJACoKD2Czl7+zGSSzsWcAkrmg4EGvPuw93cizUsnZ8Ahv+s
         UxJzkObZzNsfbs7xh3XJPfAJOUhD7tYim0Asf5Xw4kq1Gfesu73KqsePEkujs/EQibWt
         1GrkEYa1l2kKBSHPHV7wBBqRbakbU6lryd0M2S6EcmnFS+2yYpsumMqDJ+G/wepfTn77
         O/RLWkSD7XXCWoYJlBUWi8c8zF+F/u4kQmj2N+E1mvmv+B5fpifH3LLX5KtbhvPJoVJu
         NlwYlhDtWTSSZg5BxHN+JgCivVeHdogHDhwk3f5FI89kKYRcdjv9TnrjVsKr4krZr0sO
         d3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901170; x=1757505970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe7u+orzOvLVezCU9OlBjTeCccmJExoTEHJ48lrVKZc=;
        b=USnZ8/EbbwpKVbhSq6Tngiuz09DO51AuKQZnJFcDls39h5yVq6PeVCQV6UKRBud8QZ
         +Q0v06MAZmQ7s+qs/dEmIgPOOeBAaNyvXmo1KfSCzSEXKhOfAuw/xl6otcLlFtUe8Ol1
         2JE1ir7G8a9/Rv01l21bZqvtaszpzDIz1/6PsZfVFJPYPocbOtNQ1gIhRFxJ23mOLnXf
         KF5B4EtWeRPddZLPRiEahGJ9GiZn5JFy35VZesWbwiQYnO2DT3TX5mKCUhnVo8CiBUcr
         oyB20gXi/Po41wr/JMVuEouKitGOGrycS0Eq39+C49oZJ3wq6ZwNLvKZIVXoN/UuyW4j
         yM0A==
X-Forwarded-Encrypted: i=1; AJvYcCXrWIQ51+IscpozCMdler2xTr5y8n3EO4uCl4kvuPcb8sda+PFuDLWAx5YcF9aWu+r9Zug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+30Tb6V8lvVaq6Yn2iTcqD8yllryNtNNIfY216FoC8BDQZ4B
	fTMmbk01McK0hdSrrX+mnWkNcaJZoTh2Fj7h0OR3Z4MqlTY2f6srLVyUHmMzMELYk3k=
X-Gm-Gg: ASbGnctODnhMRFvizD3VmTbcjt+cb4E7McRn4qlGGp3DOSunyllHN+IjX9dAWzCMY7/
	Lb4tnFxHc+RW6POJ2Dh55b1dcR3AqoEBWaD8CZopjfxuPxkVR2Y+1qldYlveTrrG8ezZgOPOA9L
	tSiZ3RzGxxnA8AINX5bFSYX3aKDdEv2NMMOvI/cQIHvhWyZO/j/kASwiIl6t3kYfEtcG/EJhZnq
	H60jd7PRGE8EW9AOIr3qj3HONUJBxZ/afMRYa/UWFLfkc2qfvCDI0//L1jxxYaeth12TbiQPuye
	pMr6Ca3aWGIfnodWZgwjW+fKDpMRPnPMa60DahTZlsk1D4ZoRntCJ5gt91PY1BMtLz0FqSkOLJX
	o5KEjfNpPACjjdp4wa0shsxcx0DI3G6eWXGou/wuoMrkf1MkPRP0=
X-Google-Smtp-Source: AGHT+IHcbXuadl6qxtnidApDSs9NzEUJ2cD3eGt2HX37g2K/AJeCuHsM00R7bkbMn30UiDk69xZy7Q==
X-Received: by 2002:a05:6a21:998b:b0:248:86a1:a242 with SMTP id adf61e73a8af0-24886a1a561mr2427957637.4.1756901169787;
        Wed, 03 Sep 2025 05:06:09 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16615899b3a.92.2025.09.03.05.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:06:09 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	hejinyang@loongson.cn
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 7/8] LoongArch: BPF: Make error handling robust in arch_prepare_bpf_trampoline()
Date: Wed,  3 Sep 2025 07:01:12 +0000
Message-ID: <20250903070113.42215-8-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903070113.42215-1-hengqi.chen@gmail.com>
References: <20250903070113.42215-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bail out instead of trying to perform a bpf_arch_text_copy()
if __arch_prepare_bpf_trampoline() failed.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 07ca32c673d5..6dba407c202f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1719,7 +1719,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 
 	jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
 	ret = __arch_prepare_bpf_trampoline(&ctx, im, m, tlinks, func_addr, flags);
-	if (ret > 0 && validate_code(&ctx) < 0) {
+	if (ret < 0)
+		goto out;
+
+	if (validate_code(&ctx) < 0) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.43.5


