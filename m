Return-Path: <bpf+bounces-44911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89D9CD4BF
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358FD1F226B5
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E344C8F;
	Fri, 15 Nov 2024 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="DPfL32rr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862A4F8A0
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631405; cv=none; b=BuZjW+wlY3U93gZ5WHo/89c+tuhU06N8Ze3UTQXt1sUZnG/1mpA6Q/t6UKHwvMZKq6FXPHdQE+CzsfNrpEWpd/M7XWgX3/E7Iic23Io1LdvnKHQiZ+uAJMw6Lq1E5qvp32oFUooa5WeAf4viuYzpvr/HQUKo53uYzyV0MYZWfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631405; c=relaxed/simple;
	bh=+leBIfGTx3qYqG0qr3EMc/+ailKE10I/dQRiyX0z0CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLN1bUD3DFLwtS9hRGdl/4g7yzYctfWEEm9ZBJnddaMruTBxwLVfiosPsR202CE4baPZIy426lutMNBxq1auQyn3/fN8i2oSfk0xzxNZcOOc8Xog4Jul1VKdTQTRrcPrNMJtFhQ0WeewUJyakoM/VJJCRxcLnZqRo9ElOrJexyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=DPfL32rr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so120611f8f.0
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1731631402; x=1732236202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G329gGS4RBx9EPCJNPCJhs4+g77tte1wqZgFhLBI2LE=;
        b=DPfL32rr/EP+Oq/VdWeQWRNkmZDeiM8eV7sw2V1dGHtKUY8G4ozMgMtzbsAF/TSjsk
         qqAfS9KNuDPzWMupbcarr4Y73mw82IoboldufakFwIA0G7nOXddlKqRTs5xVXJ+WN0sE
         ejwi9bKdR4HrFrWVGuu+1wfFrnBq4KQpQUGwqZPmiWgaoe2uSTS0cj08HwCumV4FSHBS
         +eSjvxHR6xIfQDhnqFIKqYfM7c5nB9QSP0rGxULUDAXwtmTrvJQuyoExwL2vA1Ys7Sh6
         8TDJz1w9IutXlpLDEAhMNK3gAmcqwCBCEvEE73Rn5fqjqLblFAfQ2ZyBZUF/nD8AZal4
         BVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631402; x=1732236202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G329gGS4RBx9EPCJNPCJhs4+g77tte1wqZgFhLBI2LE=;
        b=w4tE3rA/mae18X7qLIUc/8vTbvkAJG1sJL9t3s5nBIJV03XHhnhFVSnJ2WlTiIr+M+
         Pe2PWOaTQgioSQg+xYyoju0OLMopQzZVvYlk8sm8dCbPbTq1I4HcwfepCt/iwFd8iWfk
         ygGb7VqUYm43DZunaBTwFD6JJbbiRYQRW8Vx3DRvk4XuPpVxoaegTfwPSpnWsK0LyRmy
         oH16IXY0+ohRk79pguhDXHot1kcYy6xhWXimuOzHJuk1xLCirhH0VbhYq1nBMNi2Felp
         Yytg5uHsivKXKQnQdgcMRRiYgPd+PXGa+P/wVeUc9ZDz8lq4OAiFkxpN1uj6OjWcOsCZ
         BwoQ==
X-Gm-Message-State: AOJu0YwTj22TSDC5KAwnGfRH55aSUPqkW1sOeqz/yeaLFpRMYhMQu5JU
	Re29K2m4bTkUpeKPdJlLoRC28y/+zxM0svF/1kMUoMKlxoZBMGIDRuKjqMukK9ag1vv+VaUEDFB
	fZgM=
X-Google-Smtp-Source: AGHT+IGZ+NDCXZrcnuKyG16OR19KVrggceWJ991Sv5SI+7lDy3fsd0zjvB3Q3N1NXPo7pcVNoouKaw==
X-Received: by 2002:a5d:6d01:0:b0:37d:4d80:34ae with SMTP id ffacd0b85a97d-38225901fe2mr451606f8f.4.1731631402211;
        Thu, 14 Nov 2024 16:43:22 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78783sm36781975e9.12.2024.11.14.16.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 16:43:20 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next 5/5] bpf: fix potential error return
Date: Fri, 15 Nov 2024 00:46:07 +0000
Message-Id: <20241115004607.3144806-6-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115004607.3144806-1-aspsk@isovalent.com>
References: <20241115004607.3144806-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
error is a result of bpf_adj_branches(), and thus should be always 0
However, if for any reason it is not 0, then it will be converted to
boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
error value. Fix this by returning the original err after the WARN check.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 14d9288441f2..a15059918768 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -539,6 +539,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -546,7 +548,12 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 		sizeof(struct bpf_insn) * (prog->len - off - cnt));
 	prog->len -= cnt;
 
-	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
+	err = bpf_adj_branches(prog, off, off + cnt, off, false);
+	WARN_ON_ONCE(err);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
-- 
2.34.1


