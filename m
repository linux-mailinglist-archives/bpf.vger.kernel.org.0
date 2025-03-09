Return-Path: <bpf+bounces-53682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CBEA5840D
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 13:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D467188DEA4
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5A1D8E12;
	Sun,  9 Mar 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYTiRQoB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552551D88DB;
	Sun,  9 Mar 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741523443; cv=none; b=DgUhqWql1NP/1UhemEJgcBQ3X+1ZDZlKsQHVDhIGx3Yib7fg+vkIaFaXM3+T/k84Mt0gHVH/rXr24BbvKCxzHYWUG8688GitYIQrR9PADDGHKDucVXkrOenMlHLvSOEivl6nhv0Hf9GDfY9QKrmdLKrpf6zIL9Ev4sGOh8GDcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741523443; c=relaxed/simple;
	bh=ZeiLkNs+ekRrlg0B6KrUsjT9TMny1Tw9QR6DuRYRhhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LW2V4ku2Lj9ChniujLQWb/TgKzf0APSIzBhS0rcFn6kZwBK8IjmcTncPOjm6znHL9fQ5OV73YQ10TYystbY95OhsLMCcdA8kYQjjw26OyDJXMKbYI2oYACC+GuZ+vXJrSi9fDBVsQPLmWnHMIwFeSJ6b+Y6ouLvxNIr5sdnrJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYTiRQoB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac256f4b3ecso376545966b.0;
        Sun, 09 Mar 2025 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741523439; x=1742128239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt0dh4d85A+30IaWg98E/aNFs4/LkjCEMr5INElBVSs=;
        b=ZYTiRQoBDI5EACIOmZddccp+q7ZcTkLyDol8Fkcyjbg6viFTYvc+gb4YSbpXVsmtr5
         4VkdLyeHylrqiGnprhAGF+2QVrXAwzVOCIU8dV5Jl/AopM5wtB6KXDnixhBlx66bM7TU
         MuFGOZdi6f+zj7APjr4aEumVLbRNu6hcaagBEoN7TuZ1Ur7uPm9qdrjSyxO35YdcB3Wp
         J1bpLbY9k2BQoJxy9KLTcCTcG6jOciF4joqehp75yZLll28VV7pdi/u+L+QDEMZJyO5v
         uZwWk0YcCIEEKc0vrq7WNIcjne3JYA0d98I942+ZvayLFVn+8bnQzFjR2veZ/uSAtUqN
         7N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741523439; x=1742128239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nt0dh4d85A+30IaWg98E/aNFs4/LkjCEMr5INElBVSs=;
        b=mAYOwPcYIjrA8ADRA4nUbsQ6PHHnH/Ojjh924RHit5TcbC3bSJi7hpB5bYkW+ucYkc
         HprEWPNUz9wLOi6tlkNAy7DTKOBCGJH3wTPV5VrdydOc/rku0PFSJlY7v74PJmt2oBJw
         hyoJLNKPveWdvufIpJ3HWfxMfBoktWPSWvR5Ii9RrW1buMc+o9uYBBRS90TnHGfDx1uc
         0roVP4c4XRp5cRmJKauW3GsrD9aqvtg/4JFhB4eR65EDQVXb2Il3aLhklV5dzntlNzfU
         al5rgHkRDluWYpBQ9HbuVupyeAwP2Nnyqny3hdNZVVMyFVZSs/6ueQJtIjRwEw76ptV4
         3B5w==
X-Forwarded-Encrypted: i=1; AJvYcCXgKrc7yN0Rt6Qo21+Np4AJnsFdcHTWGv25FrFfOHhngeI2kVN2yMRI+1fuFW8ypHhHYU/f4No=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywddx3XUMHxALTmbzGOU9VIS73JNwP4WlH2BTii/X8wJwypkeqV
	XBQpqN2vMilhC3vqsbkdqPAQgtqNvuVIywLMYn/+H0VeuiglTsgfg3MbgAHDvIy5UQ==
X-Gm-Gg: ASbGncuXyel6Hnw96X/f4C5NsZ98c20BR29xB7pNYnTv+HIVxlp70vevdwLjxbTw+65
	ikvoJYxJioQWo/c2//FLcPIUT6k+U1/LmUfPlIujdbDAI0JMAMX0uXwdlVo4UuHn9ZYc4VeFe8d
	vCuMUmtJs7kQ3XUpnXzvWjbMhH/7UpjNn2nqTn8E/o3e4GMhL4zOGZOV51RFN9JtVY0Dc6QZgDT
	poSRZz/IZUExV5pZaQNoFR3BJw2+o1xHDQCoqN09gS23GTLlSgXvYeixyn7HtKduL/Yy2MyUiDl
	2KfXmsaeJ7sdrUWAiFE3UC2VN/u+UwvrP6EY5dzkBtedrl1AlmvT4YEfmmAkBTwu+VknmeqFJqU
	+wmLrWg==
X-Google-Smtp-Source: AGHT+IHDkV3KkIs2+piRbNv68gzP71QoK9zBWeWZmSeCaAS2sbhD6MoY1419pr9+L0IYvZ7J4bW7+g==
X-Received: by 2002:a17:907:868e:b0:ab2:f6e5:3f1 with SMTP id a640c23a62f3a-ac26ca3301bmr692701766b.8.1741523439410;
        Sun, 09 Mar 2025 05:30:39 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29c19603dsm39144066b.38.2025.03.09.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:30:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
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
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next 2/5] tcp: bpf: support bpf_getsockopt for TCP_BPF_DELACK_MAX
Date: Sun,  9 Mar 2025 13:30:01 +0100
Message-Id: <20250309123004.85612-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250309123004.85612-1-kerneljasonxing@gmail.com>
References: <20250309123004.85612-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support bpf_getsockopt if application tries to know what the delayed ack
max time is.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 31aef259e104..5564917e0c6d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5415,6 +5415,17 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 		if (*optlen < 1)
 			return -EINVAL;
 		break;
+	case TCP_BPF_DELACK_MAX:
+		if (*optlen != sizeof(int))
+			return -EINVAL;
+		if (getopt) {
+			int delack_max = inet_csk(sk)->icsk_delack_max;
+			int delack_max_us = jiffies_to_usecs(delack_max);
+
+			memcpy(optval, &delack_max_us, *optlen);
+			return 0;
+		}
+		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
 	case TCP_BPF_RTO_MIN:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
-- 
2.43.5


