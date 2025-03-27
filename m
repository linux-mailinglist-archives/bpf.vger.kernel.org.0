Return-Path: <bpf+bounces-54801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1DBA72D69
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 11:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBE73B1427
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A306A20E703;
	Thu, 27 Mar 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJSCEIfE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35320DD6D;
	Thu, 27 Mar 2025 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070114; cv=none; b=m7lamWdrtX92skpJV0/lRUA0nl6ECuLvjffN685dJbSfBSqGLpTLaLKvAAqorBszi64G1WsVZJ5HrmEbLHZxqcNuVFWquSjXpR9GvCgXKUdIMH+mzY1fhSgZNpDYJkFnU+bHVZDSsUa/sf0h5PKfoHW1a8yb3BOS3ey+Q4TZ5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070114; c=relaxed/simple;
	bh=kGOiF7Kdzqr09ZSlwoEaSoMgDnnbDbf/Sl9R/vGqW1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KovtC6ugOBl8v72PT1V1oUiz9ZIL+TCT/FQUR8jBxtBdfj9qOO15a+/Mt5VOind7sd1JoAgIR8I8UooxQGum1uQDZUONOtVgZd0l5UOXond586YYxAXo9iPd3Jf7ym+HMt+CP2GeGKZ7CFI5Jj5LnDvRluKxB3ZBEpv6wxh+rQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJSCEIfE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912c09be7dso405516f8f.1;
        Thu, 27 Mar 2025 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743070111; x=1743674911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nM1sZ0NoIXmTU8K4jfk38nEGpUUVD3E4cfdS1FIxod0=;
        b=JJSCEIfEcXG4IC9ZhbBy/CBfkidQQQD0t1GgnNXQRgnnAtk1KsKgrL0i1ATJeNlHOM
         k5zj9Bs6qk0h98PSAY9zttGNR6Crs5sX8DekT0TfiHM5+sy6iaixjwgUz96Dnqd77M38
         +bwn05X83bnKQrIQX2JKt7rIY11hLdHKoYcGkPxbXIALhCXJv9xcZ194vUq312UE74CV
         djUVCf0bXsM3npD+ZePJjEmxAW0xLTViROz3FeFsplMhR7qDaKnVbSzBIVFEqSxOeoXw
         ODykgmkqkqX3qA8Sf8iyig3a4/PNBAEx8Km1CUjNxOmheDWCn9rTTJZezd2d8bddcl0Q
         tDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743070111; x=1743674911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nM1sZ0NoIXmTU8K4jfk38nEGpUUVD3E4cfdS1FIxod0=;
        b=EwRc8fgsesz3SYzV+nADhULA2nuqba3OEB9tkRoDrSJ/JUtiA2o2CtmOxiQU1Uy3QN
         cfnqBHHluCVjs+OfTRni1/uBLzYg5oI3EPyGB7p+s4oUgWKeiNSBXqx22qPGzxIxpj2V
         RlDH6q3KqdnYTV7+6EdY6/vj8wVzrCBhbYdbgxQuSQCQxgaPjW3Uhu5KzemyCJgvg5Dc
         D3wmA8tcfaosLHtNWvWG5bxRMvEZuaQffdVG4N/Pq9PiM2fQmu2mwFDGODANWGL756cb
         dsj+dg/Ok+nC7DOY7EVGT+m086Nx9w0Ec480XC6+b+2RivXQArn3TXOOxHLo9jdH4vDb
         OXQw==
X-Forwarded-Encrypted: i=1; AJvYcCVtWitYNV2e2QY9yAG38spoJjqfi552WTRw9lIAb0XpGKr8mYPXfdRQqG3XNKsGalxO0ww=@vger.kernel.org, AJvYcCWa3ygB/fydFlLpuWw2LWJsFTazfsrEl879lRghQDu2TQ/ccOHKjh2PF6Ad7GgcU/s+dLumjOORfOCRjcBD@vger.kernel.org
X-Gm-Message-State: AOJu0YzMU4wZV1JsfwKpCoovg3lzcJnPtzqWridMOsTbP+InAfLvEMs6
	V1zHuGXDckrJ+zgw+nIeD1TgfyWpldynEQznJ25addy4LnFz9376jgA/1KvziOU=
X-Gm-Gg: ASbGnctsxEQB7WBZvMxiFFTcDO5M+LA0lh9lrfPmqXVQAnqtCDqIjr89BfTCMIeuBmQ
	bUHTxeeykq/FxrByasIGqr9qW9gqrOpXWbchWikSeaixWn7z2ZZ8t/2DcrvRq91xK2i/IgB0vpE
	1GM4R2gaw45viD46P4dNuOvg2cgS0MkqXIdAApjKW1fgyhTd/okSzUHx86JYYKTM01EC8QgK4bR
	vUxn5EEoCExa/3+/iLfR7VCrmECLCiik6YvZou6dtI2bhDJYNEdkkHfPqEcA3xpeyhGWRhqFiSp
	4Hiase/Tpn1tRXbn4ewP9qVoBPbXRTOFDxgrpi23yOXwq4x2Ot/O6q8ZUb3UpuIZvZkvENTv294
	=
X-Google-Smtp-Source: AGHT+IFwkIcNiFv7KGqFfNNkvJNpxPHOHo5FlCVKImXKzz1I4N/bdJ/AV1z2pTR1Q2AMb4Vnm+ORCg==
X-Received: by 2002:a05:6000:2a2:b0:390:d6b0:b89 with SMTP id ffacd0b85a97d-39ad1783fa5mr2336879f8f.50.1743070110646;
        Thu, 27 Mar 2025 03:08:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:f41:90e5:5f20:8d7c:3c00:5765:53ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm19000288f8f.29.2025.03.27.03.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:08:30 -0700 (PDT)
From: Mateusz Bieganski <bieganski.gm@gmail.com>
To: 
Cc: bieganski.gm@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] libbpf: fix multi-uprobe attach not working with dynamic symbols
Date: Thu, 27 Mar 2025 11:07:33 +0100
Message-Id: <20250327100733.27881-1-bieganski.gm@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ENOENT is incorrectly propagated to caller, if requested symbol is
present in dynamic linker symbol table and not present in symbol table.

Signed-off-by: Mateusz Bieganski <bieganski.gm@gmail.com>
---
 tools/lib/bpf/elf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 823f83ad819c..41839ef5bc97 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -439,8 +439,10 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 		struct elf_sym *sym;
 
 		err = elf_sym_iter_new(&iter, elf_fd.elf, binary_path, sh_types[i], st_type);
-		if (err == -ENOENT)
+		if (err == -ENOENT) {
+			err = 0;
 			continue;
+		}
 		if (err)
 			goto out;
 
-- 
2.39.5


