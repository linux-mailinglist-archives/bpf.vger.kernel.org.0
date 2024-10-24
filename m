Return-Path: <bpf+bounces-43090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23E79AF363
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EC51F23209
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE975216A1D;
	Thu, 24 Oct 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IojU1fH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC31FF02C
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800814; cv=none; b=bytGuSWUCKt+DbaMg7eAn8LdJ6I6nAn4qLVQ05LinIra4BpnvfHjhMIQGsmrtI/YfAqvGTz0ukr2xzLI9LLLvO/wnLowjRFbr033am5qBTRx2M7P78aIt7sYZrlPh4F6Hwvz5f58OX+1WcOlY7D5YPKLtcWnDk2DubipIrgbA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800814; c=relaxed/simple;
	bh=iAsEXIk9lZDLgN0DGbxM4NFohQ2UJ057gn8Noe9P1pM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHg/9wBzFg8Ju1ThVctZ5tqRbAy05D2zzNeUmBMwUvNcQEq4zyx4mVcvPjqeI15RXuQYWYEuI8NWZr42WzKAoAH9E7/Tgw1rKmZ12zMuCENN2RgkL4dU3JhiZX+iWlH9zHcE7aEIvBVViHweuZslpTMETU96mU8m781dObQ4QZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IojU1fH5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1418058bbso83855785a.3
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729800811; x=1730405611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6aRUbO2DFgQjmBeV68T/FRJXd7JIVcxWlH9nZ0+GBY=;
        b=IojU1fH5ykSgVwqdse7x4TtiAqZxlu+zAvS9ZqaLQOcJdPUy5MySmFgLMhEv/zeZjr
         QiYCLCDLacFBpY+SF0tJduAFkbjpNx7fA/xJgmr5B7jtq1+Z987NXw2XY8c3wdVYp6kd
         qB8i5YUWkwcB4W1c1qGb0f2AJ3OYa2luciu4VS/5tbzCXqZh0UqIaQ8oP3ADMh+cYP0v
         3aOa4O6Zk8kIlYO+oUkl2flfzvv5goXb35Ml5PgvGD0O8vOYKA2fkI4dNeYamYDhQUEe
         0UyMksyxmOvzlcknIaS1ENAOkM2IOzKN0XPJXTCVvNoaMHmPBJExYvkwvDIEaa0SOR6z
         EWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800811; x=1730405611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6aRUbO2DFgQjmBeV68T/FRJXd7JIVcxWlH9nZ0+GBY=;
        b=M+GzyqWj8J3lBWXErSIeSQN3QbzhDWt1wc3FdxWX9TbvqozPjNAuo1OvxbqSu6B+/2
         8kkDISOozBXV6hOWfFn8n7IjjA3B4e8EfiqQ5hzQD99FDhOXMFXgTUN2ZpripE0T+MP7
         axFnsnIcinMhMLZj2ztYMaaM9ajn3JxCtA0rFEP5QftKCVkgAf6sqUfICWoe2eYOjS1B
         T93ci6P1ldnKqp6VYywyRq3STyFHKIY1Szw4z6IqEquzFTKg4+ipafhswDGqBubEV2lO
         ld0icHnGbBpiAmuA658W7ljLqFLbk81pXqlpucO4mR6tIoXz5AoVfJUQG+E8NLWmVCjr
         RslA==
X-Gm-Message-State: AOJu0YxIRoXEmHlO/bAei/sJqrWUm/QWYaf53S4DedKkU3XQNlQqr0AV
	TpnqEM2dqtSyO3wneZKiM3txqWMzqPf5w2fFshAhHQkW59lar5HIIMOUlueJn3jsq5wBYUmQR61
	V
X-Google-Smtp-Source: AGHT+IGKFKOvY6/7Fmlgte3Td80ujf/GrIhJW5WPVD6rsS/CUGo3vyKq1t5YoUnb6KJsAIZ9uH8ytA==
X-Received: by 2002:a05:620a:4453:b0:7a9:b268:3655 with SMTP id af79cd13be357-7b17e5ac8camr1098596485a.43.1729800811055;
        Thu, 24 Oct 2024 13:13:31 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm518952785a.60.2024.10.24.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:13:30 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	zijianzhang@bytedance.com,
	cong.wang@bytedance.com
Subject: [PATCH v2 bpf-next/net 7/8] bpf, sockmap: Several fixes to bpf_msg_pop_data
Date: Thu, 24 Oct 2024 20:13:05 +0000
Message-Id: <20241024201306.3429177-8-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024201306.3429177-1-zijianzhang@bytedance.com>
References: <20241024201306.3429177-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Several fixes to bpf_msg_pop_data,
1. In sk_msg_shift_left, we should put_page
2. if (len == 0), return early is better
3. pop the entire sk_msg (last == msg->sg.size) should be supported
4. Fix for the value of variable "a"
5. In sk_msg_shift_left, after shifting, i has already pointed to the next
element. Addtional sk_msg_iter_var_next may result in BUG.

Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 net/core/filter.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4fae427aa5ca..fba445b96de8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2919,8 +2919,10 @@ static const struct bpf_func_proto bpf_msg_push_data_proto = {
 
 static void sk_msg_shift_left(struct sk_msg *msg, int i)
 {
+	struct scatterlist *sge = sk_msg_elem(msg, i);
 	int prev;
 
+	put_page(sg_page(sge));
 	do {
 		prev = i;
 		sk_msg_iter_var_next(i);
@@ -2957,6 +2959,9 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	if (unlikely(flags))
 		return -EINVAL;
 
+	if (unlikely(len == 0))
+		return 0;
+
 	/* First find the starting scatterlist element */
 	i = msg->sg.start;
 	do {
@@ -2969,7 +2974,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	} while (i != msg->sg.end);
 
 	/* Bounds checks: start and pop must be inside message */
-	if (start >= offset + l || last >= msg->sg.size)
+	if (start >= offset + l || last > msg->sg.size)
 		return -EINVAL;
 
 	space = MAX_MSG_FRAGS - sk_msg_elem_used(msg);
@@ -2998,12 +3003,12 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	 */
 	if (start != offset) {
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
-		int a = start;
+		int a = start - offset;
 		int b = sge->length - pop - a;
 
 		sk_msg_iter_var_next(i);
 
-		if (pop < sge->length - a) {
+		if (b > 0) {
 			if (space) {
 				sge->length = a;
 				sk_msg_shift_right(msg, i);
@@ -3022,7 +3027,6 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				if (unlikely(!page))
 					return -ENOMEM;
 
-				sge->length = a;
 				orig = sg_page(sge);
 				from = sg_virt(sge);
 				to = page_address(page);
@@ -3032,7 +3036,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				put_page(orig);
 			}
 			pop = 0;
-		} else if (pop >= sge->length - a) {
+		} else {
 			pop -= (sge->length - a);
 			sge->length = a;
 		}
@@ -3066,7 +3070,6 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 			pop -= sge->length;
 			sk_msg_shift_left(msg, i);
 		}
-		sk_msg_iter_var_next(i);
 	}
 
 	sk_mem_uncharge(msg->sk, len - pop);
-- 
2.20.1


