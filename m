Return-Path: <bpf+bounces-42368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6E59A3615
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 08:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B04B23F00
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBAA17E8EA;
	Fri, 18 Oct 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iwu5WbWc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86A17E01A
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234162; cv=none; b=SQl7UItK66zMNAiGkx1Nx1QijdDdoPtKP7mDfXSeY9r+t7z+CyPu7WD3BIJwsV2/peTxk4J42Mka/mXJ5lBI+w4uprEJnXtyghQyDBFLCg//54b4Oxnf6Ms+nJv2XEp12o7AlF7s2NTsPfnOkBQpYqFOlXVOG1jii3xeBkTFhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234162; c=relaxed/simple;
	bh=2r0G+Tk5C1pTTpaXR54ZN/d1ztaHM8GLNb2uJKhbEdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mh8PEGPx59d5k6A26QKQP1l6jY3HzuOErsqqFDYQcvzuFpoFnM9Cgy2MH5GHqYXVgtKb+Vlf8CvwY/H0mev7FIXkUsLbQUBiPgXfC0Y5FJlBJDSYx78FlcD4Bd6ldy5zkw0EzJhzQsg3bASPsMWbeNObCYkgYiVKdaV8t2SaJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iwu5WbWc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729234160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i0JXy+2QzIQsbmyi7EWXjmLs6EGJBox4dVfk1fVTeNg=;
	b=Iwu5WbWcnBtVYS81Z+nmiz3ule6fGsbeXMyltlfj54XPkoBfVPSrsnFu/cbf8W8YHKWQlb
	aLSz4Lqys7MMPM/JNY4x+RmB0UjtxipayGWkrKzP0NfMqrU3JRIhriVKKP58D1aGfgifhz
	OkufQ/F2X/yVRL7o57KzJXLRUm3xfbk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-F58SWPB8MKqlJ9k92Xxw9Q-1; Fri,
 18 Oct 2024 02:49:15 -0400
X-MC-Unique: F58SWPB8MKqlJ9k92Xxw9Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CA4A1955F3C;
	Fri, 18 Oct 2024 06:49:12 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.232])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BD1E19560A3;
	Fri, 18 Oct 2024 06:49:06 +0000 (UTC)
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
Subject: [PATCH bpf-next v2 0/3] selftests/bpf: Improve building with extra
Date: Fri, 18 Oct 2024 08:48:58 +0200
Message-ID: <cover.1729233447.git.vmalik@redhat.com>
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
v1 -> v2:
- cover forgotten case in patch#1 (noted by Eduard)
- remove -D_GNU_SOURCE unconditionally in patch#2 (suggested by Andrii)
- rewrite patch#3 to just add -Wno-unused-command-line-argument
  (suggested by Andrii)

Viktor Malik (3):
  selftests/bpf: Allow building with extra flags
  bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
  selftests/bpf: Disable warnings on unused flags for Clang builds

 tools/bpf/bpftool/Makefile           |  6 +++++-
 tools/testing/selftests/bpf/Makefile | 28 +++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.47.0


