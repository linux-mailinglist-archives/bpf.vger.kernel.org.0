Return-Path: <bpf+bounces-72004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 734FDC04F9B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26F9D3455D9
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10B3019C8;
	Fri, 24 Oct 2025 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdNmI4qA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97408301498
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293301; cv=none; b=J9IWrxg+z6IFzzNPwcxv05dKJJtw3DfqscOam7wNDuV4/9g2KNmrT788t/krVxFt47TQFRuOMp16MrXO96lGng6osGSL9qih7GkgjdaD/R7YozRiJGr+sTbRi14hLFl11xPVdhIgUYexzOuBgf6VZ4UBIZvTCBeR2O6r2dpPL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293301; c=relaxed/simple;
	bh=7nsIjxJWbWE/evrRetoYMmRlti7SQG1A+Mfv2lnGeKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UPZ2yAra+nDh1olQMqRMmgSDty2yuW5G3bhTDHL2lb03awhJTgrf3jKUatykfBTYicRNbYkzLZjuQoeTkKKTSelgMY1AnFnkZryTof1Ncve0VEOMczW6rU6F2jbPTyJXdIHv+LnoMi6XE/syc+s5m9fHZz9pDP5q4MwKv84s2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdNmI4qA; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77f67ba775aso2204995b3a.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761293299; x=1761898099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVhF+LS/VFIVfRVK60hqpDN69wUmvTRnXE3X6JFK5lg=;
        b=mdNmI4qAsw+nHRMgzOO5YQvprlxV7GXHT0VIbsCcZD2eiGx8NGoRMC4pPdqLOYIGuJ
         XXQpZyxJ0Wjuo8LWgihjjt+wktRdVKiKCWcE92OuJNmpkryudbA7YY9RiikUNySiYten
         VYRyzjzn/G4w5xF67ok4lW3e2b9KZY7ajnKOtb9fVf58mckC0n+G1bsV63SYjsMN2eWR
         z7NSHcLfHq9OrK27D7niirZCRzfmFTsz/Fy642XgRgmUCCXCjt0SdDaeHHZAVIkRyduB
         NwG/W1hdJqqo6OqmjsObkctyxB1hSGfKTSJ5E+kfqOc7w+38ZEFQszvC/nAaGwpBjwev
         Ba4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293299; x=1761898099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVhF+LS/VFIVfRVK60hqpDN69wUmvTRnXE3X6JFK5lg=;
        b=iE2UcJg0cqyv6DlDiN5Ma/iElevSZ3920Om797yVkAHWWCd1/vanytIrIrCESxEGeA
         Ouen2qbqTr3RgSEyTuKd0k3KMYG0BDd4VX+XMxu8c6WeMEZE7wwMe1eRf/xGfSD0BFGt
         H46dsMQnIjRvlZkDXx6/sZ0bxqKq5meH7Um1Sn9av6GHGYc5Cg4KdiGGpLP0aTBmnpKi
         yp8gTLjNmnDK6bySkXFh19iPqhH4623X2ILs88ev+6O1yzUnCEL0763t3SWYgCSfOGB2
         eMiNo9r/klf390rUFz5Dum11dOHFZMWghA1UmHdkSFZTVRHwisqHGRJjgSRBROHsMnWK
         BN0A==
X-Forwarded-Encrypted: i=1; AJvYcCUlcbRvbQuTIxt1XFKEfj/0weOH+jIAaPFHVCMJMEEmkzOQ6z4U9JIUrbQ72L8zzkn70W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFGEp5C1oKbChLcZaC/qzXYYGzYQUew5fHFS7edH9DFgTKzGkU
	xhRpFIM0kohoN3mz6ncLaXpbMlHL6cSBrJKeUONe8wk1d16p0Wy32Cvu
X-Gm-Gg: ASbGnct0nH7WH9TTzYcf+7JJ5sVo7LbQQjwLN8QAtMPATQYvXMpqnC1k6QzkwS3RY1X
	aAg6SQbfx8eqKwGeAu3CE1yiwUwm/iSQtGxkQ/yHbgS0hA14cN/WlSmtfieItCo3iuheepz+TA/
	orrOhXsh+Z8PkPs0kgv6ZzF0Y45zdJbJARxQWFM7y4F1xdsp+oBg1iktVfulPYICiz9yOPNUcr9
	uxc1Y5vUr6f3a4NnazzAj+xCCSBsqj1Ywrg2z7N5/GKxdykRjH2mA9SBHhYTKwQpWuKD3q4KvYM
	QF1a3E0TGbYuBD4HTXd3inQ14NMqL8/6V+6F32Ofzg1EdglVfRrv+l2/eTl7lwILpqNp2SEaUtf
	6lSEJy1+PQCGWhPRVE5WN48e1vFTO1xy+GbnZ4GAz52q5KacJo7oqCkSFlACT1kp4yrAOqV/VgO
	AweSHZ5Bkdl3wp+/n1UbqGqrPKPIw7
X-Google-Smtp-Source: AGHT+IFqbf59z458q6CV//wwrkG2YQyZ6Muu0CoQS/MrqfCezuYg7MN1x7yE1WmediLzYVtk9nXIwQ==
X-Received: by 2002:a05:6a20:3c8d:b0:2fa:26fb:4a7b with SMTP id adf61e73a8af0-334a8650347mr36367003637.57.1761293298709;
        Fri, 24 Oct 2025 01:08:18 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc33easm5011581b3a.68.2025.10.24.01.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:08:18 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
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
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH v2] libbpf: optimize the redundant code in the bpf_object__init_user_btf_maps() function.
Date: Fri, 24 Oct 2025 16:08:02 +0800
Message-Id: <20251024080802.642189-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the elf_sec_data() function, the input parameter 'scn' will be
evaluated. If it is NULL, then it will directly return NULL. Therefore,
the return value of the elf_sec_data() function already takes into
account the case where the input parameter scn is NULL. Therefore,
subsequently, the code only needs to check whether the return value of
the elf_sec_data() function is NULL.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v1->v2:
Fix the compilation issue caused by rename operation in version v1.
The v1 version is here:

https://lore.kernel.org/lkml/20251024060720.634826-1-jianyungao89@gmail.com/

 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b90574f39d1c..fbe74686c97d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2996,7 +2996,7 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 
 	scn = elf_sec_by_idx(obj, obj->efile.btf_maps_shndx);
 	data = elf_sec_data(obj, scn);
-	if (!scn || !data) {
+	if (!data) {
 		pr_warn("elf: failed to get %s map definitions for %s\n",
 			MAPS_ELF_SEC, obj->path);
 		return -EINVAL;
-- 
2.34.1


