Return-Path: <bpf+bounces-38692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96952967FD4
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 08:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181911F21E03
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 06:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18D315688F;
	Mon,  2 Sep 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY/A94p4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2692156993
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260303; cv=none; b=sZxLmmZzWjQ4O6kPlQllMEQu+tcZRICCuLULtbus9JoJ8GEPdFv5i9kR91vB8FWxYJoRiefjn3pcTRRVGZc75zZ2dWPOpIdxLPJ2DDk7ffLsB5GEdGPR2f7Z66bbYGzYEIlEmmhiq+NrXfE4yg3nCxHGB1TQo+fp2eb7uQRN6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260303; c=relaxed/simple;
	bh=saHlauwphIY91kJYi7VA3uGYSbpwq2dLuLO3kDG/LU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPAPv/DjEZnf6QuGIkQZMmC5HsFCSqZ0wKRf7OKDYQuOWaP9u0Q+bbKPjCZSo0d25e0+FmN8p49UhPX9OYS2/aA5ezCVC7W002srgyg2F/nioUyRDQf+TxtmLyzIwloRZyqBbvkMU3U7VbbDjj26ttU33NY7F7pRIWnN5avypwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UY/A94p4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725260299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BcGXtD2tl3sp0YWsj1/lBrsPPNj1kaLexePfoEWhwlw=;
	b=UY/A94p4lfe2ns3mx5Xf3OAeYeGv9MRlvcZQeEselISNPLqkvW+DHv6Lc4wlRkyvHN83TB
	FQDzFMqusqqN8nOH6mp9kkpMN2DLesRXVpHwhcHd5+2l0ajYEs0AWCFE0ULVqHaV7o8yc8
	5qkdfNt3po3CLhlC8zxznSokfGbg6uo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-qoIQqxM5PQWbNnfsrvUFgQ-1; Mon,
 02 Sep 2024 02:58:18 -0400
X-MC-Unique: qoIQqxM5PQWbNnfsrvUFgQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D69E1955F6A;
	Mon,  2 Sep 2024 06:58:15 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A73119560A3;
	Mon,  2 Sep 2024 06:58:09 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC bpf-next 0/3] libbpf: Add support for aliased BPF programs
Date: Mon,  2 Sep 2024 08:58:00 +0200
Message-ID: <cover.1725016029.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

TL;DR

This adds libbpf support for creating multiple BPF programs having the
same instructions using symbol aliases.

Context
=======

bpftrace has so-called "wildcarded" probes which allow to attach the
same program to multple different attach points. For k(u)probes, this is
easy to do as we can leverage k(u)probe_multi, however, other program
types (fentry/fexit, tracepoints) don't have such features.

Currently, what bpftrace does is that it creates a copy of the program
for each attach point. This naturally results in a lot of redundant code
in the produced BPF object.

Proposal
========

One way to address this problem would be to use *symbol aliases*. In
short, they allow to have multiple symbol table entries for the same
address. In bpftrace, we would create them using llvm::GlobalAlias. In
C, it can be achieved using compiler __attribute__((alias(...))):

    int BPF_PROG(prog)
    {
        [...]
    }
    int prog_alias() __attribute__((alias("prog")));

When calling bpf_object__open, libbpf is currently able to discover all
the programs and internally does a separate copy of the instructions for
each aliased program. What libbpf cannot do, is perform relocations b/c
it assumes that each instruction belongs to a single program only. The
second patch of this series changes relocation collection such that it
records relocations for each aliased program. With that, bpftrace can
emit just one copy of the full program and an alias for each target
attach point.

For example, considering the following bpftrace script collecting the
number of hits of each VFS function using fentry over a one second
period:

    $ bpftrace -e 'kfunc:vfs_* { @[func] = count() } i:s:1 { exit() }'
    [...]

this change will allow to reduce the size of the in-memory BPF object
that bpftrace generates from 60K to 9K.

For reference, the bpftrace PoC is in [1].

The advantage of this change is that for BPF objects without aliases, it
doesn't introduce any overhead.

Limitations
===========

Unfortunately, the second patch of the series is only sufficient for
bpftrace approach. When using bpftool to generate BPF objects, such as
is done in selftests, it turns out that libbpf linker cannot handle
aliased programs. The reason is that Clang doesn't emit BTF for the
aliased symbols which the linker doesn't expect. This is resolved by the
first patch of the series which improves searching BTF entries for
symbols such that an entry for a different symbol located at the same
address can be used. This, however, requires an additional lookup in the
symbol table during BTF id search in find_glob_sym_btf, increasing the
complexity of the method.

To quantify the impact of this, I ran some simple benchmarks.
The overhead naturally grows with the number of programs in the object.
I took one BPF object from selftests (dynptr_fail.bpf.o) with many (72)
BPF programs inside and extracted some stats from calling

    $ bpftool gen object dynptr_fail.bpf.linked.o dynptr_fail.bpf.o

Here are the stats:

    master:
        0.015922 +- 0.000251 seconds time elapsed  ( +-  1.58% )
        10 calls of find_sym_by_name

    patchset:
        0.020365 +- 0.000261 seconds time elapsed  ( +-  1.28% )
        8382 calls of find_sym_by_name

The overhead is there, however, the linker is still fast for quite a
large number of BPF programs so it would probably cause a noticeable
slowdown only for BPF objects containing thousands of programs.

Another limitation is that aliases cannot be used in combination with
section name-based auto-attachment as the program only exists in a
single section.

Alternative solutions
=====================

As an alternative, bpftrace could use a similar approach to what
retsnoop [2] does: load the program just once and clone it for each
match using manual call of bpf_prog_load. This is certainly feasible but
requires each tool which wants to do this to reimplement the logic.

This patch series is an alternative to retsnoop's approach which I think
is easier to use from tools' perspective so I'm posting this RFC to see
what people think about it.

Viktor

[1] https://github.com/viktormalik/bpftrace/tree/alias-expansion
[2] https://github.com/anakryiko/retsnoop/blob/master/src/mass_attacher.c#L1096

Viktor Malik (3):
  libbpf: Support aliased symbols in linker
  libbpf: Handle relocations in aliased symbols
  selftests/bpf: Add tests for aliased programs

 tools/lib/bpf/libbpf.c                        | 143 ++++++++++--------
 tools/lib/bpf/linker.c                        |  68 +++++----
 .../selftests/bpf/prog_tests/fentry_alias.c   |  41 +++++
 .../selftests/bpf/progs/fentry_alias.c        |  83 ++++++++++
 4 files changed, 246 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_alias.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_alias.c

-- 
2.46.0


