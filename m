Return-Path: <bpf+bounces-42526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342939A539C
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 13:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DE5282CA5
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4EC18EFF8;
	Sun, 20 Oct 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CF1/lGV0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273ED190074
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422274; cv=none; b=lebbiymgRDQj9Yax04pzF2dy7PhwhghlYdo1GO1Bi5TeLUxzffkaP59/xcmZgKNKtaMrlrwpyodCT1brDwyU8vHKttVmJunRk/MM/zC5XRb0ptvvW4HI5HHnPlgVmVu9Tk45TUd0Q1zJy8vHq2oaXvP2n+iEZoY+7gmb1AOP8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422274; c=relaxed/simple;
	bh=WQkBTANNrlxAVAxsSwV26WtmnEMH/ALNmAPkbUTnNGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wh/49scADHXcJYC5KLzYU+P0GF/Fpj9XNutOv+w928ZW3/2CK27fDI3m266PuxStf520NVFGUAV3/UVX5wv9GSRRZuhpvBgpsq28xz1hTVFv33AujGfxkJlAWfVdFpOBPX1D/T9DBWKXinmFO8W0gZt/jXSWxNeDy/3FeOC+wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CF1/lGV0; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbd00dd21cso22434276d6.3
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729422271; x=1730027071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoVozaRBn349dlY/Y2Xvit4gb/ODSas9Z65fIEa/ErU=;
        b=CF1/lGV0arYwjIz/P1hxwI7dZWuJkA+ogTPxUrApPYtAhfXOfJhPf8DEEbm6CG0M+u
         0tR5VDNeZbFgO/qbz8hFjlFXOgqEec+Er10+F2oNNh2Y2oVWpecBQZfKCZMgtX7mg2Kf
         OXgcwg8PLa1Va/ezBX8fsCiSfjLFek3z21Bu/uSeip+BZ+ujYHjpiWX6Iw1czo+fZwWt
         MDFmdDcSvcBfJNhcZ40wM22uk3LEKZl3IDiV7i0TNZkWCXe/NTt6DIslHkP+or6jBRTK
         CzwLulfNIcejphvbrm+/yADPGhKiHHGGqdwmdIsClPukiizFGiv55x45yBGTuwwFfnZj
         3uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422271; x=1730027071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoVozaRBn349dlY/Y2Xvit4gb/ODSas9Z65fIEa/ErU=;
        b=iycm9+9smSid5vyKrRJoqWY43ncdqVP4Aka8uHX4WAC72ObLMTqnhbuVXQzQvoSvf4
         7r2nGDw61cHluu+DmACn3Q4RPf8Uk0Beh7sesNKmcyZdtDdMB7eqS69RukwYrH8nXpEl
         pguOw/F4vsNvfB0Jh0lFXM1BlzwnTTzVvi8l79dN+nNInLEsWgFqsOeMcKziDNPULtjH
         sWsmPvOvpXXvbEJSS0L00Fk80vn7DYUh3/CxlerCfu6ok20jnkDn0/QWRAWb+0Dhijaz
         7COlNbiLG9pz1wTt+lM3jPPXkWp0anC7fJJWQ5jVb7VyxTtBZ8Mbgj7SY+6Ao7IK/9Nj
         RVgw==
X-Gm-Message-State: AOJu0YxO8Wrv35aTotsTj9fzOrun5Hj88Bzx2bmLrPeu9sQY54qUM1N0
	VkiMLF42q584lSv2niKjGf0yjasgHHkpNRM9AnCJURPsVzHJCp+fIhz3mitIXFDFo4fQpjUfLtJ
	W
X-Google-Smtp-Source: AGHT+IHAgMi4MEiqCJ4bP4gKCLPpOSV31PlOHEsfaPhRuSXhhoSOG3x9YOX6fNqmZ3KiY8vC3iEiNQ==
X-Received: by 2002:a05:6214:3b83:b0:6cc:42d:bbb with SMTP id 6a1803df08f44-6cde1695f11mr88854186d6.53.1729422270843;
        Sun, 20 Oct 2024 04:04:30 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00700c0csm6715216d6.0.2024.10.20.04.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:04:29 -0700 (PDT)
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
Subject: [PATCH bpf 6/8] bpf, sockmap: Several fixes to bpf_msg_push_data
Date: Sun, 20 Oct 2024 11:03:43 +0000
Message-Id: <20241020110345.1468595-7-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241020110345.1468595-1-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Several fixes to bpf_msg_push_data,
1. test_sockmap has tests where bpf_msg_push_data be invoked to push some
data at the end of a message, but -EINVAL is returned for this case.
2. Add logic for corner case where msg->sg.size is zero
3. Before "if (!copy)", the logic for some corner cases related to
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


