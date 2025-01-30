Return-Path: <bpf+bounces-50157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C0A234E8
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 21:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9990D7A323C
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30B1F0E4C;
	Thu, 30 Jan 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KtC7vu9l"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653814F102
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738267967; cv=none; b=ahnkiPzODi4xfxWnZYvuEKeKo84k591BUA1ZHvImGntIHaABx3LEgqxxw7tdVuZ301k1MgJJ0MQX0vPyMA/Olm7EwmXFAodq8fitbpY7nEcPazRLAo5WiqkaCHKU2AwI1v81jIFbvrb84Zuk+IekTYMF2sjgX4CyYxO0glQanaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738267967; c=relaxed/simple;
	bh=GvXIV9hdTai+3Jet+TM+GNMm3OCGEXUNEf9N881DePQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dy8Mk9KWZwaG5fQQjfD2Z9HCRFST9QJ7nJGA1utLE88kO0iP3gyRNAqV0Bhb542flAsfzqBGpWLhpU7P3XvgE/Omxwpx37kK2eRs8pKlWdJYsICsTDoeD7hQ0s5aXlPK1pGCXKnYgWzM0AyUOgDOqYiZcRoCul+fExNE3qxhmnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KtC7vu9l; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738267963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nb57FQSKP50A4dytQ0iyVZyVd7AVvzsQkUhl2+uZLWQ=;
	b=KtC7vu9lEY0jtFhoqBOt4VpGjfOnAtoKfVw3NYoosuoNEcuwiDDWZluUz98Wc6XKnQXNpp
	a7PuZKdJBkDYCTvqY3jA5Ipkhw1Sq3QzIzzXKWVCPQKkgHfiJ793bQJ1/yPJswNDgRaq/2
	CJRELwAUH6Z+PwRK39U2gjFZgwhCw1E=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v3 0/6] BTF: arbitrary __attribute__ encoding
Date: Thu, 30 Jan 2025 12:12:33 -0800
Message-ID: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series extends BPF Type Format (BTF) to support arbitrary
__attribute__ encoding.

Setting the kind_flag to 1 in BTF type tags and decl tags now changes
the meaning for the encoded tag, in particular with respect to
btf_dump in libbpf.

If the kflag is set, then the string encoded by the tag represents the
full attribute-list of an attribute specifier [1].

This feature will allow extending tools such as pahole and bpftool to
capture and use more granular type information, and make it easier to
manage compatibility between clang and gcc BPF compilers.

[1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Attribute-Syntax.html

v2->v3: nit fixes suggested by Andrii
v1->v2:
  - When checking for specific BTF tags in the verifier, make sure the
    tag's kflag is 0
  - Split docs and libbpf changes into separate patches
  - Various renames, as suggested by Andrii and Eduard

v2: https://lore.kernel.org/bpf/20250127233955.2275804-1-ihor.solodrai@linux.dev/
v1: https://lore.kernel.org/bpf/20250122025308.2717553-1-ihor.solodrai@pm.me

Ihor Solodrai (6):
  libbpf: introduce kflag for type_tags and decl_tags in BTF
  docs/bpf: document the semantics of BTF tags with kind_flag
  libbpf: check the kflag of type tags in btf_dump
  selftests/bpf: add a btf_dump test for type_tags
  bpf: allow kind_flag for BTF type and decl tags
  selftests/bpf: add a BTF verification test for kflagged type_tag

 Documentation/bpf/btf.rst                     |  25 ++-
 include/uapi/linux/btf.h                      |   3 +-
 kernel/bpf/btf.c                              |  26 ++--
 tools/include/uapi/linux/btf.h                |   3 +-
 tools/lib/bpf/btf.c                           |  86 +++++++---
 tools/lib/bpf/btf.h                           |   3 +
 tools/lib/bpf/btf_dump.c                      |   5 +-
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/testing/selftests/bpf/prog_tests/btf.c  |  23 ++-
 .../selftests/bpf/prog_tests/btf_dump.c       | 147 +++++++++++++-----
 tools/testing/selftests/bpf/test_btf.h        |   6 +
 11 files changed, 244 insertions(+), 85 deletions(-)

-- 
2.48.1


