Return-Path: <bpf+bounces-57385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0ACAA9E78
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D596179917
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9F274FF5;
	Mon,  5 May 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fWgFDOjr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B72749F0;
	Mon,  5 May 2025 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482301; cv=none; b=iAMZXZOmD93XYnI6VeBFOcyILs/NWpEJY6Gb+WzmLUgFMOu6aYn7S6+S8dJQcv3uOS1ZYQnHSP7TRiDzqih4z1TNPA2cH56wf0RCeVlP2zcBm/T96Gt3puZjcLMnfdymTr0ZwPqcum41y9DZ3rWc3f4lAKaC2zlxiwhKu+jl/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482301; c=relaxed/simple;
	bh=R59XfxVJ7WM8Yb0L7KsqJ40wX61eld3OHOwnXmWXlbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GmSswybNTwfZugsYGPEZ0UdOSNotMAz56/HhAL9DGDLPQ9rc5Ebb8/m77OBqZGjEzpAUPhF8T+UVR7TBrNwT6L2ifz/V8Nh8RHZ8j7xZ/yiDCEQZrfIm/VycPM2vVrpJ2FgENo9I0nLVjn5MkWw/R5s0HRSUH6o+YaQJd+Hxi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fWgFDOjr; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746482299; x=1778018299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=olI8DO+YO7P8Trob+5YPSmA2pQyQWCsJA6hl62A4938=;
  b=fWgFDOjr1De+hknMdHPZxDG+G19oU+2yTERh9MmFuzhBYcS/Ft13xP0X
   d35OGKaAGEiuOZucijM2fU74J7X9GZ+u1hIzbqTbe1cMps507Ozjgp40N
   AqF6EmeADu94gLnDmNCOP+l7L92+D4K3cpBnjDOrAC7Macoaw9pC7nXYI
   Q8EMJCrs0GYXHEe8d/Id1cq+uwVJxzYIP6n71gg4dR+ApSoddexaDv+fO
   9USD9PV1bRXm5LFFxjvZMWR66HpihPC31W+lfW/87inQrmNwetyZLSJXS
   USRd0YqiOHlslVlQv8zFZ30xKD5r7qyLAWEtybZRp5hzKSeu1BqFD4LXt
   g==;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="193894800"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 21:58:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:36744]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id 88b90883-9bd1-4d55-882b-bf8d3bab5546; Mon, 5 May 2025 21:58:17 +0000 (UTC)
X-Farcaster-Flow-ID: 88b90883-9bd1-4d55-882b-bf8d3bab5546
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 21:58:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 21:58:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=
	<mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	"Ondrej Mosnacek" <omosnace@redhat.com>, Casey Schaufler
	<casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub SCM_RIGHTS at sendmsg().
Date: Mon, 5 May 2025 14:56:45 -0700
Message-ID: <20250505215802.48449-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As long as recvmsg() or recvmmsg() is used with cmsg, it is not
possible to avoid receiving file descriptors via SCM_RIGHTS.

This behaviour has occasionally been flagged as problematic.

For instance, as noted on the uAPI Group page [0], an untrusted peer
could send a file descriptor pointing to a hung NFS mount and then
close it.  Once the receiver calls recvmsg() with msg_control, the
descriptor is automatically installed, and then the responsibility
for the final close() now falls on the receiver, which may result
in blocking the process for a long time.

systemd calls cmsg_close_all() [1] after each recvmsg() to close()
unwanted file descriptors sent via SCM_RIGHTS.

However, this cannot work around the issue because the last fput()
could occur on the receiver side once sendmsg() with SCM_RIGHTS
succeeds.  Also, even filtering by LSM at recvmsg() does not work
for the same reason.

Thus, we need a better way to filter SCM_RIGHTS on the sender side.

This series allows BPF LSM to inspect skb at sendmsg() and scrub
SCM_RIGHTS fds by kfunc.

Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]


Kuniyuki Iwashima (5):
  af_unix: Call security_unix_may_send() in sendmsg() for all socket
    types
  af_unix: Pass skb to security_unix_may_send().
  af_unix: Remove redundant scm->fp check in __scm_destroy().
  bpf: Add kfunc to scrub SCM_RIGHTS at security_unix_may_send().
  selftest: bpf: Add test for bpf_unix_scrub_fds().

 include/linux/lsm_hook_defs.h                 |   3 +-
 include/linux/security.h                      |   5 +-
 include/net/af_unix.h                         |   1 +
 include/net/scm.h                             |   5 +-
 net/compat.c                                  |   2 +-
 net/core/filter.c                             |  19 ++-
 net/core/scm.c                                |  19 +--
 net/unix/af_unix.c                            |  48 ++++--
 security/landlock/task.c                      |   6 +-
 security/security.c                           |   5 +-
 security/selinux/hooks.c                      |   6 +-
 security/smack/smack_lsm.c                    |   6 +-
 .../bpf/prog_tests/lsm_unix_may_send.c        | 160 ++++++++++++++++++
 .../selftests/bpf/progs/lsm_unix_may_send.c   |  30 ++++
 14 files changed, 282 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_unix_may_send.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_unix_may_send.c

-- 
2.49.0


