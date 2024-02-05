Return-Path: <bpf+bounces-21240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57184A28C
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAB61F23AC3
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF52E3FD;
	Mon,  5 Feb 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXpIut8y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCF481B3
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158377; cv=none; b=shhyoYNbxXMPgx4l9uLoRXQEPwsgRiI6XGFrBelP7Y/vtTwsUVmL7tgvRf0vhyEArvId9zV4pHfrjtp677Jmx8fMzAMMjCa4IhlcOSEnaF8JpOdNX0bPkLKd5niIx+wKZ0EduGue6DnQLAHOpxsiDoSqE0dgpAqJz4f6prVWiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158377; c=relaxed/simple;
	bh=Pg6bhrmnyt1nmIdAOq7FpYuy9nSSAJ2pyJ6mifXYe2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i57ptcalqNTEtzT0HWvlp7EM6EuuNKm4f8I8ONs6cCC/Co7mjKMnvsU/m0AL/yBPoAmevjB9NsBB/dYwhMyl183PvExzqf5IPTJVUJmGWr5POnW+mYU4kMEMGb6PqbHo+H1qkCxKPdN9D+VwSETn9Ah2KCkTMElox+0I7N/jLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXpIut8y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707158374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wNOqDMi3a7MzjJZlBXITaVgoIn5uuPHce6KfBEKVYgk=;
	b=hXpIut8ygd838jkkhmrwQ/qfqTOu73TC1itblsFuWwPz+uJJA1PL1k8dd4IQvpRNDdJ9KX
	BIbyD5rN7mYQWf8YXUTR6EY/8XuRL0SldCASCUhmPszbnwD4btNL84zNSdFNISRLlfkjtE
	6cg0YGC4Pwn1N3ExxblxwVLBz91IDaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-_ZYmyABeNPKlcCmQ7L2EwQ-1; Mon, 05 Feb 2024 13:39:31 -0500
X-MC-Unique: _ZYmyABeNPKlcCmQ7L2EwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05D42845E64;
	Mon,  5 Feb 2024 18:39:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.202])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 442EC2026F95;
	Mon,  5 Feb 2024 18:39:26 +0000 (UTC)
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Manu Bretelle <chantr4@gmail.com>
Subject: [PATCH bpf-next v3 0/2] tools/resolve_btfids: fix cross-compilation to non-host endianness
Date: Mon,  5 Feb 2024 19:39:21 +0100
Message-ID: <cover.1707157553.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
build and afterwards patched by resolve_btfids with correct values.
Since resolve_btfids always writes in host-native endianness, it relies
on libelf to do the translation when the target ELF is cross-compiled to
a different endianness (this was introduced in commit 61e8aeda9398
("bpf: Fix libelf endian handling in resolv_btfids")).

Unfortunately, the translation will corrupt the flags fields of SET8
entries because these were written during vmlinux compilation and are in
the correct endianness already. This will lead to numerous selftests
failures such as:

    $ sudo ./test_verifier 502 502
    #502/p sleepable fentry accept FAIL
    Failed to load prog 'Invalid argument'!
    bpf_fentry_test1 is not sleepable
    verification time 34 usec
    stack depth 0
    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
    Summary: 0 PASSED, 0 SKIPPED, 1 FAILED

Since it's not possible to instruct libelf to translate just certain
values, let's manually bswap the flags (both global and entry flags) in
resolve_btfids when needed, so that libelf then translates everything
correctly.

The first patch of the series refactors resolve_btfids by using types
from btf_ids.h instead of accessing the BTF ID data using magic offsets.

---
Changes in v3:
- add byte swap of global 'flags' field in btf_id_set8 (suggested by
  Jiri Olsa)
- cleaner refactoring of sets_patch (suggested by Jiri Olsa)
- add compile-time assertion that IDs are at the beginning of pairs
  struct in btf_id_set8 (suggested by Daniel Borkmann)

Changes in v2:
- use type defs from btf_ids.h (suggested by Andrii Nakryiko)

Viktor Malik (2):
  tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
  tools/resolve_btfids: fix cross-compilation to non-host endianness

 tools/bpf/resolve_btfids/main.c | 64 +++++++++++++++++++++++++++------
 tools/include/linux/btf_ids.h   |  9 +++++
 2 files changed, 63 insertions(+), 10 deletions(-)

-- 
2.43.0


