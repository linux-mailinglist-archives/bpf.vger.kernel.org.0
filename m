Return-Path: <bpf+bounces-19819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCCB831CAF
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 16:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8951F215C3
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004532575C;
	Thu, 18 Jan 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HW8b1b/n"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6023741;
	Thu, 18 Jan 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592390; cv=none; b=IRUz4+1U5ry1S0+5PE+IHQ9zYT6yXj/6TMQ0niAci5jbOIHt77oySjpmgfnF/Ny9XzvCjLSbgwJfyTQPSKVI1+hne4H1+53qJ4kYoVooEWdVgeXkXE2yXtFByvVW9ytQNWBelF28s7F9JdaaNgO19m0GvXxdZYfnrs7qxWjThpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592390; c=relaxed/simple;
	bh=t1ixpqNa0Al9bt5CBH49/fYjoBI39QDMqXsPj57Vcmw=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authenticated-Sender:X-Virus-Scanned; b=QuTPc4HU4lWkNOpr6mhD9S8ha78IfKfD3VMzf1w1Ki8tj5fC5TuT9GhXMTWK/oa30Tqanian9CKq7PCxCJUUtMiMUEerg5ArkVZm2/Qsq5VOPjdAMpKkCr3bTt6JXw5EFdlfOu0i0gAxsfkqBh19QKpgGwbQh4VDy+PTf4Pe76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HW8b1b/n; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=CtwVExvBIVDcDDaph/forOCRNFeXQfKZzFwu31o2+xU=; b=HW8b1b/nYlo8u+C/ewOn3AO9lp
	MDTu4i/PYvz/sIq6VH5Dwu8gy03QPbOItH7H/Mv8h3acmOvKtxGkuQRXMculdtsOcrhEtkjoFry3d
	RaxJHCb5+aiU9CSoEEJGxuNIJU6mA3y+0Vf9QIndV10jci1FiEsrs17NFG1E6kurljEMeZbJpl+J4
	fooVQqHfFFYgdMNh8u1gQYBjLb/wlJvrEWAem5FN9y54clP2VLO8JK4tNW+j7c0WthjbHNZN+LSzo
	6ijYueKzvRjjowXcGnyWmvdGHIzlCuheNJJjzf2OuDQ7J4pAYjk2d1nlLad5G+AObw4jiTf4Gab1/
	toeMM8Ng==;
Received: from 17.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rQUUT-000A5n-FV; Thu, 18 Jan 2024 16:39:37 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2024-01-18
Date: Thu, 18 Jan 2024 16:39:36 +0100
Message-Id: <20240118153936.11769-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27158/Thu Jan 18 10:41:33 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 10 non-merge commits during the last 5 day(s) which contain
a total of 12 files changed, 806 insertions(+), 51 deletions(-).

The main changes are:

1) Fix an issue in bpf_iter_udp under backward progress which prevents user
   space process from finishing iteration, from Martin KaFai Lau.

2) Fix BPF verifier to reject variable offset alu on registers with a type
   of PTR_TO_FLOW_KEYS to prevent oob access, from Hao Sun.

3) Follow up fixes for kernel- and libbpf-side logic around handling arg:ctx
   tagged arguments of BPF global subprogs, from Andrii Nakryiko.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Aditi Ghag, Yonghong Song

----------------------------------------------------------------

The following changes since commit 894d7508316e7ad722df597d68b4b1797a9eee11:

  net: netdev_queue: netdev_txq_completed_mb(): fix wake condition (2024-01-13 18:26:23 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 35ac085a94efe82d906d3a812612d432aa267cbe:

  Merge branch 'tighten-up-arg-ctx-type-enforcement' (2024-01-17 20:20:06 -0800)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (2):
      Merge branch 'bpf-fix-backward-progress-bug-in-bpf_iter_udp'
      Merge branch 'tighten-up-arg-ctx-type-enforcement'

Andrii Nakryiko (5):
      libbpf: feature-detect arg:ctx tag support in kernel
      bpf: extract bpf_ctx_convert_map logic and make it more reusable
      bpf: enforce types for __arg_ctx-tagged arguments in global subprogs
      selftests/bpf: add tests confirming type logic in kernel for __arg_ctx
      libbpf: warn on unexpected __arg_ctx type when rewriting BTF

Hao Sun (2):
      bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
      selftests/bpf: Add test for alu on PTR_TO_FLOW_KEYS

Martin KaFai Lau (3):
      bpf: iter_udp: Retry with a larger batch size without going back to the previous bucket
      bpf: Avoid iter->offset making backward progress in bpf_iter_udp
      selftests/bpf: Test udp and tcp iter batching

 include/linux/btf.h                                |   2 +-
 kernel/bpf/btf.c                                   | 231 ++++++++++++++++++---
 kernel/bpf/verifier.c                              |   4 +
 net/ipv4/udp.c                                     |  22 +-
 tools/lib/bpf/libbpf.c                             | 142 ++++++++++++-
 .../selftests/bpf/prog_tests/sock_iter_batch.c     | 135 ++++++++++++
 .../selftests/bpf/prog_tests/test_global_funcs.c   |  13 ++
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   3 +
 .../testing/selftests/bpf/progs/sock_iter_batch.c  |  91 ++++++++
 tools/testing/selftests/bpf/progs/test_jhash.h     |  31 +++
 .../selftests/bpf/progs/verifier_global_subprogs.c | 164 ++++++++++++++-
 .../bpf/progs/verifier_value_illegal_alu.c         |  19 ++
 12 files changed, 806 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_iter_batch.c

