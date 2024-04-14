Return-Path: <bpf+bounces-26713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA0D8A4058
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 06:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598BB1F2149C
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 04:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE04919478;
	Sun, 14 Apr 2024 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vtjb0F8o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1517993;
	Sun, 14 Apr 2024 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713070308; cv=none; b=qkM0LmlJrRSUlblR4EZ4Rz3aiEGn5Zqn4whLH5IV6lWP3oEToGYD/vwD+e+D4PoJULCrqShVFPF20gb6c9e+C8UXdNpTL/3kKY/b3bALvsH4nH4yfyHlh27CFoAs575oLE92KKNu8Uo3qd+RVM4rELzfO56SqeAnbhfkAXPmaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713070308; c=relaxed/simple;
	bh=8X4dc5siRz0W2BoOe5zqxSL1SIvb3vj6iJzc5qSEHSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FMpCkpkhF6nshaHSUiiV8sBi8J8M2ZXDX/3mQG6RcwCVFEzlRIQ50rjlkHAR6LIqpUs3sWlc75CfbytSTAl6u2HlVnfe1vBuZF1f3tHn2VcIwNmwLyMb/IsWT9lpQQ9A0VzVvtAlr0vnAQIq8RbM/y1MDwYfKnXGICobdyTjJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vtjb0F8o; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a469dffbdfeso68717366b.0;
        Sat, 13 Apr 2024 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713070305; x=1713675105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+N9vswaqvUmkMmtjOB6fGa/yUUPk5BvqUVmQlzZ7pw=;
        b=Vtjb0F8opthji/6t9mn/bcpfRakw6TIC0W7U/QLIMXic1xhomDOZcE+g6mJR2+qtog
         GsEmN7WAUovjXgZFgvhKrCeGxrwzExmBstR3W9ToaXCi1mmKVcWW0sbmqsI8dFvYO0yR
         2M/ZJZE7/baPjPOVyegNuESsoh8xaj1JF8p1TW/9eiYoYRCZAGHID/sb/3TwCmyjLkol
         tCsp7dEXKfhUJ3qmAYGloghKZ4qOsqnRK9ong9ru9hBpO/L1kRV7zu7NCxaycpVrsQZY
         KbslC5P8gGFdOhIJvMM6EkkpCUMKmjQXFRoKrTolbTIgn6vfInK1PGEVdEJBwt55gRt+
         tYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713070305; x=1713675105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+N9vswaqvUmkMmtjOB6fGa/yUUPk5BvqUVmQlzZ7pw=;
        b=JnkGweesKhp0aBvMAvngdQh8n8PxZc342Y08sIs/0oGpta1IkhqfS+002TlVWuit+J
         V42PaNJVkSDpgfqkWyBExjY2+cUpiTk8fWSO+cdZn5zMMQMO+ZWCUbrFbAHbPxT5JRg0
         FGqUnVZr0KZzVXIvZ/dIK4zmh/MslfO+i8jQ06vP31mJiv9OEG6PtylH7ia1vP0ER8Ut
         arzFBAvwyKupo3oTa0PrA4sZGwjr/sgQ3wkDUF3PW0O5FRFnR1LgzpdwrZh5DJgqp3P9
         7YtyphL/IPouzPR14+0756BBg7p8TNGstWpp1+1CyBC2hY9whPH7E+J5re8Y2ZOwic2D
         rNGQ==
X-Gm-Message-State: AOJu0YyI7ObFyt5z/ZPVFGmz6Tj+0qNIzbgAX8vudFNJMvOdgWPj+CTu
	HXARdwpqZP0DGbQkgnxS1ctFLYBaGPMJYlrUYLq0eU34SLmE7zUFf4e/QEfa
X-Google-Smtp-Source: AGHT+IGV1kDHNDOc955MM+JtWe5YozJc4VIo07sG5GvAsItftiA/JTEiRWHQOmwoj/5j8R6pFFvAew==
X-Received: by 2002:a50:c2c2:0:b0:56f:e1af:58ab with SMTP id u2-20020a50c2c2000000b0056fe1af58abmr5225812edf.4.1713070304850;
        Sat, 13 Apr 2024 21:51:44 -0700 (PDT)
Received: from dmitrii-TM1701.. ([87.200.40.246])
        by smtp.gmail.com with ESMTPSA id dh5-20020a0564021d2500b0056e3e0394absm3234933edb.68.2024.04.13.21.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 21:51:44 -0700 (PDT)
From: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@google.com,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	khazhy@chromium.org,
	vmalik@redhat.com,
	ndesaulniers@google.com,
	ncopa@alpinelinux.org,
	dxu@dxuuu.xyz,
	Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Subject: [PATCH] bpf: btf: include linux/types.h for u32
Date: Sun, 14 Apr 2024 07:51:24 +0300
Message-Id: <20240414045124.3098560-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inclusion of the header linux/btf_ids.h relies on indirect inclusion of
the header linux/types.h. Including it directly on the top level helps
to avoid potential problems if linux/types.h hasn't been included
before.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---
 include/linux/btf_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index e24aabfe8ecc..c0e3e1426a82 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_BTF_IDS_H
 #define _LINUX_BTF_IDS_H
 
+#include <linux/types.h> /* for u32 */
+
 struct btf_id_set {
 	u32 cnt;
 	u32 ids[];
-- 
2.34.1


