Return-Path: <bpf+bounces-52944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F8A4A6D0
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02171189CF37
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F7BE6C;
	Sat,  1 Mar 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwHQTiDR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259968F7D
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787338; cv=none; b=d7FtXVOPW37I2mv3fCPdf6zy5Z2dutVTBnAZL2dKOKY9vPe1IKrOUyGYytS8c/J1MnRpZMJaz3wp1Mte0BRmp6JzMN1rv6D66ZqCHp32tEfnM8+RM/j7mWErl4x6epHMRD+SyDGy9BtatTB0VU0YJj9/9vugGAxFrMhAmZ2ZIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787338; c=relaxed/simple;
	bh=Lm4viNS9jwfLfzS56hnv533rHZTR8IK56cgoJU17C4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/ywhmlF235mZ17huY4CWzDfXkiKsd5j1BsuRPBRU1S61J4CyB6SXBrG8j2STwKzkjW32zisUioEG+mMIS3GDAHo4QcS+72j0FEa5+87DyheuBKbR7ShmBBSV/GBe0VDYTpZQqq+OfqQFbwk8y/IJ7gkvxR6SJNXIsilT+gSq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwHQTiDR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2230c74c8b6so6554095ad.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740787336; x=1741392136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRDOSr0U5aPeieQz4ZJr7W8hqZ0x548srBPd1IK4uoI=;
        b=KwHQTiDR6UqQzyBkLGo02XJOHlk2Ly8rHvgMwEjYW8HeewY4DqA+u5NrdNqAxHOy/C
         rh7SLWovUhrz/kRdfogfyLlNZQFXL1rEUUIeKTjQPGIMCOWOGi9/cYbnbh3YBBrdsg2V
         MjI9X8myiRDYba746pKyiToUBaubuawaG2ZLPlp/73tprRZXp6HJbbDUFyKGa4K8qAfp
         pDlU1erRv38Bm/fNixS/LFpKox4agKiMCCb5/2wFqbjhIv2I0OOq7jFmAgFefSwzqtHN
         zH53jcfj96XIynUlHDogQlJ4ZdO9fdx2tIwEYyF3puXucOZmAl7rS/hM4DnFEygRlTdb
         t/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787336; x=1741392136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRDOSr0U5aPeieQz4ZJr7W8hqZ0x548srBPd1IK4uoI=;
        b=wTTBEU2o6aFIJ+05SrYN4tZiYMAFlbBbQfZCaL5eiCCTAE8MeoCzT8h2P5ZK37ko6F
         dvJ9NS56YXFeyTL1Dsu3bQUpOivyC0zqQ8LLPIh7VuYf2SfMSNmfmKOhHz4J0qu3uubR
         f/7E23z/bXhgb/tTFNZQ4Ifq4tY7BA8w0EIQbcfRXGAF0T1qdKveo85ZIQZ7DTFcbwT+
         8D+s7vctCxzTsf/LtjmjI0SjkKBrfYBER11sB/hqP0pHvAxEVl0NPqaYgQJOB2aGcG4f
         I2Dmh6Io9ObIqCmG1cjNJwGd7wdHU5YC3b6O2qKolaYkaOEZWmWuOnznccCoWOCpUIdF
         1yEw==
X-Gm-Message-State: AOJu0Yx+FFoCuBh996PgHG+k/1PxBR+YdkBL9BOo1pgyMpPocCOX806H
	+8h42eLDHQSw2FNVs1eFKYp39ZA5kztqckgsf49mOsW5PAU+F8Ei6mPnTA==
X-Gm-Gg: ASbGncsuuOUOreXSP7xh/qkRjoYGabqrPjoLX/PH39KCN3euVFhxedXk3CxtZrvTLJ3
	spIGj8hjatJpat2OOs4+aTBsEY8exhfgUQBdiVt2D4H2SjUSZEzhdv9IGJWLSYF7EdX+btlMijF
	udcOKKh70Dntzv9KRsAsyvYGRSzF2o5/n6gGv2lunaFefypBtSTF3922oU2qxliEI8ZYjwz+D13
	YT5/jQd4OqdJREm+vDOfbOJcEops2x5pNDBdVEymzvwLpTBAwnKsUTFePofJEcUuoUT78ja7Ys5
	OIRYPE9KLgCgGcQwtLhnW5ArmQ5oDLdCRqjQli+K
X-Google-Smtp-Source: AGHT+IEQu5rQWp1WFv2cZao+zs3sKaNamyJO5/gts5u/DD9JM4C91+1DU52Mr6HePsdoZzEL88ad5g==
X-Received: by 2002:a05:6a00:1395:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-73634a28a41mr1491473b3a.24.1740787334680;
        Fri, 28 Feb 2025 16:02:14 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedf5a8sm3993425a12.70.2025.02.28.16.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:02:14 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 2/3] veristat: strerror expects positive number (errno)
Date: Fri, 28 Feb 2025 16:01:46 -0800
Message-ID: <20250301000147.1583999-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301000147.1583999-1-eddyz87@gmail.com>
References: <20250301000147.1583999-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before:

  ./veristat -G @foobar iters.bpf.o
  Failed to open presets in 'foobar': Unknown error -2
  ...

After:

  ./veristat -G @foobar iters.bpf.o
  Failed to open presets in 'foobar': No such file or directory
  ...

Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 8bc462299290..41dfcb6f5690 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -660,7 +660,7 @@ static int append_filter_file(const char *path)
 	f = fopen(path, "r");
 	if (!f) {
 		err = -errno;
-		fprintf(stderr, "Failed to open filters in '%s': %s\n", path, strerror(err));
+		fprintf(stderr, "Failed to open filters in '%s': %s\n", path, strerror(-err));
 		return err;
 	}
 
@@ -1422,7 +1422,7 @@ static int append_var_preset_file(const char *filename)
 	f = fopen(filename, "rt");
 	if (!f) {
 		err = -errno;
-		fprintf(stderr, "Failed to open presets in '%s': %s\n", filename, strerror(err));
+		fprintf(stderr, "Failed to open presets in '%s': %s\n", filename, strerror(-err));
 		return -EINVAL;
 	}
 
-- 
2.48.1


