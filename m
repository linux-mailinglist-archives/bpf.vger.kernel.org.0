Return-Path: <bpf+bounces-46060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3FD9E32C1
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 05:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11B5168766
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555317B421;
	Wed,  4 Dec 2024 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgI148Ds"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1017DFF1
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287691; cv=none; b=YbeFZP3jK1qMsQFmoLEZmc1Za+vPBlu5UoNjiL9lyYBYsqAdj/psvM91PD5a/Bu/bw3iw4BYZcTUmQRVd8W6VVm5MemzHGEkTabJqt4e/rErMyWeYSzwxyP1hOk5RvzXh+vMDJ3dud0dCxaHvFDQ7sUzLiLg2MkkcbKgIl+U8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287691; c=relaxed/simple;
	bh=fIdVvCp8XtB8F+IHAb9nnlPihgOV6rxupvpi/L+2WO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKn+nWg+l1/gxf3U0LPtFdyl+UOPv6/EFhSZj/k86jQMdyAlgUs+WhIyfhvq1UyJOFip4D5cxW8aZMYOi5+zVZEAwMuU0VOWQJZuyiOAFQjah2UD7VLvOyMoMrjfWBDOPNe7Fch1qaIzbTmiaZ4E6JKZQdU2qrHy09yqWkpV4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgI148Ds; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-385e35912f1so3088834f8f.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 20:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733287687; x=1733892487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2Ay3QJ3Mo5zqa0NBHsnx1xdDXUrE0nNz2CW93PKnwU=;
        b=YgI148DsoKkZ9EANr9cG3MlCsVADQ1hAPpq+bXMK5WCJMWxNFZUcpcrQk1H+g00wSv
         2MT8gWiFMMEdKKk/zmskMBAixG0WdGw7zUXJZqFXyW+ApiwL/iG6XSYjJi5PcO79atPD
         R0uCT5I9jrSMwZHRfVbmRQC4rnAG7c4efWsHVEK4r9L7chWBdS4gLLUe+QGbdQVZ6HpO
         Z6qjaHO7Qetd6EXI3+4Op4s/OqStrLywqlVFknDVX9u53IsxpeHc0EcZGpyCM7FUejyg
         3B+8RJ/SJr/8wP9RYJaK1WymZ76YQc8PEzTJ3WgWaKPVywy1Ze7EbmKsRkNba2pQiV0V
         3l9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733287687; x=1733892487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2Ay3QJ3Mo5zqa0NBHsnx1xdDXUrE0nNz2CW93PKnwU=;
        b=msjAuUqnIA2jviUXPbrQblerL3ZkUYIkFLST3Vs5GATl6ox6OMkhEJJyvQPZ/2Viwu
         QCQgrwtvB1z3Jyha3zXG0PLo8Lc1YPtrH/nenkiMdAVEaqdFMa9bo7TMwk2H6981ftF2
         KqlRZsMIfFGE7hs5/Y3Y/DzYrvFqgbVftvgCNJS+N912W33hlGG9akulCgzKr95+OiQZ
         2zmDWJ7+zxlxYHUVZzcQFrrzDHmuRtcoNpdMuT2bmp1ImWp5UfW64+CHMiBtonyJxeag
         O5/8kO3aoiIRGRUkd0FD5n9E7JKYQ8D1yz4b2Dw9SYNv1iilktkpXQvH4e2Qo8gPAFof
         uxpg==
X-Gm-Message-State: AOJu0Yx+rziYumTz4j+11b/G9YyH/cAS5yFuvAlHclf80vWX9+zRjUwf
	sa+sZk7ieMiCNw1VjOwSJUutnJ6+KTsqmBajhXTbUCwVP6XgP9U92ZCuw1tJoyM=
X-Gm-Gg: ASbGncvT07whSu//9PLuJyGKYMJC8yKCZYWtNj/Q2XpuB+vIWvEcqU1tA1NSI8cWnvL
	o2WhjH7hpR91Ysn6E4YrIM2CnGNG0q3zF0NJHNkAiaJJc9yesLfYSOsrqMC2d2og6p03KdAGNv8
	/85HN8907P0ZGz3paitLpE5ydbPi0ZSqh6BL02oFKpuqqDSlaP3ZDKvjQi7UZnKwzLx9cGDLzB5
	tivilV5aDyuOL3//sEs/AfySA6Ncoa3rBr1OY+YdV32vm0snfbLDd349CCApq5tm7hb1h1tc0lu
	aQ==
X-Google-Smtp-Source: AGHT+IHi/6znlU58w1axwSVRDO8qGJIosLMjrbjX3x5ls3mCTsdyephU1jTh9vjPE3mXBQLkyP6h4w==
X-Received: by 2002:a05:6000:4615:b0:385:e1f5:476f with SMTP id ffacd0b85a97d-385fd4212fdmr4108589f8f.39.1733287687082;
        Tue, 03 Dec 2024 20:48:07 -0800 (PST)
Received: from localhost (fwdproxy-cln-032.fbsv.net. [2a03:2880:31ff:20::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b131sm10177925e9.7.2024.12.03.20.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:48:06 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf v4 5/5] selftests/bpf: Add test for narrow spill into 64-bit spilled scalar
Date: Tue,  3 Dec 2024 20:47:57 -0800
Message-ID: <20241204044757.1483141-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204044757.1483141-1-memxor@gmail.com>
References: <20241204044757.1483141-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; h=from:subject; bh=fIdVvCp8XtB8F+IHAb9nnlPihgOV6rxupvpi/L+2WO8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT97GnopCmAv7kUneJsoLcXTYA6P18xAZiqdGP8mq RcjUSAWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/exgAKCRBM4MiGSL8Ryr96D/ 924rbJN7AINozWQjeAdvv5EQWl1F7OCJjo5NmxWXuu3JEvcJkvH1gWOnbfOFwmYJlOLHO+HMV1Sy/f BylPpmZKAxqfnnySt19KatMuWqw4Jd8/NQM78vK68PF+e7ygHLZ96j/efUfx7xDGeElDgJZZgNA3dL 3ZUoa0AuLJUAgE2EqEGKRqdMa3lEMAmB8PQ+ai0Lv72hZXxUYJnUnvhsrJpfd9iZ0NDcw+iQZveVGD sdVZGUIkdcaZjZHNfThAR2/bvSAB4Lo2SEFfcm6etgqBW+vC3NXED/TiJTDLtN2lzRaepctPkSwd1C lzoqYCgLtrhGd4ZFB8//JFk9j0e2ERRO2svhNUuXC38yXAeFXtmDAAGW5m9Dx3aP6+R6y8wMmz1vrk OigJgweLk4Az95P56pZv9TrRn7eeRr6yvgCtDTGIc9nSjA/vjUViQYOOIMptpxq4FAIPGpOmxGrotH /uPHOh5URiv14DYXfC6Q3rrpMf0bYTihrvKvLXDHF6gdWaHtW53BfKNnqaxAWTOqAIhwKJJ4350Tvs hygOm1pLLQ3RO1SJGwGXWlVFRR/2AlhSoeoIGfYv6uX8TQcoQPEVP79LmBJswC0YHAzgzGzz++F8Py a3m3LKtATFmx9NZtLWPrKqAGfmlOiNgHnJT+HZzCHApSvsTamPDFCMbma88g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a test case to verify that without CAP_PERFMON, the test now
succeeds instead of failing due to a verification error.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index bab6d789ba00..1e5a511e8494 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1262,4 +1262,21 @@ __naked void stack_noperfmon_reject_invalid_read(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("stack_noperfmon: narrow spill onto 64-bit scalar spilled slots")
+__success
+__caps_unpriv(CAP_BPF)
+__success_unpriv
+__naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
+{
+	asm volatile("					\
+	r0 = 0;						\
+	*(u64 *)(r10 - 8) = r0;				\
+	*(u32 *)(r10 - 8) = r0;				\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


