Return-Path: <bpf+bounces-52881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E0A49F61
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 17:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E63189A063
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5C27560B;
	Fri, 28 Feb 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B4Afbyjl"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7695270EA4;
	Fri, 28 Feb 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761618; cv=none; b=oWcHvlVzMFvC+FfH0GLHQP4NzTqHj8GLFRPLax/kj1OVew4ndpseAu26mRhfYvBjdHVn+ImYVGmasZS5rPMuw7g0shw7i01AVeWCMk2pVedOLPzy8LJwmHuPSsCunqTOym9st21/hPzO4KDlMXngYQnbjluloMGpl84K0OTEvJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761618; c=relaxed/simple;
	bh=STdgObjwBqNhgrALQQxpcHwZDjl0JJEXoS2ZVGtQvcE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Yfm5A5AkWPzwwMucAIMqq2LPj3US5UPm+RurdBeCkAQKhHL+LLs29t+1fIylVTGlvp0xma4YmSyN3b5OamU2wDvt5EUOs92QgdaCErBslBdAw5kak5Uz1Ehr11m/3XDBfoguVn0EgdmdOlEIZXCxYwhlK5L6nb9g+nFP84nJIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B4Afbyjl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC491210D0D6;
	Fri, 28 Feb 2025 08:53:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC491210D0D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740761616;
	bh=XrnlsEB7QNopchRgDQls44QVaqbEuRTnrijpTykRZqw=;
	h=From:To:Subject:Date:From;
	b=B4Afbyjle5mnCPcLhMWTG3/y+zD4Hrbj9it+xyFiuDuTtti1OHEuvAsUFs5JtOwPn
	 YnH0AwcijkIga5WHe7KJBz+16NcT3bMjUORqg7DWtWR+dD5uTVkjEFHtwj5//mmhAq
	 cdOwP7VcHlc/WjVkozEVp/q/3NI4OSxaX4flwZQY=
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
Subject: [PATCH 0/1] v2 security: Propagate caller information in bpf hooks
Date: Fri, 28 Feb 2025 08:53:04 -0800
Message-ID: <20250228165322.3121535-1-bboscaccy@linux.microsoft.com>
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


Change list:
- v1 -> v2
  - Pass a boolean flag in lieu of bpfptr_t

Revisions:
- v1
  https://lore.kernel.org/bpf/20250226003055.1654837-1-bboscaccy@linux.microsoft.com/

Blaise Boscaccy (1):
  security: Propagate caller information in bpf hooks

 include/linux/lsm_hook_defs.h |  6 +++---
 include/linux/security.h      | 12 ++++++------
 kernel/bpf/syscall.c          | 10 +++++-----
 security/security.c           | 17 ++++++++++-------
 security/selinux/hooks.c      |  6 +++---
 5 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.48.1


