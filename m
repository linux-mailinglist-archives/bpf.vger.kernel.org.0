Return-Path: <bpf+bounces-39564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E8B9748B7
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BE12882A3
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077683D96D;
	Wed, 11 Sep 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EjQ51H5o"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A571282F7;
	Wed, 11 Sep 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025847; cv=none; b=niSsasjA85q8yzEWTj9B8P1HuPWS34BzofIh5oSSSlcL2bbc0Moz3ezNooN2pqhqZOM66Ntv1ez+ZClUrbaDjhNqAHCCERhRziZ9SedTbnGnuXZpuwV7E5XAxb1kQA0E12N0HQGoyVapHhw+iPLgbS6XGnV4Uh4PUMs3uC1VakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025847; c=relaxed/simple;
	bh=pcNpwywcyIEWLgb/rkhZ1bhZN5kJv39O4SYeNb89Oro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ei0KYKp9b4BbpamfuHtx21TSNMFVDPYN4/oB7I9NECWblv/qSVr21ELXnXREh/YrGn0kDeQwPI1vpkZ0FcIscNiu9+O1Zqm2/+hwvk2PlcHRVCTla+2RiVxZiDecEt1oHc+KrLXxN0rV4bY6I9iT2lgKfQ0Vh40wqJ3FOXtogBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EjQ51H5o; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726025842; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AZ4UdEBxNssNLlu4rmjUD1+Uig6aAgZmp+sRlcEzI3g=;
	b=EjQ51H5oqxs0OPvWraRy62zLoA4SXS8hPZKBIwv0mKvnh8XrwydB3m9x9PI9ASjJYVdiSlihe3ak7WYvovWHYr5/auXx+Hp4bQwO3tYP9VzTmRH970z24kRVdm8m+tQT/SIHnyr6p8U5a9I2sVXCibTo0cp+11qYmXuaH3q2BYA=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEmJNZH_1726025839)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 11:37:20 +0800
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
Subject: [PATCH bpf-next v3 0/5] bpf: Allow skb dynptr for tp_btf
Date: Wed, 11 Sep 2024 11:37:14 +0800
Message-Id: <20240911033719.91468-1-lulie@linux.alibaba.com>
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
v2 -> v3 (Andrii Nakryiko):
 Patch 1:
  - Remove prog type check in prog_arg_maybe_null()
  - Add bpf_put_raw_tracepoint() after get()
  - Use kallsyms_lookup() instead of sprintf("%ps")
 Patch 2: Add separate test "tp_btf_nullable", and use full failure msg
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
 kernel/bpf/btf.c                              |  9 +++++
 kernel/bpf/verifier.c                         | 36 ++++++++++++++++---
 net/core/filter.c                             |  3 +-
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  6 ++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 ++
 .../testing/selftests/bpf/prog_tests/dynptr.c | 36 +++++++++++++++++--
 .../bpf/prog_tests/tp_btf_nullable.c          | 14 ++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 25 +++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 23 ++++++++++++
 .../bpf/progs/test_tp_btf_nullable.c          | 24 +++++++++++++
 11 files changed, 177 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c

--
2.32.0.3.g01195cf9f


