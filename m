Return-Path: <bpf+bounces-67280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD238B41E51
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 782957A55A9
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395032DCF65;
	Wed,  3 Sep 2025 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7Hbgzux"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0783D987
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901155; cv=none; b=dAgmB7Y5/1zPDN2cwGcH3PGhiy9Pu8VJF5ij2dfrbtk17sjDEEPHETWP3Zx+1WV2ibID4jhRxSG94Y9AxcQ4M4u8+l1s6wTYvaTvRx6rj+pysekELvS1VeQCZq3BXN+WASoOCvfy7R/b+oDT2zDFJxRsNr1mPtJAocDhALE6cJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901155; c=relaxed/simple;
	bh=VFZk1884jgS/DJq+nxygx0E7BGzvWbVuXGdUldrPvhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifGKKW8IJpDObSaD/ircXQ3ky8ZQZO15tdD42cxSE7NYqouFqUt5eiNfCgZlkGhnZxldSZKVIyIewHGd6VIeKkjSJRIPO03AYisveyLluf+tmvldSoO+shLloZHPXjXq1pQXHQ+wuNZet14lffdHrsTxt0j7yVr7S//oSMVwPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7Hbgzux; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so880828b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901154; x=1757505954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO2c+otpv3hSaUcvwB5pOaRyO079lesbP8vlGoLxfew=;
        b=K7HbgzuxyBiWT1gSw5jDz9rApc4ZT0Biyblgf37v9izjmI+QlFrMzYwO5B1QbJf4SJ
         o0JhgFuyrixwq5xfea9sGwje41lHHk0hGFM4cPDuoZfxoqFI0G9/7pxRfoTxY9BBWK6y
         cRC3WLQVXiw7jQc6w5XqHCmVvQ6lQENrW0EvA3eamsyc7HYt+jFAW6lr3Q/uobfK+SOq
         t2BbN0Yy/pVCGCfzHROPTkB/ncvO1Cqt8qxKaahMoNPYpDApxQORRzk21gohqjrL5iUi
         GFaEZpkapgYJnpVzo6KBtk5Ni3J9NFmUtdshnFOxNlzv26viNcKFKH5uUoztztUMnVkV
         pZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901154; x=1757505954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO2c+otpv3hSaUcvwB5pOaRyO079lesbP8vlGoLxfew=;
        b=VR8nIJTkUFJUITqdFOAVTa5tuYzhXgVl7YqOaWoLFzJlBbz7vZamAP2pmUtrAbuF0L
         UCGanblvKXjehPIF70gPT2sVuwa0ZfwQ9Ta+9DvnH3NvFWIyhgQTUPH8XGwapQje0iMt
         teRVuvATiD48Tuv8AFK0IOcu+IkN5vmou36/vlUY7XMxGRXT3/Hj+lzaD41yH6W4R3K4
         gUVBuWmi2MO4wfJOrYNobhbXHk9D7VFd/l+xpqFk9fLslh5eaOoRd4b5bqfFgT8PwjXH
         Q5NNdhRJylPGFNFKk37AsqjYc+maZHYPV4HoFOLTO94T58d7va+XmnE2iPSsx/SAjQJZ
         +g4g==
X-Forwarded-Encrypted: i=1; AJvYcCXMW+fbdWW9LTYGHuOW/xCLm+AUoKMzb2bkJ2PKbn4lKATymbBnXl70M7GqvIxak6WX0FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJv7CZFEIlymp3Nap1faOVLLyshkrCw/aihcaPM/KY9PuLut03
	0aJH/qP5/DShr0O1oE0AdrH7+3yCAKr0bAeHy+s8ryZambcpVydVVK2E
X-Gm-Gg: ASbGncvLS6zNiO3qxUU3rJKyQg6DGDq56UQH+UZEq7glPaJlaN5zV+CYkO7txdna2jA
	7VSoxuB5EKjnnXTwFe3PcSZGaKFDdVO6+o/AGVuFcb4wIkmO4YBfFaZF0heFxwBAJXW0vie+PEJ
	4533+hd+gxd2yAg+P7jkPEin4o6qW/JOg6tGeYkC9hv0CwWUeWUN7rbQvgR2LwCimpaGgyPOXfc
	4ISqklC0yv4UP2opDGIHPDJqIqOVrI+TXvlPLtLwv032l2vziR3DBBX5WRzhXVqsOjVSX1Hqu8N
	4colO80KVLqe52Itzkh6ISIr5pHEqCaKdoTo1W8nFOKR+TrDVZuiwT9XL/62YDjWRVvgO5bUKCN
	C2+iVyAsdUvdz9q3QJFcxBqYOIm0J0yNDEkpg8sA39Yfna1I80NE=
X-Google-Smtp-Source: AGHT+IHrJ5joBxmTb4YD16jo130hKukqegA4X1AEQIZM30v6N/u7zgRLj1F9dcj4A+efeg+h8tDtfQ==
X-Received: by 2002:a05:6a00:21c9:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-7723e3374d8mr18018803b3a.11.1756901153589;
        Wed, 03 Sep 2025 05:05:53 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16615899b3a.92.2025.09.03.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:05:53 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	hejinyang@loongson.cn
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 2/8] LoongArch: BPF: Remove duplicated bpf_flush_icache()
Date: Wed,  3 Sep 2025 07:01:07 +0000
Message-ID: <20250903070113.42215-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903070113.42215-1-hengqi.chen@gmail.com>
References: <20250903070113.42215-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_flush_icache() is called by bpf_arch_text_copy()
already. So remove it.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 77033947f1b2..9155f9e725a1 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1721,7 +1721,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 		goto out;
 	}
 
-	bpf_flush_icache(ro_image, ro_image_end);
 out:
 	kvfree(image);
 	return ret < 0 ? ret : size;
-- 
2.43.5


