Return-Path: <bpf+bounces-43089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1249AF362
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BC21F23253
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C35215025;
	Thu, 24 Oct 2024 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CXEqWyNv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990C216A10
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800812; cv=none; b=owGzAffKHVEJjO9W9rY2yELmiI/Me6ELqkEP2ZgsXq/pR6ls9rfzedLFcuXSiE/2Ltwjo+4Hgb3GPRoF3HsF0XM3go6/Yd51OcvASzVJNZQEfIo6swNT5N8RI4mYso1vrrLjlnFH6bRV439bRilGWmpPWnDRbFFraYSy9mLbqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800812; c=relaxed/simple;
	bh=av6oifeqTeSC9r3U8LnZD4sFuTiyevgdWO0J8BBjSF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyp0UEZqHorIPa7VANwzijoeHFZUpeWzWko7fH1OmtyZlRVNi8nr5H0smYZNJD4qjWmVcP8yB6688XqxqOESR0L4E20DdSaV1EeeAPiVwScXjRkL1ErVTKxawZf+Ven9S/PtFCoEdQcK1wITzubw0uJrCPT0I+agWbwZIND/tv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CXEqWyNv; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b13fe8f4d0so90221985a.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729800809; x=1730405609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0zv6WgbV5lxDj2FYVRbA7097HeGDDzwPhUvvFMKtGU=;
        b=CXEqWyNvEhk7PBHdY7tzpcntVa6cki/v7smACm4uhii1m9Ipu4Iu6SZiDnrCNQHxjy
         C7eT9J8BZvHk8TTrjsseWxG2G8JHxT170QydHYiT+vyEJQW3Gd1C9vKi+CjlWXZ9vDPA
         e9fGO4UEiY5OIgo/MaUmGEVZIimDm6ItmzYM8I1kul2gq2UrOFcaD6r2jsFK9jKuKB6Z
         Vkpmhw7HyHgiHypZ39vUlshhNDUkiSrVDU+nyU3/ktgFd+WCkdVSZ16ah1W6HaAhjZLN
         NM4GrZPQ8tcnDDx8UQxbEgjfUczlHIJ9UduXoh9TJ8UO1yfvKN5pKV9OoTQrA415fUiY
         urHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800809; x=1730405609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0zv6WgbV5lxDj2FYVRbA7097HeGDDzwPhUvvFMKtGU=;
        b=JIR2BQWA/t26E+1blPJ372pOCx8Yt5/mniXsg5QUXiT6I0KFAr+H6NH3EH3BwWhKq8
         VJx1Qdc4Jo/V6vx4ySeDkmA+AWvuEp3mB9JHfmFj3tjmCW43QVQjdSGMrcAl+vts8Er4
         kaGtQyPsC94Sv/rFhOZFXdtkBOVpNE7Z490i3yzMnaEXPG1gMvyJonDvesX8wflxQzCb
         eq13ZzDW2h2HdX8TJj1QFDUQGizlUR29HQ8VyRox+KanKj+A9oGXzxntcsz18DVO9wqr
         z6Gep5dWYz8QuwPq16g3b6cdCcUy/eweWj+3KN9C1aDY2t78ApseIeVtJr2ctUIb8VzH
         ddMA==
X-Gm-Message-State: AOJu0Yy6dj3nKe5PWTIj/fmXe+AKMvfrKKVwkF8HWRP7sziQZnzJfKIq
	wmR2P2z/zWIP5/iwcQLeijf18EbbaJA+OQSBhXdGM0CvZje1Y3gsz1Apkvmeu+kQDBopHHG0me2
	8
X-Google-Smtp-Source: AGHT+IG8GVkC4v9NrX5GiZ2VC5Pkekx1BhYqPQ862jNzhzn4mC1fJho5mfimbvOt2G4Q2CQZOJy2tA==
X-Received: by 2002:a05:620a:2590:b0:7a7:dd3a:a699 with SMTP id af79cd13be357-7b17e53f079mr873707585a.11.1729800809315;
        Thu, 24 Oct 2024 13:13:29 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm518952785a.60.2024.10.24.13.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:13:28 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next/net 6/8] bpf, sockmap: Several fixes to bpf_msg_push_data
Date: Thu, 24 Oct 2024 20:13:04 +0000
Message-Id: <20241024201306.3429177-7-zijianzhang@bytedance.com>
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

Several fixes to bpf_msg_push_data,
1. test_sockmap has tests where bpf_msg_push_data is invoked to push some
data at the end of a message, but -EINVAL is returned. In this case, in
bpf_msg_push_data, after the first loop, i will be set to msg->sg.end,
add the logic to handle it.
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


