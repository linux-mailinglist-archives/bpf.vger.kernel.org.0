Return-Path: <bpf+bounces-55304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C749A7B676
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 05:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663697A7B4E
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 03:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0F13AA5D;
	Fri,  4 Apr 2025 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6V3n3Ji"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85967E0E4
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735757; cv=none; b=W4eLNwY76jG5WwnHkah3GXn4Ly6HdIwZ64E2H4vGz8ft6cU4jKK9Me9VKNY1zznjU+h5vz/4N58PNrnZEZghXEvdjU43RplasdWd2T+yWq0wQTRdNNM6pr2W9uSO1TVMZ+PFO6GM4c99qkesknWKJWpjg9MM8cyh27T9U8dVVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735757; c=relaxed/simple;
	bh=ufWw//vN6R3rFUiNP0v3lcW2KjnST/75vrkDJ06ZDFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=int3VjaZKEtfdaMMaeOptpP7Mr2g2OSw6JA1x1KTb3xvUyxBZSA9KZq6djwG3toJEIoo5ycr9Ez8VJVd9/f5AvqyB7dR0Vwa9hSL/Zyof5klwkQuulQzSgY5rHH03BXWDiHQ6Kkho0MgCQp1InAwtKfSA8p1EDefwRxjXAsJBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6V3n3Ji; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227a8cdd241so18946515ad.3
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 20:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743735755; x=1744340555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9O4wTYwQPpJWdK5FCjHS007JWQpleau2vu8/fLM+Vo=;
        b=R6V3n3JipU4xBs5JZXt6r7bAzoWvGDi0HD0nLk0R8a3JZqkHA7/Dv0+I2wndNddLiv
         O0IaoqfPNPG9nMK/wbiHCEqqzDfthheUJ+aq0iJX2qRX8OOdcFmCmDzV+OLs9LoTVD2D
         lAnIHBXVIuJPrSJBToRpEtOphfdPgHTa77xoiNfoWXz4Uo7QYoxOta/bOuGH8fx9KWcm
         g9Hosjq1rYi0KbvqoRov6VdKDb8/SeDUsmHIhdupmgWAs8BwoypGD1QzJN79G6rEkxIH
         L5kEH5rRGscHUP3KoGRf+jwZNjpgHsl90EaaDN3eg1umrObQPNs6d7Cr31w7+A/igYxZ
         dX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743735755; x=1744340555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9O4wTYwQPpJWdK5FCjHS007JWQpleau2vu8/fLM+Vo=;
        b=JZNwlGqSdBeZ1ixms9HEdqNdijaBvVufY+5aokdxeIHm3a3GYDT7/d1fy1hu3aF1IV
         wRx4A+ucNDzypKzDj87swl5yJ6k38GNfBEXOEODGney+SZ+VIuWXWkMmTXBPkyDCtuHx
         dLwgNcHUsPmpLRM91shOh+xHInrAf+yutAaVsJhomeZ8jinu8p7m1kDUDJYbN2F3gJ9A
         6yHt52ZI5X+YNIfw8fAi2rTADHZfYS3O7ifKkOJy7swUGeHoIipqWci4+t557as+Iz2y
         BckK0ZKxhyVU8FMlfFS8sPp5iap4NmbSASZ7kq+bHQsl/xlKzexLf9yUavZLVmnGo2IG
         9k3Q==
X-Gm-Message-State: AOJu0YzlnkdSJrnTaEDvQhEO3PwP006rZWvG5SFFwk0DVkSQLZCr9DnN
	7fFusbwv4DLM8ES6ENx3H2bMLRyicIeF49nm+5nrHf2WSWsi9QTemPE8IA==
X-Gm-Gg: ASbGncsvCWULwHkFr+C5n+0s/glUmbfA5CTlodKd/KlSRT9KeH77K2Kh5Hpv5wmeYiP
	t1sVjER3LMahGv2WlD+pfgxiCosin7B7CeL6smIXydbcskL5MRKSX2K4yc+hm7LLTLdxl2+a8+n
	qOOUhpBcAZWshr4NJYop5SDGMD2lPMCIbAUjTC/SpMjOh3GJk8YPWUeMsVzQgP2xsSxWCANw3yU
	2hB0wHW0RMR7CpTs0P+Cnvuuqqszw4IqKk2cUdnCTgGCVctnRFSGLcgIpXbOVDDRfSxDYHLdKCv
	/OcnuwOxcTciSVuOLsy1+oON1x1hYgzlpX/64xoJAuoIAHIXeQhmgEIEDRz4Knqh6KlyFIUeWP3
	MPN6dJh/hvIchh1baSvg=
X-Google-Smtp-Source: AGHT+IGAlo3PQLkNsi6G1XKxwIHuGttWSa4IQTAyycs3zwDukckfHdC8g9I2xKQKBCIhCvFesfnBSw==
X-Received: by 2002:a17:902:f60c:b0:21f:35fd:1b7b with SMTP id d9443c01a7336-22a8a0b372emr21413985ad.50.1743735754911;
        Thu, 03 Apr 2025 20:02:34 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0791sm2262954b3a.110.2025.04.03.20.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 20:02:34 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH v2 1/4] bpf: Allow creating dynptr from uptr
Date: Thu,  3 Apr 2025 20:02:24 -0700
Message-ID: <20250404030227.2690759-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404030227.2690759-1-ameryhung@gmail.com>
References: <20250404030227.2690759-1-ameryhung@gmail.com>
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
 - global subprogram argument

Since this patch only allows PTR_TO_MEM without any flags, only uptr,
global subprog argument, non-special kfunc that returns non-struct ptr,
return of bpf_dynptr_slice_rdwr() and bpf_dynptr_data() will be allowed
additionally.

The last two cases will allow creating dynptr from dynptr data. More
plumbing in the verifier needs to be done before this patch to make sure
the source dynptr is valid when creating a dynptr from it.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/uapi/linux/bpf.h | 4 +++-
 kernel/bpf/verifier.c    | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 661de2444965..12d916664b1d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5566,7 +5566,9 @@ union bpf_attr {
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
index 8ad7338e726b..d1e1841f632b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11378,7 +11378,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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


