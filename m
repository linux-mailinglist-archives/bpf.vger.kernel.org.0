Return-Path: <bpf+bounces-75665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55DC902BF
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 22:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8E344E2D37
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987530FC16;
	Thu, 27 Nov 2025 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDRfbGJ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E321B9F5
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277271; cv=none; b=AIVJzvFr6NMwueVku+pkZOianbkOmm6HO4y45JZmkXOjaQd9xI2ZGfApw+bCEzcwE3C8p4zb6Z8Ud8T86sgPINeP+S7r38EYj8oyqdMiBzgHAf+/NznRfBuVfdS5zRdwQ6jGKYtvWT1dO+4rZO/4fG0a2fOJjWDKr98ON42C0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277271; c=relaxed/simple;
	bh=CRtBOxsvowIsrG9IIZjD+TNQdinAURq5wnzAWd9Dxno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jL1Wt4KU6hxf+J/EFsJ+/6yR4MKFKdtPCHaZ3SOWlRPTa76NbNhhW4YLseZVqJXPa9tdHIuVrSyZavjdS1TxGGEuko4jSrpBrZorPCEqFofgNSB5X6l2NoNa2osFOV8Ltikbqmcw9snuapJUSVaPy/+XxlzCJgfM55HsF61f9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDRfbGJ9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42bb288c17bso809913f8f.2
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 13:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764277268; x=1764882068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UB5GYR2Y9gT++pcCe5c3Az2yczxHavHJBHiuIl3EX6M=;
        b=bDRfbGJ9+x0mAYvDzL5CyVo59D5rHpSjhbm+I6m4JsJxb+JcIYaUe2tEj4SKGg70tA
         wpNlO1eyNU3VRucx7VjtjXJaQSBsWjodQQY76mmQYSUr33VXL2wfTlAgoWUMHaN1bMvs
         1whLjZ+ROVqfoCe0uaw1NBpPhS+rRiCobYTAj8Zmkccb7gv9wQFquAgz+8kOySyDb5qE
         C7vFWtGGY6Yt4OnJUuq1fUJrUkMX8nWN7I1gV7kPgl1H2JY6MlLj+qvv5WCenX6iPaAn
         iYW2PQCVv6LsyJNX+o+TBvzqaj+2F1kTEg4tIhN5p1DQt1NWZRjXEZC12SadXtg2/ewC
         fXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764277268; x=1764882068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB5GYR2Y9gT++pcCe5c3Az2yczxHavHJBHiuIl3EX6M=;
        b=k6kJte2Mx5rJwKAWBTRNFmpMRUSnWbnVOaqFQXbPtpE4e/0cX07IOKxd51WtmF6NVN
         3z6E2QEhKvCvFvoM7DO9QVkAWLqjiocf8MZSk9wufbXwacNTSR/9yrRNOY/djaYZ/VWs
         l1KM9Di/3tzJdQgo+bewBtE5jqpjIPPD1CEqmJJZheLMgjBs3gtYfv7TQQONxLNk51l8
         romSR+/tIJ0OPQgPowiW3U0rUtkxks+LdkOLgOGNggnVUcjDoOoSVwFRfLEJnm6iJMxC
         V+7Ag5rPJTVhRJWABa9srcDYXxcAPLxnEmfo22DnnlTB7JAmDwhwQ4MXf6sS6/ciQk6q
         X2aw==
X-Gm-Message-State: AOJu0YwZvo9e+n1pvINos/sm0AOQlYYl/3whQEl9dGE1kG36Qq/0HQx3
	Tf/iys4qqfQSzl5eT7qu0In+WM+Ww6GQzatb8bDtDjDHzjVUM1+uQ6bv9Y4kfA==
X-Gm-Gg: ASbGnct9ruiyE7Z7o7w9NlpCHHOAPJcZZgto93sv6hT5kdnIsvcAADZ+F7cILOTdaa8
	HpZWi33hS2TGOfTWYl3zj+57lwzDYuY/kfqQWal5o2IJmYnCC7es3TLZRzmFF8uyUj4+dXghkh3
	sjFeolTPXtIhariFqB6FD7cL3pioovlZv7cuhQ7yCxvsMMwz4CI5uNmfq7ou7KDfITzycw8TXbp
	Jj4n6apHQa4XxaoWdn8A2TLXwgdzQoko15kwUXaQ5zyQjdnYnchMP4MujGbKKLtJYEZ8FfL5haL
	iPObfPfu7nfaxyZVe+yaruHzLdNTsuhzSeTgPOqXj5TpfBNQJlIZouDqfozNv5iP6o9obTol3dN
	GmctAmxWYVIdnqdLD1w6i59q8gfPGRX0v5cazG8ujOWohWHWFKAjVd38O6oQ753W2YF/9bIydKo
	DVc8L7vATF8InUiZPrUf6Yh0BfSS+21aDZNc0J7MVM
X-Google-Smtp-Source: AGHT+IHH3j1xCmuk3Mo2PFrgr8vyx2Pt/3wX1+nnAjlvBqaHJ1l6DPrhpKA5coUFquCqmOp4aanlpA==
X-Received: by 2002:a05:6000:2883:b0:42b:3806:2ba6 with SMTP id ffacd0b85a97d-42cc1cbce07mr27198507f8f.25.1764277267899;
        Thu, 27 Nov 2025 13:01:07 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca9aea3sm5476461f8f.35.2025.11.27.13.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 13:01:07 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] bpf: check for insn arrays in check_ptr_alignment
Date: Thu, 27 Nov 2025 21:07:32 +0000
Message-Id: <20251127210732.3241888-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not abuse the strict_alignment_once flag, and check if the map is
an instruction array inside the check_ptr_alignment() function.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58f99557ba38..ddc68273d29f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6482,6 +6482,8 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
 		break;
 	case PTR_TO_MAP_VALUE:
 		pointer_desc = "value ";
+		if (reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY)
+			strict = true;
 		break;
 	case PTR_TO_CTX:
 		pointer_desc = "context ";
@@ -7529,8 +7531,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
-	bool insn_array = reg->type == PTR_TO_MAP_VALUE &&
-			  reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY;
 	int size, err = 0;
 
 	size = bpf_size_to_bytes(bpf_size);
@@ -7538,7 +7538,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		return size;
 
 	/* alignment checks will add in reg->off themselves */
-	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once || insn_array);
+	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once);
 	if (err)
 		return err;
 
-- 
2.34.1


