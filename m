Return-Path: <bpf+bounces-60464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19529AD719D
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A1716A508
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58833256C80;
	Thu, 12 Jun 2025 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV5OY+s3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F856242D63;
	Thu, 12 Jun 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734338; cv=none; b=BpIViQZOix8qosAumb92KAsUKFAemdI8Of0PRwfHYigQzYyGvQU62qUedH+MDi7SDnneJiigYDWdzmNhSiCFYQ58CbAh7zHnA0Y/Nwka2Aw/OnY5ZYLRh28PlgaREQVRzuiPIVzoWga46136rMsUkrdPG7wo/ToPGwRN0f5szxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734338; c=relaxed/simple;
	bh=Onvkn72qbpv6WHAGIv34zbp4AdrM6BtWd6jUL+NK4Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8v3/q9P7A4AhzvNWbSNeE2UYCSNup9ibEBFmGlQRJDyGl5ymOerav3xoqkrOPMpndmf5u067KCV3H3zVbQh34DLBSuEySbX3ZAmJY2aIMdqY79qYpL1W89JObNb9ZTxHp42kg83VNmkSzS3KPDSp9S98y/GqaLQSoaFJ9y3UZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV5OY+s3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607ea238c37so2108288a12.2;
        Thu, 12 Jun 2025 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749734335; x=1750339135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2W6MiZfLRhlv/hbI5L0U2xNDEqKtD2PvAaiIWWuBOf4=;
        b=KV5OY+s3QiLEwb8DR5P/CtH/COzcwk2goo1I6iXoFC3YS5uSPaXzWBsAGaLHi37Tl2
         frAz5Si8rmgBwbv0e6o3jOGs6u2cOtgJhXbL0ifxIi6zwrbScMYqdGMr7y2tyZFc3w0g
         U7RTVEbACrTkjuKhPO1ehId+FdhH0k7VPSeHRP0CDtLJugvFOoxW4Jfd4oYOujk1KbsO
         3uW3vewyoEZiMNY7YcR8GQMXvW6F5aK77kxyo+P2NPqFCBWsEFMydQ2NEl/R8Jl5bHwP
         Ay1zG2JmiwvahTY+1wuFc65AF3fEpDlGbcV8pZyH7KdzdOUKKSCGRkzwo9AOGoVxbf5j
         rPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749734335; x=1750339135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2W6MiZfLRhlv/hbI5L0U2xNDEqKtD2PvAaiIWWuBOf4=;
        b=RUIve/UA/5Db/BNsMYs5iPxUd9E2xxqRRk/U+sP34FWZEgD8IMlEK5krFygCanwB1U
         CRaq8S7dae7nCHDwWmW+4eSuyJPG9mTR1yH0FI4H8RVn95qH7UcEcPcNZECYGiABONCt
         3z1ffVrjSmLWdH3sKTLfB6B9Al6NCe1qb0JqXkSQwVXs4oJefwDcmHlPQ5frPta+KYl8
         owI8rjDl6CuQnBcc0neafxeM640bVZ61cLD9o0WFYSYA2sLpSLlvwKIjOi9X4soVhRYF
         wjkdL0gbeqWUXyoghEt7Ji9wocsGwFcFrO39gJpV0UoS6XStQauYkFn6XBkbsXSpgdLs
         k8iQ==
X-Gm-Message-State: AOJu0YzEBenLcR0kOqSE6mL8nO5rPh/yEqn9Lk1kPZFb9+98vfCD1cXC
	R+S4nnSyfGfVz00BOUYbWotLG0gyZVDizaijpeX86BW+1vxnu9lELZ++7S5w2XQlxjU=
X-Gm-Gg: ASbGncva5ftD2iiZ5wJPn+v+6fLe6w/hXSy8MqohlJJG4RGZl9kVQs5ulHN5w++x2xg
	IltYrpcz75tSMOFIKgChcoQAATZ0luJa1Xyd0bmrtBcazrmoo876pKQ1JWZavDFX/qOK0kwZ9DD
	ucCtCdABDjFEuJr6c9+kbfppWMm1bD36pSOYBRkzYdRGKRM7X1NlR79RhWRBXC+qSQHqa4qxaq1
	yY43gJTSuTTMqh8YfTBuFTOZ4gj9lCYqFpjGl/9m3BQ8a2cc4OG7T+U8CcjQevo/bWD+RQOX8wN
	FGb9U8r6rH90rvALa0jfad4gpGPvIARaf+LmlcBpIZ27TDCV5Oe6gCPZYzU3UW4+dgxKx/83lrj
	6R6D/4b11nqB89KkN9W0cMhU=
X-Google-Smtp-Source: AGHT+IF31AIAPCEMcqDEWRQPWUUUfzg6uyT6KgJrI4JjoCX+hz+MfDKC4P7wni5DqpZXX62qMU58oQ==
X-Received: by 2002:a05:6402:27c8:b0:602:29e0:5e2f with SMTP id 4fb4d7f45d1cf-60846acea9amr6706630a12.10.1749734334875;
        Thu, 12 Jun 2025 06:18:54 -0700 (PDT)
Received: from localhost.localdomain ([91.242.54.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6088c83526asm842171a12.81.2025.06.12.06.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 06:18:54 -0700 (PDT)
From: Ruslan Semchenko <uncleruc2075@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	Ruslan Semchenko <uncleruc2075@gmail.com>
Subject: [PATCH] potential negative index dereference fix in get_exec_path()
Date: Thu, 12 Jun 2025 16:18:16 +0300
Message-ID: <20250612131816.1870-1-uncleruc2075@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If readlink() fails, len will be -1, which can cause negative indexing
and undefined behavior. This patch ensures that len is set to 0 on
readlink failure, preventing such issues.

Signed-off-by: Ruslan Semchenko <uncleruc2075@gmail.com>
---
 tools/bpf/bpf_jit_disasm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpf_jit_disasm.c b/tools/bpf/bpf_jit_disasm.c
index 1baee9e2aba9..5ab8f80e2834 100644
--- a/tools/bpf/bpf_jit_disasm.c
+++ b/tools/bpf/bpf_jit_disasm.c
@@ -45,6 +45,8 @@ static void get_exec_path(char *tpath, size_t size)
 	assert(path);
 
 	len = readlink(path, tpath, size);
+	if (len < 0)
+		len = 0;
 	tpath[len] = 0;
 
 	free(path);
-- 
2.49.0


