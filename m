Return-Path: <bpf+bounces-41862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83E899C9C3
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 14:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDFB1C227DD
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80819F489;
	Mon, 14 Oct 2024 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="MN7oRMhm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4819E806
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907928; cv=none; b=mjJ5V+9qD/dN0yvFd4IMn0ekddyOcv2jkFYTxOCYn6L1wC2W5aq4IvrLXiaK79Y8c3zSd+RjUmW3HSN1NeG7/eT/VPDJVXwjZUsi+5DCPHiGOx6WBY7AHUnCPdIh0Ztb5OsrT9b3Ase3iTbfPTGeqToshmUGqr7nATtxZR97wCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907928; c=relaxed/simple;
	bh=0vUGj6VytI8U/VBlpkbY+tbgleotP7rda2Bbue0tPWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dgNm448H4yWERGlolpEkNqCRz3Kgu375VIYSiyjNJm6CttqMtluMYWVTt+drmO49sOjenF/294nZJFEG/RAo5UhHkHRZYGAt2habc2JyG/kZvZmnzQ2juIgn8yw+ImgWVXF8ccozIfdMXHcNcNxCkQqa5Ni/90Z8SavOc0PFd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=MN7oRMhm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so290693366b.0
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1728907925; x=1729512725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqJqB6UsTIjcVrQdfvHzddz8jFNpy/xNoJsAQntNFjg=;
        b=MN7oRMhmlETRU7whdyR4Pk/wiO4rHMeWDKptRZz8G0Ry1n5VB6+BVxiIFj7x9HSNKF
         /lH02hf2OlR9yA7ojellDrsiywy/Kv5iSed0Vd2pSoCplq1f5A23uc+1YpyJUTcUQ0xe
         NCqYNPTXdLxbpDozeTMrV63/MzZy3MULIbrL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728907925; x=1729512725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqJqB6UsTIjcVrQdfvHzddz8jFNpy/xNoJsAQntNFjg=;
        b=m99S3YG3JsPX8oO9q3VWRC/QAqdK1YcdTpRyOvNBl9D7Ua74ZgFea3hfNawp8/8jZH
         4nHTKGd1aB3vUeyIc+Pv/eP4eIzXcb1ETIZK6hge9nduo1UaLPSCl8xclmJEvz5lEXYi
         7Bj8Iw5ApuW0qmODePTTali5x5wYrWmhQ0rFiWAt39F7R6SC6VK6DEwFCPfsmgbdA7e2
         WTW0UTRNswD4uI2vtNZPF5GI7fqebSzYkSiOXRsLjXvJlbGdkCuM5zkCfrGuPHIINy2B
         rS1preM/pOTSJyRlthvFD1xUa7vpoHUFgNMPqoNUBA7FOChpX9OQHLoa8atfmEpDz4YO
         yzxg==
X-Forwarded-Encrypted: i=1; AJvYcCXJMMpzJfUIZHVMUHg8QlMOLG6S1u4iPXT2vKcEjTc2ABq2ie2lweML6SVmyfFVMDY5zbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/CN1WAwg18ffndHPRXMFZB7HFtnUtAJiT8mYYQh/bmqSCmEw
	YwDVtOCYepde+DBznGN8WGF/74L/RjmUC7LdA5AdihrKkp8iVfx/fe0Qmp9XW/s=
X-Google-Smtp-Source: AGHT+IGxwwqCJZC5I2uutjcPeuhl1UdJ0hOjYW8APhkUHIKeAM0uxNta4/CDJrWyziS95ykmDpBhmw==
X-Received: by 2002:a17:907:3e96:b0:a99:6036:90a with SMTP id a640c23a62f3a-a99b93f9128mr940309166b.14.1728907925320;
        Mon, 14 Oct 2024 05:12:05 -0700 (PDT)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a1ac71a7fsm55293666b.15.2024.10.14.05.12.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 05:12:05 -0700 (PDT)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Zac Ecob <zacecob@protonmail.com>
Subject: [PATCH v2 1/3] bpf: Fix truncation bug in coerce_reg_to_size_sx()
Date: Mon, 14 Oct 2024 15:11:53 +0300
Message-Id: <20241014121155.92887-2-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
References: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

coerce_reg_to_size_sx() updates the register state after a sign-extension
operation. However, there's a bug in the assignment order of the unsigned
min/max values, leading to incorrect truncation:

  0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
  1: (57) r0 &= 1                       ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  2: (07) r0 += 254                     ; R0_w=scalar(smin=umin=smin32=umin32=254,smax=umax=smax32=umax32=255,var_off=(0xfe; 0x1))
  3: (bf) r0 = (s8)r0                   ; R0_w=scalar(smin=smin32=-2,smax=smax32=-1,umin=umin32=0xfffffffe,umax=0xffffffff,var_off=(0xfffffffffffffffe; 0x1))

In the current implementation, the unsigned 32-bit min/max values
(u32_min_value and u32_max_value) are assigned directly from the 64-bit
signed min/max values (s64_min and s64_max):

  reg->umin_value = reg->u32_min_value = s64_min;
  reg->umax_value = reg->u32_max_value = s64_max;

Due to the chain assigmnent, this is equivalent to:

  reg->u32_min_value = s64_min;  // Unintended truncation
  reg->umin_value = reg->u32_min_value;
  reg->u32_max_value = s64_max;  // Unintended truncation
  reg->umax_value = reg->u32_max_value;

Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Reported-by: Zac Ecob <zacecob@protonmail.com>
Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 kernel/bpf/verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d9b38ffd220..70a0cf0f1569 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6333,10 +6333,10 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 
 	/* both of s64_max/s64_min positive or negative */
 	if ((s64_max >= 0) == (s64_min >= 0)) {
-		reg->smin_value = reg->s32_min_value = s64_min;
-		reg->smax_value = reg->s32_max_value = s64_max;
-		reg->umin_value = reg->u32_min_value = s64_min;
-		reg->umax_value = reg->u32_max_value = s64_max;
+		reg->s32_min_value = reg->smin_value = s64_min;
+		reg->s32_max_value = reg->smax_value = s64_max;
+		reg->u32_min_value = reg->umin_value = s64_min;
+		reg->u32_max_value = reg->umax_value = s64_max;
 		reg->var_off = tnum_range(s64_min, s64_max);
 		return;
 	}
-- 
2.43.0


