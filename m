Return-Path: <bpf+bounces-75324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 660FAC7F5BC
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 09:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E777E4E41F9
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3AF2EB86A;
	Mon, 24 Nov 2025 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5PnZWLs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE942EA473
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971754; cv=none; b=UZ/RLDNrdaKdaz6VjiSx0O0loIN0HeUM5AItt3F/PC2JZfRNr8mHVfK7os168PkkRubA4fehTyw2wNaMp33bckwjqBNAvBJ8BhgWY04Avjtz5XuPnmlCTQ1YesKQLlN96wqkPt3Zjq7cDlGolJzUlXJQxxhSRORwl13NDxeil8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971754; c=relaxed/simple;
	bh=V81+1ze73yTvx1q8a2ipglYldq7LJealeazPhR2dWm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fAupunIA6HCkFW1Hq9AAyt4ajpo9V1dRYzj14UDTPjiGHp2qNPOjNRwxJFJPmDv9YGrItCN3ySnDL9Zxz8fZCHvOqwuB1utCN5/I/er5Xg++0YSKiKI/pdBBmvI4MFTjyNYPM3ISpVntoXFzt8gK78VRcDQfqGWYBFn6OKfhSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5PnZWLs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2953ad5517dso49126165ad.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 00:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971752; x=1764576552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/j0qk7QrSntrIDGpLECyQj/ceblaeuxUWotaYtatPsM=;
        b=l5PnZWLslUIrUnNOm80VRFmjHSenyI8OXWIc+Hc2yRQMLOrwzC5XlbYk8iECzjRiQu
         StqObEM6iYoKjwlEnN6Kw61+s9YIUbmYrY0GXTp+oEOstmMijuagj47q/I75p5i6qMtr
         xDbSJlwSNP/sSpsrcC72pbnUEQW+3rT/uCAliMl3fL606v4Hm6JQ/hvITQVsX07Vj7ty
         sIW88zufH/gwkVVUxW8RxuCL5lh0W0TVFNxcpPyDFEYcsOlIExudpzAIJSDSEAP5/Y7j
         DubdJEn1r1OZl0sGY7hhkgbQIVUomzqafk1BUSIpvfwvK5LqrVZAIa4ltNoR6aa5WDbc
         m9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971752; x=1764576552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/j0qk7QrSntrIDGpLECyQj/ceblaeuxUWotaYtatPsM=;
        b=BzrZE4BXs2kHxxyOHOkQXQyv4OQT40Ieh2M/ttmRGxpf5gF+248P5IVcyKgp9fCb3j
         nUAlatjASqFf8++T+C6/RHy3G2IH8y89Q/LSZ7AO+8j41QPlWmPJvipXJsFRnbkhikJx
         kaN5cXOUJGKW0zdHyfAAadWajpCTnZmPE33WroDkYZOLxbnpTpuIt2unsVzDzZGYC5k1
         npYelB0EuD1TWEoP8w7K0+4bO1VOuTj9ayvmFTs83OnMijwAEP/5e8OA2k7/bnU9KIBz
         Czxq8AofhQbdAuPTN03+Pwh1SzM3tzPuZOVW2OeuV5B9QZpNGGGdqKi2bdE47YrRB9Ss
         SnLw==
X-Gm-Message-State: AOJu0YyQLl7I0fOQNPqoyRpQ6w31iNj3uF7Iyf52yKqxQ+LRhfxg1kdE
	3RrmGhnvVXaMe7vXgz9/xSuh727W1L6g9JVqVVfVQkI/ZDc9JHTEQqZB
X-Gm-Gg: ASbGnctS5Vk86TCZXKN05Zka25OLX4NqV7aL1kS5GW/Hr1XG07JJCeWWJqs6OJhFGXT
	fYQmSkFGn2Kz0S2QFVHFrt62bVe5znohtO5gnSSJjsyEKYrcrYJvYxQeSWbVni8vtG/OFiH8Zba
	RL98PDJ2rZoBvTPI8Xd3r3yHtuqsgHU2zpgKZXikzuUUk7e3zGvwST6Ounpva44ng8LrujpghcZ
	7voK8huREMWz6rSou7gEqGctn/auZihrErE/ZJ1k9ROA4Qmgg2j8RM2kgjKcYn+R4sTSAq6ogwr
	twpNa76fZ8SF9JKCuBak7WUHIfIgGcZZL8JDAiNKnGO7tknEXitGFb8YU23xg2INQ/I5RLaJnFn
	m5C/XXuXNXpZgx+m06xwFs+jV95kdnBravhEry2tZdp1tml+p27sULiD4DY7ynlf/E+mjuQ6Hob
	0ji5WRqp90BTYptY4TFNXLTFUjyJ4WJx6BUNKZKu0m9Ik6VJMAIKBNJCgpWmM16V6XWDzg07rK
X-Google-Smtp-Source: AGHT+IFS1SSpZp9KxAg6FhJIqHp9gOdWB3H3u9BePqWILGSiROt9rU6Bnj9TPkP+uSbNBUygJUY3oA==
X-Received: by 2002:a17:903:248:b0:295:507c:4b80 with SMTP id d9443c01a7336-29b6bfa0b8fmr111044815ad.61.1763971751912;
        Mon, 24 Nov 2025 00:09:11 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm12343837a12.0.2025.11.24.00.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:09:11 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/3] xsk: introduce atomic for cq in generic
Date: Mon, 24 Nov 2025 16:08:55 +0800
Message-Id: <20251124080858.89593-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the hot path (that is __xsk_generic_xmit()), playing with spin lock
is time consuming. So this series replaces spin lock with atomic
operations to get better performance.

Jason Xing (3):
  xsk: add atomic cached_prod for copy mode
  xsk: add the atomic parameter around cq in generic path
  xsk: convert cq from spin lock protection into atomic operations

 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 16 ++++------------
 net/xdp/xsk_buff_pool.c     |  1 -
 net/xdp/xsk_queue.h         | 37 ++++++++++++++++++++++++-------------
 4 files changed, 28 insertions(+), 31 deletions(-)

-- 
2.41.3


