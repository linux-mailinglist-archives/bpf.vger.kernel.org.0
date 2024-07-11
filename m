Return-Path: <bpf+bounces-34524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D7792E290
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 10:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74A428B252
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8969150992;
	Thu, 11 Jul 2024 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QyBv1DEb"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014FB78283;
	Thu, 11 Jul 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687223; cv=none; b=reF70/FtDFdr+M4Jcq9FrmfVwIJ1FKUvk0EFsezlS5kJXfZzvXa9bo5kjr4DT0ZwellRFqUYz6j5y4YmJsAW9j6h1pZZU8RvcFnjFGzWrkkcvKCyh010NWyADXKjQnBBee9HZoxaOIpWvn3kojoT1rl/Tk4LGp9YszXJy5bzCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687223; c=relaxed/simple;
	bh=mc9w5NzDBPnS0TnM2ITAqGZMns2hnTzukvho8kud2gs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F/oYIKUih84c/5u5nKp0zspP9UC8swXINWisWWFNeiXn/7zgkhl9NjcDDxoEAPWGHj8qeQU9LEXc+0Hdft/hIxzslHfCcWp8YtXCyHlh00a/PlI0HLNvoGnBvSOz3GXeDZyCA6G+fE6GQCcmLKK3oYz7DoUceRmnDOnoraSujfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QyBv1DEb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=rDyhdwH0D6qoj4ubPy7FV55fYiDYuk1Ur9NfVUnV98Y=; b=QyBv1DEb+fKpwtYAycR0BRXF9T
	UHD/eU9E+gOYmUXF+fI5vwr9IvZAKUc+uGR2R9uzgEzoD/ZLwShIYv6r4DbH1da2XmwRdCvoH4hGP
	AU80hVZ7Nx2eLKOkhnMG5zLNxxFXRrw9QfiC4rVXNrGkL53+Nt4dS2nKzifjROafWcx9AzNqcmgJ9
	LKHoAX50TYSR28UKCsHNG7m11l9vG6UY2DWZ5b4t7aBQTbp5BNyq/ni2t4bO2Af8LEXX6oaxdMDG3
	bLB494Ek+9f9QLM/rv16S/WASqf/flFQ/gdHNE2AhyYgd+Oc5KlHnxXIP7EXZq9IQlk4qO8/ZwYZN
	jh8DTUaQ==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sRpLd-000HDK-Mm; Thu, 11 Jul 2024 10:40:17 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2024-07-11
Date: Thu, 11 Jul 2024 10:40:16 +0200
Message-Id: <20240711084016.25757-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27332/Wed Jul 10 10:36:46 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 4 non-merge commits during the last 2 day(s) which contain
a total of 4 files changed, 262 insertions(+), 19 deletions(-).

The main changes are:

1) Fixes for a BPF timer lockup and a use-after-free scenario when timers
   are used concurrently, from Kumar Kartikeya Dwivedi.

2) Fix the argument order in the call to bpf_map_kvcalloc() which could
   otherwise lead to a compilation error, from Mohammad Shehar Yaar Tausif.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Christian Kujau, Dohyun Kim, Neel Natu

----------------------------------------------------------------

The following changes since commit e1533b6319ab9c3a97dad314dd88b3783bc41b69:

  net: ethernet: lantiq_etop: fix double free in detach (2024-07-09 19:02:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 50bd5a0c658d132507673c4d59347c025dd149ed:

  selftests/bpf: Add timer lockup selftest (2024-07-11 10:18:31 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'fixes-for-bpf-timer-lockup-and-uaf'

Kumar Kartikeya Dwivedi (3):
      bpf: Fail bpf_timer_cancel when callback is being cancelled
      bpf: Defer work in bpf_timer_cancel_and_free
      selftests/bpf: Add timer lockup selftest

Mohammad Shehar Yaar Tausif (1):
      bpf: fix order of args in call to bpf_map_kvcalloc

 kernel/bpf/bpf_local_storage.c                     |  4 +-
 kernel/bpf/helpers.c                               | 99 ++++++++++++++++++----
 .../selftests/bpf/prog_tests/timer_lockup.c        | 91 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/timer_lockup.c   | 87 +++++++++++++++++++
 4 files changed, 262 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_lockup.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_lockup.c

