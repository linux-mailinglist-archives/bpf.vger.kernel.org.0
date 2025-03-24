Return-Path: <bpf+bounces-54607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E45A6D9C7
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 13:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EF63B1038
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9F25E457;
	Mon, 24 Mar 2025 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz8bpSUE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D528E7
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817833; cv=none; b=V+ba3Td9qvnwRivwtGCwE8kQdh4twGPKfh1AkFmFCtHUVQu7p31kLfWIab2uFwBUEmeUSTauu/JnO+YHbz4Kh4WZXxLHsYDwmPrjO8JK64uTR4QZn7WoVbb4Ml+t/Z0t/0NeJh8gjLKUwnPz4gxzvAbRIMfuuYW4ShcPtgyjl50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817833; c=relaxed/simple;
	bh=b9Mx7w0bFWbbRh8G9JEqKnuwMa0XSyh4MO/kAcbxdVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HODNEJdbr4nJVpubYTB23SSHu/ebqR8UsG8TDGPQasWe7Sicyw1uTIvi9akeB+nWcjwCZJ1oSv549OlqwAIQYFh/6avwW4CNqNx0f2DF2HI/TxM3QNi0/mRzwpylY4rQyglP/36GAJGz2oQLTj+eQJchqhYM/r5idE1PHm0xA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sz8bpSUE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742817831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=knQteduWqKsIoQ1kXt7nlTUM6/T5qWRh6iVTwq26DHE=;
	b=Sz8bpSUEKPCFKri5qZaOjVI27jEpL2CJlD+Ck7rEGB7t4UMOul9hjfZqHFA43RhLRqPXDx
	fOVVyVgYHh5wpRqSgxO5tUrzMBdaxR8sjR7f3fd3fs+eXgU+YLxXhtA799PQxrbH4GgOUN
	eBMHAwWbx11P/rPmVLn4Tr4Epv9n38c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-wAueAqK0Mj2UKw6a79ndcw-1; Mon,
 24 Mar 2025 08:03:44 -0400
X-MC-Unique: wAueAqK0Mj2UKw6a79ndcw-1
X-Mimecast-MFC-AGG-ID: wAueAqK0Mj2UKw6a79ndcw_1742817822
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEDD91800262;
	Mon, 24 Mar 2025 12:03:41 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.25])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1050E180A802;
	Mon, 24 Mar 2025 12:03:35 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v3 0/3] bpf: Add kfuncs for read-only string operations
Date: Mon, 24 Mar 2025 13:03:27 +0100
Message-ID: <cover.1741874348.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

String operations are commonly used in programming and BPF programs are
no exception. Since it is cumbersome to reimplement them over and over,
this series introduce kfuncs which provide the most common operations.
For now, we only limit ourselves to functions which do not copy memory
since these usually introduce undefined behaviour in case the
source/destination buffers overlap which would have to be prevented by
the verifier.

The kernel already contains implementations for all of these, however,
it is not possible to use them from BPF context. The main reason is that
the verifier is not able to check that it is safe to access the entire
string if the string size is not passed to the kfunc. Therefore, the
unbounded variants of the operations are open-coded with
__get_kernel_nofault used instead of plain dereference to make them
safe. 

On the contrary, safety of the bounded variants can be checked by the
verifier so we reuse the kernel implementations which are sometimes
highly optimized in assembly.

The last patch of the series adds a benchmark for comparing performance
of the bounded and unbounded variants which shows that on architectures
with optimized bounded string functions (e.g. strnlen on arm64), the
performance benefit can be significant (140% for 4095B strings).

Changes in v3:
- Open-code unbounded variants with __get_kernel_nofault instead of
  dereference (suggested by Alexei).
- Use the __sz suffix for size parameters in bounded variants (suggested
  by Eduard and Alexei).
- Make tests more compact (suggested by Eduard).
- Add benchmark.

Viktor Malik (3):
  bpf: Add kfuncs for read-only string operations
  selftests/bpf: Add tests for string kfuncs
  selftests/bpf: Add benchmark for bounded/unbounded string kfuncs

 kernel/bpf/helpers.c                          | 299 ++++++++++++++++++
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  21 ++
 .../bpf/benchs/bench_string_kfuncs.c          | 259 +++++++++++++++
 .../bpf/benchs/run_bench_string_kfuncs.sh     |  34 ++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  10 +
 .../selftests/bpf/progs/string_kfuncs.c       |  58 ++++
 .../selftests/bpf/progs/string_kfuncs_bench.c |  88 ++++++
 8 files changed, 771 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_string_kfuncs.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_string_kfuncs.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_bench.c

-- 
2.48.1


