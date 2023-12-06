Return-Path: <bpf+bounces-16954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E8807C50
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 00:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75EC1C21006
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711092FE38;
	Wed,  6 Dec 2023 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjK5CoDM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24310D9;
	Wed,  6 Dec 2023 15:27:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce72730548so67806b3a.1;
        Wed, 06 Dec 2023 15:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701905234; x=1702510034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU9vkG8RfkaspO5yaBB9jJ83C8HW3ck1RxQ3+5By3Po=;
        b=LjK5CoDMoyZeU9lwlTTY0+xgrwPvveLMP2ys0vOqgl0xrzYRj+YQg2JFJubmZkXM3h
         Of7yMJYVWe/wd60t+RxxOdR1ikMIZr1xCxnfEwhmMkU5/Lzak3BdV73AAJHvJrh5nmOo
         Wx/6eK4UNIYfRsHITR3NzQN+7DQUhYqNAT9z9C7Wv6M+EeslVlAOpAgEs2Aw6u/9Alt4
         mJmNmnX140WgXMOKry3Lp2aeeAlzc0fQgbVSKG04+07JAF5C8SyD4AZpazvkldXdJvQr
         3lcJVmPYUeyUgJc9OSf10k/syN9IpGDMTKWPlX7e9ZlKhAcqAlL+X4xdL9MfqX+KBLe0
         BPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905234; x=1702510034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU9vkG8RfkaspO5yaBB9jJ83C8HW3ck1RxQ3+5By3Po=;
        b=e+UbW3VfHhDE9jrF5LhxXuQ2ytmKJ3rOhBq+t/BcLAp2zgrm4wBaGfpYfzMdcIQzWG
         WiJ3sCubYs4eZxeAv1p7VCt3Z087olc2zVwpIqXpEJgLHsi/hOiMxnxrwMmJM60VOw4s
         G16ohih+n1SQIH5CXzD/AtApQ3hy7KOFHvuNVXwvmRvDTg0C41YBFEmq1VXiPMXgUjyI
         DEnPZJNTykbWYflv3F8q2TVTiAkJ0BKjUhR/VAnau/42e8vNa2gHhl8409vdprI1Vry+
         06V7EFZ6mrm8LoGgeAKlFy5Tt4CPNq7lb0MjCNy4E6AS/og/nzdYz/+/moDXx+I59RvM
         ntjQ==
X-Gm-Message-State: AOJu0YxFXQowYcs6fxVgZ3eh49RlC+YzUYoVBgOsJWVSsst3D/KW/KJr
	BXoSU87RX4bsCY+Y260o21M=
X-Google-Smtp-Source: AGHT+IH5xOQG0TpivXQIeKLMVAq48E78zG0YLW/mNgi8skexCddKCgpMOe41BE4rSXW04mUngeVqNw==
X-Received: by 2002:a05:6a21:33aa:b0:18c:1570:49fb with SMTP id yy42-20020a056a2133aa00b0018c157049fbmr2167975pzb.50.1701905234161;
        Wed, 06 Dec 2023 15:27:14 -0800 (PST)
Received: from john.. ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id ka18-20020a056a00939200b006ce91d27c72sm58545pfb.175.2023.12.06.15.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:27:12 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: kuba@kernel.org,
	jannh@google.com,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	borisp@nvidia.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net 2/2] bpf: sockmap, updating the sg structure should also update curr
Date: Wed,  6 Dec 2023 15:27:06 -0800
Message-Id: <20231206232706.374377-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231206232706.374377-1-john.fastabend@gmail.com>
References: <20231206232706.374377-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Curr pointer should be updated when the sg structure is shifted.

Fixes: 7246d8ed4dcce ("bpf: helper to pop data from messages")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/filter.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7e4d7c3bcc84..1737884be52f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2602,6 +2602,22 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
 	return 0;
 }
 
+static void sk_msg_reset_curr(struct sk_msg *msg)
+{
+	u32 i = msg->sg.start;
+	u32 len = 0;
+
+	do {
+		len += sk_msg_elem(msg, i)->length;
+		sk_msg_iter_var_next(i);
+		if (len >= msg->sg.size)
+			break;
+	} while (i != msg->sg.end);
+
+	msg->sg.curr = i;
+	msg->sg.copybreak = 0;
+}
+
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
 	.func           = bpf_msg_cork_bytes,
 	.gpl_only       = false,
@@ -2721,6 +2737,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		      msg->sg.end - shift + NR_MSG_FRAG_IDS :
 		      msg->sg.end - shift;
 out:
+	sk_msg_reset_curr(msg);
 	msg->data = sg_virt(&msg->sg.data[first_sge]) + start - offset;
 	msg->data_end = msg->data + bytes;
 	return 0;
@@ -2857,6 +2874,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		msg->sg.data[new] = rsge;
 	}
 
+	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
 	return 0;
 }
@@ -3025,6 +3043,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 
 	sk_mem_uncharge(msg->sk, len - pop);
 	msg->sg.size -= (len - pop);
+	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
 	return 0;
 }
-- 
2.33.0


