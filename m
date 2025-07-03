Return-Path: <bpf+bounces-62339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377F1AF821A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C97F4A833E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890942BE7D0;
	Thu,  3 Jul 2025 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q545Id/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA829B8E5
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575720; cv=none; b=ZdeFa0n/thCpzrrbZF7qs/AbzqZxVRyEXhl16ZZXFRtsP/00Hvo6sW0fNsN8rQPaH6LnCSh8wYYYUFPUEsysFKVwzM72lv54k+3pA1zbP/M3hgGJoYTzKs8zDBmqRwNVaUrP9U+TcxVDN654x241DNjitznljNnb9K0Kbxcwvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575720; c=relaxed/simple;
	bh=gL3a1w00tHbFN//7/baKWBSmweu8nl29wylvHEKASbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQzehdzAwqBMbsMOE6pEaHMXjn4DqqQm/AeTd6RX1sUKZje9qmHTSI7laErLFUfd9mlsbwZKWCP2TbqfIhjLVvPp0i3XrNv2W01wivMew0YLHROttZMn3wwljbR3KLEqik6imJPT1rUsbL2WBgNCXoVtKRIWPK4x1inh1v0Zf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q545Id/E; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so585005a12.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575716; x=1752180516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbLfkwcA3kfD0F3Sg8fMVBK3UG0LHsEXOd4IcOhTmms=;
        b=Q545Id/EaDjJfMjElc1sGMlc0FDsZEwjDGzVGln4M790B3ttm36zpx6WYNAXjV2bKu
         7bY0GiY4UZxJoh5a0Vunz0+1U1dpwFGqplp9RgJdth2APSMO/83REemXUje/SHO+8tMh
         A6UErWcqmFzoL9MVzyTDwnLHrv5fXPz0kfnTdQpZfov35e8Fg1JMKCBKdmBcR3A1NIMH
         fNrH6nNd1QDnCRPOelR2MVjDf6heBky+WM3EPWcHWEsjKdh/cMjfb+gGl9FFloiaT1ng
         Z1mbx6pOilV8IdiKkamhns5mR7y8VXZvvGh4kBjQB1Fzs5OukH5aIum7zL88/VcyGYKb
         mc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575716; x=1752180516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbLfkwcA3kfD0F3Sg8fMVBK3UG0LHsEXOd4IcOhTmms=;
        b=Kyk47MxpaSTLdnh3L2xiebg66YqdKk2ifNMLHs91P43RiO9FPmeqPSVOYcS2e46Led
         9Wt2DVvoetZW4W9pwWKaGU0zsmUrJBXFMA4zfZGaiP9u/oCWKPoMjXj6bLfQj+DWcYEe
         IwJsE1fldi5apwAi0eGks6vffFZcOw/yWjYtA+QJYCZRFLM+iVuCdoo5k/yfwO2ncLsj
         38/Km0wC8kzEBFZLYoKdJ/TsddSMhpYOivmlTxOP6M4WlvZLbY5T75kMieoKDO/ncqFg
         OQrnDK+dM8OCvM8E04rrSk8gpjAjDavLSfK2ePau6E4Zja3vozMA7tglVrwqF4AQXj2K
         b+PA==
X-Gm-Message-State: AOJu0YznuPft/i/bPl+PLgojF2FsCH5FGIhsWiaMdGe4bMbP6VPItQj2
	jzkxNnfXM3iOywoTNbIy8kTYzyvI0exkVcToEElI51OPdi90bw5FzMcA+R7q4+lyU8Y=
X-Gm-Gg: ASbGncvYpLiSqiufCs9PVmgJ/opxHbMMDrfZSOIhtQzvFu+bQkK9qaixojGYGGxSCCw
	w6ca8y/kWUuXS1qHl7zcApMp1qaJg28UjmEPqxb4wzD90PLAMUCUhHEgsO5Png985WRY1stVpM4
	v6INWBT7COQMDd+OAad+H8NeEfBmXOy6sK8w+BLc2TmTELUVAERD7Ld0Bl7PNKBYThJfWmVHadS
	S2SelFqQUKdTxNfrrAinw4iL5J7xFO8mvtLyWguLx6Ymnf1gzQLkQ5h0uRMPfQcM9l87ZxdSxjr
	U2lPrwLNzaBCYT9suCSEuzff52DM7MdaVGlqZ48M1NnU3r9XoBoTnkp1gUDIlw==
X-Google-Smtp-Source: AGHT+IFD0k4UsCEVC2zirL9XBuwJC9bJn7ZRPRnrwHUKdk9GoeqmEzrqlBnSm90RxmotUUUgj/M82Q==
X-Received: by 2002:a05:6402:24da:b0:602:7de0:b30f with SMTP id 4fb4d7f45d1cf-60fcc777704mr413409a12.16.1751575716251;
        Thu, 03 Jul 2025 13:48:36 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6640absm287325a12.12.2025.07.03.13.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 09/12] libbpf: Add bpf_stream_printk() macro
Date: Thu,  3 Jul 2025 13:48:15 -0700
Message-ID: <20250703204818.925464-10-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; h=from:subject; bh=gL3a1w00tHbFN//7/baKWBSmweu8nl29wylvHEKASbc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudM8csMLWyxEEz1sI8R/t9w5nZ75TaLrtDGeB0S 78GwnEWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnTAAKCRBM4MiGSL8RyrbSD/ 4pNVD73FcjA2O3rjQeqZfcGOkms0WAQbkHAy8FLu4F8a8A7Vdrae84aY2si0lRG9+LQZSeFFKi+edt Fn6wTcMKVpMuUwaiEBM83qz1A1zAI/7QQ0h4inyRdVAewhQNyKDmN/exghomw4eu50lB6BsTQBwZh/ RrAzwUQrkEmJTDoNpttN6sNKwfJ8C+SXNEOP+g9iKfdti+nrfYF5ZX2iO/sSDtPdH5xNgez3Jy8kFy Edh9UHGasg5ZiuhOkxLzinBlUszQmGRlxKNmwuwgV/wazlwyU7TAReLnfTOIs/YF/Kk8RKaHDz4SAE 0xG3sJ4k0VLX4rfA7WqHRtcnwukNePR6mvmir7zsUhFWhdOPDcYGvVlu4/j/FGyuqR4LHYL9R/bC5V rSvfKHsQ/rXaNkNVlyOKMOaBBw7Vyjn+2O9gKcd6tW2VjzQLVYwEBHsaCMZrU5PCVOVdIuxXJrGxRi oXrCbAqpPns0savB4QUEff/cbBhNOs7OGQq+k3ec0aijKgEfn6KSCRrB9PK5qEPVmFFvOmW90mTu3M 9oBwet0poFq+enqCzbhcQCL/PNjNONoYfs/D9vOZoZXgnsMAgPX6Ou1qK9XVPiI5/HW7Sc8IqMfg/q 40D57+YAUoiC3FWQG8HdOivS/vuxl0skVu7DYZt8UVCiWgIjau4Jrfnos3HA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a convenience macro to print data to the BPF streams. BPF_STDOUT and
BPF_STDERR stream IDs in the vmlinux.h can be passed to the macro to
print to the respective streams.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index a50773d4616e..76b127a9f24d 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -314,6 +314,22 @@ enum libbpf_tristate {
 			  ___param, sizeof(___param));		\
 })
 
+extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
+			      __u32 len__sz, void *aux__prog) __weak __ksym;
+
+#define bpf_stream_printk(stream_id, fmt, args...)				\
+({										\
+	static const char ___fmt[] = fmt;					\
+	unsigned long long ___param[___bpf_narg(args)];				\
+										\
+	_Pragma("GCC diagnostic push")						\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")			\
+	___bpf_fill(___param, args);						\
+	_Pragma("GCC diagnostic pop")						\
+										\
+	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param), NULL);\
+})
+
 /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
  * Otherwise use __bpf_vprintk
  */
-- 
2.47.1


