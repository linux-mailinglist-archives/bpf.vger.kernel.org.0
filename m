Return-Path: <bpf+bounces-28257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0F8B7593
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 14:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F33228393A
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053213DB90;
	Tue, 30 Apr 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l29fQI9B"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D012D755
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479498; cv=none; b=jevpq5nJXF47A+4cWHbNqUbaqkJo/acvUfj+eRw9VnsV9PlBbrfBVKXBPhIGFZLATO+EIAbwfWCS19CktDqWIs+MZsRzizoHinMN6XhWxg6irf9R1ta2RO4aRMMDkWtfGJetU2j3sJ2mlZ1nfVkEXDyuxAMicqrCjZE4x2g3Czs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479498; c=relaxed/simple;
	bh=dPSsH0GZNtnWu2NW2iWIhhOkmqNFgSQujrGR/iDYe7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qURpJJuWcRRMjKvbUUXyjOdji9Aek3Y7AYEkiihwmG54BGdbP1houNUYUtOdfU4LPkgiWyKU7jKryOdGqz20bJbwS+ym3ODRjE54pC2WKjaPBjebVPD9bgPP3ax5s4joqZn0Ib3gUcx7OXBsq9jQIhQMS17pfmmBk0UWMHFcSvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l29fQI9B; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714479488; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=trZpt6kGsrKog7Y0eP2zTn1GwQfgMxFjWiztnpqSft0=;
	b=l29fQI9BUOlNha9GZtBduSkX1v4BAoWHx9tVvZjBbM9gq1c5JeiP7a5ytJwwb1fiOKgnBouBnl0sdLxh56f5D6ODhzDBarnV/QPPpH60QIdGCI+L2LqfzMVTFN8GvRyptHOHP46XtRb9RkNLWZuaY/Q44PmJg9WPWhEWYzbB2a0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W5cFrMK_1714479485;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W5cFrMK_1714479485)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 20:18:07 +0800
From: Philo Lu <lulie@linux.alibaba.com>
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
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	drosen@google.com,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH bpf-next 0/2] bpf: Allow skb dynptr for tp_btf
Date: Tue, 30 Apr 2024 20:18:03 +0800
Message-Id: <20240430121805.104618-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes bpf_dynptr_from_skb usable for tp_btf, so that we can easily
parse skb in tracepoints. This has been discussed in [0], and Martin
suggested to use dynptr (instead of helpers like bpf_skb_load_bytes).

For safety, skb dynptr shouldn't be used in fentry/fexit. This is achieved
by add KF_TRUSTED_ARGS flag in bpf_dynptr_from_skb defination. IIUC, the
flag can be added to current defination directly, because skb is always
passed from ctx. But I'm not definitely sure about this. Please tell me if
there is any problem. Thanks in advance.

Selftests are expanded with skb dynptr used in tp_btf. They also make sure
that skb dynptr cannot be used in fentry/fexit.

[0]
https://lore.kernel.org/all/20240205121038.41344-1-lulie@linux.alibaba.com/T/

Philo Lu (2):
  bpf: Allow bpf_dynptr_from_skb() for tp_btf
  selftests/bpf: Expand skb dynptr selftests for tp_btf

 net/core/filter.c                             |  3 +-
 .../testing/selftests/bpf/prog_tests/dynptr.c | 36 +++++++++++++++++--
 .../testing/selftests/bpf/progs/dynptr_fail.c | 25 +++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 23 ++++++++++++
 4 files changed, 84 insertions(+), 3 deletions(-)

--
2.32.0.3.g01195cf9f


