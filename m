Return-Path: <bpf+bounces-34737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688BE930736
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 22:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B0228383A
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E21448DA;
	Sat, 13 Jul 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="aXn7YkOy"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350C18E20;
	Sat, 13 Jul 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720900976; cv=none; b=VFSqX6reXzPrsCwSUGF4BgBOyTdVTBvYsJ2tVZWFOZSHu9eF9XQvjyxSCpbKIl5YxlUMqbHoB0ir9yCuEk+oO2gg8nzBxV38UVv3vUd3LXuNUqsc0a9iwWBP4xV9XFz0NA5L+YzdxWtciavKWgzsSfIJKNVGA2cQ5jG48dpMf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720900976; c=relaxed/simple;
	bh=MM4eNVMg3kPNkxH5RchtX2R+vU+hx7d+zbMU1H0dI3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pan88N8OgZSAc4IF1xKs0/raUpmuuH0/kTgNphuozZPWdYhhet+Z6w1K6zSR6YjrlajLmYkSmAzEFfGasMuJ3eXVfck5NDso9c0LruSdmzNthWMc34wDoE+bsL/xkUr2aRg1DAvTUch5nf1YjgnFcWATC7UUXho+UiXLCiQmCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=aXn7YkOy; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sSix7-00FbQJ-US; Sat, 13 Jul 2024 22:02:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=cByYk0lvIWunhrbwXLOqV7Y742DeSDOR7RaGVk8RYhQ=; b=aXn7YkOyym/we
	MlC3a9HOVCjOEZ0MH4WPkWyZ25E6xAk0uoL9+iHZPHxdHeWvoaYomD2h4Rtz9v75IyE+iAGZQo/+W
	eKb2KOW0J+KnCLaxp+C0xHW5g3avbnnWMfDZ/+G4bz3loa7uhJW3B1QvvwqLGkq+YD22KIj57Uo5O
	xZ7rCQqHxiI7FFH79tILxo3W/xrZZsckDYbLEqI6Nzgi4bpqtkPjwOZCJ6WZ/9jw34tiChX8ClJix
	KV4pM61NS/H5ZxL+ak+DXmnkoCnb4j34RD4beDPT4RqFVZ/vkiZPgyeeiMnXJJ+1C7C245/IFYmZv
	XbpTQYjaWSnS7WFZg6T2A==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sSix7-0006ij-Hr; Sat, 13 Jul 2024 22:02:41 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sSix3-000dGr-1q; Sat, 13 Jul 2024 22:02:37 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	kuniyu@amazon.com,
	Rao.Shoaib@oracle.com,
	cong.wang@bytedance.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v4 0/4] af_unix: MSG_OOB handling fix & selftest
Date: Sat, 13 Jul 2024 21:41:37 +0200
Message-ID: <20240713200218.2140950-1-mhal@rbox.co>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PATCH 1/4 tells BPF redirect to silently drop AF_UNIX's MSG_OOB. The rest
is selftest-related.

Michal Luczaj (4):
  af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
  selftest/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
  selftest/bpf: Parametrize AF_UNIX redir functions to accept send()
    flags
  selftest/bpf: Test sockmap redirect for AF_UNIX MSG_OOB

 net/unix/af_unix.c                            | 41 ++++++++-
 net/unix/unix_bpf.c                           |  3 +
 .../selftests/bpf/prog_tests/sockmap_listen.c | 85 +++++++++++++------
 3 files changed, 102 insertions(+), 27 deletions(-)

-- 
2.45.2


