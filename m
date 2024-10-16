Return-Path: <bpf+bounces-42253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2E9A163F
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 01:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF7A2821B7
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7007C282FA;
	Wed, 16 Oct 2024 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GoGkAMWY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614731D435E
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122547; cv=none; b=cy9r5RyvAwrG+ke/BsEqRx93RQCzG9ZYTWl+38zO7Ohnkqqf7Dz30+txH5UySpT7iZDfPqhrv6ZoDZGNoHgIhS1KQakpL8iRe5qA4Fu6T+y5EJZ0dx5LRyHdQQDGxj7hSHHtKq7r0vTgL2qeoWfQv2LrpjGEXz7Ap/uKEyxa42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122547; c=relaxed/simple;
	bh=DFfOAEhm0wwd660UDeRRZMCCxWuL4iFN9ljeYOxZD/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UYJqzZq9Bl3XqGjFF52nwPf83dJdGAPDdJwAPvmPOGjBuhMl5V48R6wpDGP4p1CTwByGWFL3Ew2EYuLaaYXPrsg1Y1S+OY8ccIKISC8wAYSM6uqQntnWiVjX8Kd9T4E91HkTwAoxGLtt1Ffvs4be54JazKekaKljd2w+4PjAauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GoGkAMWY; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cc250bbc9eso2498686d6.2
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729122544; x=1729727344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCJq8JdZ6dGQki8YzsoJsRY61CTBjWLkvdOWRxyyBqI=;
        b=GoGkAMWYZXCTtKPNmPRfm5gcZGaV9+3ETfvP5d5w59Qtj1xqYrlwpowTIx0AW8VW/r
         NXmoARiAvzGC8klJtwq3Gy/M7Jx9zovi7VVLiryJMAk2z7WoeoEeWBj/rVapSl2iw3Kf
         65wEC/40aZNfslgGJ8tkSkvMGHNqw218AU+cESdUbZszD3HYIXEYpEkSa+gJaEZ8SzbN
         70XezGrz3lu/uKLVNjAmltQ92Pm3RlBiizrjjXfmn0QK0rPaIDf2pzrZUbKqdz5xyE1b
         4lk8rWV+O7kZL3q/mEzldqyLngY5ISMDhY6sIEoLmXx1s1RJSU7tn//TUagcTYt/v4V2
         Ed+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729122544; x=1729727344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCJq8JdZ6dGQki8YzsoJsRY61CTBjWLkvdOWRxyyBqI=;
        b=HYmLtxtv82xOBA7jCm+AWv2KdQUr+Dg/MaywqSvzYCmNcKuXR5F9beNiGUNAmXuoX7
         7zVG9D8CfvgbkiyPzy2Ji8s1rVKx79+kImgm6kelhQ50BTXr5IvKG/b7wXC3B9j+4qn1
         Jhq+AP2jmDeEi3Bg8eXnGxOKYbFCShKrcEA7q+kHc1L+hHF4AdNwSFuC2LtmjbcpZXnq
         gnXWvMfdBXklRslec4IRxiwbnd5XyrfUY6iELOpGAOTqnIbWaC52o5g+OSh1DmpU0hch
         +M8SZE8mwnALSne22sX5NSDdvdo1DS56wj6OrdEpEgwUPUk1nR/iijTCgHfF/C5KvbNs
         tW5g==
X-Gm-Message-State: AOJu0YzrPqv9l5RhoJOqH6hg6CFkA081EsFymGIxQ3w5Dlcg6elrzP6U
	LhQFvQ551pwZ50LPmtOHZgncQm4dnsnkhTOG7vhCN+vox4K1KZFqgPh3JrxijrsKUv5PnG+SLnq
	y
X-Google-Smtp-Source: AGHT+IGOxqv93v5Vah9TH8paZStqqO9CIaTSchGZYM6BCd3s7G6jnI9HhwKLOQCq+nY/Kaq9eq+IhA==
X-Received: by 2002:ad4:56e5:0:b0:6cb:f5f8:9099 with SMTP id 6a1803df08f44-6cbf5f890cdmr218331136d6.0.1729122543866;
        Wed, 16 Oct 2024 16:49:03 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22959ae2sm22909296d6.93.2024.10.16.16.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 16:49:02 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	wangyufen@huawei.com,
	xiyou.wangcong@gmail.com,
	zijianzhang@bytedance.com
Subject: [PATCH bpf 0/2] tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg
Date: Wed, 16 Oct 2024 23:48:36 +0000
Message-Id: <20241016234838.3167769-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

When apply_bytes are not zero, sk_mem_uncharge for __SK_REDIRECT and
__SK_DROP in tcp_bpf_sendmsg has some problem. Added a selftest to trigger
the memory accounting WARNING, and fixed the sk_mem_uncharge logic in
tcp_bpf_sendmsg

Zijian Zhang (2):
  selftests/bpf: Add apply_bytes test to test_txmsg_redir_wait_sndmem in
    test_sockmap
  tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg

 net/ipv4/tcp_bpf.c                         | 11 ++++-------
 tools/testing/selftests/bpf/test_sockmap.c |  6 +++++-
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.20.1


