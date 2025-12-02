Return-Path: <bpf+bounces-75864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC611C9A93B
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 08:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFC93A6B67
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 07:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BEA304BB3;
	Tue,  2 Dec 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy8Ps9oN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2B303CA8
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662117; cv=none; b=iu4NT9pzJT1u6J42w+cdMX1+wqJ4g5gX9S6zX9wgJR8QBQ+6kbl88Wsl+gWp23IhLgI8La8T0g8e5GKiN6Of88tBNir17b0c7/eclPTy92+Ch08dHeb8zZEYsH80U4gRGfZ74IRZ84TPWnULXyKRlFKRHEa9wZHi3c6MgNQts88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662117; c=relaxed/simple;
	bh=HDJieKVU1OPAPmWICR7jITnRxxHe+vYqQPrTd5IfbEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saAiyctRYib163ChoxlqgLHRKnDw6Z+Tm9VnlyuWMEkZsJKwXqjwYxmdilWtf22/4z7IAnc4rvdsSRHnevLlhqAd9EYo0Cy0n+UUCnMDwEn+zsQqlH3z6WK80IKlvZn3lE2JomGRtdOJ+rioXwrgmGSb2KBE+2+r+xS6NM0Xsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy8Ps9oN; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-640c857ce02so4684135d50.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 23:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764662114; x=1765266914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhV+wF32u4YWe4M1PbEZf3RsFPpmY7QIKhhlfIeHA4U=;
        b=Jy8Ps9oNB3ab2K2ycUuXqN0BU7zovA5qMOWdMPG+3EBjsixSFYzmiDSP+ARnJvCN4z
         GEOjWMcltGsp9x7DSZhM5BZ3RrQlCttgxwt2nl7TJX3QYXMbPsC1acPKMdmopTkssmCM
         YsL8uFGsVDDXKNz87drTtLsozNGTH802ekoqHADWAPAMBjsuGNBPDmhEUpjjWNtl0xyG
         W5dJemmAFon/n8Bwydo0UU7NwGrf1ngtAbpy4PQADn+eNYkoR0cPxF6CojFC4LrklR+r
         NOo1zq7x7fFuwVi1P0uMjizbZNbGeYeJL3u96joi6lfH8bZ9+Pw+1WIHz+hY4n5UOzN+
         a0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764662114; x=1765266914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhV+wF32u4YWe4M1PbEZf3RsFPpmY7QIKhhlfIeHA4U=;
        b=tFTwaSkuoqxZVkVfyGSD9yU8HnwuzY44gW7I/iMV1jaeQlaZcuhGKj1uLsySqMDarZ
         B83RVsYpPbVvyyTxl3wtwffOhzJj1UFDH33wdVFcTEqXuqjcVxJMVZciETM4nTJ9GCDw
         C3MLslRL0Sm7WIHVTWkX7Cur0BYUZnuWNG5tNfWpHeVyMdpvyb4VFVYPT/JKmvFAXpgs
         1OB0CHKODhtYFEwmuA6/z7z1SMgaBIXa0f1ESXCHUFRSj/PgBkakTiCFvTYEK57KYEfN
         yhYWCcAa/b0xKjH/Z/W4tbH3tA2Zebvm6cmE0kjqbVH9vEvhM6P8+LWwv66JAsn6wfIX
         VIRw==
X-Forwarded-Encrypted: i=1; AJvYcCXz0ZSEu7mq0WDVdjXClFg3rjxEyarbyc6lD6U2sTi8DgZSKCBQYaS+PTWhi5SVD7vyzuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJr/QGs6cE3dGy/7qVvvT8Cu7Ef19j166/j1liedS25fNVICpq
	UvMbWUu1lZ4g4qIid4EqWBXCsoaq+QMAw9zdjQf6u3BwfHtFeFUQ9Gm/
X-Gm-Gg: ASbGncsUoXT1QZNMadCF1KSBN7WjGkJhapjz4ml5x8nHS901QI1X+uIU3aLmRw7R2s3
	RLmz4SF4W5qglh/Tfexn6rYo9hBOsKkhgcF9hURRRkkDWrwVYBgKO9jjuD4My9M3V4o2nf7drIA
	7lEZUSM50BjqyjkTAwtzJ+jo3AHVHQj2k2sumoDuduTiWRwa8Mz0agnhOKfKgaqLyc9w08Ik5Wr
	LxRuGD1hud92xMefUPP2wkty+eKwuiqIOux5hOUzQYj9Mzu8Uwera7ULZUN0Os2c9EkzMVnv9JW
	9lfedJVmSP57NzHKR63Y0KuLj2bkESY2XsSFSQWIA50yPLrxossE9HVAAI04KwpSPejgEyGExm3
	zyAkFZEcoixkvTbltxzimX/si41dOotxxWKexnwqteqv3ldIhFHObBL1+n0fyw3AZkBF7DULhzi
	tltbvBDs1VMfY9CpOSfOMK5ZdoWf3Q7j3hpDVwfvgfN6/97cVpIKk=
X-Google-Smtp-Source: AGHT+IFBZzlyhlJjdYgFkuL2hoZT20pUWcYFhY1fRPsK8reHDBcNcbu7yudp/HsStn2A2L+CGjg/Og==
X-Received: by 2002:a05:690e:134b:b0:63f:7da8:6b8f with SMTP id 956f58d0204a3-64302af092emr29674313d50.54.1764662113717;
        Mon, 01 Dec 2025 23:55:13 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c050d98sm6008225d50.2.2025.12.01.23.55.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 23:55:13 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Tue,  2 Dec 2025 15:54:40 +0800
Message-ID: <20251202075441.1409-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251202075441.1409-1-electronlsr@gmail.com>
References: <20251202075441.1409-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") started distinguishing read vs write accesses performed by
helpers.

The second argument of bpf_d_path() is a pointer to a buffer that the
helper fills with the resulting path. However, its prototype currently
uses ARG_PTR_TO_MEM without MEM_WRITE.

Before 37cce22dbd51, helper accesses were conservatively treated as
potential writes, so this mismatch did not cause issues. Since that
commit, the verifier may incorrectly assume that the buffer contents
are unchanged across the helper call and base its optimizations on this
wrong assumption. This can lead to misbehaviour in BPF programs that
read back the buffer, such as prefix comparisons on the returned path.

Fix this by marking the second argument of bpf_d_path() as
ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
write to the caller-provided buffer.

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..49e0bdaa7a1b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
-- 
2.52.0


