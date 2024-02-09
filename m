Return-Path: <bpf+bounces-21577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687784EEE1
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4FE1F236B8
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1FD1847;
	Fri,  9 Feb 2024 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLP81e0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC884A28
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446277; cv=none; b=YDYTsTn7+xvIRmha2guAjL693tCsxT2bXdizs6rvNwHArDPUmxVABIBPhhNPCC3j+HhNaFizkQt+QkmU8+MDphIoapsVxI4qNMnwRrbuJNdPHjH6/IfWVcKfnRVdxJuyhgg2/MTCLtbh2N3p5SbOoWFkU56807VU9k8OWrrGNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446277; c=relaxed/simple;
	bh=4UNGAiBlbIhXPVNFPusepQXSZLNoKdzsnPsjmEDsRNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qwMCkTQFlkJM2YFUun/uc71Pg2fB3iD80fIso6MJFPnQ/vgI9eMU9bvb6jjnh8jYe2voG+xuJPLVbD0qK0w6WZiwIBV5lOmPw1d3DwoCOSS1HZqQki4F3ftgfRIkRdwWcKZaWW5Vl1658F/mVA7D+DFX/zxiJNgK3NF+zZc2aAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLP81e0X; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-604966eaf6eso5474627b3.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 18:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707446275; x=1708051075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVXAYn+kBBkRE2GKj9qbQ7OXYLy6VKv4rz5z5iQMMZ8=;
        b=TLP81e0X9/DGNoAXIOOoXvl1Ovko0W+iRgziyW/nToManHiDaHVZFyfvw7UZ07R2f9
         lRtB+q6TDosrFZ0V4WH54+4t+cz801HmseptgFPMuxHxt+1TAwpji8GGAeTkH1tjg5Cx
         dz4lWOsIjhZPDvE3MAOYK56l9ytSCiZHvy1Aeo8OmTXtkiC8OClQ2PEtTtAEuATXH3OG
         K4LaibqKnH2Sx34CPtzr10kr/LHhk/fpN1e/tle0278mdzNDfGHL7yplk8KLtNmN5C1+
         lwOOjkD03EX+kCd+CRvNubo5S5T3IOPrLnr7pwvUTJEsnvg06EosC8qSlydXhmTw1Qmd
         t74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707446275; x=1708051075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVXAYn+kBBkRE2GKj9qbQ7OXYLy6VKv4rz5z5iQMMZ8=;
        b=NhHDUGWN1srjqBTEPdmym2g2+XUSGzMK3emQXIzBLxCyu8ExzT3+pZz5woPr4+obQd
         r92kCcz7M9mYO/isfpBLjXAy7LoVwzlUrBxhWE+BldMNjbyUU8rFyrA86z0O30fE0Edy
         ITCDjQBsK7EYsZ/exNirzXjxErMLCMa+PNwOX1JmBW+GYV0QCrC/9Gw405ifHu6J9+Hn
         wU/MQREHzpyGr8i2wZn9F7TTGkd6fs/P9+xs5yRFINcifFx7qqlMj+AOKLPNihK/bdBQ
         gUObB9dB9cPrikTsa5rMvka5Eob2zQgNioWTQrTRiLpPdsUPl53C/BUvwmye9ndoi4Nm
         lDdQ==
X-Gm-Message-State: AOJu0Yxblj909pVfKL2xMBXqrkkb/X+qTJXJaX3lQVcOyLBM3YH2pgMa
	1E0SwihulSBTcQVHFz+IlmZvq5xgfzW3AIiQxeaxqKb6CZGDqVr8abMiWeKUIQA=
X-Google-Smtp-Source: AGHT+IGMI0D7baPWdTse9G6b0cmxvr/4roQqYqhwu9xB0nsJ6AY859/RLZebMoxdSSj0aKr+SwG/AQ==
X-Received: by 2002:a0d:d90f:0:b0:604:96c8:652a with SMTP id b15-20020a0dd90f000000b0060496c8652amr311205ywe.24.1707446274936;
        Thu, 08 Feb 2024 18:37:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBO848ICTeZsbcuwnv8g4gmQTbtpb3P3HlY6sofOtdCjb/SKO8Hxxb3CgZvnvJgSkXXD39YihTf978gH3lg1exWfiMyxYa1+/2lcM3CAH4G44avYhPGKDl8dB6bjtQRtxnhsJ0Jq0bjhejh/OP+ny3z8Hwa+bh1DSQ8gZTT92VmsZ0HDq9mpeeFOIsjDI14p6cq3TttMSFW+gr8bGJDn54YLW5Vz6SP2iYdDJ0XetdJD9rzQF+8qfYpeSpWvtNHz22KzmuXN7l9NI5xEcGFO/nWLWCShINvievPg5/2m9Lagg=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id i2-20020a0df802000000b005ff846d1f1dsm144949ywf.134.2024.02.08.18.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:37:54 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v8 1/4] bpf: add btf pointer to struct bpf_ctx_arg_aux.
Date: Thu,  8 Feb 2024 18:37:47 -0800
Message-Id: <20240209023750.1153905-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209023750.1153905-1-thinker.li@gmail.com>
References: <20240209023750.1153905-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Enable the providers to use types defined in a module instead of in the
kernel (btf_vmlinux).

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/btf.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1ebbee1d648e..9a2ee9456989 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1416,6 +1416,7 @@ struct bpf_ctx_arg_aux {
 	u32 offset;
 	enum bpf_reg_type reg_type;
 	u32 btf_id;
+	struct btf *btf;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8e06d29961f1..7c6c9fefdbd6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6266,7 +6266,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			}
 
 			info->reg_type = ctx_arg_info->reg_type;
-			info->btf = btf_vmlinux;
+			info->btf = ctx_arg_info->btf ? ctx_arg_info->btf : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
 			return true;
 		}
-- 
2.34.1


