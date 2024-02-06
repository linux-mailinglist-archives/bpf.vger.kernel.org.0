Return-Path: <bpf+bounces-21303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF5384B581
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 13:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901631C23C0F
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE12612D762;
	Tue,  6 Feb 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmZ8yABg"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7B1AB813
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223584; cv=none; b=Y6QPD+8PQ1N2myujfMg46AJR7RY8wGiWgyVQ0pZ3mt2SKuPTzvFR4/JqVIxARLspT3WShkjRy3g4juamPQnycP+XYeSwCMfXgZ3MPzvzwi3NcgAFkyU45seemDZFD/btjvTMIDlqMnpZlQhSDqGPF/FGSsD0EZcJCFHIdEfTexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223584; c=relaxed/simple;
	bh=ZqvHTzNs8oxZWo7+BR1NeOZnQ2ps35YVf3y3xLIDsYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0azCcfmwsLmTBZ2qXrehSEykiPGajY6bqXGH05quDSRpAqpBeGeJ2gTOBZR5ag2oSffQ/DZhoAr9OclO5Su45l8OvqiTN2V+WO9xNdK4hOUJm9IaP2GT/V01rhcSlFpKubEwLQF052DSI7CPgFEF0GEPDLQm2XA+ZvTS9Z72h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmZ8yABg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707223581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cSDuh24pkVF0rYVVE4NLT2A39A0AIU0AaSSNVUpIUmA=;
	b=BmZ8yABgtzWYbkP15sGfoP4ZDW40PEMOUeMrR4E/Bsnh/7cPdVC5X+Lx/lUNazn36oAWnw
	rftZAqbjGw6K3XamMe/QenZKTwP1iXxqOnHGcq32IVLW84Wqbb/HZgJ08MgpvK70K7rLeH
	KsFlMQxUOZ5BQcUOZDdF765mYOjOick=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-c11FK6XPPrubAUgvOF2Pjg-1; Tue, 06 Feb 2024 07:46:18 -0500
X-MC-Unique: c11FK6XPPrubAUgvOF2Pjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40BA083B821;
	Tue,  6 Feb 2024 12:46:17 +0000 (UTC)
Received: from dhcph057.fit.vutbr.com (unknown [10.45.225.89])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A15D51121312;
	Tue,  6 Feb 2024 12:46:13 +0000 (UTC)
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
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Manu Bretelle <chantr4@gmail.com>
Subject: [PATCH bpf-next v4 0/2] tools/resolve_btfids: fix cross-compilation to non-host endianness
Date: Tue,  6 Feb 2024 13:46:08 +0100
Message-ID: <cover.1707223196.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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
Changes in v4:
- remove unnecessary vars and pointer casts (suggested by Daniel Xu)

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

 tools/bpf/resolve_btfids/main.c | 70 ++++++++++++++++++++++++++-------
 tools/include/linux/btf_ids.h   |  9 +++++
 2 files changed, 65 insertions(+), 14 deletions(-)

-- 
2.43.0


