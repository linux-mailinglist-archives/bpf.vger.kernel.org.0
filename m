Return-Path: <bpf+bounces-76614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 346A1CBED8B
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA717300C361
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B631B818;
	Mon, 15 Dec 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ycfhWZ8i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EC3090EB
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815223; cv=none; b=E2fkAq7s2SylULy/li9dTEXZlKLOHxi30twkNgSdPn8BYcNOPH46HRBJTgl59xgIO6j2D7LfW9wAOwjPznSo+RqZs/VZp3jvnHCSUJUCfFnkjbWsqplOyQkN+kgoWTZSCW1PYBqD7ZcL5T/XTMzy6XUBYVYZYvDagRcCHxlZWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815223; c=relaxed/simple;
	bh=hsAWPLjQC8qPB/nc51SY5+n8YCL6J/P9WQt9gWjZut4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jW/o7ijmmtRYuK0dQJFvy1irwYO+J4pYbU+RYSlvDUSyVOjqLk3fGw8W0IiIVdZxHrT3lcpfvXFIEi8pEg2o8XyaVYgRsM1fXgytNoi9ugrUf9rO07uK9LwoR1SziL1E0gGcNCfoGdhaMrL16KfCrpljewZRwQifARQOvPtGOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ycfhWZ8i; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b31a665ba5so448073685a.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 08:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765815219; x=1766420019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/mvpywVKx4oPRsDhTlYFwq1gn5Pf51ZxlF4MLTS7YY=;
        b=ycfhWZ8iNhfRS6xob2egcWHWDDl4NvGmwOROSO6xe26v8htk8CgzZarR0HCI7Mj9ek
         +M+N6WeR6FWr+gNyThHUFjdtlvkJp7YonMMbIV0xjfvm46PXRBF+onKfx1z94HXFxmVj
         fyeFtrgMnrhsSItTAW3c5OQIqrmD7lRuPA7m4VCao4HjN9ZZanLM7yAx/lybK3fgY4cV
         6/Gk/Xsng+MYKrBxoiXxgr5IwQzoX1Voe2VLPtMhIjGvn1UECRFHw1XJGAjWui4Cseyp
         hpA0XzU9eMorMIJcluImcD9X6yyAFqg6rrGA5OME5RjSVMQvzEbBbaycEiIlrcKMOXXI
         EJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815219; x=1766420019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/mvpywVKx4oPRsDhTlYFwq1gn5Pf51ZxlF4MLTS7YY=;
        b=uHEBuPtl9+hOmls9nQTuUts2kLWZcEueRMFbjJnYegFkc4kWelreAgMu5bdlWofCX1
         Jyc2zU48PHXBlTvzPZKcaVbLDoALX50WA8AZgoQCknMxltriRpK9EwG22wHSVaAvu8rP
         mGKU+T69e2YkIhIQctxxlcPIcCl28TVxvetHYSLrCCv4SHZHrL7IAccvXp9j1AAKrLJJ
         k1Yizmwlm/CrcgJfEYGVfnBotEigVi9W8viOi2brMCTSt8MbjedWgtWI5EUYryo9ow4y
         4+boTZLN5473n4NAWoCLVqgWppbrHVutZeJdon5AWRXZ+00M8D5nnpQSoZ4u5mU2NRLZ
         RNZg==
X-Gm-Message-State: AOJu0YyB07dkxjib0kT5rpNXdCGt1NffuU1ievNxr602T5GGrEg5V4CM
	V0HrARzxNXOztzX9UqfbmWZWwZ4tvderUlButVMv8U86vkBiqW6JD0glESB10RnDvpn1Sjj6AeU
	213x+
X-Gm-Gg: AY/fxX6SHWkjqYZgjRiz+xlp5CvfFXaFQy/PIsn13jLo8Dxe0wDlHR3HRxOFCePNYqV
	xwW8or+Ma9+h7LyS3Sge6OKkbU7h/eEb4lTGFh067D0nsRfnQaRtbUy8hNE/h7M4v1Nx9LoEhJB
	jBuwZLzPUlw4Ff8w/hcMxsRsVER8kgjvLb4vGPOAh+Z50fZ3jdT91m86hSVsF+VFYneyhm2wdhg
	eG3ywA4I2xCAv1+2TLv/gN5eyXV+uw/NoYJfIfcqcETLOqZSe9WHI/5jZdCB9alX0nkBoVWfuh3
	fQp/YIWk+1Zm3ZqG0sCWUpW2a99303roIaqqDwn89sWdbIQBxzJAC9S5p71noTxrB5pIrd0aqJS
	plubiF2nx91XJwG5ieJeEWFXdeY6uUCUx/mQi1cazindTWOEaB+E3FlikejELjKjKQTG1rsQCj+
	jvcPn6m86IXg==
X-Google-Smtp-Source: AGHT+IHG5J9v3/id6Xc/yqTrTJ+LsNU/AZeKfiSuvqMAW1vlGn4ZKk42GVagstaHPoNWBZDKplQFlw==
X-Received: by 2002:a05:620a:170b:b0:892:43af:ba4b with SMTP id af79cd13be357-8bb398e2708mr1723814485a.29.1765815216982;
        Mon, 15 Dec 2025 08:13:36 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3c85bsm1142195585a.26.2025.12.15.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:13:36 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 2/5] bpf/verifier: do not limit maximum direct offset into arena map
Date: Mon, 15 Dec 2025 11:13:10 -0500
Message-ID: <20251215161313.10120-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251215161313.10120-1-emil@etsalapatis.com>
References: <20251215161313.10120-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier currently limits direct offsets into a map to 512MiB
to avoid overflow during pointer arithmetic. However, this prevents
arena maps from using direct addressing instructions to access data
at the end of > 512MiB arena maps. This is necessary when moving
arena globals to the end of the arena instead of the front.

Refactor the verifier code to remove the offset calculation during
direct value access calculations. This is possible because the only
two map types that implement .map_direct_value_addr() are arrays and
arenas, and they both do their own internal checks to ensure the
offset is within bounds.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb7eca1025c3..dbb60d6bb73c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21136,11 +21136,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			} else {
 				u32 off = insn[1].imm;
 
-				if (off >= BPF_MAX_VAR_OFF) {
-					verbose(env, "direct value offset of %u is not allowed\n", off);
-					return -EINVAL;
-				}
-
 				if (!map->ops->map_direct_value_addr) {
 					verbose(env, "no direct value access support for this map type\n");
 					return -EINVAL;
-- 
2.49.0


