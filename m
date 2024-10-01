Return-Path: <bpf+bounces-40629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574A398B1C0
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 03:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2A4B22018
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 01:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397B6BA3F;
	Tue,  1 Oct 2024 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmokTlTV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352D63C
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745949; cv=none; b=jig6qC/5tdeKjfqgFcRhmTA4qLPeT81MdaXOlOE659N2elA3CmsWeqL5luUaxiXTjBqkaDsk7VWiv9Y4vx2ppPsIo/ztRRuW5YOHXPX9oA97C8I8cADXONGcnPVRaOrvL0kBrL3RhSqGddPwCVyQf/enUgeB0xg6JeOjLpoYBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745949; c=relaxed/simple;
	bh=4m1xMdlh6FTCx0U5kweh2TLkIq7+tY9r1nz4VtneIBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jX416J+Gjoluimv+T12REWd6suFVN3DVP8G9Y2ML1hggxIuVK8wYtW1VVz33SjSpSIu2rrN7YgrClsAh1edq8lFLga1VGSYOGWLS5tmcCiex1JBmGlJgJ2GiNfCxhEymPEhl/Q6m1CR6jVSV0qTX6u5PBIdg5FR1Ul4yV7IRyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmokTlTV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b0b2528d8so55017215ad.2
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 18:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727745948; x=1728350748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfF0elsF/csrWoG8dlynOlH/9U01Eg11a9gCLTfdKok=;
        b=TmokTlTVM7zK9GGuD7be+gpTih1V8qGkE0Hb86wtCkD3rmJ0T9Gudye1fZUQNJGS9y
         pJ/4Rqy5VB0gYd7uZMKB1QN+zKoHd/iqIYQnTXK7plrz9cfv0S+pe5MhKGUbfcD/Garw
         CWJtwCE+L/JumccsHaPzjkEy79v47oD3xBeSQ2vSj5oYPb78NWuSv+nWjFCBCTC66Jzw
         Nk8W82zKk3kPiAEb4n6dc1u01jeiVIUIPouOkfyy6JHsy7fIKbFMXKJWiguIjQR5yfAX
         7UjtwWp49ReLPXNAa3iCDdUw9HS1nNU1dVJNgiIxC4GTj4OlAZEkkxIGx6OcrpKNoBvP
         QwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727745948; x=1728350748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfF0elsF/csrWoG8dlynOlH/9U01Eg11a9gCLTfdKok=;
        b=Z2Uaw9cutffFt6YADeP03kDHQhNky5mrnKtMXqmJfZwLV/PgcA4fCCVQVV28/L1TLF
         3NEb4MDqYALO0IXH3q9pgd2BFXyDg/4ah8eGD2tVt+tMGW5UrbJ9vPle6qSYrwcUHfey
         GmllVGqHztD5ckX0Sy6pBMplvAsJ4vKQVt40bTJoVo2Dk63rHnHGsD178kIWYEm0HjXw
         oXC9h28P/NgfukPOsRcs/1yKZpOMZbZeh2geuQsxaeTc6Uwol3+TG60+baOstjEYLpvy
         zsq0yfByQDv8PhwyjO7j8uQkoHonNBMppjNdfNIlevXFNsPoVkm+4zTixIkwl0Oa8jcM
         hK0Q==
X-Gm-Message-State: AOJu0YyDnVDjOz9FeFUyNm4k53v/sHYhDByDcGwSmtqWFg6iwqlKyf4/
	zmeoWvIWKXl1nvR2WHiaA83Pa2mtRBEvbe2AJNqowSz4bgjaZkh6
X-Google-Smtp-Source: AGHT+IGah1Yo3YRhqMDtd+Vu/eWaylVm4i6c11LHYz22n9SSxfxM0BdEfPqD8jlsY44AKPHcLhU+Pw==
X-Received: by 2002:a17:902:c950:b0:207:3a53:fe67 with SMTP id d9443c01a7336-20b3776c17amr204746445ad.32.1727745947633;
        Mon, 30 Sep 2024 18:25:47 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.33.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d960bbsm60434735ad.84.2024.09.30.18.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 18:25:47 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v2] bpf: syscall_nrs: disable no previous prototype warnning
Date: Tue,  1 Oct 2024 09:25:40 +0800
Message-Id: <20241001012540.39007-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In some environments (gcc treated as error in W=1, which is default), if we
make -C samples/bpf/, it will be stopped because of
"no previous prototype" error like this:

  ../samples/bpf/syscall_nrs.c:7:6:
  error: no previous prototype for ‘syscall_defines’ [-Werror=missing-prototypes]
   void syscall_defines(void)
        ^~~~~~~~~~~~~~~

Actually, this file meets our expectatations because it will be converted to
a .h file. In this way, it's correct. Considering the warnning stopping us
compiling, we can remove the warnning directly.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/CAEf4BzaVdr_0kQo=+jPLN++PvcU6pwTjaPVEA880kgDN94TZYw@mail.gmail.com/
1. use #pragma GCC diagnostic ignored to disable warnning (Andrii Nakryiko)
---
 samples/bpf/syscall_nrs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
index 88f940052450..8f6ae21d358f 100644
--- a/samples/bpf/syscall_nrs.c
+++ b/samples/bpf/syscall_nrs.c
@@ -2,6 +2,11 @@
 #include <uapi/linux/unistd.h>
 #include <linux/kbuild.h>
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wmissing-prototypes"
+#endif
+
 #define SYSNR(_NR) DEFINE(SYS ## _NR, _NR)
 
 void syscall_defines(void)
-- 
2.37.3


