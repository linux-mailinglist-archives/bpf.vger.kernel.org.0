Return-Path: <bpf+bounces-35268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73299394C1
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 22:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49ABCB2198E
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47BC28379;
	Mon, 22 Jul 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMj3wvck"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F8224D7
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680085; cv=none; b=Cs33Z6szoUyZqbR63QTQuD8uZZES01j8lwgd9XZaPRCIV+zrYMyzHAUbFgYNessIXBA1rmDBMbZ5Izz37YT01tHtppG9UScTWeYaJVZSSjdWZT1l81e/jMA17IA9Rg7sbXVVIg88BVaA84mFELA649Ly1W1MZCVruwQRZHWYI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680085; c=relaxed/simple;
	bh=HYtDysTi6nPA+kFDGz8ziTuDlnE/hiDqm/cbqHTY5W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaG5MLH2GMK8XqsgPWOm9KT9l5qiYptIEn19y95RNJbRJcJrX4osapjJDqhGBqmMyA2TxggTGla6EYm1YgWrS4yi7mPG7VIc4RbW1ovTUKI4A7uZhCUSipWjJOWT+sqytNHCs6RGkvD34W50St2uNYO6bo+ZaiNnp73HsRUNr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMj3wvck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AED4C116B1;
	Mon, 22 Jul 2024 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721680084;
	bh=HYtDysTi6nPA+kFDGz8ziTuDlnE/hiDqm/cbqHTY5W4=;
	h=From:To:Cc:Subject:Date:From;
	b=XMj3wvckDvys3a0h+c7mZMuFqNN+DYFaur1pDjQKHQmj0e+HcgqR9FJ59E9EOHPKA
	 m8eo/AuOhQzNnYnF9ilhKpueiYnWm4GcBdTyADxZZKzNA//Val8A7Qpd/mk0B3AyG+
	 qil9fx8FiGHJsLLFz9zxdgEOx/jCqnLUk/6OQsZF7SSi/VNxfuQ+BVz39UZyo4Z7aE
	 XYPk1j/vFZ3CB6aXy9kgYZ97eG6foSDMdH09LtdUw1s8RKRMHdl48Uc5LVSDVgFnNa
	 upTWfu+TBLdbZuxIbVS3F/d5op5cIWpral9jyR06sTwMz3yjpayVXV6oZDg74risuA
	 zxQj8RzQ0cdzA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv3 bpf-next 0/2] selftests/bpf: Add more uprobe multi tests
Date: Mon, 22 Jul 2024 22:27:56 +0200
Message-ID: <20240722202758.3889061-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding more uprobe multi tests for failed attachments
inside the uprobe register code.

v3 changes:
  - renamed several variables/functions, null check [Andrii]
  - fixed CI issue

thanks,
jirka

---
Jiri Olsa (2):
      selftests/bpf: Add uprobe fail tests for uprobe multi
      selftests/bpf: Add uprobe multi consumers test

 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 331 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c |  39 +++++++++++
 2 files changed, 370 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c

