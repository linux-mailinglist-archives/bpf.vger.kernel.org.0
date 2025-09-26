Return-Path: <bpf+bounces-69865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D10BA5112
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 22:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0150D2A626D
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 20:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57DB25C711;
	Fri, 26 Sep 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cjuoSOti"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA28834;
	Fri, 26 Sep 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918680; cv=none; b=qx8d+P+GAMa3Ch9o+soCBS+C0QgSKpY1DBliXrj2r/Y/sNaMYRtc1GIU0RMH/y1vn4u/UW+6d1jYrpjlrdv4Ug0mxcvzMgDc+nV3UWSf60TW4Cz7aS8GsspjZbuVUNXSG/N3qxq8mpE5IXmP25jlwZ1gHUylL1Biuln/qyxSWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918680; c=relaxed/simple;
	bh=UmLPKla3ODSXwKi0KVeg0N1T7Lhb/DLFtu7IyQt7l2I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XKI4S7oV+UK8290cXpBlXOTqHEbMLl0v+rqjQSLlpX0vlq+lXrq7oDOpqGEETPx7RGhR0qOweZiKC/BIZDFRCpsWHqzYX7o6pv2VlQa2bJwKxIcoyVpnjsvB3y4uuTpwC1669obj3bg5uyHd6lGbxyodJDrR5yRmaim9SbsxSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cjuoSOti; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id C82B62012C31;
	Fri, 26 Sep 2025 13:31:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C82B62012C31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758918677;
	bh=RHkCC1uC39D0Xvr6gwziKadnB80fI3HBckdBqjbkRiA=;
	h=From:To:Subject:Date:From;
	b=cjuoSOtiyxCXJ9PhJkxYA33NUQEsK7FM1NeAaUQJjz7VQsRkpvJKd26Av69aRJvYe
	 DjJ/WXw38GXIn2f+nfNgqhmJ6io1XEbriHe1F7fZaO/4fY8TiTyNWALRSP/SGvqC5V
	 cJMSiYzRj9E1791DZCBFksbMfhef9FmjpTXOo2dg=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kpsingh@kernel.org,
	bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	James.Bottomley@hansenpartnership.com,
	wufan@linux.microsoft.com
Subject: [PATCH bpf-next 0/2] BPF signature hash chains
Date: Fri, 26 Sep 2025 13:30:31 -0700
Message-ID: <20250926203111.1305999-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset extends the currently proposed signature verification
patchset
https://lore.kernel.org/linux-security-module/20250813205526.2992911-1-kpsingh@kernel.org/
with hash-chain functionality to verify the contents of arbitrary maps.

The currently proposed loader + map signature verification
scheme—requested by Alexei and KP—is simple to implement and
acceptable if users/admins are satisfied with it. However, verifying
both the loader and the maps offers additional benefits beyond just
verifying the loader:

1. Simplified Loader Logic: The lskel loader becomes simpler since it
   doesn’t need to verify program maps—this is already handled by
   bpf_check_signature().

2. Security and Audit Integrity: A key advantage is that the LSM
  (Linux Security Module) hook for authorizing BPF program loads can
  operate after signature verification. This ensures:

  * Access control decisions can be based on verified signature status.
  * Accurate system state measurement and logging.
  * Log events claiming a verified signature are fully truthful,
    avoiding misleading entries that only the loader was verified
    while the actual BPF program verification happens later without
    logging.

This approach addresses concerns from users who require strict audit
trails and verification guarantees, especially in security-sensitive
environments.

A working tree with this patchset is being maintained at
https://github.com/blaiseboscaccy/linux/tree/bpf-hash-chains

bpf CI tests passed as well
https://github.com/kernel-patches/bpf/actions/runs/18021422444/


Blaise Boscaccy (2):
  bpf: Add hash chain signature support for arbitrary maps
  selftests/bpf: Enable map verification for some lskel tests

 include/uapi/linux/bpf.h                      |  6 ++
 kernel/bpf/syscall.c                          | 73 ++++++++++++++++++-
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  7 +-
 tools/bpf/bpftool/gen.c                       | 27 ++++++-
 tools/bpf/bpftool/main.c                      |  9 ++-
 tools/bpf/bpftool/main.h                      |  1 +
 tools/bpf/bpftool/sign.c                      | 17 ++++-
 tools/include/uapi/linux/bpf.h                |  6 ++
 tools/lib/bpf/libbpf.h                        |  3 +-
 tools/lib/bpf/skel_internal.h                 |  6 +-
 tools/testing/selftests/bpf/Makefile          | 18 ++++-
 11 files changed, 159 insertions(+), 14 deletions(-)

-- 
2.48.1


