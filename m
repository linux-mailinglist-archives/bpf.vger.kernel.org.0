Return-Path: <bpf+bounces-35299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B093939777
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2522A1F226BA
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFF74C619;
	Tue, 23 Jul 2024 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt+cQBb6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A549656
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694682; cv=none; b=ko4kqQijfQtXDOfToo6XIcP/zeInyR43j2TpnTnslcATTjKmiW1HikkNDnHGe/U/Z2/44ml2xZvViVJ/N4u4EHnTtuvjrJEpGVqmmfSjr6B1JFtQrmuuKQ0Gs+kKN9izGEF48ddgvryaiAHddvC4VRdEUn+ll6VdupJidSbEmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694682; c=relaxed/simple;
	bh=X97mdQlQuKoGPHZHhSlYoGKKN7admO6PN8RjmikOBLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FPPCcsJlJa3R8EIoFOH6qaCIGj5hKojDn4og4arDT9BnK6LLahcLPckRH25QcSMSg2SI/82rurS61gH8O5teBgaYboJBxO1fllME/il0wgt1+ORanHdreSQoONuKyC3VnzdwWQTGTLgzXrD65ZKxPgVztC5Z/m+4SL+beHnhqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt+cQBb6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc692abba4so1800035ad.2
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721694680; x=1722299480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgyi9QdEXhnTGNpHh5CUSdI1QUH1SMAI0qDmVTtMWik=;
        b=Xt+cQBb6ca2ptvVeaJsM7g/S6OKnXwkHK6TZY/8Njb+syTC7pRUfSnf9dfzu8uFPuu
         UAVzKZGFPilPsNNm8TpBgbt1K3pBjyQ0G5eGOwo0iO4r+17Afws/dxIWJmEVuHz7WzlP
         AXXFiMUCl/XeLVbA4Bvak0onBlyXXWYQUudPKLx2ElId5zcA+8gfKbqQO+L9hfrjN8G4
         YbdV6BN4/SMZDtNplbxrf3zstImYG6h1oaNDnSV5Jc+Y51WBlGV6rx0k9ST13O5szHQO
         lg1R+3zyRiSgEUQUNVd1WZDe4bRBO5Da/IjfleYyT0Ul/4AY2UdhI38mrGMClGy4+u7u
         6MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721694680; x=1722299480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bgyi9QdEXhnTGNpHh5CUSdI1QUH1SMAI0qDmVTtMWik=;
        b=DBARjTcc/QvtxbI/GVM+2c+FTBdntnPmOOL9zagESSSrz/vvh6XhYABhYOTGejFTqd
         AEQFP/QRO86Wa6IcIFL8PwsbFNJskz5KyrWW+RaE1Ko5fL/3hZWtygz0OfV5grMQznca
         0rs0WeyNSLVylgrY5KwQ8/NgQzx3uOgKvzf94NVzBgU1kBGecVe54xZWQJZNf6DvMV17
         mRe0jRcJFj6X+8oa5kPW8mmPzMVwB9leA4EzT7A04qWuY6hc/sgPTnF9wjzI6uHWrjKf
         2lj26stCaf+ObpJvazVqeD8hueiKhPIY+sqCWRnJ/EoqJkZkiTuMZKcF0e9Nv4G6KS6H
         UMAg==
X-Gm-Message-State: AOJu0YwE+329IBwTdQO+yHBh6vut37MBf0mF9p2dg0+Lzk/vbe6jui41
	r+DkAAW4uHONdfZxNOmOT4hLyebZE144v3M+dmlCozCExNXrZHHAsVhfrh36
X-Google-Smtp-Source: AGHT+IGw4Tam6mLJlM58FwgyITsJ4QiLVTyRqgg47TaDdZAJy7bXWJvcsrCYfphz11mOaZvDBxYbiw==
X-Received: by 2002:a17:903:280d:b0:1fb:9b9f:cb38 with SMTP id d9443c01a7336-1fd745f5fa7mr48356945ad.46.1721694680033;
        Mon, 22 Jul 2024 17:31:20 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f487857sm61202465ad.281.2024.07.22.17.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 17:31:19 -0700 (PDT)
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
	Jiri Olsa <jolsa@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2] tools/runqslower: Fix LDFLAGS and add LDLIBS support
Date: Mon, 22 Jul 2024 17:30:45 -0700
Message-Id: <20240723003045.2273499-1-tony.ambardar@gmail.com>
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
v1-v2:
 - add missing CC for Ilya

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


