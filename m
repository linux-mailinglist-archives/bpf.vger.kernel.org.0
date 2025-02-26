Return-Path: <bpf+bounces-52597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FCA4517A
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 01:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7977178FCB
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 00:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC5145B24;
	Wed, 26 Feb 2025 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Www5p8X7"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2429D0E;
	Wed, 26 Feb 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529871; cv=none; b=juG3Ier/T2FhC9VyUSzu2/Gm1+kZI7q6OrFgG7QxHIwSz/ynL+vDJLzlM/53yullw6+Y4E3EdBCl+HEyA1wO1l2xrKsL13nByJf5aC9MnDo75YRi6QF1Q3Qw6Nv8iFg/BNxJEsV+ygC5964+unvDFq3WOwevR0nvOvECeIqU4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529871; c=relaxed/simple;
	bh=7u8Urx6xbaSc2nMybYjuCDRx1MQ5fV1RW8+qDsUXiXk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uhOZmkFZZRQBki2EBbjwHsI4DbH75auCbxaANRYITjFWQrIiBUO+9u9rfSmjjbpAMynjtmG5uED0hAGgDuMHpuH0kgMA6R7wQfwRuMk1S2Q3sCRGotGoW/lDlxOGeN3Wz5YDZDr2tqKgARFoMI3g5a/OugWCVFlU7g86kiW81PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Www5p8X7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id C83ED203CDFD;
	Tue, 25 Feb 2025 16:31:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C83ED203CDFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740529869;
	bh=Km3jX9X6KTYjsEDd3nzA6yCAbUXbwEpnswIIoKZCbKY=;
	h=From:To:Subject:Date:From;
	b=Www5p8X7rPz9jCtj/syOpKPEtf+WUWo9iozLUUxACDprDqLaM0WueD2es0YiephT8
	 b8MgwlRHemGiFZnvpSh9sbBPyTceOFSSkXj0yPaeAZwWB7CBblRZGYzB2jCh+78iAO
	 hhkAJ8aiIDgXSvQXgaaRXw7AtxinjmxLWq71x/W8=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	bboscaccy@linux.microsoft.com
Subject: [PATCH 0/1] security: Propagate universal pointer data in bpf hooks
Date: Tue, 25 Feb 2025 16:30:29 -0800
Message-ID: <20250226003055.1654837-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While trying to implement an eBPF gatekeeper program, we ran into an
issue whereas the LSM hooks are missing some relevant data.

Certain subcommands passed to the bpf() syscall can be invoked from
either the kernel or userspace. Additionally, some fields in the
bpf_attr sruct contain pointers, and depending on where the subcommand
was invoked, could point to either user or kernel memory. One example
of this, is the bpf_prog_load subcommand and it's fd_array.  This data
is made available and used by the verifier, but not made available to
the LSM subsystem. This patchset simply exposes that information to
applicable LSM hooks.


Blaise Boscaccy (1):
  security: Propagate universal pointer data in bpf hooks

 include/linux/lsm_hook_defs.h |  6 +++---
 include/linux/security.h      | 13 +++++++------
 kernel/bpf/syscall.c          | 10 +++++-----
 security/security.c           | 17 ++++++++++-------
 security/selinux/hooks.c      |  6 +++---
 5 files changed, 28 insertions(+), 24 deletions(-)

-- 
2.48.1


