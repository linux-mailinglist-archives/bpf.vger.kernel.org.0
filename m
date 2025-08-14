Return-Path: <bpf+bounces-65677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4287DB26E89
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF9D6010B3
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF0D200BAE;
	Thu, 14 Aug 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b="e/3mznWt"
X-Original-To: bpf@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFED319878;
	Thu, 14 Aug 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194531; cv=none; b=kQYflPJKB84E/ZYhsM7RTHTagllEUMqKhv/sJ3B0oczexKh3Ffda8h6mPaonNxSoBgYm6UxxTkvbhBs8ax5HAmlzdozHiepOtDU0q+2LmgzfsLmfQnX3rC19B5YjY4RP/i/dc3UiPggmRDzyd4Ao6HlLiRVjKidcoCvgIh0qn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194531; c=relaxed/simple;
	bh=+GNU2gDpN6GiKnpKgO/L5NE6HXec9msvUjnPjkB/igE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VA2inEg7DdOzuN5xX0nzH9sok6bFHFZcnH7SgWuabO7TbZBJZc9nP5ZMBHGxmquJD4FPI1g7MVrdzvq84S3UZmmifp/3FOjvfrSKCPJlW/l2Bk4NrmJgJeVekIWwcvw2Romt1iq4knnkpKy+NEcXeA5EGupGTjau4Q70fqZ+M6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev; spf=pass smtp.mailfrom=yuka.dev; dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b=e/3mznWt; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuka.dev
From: Yureka Lilian <yuka@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
	t=1755194525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uvmzxtbe3yYROKJpF3l2EIRZ74hgQcblp4CjdJSICQ8=;
	b=e/3mznWt/1genX+GZkDV38Zz+xLVKyT9UDorjnTbs4dnXHKa2PKDW4KNbfoIgZngg4/lit
	SdGxJO1FE66aEJqXcGeWaCh3bVZCfsqp8auDBah3iEM2WSsng/H/uoIbbdUEioOdDVg4QO
	gaUbtjnrrqjIlBsxy7NdEWZPqckoqOs=
To: Andrii Nakryiko <andrii@kernel.org>,
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
	Jiri Olsa <jolsa@kernel.org>
Cc: Yureka Lilian <yuka@yuka.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] libbpf: fix reuse of DEVMAP
Date: Thu, 14 Aug 2025 20:01:11 +0200
Message-ID: <20250814180113.1245565-2-yuka@yuka.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v3:

- instead of setting BPF_F_RDONLY_PROG on both sides, just
  clear BPF_F_RDONLY_PROG in map_info.map_flags as suggested
  by Andrii Nakryiko

- in the test, use ASSERT_* instead of CHECK
- shorten the test by using open_and_load from the skel
- in the test, drop NULL check before unloading/destroying bpf objs

- start the commit messages with "libbpf" and "selftests/bpf"
  respectively instead of just "bpf"

changes in v2:

- preserve compatibility with older kernels
- add a basic selftest covering the re-use of DEVMAP maps

Yureka Lilian (2):
  libbpf: fix reuse of DEVMAP
  selftests/bpf: add test for DEVMAP reuse

 tools/lib/bpf/libbpf.c                        | 11 ++++
 .../bpf/prog_tests/pinning_devmap_reuse.c     | 50 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_devmap.c | 20 ++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_devmap.c

-- 
2.50.1


