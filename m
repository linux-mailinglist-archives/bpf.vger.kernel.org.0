Return-Path: <bpf+bounces-41142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807F49933C8
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 18:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B165C1C21966
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0511DC06F;
	Mon,  7 Oct 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp1twiEx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CC21D4345;
	Mon,  7 Oct 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319617; cv=none; b=eyITlV3drUiEQHehCgIGsLYfqnsrNc6anTtTpRezGfEZjnF1ZIcaOw8RgGzwolbIW7npk0Qc7K9DMABhtgTWkll9lHR5Cy5x9dXOfS6rkS0gveapPQ09iuA0PUjTH8f+ywtK7AEQUpVxdoEb+BZB4NH3UJb93I6ZdO06MOA0Bdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319617; c=relaxed/simple;
	bh=v6/USJgPTXQ3pYhiGAZg9RF+9zeybeo9ggj+sDXuiUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkNCUwmQ/9OaGw3fUT1Xd3QtKNV9MiZDp+hgizDtC2TP2sz0pjAZ9/gU1u1EYXLZ5qcuiklCCF4rlilJMyhjhmYRlS7wVvdAmD8i7TkAoJ1gx8Mgt1B7X56AgM56Wbf3oOTbXyV+J6rS7iBTswJG+pLTpojlP4oyQXZRh4ghrYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp1twiEx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71df67c6881so1843841b3a.3;
        Mon, 07 Oct 2024 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728319615; x=1728924415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x474kzK8YR4kJtZQLEiCdd924M+GSa8g7xKps8ToXwY=;
        b=Qp1twiEx2mvpqyj9lk5UFgcsCJ8CDXsuKJ8gNC8V75OgUkYD1oOiixgx0IBY1GrGDt
         0MekL+aCz2S1BoIlUhXOeWGUfB7BS1e+L1HvsIoR8RBoyn7GOhJDZ90BsIO8BPsgtI3g
         kpGNUO6uU1h+11s83UpIFwNF8n3IE9A8cBtkRWoJ3EJlNzl8bA7gnylif4endZqC41mc
         R8tEHy7suJL3Pdcaqye09l16m7bdE7VQoRKHElopn1tkGEKuYMBd8wErBOeZx9sYP/Hc
         /I5D2N/ibupmiHNz0M1UP+ieiqXg17YdkmzBtSBeNLOs3wdxqmbxW2vvg7FLl/8JP10x
         7ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319615; x=1728924415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x474kzK8YR4kJtZQLEiCdd924M+GSa8g7xKps8ToXwY=;
        b=IfGT6azGKW8vmZvjgemfKpbUjJ0ImUExxBw93eifB24jgP1E/oUR2AFNVudJwEo+70
         I4XllxEd4rRtQHZk7BLOznxDD7r3aBo0ZyU/pHz+1NHJw/qEPwfWB/xldcLiQvDVm+pX
         nd5j+apmW209kZFQUQWXi9OCR7T4RamsqrElY6NCeuxqzuFi0EhWBTpyfDMDe+8JeT7j
         12cpN0X0GT6oLzf43ZXsbeL87jfgMUg66M7dxrj9ET4ThDghXrsfp08bJvoemcn1qRjI
         fuxGC1clp7Zvh9u1Dsfl4zNfoxoNFNqLjLZjb44loWq2wUGunqls2CkCfZaM4VQxJIpB
         uvBg==
X-Forwarded-Encrypted: i=1; AJvYcCUDXCfHhAv5jnYTJJHCp2wlNe6ZMcnmv6CnHfvm4vlOW9KnjqrEP1hsVAkX3gXHWuZwA/Ujjjj11J922GZF@vger.kernel.org, AJvYcCVsIwP4LqooKw1/4mCUgBPUYnkI9AEudlMUT63a1axt3vN85ZuPSuJUVNPCunxWkFBGKjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywun5z140iFC+yFZL8ZEzISkLM3UhuyALrk/vn1/hsUzpJ4eE5T
	vKfOHxQJOZZbt0eItg0WryhygU0oWxsJx3TZp55BXIcK9Qs5Ab2o
X-Google-Smtp-Source: AGHT+IF9R8rki+DMzj2a1TSHbHN7YFw7JEdxr94Rd7L6dc0LOsAEap8bxlgWCWM2KSWPbZwFDWHbiA==
X-Received: by 2002:a05:6a00:854:b0:71e:695:41ee with SMTP id d2e1a72fcca58-71e06954699mr4611858b3a.5.1728319614971;
        Mon, 07 Oct 2024 09:46:54 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:d13b:ab1f:73a7:7b60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4633csm4583732b3a.126.2024.10.07.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:46:54 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] libbpf: Fix integer overflow issue
Date: Tue,  8 Oct 2024 00:46:48 +0800
Message-ID: <20241007164648.20926-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix integer overflow issue discovered by coverity scan, where
"bpf_program_fd()" might return a value less than zero. Assignment of
"prog_fd" to "kern_data" will result in integer overflow in that case.

Do a pre-check after the program fd is returned, if it's negative we
should ignore this program and move on, or maybe add some error handling
mechanism here.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a3be6f8fac09..95fb5e48e79e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8458,6 +8458,9 @@ static void bpf_map_prepare_vdata(const struct bpf_map *map)
 			continue;
 
 		prog_fd = bpf_program__fd(prog);
+		if (prog_fd < 0)
+			continue;
+
 		kern_data = st_ops->kern_vdata + st_ops->kern_func_off[i];
 		*(unsigned long *)kern_data = prog_fd;
 	}
-- 
2.43.0


