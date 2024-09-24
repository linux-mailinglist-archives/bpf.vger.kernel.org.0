Return-Path: <bpf+bounces-40264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B8984A03
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 18:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB751F21D1A
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921031ABEDD;
	Tue, 24 Sep 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6jQ0zKQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AB1ABEBD;
	Tue, 24 Sep 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196735; cv=none; b=Fjkm0ot9KQSzx2BriTAkMqrae7wcyoo1SoiHjpmFNWFDpyDzRdg3WyS1aHGUEeoodOxtBm+0z8BwSfvNYcDNSHHgf46or0OSqfU+p5IBJBC5er+N765v4rHKjvlIAE9Vzbjvp6w3qYEvg34JA2PVa3qhl2hUVqSHiAglUwMZBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196735; c=relaxed/simple;
	bh=H/6l72Ca7+Y8qi9YMnj2+EzvUgjRfVz2PbhqQvLFdag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oxI61Ip9YO0tFidVpgseJ9MapE3sKZadf6/2/8XgGi0EI/iCZeJF0TRD+szvMCURi75AKal+usfnYRD7RT1jhfQ/iYIC0i1FWZRGIWtszxKmKW094gOUQu8L4LWVG89LxBwphxn8VdMP2kL/UqAlQVd+wSILA3drm3wS0NreCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6jQ0zKQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so3427486a12.3;
        Tue, 24 Sep 2024 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727196733; x=1727801533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiCsAkbQBe9LJKRTrWozwpKUfdPwVMDJuNSsnhssFKE=;
        b=e6jQ0zKQ39AlW/cDmTak1ox1Y8dSuLF0kVR9SCpVERdu82G4ix3sfSkgeUYtbci236
         6RpeSM0kQnRcfjhHP1YhcT9khZFgAHFyue1xL0Km7kJHHxArEM2fezWfnSPyYNW1Boot
         eGVYZXk/P8w4ERaRXRUVVij6qux9H+ws4BAdr0N+Z8hzas39nJ2SsvgUk94hnO8aSOOO
         MyyCCTIHOS0SqyWL80KW3zKcKHSv0UeZ74wJdWQf/tjOOcwOJ8lpj33WjTlJ1PWaom9k
         C6lmeWrFttfc30kGsIUoHwFgjmV14VTCu58csZ7BQ5gxVMKd1ztulJqFNjku6vbRwyN/
         /BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196733; x=1727801533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiCsAkbQBe9LJKRTrWozwpKUfdPwVMDJuNSsnhssFKE=;
        b=MC8x9pGondbaoWQlnb7KFjI2oqyLVBEobhysrMklg9GundH9uOTnoxQZVdKxG5snkZ
         8uLw/x3ERRflws0DEqvMGzOtqNQhRe9Q1OsEDFqHs0xkLXN0rdGdmhWptqBcuMsYirbr
         vG8GWbJ+eDBE3HfuijCAt1K1Ww/zQCMd/QQ8/elU82BuPESQTwrifZVQZW+1+I91Z41I
         uXmlSPx1U+iGLIVYVdZrBcq2NO63WqetnbLW6vOf1CAVQw+B4Tc1iiILpTfDLWA5hbZQ
         Pel9/U5xBCri/T9NPnN9vjnZsonAM+Y/NiIzFmh2Lt2sh5ST7QMLncH4gNdf5m+XoBQG
         fU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEHnMfpg87oS5AMMOivZuXdTKm2LUe+BsdLrBNGLHmGGNOhO9uFlsTlZj3gRXWMGNMOtbGh6CzwYSy52Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVtj+4UXOYvKH6ELTatgCTrr9UxQU2OlLVNoLd+RoIXCMqTZ4
	R4lHDoKMSxLacRK7KtEyBbrTorC0RmXvDXErRLR2f3N8wE1kl7nl
X-Google-Smtp-Source: AGHT+IGsNcreWmqDP41QHpDWhnsfEBCZpeSmRWgtBSl2Ji72JhPdSGV+r7Wibq4jlzSSzJkWjNU66w==
X-Received: by 2002:a05:6a20:e18a:b0:1d2:e8d8:dd46 with SMTP id adf61e73a8af0-1d30c9e69d4mr18596550637.15.1727196732696;
        Tue, 24 Sep 2024 09:52:12 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc939068sm1400177b3a.133.2024.09.24.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 09:52:12 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next] bpftool: Remove llvm-strip from Makefile
Date: Wed, 25 Sep 2024 00:52:02 +0800
Message-Id: <20240924165202.1379930-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Quentin and Andrri said [0], bpftool gen object strips
out DWARF already, so remove the repeat operation.

[0] https://github.com/libbpf/bpftool/issues/161

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/bpf/bpftool/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index ba927379eb20..43bd826b0879 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -219,7 +219,6 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
 		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
 		-g -O2 -Wall -fno-stack-protector \
 		--target=bpf -c $< -o $@
-	$(Q)$(LLVM_STRIP) -g $@
 
 $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)
 	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) gen skeleton $< > $@
-- 
2.25.1


