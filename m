Return-Path: <bpf+bounces-18566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F0981C1E0
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BCF1F263A1
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774E7A23B;
	Thu, 21 Dec 2023 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM62l13L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B17A23D
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7810b3c4fa9so175614685a.1
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 15:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703200963; x=1703805763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1/bTgeDwiljTJ9wgpmsLoA1+aGF/EjTYlSK91H4UlI=;
        b=BM62l13LXSnFsZfKxQU7Icf0/lDcB0Efi0Zpe0TwI/E5g66bGmB0/z53vZa4waZZUM
         iAgpEU8/lPTqV91lECi9VfAD+J4ulZDwJljBwIvXSp8lVBTQrLTkvQugeXU5RCWukCmA
         gy1cHLTtJtoeNnYOEEzx1C4z26fGnBLVb5hsc9gPZfsezILVCw91jV/n8PV/AL14Xt8v
         AoC11h1b6xkrCFGL5Q5VCE6kwNiRCUE2Gthui0nI2M7BRrftdXfJ82GelRfeXj0CkfXz
         0dHdzwVA3lOIoSJaEgEzWpZdTimo/XlfoI/+twRSAwQx6Ctdc2xGmbAgqv1wstw9QOPg
         YGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200963; x=1703805763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1/bTgeDwiljTJ9wgpmsLoA1+aGF/EjTYlSK91H4UlI=;
        b=F8PjVqFqOFSs59W9Cb9apsnHfBBgPPM94A0z7/GFa3vK/Q0jJYdAYT74jmUWYSqG9T
         F6YDx6FU0CDgO7UwPISPyfdk7/3pE/TIWaQIFZxAZzAqtIz7RI9691rPOG+kd+nWGc/T
         36jP7LTuc3Whz0iuLIhW+flory1mup6tObaRDGYfqiR8t/3yYXNvGoQ2g7X9n+9jFIaP
         RLL/f91pCwVzeUbaDkS6Qci7DkwCDKWOxv+1cQ3U5iV2VX1RuBVRmjAdBhg+A6vs26lC
         Qumcky2svN1Q3AYURWAK4gngAb+2+6HQ/I2f7kGH3fcLNz5xflzP4V7ePPHS1ht5N8EX
         R+3A==
X-Gm-Message-State: AOJu0Ywl3N/zqWyIynTugfP9ZjQVfGa6fP49nUvQN7c8Is4k8GnOmlUT
	2Zajk5r/FE0zsJlylW4iocZECvL1XKk=
X-Google-Smtp-Source: AGHT+IHi2J5PLy6Xul5b3dN4iH4C22uK9oHfjrp1Wn4PhZjLq5VQKl+jh6uy3lXUDA31SW3nn9L2rg==
X-Received: by 2002:a05:620a:f85:b0:77f:3b93:b62d with SMTP id b5-20020a05620a0f8500b0077f3b93b62dmr616889qkn.73.1703200962705;
        Thu, 21 Dec 2023 15:22:42 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net (098-030-123-082.res.spectrum.com. [98.30.123.82])
        by smtp.gmail.com with ESMTPSA id l12-20020a05620a0c0c00b00781121dcc24sm981281qki.119.2023.12.21.15.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:22:41 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v4 1/2] bpf: Simplify checking size of helper accesses
Date: Thu, 21 Dec 2023 18:22:24 -0500
Message-Id: <20231221232225.568730-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221232225.568730-1-andreimatei1@gmail.com>
References: <20231221232225.568730-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch simplifies the verification of size arguments associated to
pointer arguments to helpers and kfuncs. Many helpers take a pointer
argument followed by the size of the memory access performed to be
performed through that pointer. Before this patch, the handling of the
size argument in check_mem_size_reg() was confusing and wasteful: if the
size register's lower bound was 0, then the verification was done twice:
once considering the size of the access to be the lower-bound of the
respective argument, and once considering the upper bound (even if the
two are the same). The upper bound checking is a super-set of the
lower-bound checking(*), except: the only point of the lower-bound check
is to handle the case where zero-sized-accesses are explicitly not
allowed and the lower-bound is zero. This static condition is now
checked explicitly, replacing a much more complex, expensive and
confusing verification call to check_helper_mem_access().

Error messages change in this patch. Before, messages about illegal
zero-size accesses depended on the type of the pointer and on other
conditions, and sometimes the message was plain wrong: in some tests
that changed you'll see that the old message was something like "R1 min
value is outside of the allowed memory range", where R1 is the pointer
register; the error was wrongly claiming that the pointer was bad
instead of the size being bad. Other times the information that the size
came for a register with a possible range of values was wrong, and the
error presented the size as a fixed zero. Now the errors refer to the
right register. However, the old error messages did contain useful
information about the pointer register which is now lost; recovering
this information was deemed not important enough.

(*) Besides standing to reason that the checks for a bigger size access
are a super-set of the checks for a smaller size access, I have also
mechanically verified this by reading the code for all types of
pointers. I could convince myself that it's true for all but
PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
line-by-line does not immediately prove what we want. If anyone has any
qualms, let me know.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                                  | 10 ++++------
 .../selftests/bpf/progs/verifier_helper_value_access.c |  8 ++++----
 tools/testing/selftests/bpf/progs/verifier_raw_stack.c |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1863826a4ac3..d041927b862b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7296,12 +7296,10 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (reg->umin_value == 0) {
-		err = check_helper_mem_access(env, regno - 1, 0,
-					      zero_size_allowed,
-					      meta);
-		if (err)
-			return err;
+	if (reg->umin_value == 0 && !zero_size_allowed) {
+		verbose(env, "R%d invalid zero-sized read: u64=[%lld,%lld]\n",
+			regno, reg->umin_value, reg->umax_value);
+		return -EACCES;
 	}
 
 	if (reg->umax_value >= BPF_MAX_VAR_SIZ) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
index 692216c0ad3d..3e8340c2408f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
@@ -91,7 +91,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to map: empty range")
-__failure __msg("invalid access to map value, value_size=48 off=0 size=0")
+__failure __msg("R2 invalid zero-sized read")
 __naked void access_to_map_empty_range(void)
 {
 	asm volatile ("					\
@@ -221,7 +221,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via const imm): empty range")
-__failure __msg("invalid access to map value, value_size=48 off=4 size=0")
+__failure __msg("R2 invalid zero-sized read")
 __naked void via_const_imm_empty_range(void)
 {
 	asm volatile ("					\
@@ -386,7 +386,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via const reg): empty range")
-__failure __msg("R1 min value is outside of the allowed memory range")
+__failure __msg("R2 invalid zero-sized read")
 __naked void via_const_reg_empty_range(void)
 {
 	asm volatile ("					\
@@ -556,7 +556,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via variable): empty range")
-__failure __msg("R1 min value is outside of the allowed memory range")
+__failure __msg("R2 invalid zero-sized read")
 __naked void map_via_variable_empty_range(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index f67390224a9c..7cc83acac727 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -64,7 +64,7 @@ __naked void load_bytes_negative_len_2(void)
 
 SEC("tc")
 __description("raw_stack: skb_load_bytes, zero len")
-__failure __msg("invalid zero-sized read")
+__failure __msg("R4 invalid zero-sized read: u64=[0,0]")
 __naked void skb_load_bytes_zero_len(void)
 {
 	asm volatile ("					\
-- 
2.40.1


