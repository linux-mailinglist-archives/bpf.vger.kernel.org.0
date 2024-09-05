Return-Path: <bpf+bounces-38961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B305E96D0EF
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FFD1C22D23
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A72194A60;
	Thu,  5 Sep 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L4bo04zg"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A73193432;
	Thu,  5 Sep 2024 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522996; cv=none; b=DhFOcnKj8/cOjGJdk+OdWLqwCqIQZnLIhoM/hI8vs4XSnN3vk3Z5JhfHIpe5JbdFe7njU/ZHDLUdrSoU3uLEsamw4h96eay954bCgCHSxI3O17IHZAC2KRQ5SX0wFSbwXjuRdekaP5jFoBrl+aQ7ANAeT2n2vwAfMnmBw98EQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522996; c=relaxed/simple;
	bh=HSbCsyWENOOlMPThk6GgcaOBaiG7kMtdEQK1puFpCCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzz2S7OhoQBKaZGh5qzbEIIzj7go4X0GaOKakgxLIEUdYjFulAvRbhCemo2eCuazxBCjKqFyrfWzalimIZmubVoo2R3pnU30luoMpfk/xwt60LggmmjRY5o1P+XInW2Zcr0AtbhNN2t7agi7M+YP1tmUCmqnDKRz6P2guPg+v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L4bo04zg; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725522985; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sdh8MrBU0BE1JM2cVtdUOToCDqNaIfDOUqNsR5L7rn0=;
	b=L4bo04zg6MRiFYvs9nQztuMphzhmcWtuap5Mx0/KIemsmFkgLaD6Uwyv/D0SZ5YmMceHboexUakg+2xtCymiI7fDnQektrSImUOgnn6djl7NkLihEeM+9mGEeTp/4vGEtU7z7BD5XReW6KovY5afMaBndjLd2frQmZO/pmHEldY=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEKuTB4_1725522982)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 15:56:23 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	juntong.deng@outlook.com,
	jrife@google.com,
	alan.maguire@oracle.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	vmalik@redhat.com,
	cupertino.miranda@oracle.com,
	mattbobrowski@google.com,
	xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/5] bpf: Allow skb dynptr for tp_btf
Date: Thu,  5 Sep 2024 15:56:17 +0800
Message-Id: <20240905075622.66819-1-lulie@linux.alibaba.com>
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
by add KF_TRUSTED_ARGS flag in bpf_dynptr_from_skb defination, because
pointers passed by tracepoint are trusted (PTR_TRUSTED) while those of
fentry/fexit are not.

Another problem raises that NULL pointers could be passed to tracepoint,
such as trace_tcp_send_reset, and we need to recognize them. This is done
by add a "__nullable" suffix in the func_proto of the tracepoint,
discussed in [1].

2 Test cases are added, one for "__nullable" suffix, and the other for
using skb dynptr in tp_btf.

changelog
v1 -> v2:
 - Add "__nullable" suffix support (Alexei Starovoitov)
 - Replace "struct __sk_buff*" with "void*" in test (Martin KaFai Lau)

[0]
https://lore.kernel.org/all/20240205121038.41344-1-lulie@linux.alibaba.com/T/
[1]
https://lore.kernel.org/all/20240430121805.104618-1-lulie@linux.alibaba.com/T/

Philo Lu (5):
  bpf: Support __nullable argument suffix for tp_btf
  selftests/bpf: Add test for __nullable suffix in tp_btf
  tcp: Use skb__nullable in trace_tcp_send_reset
  bpf: Allow bpf_dynptr_from_skb() for tp_btf
  selftests/bpf: Expand skb dynptr selftests for tp_btf

 include/trace/events/tcp.h                    | 12 +++----
 kernel/bpf/btf.c                              | 13 +++++++
 kernel/bpf/verifier.c                         | 36 +++++++++++++++++--
 net/core/filter.c                             |  3 +-
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  6 ++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 ++
 .../testing/selftests/bpf/prog_tests/dynptr.c | 36 +++++++++++++++++--
 .../selftests/bpf/prog_tests/module_attach.c  | 14 +++++++-
 .../testing/selftests/bpf/progs/dynptr_fail.c | 25 +++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 23 ++++++++++++
 .../bpf/progs/test_module_attach_fail.c       | 16 +++++++++
 11 files changed, 173 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_module_attach_fail.c

--
2.32.0.3.g01195cf9f


