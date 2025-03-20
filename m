Return-Path: <bpf+bounces-54495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B0A6B008
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3563A643A
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 21:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0992AE6A;
	Thu, 20 Mar 2025 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVWZCC3t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F434215162
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506870; cv=none; b=l2A1JAXWk11MaFC7YYXwtWwOolEGmI1+Hr8GkJm9SmuSjbHv0EE4t+TanSAxrKAnCglWRrBPwvWwJQPvn1f2oDgBe70GhoKkEofCcglUjxXOVKQkIsgjvBocdiZS66qTDlguen7RmqXHr9tKmMyLVu/C+w1vJiWfFQLB8Mf17rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506870; c=relaxed/simple;
	bh=LNQUP1itkchmVPqrKZGUPCA9eQa6H53c/zf9fLj3H2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/Jt7oVSwcXDzSBbs3F9oKd8pivAsPDbTxHOY0KpCa9B7oNdP8rrCpMn1V02a9oG17T5nJitF4QWGoQ9PPgfApMUYv2bpJXoRBvFWBgexAXbIrxj7f0AbTrvX7CYE4ps4OYz4YmpCpwEASHMMWCDJj+A4YBhTxX8TV7n52TqUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVWZCC3t; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240b4de12bso35534485ad.2
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742506868; x=1743111668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV1q8eZvmx9V4jpMFcwO19JOZZYsYX8wO6GVRgpd7aA=;
        b=SVWZCC3t/XxFp3HddrlM0gYgrfH3tRHZ58di38cfcI/+d6m7BObSyitFhOYNCDFXf4
         aRo7ebYetiUdZEOnMJqeLYnbnhOgTto5El2NhDTFO5Vt8+CUBE99rcxiMeoqkZFjW8rQ
         iiIj1Ju7tUp6jRM5WBFszId0sr0/ordmVQnqINVRb+teobKQakgSWQC6NkakpWxUgUNW
         yz4LQZwPq0Gs2RgfSRZpyPZK3gtmnLuxFcGHKoNWFz4qn6jus7qUHq186nWOT+XkF/UU
         CmN6Ik26b8HCyOM4ApX7TSuyfYQnxF1wkZ3CbvYmHAFBALuQvzI3cEVljY6zwCewA8Q5
         ydhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742506868; x=1743111668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV1q8eZvmx9V4jpMFcwO19JOZZYsYX8wO6GVRgpd7aA=;
        b=ADGWJFKxbwaeP+KqQ6lVQknGUiLYI7wgNz7QZooyusKdKPw9bgnXaVNm03dVuf609B
         fyv0YHPwSYNY4lIznH+YW0kfnPQavm6eaq35QcmEe2eJi4oBRfcj9RiSk0wdF0g14hAZ
         4XbxhREriqlgg3/ySJ/ixV2JHzfqFie/bmJt49VpIaLdm0lVhTbqf+CgkscISNXthmZ8
         wMS7+EZVc+jRIW9DlltTclHulsc0+cZEVUaXYAF06lzP8ljY1oOu9yqdgGLDbZAeAxxp
         4QqRodS8jlM5vMV2rzvj7LDPO4fWI30qeZqnvYgyXGOwHQs5Eb5v2DvQBFbh7kCT6Ub9
         C4Vw==
X-Gm-Message-State: AOJu0YyEHJ4fNfJor2LdjFbRzElGwBfG3CckNN0AH/Uwjr+TgJ2ZMeG6
	Ikc1/TRDD+zaEIDqtoHTh/wJyTdvWFZLST53i9w6d851x1YyCHslwSeYjWvtnz0=
X-Gm-Gg: ASbGncs05ETZcvz9NYGotO6ODmvI9/V6zyipZDzQjcMk5T2w40vuYrcFja9F0eMcCn2
	bYxhAWpqaYkhFmBOCU+m0IZ8i7xBKt5RoIpUt/ufb5/Q75vT0IT4YLG9+fzvIJuVtio+rCQFWXB
	rzqJG2HF3KE6Nx4y7Td4D3+cSQl3wv0mIelMvhJkdvQSRf5W0ok7MRgHW5MzlcJlGdrk6ZyDcgE
	A3n+dhGF6mmPmYBUWzqjnuYqmBRm5gKhflX/mVFVR2UMok1WQrjriaPsELxRGz9AaUmT2gnMjnF
	cyyTP5uugyh6+dItFgobHNHCDOyenU07BFzp7gRrO9pY+bju287KE1vfDakdKL2K17yovFd0gvk
	1Intm0DfB69K0RGo7xFE=
X-Google-Smtp-Source: AGHT+IFhYKTQYCZCUOE1GnzIBakRG+8OrBANLWr6lG5V/ukm2RY45tVhHjzsnP2yVlr5ZIX+2m1g6Q==
X-Received: by 2002:a17:902:cec4:b0:220:c143:90a0 with SMTP id d9443c01a7336-22780d96ac7mr13699255ad.24.1742506868202;
        Thu, 20 Mar 2025 14:41:08 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e59esm321135b3a.170.2025.03.20.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:41:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH 1/4] bpf: Allow creating dynptr from uptr
Date: Thu, 20 Mar 2025 14:40:55 -0700
Message-ID: <20250320214058.2946857-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320214058.2946857-1-ameryhung@gmail.com>
References: <20250320214058.2946857-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bpf_dynptr_from_mem() only allows creating dynptr from local
memory of reg type PTR_TO_MAP_VALUE, specifically ringbuf. This patch
futher supports PTR_TO_MEM as a valid source of data.

For a reg to be PTR_TO_MEM in the verifier:
 - read map value with special field BPF_UPTR
 - ld_imm64 kfunc (MEM_RDONLY)
 - ld_imm64 other non-struct ksyms (MEM_RDONLY)
 - return from helper with RET_PTR_TO_MEM: ringbuf_reserve (MEM_RINGBUF)
   and dynptr_from_data
 - return from helper with RET_PTR_TO_MEM_OR_BTF_ID: this_cpu_ptr,
   per_cpu_ptr and the return type is not struct (both MEM_RDONLY)
 - return from special kfunc: dynptr_slice (MEM_RDONLY), dynptr_slice_rdwr
 - return from non-special kfunc that returns non-struct pointer:
   hid_bpf_get_data

Since this patch only allows PTR_TO_MEM without any flags, so only uptr,
global subprog argument, non-special kfunc that returns non-struct ptr,
return of bpf_dynptr_slice_rdwr() and bpf_dynptr_data() will be allowed
additionally.

The last two will allow creating dynptr from dynptr data. Will they create
any problem?

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/uapi/linux/bpf.h | 4 +++-
 kernel/bpf/verifier.c    | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index beac5cdf2d2c..2b1335fa1173 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5562,7 +5562,9 @@ union bpf_attr {
  *	Description
  *		Get a dynptr to local memory *data*.
  *
- *		*data* must be a ptr to a map value.
+ *		*data* must be a ptr to valid local memory such as a map value, a uptr,
+ *		a null-checked non-void pointer pass to a global subprogram, and allocated
+ *		memory returned by a kfunc such as hid_bpf_get_data(),
  *		The maximum *size* supported is DYNPTR_MAX_SIZE.
  *		*flags* is currently unused.
  *	Return
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 22c4edc8695c..d22310d1642c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11307,7 +11307,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 		break;
 	case BPF_FUNC_dynptr_from_mem:
-		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
+		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE &&
+		    regs[BPF_REG_1].type != PTR_TO_MEM) {
 			verbose(env, "Unsupported reg type %s for bpf_dynptr_from_mem data\n",
 				reg_type_str(env, regs[BPF_REG_1].type));
 			return -EACCES;
-- 
2.47.1


