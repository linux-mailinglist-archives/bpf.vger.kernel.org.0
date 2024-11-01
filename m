Return-Path: <bpf+bounces-43708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5009B8D18
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 09:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6385E1F23828
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4865718953D;
	Fri,  1 Nov 2024 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIadfvlS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399B15D5B6
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449656; cv=none; b=tbkmV1L4BZqDk7Ex68Gq1P2beJSlPXOdI8fWePr4S6QcUNv/y8gu4tpx9ZNFnC1SQPD9xMsVqEu6uzNrXQZIE0V0bgX80gp2ycr+1hjUaSdfT92idAYgAQQUn3vvgYie0UlB5Wqa4JWACErX+CB3zJwVRctiVR8BkRwgq2gW2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449656; c=relaxed/simple;
	bh=eUpAXIBdBB2kS81qTkYO7hRjuUskB5bBUPvVcgS2SfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Va5oNSaELAZBZX62aEdRcBC12zgbq1AOOXD7zXUK0nzg+YhXi1IhviM4MOY5yy7wCSnLBcEHW8TUNpdG446YoVnPw7hmBH5/v6JgajnoZ/tCO/Zc2xxrTp8KWFnDMIoUBi8C87bDZz/e3ikGX/6QOe7ktwqIFsxzocKZdIrUaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIadfvlS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730449653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gMwtIGOBx2aGeyU2gX2sFIFNNiTg4/TmyFuXnNPoDzI=;
	b=NIadfvlS2JE3BvW/RIEU+Xxm+IBVT7sZo3Mj5/wjl7LWgpd/7FW8WMRiFeudMXHSUfb3Md
	7jNdsMmeRTKbn+p8rPna7lEHSEkEcuEkehiqj4b5+0thmIO7aKptP07xmo62ma+BZhnJ0r
	nTGDZ9ub7VaORRfvoR6ps15T8pisYrE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-qw5Hi2uPNdaREsX6uXibVA-1; Fri,
 01 Nov 2024 04:27:27 -0400
X-MC-Unique: qw5Hi2uPNdaREsX6uXibVA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 033D519560A7;
	Fri,  1 Nov 2024 08:27:24 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC3151956052;
	Fri,  1 Nov 2024 08:27:17 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
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
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v3 0/3] selftests/bpf: Improve building with extra
Date: Fri,  1 Nov 2024 09:27:10 +0100
Message-ID: <cover.1730449390.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When trying to build BPF selftests with additional compiler and linker
flags, we're running into multiple problems. This series addresses all
of them:

- CFLAGS are not passed to sub-makes of bpftool and libbpf. This is a
  problem when compiling with PIE as libbpf.a ends up being non-PIE and
  cannot be linked with other binaries (patch #1).

- bpftool Makefile runs `llvm-config --cflags` and appends the result to
  CFLAGS. The result typically contains `-D_GNU_SOURCE` which may be
  already set in CFLAGS. That causes a compilation error (patch #2).

- Some GCC flags are not supported by Clang but there are binaries which
  are always built with Clang but reuse user-defined CFLAGS. When CFLAGS
  contain such flags, compilation fails (patch #3).

Changelog:
----------
v2 -> v3:
- resolve conflicts between patch #1 and 4192bb294f80 ("selftests/bpf:
  Provide a generic [un]load_module helper")
- add Quentin's and Jiri's acks for patches #2 and #3

v1 -> v2:
- cover forgotten case in patch#1 (noted by Eduard)
- remove -D_GNU_SOURCE unconditionally in patch#2 (suggested by Andrii)
- rewrite patch#3 to just add -Wno-unused-command-line-argument
  (suggested by Andrii)

Viktor Malik (3):
  selftests/bpf: Allow building with extra flags
  bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
  selftests/bpf: Disable warnings on unused flags for Clang builds

 tools/bpf/bpftool/Makefile           |  6 ++++-
 tools/testing/selftests/bpf/Makefile | 36 +++++++++++++++++++---------
 2 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.47.0


