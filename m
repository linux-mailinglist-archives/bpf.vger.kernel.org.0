Return-Path: <bpf+bounces-61642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F652AE95A9
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 08:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5954D1882D10
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCB022578C;
	Thu, 26 Jun 2025 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7XkVUYD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03501A0BF1
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918129; cv=none; b=GTmRt/YjWJEOo0Pe8xp+RwigAcPGQLlEZTzvRpwsZyctP/izMvJ3gXVLqr8E6NA+NBXPfGPPLkRAkxig9yzIENDReusOJWLrFy4Z9eh5EiFvLIFPYUhp2qsWZ+jcleXsY94ZtCkOoYPKI9vtb/1D54dMxAafI4WqKRS4Ua/TYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918129; c=relaxed/simple;
	bh=WPRxntTcvZ2bRyjIMrdLiAftxfUZ5pBKZ/IjVbpuVhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYUoowyDl3CTLoFVaNW+8D2ujbLomMxSOxOtEZRpnSOpeEJdZlNj5UYGSrqdJygfKq+E6V0tBJy1+3u5BHOE084g/n1/3DedS7ir7JaRnBGSVOdYNiA846NLmvSf/575J1yPenfhTPjeec0UKE0iNFIH3BBXQmzzpltaip0YsyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7XkVUYD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750918126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=52K02ElfuB52sxxZfv/ArMyjZG3MWCTvuXlN+W7lfeg=;
	b=P7XkVUYDx1BJWVtwB+sG2OF+gh62Ci2UWFCu5MircWd0Av8xTRhKA1OqSEIt4Rjau3ss0g
	wgAPmlMT8LSFuwxXwjn7Rj7HKxT8ItsMLC1J10ZJeT40OeH0jfhnOU8scNQQ89Q8pbcBHf
	9aYbHPImY38wXqRzWQXgUhLNVy91mjY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-LyJ35S7TM2ii990DNCCRog-1; Thu,
 26 Jun 2025 02:08:42 -0400
X-MC-Unique: LyJ35S7TM2ii990DNCCRog-1
X-Mimecast-MFC-AGG-ID: LyJ35S7TM2ii990DNCCRog_1750918120
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA6D3195608E;
	Thu, 26 Jun 2025 06:08:39 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 501A519560A3;
	Thu, 26 Jun 2025 06:08:35 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v8 0/4] bpf: Add kfuncs for read-only string operations
Date: Thu, 26 Jun 2025 08:08:27 +0200
Message-ID: <cover.1750917800.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
string and that the string is null-terminated and the function won't
loop forever. Therefore, the operations are open-coded using
__get_kernel_nofault instead of plain dereference and bounded to at most
XATTR_SIZE_MAX characters to make them safe. That allows to skip all the
verfier checks for the passed-in strings as safety is ensured
dynamically.

All of the proposed functions return integers, even those that normally
(in the kernel or libc) return pointers into the strings. The reason is
that since the strings are generally treated as unsafe, the pointers
couldn't be dereferenced anyways. So, instead, we return an index to the
string and let user decide what to do with it. The integer APIs also
allow to return various error codes when unexpected situations happen
while processing the strings.

The series include both positive and negative tests using the kfuncs.

Changelog
---------

Changes in v8:
- Return -ENOENT (instead of -1) when "item not found" for relevant
  functions (Alexei).
- Small adjustments of the string algorithms (Andrii).
- Adapt comments to kernel style (Alexei).

Changes in v7:
- Disable negative tests passing NULL and 0x1 to kfuncs on s390 as they
  aren't relevant (see comment in string_kfuncs_failure1.c for details).

Changes in v6:
- Improve the third patch which allows to use macros in __retval in
  selftests. The previous solution broke several tests.

Changes in v5:
- Make all kfuncs return integers (Andrii).
- Return -ERANGE when passing non-kernel pointers on arches with
  non-overlapping address spaces (Alexei).
- Implement "unbounded" variants using the bounded ones (Andrii).
- Add more negative test cases.

Changes in v4 (all suggested by Andrii):
- Open-code all the kfuncs, not just the unbounded variants.
- Introduce `pagefault` lock guard to simplify the implementation
- Return appropriate error codes (-E2BIG and -EFAULT) on failures
- Const-ify all arguments and return values
- Add negative test-cases

Changes in v3:
- Open-code unbounded variants with __get_kernel_nofault instead of
  dereference (suggested by Alexei).
- Use the __sz suffix for size parameters in bounded variants (suggested
  by Eduard and Alexei).
- Make tests more compact (suggested by Eduard).
- Add benchmark.

Viktor Malik (4):
  uaccess: Define pagefault lock guard
  bpf: Add kfuncs for read-only string operations
  selftests/bpf: Allow macros in __retval
  selftests/bpf: Add tests for string kfuncs

 include/linux/uaccess.h                       |   2 +
 kernel/bpf/helpers.c                          | 382 ++++++++++++++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  65 +++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  14 +-
 .../bpf/progs/string_kfuncs_failure1.c        |  87 ++++
 .../bpf/progs/string_kfuncs_failure2.c        |  23 ++
 .../bpf/progs/string_kfuncs_success.c         |  37 ++
 .../bpf/progs/verifier_div_overflow.c         |   4 +-
 tools/testing/selftests/bpf/test_loader.c     |  24 +-
 9 files changed, 615 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_success.c

-- 
2.49.0


