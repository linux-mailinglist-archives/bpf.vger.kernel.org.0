Return-Path: <bpf+bounces-46772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11AD9F00D2
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA5916A74B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5017D2;
	Fri, 13 Dec 2024 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR2HbLYV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B88DDBE
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049972; cv=none; b=mXJcnYnid9jJSGHkZKbC2t8KTRu3ExLvS3//PEh4+JMfoqP0nrTbwxMzZ3wH22TMTKntq80a/uHnFoH2phsMbmVZwFyZ3lxRf9ogzka75GmEzGI90sLZHMzLfd0x7ilIYp5ZyJdBzbNNgUr24ZzsJ1/TzVtW6WHduQho5PUEkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049972; c=relaxed/simple;
	bh=rUeT54e2y7JuZi4XvefWUnxBNFwd0BvkDEp4drRoVHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFP9/8b8iBtvoCkqPmEgB+p5nseb1glatrBtRKVRBwHYO+UAdYkq4sMHTxc9oHaKCL8h474kbxi2rDCM+kOXSV9565IZ93X5RD1tuCChwUNyH2dbNJ+VdNbYR1QgU2L7IfZNJT2dZ9iBCWTecbzVDcNm4AZOS89Bov1gcZCa1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR2HbLYV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso10975325ad.3
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 16:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734049970; x=1734654770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CANy1t28FhFY0VoMXykBEq6yj4clQ7BB5SeQkAkJcc8=;
        b=aR2HbLYVtNiHXHoPMFoDhNSmyqvuNa5aDr3Nw01QgcbUyy9/oFGGL7+zKuQQHK/lKZ
         JGVC7h+Y2UpyJWcYLa3BH9MxrelE4gBIBS9SCixg2peP5uZ6hMOI5OWoeSW7Kg5FPirD
         nj+F5Nvx1E4JZT6mgWyjk41kbP4Wzc19OezVEjXy0KUw8GCcjOhYMCywNAhYh+DD1ZAP
         oBd7y4NQx5SRNe/nNJFxUOozvrFUqairoRqD7yAzvy3F8ZkkAGzyuZbZ8yS/8MfzY63I
         iKhi5NPnMHsGESe36flaA8RKd3P/eX9n1+pmLG6jEFTBU6RrvQ4VZDzs7XcYaLiNwFj1
         y4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049970; x=1734654770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CANy1t28FhFY0VoMXykBEq6yj4clQ7BB5SeQkAkJcc8=;
        b=VqtFnR1Eopxc53AsEeJsbSobG/tKthlYYm/eFHrE5dABxPZB8u42pmGsxAx0TIq+Zu
         picCNT0YOKqfufnbkfabKoYi2ggQv3/gGBZg+l9rOG2sBA0Qymg7pjsE1Z8jrok3xhGZ
         cspXnb96K9HjTYguTkr57muyGio5td2mGDitsXGdQN2SLfQ6kTb3G8kFuboy4WUpdOEb
         m0ctsRXNGK7ZxMW6zjPZc6vTsv8ID2JL6VK/gdAgKgEQ8bOGv6s4EOJfAz7fqQ7RiS9Q
         1CZ9FheAhKKrI0VEak+5kV64elP8IfTc1HyGWSyu0/3ZVJ910TcpdJ1P3uDlAfv0Pbh6
         QL1Q==
X-Gm-Message-State: AOJu0YxOImv6zMdapFJ6oDC4M3dfkUuSeGOpnzjaDoNLIODqLND0KQMr
	NUcGIYH714xug7M9OuUHy3vSR2YnNy0B+6xO8S56qt9zd5ZQZJQlSzwWRg==
X-Gm-Gg: ASbGncsz3NS/1wBPcPg1y4kn0eeq3vlqaT5N6HslGyRWacxs2YgOZPlm38FjyWlDEVE
	RVGBQWLRy22J8v+dIO88tzK1jjTkkZffzJSh0QVtGPOqTiezNqjU3Ni4tcTM3LA4jq+I6iR8Vwb
	SJd7sL720LhZmug7HGF95fpc3lK+Zq8dxkxhBE1MAtJVblsPurnZeT1EMzMbbTMSAFQCf+dFqG7
	qvpCUj9MtrdIRBtQq4I3Rlyj/UutP6j62TZj27eDQhRvLQKKxWt
X-Google-Smtp-Source: AGHT+IHJKtPZYUlO55NjiBcXJrzxzBXWPwcShkKsehOfZbuPCLZ2m+ZJvv+5NRyanwF6F1rUCqFcPg==
X-Received: by 2002:a17:902:eccc:b0:215:a2e2:53fe with SMTP id d9443c01a7336-21892a59712mr11358685ad.40.1734049969869;
        Thu, 12 Dec 2024 16:32:49 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164ec76eb8sm74931945ad.179.2024.12.12.16.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:32:49 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf] selftests/bpf: make BPF_TARGET_ENDIAN non-recursive to speed up *.bpf.o build
Date: Thu, 12 Dec 2024 16:32:24 -0800
Message-ID: <20241213003224.837030-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_TARGET_ENDIAN is used in CLANG_BPF_BUILD_RULE and co macros.
It is defined as a recursively expanded variable, meaning that it is
recomputed each time the value is needed. Thus, it is recomputed for
each *.bpf.o file compilation. The variable is computed by running a C
compiler in a shell. This significantly hinders parallel build
performance for *.bpf.o files.

This commit changes BPF_TARGET_ENDIAN to be a simply expanded
variable.

    # Build performance stats before this commit
    $ git clean -xfd; time make -j12
    real	1m0.000s
    ...

    # Build performance stats after this commit
    $ git clean -xfd; time make -j12
    real	0m43.605s
    ...

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index bb8cf8f5bf11..9e870e519c30 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -461,10 +461,10 @@ $(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PTR|LONG)
 endef
 
 # Determine target endianness.
-IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
+IS_LITTLE_ENDIAN := $(shell $(CC) -dM -E - </dev/null | \
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
-MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
-BPF_TARGET_ENDIAN=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
+MENDIAN:=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+BPF_TARGET_ENDIAN:=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
 
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
-- 
2.47.0


