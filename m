Return-Path: <bpf+bounces-43098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF14F9AF3A9
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E21C2187C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284572170C2;
	Thu, 24 Oct 2024 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D+R+28L8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B52170B9
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801787; cv=none; b=ZetoyrZfff19J2MNE058+y5zGeJgu0O4TPayBw5bVJdBOCeBFBaCAK4YpdkeTxs+MxIDenjXtjnza6FQF2xGcAr4sYroQK1KtoNdtOzrlnjwUL1WfMOyg2TBsjQRTe4n3LxgI2qc3uTyvreKgQo4NOiyGrBDUdB3zJ6EfFoA/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801787; c=relaxed/simple;
	bh=j34bvrCVF0oaO1wKlQh8wGEACHFU/0w9veoKch8xoxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpdBzGBIUNxhvzWcXMRvSJYyjAPUnSYGeq8dbkVr/SfVUX1Ey/3Gnn9NXUmL0uFhfN6RWP2ULcR/I6FNXUEX/unOjr9mu0OAsbLYB2P+t59ETsSugRIuTMDrnA+hmECeIRpQ4x0ZsAWLyQdOL3kBRwHZ7qvcVE0Wf9TCz+1X2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D+R+28L8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460a23ad00eso21701041cf.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729801784; x=1730406584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XhEsmOF8nZeJsm6eI/AhkOJHXVkV3Jbs6Tk1mX0i8M=;
        b=D+R+28L8DYkB8n9uKnImUSzvP4mmpai2YqH2IrpSFWdMe57hV3a5r3nVnEA30xDCgW
         v0mWevMvZEKY2VoQJUh2759TvdRsTMwDEOrwkvLHCQLa4b6DTqkFpTHbIyN6rd2g50O5
         e/gx085rTdCeooTpapwKKgU6gYdJ7/3UzPYFHdJ746BQVjT0piETKNvjCWfXJZsx0RYC
         OnWu7CjPuDnAciswPooFJeuz2woiBpgVCpWhORaO+KOWYKmGbUOuBOG//8a2MZEIt76k
         SUnzWw3za+4171ZHFnuMiPzQUjkRp5yNB9ghzy/yCZ/gyaIaX/ie9bsWUDYu65AfAi0w
         23+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801784; x=1730406584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XhEsmOF8nZeJsm6eI/AhkOJHXVkV3Jbs6Tk1mX0i8M=;
        b=tQrASXm6/Y31B/7xsvWJb4rZvoKRWnLfaN0WPp1F/VtWfHZJ8+94wUueVuAur/j/s1
         /K9KuK6t6WrRQ9UWsK2Kncfu1T2CsiNUqBNZitFEEYJudKuG8nFfeqXaloCo33/miwsV
         MibyYngLmg2WXfyfFRkb1fOQNMlwi3xm33Iyx6ev4V3UaTKpUIEqMWdfnseOxx6+MjCV
         MHBvkbU8wrSKgMh2PESLYFT+yt+8xw2586N7NGcZKbj8uBn9EYcVDzTBCfKK0XI+mE8R
         VIqpqItfI+3lwx1jUMvhj3UXS/9uyznLIYK61O89mr7sj/gyfo6hIn/fh4cTfKko/AF7
         1hdw==
X-Gm-Message-State: AOJu0YxKGfdfc3lL/pzQ7Bc6QE8sLQ7DmWTDdhQf/oKUTX27HssgG36g
	tweuCk90iSWkLyymgelLvJT+fxPtd+Kf03zGa2EgVdAE3UO5V6rgX9xWgGO6ypCswsJXl886cSn
	w
X-Google-Smtp-Source: AGHT+IHt6jNVAFAtxbYTk6vicLjIQ/twn/x5r4MiC2EooTqfxA9qqcS2BDfMXntfQLdRH8DO1UgT+w==
X-Received: by 2002:ac8:7c4f:0:b0:45e:ff39:ea6c with SMTP id d75a77b69052e-461252d181cmr59089361cf.29.1729801784100;
        Thu, 24 Oct 2024 13:29:44 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm55486081cf.52.2024.10.24.13.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:29:43 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 6/8] bpf, sockmap: Several fixes to bpf_msg_push_data
Date: Thu, 24 Oct 2024 20:29:15 +0000
Message-Id: <20241024202917.3443231-7-zijianzhang@bytedance.com>
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

Several fixes to bpf_msg_push_data,
1. test_sockmap has tests where bpf_msg_push_data is invoked to push some
data at the end of a message, but -EINVAL is returned. In this case, in
bpf_msg_push_data, after the first loop, i will be set to msg->sg.end, add
the logic to handle it.
2. Before "if (!copy)", the logic for some corner cases related to
msg->sg.end is missing, thus add the logic to handle it.

Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 net/core/filter.c | 53 +++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a88e6924c4c0..4fae427aa5ca 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2793,7 +2793,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		sk_msg_iter_var_next(i);
 	} while (i != msg->sg.end);
 
-	if (start >= offset + l)
+	if (start > offset + l)
 		return -EINVAL;
 
 	space = MAX_MSG_FRAGS - sk_msg_elem_used(msg);
@@ -2818,6 +2818,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 		raw = page_address(page);
 
+		if (i == msg->sg.end)
+			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		front = start - offset;
 		back = psge->length - front;
@@ -2834,7 +2836,13 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		}
 
 		put_page(sg_page(psge));
-	} else if (start - offset) {
+		new = i;
+		goto place_new;
+	}
+
+	if (start - offset) {
+		if (i == msg->sg.end)
+			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
 
@@ -2845,39 +2853,44 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		sk_msg_iter_var_next(i);
 		sg_unmark_end(psge);
 		sg_unmark_end(&rsge);
-		sk_msg_iter_next(msg, end);
 	}
 
 	/* Slot(s) to place newly allocated data */
+	sk_msg_iter_next(msg, end);
 	new = i;
+	sk_msg_iter_var_next(i);
+
+	if (i == msg->sg.end) {
+		if (!rsge.length)
+			goto place_new;
+		sk_msg_iter_next(msg, end);
+		goto place_new;
+	}
 
 	/* Shift one or two slots as needed */
-	if (!copy) {
-		sge = sk_msg_elem_cpy(msg, i);
+	sge = sk_msg_elem_cpy(msg, new);
+	sg_unmark_end(&sge);
 
+	nsge = sk_msg_elem_cpy(msg, i);
+	if (rsge.length) {
 		sk_msg_iter_var_next(i);
-		sg_unmark_end(&sge);
+		nnsge = sk_msg_elem_cpy(msg, i);
 		sk_msg_iter_next(msg, end);
+	}
 
-		nsge = sk_msg_elem_cpy(msg, i);
+	while (i != msg->sg.end) {
+		msg->sg.data[i] = sge;
+		sge = nsge;
+		sk_msg_iter_var_next(i);
 		if (rsge.length) {
-			sk_msg_iter_var_next(i);
+			nsge = nnsge;
 			nnsge = sk_msg_elem_cpy(msg, i);
-		}
-
-		while (i != msg->sg.end) {
-			msg->sg.data[i] = sge;
-			sge = nsge;
-			sk_msg_iter_var_next(i);
-			if (rsge.length) {
-				nsge = nnsge;
-				nnsge = sk_msg_elem_cpy(msg, i);
-			} else {
-				nsge = sk_msg_elem_cpy(msg, i);
-			}
+		} else {
+			nsge = sk_msg_elem_cpy(msg, i);
 		}
 	}
 
+place_new:
 	/* Place newly allocated data buffer */
 	sk_mem_charge(msg->sk, len);
 	msg->sg.size += len;
-- 
2.20.1


