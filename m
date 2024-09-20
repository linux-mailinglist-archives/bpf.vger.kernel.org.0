Return-Path: <bpf+bounces-40137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B53597D774
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C871F253B8
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723513D28A;
	Fri, 20 Sep 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg7gzb07"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166910E5;
	Fri, 20 Sep 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846272; cv=none; b=NMxuFssxSL0N9EU8erkW27u48qi99mjlvyTXDt5Sem2KqgRB2dPeM/RgrNEY48/HJ1y09tnkJ3zH0CIYWR5mJADJafovLqklldb+hj8lF0ndqpXx518KFDszVPWP81S1JkLNJRQDGPHFEBgEu5XSe2cH9ahFqc38R4QsgGueRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846272; c=relaxed/simple;
	bh=IhqzmrCAVaLbNPfFQSlXvHcZL1XBwRYgh7yR40B9I6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kn2MRofwn5JWS7hONRJsof1r1mfMNYj1Kdofs/RXMDC1TQ7FxkeJxBIqZdyhVd7HymJ0Obtvr4rAwPiy8eoG5pptzaLQ4RonI96ep7/ehR+3H8UrOXJDQ+xVl9mVeKB90mVca+w/E+N13nQc25mJ3Y0yycgLztnt9rAHiAnLy+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg7gzb07; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1446171a12.2;
        Fri, 20 Sep 2024 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726846270; x=1727451070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zc/acfT9kdgzhmkJk3mvwRHkKN76tDWkgF+Kd466Ixk=;
        b=Gg7gzb07hqogBJITJ/EqAlDAEl2lwRoghAcfA0cqvr+9CvU0O6NOQPVnUHKPNrscyq
         UV6+ij8jLcNn/TnZLq67GPzYMQ+irx86CVRYkd9qPeEBOnrUxCNBhzsjT050gZemPJm8
         UeZhFtzZIZj+430QfwHUT+dxZCjlqgLw/92uLdKX2tx6c/JTZtLIwb1LWKG+BgPObZra
         d8jRoZBcXG3WjfW1cZF3AZY1vsT/dV2zL/rReDrhdptLagfdt0bbIQtpicV6FblAt4A8
         U0Kd0eLOKAAMZjMRE+/HZ4weK2+lmY8Q5aLwJVULG8BFoNS++athrARAzvgcJ8kGqXSA
         8ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846270; x=1727451070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zc/acfT9kdgzhmkJk3mvwRHkKN76tDWkgF+Kd466Ixk=;
        b=GGVQbswKHIdi7It7O1wBhTDJ/6nbKJM4JZyzLBrk9nWdQq9YDdq1owhPD+F/6mlcby
         dgaAgSsmfH0/I5/F2fggg1WNag9tnKQ8ZDUSwpuq6UT9gYn1efsnDl1iJMe7j/OlGe9G
         6OZR3WrbczyphWzUnMByVd1B6i9/ZZn4wKwjxl1cFT04IElvxqnnV+iieS4u89UqJBvc
         /AwuXNmRF/XFJyzAX/dMcbIqho3tPzYriRoUPDOlTm64beayrxgNNxxRWXAS9zcG+JME
         51gQNnkngXjRCCVnsFLPI69cwHfEN333zlvLUNvyJ3Nh3pODo/d3LC6CtnTAaLlcLczJ
         If4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbkA57/7n6UPEq68VLCqG7Q++sRUBwCo7Do8+/uawJL8ZVcXHcxP2rmSoTlOi+y4ol9LT2aDVIfvTj6Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISltVExlyHMMtSf7CnbZcUH0tn1EeLMt/LXQqqjPF/1adOriK
	pJlfm/s/+XylkpLvT4YLi0XiMzviFmkuiKMKjrg/yG9uh2QCesJs
X-Google-Smtp-Source: AGHT+IHjpe779ClnZOTU5SO9V278H2pLnOi7zxNeBp9yEXdP658YfTZE9CXq4DHWdyh8M+/yj1coNQ==
X-Received: by 2002:a05:6a21:1690:b0:1cf:6c64:f924 with SMTP id adf61e73a8af0-1d30a9fb5aemr5328127637.38.1726846269968;
        Fri, 20 Sep 2024 08:31:09 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498f9eb2sm9543956a12.23.2024.09.20.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:31:09 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Simplify code with BPF_CALL_IMM
Date: Fri, 20 Sep 2024 23:30:50 +0800
Message-Id: <20240920153050.918697-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No logic changed, simplify code with BPF_CALL_IMM.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53d0556fbbf3..26fe57c79f93 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21157,7 +21157,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				func_id_name(insn->imm), insn->imm);
 			return -EFAULT;
 		}
-		insn->imm = fn->func - __bpf_call_base;
+		insn->imm = BPF_CALL_IMM(fn->func);
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
-- 
2.43.0


