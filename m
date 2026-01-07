Return-Path: <bpf+bounces-78081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC204CFDB2D
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 13:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B42A310AE69
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EA03191B2;
	Wed,  7 Jan 2026 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPE49rnj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD74316912
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788558; cv=none; b=tfCBr2RlVD01a2AmH9YvgNB8oYYBpvJ9Ux6YL1WVUczmqQxtTW38s3ix9LguAGOuQd+MTgAUIyYhd5+GH+Sogk4e/FZ+wUswTZS6SQyoF6WL2MrpkGlQBsIQFL/a/9lYogrJIRIxGFlif/M9QLqtSikfNJht4Jnd/oYDRtP0NYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788558; c=relaxed/simple;
	bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOp7dRIxumfbLxl7X+lNUr6je9BV+xNvYK7DmrV2LMPYIlUlaSBFb7u5JVF6RMzzQt5u4MVuYjT2wNdiycEZdkQMXhFJxjw4C48H15/exewcf5zG0LdwVCLXyPxgeSu3EOk8ANYvssLjLDh9H8Ld8xGT3NnCLzm0MDWXmcwGkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPE49rnj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c227206e6dcso1471519a12.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 04:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788556; x=1768393356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=IPE49rnjTjtHNOBtLnU3aEWDBjoZx5aoL7s059ET3UMOTiQ/nA6pVAcCTiwASBZDZz
         dEPHicB+5eMr95lUShJLydiEOVzS/Pq0ts2IIL8m+lUMVjD0mJj1/JksKgGPqUj38+3Q
         tlbPNWe6NBaxjmO7u4RWTO1+5oo4esLYzm8dMi4RrlApnNkpdXQwNt1dLyYvSKCybrTQ
         sOaJTBT9RzwMbK1EuwKvmHMHkZxFF/QnLpIr/oaxJLVtQ6G2Y5fzKOjK4YAckBZyMn2m
         98RJck2QDqsS1P1iaBBZ8j4enbxg0mUqyZDomxUbMb9/7+VQypljfgi4w07DMF3+Rmh4
         E/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788556; x=1768393356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=JgxP08BmRvhiwDNVWELeecDpjzLmFywIdGmtJ/ToiSVMsiTMN+TJfk5VAWYTJ+6EHD
         K4V2eCEPHXqAz91CDtac+r0cMXynWeQwi/MVP13JN6Fw829/i4xjcr6xIBdRqf2P0ecf
         pIKIpNdzK/ZrMAIc/FqA6nHaRj0cDpbXNRiJJe9RUr10oCYBDQ18iMK5hzW3e5E+zARf
         u451GFh2yd+bd8IRDCmYkYeL7KOn7oq+VVzoFI6xvPvooeBeLIRXbsiD5OIkgP3qpo1e
         1IHbeaOzPw3l8VKEobAst7DqfEDbC4hPikbDKuE6VKN0n3bLS//ymllP5fjW+ooH1zHw
         T8aQ==
X-Gm-Message-State: AOJu0Ywdh/Y9QoMiBdqsEFdTtWz/ZL5/2+lRR9uyrp4/Lcn9hm7SNEmq
	AxIh/Z2F7yTsIQfhTCqS0zzKWsc920LJ+NpzLRyv07+pRaHY/TL7pDsT
X-Gm-Gg: AY/fxX76vl6fgobXcIHhb3Ch52iOvQm1WdgtpNlejP0Y4qo6JpetSTyFynuq6xSi+eM
	Cnhc3dH2T1a1MXW75FhaA3Bc1inFaLQKN6FaaEDA6oCRDW+ZR0L4LXsaukXxUiZVbslIYex6Nsv
	kZ/cC/HcisjFGA0sRvVwe6N71+0quVUrZM9EWmwfakZfNhuwIKPS2KctiOK10QKYXWghNbwCdEt
	MLe8cwuz/90DtFCnwK6k0S6aMNDflalSM9WAnf6ViOkIot5YrEe8PYhDMd5w+vqieZ8GajgbN+0
	WA6GMe3uim2TEDW4j9szwggsm3kiZUf9wn37sv9VZIFk+N9FJZXJIZe3c/ig+DO12FOmZz5mawn
	ZCi5SiDGuEs8ap8rjqebxWqQVy76KMTNUNr5nTIzBrDd7WQjLPMh1v6jJyFOKVuzQxGInAwj5z7
	tNcfAJ3k41TtU=
X-Google-Smtp-Source: AGHT+IF4vumQ3UxDP/AczQhAuKSLCFCXdWDt3+3Ac3DseSrY7lK07U9RAIhVR1+386lDOWSI3dLtWg==
X-Received: by 2002:a17:90b:540e:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-34f68cbe0b5mr2124192a91.19.1767788555990;
        Wed, 07 Jan 2026 04:22:35 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b1526sm5025946a91.14.2026.01.07.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:35 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Wed, 07 Jan 2026 20:21:39 +0800
Subject: [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-helper_proto-v1-2-e387e08271cc@gmail.com>
References: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
In-Reply-To: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2ac/xdV2YfeZ4wuCJmHK+jVqLv8r746++XhqI33HeIWb
 12tuTauo5SFQYyLQVZMkaX3h+HdlZnmxttsFhyEmcPKBDKEgYtTACYSPZ3hn9Xf5xONrlr+X8xp
 w3u4MqBS/ZX9+cne2x/Yf3gYWmhZ9YLhf4YZZ/bqW6kPMp8LaE/j6LdmUPfcu6VwpXSdpc3x3sx
 nvAA=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE or
MEM_RDONLY.

Using ARG_PTR_TO_MEM alone without tags does not make sense because:

- If the helper does not change the argument, missing MEM_RDONLY causes the
verifier to incorrectly reject a read-only buffer.
- If the helper does change the argument, missing MEM_WRITE causes the
verifier to incorrectly assume the memory is unchanged, leading to errors
in code optimization.

Co-developed-by: Shuran Liu <electronlsr@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Zesen Liu <ftyghome@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..c7ebddb66385 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10349,10 +10349,27 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
+static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+		enum bpf_arg_type arg_type = fn->arg_type[i];
+
+		if (base_type(arg_type) != ARG_PTR_TO_MEM)
+			continue;
+		if (!(arg_type & (MEM_WRITE | MEM_RDONLY)))
+			return false;
+	}
+
+	return true;
+}
+
 static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
+		   check_mem_arg_rw_flag_ok(fn) &&
 	       check_btf_id_ok(fn) ? 0 : -EINVAL;
 }
 

-- 
2.43.0


