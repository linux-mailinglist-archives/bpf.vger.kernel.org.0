Return-Path: <bpf+bounces-37937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A14195CAAE
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 12:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC74285D78
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64424186E50;
	Fri, 23 Aug 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agZJlZ43"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351F3717F;
	Fri, 23 Aug 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409801; cv=none; b=RRwcdt1OJ8t2cjuDvCITRtkkGVdhBgkxve9pb6S8YEOPEcj7owqhMev1zKgyTvfsrp2EcBPzYO81RWzB50Y57BScJOhfXQ1iHIZaXi619J+90a3ke4qdf2eBYVumlP0FavscSh3kblAClzXcii7TZg3oPA1y3KqRthrwWBcNrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409801; c=relaxed/simple;
	bh=Cg5Z/NuEKYZNowKFFYwqFbeerE78DxVJZRYURUgKWFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=stwSCLwEMRRivwKJrRopn0TwNTvqameJ0vEU5NMUzUIfXVVyqGYuLlyTS9Wiyr9LAbp93naFWOEcjSqFcSWc+wLs1ridQdtO6tD1lZX/fxvI924hSkK6JmpGIAnZwSjSCj16bqCAfot+I/LVeq2Z3eDdUpemGlMx4zn0Y8OaixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agZJlZ43; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5dcad91e64bso1684856eaf.2;
        Fri, 23 Aug 2024 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724409798; x=1725014598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+YXSKYFe3TblLjZvhs0wWwc/DjFP9Pil6ZOOva/SGA=;
        b=agZJlZ43mxAOgl4POf19RlULMvRDw52xpi0prxq+HIKFBz5aKm11M4cpKtjg2PSsS8
         o+ULG8iCU/+KjYLhTh0H7kP6RpoNBQDyl/bRz8yGlBFQ5NhOqc/qMndxBSySubnA2Ude
         IW61UGiJ1gT0vBv80mF4jCFKwJfVXr3AoGt536VAvsZNjjcVWOQ13fU1mjMj03er7Zi4
         fBoonN5VABCdpvKoY44VAPjPTYFArKDmRQVBBrXRLnoyCQOnDsLfyLVZrhkW4xgiz6MK
         7fQWvnaKK6IR5e5M3f3NOgHmVpmc3GqwlRkMTRxNrlpqklPZ8SY2rOVThrDoAkx9YWzq
         9dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724409798; x=1725014598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+YXSKYFe3TblLjZvhs0wWwc/DjFP9Pil6ZOOva/SGA=;
        b=SoX29xJazXIQ79cnz8KjLCxiLWebW7iK60D8abav7JMbJuWn+4zUiovaQ4OvUDEegM
         N0M7RZJgchfxITNNh8Cto0JQU7Ch2lp9sFsWIagQUjN3w3HBaDnTMBYW/YwcljHcIP4C
         1KqModobIUG1SddOUwPHSoSSm7I8Al+6gbTqr2mg0Hd/DHGx06PFd3vY7cd3BvPOmWGg
         ES1ermuXGBXWNxqLbXtr1QUg2oQHqP1ryGQz+64fQnRY94DcXoKKR4eXSLasIzKm97L6
         jOkwGaDjwdtsgjUNAx6qnyyJjHPb/T46xB9EhiFPBZSeIayP5q2ZCWNSRupVStHVj2Bc
         sbLw==
X-Forwarded-Encrypted: i=1; AJvYcCUsgoe1kKv05O1zPaSx9bqMTZpjVTViGNDmP5kbbtlp+axFFFPuXxzvvT727iW/eec2zk8=@vger.kernel.org, AJvYcCW1h4YMzrotldJyJ0w2Llk6nCyQ9nras7AKQQXUQY+C1e857fGRMJWMY8mldnVsG+4k/NPSQCGarqeX72rZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxjryLR6o2kB9CZalWbEx/lU0Z2AQ5Z92IbASZHyXnypU9mX/9y
	yFGi/I9RMhcoDEcfF3/zs6rRRzDflWqq2/x7WUOKFCsBmIP7iV+dI5Eyc7W7zEc=
X-Google-Smtp-Source: AGHT+IE7jl0pcwu6M7lLNiZqOv+5Fjgz1KpHjCRBSTNUcF3AE9Xf1HcBOuk9kA/FDyetSqjaKVCiaA==
X-Received: by 2002:a05:6358:b390:b0:1aa:b887:2386 with SMTP id e5c5f4694b2df-1b5c2140c0amr160559355d.10.1724409798471;
        Fri, 23 Aug 2024 03:43:18 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0a6csm2752263b3a.128.2024.08.23.03.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:43:18 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH bpf] bpf: add check for invalid name in btf_name_valid_section()
Date: Fri, 23 Aug 2024 19:43:10 +0900
Message-Id: <20240823104310.4076479-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the length of the name string is 1 and the value of name[0] is NULL 
byte, an OOB vulnerability occurs in btf_name_valid_section() and the 
return value is true, so the invalid name passes the check. 

To solve this, you need to check if the first position is NULL byte.

Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASEC names")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..5c24ea1a65a4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -823,6 +823,9 @@ static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
+	if (!*src)
+		return false;
+
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
--

