Return-Path: <bpf+bounces-28045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC748B4C97
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126BAB212C2
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394586FE35;
	Sun, 28 Apr 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odgq8vRq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D236E5EF;
	Sun, 28 Apr 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714320663; cv=none; b=FMSz4dXrx6K5ia0IWiqWymPpUIxA1tzb08NRbKGFN24x/b4cUW10Q3QI23FlHkMtkMhWzPt8Lx6UgkN5XczKRa68oYzBuPQ57C+zoHJIF64BwIoJcS0rirHmATqI619rP6J7NPgXW4D7el0CDy99o/1LHyHKh1VRZOXOJPLAOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714320663; c=relaxed/simple;
	bh=6tFDsKpu6tXL8zLXNmoHqnSmgpgJQp8ILsz90Vn48ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M45HaDVmzBrIyetq4O0SiGNUAlyG1eV2anvkioMpyrk6gO/906YQWtJifTWxMNZCOUDqcamW3d1yQUWtomG8TBIBbZQm7KxHCdCfgY1oXTzdikSDWRtP/e5B8+6RyRmz7JcWBTywdNKdfdfbqWfVf+HgE1HpbhjZqRsmdYEkPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odgq8vRq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2622260a12.0;
        Sun, 28 Apr 2024 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714320662; x=1714925462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kiR1X4XEYcmyl9Y3bjFeNU2iq67tOTmz+4bOcXGmymA=;
        b=Odgq8vRqi/v7eQgqpUlibC+k0wsuwfBW+ei9Q0HyoyUrcgA+db86EynLNXglInHIYq
         1OSwEiSUMU+KgQxeyEapeVJL4FVXE3VRoL1xqrhqxlFS1NLnZeGHx2ohR8DPf0gXKt4l
         rnjiK2HHY+rSN3EaROhqpUM+OxPzcBy2nH2NliHxaV//ixLUETfOfbkAjh/fz29z4fJB
         i89BS3ZlOOagmExY3Ggn6wE0zTmaap85kzbAvrqP66houd5eCZvzkzpnNNgCgGmBxThS
         9TZ9K2xzQEpSsgnZpklsSciuutFTW+k5/b0NHQSMRQ1M33EsTZguKUx+Xp0aSx8LTcMU
         lltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714320662; x=1714925462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiR1X4XEYcmyl9Y3bjFeNU2iq67tOTmz+4bOcXGmymA=;
        b=MR/d1TdJDD0C/eGJFnCQYeSGYK8C8plNzo1HtYQVGH7fQtlohorFW6XdWbI87tILin
         Y0AVSLSwK35E2oYjl3IDvV9UWQXx8fPuxXs7Nqh7AizrreB97e1C+xX2E+qecGiwFYlq
         9tCAUJG1OADEJhDi37WuKrvRH0IDrSiaMLFoLzAvX3e3CbEk8gx8MyBDNy8RH1K2kzpK
         xiFydjwtSNMFMCvKPOQn4mV9P5CQ48dCBlZOGyQZ25yQNRRKzuURlJMQQtZpYDThZuqV
         nRNe3GDASmNNdl1EMAdfeu5EmThshQyT4o9dtkom3enhOmBcuYLGEI95hD5f592AA2nF
         Hy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVk4eeRWvDBx9ZGejCdVzLEyTJudn5gFI80IoHsdQziMnRCXOtFATG7B0XgG+IZIr9fIYjZwbOET9SJVYUmHMTxU3SueCE/aKgRbqyZ
X-Gm-Message-State: AOJu0YyYwuV0n7NSTsJyoCM62RWSIbOOGsQRrVlSkVyu3SH4cbWC5VTy
	Rj3BWEs2n8dMcDU2IJ5iDzfAMiwh3JnFXlFYDrsp+zqnWlp6X8B8
X-Google-Smtp-Source: AGHT+IHDhxTyBclN0U8nV7dhqSE/HNPD5aHpnTpJ0Dp9gMSP6XQwS9xldgDBmfah4WMYDokZ08kMww==
X-Received: by 2002:a17:90a:fe06:b0:2a2:fec9:1bbd with SMTP id ck6-20020a17090afe0600b002a2fec91bbdmr6256989pjb.17.1714320661563;
        Sun, 28 Apr 2024 09:11:01 -0700 (PDT)
Received: from localhost ([183.247.1.18])
        by smtp.gmail.com with ESMTPSA id o21-20020a17090ac09500b002b143417622sm1428685pjs.12.2024.04.28.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 09:11:01 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	chen.dylane@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] samples: bpf: Add valid info for VMLINUX_BTF
Date: Mon, 29 Apr 2024 00:10:32 +0800
Message-Id: <20240428161032.239043-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When i use the command 'make M=samples/bpf' to compile samples/bpf code
in ubuntu 22.04, the error info occured:
Cannot find a vmlinux for VMLINUX_BTF at any of "  /home/ubuntu/code/linux/vmlinux",
build the kernel or set VMLINUX_BTF or VMLINUX_H variable

Others often encounter this kind of issue, new kernel has the vmlinux, so we can
set the path in error info which seems more intuitive, like:
Cannot find a vmlinux for VMLINUX_BTF at any of "  /home/ubuntu/code/linux/vmlinux",
buiild the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or
VMLINUX_H variable

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4ccf4236031c..6fbe9345eb6a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -326,7 +326,7 @@ $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
 ifeq ($(VMLINUX_BTF),)
 	$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)",\
-		build the kernel or set VMLINUX_BTF or VMLINUX_H variable)
+		build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable)
 endif
 	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
 else
-- 
2.34.1


