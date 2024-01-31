Return-Path: <bpf+bounces-20838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3864C844403
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5621F27AF8
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ACF12AAFD;
	Wed, 31 Jan 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guXVxxei"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BD12A146
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718266; cv=none; b=VKR3TRN5llv6YnrMX2cA2baf9vjLl68Rrkhp2Pr3FoSs0m/nev8IRvkmJCUEMkcI4Y8v5hEtcB/dlo54Up0cxuFXG3x1eLpPKS+hMK/uMouCPCkmB6sgAROBQXBTb8dn6kHb1tXAQf1+ykpoOy7Dt+kXUxPjsKj0I9oEptSi/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718266; c=relaxed/simple;
	bh=QzdaSYBYj0oQdaxeovKmznN0l6Hxa30hq/qfARLKbjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqwE9ev9ZLoBnsmUgKJfA1yFxdEuRcLVDS/Z5GiHA4ABNHSIM9e67sOfg1KBJpPO/ScRiEv+bKK1NZSNVkPEeNJd+hJFTBqZSauWpaVK8h05xub1phbzag/rwT/TtBgq+EuMjIPOuiI00G/UbTAYgyJ/WOlM57UcxQlgzg50HRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guXVxxei; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706718263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QAwtJgTN3R29PiPjMA36yhtoCDNAU3HdwxP0TJVB7ls=;
	b=guXVxxeiZD+N/ZOcA/UrveP5RMis6ladAaxr2pbQ42pMPJS4HZzA/Y/V03xiyKbUh7AlNz
	e3HYAiwhvGwYaV4JzO5mC7iLFX40uUBNqV+B8X8yjfgcE5Y7daLWPQSafPO8LLh0KiUQqH
	i0dpav6xhOe7bibs0/csphitwNY6hfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-c0ar0QIcOVSBoGnssidVBA-1; Wed, 31 Jan 2024 11:24:17 -0500
X-MC-Unique: c0ar0QIcOVSBoGnssidVBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4B8885A5A3;
	Wed, 31 Jan 2024 16:24:16 +0000 (UTC)
Received: from dhcpf210.fit.vutbr.com (unknown [10.45.224.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 978CE1C060AF;
	Wed, 31 Jan 2024 16:24:13 +0000 (UTC)
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 0/2] tools/resolve_btfids: fix cross-compilation to non-host endianness
Date: Wed, 31 Jan 2024 17:24:07 +0100
Message-ID: <cover.1706717857.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
values, let's manually bswap the flags in resolve_btfids when needed, so
that libelf then translates everything correctly.

The first patch of the series refactors resolve_btfids by using types
from btf_ids.h instead of accessing the BTF ID data using magic offsets.

Viktor Malik (2):
  tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
  tools/resolve_btfids: fix cross-compilation to non-host endianness

 tools/bpf/resolve_btfids/main.c | 55 ++++++++++++++++++++++++++++-----
 tools/include/linux/btf_ids.h   |  9 ++++++
 2 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.43.0


