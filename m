Return-Path: <bpf+bounces-22206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB058858F29
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 12:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC6B1C21025
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32269DE6;
	Sat, 17 Feb 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USFtXrxr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DD1B7F6
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708170128; cv=none; b=ROymFF/xzX1Q2jX2XfXrCqUcRmxpGeqBNUXVQynCbxcMFpe0x/KgfwFG6w8DHxvm/V/H4jOpxbAtkI0cZvo9OrrCmA/Cv3QEhj3MktrL/IqBmvqfTC1dZSezpVGwmFfkevp9zZ8wGnCPPI5sYqKA8AiZC2NoG1UovAtloZsXN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708170128; c=relaxed/simple;
	bh=UYaKBGdBoCemQFpWQtWxvuILlxsTdGNWtG/C/2IhZIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBAOnOyEPVuGAwA72I8JhKX6Ec/b4OLjszGuZncNau+XMB0I+Q0dKlYduzUEWnWMQtFtXP8EFU80fYDbO7tsC0T21h9UG+n/sXbXlcDjjbgF9I8rsTeZEEr0LNfGE+HCjaikhKMkFBWnFw1bF9BcCGXBbCmwyXI3Pe+tA/wyO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USFtXrxr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d73066880eso27945875ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 03:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708170126; x=1708774926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHWPcVTnDwtDUKMBTkT9ukaWA+mMoJGUQ8CGQfJH/kg=;
        b=USFtXrxropiTaLcDNOpxgxOVCTLkhyCZNgbxdsxVYCGJvrUUnh9brz8cgGKWD3xX3j
         LpcGvxqGpn/vMxIOpEqlyXtxrv/VxFVJiFBU2l6QgxS0duFQ4pmxqnRUcD7UpOQi3sOO
         uP4bOUa7LGxP7fwnly9zzamjt9wRnvpIvX4hZrWobKgZqA/le9KYNcz6PYos36RzbD3A
         RMR/x8MwHu3elyDkYTaA/qL7aYrUQ0WDl5Yuxmke2leoZgE7EIPFmS+NWc+Hj5a267bX
         eoFu/M2tL+VUsIGsc8YCpznnBF6ZdN35v6xiFb3aI7oXHn9yYuU2TZ4ompbZsnD80EWp
         erog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708170126; x=1708774926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHWPcVTnDwtDUKMBTkT9ukaWA+mMoJGUQ8CGQfJH/kg=;
        b=R1RUBFIvNtuNG2lfxDzqyV1KQH5llfRT1OcsNRcRPKIA+wzjWNiqvqZlZFHyYmK0ri
         v6clz6M2LNQCETWec/CPK0a0fwrT47S/6X5HyaELcfii1F6t3tbbtpTDYCwXVVEDNNAF
         uACJpqhXJ8Rm5g1urfjqolb/TEFH9NOiBhj6w2KYU5mQgC+S5WCkPhzwH+GWq00OxJl9
         LQ2lL0CzupFKoMWhMcNDbxi2nCLsIhrJ5/0hZt45xowvFIBGpHx8th/sN3JmJ/1klUmJ
         yPapaxGChjN5JFrmQfuMcVqkD5Nd8PXN5bkAOAha0YTTPQAQ6w3HI9obGB5/Qs/R+H4a
         EsXA==
X-Gm-Message-State: AOJu0YzjEikyMagYiXgEDcJ6tbElNpdOjrT0yv2PqSaVVJBAjoQrwrzU
	InW0PhscTxcTRLi4TA+e0R5ei70No8BzXRo8JX+Lex8Axie4zbLt
X-Google-Smtp-Source: AGHT+IFlbRB9CvsUTlr8pgfVc/mCY0lIkPk0Ug+AHxDf+DoboXeN6KYWrQAIVTU7mfmZ/ugwn7iziA==
X-Received: by 2002:a17:903:2a90:b0:1da:933:fb39 with SMTP id lv16-20020a1709032a9000b001da0933fb39mr9415242plb.39.1708170126192;
        Sat, 17 Feb 2024 03:42:06 -0800 (PST)
Received: from localhost.localdomain ([39.144.45.19])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902f21400b001d8f6ae51aasm1307201plc.64.2024.02.17.03.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Feb 2024 03:42:05 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 bpf-next 1/2] bpf: Fix an issue due to uninitialized bpf_iter_task
Date: Sat, 17 Feb 2024 19:41:51 +0800
Message-Id: <20240217114152.1623-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240217114152.1623-1-laoar.shao@gmail.com>
References: <20240217114152.1623-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failure to initialize it->pos, coupled with the presence of an invalid
value in the flags variable, can lead to it->pos referencing an invalid
task, potentially resulting in a kernel panic. To mitigate this risk, it's
crucial to ensure proper initialization of it->pos to NULL.

Fixes: ac8148d957f5 ("bpf: bpf_iter_task_next: use next_task(kit->task) rather than next_task(kit->pos)")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 kernel/bpf/task_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index e5c3500443c6..ec4e97c61eef 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -978,6 +978,8 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
 					__alignof__(struct bpf_iter_task));
 
+	kit->pos = NULL;
+
 	switch (flags) {
 	case BPF_TASK_ITER_ALL_THREADS:
 	case BPF_TASK_ITER_ALL_PROCS:
-- 
2.39.1


