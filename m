Return-Path: <bpf+bounces-19715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029CA830276
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 10:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079461C21023
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADAE14015;
	Wed, 17 Jan 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAThuiOm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725714264;
	Wed, 17 Jan 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484436; cv=none; b=qkxNL5B4pVZeWnF7WrJg76HGOL5PXnadQUsQScxPT4EkLhJ9+rNfBmSdjRxc16fv5vEAU9N1D0ZCdoLROPHoeFkj7GsP+rWfGnhpYeft91SV/jDpZA8BUuGRl0s81AI4cYBeLd2A0w8jzW0XAjWZCz0RHRXOqXC26ByT8CxtQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484436; c=relaxed/simple;
	bh=2GsEiOJR8LLt3uVHvWmT0d7TQeor78cxlhGybVEomHQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=TvaqvvguWEHr1vDRhF4JL7ap1kSTZUsYexJluRhq7vBfSrvb7WSxtmbDrJfAqZfzcJfJ3942QVUIK36Kwx2x6HJ/iY0jSr/+Qrxq5ScPWLMdw+CgZdEJKoQB7HZMjkodDhotbTsmWzgzBeSdK4x6Zb5PepPQE8SVUirGWDHwwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAThuiOm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso59058145e9.0;
        Wed, 17 Jan 2024 01:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705484433; x=1706089233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuJ0s2JIu9f/6e1MDd/MqOtZxdjhgBwx8nheT4zTYe0=;
        b=cAThuiOmhqIUzbKyh5S0lHhBg9BuMe7WhQI/lTGwwM1J+d+J97+wrTqcspp3wHi++O
         MfUrRr2FRt+rk9rQWSvSu8WbzYDFZ2IGfMy1SYjyDmGASaIWIS7F8I2G66tuhUPY9lQO
         X1cJWZe4AFlK5a0yw5oO8El2F0F4Qtej+jWneVN/VwjM6P3eb7EHGprLkVb8RyHmTJsp
         u/G4rQuwwVD5DD2d9+hTKC3XQ6PYWDom7ZZJr4TymwhY94J5p3biWnBUs7+d+SSynN2d
         OLcqllJzXpiF/mwfNq6Dn0/Mn94ynMksZeesqdqz4g2IWuI2ORieuN2Op7KjADRF897M
         FggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705484433; x=1706089233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuJ0s2JIu9f/6e1MDd/MqOtZxdjhgBwx8nheT4zTYe0=;
        b=PVmHTgTcwrEaomhN81iJkKB9aT/J2vh1FBxfXi7ALMJGoBiQhekbku/Hes0dxGtlS9
         ZOUcfvFqkxpmU5FI0p339WfBFCIMu5NavEDA6NucbhAeQx8XQNLtX0gCHrKfeJSjIj3Y
         JxbxbAx1UnSogWT+II3JcL00sFY3pIfq2U55sU2PmTzsTaP7zgcPT5YvG9j6DVk5KBFs
         DFoK0vUeRqgGr35k7aem9l71vBbQSID2i55GqSSIKutG8swWQ/l1jIe3v21CKScVF9Sn
         5m4I5DmLmU8lDhWQ0eEOQcf+n/NuLFFVByrFD9SaXLQYxf62RGfVu0wBkL6aNxHppDUo
         o75g==
X-Gm-Message-State: AOJu0Ywa3pd3QMt3O23mhLtKgEbuyzfdZU2ZxYcNM+PRMIahmtbVfqAq
	KGaAZn1l1ZpqPVgk+IPLe4D+xHr3rA==
X-Google-Smtp-Source: AGHT+IHEU8b0F97PYYQLYy7w3fgf0rW9Wl0fQOSSic4hOUUlQN2XPOh3FMQ0ZBRLFrA9UUuaPRoAGA==
X-Received: by 2002:a05:600c:310d:b0:40c:2c40:8c with SMTP id g13-20020a05600c310d00b0040c2c40008cmr4689239wmo.154.1705484432682;
        Wed, 17 Jan 2024 01:40:32 -0800 (PST)
Received: from staff-net-cx-3510.intern.ethz.ch (2001-67c-10ec-5784-8000--16b.net6.ethz.ch. [2001:67c:10ec:5784:8000::16b])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm21684766wmq.12.2024.01.17.01.40.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jan 2024 01:40:32 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kernel@vger.kernel.org,
	Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH] bpf: Refactor ptr alu checking rules to allow alu explicitly
Date: Wed, 17 Jan 2024 10:40:12 +0100
Message-ID: <20240117094012.36798-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current checking rules are structured to disallow alu on particular ptr
types explicitly, so default cases are allowed implicitly. This may lead
to newly added ptr types being allowed unexpectedly. So restruture it to
allow alu explicitly. The tradeoff is mainly a bit more cases added in
the switch. The following table from Eduard summarizes the rules:

        | Pointer type        | Arithmetics allowed |
        |---------------------+---------------------|
        | PTR_TO_CTX          | yes                 |
        | CONST_PTR_TO_MAP    | conditionally       |
        | PTR_TO_MAP_VALUE    | yes                 |
        | PTR_TO_MAP_KEY      | yes                 |
        | PTR_TO_STACK        | yes                 |
        | PTR_TO_PACKET_META  | yes                 |
        | PTR_TO_PACKET       | yes                 |
        | PTR_TO_PACKET_END   | no                  |
        | PTR_TO_FLOW_KEYS    | conditionally       |
        | PTR_TO_SOCKET       | no                  |
        | PTR_TO_SOCK_COMMON  | no                  |
        | PTR_TO_TCP_SOCK     | no                  |
        | PTR_TO_TP_BUFFER    | yes                 |
        | PTR_TO_XDP_SOCK     | no                  |
        | PTR_TO_BTF_ID       | yes                 |
        | PTR_TO_MEM          | yes                 |
        | PTR_TO_BUF          | yes                 |
        | PTR_TO_FUNC         | yes                 |
        | CONST_PTR_TO_DYNPTR | yes                 |

The refactored rules are equivalent to the original one. Note that
PTR_TO_FUNC and CONST_PTR_TO_DYNPTR are not reject here because: (1)
check_mem_access() rejects load/store on those ptrs, and those ptrs
with offset passing to calls are rejected check_func_arg_reg_off();
(2) someone may rely on the verifier not rejecting programs earily.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/verifier.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 65f598694d55..861d8d824bb8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12826,6 +12826,19 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	}
 
 	switch (base_type(ptr_reg->type)) {
+	case PTR_TO_CTX:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_STACK:
+	case PTR_TO_PACKET_META:
+	case PTR_TO_PACKET:
+	case PTR_TO_TP_BUFFER:
+	case PTR_TO_BTF_ID:
+	case PTR_TO_MEM:
+	case PTR_TO_BUF:
+	case PTR_TO_FUNC:
+	case CONST_PTR_TO_DYNPTR:
+		break;
 	case PTR_TO_FLOW_KEYS:
 		if (known)
 			break;
@@ -12835,16 +12848,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		if (known && smin_val == 0 && opcode == BPF_ADD)
 			break;
 		fallthrough;
-	case PTR_TO_PACKET_END:
-	case PTR_TO_SOCKET:
-	case PTR_TO_SOCK_COMMON:
-	case PTR_TO_TCP_SOCK:
-	case PTR_TO_XDP_SOCK:
+	default:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
 		return -EACCES;
-	default:
-		break;
 	}
 
 	/* In case of 'scalar += pointer', dst_reg inherits pointer type and id.
-- 
2.34.1


