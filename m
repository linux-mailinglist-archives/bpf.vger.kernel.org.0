Return-Path: <bpf+bounces-34198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6369692B363
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67F4B212BF
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9D015443B;
	Tue,  9 Jul 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="P0U23hmD"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED28146016;
	Tue,  9 Jul 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516500; cv=none; b=ZHClgWoHJKKMJI4TvbhNUOknYT/6Zv1iEm9TFW+PK+7IgH+aeFv376HsZxKLvOlD9XoZQ3os8ExkN0Py3hTk9Q8wyLcf43ZNePGcBFVAZH6ZIVFTMNuS5jfIYRXo9DzJCf2GPSC98FvcbsgC9Dxxj+eHtqtOJcQja3WSyA6kzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516500; c=relaxed/simple;
	bh=+FdTgZZ5xwNnbJ04qMHYnhUuJdEzN6M2RkyboQ53P+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6vKm38jIomiL6NKwCBMC56oq1Ij/2Gyo/ODyPo8DogTQ4khip1JHjpG+vZIMPCYpdtT9hevJwOibnbawjrddHQhB+ERDlDCbl6CwQXlVdX54PT15fWdKRNmiSR3fDuqdkDKaw0486Sk0UKr57twhPy7eQhxCcqghOCgKuH25GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=P0U23hmD; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=z4EfPPZ0SjrVckdR6XdJ0wCg3cpqIDKpbJFZTkeXUk0=; b=P0U23hmD0u3FGu2IXppFlh73ec
	+f/1CI2Xeuq5emDjwXxAOJZZahTuwZh160PArQFlvBNlksVzSJckytyleMO4nNMSdDW35qtUuGsH3
	AxMnNIFAju3Q+ejGm3Imn/guk2vMCYTr7YxYIjaV3/XIHxgf5wdy3FQZbBHhp4HjDiwzdQ3yyOoO/
	n5v7zhNuVYN6dSc1ZqB4DJrvP+P5LtDzzlD5hyUVWdfwnaBJf+k2BV1ENxhShWIAugVGPl/xomRe5
	P1rlml+dub0XcaXglolObgHJi0fsgsiFd/f2AF3ug2wce280KXE2U/0xCqqRqUw+xVQL0rMJ5JnC5
	En1DKabw==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sR6w1-0004b2-Go; Tue, 09 Jul 2024 11:14:53 +0200
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
Subject: pull-request: bpf 2024-07-09
Date: Tue,  9 Jul 2024 11:14:52 +0200
Message-Id: <20240709091452.27840-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27330/Mon Jul  8 10:36:43 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 3 non-merge commits during the last 1 day(s) which contain
a total of 5 files changed, 81 insertions(+), 11 deletions(-).

The main changes are:

1) Fix a use-after-free in a corner case where tcx_entry got released too
   early. Also add BPF test coverage along with the fix, from Daniel Borkmann.

2) Fix a kernel panic on Loongarch in sk_msg_recvmsg() which got triggered
   by running BPF sockmap selftests, from Geliang Tang.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

John Fastabend, Pedro Pinto

----------------------------------------------------------------

The following changes since commit 83c36e7cfd74e41a5c145640dba581b38f12aa15:

  docs: networking: devlink: capitalise length value (2024-07-08 13:39:07 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to f0c18025693707ec344a70b6887f7450bf4c826b:

  skmsg: Skip zero length skb in sk_msg_recvmsg (2024-07-09 10:24:50 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Daniel Borkmann (2):
      bpf: Fix too early release of tcx_entry
      selftests/bpf: Extend tcx tests to cover late tcx_entry release

Geliang Tang (1):
      skmsg: Skip zero length skb in sk_msg_recvmsg

 include/net/tcx.h                                 | 13 +++--
 net/core/skmsg.c                                  |  3 +-
 net/sched/sch_ingress.c                           | 12 ++---
 tools/testing/selftests/bpf/config                |  3 ++
 tools/testing/selftests/bpf/prog_tests/tc_links.c | 61 +++++++++++++++++++++++
 5 files changed, 81 insertions(+), 11 deletions(-)

