Return-Path: <bpf+bounces-36578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E567F94AA30
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B55B2BDFF
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F0A78C8E;
	Wed,  7 Aug 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBGBM403"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2A339B1;
	Wed,  7 Aug 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041079; cv=none; b=CGiJErIdxfqw3O2vNZFn0uMruX8wl0QWKwclztEJ2sQl9CVxmtDRpHlLSsvRqWjdpbr2nHUUM5D88kPEij/mwQbpRE+ZXEZGDqc/obv6eHYHoygYq2P5XBegBfr1iRZI5rAlUOG6RUd+DN5jRA92D2Bc76ju0EoXPTqZW4WLRes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041079; c=relaxed/simple;
	bh=cxTU1D6c0kRGYNTYsw/HcNCvx+qua9So1XJ+sb5d45k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WrxtwnucLxa4p/M9wsNodGl1KL5Qb/o3hz5h68fhxmdpYwXY3Lm6shDQ1mHTU1ppP+aZCGktpWRQ37b5v5SbUVCVDxrBSW1cb1uwM1UUXHf4uqT3RZ3Oz/OSZ4FCofmEqndbgxDtLu1ddaTzK1CMb3UWFHM6bvp+YSFL1HD8jeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBGBM403; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so1356565b3a.1;
        Wed, 07 Aug 2024 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723041077; x=1723645877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lm6qhwqKoFxy+V0aw7PJqQZ53pl3pN22qzvw1DoD/Gk=;
        b=IBGBM403l1c0IQwgRCYghUydY/Sw6izdcIOQAhZixBtKlhmkWboSSNQ2y9kNldki+N
         YPwcPT0gByWq4tpxa2JFR6oBvDiHxK+sStZ1KlRiIYK06pnAruqMYAEJ/vWtIKBDVvbJ
         sfubfem67+dwHz6COWRTDAlvQdIR6i19T9EooT0RG0oTULMR1S0ASw+K6X7j9SDjOr/P
         geJL2xXyrmLAR1qdvd7GY9I6ZK6V0ssPsFLBu6rNNxJKQUIceBacVwl9ZTpvGrSGy9AP
         pJEXicCbMAsMk4h4HG7q//iGJwHmr7G1jZoHFuzwEkqnDZvOdBsw42uxyBS8FdJO3pEd
         AS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041077; x=1723645877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lm6qhwqKoFxy+V0aw7PJqQZ53pl3pN22qzvw1DoD/Gk=;
        b=H0o7wOzdhe3narQ9lCxTiNyLjDISb2S7MB84dXWJDunQ7o60NcOR3UKzWt4UVtvNw8
         0N5KfeCbTyvhjYUXMEVFhJpn0IQyI/GbdaHzBuSz825upol2jhYVkuNzQkcFBuwX8HJc
         yQDEP8B3cUUkaT1tFFEXxkiyA3/U8eTwqwrXWxssUKVugbUuRHF50kT2IuHCR6arDVUD
         DotHMlMI+dHIFSPL2VQAJZoscfb4ARq+SYCv8v1YWn8i9zFIuP3Fh+tLb9CUVZN2lXww
         XS/ud+CJSpJp7yp8fRFkByMFckolWEo5Y4aFcemdFYSzzq45k5JUyx4QlziFMmEDAgTt
         RgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHhArQihnPSUwfCCLV+E3Ro4nZgGKcXtoU+nfv0qL/45hESHYOTXut1ZhyRSS9vWIV4RHGAf2a6FZn+t/ab3tbewHD7gBqru58A9ztHHyUGn5eVcZrkFJd2nhaarw13C0O
X-Gm-Message-State: AOJu0YxxRsbPJALQSDNGOP1Nl5G+3GU7gEXEyAngx8TOfCCqxRVhqmQ/
	HdAa3LQU5rIrzjPPb7RsBkK9IsnFnRK6HXvsIsWHGGAwF8+yBEIr
X-Google-Smtp-Source: AGHT+IH6NryRyDMofSB/jsIwYGXdt07dU5k6dgv5xCjHoK7kFcldevahcJ0egT+7YJZWTt11eKqL3A==
X-Received: by 2002:a05:6a00:2190:b0:710:4d4b:1af with SMTP id d2e1a72fcca58-7106cf993cdmr25750332b3a.7.1723041077501;
        Wed, 07 Aug 2024 07:31:17 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdffe4sm8420667b3a.128.2024.08.07.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:31:17 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
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
Subject: [PATCH bpf-next] bpf: remove __btf_name_valid() and change to btf_name_valid_identifier()
Date: Wed,  7 Aug 2024 23:31:10 +0900
Message-Id: <20240807143110.181497-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__btf_name_valid() can be completely replaced with 
btf_name_valid_identifier, and since most of the time you already call 
btf_name_valid_identifier instead of __btf_name_valid , it would be 
appropriate to rename the __btf_name_valid function to 
btf_name_valid_identifier and remove __btf_name_valid.

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/bpf/btf.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..674b38c33c74 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -790,7 +790,7 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 	return NULL;
 }
 
-static bool __btf_name_valid(const struct btf *btf, u32 offset)
+static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
@@ -811,11 +811,6 @@ static bool __btf_name_valid(const struct btf *btf, u32 offset)
 	return !*src;
 }
 
-static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
-{
-	return __btf_name_valid(btf, offset);
-}
-
 /* Allow any printable character in DATASEC names */
 static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 {
@@ -4629,7 +4624,7 @@ static s32 btf_var_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !__btf_name_valid(env->btf, t->name_off)) {
+	    !btf_name_valid_identifier(env->btf, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
--

