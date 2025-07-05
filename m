Return-Path: <bpf+bounces-62466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6380AF9E63
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 07:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A19D4A6D3D
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 05:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A8273D7C;
	Sat,  5 Jul 2025 05:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTqg1+pU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023DBAD4B
	for <bpf@vger.kernel.org>; Sat,  5 Jul 2025 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751693445; cv=none; b=ULCY5qfz0oHfP07MnVcjIY4xvlozSOWav0DGSi9lR8OJGMjo2AisjOF/20g0l3ZZJLwi3SVyFqwmvs3O4icZDJstV/ogAuAwIRRmsyXiw2yd7mm4UGbcFEKF5jVgcWEK3VPv3ds/MTxJ6W1469osJQiPfS1HIEAb4FzLOCSM3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751693445; c=relaxed/simple;
	bh=TrPhT9RFra9ViBD0CbZOUNZLybQDqepOmP4yk7v9jJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtpiuNwyuhf4+FwGl4D/HJ1/yJobDjJnCMzHhO3xFI0zP9DRYSg2SCJQvrf4Fu4U3WrlrhZFduDMPQaNEX6d2sFEcYhmmAljj/qUWqjxYE2q9O8IR6Rj20zjQ7YvW60oNunf0/XYTesNPyWcOfaZQyjkwBQYAvIkMe8TpnPvOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTqg1+pU; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso2818659a12.2
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751693442; x=1752298242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HudLyhn1FGlvNEfabQRL9sFov3wQH5xFrIk9C+FbbX8=;
        b=HTqg1+pU4s0Roh77t5NILaQTbKhO7DF/aT6+sXYvev8nU6QtLBD7MhXt5jfjVYuYbA
         gI6lFjww06wOFZTRWqTIVal/Rlmp8YBbEcaKD43oGRrw9BHpDJ8XHSsL1T/ywAH9hd4F
         nTofyVyr05KZcDsVDMfznQhj+HODnh1ohvj2SqvAUdZhDDjvuxS8ssczqvezCMwgeTA6
         L5NfIy9ZI3+T5nXAf5BGioqzZD6Ivl38unZQD6+8DbfqihX+aQ1wLYkZP6+1o4KRZCgs
         w7CiMxJIOBfXqb/dMx9mr5t2Ux4SCu94TZgOLKo1JiHb1RXcg1FdfR8pMBTffvoTCSWt
         djGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751693442; x=1752298242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HudLyhn1FGlvNEfabQRL9sFov3wQH5xFrIk9C+FbbX8=;
        b=snANlxr8eF1Rcj77b8U3YN2NDZZhgYtDhKhlg3YlR6EyuxGWH7slug7j1VnCwsPynD
         qKJ+phGaDC55hkj33n/w+8yZ1hHU9BAu5pIPqngFcWTKUHHAX3VZ0Yj1n1UniRZx2C7T
         Qc7gH/BNIigY/h1kR2p5hovWeA96vzuN9zqWM9xVEZRWTtfgnJ9J26BZq505Q33hk31e
         v9RKYNHXphs431sxQWaiGNt8M4ekgIKUW3ikjzN3W2BbuUDyPyIjZDCbozaZepRfxFeG
         AFiH96tSYDOxMn7Z0Rl5FIG5lY/yhuVteUi0oDVlvVDcvL0egVPupzflDNeXYI8Vx1+j
         L4OA==
X-Gm-Message-State: AOJu0YxrvfnKUQ8YaA4WiLDORBLLMEVoAcs88Q2Sh28mnV232wfW1tOA
	sjxJvhdmx8joC1N2JGZS5ZFMKapnijlS87Jqkvocxbv347UPkRqaR9gkRB9vSLlIyq8=
X-Gm-Gg: ASbGncvklqPSCJhTtpkdFix5hH3Fl54rHubjNdW9f1aaxf2bqEEcRpAPQRzcnLHZy2y
	Jf2NrCMVq7hAPxzrAr6gA2044dl1sdAQ8LcIgoIgAK3+9ASZXqIgPyftvshQq4NNwWldVMRbOYc
	FMWXv1ATagE+Zi04tbgwLDsrp5JIZcH3Jda4pk+1Ecc5WX2k7npUYj1g/CPOYZTGO5cCaFQD/HE
	aX0QlwOa7sMYYtUTpbHtHtgSKRls73a/xt7CrwSy+8hsA7Mh3PcVdWYZRUKlABGEXx9enkpG3fl
	c2Tl4p+Wn4PjXcLsRKMa4/ULcbCBbClXIpcvk5MJ4z/KYPM94rT59eGoLb7X2vtt0oE/1sdT
X-Google-Smtp-Source: AGHT+IEunoNRCgDKmiT+oA62ExFxcFWZZ7Zwzyg8Mk5Zln0tdvXeq/CBT49e1VRu9vrtggHxgOIoDQ==
X-Received: by 2002:aa7:c499:0:b0:60e:404:a907 with SMTP id 4fb4d7f45d1cf-60ff3e21514mr691249a12.29.1751693441785;
        Fri, 04 Jul 2025 22:30:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6676a2sm2141684a12.5.2025.07.04.22.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 22:30:41 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Fix bounds for bpf_prog_get_file_line linfo loop
Date: Fri,  4 Jul 2025 22:30:34 -0700
Message-ID: <20250705053035.3020320-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250705053035.3020320-1-memxor@gmail.com>
References: <20250705053035.3020320-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; h=from:subject; bh=TrPhT9RFra9ViBD0CbZOUNZLybQDqepOmP4yk7v9jJI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoaLO6TI7M0g2d9lQyxdAf5jXMkfFj74lcY7lS/cSM MVLDuKOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGizugAKCRBM4MiGSL8RyqpGD/ 4gxHDeTv9/bO/sysKqFS0Bmr3yz1RVCfVQDQs/fkJxiaTnt/x/Aua+Pn/9IKnM6xkz9fp7fu9MOuuv Yim76UgF+8vDeuGRXct/b8UVzZFXJYPih8u+290foie13fPn+WPqawYyTkkBkY7HRZE7WqgXw9gvUU bpCGl5kACrSato91KjChVWghfCvHZofDEWcdAogXUdI3c4HRdZFkhjZK6ifHTdNj5rlrVY5Fs0U4uc DHoaKQcIyrZ0oAwVShWZYpflHi/hkPqqzizNKpR1S76SG/8yc7VZkuTlihYZHrMuOJMQ9EkAGtAdut 2UT1OX+BSDL7041dxgX53x7onUUHvrQnTVrs5/WPlD3gvjI4TU4q1jYgWFS+aU/O27TsQAuVj7FIAI GYsaBhvj/ri1DPnHgBto85GjQ8sGGMW8dgn+QvS3ykuRfstUmDE4AHieHQFF2Wjhm0hUfvrWrI4Rh4 UNa6uymDrrkdWHGipXpS40EyDS5isL0nrEr/sFfekSwTZt7aE4x1WNgTWdNZJbnAwCHAtx6rza55L6 HVPEbIuoGgJSNPtP8V1PrIaPJ02xPV+y6XURPW96TUxRtnKoPwpRY+rhSk141aQTRG1cQwSF8yH5WW Y4+utkEAhSu3Pv2YKaPi9lDj7Nx6qxCaeUSqeSH8o8wqiXIxZ01iFGDWU6DA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

We may overrun the bounds because linfo and jited_linfo are already
advanced to prog->aux->linfo_idx, hence we must only iterate the
remaining elements until we reach prog->aux->nr_linfo. Adjust the
nr_linfo calculation to fix this. Reported in [0].

  [0]: https://lore.kernel.org/bpf/f3527af3b0620ce36e299e97e7532d2555018de2.camel@gmail.com

Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Fixes: 0e521efaf363 ("bpf: Add function to extract program source info")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fe8a53f3c5bc..61613785bdd0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3244,6 +3244,7 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 	struct bpf_line_info *linfo;
 	void **jited_linfo;
 	struct btf *btf;
+	int nr_linfo;
 
 	btf = prog->aux->btf;
 	linfo = prog->aux->linfo;
@@ -3258,8 +3259,9 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 
 	insn_start = linfo[0].insn_off;
 	insn_end = insn_start + len;
+	nr_linfo = prog->aux->nr_linfo - prog->aux->linfo_idx;
 
-	for (int i = 0; i < prog->aux->nr_linfo &&
+	for (int i = 0; i < nr_linfo &&
 	     linfo[i].insn_off >= insn_start && linfo[i].insn_off < insn_end; i++) {
 		if (jited_linfo[i] >= (void *)ip)
 			break;
-- 
2.47.1


