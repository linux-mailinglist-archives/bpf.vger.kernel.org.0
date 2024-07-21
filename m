Return-Path: <bpf+bounces-35178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 962E69383C1
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 09:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C3A281621
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A679F6;
	Sun, 21 Jul 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH3PwCU+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB779CF
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721547032; cv=none; b=gaWuBH+dCbOCeT48v1hFh0/W7w+UrGR9VfvvqgnxFAzfVlJqF7WEbRCwx7GTC2exHOsA6BZFrFoXL56jypy1urHZp8YTCxECBdfC+gktlUXHLxtsMSnK+uSiDVvTv6O9a/2zIxCu/hVypgaBZodpaaUwhUnDil0uc0fm876f2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721547032; c=relaxed/simple;
	bh=RYtaPTSLqnNROY9snVsGPib1Sl7NdAjbH/l4ogCHEDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LEYRj/0h8Z/IHoi85s47AHwK4J+wIMlnKVkBJ9NHB5997Hx0gZD1wtu6Nc5Cph2bmkBaC4rdKxau1BGsIaHJilykkvPcHOadNF2x5Q5ee9v3gVLibOPs2YMiX3EHOMF7MuepcV23R3tY/Gc7ESbYMkhlAsq+c8DsoGGrciJhpAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH3PwCU+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-395e9f2ebc0so17454465ab.0
        for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 00:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721547030; x=1722151830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5LF14PC4KL/8FcoNXmuomsXqUCfMFH0Hzb4SQ4iqGI=;
        b=XH3PwCU+mM1kFLo+YFVAcHHJLcjrDZCNZO8SF+tLPW0C46BenBza45vu2d7GhfFu72
         N3i/aiPIHBVTU1Vh6j2sPhnlzU4PTqWwl2nd/0I/b63dH+IBqTlEk9SRXkDWTB24/5HX
         2fUfArpKi7ismK/qR7HIS2tFhDGuYNEsmLGbJN4yiGUARGA205WI8arJeFS0uerAzrw4
         JaZ1dVOA4saajkRAvgG9GvsEseKetMIKpWMbMoYEd8oVzy5XaD54oN5CtctKGrhEQEpk
         axRoO8zsx9IUmaWJG/Z8MAZZUKohUdifeaQBQkGTlcI8ZYhlXHfe6ipE5AwI9eJM9U8r
         727A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721547030; x=1722151830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5LF14PC4KL/8FcoNXmuomsXqUCfMFH0Hzb4SQ4iqGI=;
        b=hgyIPqboyMAtXLBfAlg0wSdi7UjpfTCzWK1lmDGXP2ocJ6/sFNOCkD8EAFl7V8XGN1
         dMWDVcZK3JbWyx+1ls7O6Z9sq9lkvKL2fzyme5D3grOgjLrTmM6j+q9pj5OgDPIWqbdC
         katcxtVMeQwDTcnHxIs6Vh7gDBr2bmBSXv7XaTKtS8fl2ZUJumywRhHhIBspR56L8dIE
         XuB2ooqdxfWei9o8SPoPlR52eB1ImXlln7dH00efdRoV1iLu1uy/liEopqz71b3KTSXd
         KyOjG+VhD9zIFzwyMYUAyoqWypEV4xDTGCLYATWqLJ41gu/qwzcaDFhwAObWmOb9XK4R
         H/zQ==
X-Gm-Message-State: AOJu0YxyIVY5NNKvYOmDBPgfPcpdHm5nTmA2mNQbEQ+1FExkVGuYnjhY
	9J0Eho07IiDgeEpSFN/7BwwR2VJWt3zahhlWVWfbaZZ68O9Dio9tIWo175un
X-Google-Smtp-Source: AGHT+IH/+Q3ash/JHtgMepuy1+zMZY1a3OvIA5ZhS5giHntXOEGnpIIUpCWzl/aRKR6hhNt5OUIXBQ==
X-Received: by 2002:a05:6e02:1c82:b0:379:40e0:b0b8 with SMTP id e9e14a558f8ab-39940430379mr37038225ab.20.1721547029734;
        Sun, 21 Jul 2024 00:30:29 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ab3csm32424875ad.1.2024.07.21.00.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 00:30:29 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v1] tools/runqslower: Fix LDFLAGS and add LDLIBS support
Date: Sun, 21 Jul 2024 00:29:51 -0700
Message-Id: <20240721072951.2234428-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Actually use previously defined LDFLAGS during build and add support for
LDLIBS to link extra standalone libraries e.g. 'argp' which is not provided
by musl libc.

Fixes: 585bf4640ebe ("tools: runqslower: Add EXTRA_CFLAGS and EXTRA_LDFLAGS support")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/bpf/runqslower/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index d8288936c912..c4f1f1735af6 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -15,6 +15,7 @@ INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../include/uapi)
 CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
 CFLAGS += $(EXTRA_CFLAGS)
 LDFLAGS += $(EXTRA_LDFLAGS)
+LDLIBS += -lelf -lz
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
@@ -51,7 +52,7 @@ clean:
 libbpf_hdrs: $(BPFOBJ)
 
 $(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
 
 $(OUTPUT)/runqslower.o: runqslower.h $(OUTPUT)/runqslower.skel.h	      \
 			$(OUTPUT)/runqslower.bpf.o | libbpf_hdrs
-- 
2.34.1


