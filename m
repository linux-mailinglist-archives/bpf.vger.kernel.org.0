Return-Path: <bpf+bounces-21201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5984939D
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 06:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA93B1F23883
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 05:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFABA39;
	Mon,  5 Feb 2024 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQRUBouF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B47BA22
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112613; cv=none; b=tXD1SXpk6Oz9fXWky+tBpLp4HtJ864uiCERshD3uSxruP4EVyWEUjM3rDNFe4nR8fH8h+91hq33Rtsxj3fAoQX4OFBNHJh5FdIftaCm8tnk0vwcMG3Zq2WldbC8We1IhGMgFtoWH5WA+SymH6rCEEDTK+CCcDGX/cch5X3zmxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112613; c=relaxed/simple;
	bh=izf/2Br1SywPls5d/eso9728cVQxXGhwEd0AVvcYmA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAvDN1uaCG9uEXYTX/7sgnjAVjbClISsvQMDIGhab/LE0ol+d3ftLZ62Tos37oWbD7OjXGIkcVtRUrcHQd+wVA3jxGfciFzEEvGHAlYQ1g1CrRcxgWfR18exIb/5lrE7BtmOeM3Xpq2hFCKqZ4NIBjRI0vrPc5Mf6fE3N8ZwcVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQRUBouF; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5606f2107ebso606825a12.1
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 21:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707112610; x=1707717410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr05milfNRiA7y5yelFNvnWvkanfWghTvjzm1/74DEY=;
        b=kQRUBouF5fj454J3MjrgnSCk+B/cw3t5Z0DPYeQ9yCMpWHJNzLe/QnsYX+MdU28paU
         E0m8b7ePJ1TR8Tn0OPbsXevZHxd5qrT7t7x9+rVJFY7o12c3B6jShfsAEd/pCilZmRvW
         QRpNH9EvEqEaGkMN9lVduZdMdRoK+2Z9GI+VLt4jn7lDIp6aFANJG27USD+F1/PdHXdc
         FIxaSC69ul4l/nG/LIwo3YPZA3jFx/IIqzq/AKq0uaVKzwLC7T71tna3diHULJIEmLBI
         AQGq1Z776jYGfhBFVj1rxeLk0IpLMMbgSAyaNBUi/RwmPxCKOQjmRD/Pxe7NWlsIgjW8
         j3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707112610; x=1707717410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cr05milfNRiA7y5yelFNvnWvkanfWghTvjzm1/74DEY=;
        b=rWsLznMIPSnTst1tcbF6SnqJ1KkxcTKFuLlwj5Ul4w1pEzLBx942/pGotwwkw4OtzC
         nFgxWekUKvSZZH4c678CTpiA3uK+FIpdMmRgGTpcRcRaPIFKachU9k9XHQPNAGderLe0
         F3Q8eEt1Wx/5Mhg74b+PelUQUIh8QeQLXZ3+baLLtuzbu6iTiohC+zpfT7eqavd1QgTD
         s0PN1RLA4wqB2LD78fCY68/wQLIah3fmgvI6en6GIasmwYckuTfiM1IDcTj2XiJhVVyz
         IWGzbR3A5YiXI7LjCM9XKfu4ooARb/7Fn0X288OMtGymFMKW/I/vH44dzSvX4PtNT7Aj
         DmbA==
X-Gm-Message-State: AOJu0YwX0Aauvbd5VcxogHJ1CTa9Nkg4xSOij6OBVg+NVC4tzGMdFdOI
	urlk6ZP9tmqPMHIA6TczKNmozwYqXMWlELRoQdFRSUcUWNn3oLg4JAKvtI92NIA=
X-Google-Smtp-Source: AGHT+IE5hBXa2yOTHpQve+0PQk9UVdR8Xfed/XYuYX410AnXMAQOPOWw8MlbcxzxLc3/1+2XsB2aNw==
X-Received: by 2002:a17:906:2b12:b0:a37:e824:e3ca with SMTP id a18-20020a1709062b1200b00a37e824e3camr33846ejg.0.1707112609586;
        Sun, 04 Feb 2024 21:56:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXy35YhkT8LYyp4Bs69rOeixhhzvHRnREn4+T6ZMIuvTYCN8K43KAbmPEkcp13ZJGgWrxqIc8L6tsA8FlYTSnAoxIQ0YqGBZJEdfBSPc1tsegHTMgo9dEllQ10r+7A9/C84aK0PGNZAXy46hN0aH0g3WSmmW14DwfIbquE3plVoema8B3Ydp2DsMGmQG5/ou080CGthTRW7uGWW1LOt5o1JBrEVFSnS2OfRiZduGTRb19af1M9qj1T9RkmU2A==
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a373202928bsm3015546ejc.8.2024.02.04.21.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 21:56:48 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: David Vernet <void@manifault.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 1/2] bpf: Transfer RCU lock state between subprog calls
Date: Mon,  5 Feb 2024 05:56:45 +0000
Message-Id: <20240205055646.1112186-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205055646.1112186-1-memxor@gmail.com>
References: <20240205055646.1112186-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=memxor@gmail.com; h=from:subject; bh=izf/2Br1SywPls5d/eso9728cVQxXGhwEd0AVvcYmA4=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlwHiNPtxb8cuSGU9VzIY9AP1Nia5hm4t5GsD0O mFE42lkOGiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZcB4jQAKCRBM4MiGSL8R ygK5EACTYfhivHUDWZFamwoO4fIv0ptKrpiBto08wsS4WURUdkTK3A0jT4aop93Xle8IMmWj7dW AfbxEkrszNx7fZzmK5vkvVkW5VmUyD6DITsbYngLB53KO5/wU3pFa06m8zhm43MDhmb04TgG5pD 95G8e1sYU9KGpePVcDI1KGrGZ1MJ3wtQj/GoRznD0853OppQkH9J2X6A5oU3byL7gXpTdtdhKOp H7g4qj0RYWxYDINn8BsoAlEbGRRegSHa9t3LVoL8P9R9IYGFIbPrX6eSS6ZfIqocI4sZHKreJAp 4j/aFQr8bdFtAw8e5STHqYoXDiFv8GMkxlJzVRLXhYg0B4fTM8B3+YFSrV0yVtghDR8CuVcEUwz a8ihThuxx/wzomHX2rBYF3NduCYUr9aAmx+H85aJRYs+/JgLtxbu4470LN38H1zqUKft4g2aJpQ nI6SGtR0GejADxM+RMQQHBSLUtwdQioojjAbTBTWHfMswvUMg6YTgCWrPYMGOvCRZ+SZzo2UW7D 8IW3rR/JE7jyjGXgPj4+KjSed0WVPoh3TdEYoKsBCj8DnJt+9jlbHx5AOKvKLwaGphNXgdyxsfT SSv7eIjwLZH15rSMCMyCPHzeQhDu54Gb1rd9Y3/zJz6Ll8zozzBcz3vdlszI+TOyJyK39tHWm8Q 7V5EXiM70A4bXJQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Allow transferring an imbalanced RCU lock state between subprog calls
during verification. This allows patterns where a subprog call returns
with an RCU lock held, or a subprog call releases an RCU lock held by
the caller. Currently, the verifier would end up complaining if the RCU
lock is not released when processing an exit from a subprog, which is
non-ideal if its execution is supposed to be enclosed in an RCU read
section of the caller.

Instead, simply only check whether we are processing exit for frame#0
and do not complain on an active RCU lock otherwise. We only need to
update the check when processing BPF_EXIT insn, as copy_verifier_state
is already set up to do the right thing.

Suggested-by: David Vernet <void@manifault.com>
Tested-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64fa188d00ad..993712b9996b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17698,8 +17698,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_rcu_lock &&
-				    !in_rbtree_lock_required_cb(env)) {
+				if (env->cur_state->active_rcu_lock && !env->cur_state->curframe) {
 					verbose(env, "bpf_rcu_read_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.40.1


