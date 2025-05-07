Return-Path: <bpf+bounces-57633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F35AAD651
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111931B68BD4
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5234D211283;
	Wed,  7 May 2025 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbfHS2aO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A71E8348
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600067; cv=none; b=H6YkqJdyd0q/xFBbuJrGpzYvNzMMH5Ul2PPcl2tAoyakQKcAjm7rp3+IxpED+Cjd0yGh6xvIs+nL25C05c+00WmY3l5de/+FmFIuKzugXePOZAvZYOhqF6XfF2x67Q1yBzjF5LOK227RlS24aCn8BAJCkC6AcHieNXYuiBFlD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600067; c=relaxed/simple;
	bh=JclVMpt0MgIfgF5xGVyE7UFVN2g/41XFRnyGNKD93sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUYJIlx8Ug/przYuU1Sb7biuELh/gO2UBFE1N+btHjbQVSRrVkmrdA4gGijQWjmyWRGw5S/lqaGrHqtj2ihi3uUCKtSRWfwI2b7rBS9s+3UFG/E54BOvCWeiZIm6E4H/PHrn/Ek1T0qPTTYqL2A/qV/j6N4ShXMaQkLFkWwL2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbfHS2aO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746600065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zcTaFNzmhF+HfyLh1TEI6u2P+jBrolOJVFNlnJXM/6c=;
	b=HbfHS2aO3xnlGNPjZhIN/5a2Ypq4yuBmLNzqo2RWRfNV9Fq8WlRGrWjIBHR6gsUsNsUdu9
	R5rd9tGLJK8DRV7CELMfGPzeMeJ23trT9Cel+dAsEJ5BPPaIIV76KtTcj/MQWVhV9p9Vvy
	5NY20w5Kw7Fg5fiDB4m0QsSLXXs1nWo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-5DKjrQy4OUWupxxf1ytZkg-1; Wed,
 07 May 2025 02:40:58 -0400
X-MC-Unique: 5DKjrQy4OUWupxxf1ytZkg-1
X-Mimecast-MFC-AGG-ID: 5DKjrQy4OUWupxxf1ytZkg_1746600056
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EC471800368;
	Wed,  7 May 2025 06:40:55 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.220])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8265518003FC;
	Wed,  7 May 2025 06:40:49 +0000 (UTC)
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
Subject: [PATCH bpf-next v4 0/4] bpf: Add kfuncs for read-only string operations
Date: Wed,  7 May 2025 08:40:35 +0200
Message-ID: <cover.1746598898.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
__get_kernel_nofault instead of plain dereference to make them safe. 

The first patch of the series teaches the verifier to allow read-only
memory to be passed to const arguments of kfuncs. With that change,
the added kfuncs take strings in three forms:
- string literals (i.e. pointers to read-only maps)
- global variables (i.e. pointers to read-write maps)
- stack-allocated buffers

Note that currently, it is not possible to pass strings from the BPF
program context (like function args) as the verifier doesn't treat them
as neither PTR_TO_MEM nor PTR_TO_BTF_ID.

Changes in v4 (all suggested by Andrii):
- Open-code all the kfuncs, not just the unbounded variants.
- Introduce `pagefault` lock guard to simplify the implementation
- Return appropriate error codes (-E2BIG and -EFAULT) on failures
- Const-ify all arguments and return values
- Add negative test-cases

Viktor Malik (4):
  bpf: Teach vefier to handle const ptrs as args to kfuncs
  uaccess: Define pagefault lock guard
  bpf: Add kfuncs for read-only string operations
  selftests/bpf: Add tests for string kfuncs

 include/linux/btf.h                           |   5 +
 include/linux/uaccess.h                       |   2 +
 kernel/bpf/helpers.c                          | 440 ++++++++++++++++++
 kernel/bpf/verifier.c                         |  10 +-
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  65 +++
 .../bpf/progs/string_kfuncs_failure1.c        |  51 ++
 .../bpf/progs/string_kfuncs_failure2.c        |  24 +
 .../bpf/progs/string_kfuncs_success.c         |  87 ++++
 8 files changed, 680 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_success.c

-- 
2.49.0


