Return-Path: <bpf+bounces-43099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE879AF3AA
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA8B2166C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C882170C4;
	Thu, 24 Oct 2024 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="koZy5brh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25541AF0BF
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801788; cv=none; b=M3R1K1dlc35MKGyQ2/Zla2XuBghdPnfZhJKj5Oacu5nr8Ml3sH7yaWu4be3TOFSQjhTY/a2Da/mFoMq842zkeoahQbDKvLvlN8MaSssf81DNBYWfmp/ID6F6n7I+qz9nbmTxaQkBX4L26TmqFOGMfF8tZcc5MGYTyQRP/PQSI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801788; c=relaxed/simple;
	bh=iAsEXIk9lZDLgN0DGbxM4NFohQ2UJ057gn8Noe9P1pM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKC9CMmQHw9UFqZbfZuBOYHd3UDVDdoVmB7G7eK/UTAi28LSk5ounePVGtU8AfngqLat3pw0+g8s9kosSqik7aCgTQlq3IJzfTJk5hYbNXVe37hb37vZlxMbExmKHJy4AzhaTw3bPjQ4cBVLO0CWZIVM8/EkkRMt33NOBbQFz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=koZy5brh; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso1531380276.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729801785; x=1730406585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6aRUbO2DFgQjmBeV68T/FRJXd7JIVcxWlH9nZ0+GBY=;
        b=koZy5brhtIDCPY7ozap4+DdY+RtVS83gCf6s1ri42pj6mq7HRxAp4xcQZDjbZ1RnQm
         Luhm34ZLQ+yZD0hK9COYSsNygL0pkXTzFA9MNzA5WSexqIdnNrE48XsGchm4NjjZ57td
         BLFgUjkdP/DbLWtxFLME9Ky/+SsPh3wj3I2mkW47kQPTOinRHq/bIJYiY8aDxVErKlg4
         UkBCVtmyRAf8qqO+3aNaZ52ta8hXvBTx70YLv9fH8UVBUWwz3M9rw2bVXFWgShk0gyDz
         21s5dxhcQiobMt7i1BA4yPsjZEgTFInsk6UrMIvqOPlDO8gNTI1nhVOBm+Yl9rpgMIOe
         ndvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801785; x=1730406585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6aRUbO2DFgQjmBeV68T/FRJXd7JIVcxWlH9nZ0+GBY=;
        b=b7O0eKOigK/fqRDoxgSkb6NlrEqHuT5sVQBZ1H+1xlkyEutbkWtaEFMbn4Zu1/w0em
         xH0Smr3QB3DY/l6eRYIQklK+JChpHL25CmDxWXRvhSgsHyPUTiQXKzXO19C0wnLc4kwd
         UdV1RBqFQZPdPiPPIaBMg8bhOLyRvMay2Bto0S2qfVQezGZe88yqOFk5Pol3wwJA3VdD
         8EQFZs6o2SzbyOiHrku4BjcI4jVbluGEfLlWgCyTBnYkn0S3eyQk78SfpG4e25PDOT0U
         EjmcKwAfhQeqyMxw9Vb4EDYNC+k7kdNIDaIFrEFB6qLsRAkr7HDCDanWmfAfxcrBZXvx
         0K8A==
X-Gm-Message-State: AOJu0YzazZw+gnTrMgIl2NuY/b91cAk8K7vDk33GqLosd4uTg7MUZvsI
	RZ+zX4ce9H40xq2tjiQuYQKxMOTw6GeffSsMLHZbF+Pv0rF3ShRG670eP6oH3PyTYADv7Tzb/Ed
	3
X-Google-Smtp-Source: AGHT+IF5dijjfumS8n8+qcRDEWEMsXd2GgVjVCS970UbRLXe/Upc33tK6dykXc6je1Mza+tNe6TQ4A==
X-Received: by 2002:a05:6902:1685:b0:e2b:48af:aa93 with SMTP id 3f1490d57ef6-e2e3a6e76b1mr7894708276.54.1729801785606;
        Thu, 24 Oct 2024 13:29:45 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm55486081cf.52.2024.10.24.13.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:29:45 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 7/8] bpf, sockmap: Several fixes to bpf_msg_pop_data
Date: Thu, 24 Oct 2024 20:29:16 +0000
Message-Id: <20241024202917.3443231-8-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024202917.3443231-1-zijianzhang@bytedance.com>
References: <20241024202917.3443231-1-zijianzhang@bytedance.com>
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


