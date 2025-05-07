Return-Path: <bpf+bounces-57673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C447AAE790
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231E81C01DCF
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E2C28C020;
	Wed,  7 May 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAigAqj2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E81D5ABA
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638247; cv=none; b=q3OgubaoTV7QFlBz+XhjZpKIhDpweOvlNrTNbNTcXhWhxfU2lRSfjcLi7ndFVn3GomfW2DP4VPiuwbPjT1nUHREiZIQH3b6Jv2Iru5oFfIWwJImSV+qe2CJZI5GfiRxnfJxQTEu3l6fMVtkh0AC/BnCDxD2NuwhgUu+6Tr+BSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638247; c=relaxed/simple;
	bh=eAQDNP9T/uvtusZPeoYKHfGgwBmZ13MQYnDdmB9ukt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGSw+axsU7U7p4NyUQtsOKY86Bw9oa7zljC3bq7dQUkwASv1GZwf9XPXvA3HWv7bpUmmOMvwAP0X7Pubzn/GD7DvfDs78MOJr8sGyVBXSUjadVGn50XhM7Rwlpo3E9EggPw2iWBxck7jYPs7nWBwUQtYm1ZzVAVqrcLc1zUapko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAigAqj2; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso93025f8f.2
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638243; x=1747243043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1L/NqTZed1JegQs8/o3PFfTtF5D48vi8zD+v1B8Srs=;
        b=XAigAqj2oem17+mfi28TH8rDSM99UZ5b17+co17NnIoFw9676deBKjZNFjSZY5BFyn
         hrwfpoinZLPykDIxYfhfXLtw8uCmzwWE4hBp5EUso+D/pqBXiyePK6MW9LXDji1imry1
         KfcUxTB+YFbJRw0lXU12zDivKFyFEgcOI2c7bsS8IKyD+lNL18qKtPrrIzdfB5r19mm4
         YvNljzVV3G0Id2XUq/CYzuDLoBkV7KU2X686pUcvM0sYJPJ2N72kTokAkBS/ciFcO3RV
         vionjNl+n3DEJzpKzF8ojcwfEkzQhQJHwI0Rpc9B9fghzLq03KpzjNNeDLynVH+PChBL
         yKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638243; x=1747243043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1L/NqTZed1JegQs8/o3PFfTtF5D48vi8zD+v1B8Srs=;
        b=kZUdgwBUFqYHffF6mmHg2yftz20ZiIZ/7EwpmGNTxe6nl3zqK01qxPazl39WMYeB6M
         Arw+Ovhcrfg3nR1X3HKX3IN0MxEWruTcFr3Gf3W0p/grqhnlCrrFcCXe+VNP+ILy00rZ
         7AOIFi9V+5ozSyIIL3Ra2zXofJyekaDl0mCKLbyjGy520wqditPTzmbMA8PCjZQh4wFx
         PGx8NegZNT9fArjLCW9Xex5l7hzN33/6RTtlrMmgQ+CTrhkipARMzdIeEl8MOa+bNcqx
         NTqiAwAcFahIhw6SZYd4slNCw3vzdxJDpkg+lk9GJ2K10ji/6mEIJPCXabBpuPeWHk6n
         CRpw==
X-Gm-Message-State: AOJu0YyEx1BxkTqROnCXZ5pUa8YXlRCRhbQYXDFhDWkISHOfK9V8WR28
	1ERQrjL6hrkAA4oqa5rd0OxRGHh2HvaA1nVQf1OZLuxDhoBX2ufL5IL88QYK6a4=
X-Gm-Gg: ASbGnctw2B5NaxhhtFBW4TkdOWJnIB0h957xhxd8SHLb6c5ON7PXb3yVWpCgs7ps6mF
	PuP2/JAF4LufDlHlHFXvYBQxaP7B2K5U+owanCL6ROOZmDtaJM35joIajHpnsl2j1G3tcopFeWh
	uAwY9OwU5cxzDko20ZERt//45n+0n9ZUpAU0Dlzz6xza9045acM/wCMIJ6gIMQ7p4pQKAC9z6v1
	aloPMgmx5LhztIzyu+LY+a4sOvxJB1UCRFzUljPOtdnaAclwQUEZxmpYXphppesAH657Q7UV0Ex
	C9wcQcYNzfrGQ75F8zqw49AuzmPku5M=
X-Google-Smtp-Source: AGHT+IHbrx8qqC3gKQh5FtpiFEorsySKFOxvJO8LNVkq/G8MXKJFmB2SCrFukj8LZkgbQc4/5scUBA==
X-Received: by 2002:a5d:5988:0:b0:3a0:7017:61f6 with SMTP id ffacd0b85a97d-3a0b49ab896mr3437275f8f.14.1746638243207;
        Wed, 07 May 2025 10:17:23 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae834bsm17644119f8f.60.2025.05.07.10.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/11] bpf: Introduce bpf_dynptr_from_mem_slice
Date: Wed,  7 May 2025 10:17:10 -0700
Message-ID: <20250507171720.1958296-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4251; h=from:subject; bh=eAQDNP9T/uvtusZPeoYKHfGgwBmZ13MQYnDdmB9ukt4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WJvdHKRJ+uxfLeGRjSwcQilSw9wjzvxyYYhhV7 dwkEcYuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuViQAKCRBM4MiGSL8RynTLD/ 0V5M5eRZ+uCagyEPrwwd8+SVMZvIeYOTu53cCA/fjr+m+y6VUdwhDetxKShaoIwdigKRgLBEAYKsad DsBJIAwl7SfNf8wDmbPe92BzbY6cIDsT8HXLtT1OKgSVrpweOEh9naXQnljUx7yLgjGs5aCuFn+m8R My6//F+l4HkI3j23cdtblspAm4D3Pi1erfE1ibGD0fajSFzpKynnrFZFukZFG7Fi6wuiPM7o6T/E7+ 4mq+L4bTkpC5UB7aG+LCDX77hsP8TssdZ3bw5nijDHPrhrVXYbhKwWmm0K/g5244JQ6feoDBToEhhC m0k7HuBy7sN2wbQdZAZD/Wd0Al1kf23JUb0jAp7ZZ7ZKktlxT/i2qcgJKE4lCGdeZz58Z+SdH0WHhT +mXeklWLvqyVg/eu8W9ofChxJg/kohJa64WVCX2E/aImbTAXF9ujbasRHj8fftMVBpvnWfISsbiJ7m OXBIW2hXcHPStUFBuYJrlvc8dWGKHejZlOoNruia2gSGjMrQ88FPZp6e23l8iWDqTLF187g6C2+SYw +zHgy5LfG/pam0huHDSVrAgWHy7nMazolylBTkpJT9x6TlQIYrjbPi14n5o79twdp1MP+5VR0kKEqP 9RkvW1t3q8PRJk2ktl31ZVQNf9PjxOhyNyd6at3y3jeYxwc9AKyHTb+rwiDg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a new bpf_dynptr_from_mem_slice kfunc to create a dynptr from a
PTR_TO_BTF_ID exposing a variable-length slice of memory, represented by
the new bpf_mem_slice type. This slice is read-only, for a read-write
slice we can expose a distinct type in the future.

Since this is the first kfunc with potential local dynptr
initialization, add it to the if-else list in check_kfunc_call.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  6 ++++++
 kernel/bpf/helpers.c  | 37 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  6 +++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..b0ea0b71df90 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1344,6 +1344,12 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_XDP,
 };
 
+struct bpf_mem_slice {
+	void *ptr;
+	u32 len;
+	u32 reserved;
+};
+
 int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 78cefb41266a..89ab3481378d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2873,6 +2873,42 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
 	return 0;
 }
 
+/**
+ * bpf_dynptr_from_mem_slice - Create a dynptr from a bpf_mem_slice
+ * @mem_slice: Source bpf_mem_slice, backing the underlying memory for dynptr
+ * @flags: Flags for dynptr construction, currently no supported flags.
+ * @dptr__uninit: Destination dynptr, which will be initialized.
+ *
+ * Creates a dynptr that points to variable-length read-only memory represented
+ * by a bpf_mem_slice fat pointer.
+ * Returns 0 on success; negative error, otherwise.
+ */
+__bpf_kfunc int bpf_dynptr_from_mem_slice(struct bpf_mem_slice *mem_slice, u64 flags, struct bpf_dynptr *dptr__uninit)
+{
+	struct bpf_dynptr_kern *dptr = (struct bpf_dynptr_kern *)dptr__uninit;
+	int err;
+
+	/* mem_slice is never NULL, as we use KF_TRUSTED_ARGS. */
+	err = bpf_dynptr_check_size(mem_slice->len);
+	if (err)
+		goto error;
+
+	/* flags is currently unsupported */
+	if (flags) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	bpf_dynptr_init(dptr, mem_slice->ptr, BPF_DYNPTR_TYPE_LOCAL, 0, mem_slice->len);
+	bpf_dynptr_set_rdonly(dptr);
+
+	return 0;
+
+error:
+	bpf_dynptr_set_null(dptr);
+	return err;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -3327,6 +3363,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_dynptr_copy)
+BTF_ID_FLAGS(func, bpf_dynptr_from_mem_slice, KF_TRUSTED_ARGS)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 99aa2c890e7b..ff34e68c9237 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12116,6 +12116,7 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_unlock,
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
+	KF_bpf_dynptr_from_mem_slice,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -12219,6 +12220,7 @@ BTF_ID(func, bpf_res_spin_lock)
 BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
+BTF_ID(func, bpf_dynptr_from_mem_slice)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -13140,7 +13142,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_mem_slice]) {
+				dynptr_arg_type |= DYNPTR_TYPE_LOCAL;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
-- 
2.47.1


