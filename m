Return-Path: <bpf+bounces-42171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D419A047B
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 10:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BBD2818C6
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401E1FCC78;
	Wed, 16 Oct 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7yc2/l9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F781D8E05;
	Wed, 16 Oct 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068130; cv=none; b=rbwF5pm1W5WaQ5WjRBS4XlxTtCqNowDO7sRD2vrawya2YF1eiNZk3CyjC/aqWSszsnhO0vbkbl/faB0VuEyebZlK2TwR+y7O6JP0XJVxhqIds03FqB7Oi4Cx1b8rlHinDoZvjwAzwmH9RDpGD9/IonhPLaLRc7LcQ4P78Yi5o+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068130; c=relaxed/simple;
	bh=Ocs425loXucc7jPyHZiDDtOFkNeXNjp01PdfJPdtEaA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tGvHeuZhh2H7zGW5BQAs7kIH3G+Fo4ZbOx69PJdvZ8RNR2pbYNKX40VMbf/k0VtcTybBkKFFL7JcLKtgteSNMSoAq9ln7g7FXS4Wt0PecW4ADV8DulN1fRezeWsTXHHnicph/4J0IwDFjFzprIqeaYT7HFw5YV9jLvaOZx1RJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7yc2/l9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8260FC4CEC5;
	Wed, 16 Oct 2024 08:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729068129;
	bh=Ocs425loXucc7jPyHZiDDtOFkNeXNjp01PdfJPdtEaA=;
	h=From:To:Subject:Date:From;
	b=N7yc2/l9J520xwpjfBtrF018XG+K3wvzM4O6E1vOWsFNoa/rRIatDE425JY2KKfz0
	 RIn9YGGPx10ly2l3ybhWtcFYF6zbhEGfaLGzfxEu/VzkLffG0/V0KkvloiEKUxpvvN
	 ASr3IYaM5pTqmlc43l5pQqAUhRnjOkx0HEh+fWlx2U+V0NpyyKR9g03/A5GefEnHf+
	 U2gn/qbJiuIa8jRz4dqANNzlvGHylOasWF3wILW4PKwMBM3dz24X/fDnGl8uzRtSHF
	 1uPN7lwiTd1FJXDHgBBO7tpMyR1zzAGoypMvb5cascZOZ88cN/fQbts2jb7ZdMd9hN
	 w1hB4MOSE7tlQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: [PATCH bpf-next v5 0/2] Implement mechanism to signal other threads
Date: Wed, 16 Oct 2024 08:41:34 +0000
Message-Id: <20241016084136.10305-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set implements a kfunc called bpf_send_signal_task() that is similar
to sigqueue() as it can send a signal along with a cookie to a thread or
thread group.

The send_signal selftest has been updated to also test this new kfunc under
all contexts.

Changes in v5:
v4: https://lore.kernel.org/all/20241008114940.44305-1-puranjay@kernel.org/
- Call copy_siginfo() only if work->has_siginfo is true in
  bpf_send_signal_common()
- Add Acked-by: Andrii Nakryiko <andrii@kernel.org>

Changes in v4:
v3: https://lore.kernel.org/all/20241007103426.128923-1-puranjay@kernel.org/
- Fix the selftest to make it work for big-endian archs.
- Fix a build warning on 32-bit archs.
- Some style changes and code refactors suggested by Andrii

Changes in v3:
v2: https://lore.kernel.org/all/20240926115328.105634-1-puranjay@kernel.org/
- make the cookie u64 instead of int.
- re use code from bpf_send_signal_common

Changes in v2:
v1: https://lore.kernel.org/bpf/20240724113944.75977-1-puranjay@kernel.org/
- Convert to a kfunc
- Add mechanism to send a cookie with the signal.

Puranjay Mohan (2):
  bpf: implement bpf_send_signal_task() kfunc
  selftests/bpf: Augment send_signal test with remote signaling

 kernel/bpf/helpers.c                          |   1 +
 kernel/trace/bpf_trace.c                      |  53 +++++--
 .../selftests/bpf/prog_tests/send_signal.c    | 133 +++++++++++++-----
 .../bpf/progs/test_send_signal_kern.c         |  35 ++++-
 4 files changed, 176 insertions(+), 46 deletions(-)

-- 
2.40.1


