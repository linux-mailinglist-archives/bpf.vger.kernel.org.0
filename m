Return-Path: <bpf+bounces-67884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981CFB5026D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590773BF1E7
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC13350D77;
	Tue,  9 Sep 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GPEN2K5A"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A925B30E;
	Tue,  9 Sep 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435041; cv=none; b=IJE25W1vy7TMoafAM8NrsHi/475Rg+Z7LkND+1ehQkGNm+eWbKJpROIteyOCIevW32Rc2d9EdGnnqsI+F0PyHV8gshkzksnXtIsRO9csQVgQtirruaewA72OUvWf2B98IAdxldScgMvAAtNC4Cz2+c82/Xxtc1YoI+8GjLs/ezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435041; c=relaxed/simple;
	bh=mShLxsWpEq7APxwxSrrOnpG/lf7CARP9FGxuy/bI0TI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1qfeS1VM8LB/wTroPpIClp/Zc03fwzEj5ywaTknP/L8QqgGfYF7oU9qx3VvfmO4dzF3xrauaR9FlX3/Ge7mGiDz5612D8qrKK2zBOF4e37+NS0JN91bSbGJSiCPpnKSWKrk0HU0en0QDvHMgkpQgcR+JlFr5oJ40HzF7PBTqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GPEN2K5A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 59E332119CB4;
	Tue,  9 Sep 2025 09:23:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59E332119CB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757435034;
	bh=jbmTlZwKdtuA9HF1CJplWnouJXiS3lWAkVcbaePt7yo=;
	h=From:To:Subject:Date:From;
	b=GPEN2K5AVkQWhJpKWhDWtqQzfiEbkj12NRhRVJV6tYMI6Wf/QeDiGeKqsmqWZXY8i
	 Ro8yVr3jZADqhs0wJf9kIk8BVGqY99vngmp2+pUCkEdgGv6o9pRb+YgLJSj5SjxvGb
	 ee18uUNKkbS1oIAMSzFvnfS+K1e/QQPZbNgdgEGk=
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
Subject: [RFC 0/2] BPF signature hash chains
Date: Tue,  9 Sep 2025 09:20:57 -0700
Message-ID: <20250909162345.569889-1-bboscaccy@linux.microsoft.com>
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

Blaise Boscaccy (2):
  bpf: Add hash chain signature support for arbitrary maps
  libbpf: Add hash chain signing support to light skeletons.

 include/uapi/linux/bpf.h       |  6 +++
 kernel/bpf/syscall.c           | 75 ++++++++++++++++++++++++++++++++--
 tools/bpf/bpftool/gen.c        | 25 ++++++++++++
 tools/bpf/bpftool/main.c       |  8 +++-
 tools/bpf/bpftool/main.h       |  1 +
 tools/bpf/bpftool/sign.c       | 17 ++++++--
 tools/include/uapi/linux/bpf.h |  6 +++
 tools/lib/bpf/libbpf.h         |  3 +-
 tools/lib/bpf/skel_internal.h  |  6 ++-
 9 files changed, 137 insertions(+), 10 deletions(-)

-- 
2.48.1


