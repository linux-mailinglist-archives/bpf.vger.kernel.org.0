Return-Path: <bpf+bounces-41970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C6599DECB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 08:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FE5283EDA
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64618A950;
	Tue, 15 Oct 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ2Tus1Y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A64D8DA
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975301; cv=none; b=SaEr3m40Y5dX0FcsF0xfWyJtiCTWxh/MOxViO2JpY2E9l//RVOkxB95M2DtWoZZ2iTergSdd1F7aoBN5enyg81dbkjx53TDbSc9QCIiJ2ywA9NCF7zzR73WxzQtaU8gnlKLc3MeFhp5V+BtgK9bzA1RXVBPBE200SwHpyMKWpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975301; c=relaxed/simple;
	bh=05aEsjUzVSqThserJ/OwvkL7j9F/o9vKgGoPcuX1dj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmzAKM+f5ANtB0UsHZKSCtqNfDcz73Hed1gO9KojzS1z0VmrKbwLYluWKJHUww1819Hix7j2OlTwTATXjeOtQEzAE4cmsDjT9kKV2lmbS7taU9snEF47z0q3CHRhAF4YUf5k9fu0GR16cjgPVbLydMfAjputk1PVIBgPmzbAJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZ2Tus1Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728975298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gaa6HMtM/sTuFuoZcMmAnlbhQ5/S8n5V2T+330pN/ug=;
	b=IZ2Tus1Y3vnw2BSyR0GdT8nR1TnrY2HBWU5AiQFuBJkpRB7R8GFPQMS0TWZDkEDPyViS3/
	BGK6nXLF/j0xQWYb1a69qvuwkyD8J+U4VJwNMzG1NzjMuN7dqiRqQXJH2GxDvmdKv7rka1
	ukPVsJ5NzC6DNyW+ESwos5mMj1l14aA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-LAbmi3R3PoCIONEpdaPvDA-1; Tue,
 15 Oct 2024 02:54:55 -0400
X-MC-Unique: LAbmi3R3PoCIONEpdaPvDA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFFCD195608F;
	Tue, 15 Oct 2024 06:54:51 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96C101956056;
	Tue, 15 Oct 2024 06:54:46 +0000 (UTC)
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
Subject: [PATCH bpf-next 0/3] selftests/bpf: Improve building with extra
Date: Tue, 15 Oct 2024 08:54:39 +0200
Message-ID: <cover.1728975031.git.vmalik@redhat.com>
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

Viktor Malik (3):
  selftests/bpf: Allow building with extra flags
  bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
  selftests/bpf: Allow ignoring some flags for Clang builds

 tools/bpf/bpftool/Makefile           |  8 ++++++-
 tools/testing/selftests/bpf/Makefile | 31 +++++++++++++++++++---------
 2 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.47.0


