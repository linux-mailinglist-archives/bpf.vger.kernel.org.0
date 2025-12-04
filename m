Return-Path: <bpf+bounces-76033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A672CA2AFE
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 08:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5269730B2328
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1844928642B;
	Thu,  4 Dec 2025 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T709czta"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A72FFFBF
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834428; cv=none; b=q2VBF/QdNv2SdoyyWa2m5ziUeeRRBVGsEu0CM/bjui4QoyEIVSnqh/3cMd6kHFMJxS0P/9SSiVjVD7ilHGC5jbjVnRmL6m5U3C2IWNY5KolHs0gxasMkVfVsjk1HGEq8SEp29F9ZXG9cKQFSQyRo7rSdc/h8mUw0EsL051m3GQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834428; c=relaxed/simple;
	bh=S+igu4aju7EwXWFRbjCCQgO7Bx4KXZSG7GeZGRqJ1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9hCxlVUG1pG3v0O65eMIDmYcgygu2pZM0QR5gMe+EVDLimRiWpFQyY2yG3ScnLY7EoFT+Z4/VaBMr8QqcNgFsF3QJLgC2a9Sd2/zSHDOLS9OulSfhocBj4dg1q1nCooqTAbmEqATpYIgBqOdEt4jwWl2JnO4esviafFoDmGvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T709czta; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640d0895d7cso1013970d50.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 23:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764834425; x=1765439225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=T709cztaehuPRi/41Hlij4yPBK6fd5hun8C2R3vIhqNee3CfJYkSQDqJ/myUIKs9lM
         7X1GtK2Mwy/neATrH8vIWAp+dvBQpRU14Et0JUWEOY4n9F0XYBdj8l0bWxGMeDeIqVef
         GV5NTOn1QEUKv3T/Lpmk0jDKTHUoY7hU0AwAEi0forF+GgN4yetgMqRLsrYfI6zGmRKL
         NEYkSxyE86M3POKl9NlZHXb+PGZ9TTqjmmyeoXaqQgbvR1zYnRh0rx89rGzFFnNyruDt
         PL50tCxLx2g93qmi1bPKeKfLMEgTTqQYGpvp6fDs1XJUnRCt2H2ynVEOweidZB1O2C5r
         dh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764834425; x=1765439225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=vqS9G87HIkYGxl0DdhcV1YTr8rQN33eIjNYYsy1aA39cTVvSdluJ7V986Xrik0oDiA
         47+MdOIWwpncYq7uh+acwVdpM0lhi6Y+qFgWJ86VYxMLxFAjAQC76uc1ytVOu3IyQiGN
         Uz3uv71YlKlMDcKo0Lys2HwnRY7njzJO7FFhOaG9znDsqJcDlUwTdGDFcOOnPIQAMueW
         nAp42KiL8AjfhxpKhQymg/N7JQuCTBRo+2lXw1IeaHa+yv/18uzyX8qwonIVrlo2qPSL
         1bkbEhS5bzt7wLRuZDCOjZikf+Aadf5Fz4gxvSpFgXOVAjnnGB0wJKT+0S1mCS1PKMSZ
         Te/g==
X-Forwarded-Encrypted: i=1; AJvYcCWPTpCMNTqF8gejzl8vTN5twcl0mVxcgExfW0/6Cdh5pq0BrSpF5wzY/1jMaIyabBME2po=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ87rtFlLhitQmc/FaBkAAz2O2cQPEZSEI5CojVjXkg0OFtR6O
	4dGhxj4HP0Ab6x3tWsh7bJPfBFNhVvV+wEuXUh4zwnq+tGtM6HpHyuaW
X-Gm-Gg: ASbGncvfT5S9qc8HTEOMD247Gisnfj6GYo7Byv/J8B1oEuDCI2A68v5y3ypmrkQNmhB
	ZOhXjuu/VgKfJ6L/WeOpRh0NludQXw3ncskQhdy+wi7q+fNGK1EWcZysg01Oxb1zj+Ip8t1bqfQ
	dN3nKTubJUBR0R0O5U2Ye8Ae7mDRPicBwpyfSLFhq1jB/3ZoBWdGytcNbQbz2IjXzJT0ia3yyYK
	+8xBi2SL/2QbxqXhyeVxulsA7xj8DAxHi9gJwH1FOzWjug7wT6SvlYekhFkYxC7ZZkXlS+3KHag
	O/nAXYK3ZrXXMtMG6lUsFwh10+KwtMGhBVg5nnrxD+gjsSm6u3xUZ8LNLEhv0f3CFMFmJTv+B7p
	8whkxdQeZBADEVKVxq2ejTL68B6urWB/E6AO503/VBRfF8JIlrBEqNCjI6VXOynSgBj59uBsIWR
	nQ8lXwlu55fjVBIUsMUw5k0KjIdIgMqhIulNSbQ6/bK11Ddn76u+Rdn6HWFvZe4Q==
X-Google-Smtp-Source: AGHT+IHAWdGveni9JgLF4NjXVCpK9JAnHMY2t30oQX6L7RsPJUxpwwCxNvBkYXUImMErt52ZB44Cuw==
X-Received: by 2002:a05:690e:1301:b0:63f:af0f:aaf with SMTP id 956f58d0204a3-6443d6e9d62mr1667544d50.1.1764834425343;
        Wed, 03 Dec 2025 23:47:05 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5bcbbesm364495d50.23.2025.12.03.23.46.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 23:47:05 -0800 (PST)
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
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v4 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Thu,  4 Dec 2025 15:46:31 +0800
Message-ID: <20251204074632.8562-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204074632.8562-1-electronlsr@gmail.com>
References: <20251204074632.8562-1-electronlsr@gmail.com>
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
Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
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


