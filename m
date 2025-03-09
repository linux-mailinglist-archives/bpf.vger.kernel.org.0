Return-Path: <bpf+bounces-53681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E72A5840B
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 13:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84003AE073
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00911D79BE;
	Sun,  9 Mar 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMrXvmce"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1721D61B9;
	Sun,  9 Mar 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741523441; cv=none; b=DSeD7AfKXE51ofm9n8OcbQ3Y5PUIYrcHvcjlJXztZmAHqsdaD683lUzFLmQfzglrlfjZpP5rAmg8ysnwLbVz7cOZLv63dUqd92VM4hxry2jWNQ59j4oRxJfd7BW6bioHx9Z7FaBE8IKMTqfaE3e7C4OZOx82iB73aXE+sv1hbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741523441; c=relaxed/simple;
	bh=sHneU/WhzAXsRqXcY1pmJTLHK8J+w04q/ubBQJ0xnjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZ/9+xBa+ZezC+333lqGBp42ACzD3QIyfZHi+WYm3eHjQsNCwphl3tKO7KSkE6szhbBq6qDFI/+5FUhSa9XtjFRGKImfDDt8uuU4o8msKr8Nq8x2PAt8JaAu+UQfy+QKgSJO82HJRkiTsM8WxIajq9WMRZkWCfHyWT/QrMcCXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMrXvmce; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso2722725a12.2;
        Sun, 09 Mar 2025 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741523438; x=1742128238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fsJPW6BgulTD+UOIwmmUvOXjWi7hifzwjr8WFsPZeU=;
        b=YMrXvmceHlfeHMf9QpTnMn7B/aPyLhRgHIDTHrmzS+2e8pySDKjw0f32/sp/eNTX/j
         1IDUU7lxug41ulYeZJrY2Om7BSwInJrftIpx7LTP+IWrVwK7j/J6FV0TSMzgrKGQV24+
         V/VipoRJ/Se0c2MTSL/hgWteUyErZ844TcH52PM+KyWC+BC0k19bC7bgG5VFNXXeqxNW
         M/JTmcsTS902RQD9RhEtTdHz7ZNdgc6wfRE4Dx7U/M+vZDEwegP1vJpFatiH0Ar10QYZ
         qoh8TT79uurjZl4zLFodtPGtMPtxJV4j6R4469bhduPZVGfO9JTc/CXTFjRAlLtF9zCi
         KqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741523438; x=1742128238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fsJPW6BgulTD+UOIwmmUvOXjWi7hifzwjr8WFsPZeU=;
        b=xC90cIJJsg8QWtUxzUNv+1wBWQjLX/hhWPUcfyoO1MZwiz9453TsKORiJyksuDWb35
         LtGy772ePnTn0NbzreJ2oc6L2faAVXj5J/MMD/5bdygzsTugmWURFLCEIAUkoNoCwsNw
         9RzetIVx2SqDeWeRNKmQpz7gBfes8d+d5O9w/JUd8eR1Ww/8YW9JIKToQ7g1Q/jijJll
         ObnD8WM0ce1bZYEejuvDooQTnhwG2rzPpdwvisgrjf2JC67Va/WpaWKFfdTKo0byhgMk
         UZy3ZQSyv/5g9RitICC3Tax6jsrObIXSHSZ6+55n6grdZdpWSgel5KkQ3oRoB24FCOKX
         zqnA==
X-Forwarded-Encrypted: i=1; AJvYcCUmYv0Syi4LRhfDtfJ6PdWLVHRxwT2TYFUXuvrbbPaiDZ7qdi3AjW8RpgOO2wrJw/xnolUlaN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mmurSHzFfL/ofmiHNOKu0Uuanyd/Uw2HseL2LGI8fI4znZB7
	jgZsIlwNSHs6mW2T/dok6QtYQmH4MC5mZs3cAQ3gpGiHRTjsx5kb
X-Gm-Gg: ASbGnctyJKNBeEdlPR+YhWcN+PiLzJyZSh9TtX/GMNakArM6K6CXeFgQC++e+NB6Mi8
	wOHF8Dtu++YkuIi5ttnjf+3rTpeishY9SVdEO7RICMYU0rY4cwy9YHaATRdvqDf1G6W+JMfRxon
	WgrYmUWLq/pKSjtYKfI8j66vIj1d6xxY2+RWRq6vZtWDDPUqEwI1pS7hQTU5oboLtU0Y0eVOETo
	wUlOAqQ5nJLUf6QVYrDzJ40KyTHYjtX/oKjijWWBDl4Nifqe5lp0PCh3abfYzXuTqewQ8JWtjGq
	h5UbI04GPh/NZxM/X1URTdUouW7XvOJ885slcQiwRiFkHhehip2C6hFcNXdpMYRJM1LxjzjLWWi
	X/At+IQ==
X-Google-Smtp-Source: AGHT+IFT+Hegvxny7T+j7UvPrNioERL0YxBHaW78fM1U+yDkZ9D04WWwTLOyMumsJWd9lE/QPbHrBA==
X-Received: by 2002:a05:6402:34c7:b0:5e5:ba77:6f24 with SMTP id 4fb4d7f45d1cf-5e5e22d4c66mr27542180a12.16.1741523437839;
        Sun, 09 Mar 2025 05:30:37 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29c19603dsm39144066b.38.2025.03.09.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:30:36 -0700 (PDT)
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
Subject: [PATCH net-next 1/5] tcp: bpf: support bpf_getsockopt for TCP_BPF_RTO_MIN
Date: Sun,  9 Mar 2025 13:30:00 +0100
Message-Id: <20250309123004.85612-2-kerneljasonxing@gmail.com>
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

Support bpf_getsockopt if application tries to know what the RTO MIN
of this socket is.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index a0867c5b32b3..31aef259e104 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5415,6 +5415,17 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 		if (*optlen < 1)
 			return -EINVAL;
 		break;
+	case TCP_BPF_RTO_MIN:
+		if (*optlen != sizeof(int))
+			return -EINVAL;
+		if (getopt) {
+			int rto_min = inet_csk(sk)->icsk_rto_min;
+			int rto_min_us = jiffies_to_usecs(rto_min);
+
+			memcpy(optval, &rto_min_us, *optlen);
+			return 0;
+		}
+		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
 	case TCP_BPF_SOCK_OPS_CB_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
-- 
2.43.5


