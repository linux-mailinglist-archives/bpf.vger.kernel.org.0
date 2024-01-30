Return-Path: <bpf+bounces-20765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AD7842CFA
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C1A28B59E
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1BD7B3FB;
	Tue, 30 Jan 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcryu5Up"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D137B3ED
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643412; cv=none; b=iPpDtF5kgC14vHVS8boFNQBwX4yzvrfN1JvdnV2mDdms2zU3/iGj6Xfg79iQrahH/HBc7AvQqKTa51IiYV/txjUmbgK/FpqaRbOWk8ml5BFsTgX19teO98Eh4v4sHN6R3wb6WodisoHDzisJc5ncLsFP/NH9L6zSxojT5s90dCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643412; c=relaxed/simple;
	bh=QXzvJ8x7p+9tF6faszun/TuVvoCj9ordnsqcwKXbE/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Szg7x6NYDDGO3Zklu0MgQJkYbOb2u4IywyMLNWWcZIUAjFfDYrz/xVXuGTyjmjUJGg6huGbho8o9pH55L/To06rwYAkiGi7x/FNqReK/Q77APhd8xzkEK8iJmh4C7iSZ78ky70R/0JXCkWs4Kk7glT46RXVAMCbz+UeJ57TY5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcryu5Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E047C433C7;
	Tue, 30 Jan 2024 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643411;
	bh=QXzvJ8x7p+9tF6faszun/TuVvoCj9ordnsqcwKXbE/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=gcryu5UpZu7T8I/J0RHlK0krgzwsqhiahoRJ1k9GbN6PK0s4jV7FQbx5Gl/ieUA5L
	 uJM4ZXAWMr6qOBJGJjh3bpkOnwm3dzUCCHhSBm+XLwpVvgDvzPXfVeWrID4TuURDg3
	 uBvk/dzAfK6bh9avfOP4KXB83qy02j0ITXb3qTExIjc+kTeoIy0H4Tp07eU+10s5rI
	 0QV9WSs5LM3hW+lM7DFNdub6ghkkUagz9ASCXNsWH2Rm2ULhlESbKi/bT8Ofc2nGbp
	 3TEU66eDCV0d0lG3oFQgetZPQ2RTDJgWSVmrcEQtY912hySF7B0kdm/Z6KyHM/xjEl
	 n+kZG/mkMXnog==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/5] Libbpf API and memfd_create() fixes
Date: Tue, 30 Jan 2024 11:36:44 -0800
Message-Id: <20240130193649.3753476-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Few small fixes identified over last few days. Main fix is for memfd_create()
which causes problems on Android platforms. See individual patches for
details.

Andrii Nakryiko (5):
  libbpf: call memfd_create() syscall directly
  libbpf: add missing LIBBPF_API annotation to libbpf_set_memlock_rlim
    API
  libbpf: add btf__new_split() API that was declared but not implemented
  libbpf: add missed btf_ext__raw_data() API
  selftests/bpf: fix bench runner SIGSEGV

 tools/lib/bpf/bpf.h                 |  2 +-
 tools/lib/bpf/btf.c                 | 11 ++++++++++-
 tools/lib/bpf/libbpf.c              | 11 ++++++++++-
 tools/lib/bpf/libbpf.map            |  5 +++--
 tools/lib/bpf/linker.c              |  2 +-
 tools/testing/selftests/bpf/bench.c | 10 +++++++++-
 6 files changed, 34 insertions(+), 7 deletions(-)

-- 
2.34.1


