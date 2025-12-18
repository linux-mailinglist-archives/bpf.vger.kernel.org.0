Return-Path: <bpf+bounces-77020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAFBCCD12D
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 442DB3015119
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AB530FC07;
	Thu, 18 Dec 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRGWT/6b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8C30EF67
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080607; cv=none; b=dtfK1Q3kMsb6lBL+Yv2CTuX00s3NX2RHaeMWeWFO1gjbc296Nrfa0rcwIePOMTBChcczctlHkLwc1H+R2zOW4KDsCUu/knq2SAm93rXIKQnuPyuvKSQmk/t0pFj8kfwhZBnlo8iMJBo5s2I5Tzs7G5xJhgw/pllBgmmjupDC2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080607; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOGu40s7bpvx4uTLRB5jB5xYlE5FGH19W7El6gulam7boFJks7aCgpNIdRZFCkKFB48rP6O9x65RINe2vpuTEcMnWNJ1KsBtMNAvu2SXCQsKvwrMCztmN/ifllWMGjMN/xSbgqjNcrinGa1bmFeBxCzXld5s9CMws/nYe2H4u5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRGWT/6b; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c3259da34so924222a91.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080605; x=1766685405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=iRGWT/6bXVp6BjqwoiKoSdlxjsInf+Si3IVFE6nFLI8JFKMbricklDKdYwHmFhciGa
         B3lCuP6Es1HXBi91+8uPwnpIJ4Ra0/Pa6BsXIC0PIUOaGk0kOXUNaM67vHXp+tu9OEzR
         JQxH7/O6UXzp54YbnEQsSIjUk95o4PhhJI4r24Uh3R6Vhr+t3Djqz/CxUieSXWy8gP7h
         UeZBknLt48vVFu/dSiM4OyqgsZkB/n55kViHQftCA1FDbceeO1VMxzv6D25u3BSd2vfB
         RSoF4ng1rLWJWZd+5c03x1sKtljxatiIql6tj59DaVhQNJCiTrF2/ew/TNcNg+oVpR0h
         2anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080605; x=1766685405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=wj3OE7U+sKdUsek2Bf5w1LzwvWVlx9x3XTqrKgM1OuqFX9LXFMhuCQOB0jrsUBL5In
         qadF2WMh+h+pjMKDE9uLAUaf3T1C92VZDQ9o+kW45aIEq+CaiV7xrZc97vZ7l0uqgk8P
         qTub7EQgv3UaE/7tU+mWEvagV0FR6b+VT+Zp5XGae72w2Qvd5B0i6oi45j/rZ1J2865l
         7dVlIzyK39vwzhgI0Eqz7R1F2+3ctapnNuMCu1Vm2rRf8MSz94I7BHNTGb1BZXS4v8wc
         Mdc2Rs7H1m88dZRmQPzfM/GaFg6ilNmJAw9UxN09pBM3KzYXEoO0q54A2UJdQG5w1jJU
         d7kQ==
X-Gm-Message-State: AOJu0YxseiaBmlFuUW4WyGoB5/ij8Iu6YiQ2N0xlzn7r9UHkGytAzC7h
	7LKJhAspA8MiKUtXKZpYOFI4VuZqSBQenbSp4RItsfMscdBsn1MUaZ1rOiaP5w==
X-Gm-Gg: AY/fxX6R05HoH+JdtA9WXJBP3wS3xFDX3hA5QVa6Tdg+Lm68iPIOZvR2uab1ZTht5Bu
	xYQ7R4f3KN+QoU29KrNLw+1j3RlyUzqAfyWJnYxPvmVvIpRjCBYkPobER2T8P7XV7IX8KKYih1Q
	Rol35tF6JZz81nOHUJ08PYysy2GCfZVuS7RxWnrTfkrpDehdrLhry6ACaE0I7r6iuS8yEhvCvwq
	HPvXGQE2X2s+hZ4gICRAdCnP13yDivWcMmr/efsPlE4i0ia2ApR97htklBnw6l8z5P5D8ARwIyj
	BocUb0fngio4nsZMpZxQiFP74JxgaFZRl/WVwYQgCJEKXeVtAfcGkFlT9I8PIpvA+Gt6DhCPJxG
	lVyt+zYM0357R5u8RMun9l0yhm41FteJvuhky1WRjF4QXBd3sCpchqwlF85vtU1BEFrtVQx6zUp
	SbGPNzy84y4dvxDQ==
X-Google-Smtp-Source: AGHT+IHWv5b+Xv8jWvC4vBtqhDAaK0vV8FNZVOWNFs3M/xZtMZzQzkaj6mdLHMOymreZBYpyb8C7mg==
X-Received: by 2002:a17:90b:3852:b0:34c:c866:81ec with SMTP id 98e67ed59e1d1-34e921f0ae7mr142339a91.36.1766080604738;
        Thu, 18 Dec 2025 09:56:44 -0800 (PST)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm3103197a91.3.2025.12.18.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:44 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 12/16] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Thu, 18 Dec 2025 09:56:22 -0800
Message-ID: <20251218175628.1460321-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check sk_omem_alloc when the caller of bpf_local_storage_destroy()
returns. bpf_local_storage_destroy() now returns the memory to uncharge
to the caller instead of directly uncharge. Therefore, in the
sk_storage_omem_uncharge, check sk_omem_alloc when bpf_sk_storage_free()
returns instead of bpf_local_storage_destroy().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c   | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 46d6eb2a3b17..c8f4815c8dfb 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-void *local_storage_ptr = NULL;
 void *sk_ptr = NULL;
 int cookie_found = 0;
 __u64 cookie = 0;
@@ -19,21 +18,17 @@ struct {
 	__type(value, int);
 } sk_storage SEC(".maps");
 
-SEC("fexit/bpf_local_storage_destroy")
-int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
+SEC("fexit/bpf_sk_storage_free")
+int BPF_PROG(bpf_sk_storage_free, struct sock *sk)
 {
-	struct sock *sk;
-
-	if (local_storage_ptr != local_storage)
+	if (sk_ptr != sk)
 		return 0;
 
-	sk = bpf_core_cast(sk_ptr, struct sock);
 	if (sk->sk_cookie.counter != cookie)
 		return 0;
 
 	cookie_found++;
 	omem = sk->sk_omem_alloc.counter;
-	local_storage_ptr = NULL;
 
 	return 0;
 }
@@ -50,7 +45,6 @@ int BPF_PROG(inet6_sock_destruct, struct sock *sk)
 	if (value && *value == 0xdeadbeef) {
 		cookie_found++;
 		sk_ptr = sk;
-		local_storage_ptr = sk->sk_bpf_storage;
 	}
 
 	return 0;
-- 
2.47.3


