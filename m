Return-Path: <bpf+bounces-27099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B478A9059
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 03:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613AC1C21969
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9B54729;
	Thu, 18 Apr 2024 01:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHH1q+NA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2D5467C
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402466; cv=none; b=iusAWbqtQhQ3quoAJTxbr0cmoCKmMR1pyu1bRHLUGgiOd0LHAG2bVvKI8vqvtugZ/Dro4U4iNcEaKiWBXbtDCBv+lr0iipzSUX3lWwdVv6dX9Ot2Tn1GNUH0D74uJImUFHKitbB9VzQRGIfGrn6UFuhvbTtF+0NGVH479wOKmHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402466; c=relaxed/simple;
	bh=vjRJ1U7DKOKEv8zqHNl/1MSWTfJ+WAHC2urS1kF08ZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qqfRBQ/pZJuBzHx0vS3LsdNEeIt1qFSkzZOaUE7aKUbE7bSn/OperP0JMnaLGToxYzVaZjYzF82VOjTaNBYJyvR0IsDMLXpWXSNfWVrPE8os+0cc2P2ZiemH4n6KgveXoFqRpOAkIskmoIqW+bAtsdRuiWosDnwcYw2NduKl+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHH1q+NA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a2fdf6eb3bso432734a91.1
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713402465; x=1714007265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuQpI8q1wJxBD6X4kJwl22uAmYchmA+XE2ed6Sx/XW8=;
        b=UHH1q+NAnkAIYmnfTLZbtjKDEB1MeEw/V2YGrHVRgkHNgViYvAcYhGbanCgx1+KyUa
         mSFsJiFUEggS3i6hBRDxT46S58f8JmbGkcG2+T6NZgnCroX2zcULVWzY3/li6YgWQ88c
         i9wVom7OjPQSWru/F65Mz3S5CRweovRex77GgbLdeL8p8NR+IzqCAXXPifjv2N1DsmJ4
         1xInCgPaK2AApo/85qAuAntj6NYPfJevmg8A88Nbb0i5eTA/i9VXByge+sJ6GkNCmjKR
         aE3YIbAzCIcSVa4vBW805BJ2xJzSPFdm4WKMv37NanPYvfCqHK9FPMLPFlhb4ZIMvA/+
         oyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713402465; x=1714007265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuQpI8q1wJxBD6X4kJwl22uAmYchmA+XE2ed6Sx/XW8=;
        b=hjE6rSrwhbCeyQx9o3fh/K4Zpe2vgn8l57qrRAV4AKhMKuJkNS3PTdS1ov2/jsagOS
         Yq7R2fH1EsjUudn9yfuRPdwVFhs9GIyYI0I6UlLXb88Ivn111PcKWws+JOwEq0ke9xzm
         BIuRGG+yWnnuPAzRK+HIQjbytyO6xsw3mBLzR0lQfrTtuuKdAT1VaCCjaVWadOyu5/JH
         vDO0uo4bJ1W9onLoRXZQdhWApIdm0k18svZmi0kj2u4peu9YM8BtOv6HswAnZXFHeuCc
         tuI4rAxQrbXGnkGUlvET4tpRsWRFkEIbRVKWkZnjOjzEVnR6S8tX7o14LdBOY2oZ+Rfj
         c+qA==
X-Gm-Message-State: AOJu0YxA1uKEyyUIeN2W9BPl2BlSYSnUhPIlXVm00BhX+s2GZKl4XV9B
	gDVdlT3xs0PjxFzHeipKE60OHDldJPMr4CaSma8tj1n+ow4ACBCY+lItc8cy/KpSqBcFSZ5/wE2
	xcg==
X-Google-Smtp-Source: AGHT+IHGZwUXxnIi8umgtcmk1AYnoU9sLsjsWPwJKD9HL4ufshZxqeVmZB8Cu9P+R7pMCrRGbgVEpjMIq+c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:d081:b0:2a2:5697:f90d with SMTP id
 k1-20020a17090ad08100b002a25697f90dmr2975pju.6.1713402463538; Wed, 17 Apr
 2024 18:07:43 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:07:14 +0000
In-Reply-To: <20240418010723.3069001-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418010723.3069001-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418010723.3069001-6-edliaw@google.com>
Subject: [PATCH 5.15.y v2 5/5] bpf: Fix ringbuf memory type confusion when
 passing to helpers
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

The bpf_ringbuf_submit() and bpf_ringbuf_discard() have ARG_PTR_TO_ALLOC_MEM
in their bpf_func_proto definition as their first argument, and thus both expect
the result from a prior bpf_ringbuf_reserve() call which has a return type of
RET_PTR_TO_ALLOC_MEM_OR_NULL.

While the non-NULL memory from bpf_ringbuf_reserve() can be passed to other
helpers, the two sinks (bpf_ringbuf_submit(), bpf_ringbuf_discard()) right now
only enforce a register type of PTR_TO_MEM.

This can lead to potential type confusion since it would allow other PTR_TO_MEM
memory to be passed into the two sinks which did not come from bpf_ringbuf_reserve().

Add a new MEM_ALLOC composable type attribute for PTR_TO_MEM, and enforce that:

 - bpf_ringbuf_reserve() returns NULL or PTR_TO_MEM | MEM_ALLOC
 - bpf_ringbuf_submit() and bpf_ringbuf_discard() only take PTR_TO_MEM | MEM_ALLOC
   but not plain PTR_TO_MEM arguments via ARG_PTR_TO_ALLOC_MEM
 - however, other helpers might treat PTR_TO_MEM | MEM_ALLOC as plain PTR_TO_MEM
   to populate the memory area when they use ARG_PTR_TO_{UNINIT_,}MEM in their
   func proto description

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit a672b2e36a648afb04ad3bda93b6bda947a479a5)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/linux/bpf.h   | 9 +++++++--
 kernel/bpf/verifier.c | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 84efd8dd139d..96b2aa567d23 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -312,7 +312,12 @@ enum bpf_type_flag {
 	 */
 	MEM_RDONLY		= BIT(1 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= MEM_RDONLY,
+	/* MEM was "allocated" from a different helper, and cannot be mixed
+	 * with regular non-MEM_ALLOC'ed MEM types.
+	 */
+	MEM_ALLOC		= BIT(2 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= MEM_ALLOC,
 };
 
 /* Max number of base types. */
@@ -396,7 +401,7 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
 	RET_PTR_TO_TCP_SOCK_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
-	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
+	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3dfc45ed428a..6162ba31a89e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -567,6 +567,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 
 	if (type & MEM_RDONLY)
 		strncpy(prefix, "rdonly_", 16);
+	if (type & MEM_ALLOC)
+		strncpy(prefix, "alloc_", 16);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -4970,6 +4972,7 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
+		PTR_TO_MEM | MEM_ALLOC,
 		PTR_TO_BUF,
 	},
 };
@@ -4987,7 +4990,7 @@ static const struct bpf_reg_types int_ptr_types = {
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
-static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM } };
+static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
 static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
@@ -5150,6 +5153,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
 	case PTR_TO_MEM | MEM_RDONLY:
+	case PTR_TO_MEM | MEM_ALLOC:
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case PTR_TO_STACK:
-- 
2.44.0.769.g3c40516874-goog


