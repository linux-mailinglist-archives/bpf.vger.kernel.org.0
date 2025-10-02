Return-Path: <bpf+bounces-70239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB2ABB521C
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 22:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530E519E7C60
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F55269CE6;
	Thu,  2 Oct 2025 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcyN11f0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F6426D4CE
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437146; cv=none; b=cuDSNV0n/+RhdlUOzZ0eTYVnIIK5iZgLyOrug/m2l410tZaDN72WHxvxuFZsaxLqhfTlXfRWQY4CGjPmFsWagk6O0o8jqiD9gKoyNJtSWoc6zrFqtkM0BPjM7f0V5SjCzAz3hCkP4FmtExZyfoalxv0hXYWPqlNuisu1VUV48fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437146; c=relaxed/simple;
	bh=l5SDQF0bzNQKpuWED23qNIahAnKQwl10/hdwnOrh+Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Pp82WOw3FGd7ceB3rAtgwOHF1eQzfJJ65AMwhZni3UModQgDaEszN0g++VLlCB12Jk31aD203EilRSUgktmKtWwNvrfkOpjHiLT66ofiGaasgBcWR5DnIre4AvqIGwk2nqcNsrWiegviie+bsc8wx8MygqxtlBlP2agfvvg+HDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcyN11f0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b54a588ad96so1011533a12.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437143; x=1760041943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv+xTyL0FMN0YE/aLYG86t2IgkoAWaFt5tJYlGdaGFA=;
        b=JcyN11f0BZcUjWneyy102UCpaNiMBvrJyp6qspSweFd3e2ftrM/p9aq74tzAnZ5Bo+
         FdrH7BwyWvTChuC6zy3cOThwBTUf9R3rUg4pSrM4xd0awPVQKIsyX4GXaligFslqCxfB
         gCZAppLRMZrOgbRVfWqaQYmtX+IqIP9ykZi5bkPsEzrJCjczWgb5inDi3Fkzzf6o/MHk
         azohD7pqpVd1MFGQxGT5LLctKF/uvSyZ20L1GdcY6ojhMQZe2bdSyLD/6b0EE5ZmFZyS
         v3zia5oTOjekGJkycotMrGbSNXRk9KUj/8wgn3uxI1MEWxavkVzhU9ILTGtxiFKLEoua
         qvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437143; x=1760041943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv+xTyL0FMN0YE/aLYG86t2IgkoAWaFt5tJYlGdaGFA=;
        b=d9Om4lSjI+21nCW3XxkjW8/NJxQ20Pm6+F4ObY15arzN3knb93Hemu8Dxo8kSmfTPR
         Cmo9SiFx2WSvZsMvnHRc8CgZVe2ci5wqG7lw2yCl0vnrmohA0dpGGw7MIb/nI4rKRdyP
         7bnO2wghYLYcy9v+hYD6aPda77rib0OmKFg8HzBoJL+HJ3dT1p9kUCl3LG2mwWXLBgwL
         3AqEdtdWA6NAU24c203I8cgGsgbZPehuoFTK8oUKwsQpOZHBwC8HLvhtIiVpTYEk1ng9
         efYFDKhas8PyJxOtX6mMY4Xu0vAqX5Yr7ppJ/lzXTbM8DGSYMmAxPU5CPvRIJOAvSA4e
         2rOA==
X-Gm-Message-State: AOJu0YwIhGcKjocfRL0kEeESJO/XHXOoPP6Zk+bnJTtEExIZSW8PG1/4
	4/hxbC5avqHhO9meATBpbZ2GSiPbh7BifcoYJEKRm7j9tCzcfKDPWVrShWXW1Q==
X-Gm-Gg: ASbGncu+B442EQE+2Z9ljB0O4+Bw3p8j7Ez8z8D+S3HrbFr1wCnAYYaKbUs/2fDVH3d
	pCiSPDGQJKmNyBj3++n45KIMGxvh1MSvzq1gWNRs6rm5n0ybKHyXGSVJRK7Ylgpky96ath+WTgm
	Fq8/wc/T8x5dPjUedjV0YiOzib2qQxV1FvqF62bm91dYrEudZknWjc3zQVtIVQ9dbBTguh5qZtm
	Erw/MKyoYrJN009FJXtA51itMf6hFwWBGrBQvkwXeIPWikCCrpbvxXsSmcZJcKXpWwoTRbzqVkj
	ZVLjp4hTLMSaYT/Imgon2w2STF6zGbWN72Jl0M7FdID9sKMR18kJswh7qAznFQtMP9iRctYSj3e
	4OMD20jT4TgZB25RK0ySAz+WurUSBSTTof6EZ3nr/t2WGYu5v6zdxaR2U6+5CZbWSyN7LYjA9PN
	/t6OtZaDzSaaQIgQNYiyhfkg==
X-Google-Smtp-Source: AGHT+IFoXZdEjPbnCtnbZLYdCAuWlz+OgxS2JwL9NPvV1i90a7FO0gLQ+Ael2RqfN7HZQ+twpBzhqQ==
X-Received: by 2002:a17:903:1b6e:b0:24c:af27:b71 with SMTP id d9443c01a7336-28e8d0c9c3fmr45711005ad.20.1759437143461;
        Thu, 02 Oct 2025 13:32:23 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1233c1sm29486395ad.47.2025.10.02.13.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:32:22 -0700 (PDT)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf v1] libbpf: Fix GCC #pragma usage in libbpf_utils.c
Date: Thu,  2 Oct 2025 13:31:50 -0700
Message-Id: <20251002203150.1825678-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The recent sha256 patch uses a GCC pragma to suppress compile errors for
a packed struct, but omits a needed pragma (see related link) and thus
still raises errors: (e.g. on GCC 12.3 armhf)

libbpf_utils.c:153:29: error: packed attribute causes inefficient alignment for ‘__val’ [-Werror=attributes]
  153 | struct __packed_u32 { __u32 __val; } __attribute__((packed));
      |                             ^~~~~

Resolve by adding the GCC diagnostic pragma to ignore "-Wattributes".

Link: https://lore.kernel.org/bpf/CAP-5=fXURWoZu2j6Y8xQy23i7=DfgThq3WC1RkGFBx-4moQKYQ@mail.gmail.com/

Fixes: 4a1c9e544b8d ("libbpf: remove linux/unaligned.h dependency for libbpf_sha256()")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/libbpf_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
index 2bae8cafc077..5d66bc6ff098 100644
--- a/tools/lib/bpf/libbpf_utils.c
+++ b/tools/lib/bpf/libbpf_utils.c
@@ -150,6 +150,7 @@ const char *libbpf_errstr(int err)
 
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wpacked"
+#pragma GCC diagnostic ignored "-Wattributes"
 struct __packed_u32 { __u32 __val; } __attribute__((packed));
 #pragma GCC diagnostic pop
 
-- 
2.34.1


