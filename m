Return-Path: <bpf+bounces-44174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362469BF93C
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 23:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC32B22B1E
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6820E32C;
	Wed,  6 Nov 2024 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U/tbhTFv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7120E310
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931985; cv=none; b=sdpBSv1SaJ1RNgKxJP8MlxoWCL8XZT91BTvfAoNEOJ1ric1oM68oED581HONOvzDwwXBMiRArHn8peXQH2/LfzV/6VXkQjYg5Y/CN+6QdxKB96gGaQ53z/GEhOH+7rCIaLgx0teo3N/kthoB0ZC25nWs7kSs26GoYJO5sSjuGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931985; c=relaxed/simple;
	bh=xY3Iw8eGGcMBCG99o2KeIj7WYBk9LPCRvd2nwY/GJuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5ZKLWO5KbPdgosSsNM+cw/0liud6YrCp1qa14Wf5ZyVgabVEdTiU8PFIuOyJUIKom071p/shO9qZ4SyzzbGqIId+c0P6VimPVjwraHV88XMmaNF9LatdRbQ9EWBI6q9Himk18xTX2BunrmQ6PWd6qlkQWcxOkyvwfdUdrwKwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U/tbhTFv; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7181caa08a3so232172a34.0
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 14:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730931982; x=1731536782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0HGA2syRN5y9s7R9m7dm5GeVLMrSiqb/s9x6nYldOs=;
        b=U/tbhTFveNp1RcR9SvMSrC90TTdvNEMi+36WZNRFbppeuXhW4XJf2JykckqzWpngoA
         /RvTV1YPLd7vfoJPa2hCExGiED8jo3qsAhWZmX7rokb0QT0D4eBcKkJbqvJxNbUTDPBO
         d0jnHtRbD95ZYaD/qRWM+obhHhPXkqFk3dBDs0sZaI3W03V5iYNJbb2qoLCJxU8RTciA
         Slbt309+CnMzRwFfBccxPszzV/b3J9gDA7xnK5F7uSxeQaXadAPqxznOEjErj/iuHbn5
         1m1tEDcvxMnJhqCzs4cNkkK8lgNSZIxJCsqhFzvbHkh1PScuX52YtDNurDhdCNZIsVIB
         Odxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931982; x=1731536782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0HGA2syRN5y9s7R9m7dm5GeVLMrSiqb/s9x6nYldOs=;
        b=IsaENvoPA4/v8rriV1hkXmwM8H8NooZUytJj5pCDVBM/ixHDyGZyyIg4NJZlHJO9vB
         6KjZ3GhCcysJ2zxhLqXmYVAFeCLIxeR/1iuIztwI+QgeAdyM6uellqtoS+n6r92ZyT+2
         RwkK21fBNGoDpjw17UYkNXeWilIG2JXHdXMKNvIYhMndeYlJ8Zr7aU4/kZ7vE4CPPeNB
         RUQ+/NXU511poe7CUZI4JhZkODhwarvDSGIs1naEMUs8P0kQIaANxHx0xbQwFrd1+m/+
         wfDoUwLBUngUQQhZ5F5GaRy4dfOUJPjQR2TfSaNM9jq3qyTpMUETwotWgiowE2IbJlCJ
         PFKw==
X-Gm-Message-State: AOJu0YzpfTJZwuTnonD3vWr5EjUSIb3KdgISM1QVJ73QslOeSbYwTDVa
	2iuQint5wCOOdEImNZRHIHLewj+xVrDZsmtONqotCLjLhBDHR7h3Od6LR/bdYdsIeDNHMhJRkT9
	J
X-Google-Smtp-Source: AGHT+IGWKofCI6TAOtgbyO7DqfjcexCEellUqbkcRY5XPUrYDGLq4TV/mfqzGtVhM5LJj4ZqL81z/g==
X-Received: by 2002:a05:6830:907:b0:718:194d:8b1 with SMTP id 46e09a7af769-7186828191fmr38372850a34.23.1730931982401;
        Wed, 06 Nov 2024 14:26:22 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf6c46sm2536585a.127.2024.11.06.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:26:21 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf-next 6/8] bpf, sockmap: Several fixes to bpf_msg_push_data
Date: Wed,  6 Nov 2024 22:25:18 +0000
Message-Id: <20241106222520.527076-7-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241106222520.527076-1-zijianzhang@bytedance.com>
References: <20241106222520.527076-1-zijianzhang@bytedance.com>
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
2. In the code block of "if (start - offset)", it's possible that "i"
points to the last of sk_msg_elem. In this case, "sk_msg_iter_next(msg,
end)" might still be called twice, another invoking is in "if (!copy)"
code block, but actually only one is needed. Add the logic to handle it,
and reconstruct the code to make the logic more clear.

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


