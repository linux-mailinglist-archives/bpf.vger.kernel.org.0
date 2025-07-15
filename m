Return-Path: <bpf+bounces-63304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63FB0543B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 10:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12090188C49D
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C729274B26;
	Tue, 15 Jul 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLGg6JGi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2126D4E9;
	Tue, 15 Jul 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567132; cv=none; b=iUf2a/dtxo0+7ddnxKNm11hEDBJ462EVhevXonk4sLC6c2F2NfNqPyL60F6WJkFjKjyHsoLRwJzYGYvT0MQGeWlY7cfjdrMSMjCvd+PPo4NU2FZ/an7ZV8I2Gxne8bHP/X5K1OL1SVJWm1sqPL+HiVLFo9yM79GWB7QZiiKXEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567132; c=relaxed/simple;
	bh=A42hZ1CXXzEmtAuN3Oh4U+HhEO00ifH9+iMTus1OfLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUxfrtm2TGGH1LovzJ+CrtgoXZMuh75tZa+uH3V5daiLALSha8cWlGzNWQawCZaDgxZ/3BiidVvuZr++DsTcOiPpvYo8KAZbcphARk3drjr8xIdHa1J95GZuPtRm4owz/sgTK8Pg4LtD/ZWCYHkIu4T8YQ0g6V4ceq0E7WveZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLGg6JGi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3134c67a173so5363652a91.1;
        Tue, 15 Jul 2025 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752567131; x=1753171931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9cZzIxfvxK1Q11zfJm7mjrfAiqzGoJPBeFUMFwlPyY=;
        b=XLGg6JGi4DKHsaBDMBomYu7kgK8vsYLIPEaOSOuTPEw4qIeQ4/WGHqbfW8hBgw67Ql
         XmTLvSbUioR6Si/qiGhUrPU5PgL6lnFJ7leYqtgu+wgKL5lK+Nkx/gkWr+CpSMOFNEyt
         NA/IEipe13IUsUKiVfWrkei/+vE1O2uKZ5RDorbqFX7D4pBnHy3dnQtUZM+2ROXLWiMf
         sR8XZ4SwG5Yiin51EPIm3gEZFKK659KUrQkPTDEdVTzNY6a3KiA18chp6ax5tRsoa1J2
         p69LSRtq1RphSXE4qw6GdBdKWNmjdb6uD0Ys7G18k4+dQ2zRMdo8ebpjct0D475y5+ES
         vUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752567131; x=1753171931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9cZzIxfvxK1Q11zfJm7mjrfAiqzGoJPBeFUMFwlPyY=;
        b=fEDnJkBCLEiSxRk7eFFMChoViWqjy9clvqG5czS4+l7o4StqTss4CAe756ixMIPrVd
         9LIWNIZlbNYEBhC3nqHBtFm0Lz4sG4bhKtaAG77NTOVtZE2Vkt1eVzHpYC5Va8ysuN6R
         nfXiV/7Whz5zf3kA5Iu0E+DD5lmYrU6/HIK9yMjWRRDhu2Dwhz7649Sc3174Dc9dsQLX
         geV3fJ/2/kRkDz8qLiBfWjv6qpiQ2UViUmLpn43S+dZABN8r8WPB7IoxlXGiqoZZaU3E
         GoMBWxAFV7/Ltq2ev9JebD1p5vOiVoCFe/iskomQQy7m6PcyFdIF98XHw7870v3KHhLh
         1eCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ByCqzn2ZawVyw1bQDHSIJu6SJzGdi74cs0Mxg3X69yckGCZyh+fmSrFWeMLe5EUQDME=@vger.kernel.org, AJvYcCWWYbakaQHUAP/8PHmHIeC4wNNp3gFbH4wdvX7tqfq+koroocWJZyX1UTblNWUhKjoXwkwyPm0W@vger.kernel.org, AJvYcCX7xspcH7bEkOF/Oaoo4BYYuOUKVrSvdoOmyhEgnfi+tAql44X9G/P5qo1ouXuXJAK51apeJiCQPXVnoJg/@vger.kernel.org
X-Gm-Message-State: AOJu0YywIDJVJkq4E+PZHAF/5huIQU1MuQo8C4nLG2ZpG8Ar10ScSHlk
	emoJpf0UGJnbK6xSPYGgJkggKo5eyp9AL0cK/D0RGYnub87TL/ZlGJ0Q
X-Gm-Gg: ASbGncs7xuH7ScbpnkthrdqqBExuExlrx/Ep4ORxf4OfV6e/CcWU6VrmoTrhq7Cy24S
	VOovyOhk35amIoow4EAAT+QWOCS1Pn1YTL4EVXYB+ra0og64j8tFsNm0B9Jd7jgLZ0DIduDjAle
	71c3SNPurebzdMFesD2pm/2Isz4mwltYBGLIw+P7SrFsnPd26FJTona+mM3e+FA7QnsF2c1bk3/
	AyYHcWH3vsPcO6S00U6iTs5E3rf6pMiB2wW2hM+fWWO+Onu10NJIQ7L/VGO2X0GALTgGIDvY71l
	iW35b1sXxklw+aCsim1r2Ei9qz3ZKEET6uKVPnv/c4VJ7k6Pt6UaW7maLb2aXVGwsWeDJcSJEPc
	RXCGg/a0jK2Ypxea+kQLsar3asn4NFvn+PZSamWEd/BE=
X-Google-Smtp-Source: AGHT+IFs5trgbTAyKft18DYDReY5ltyl88fzCm7ptR0K9hii4EwznJNonE1VzgHtlmmcLfwXRMVL9g==
X-Received: by 2002:a17:90b:3b90:b0:312:25dd:1c99 with SMTP id 98e67ed59e1d1-31c4ccd99d8mr25949761a91.19.1752567130634;
        Tue, 15 Jul 2025 01:12:10 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c68:e0ce:6703:6e3f:3a79:d2e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017ca4csm14236712a91.31.2025.07.15.01.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 01:12:10 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>,
	syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
Subject: [PATCH] net: skmsg: fix NULL pointer dereference in sk_msg_recvmsg()
Date: Tue, 15 Jul 2025 13:41:58 +0530
Message-ID: <20250715081158.7651-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NULL page from sg_page() in sk_msg_recvmsg() can reach
__kmap_local_page_prot() and crash the kernel. Add a check for the page
before calling copy_page_to_iter() and fail early with -EFAULT to
prevent the crash.

Reported-by: syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
Fixes: 2bc793e3272a ("skmsg: Extract __tcp_bpf_recvmsg() and tcp_bpf_wait_data()")
Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/core/skmsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 4d75ef9d24bf..f5367356a483 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -432,6 +432,10 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			sge = sk_msg_elem(msg_rx, i);
 			copy = sge->length;
 			page = sg_page(sge);
+			if (!page) {
+				copied = copied ? copied : -EFAULT;
+				goto out;
+			}
 			if (copied + copy > len)
 				copy = len - copied;
 			copy = copy_page_to_iter(page, sge->offset, copy, iter);
-- 
2.49.0


