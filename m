Return-Path: <bpf+bounces-60922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B05ADEDDB
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452C43BF77E
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE5284690;
	Wed, 18 Jun 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMNogXZe"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FD1DA5F
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253561; cv=none; b=Y5jzl+wPr/+TxE4ty0bStWKjnVWeycqHJHhTOkJhgyneqxy0uq+YkdBpRQzWfsuservzaGUNCQMC98Y0eYahvxjV+lGkuZnDcDtqP3TfYgnIM1v644Ijs/19dlyqEq+9HtDJZnfg2bmsFfy8IYHbHXZ7837eC7KAS6ygkpfImLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253561; c=relaxed/simple;
	bh=0LWK09JnMD7WoNYt8VOc8Ua2lyTWxV+Vc7bb/1pzRK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUryogYw3LCFVZUi6e0usIqr03wBFD4fYZHjHGmPTyC5LFZvRfP0VLRbCFatuiIBoJN6T5+OVPavQ9i4hIgoE8zt+ttOcq901jX5NZP9ED2TEV9C08a3ivDJ5pobey1cNvLkTjDKNCmxPZnZECLT9Xy2Wz6OoQ21znjLYhNV5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMNogXZe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750253558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4uEik5f3xEK+LXHICZqZ5SyJGqiwK3eRB9BiMouVf28=;
	b=HMNogXZeCvWY7Scss8QWToQIrIGhHIbJcj551fGepdIZa2z5S8r494AJr0BpQ6XBkMX7jz
	9NJSaTq2mABV5D10Sfszy1vsBINZ4n57ozSuuPaaspzoVFUbKgDD8eANRyd2TdSDtoZ6XC
	o7dFa0j1pL/1EEFko7mCyH/836o2hmw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-f0u4qhTpO7uvfpcvDhLr2g-1; Wed,
 18 Jun 2025 09:32:37 -0400
X-MC-Unique: f0u4qhTpO7uvfpcvDhLr2g-1
X-Mimecast-MFC-AGG-ID: f0u4qhTpO7uvfpcvDhLr2g_1750253554
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C21FC19560A3;
	Wed, 18 Jun 2025 13:32:33 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.226.177])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32A7619560A3;
	Wed, 18 Jun 2025 13:32:27 +0000 (UTC)
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
Subject: [PATCH bpf-next v5 0/4] bpf: Add kfuncs for read-only string operations
Date: Wed, 18 Jun 2025 15:32:18 +0200
Message-ID: <cover.1750252029.git.vmalik@redhat.com>
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
 kernel/bpf/helpers.c                          | 389 ++++++++++++++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  63 +++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  11 +-
 .../bpf/progs/string_kfuncs_failure1.c        |  77 ++++
 .../bpf/progs/string_kfuncs_failure2.c        |  21 +
 .../bpf/progs/string_kfuncs_success.c         |  35 ++
 tools/testing/selftests/bpf/test_loader.c     |  17 -
 8 files changed, 593 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_success.c

-- 
2.49.0


