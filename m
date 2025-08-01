Return-Path: <bpf+bounces-64935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B36B1892B
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 00:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00C6161EA4
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF6226CF7;
	Fri,  1 Aug 2025 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbcneFTd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1591A256E
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754086841; cv=none; b=BbxhJ48w11OkuNS1Ox8cDa5VXDmozh0iimQEw2nJp2WFTzHYMg6WtS9cCpHVkspjg7H5Qiyr7blzu4mPAOks8W+qASFiPE8sVQ7GU852oqH5SUT2h6ZZVAhN+UFuipU28HaF3vKUp/DHYjDC4UDubIumGZzSXzkjWMdl1l9RNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754086841; c=relaxed/simple;
	bh=iu+st6VKp+dU5tcb5wf/kt0nYTV65rVEGg7pDQb5thk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CdfT9nMsA/xYd1wwxQUXwKtqGFjaPt5Mm3vK+/LnO+/Zk4CY+rtfm9+MWyB0XBEVaTiqUMOM1jrx8Y9nTIBtHckc1yt6HnKT0hk/zOg5Ln1xv7b9FXwUVY4+XroojD/yY09gRJrbh4b4OsJggw+zz3dJRuuu9xHZYV/l933zGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbcneFTd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c8f179e1bso18191615ad.1
        for <bpf@vger.kernel.org>; Fri, 01 Aug 2025 15:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754086839; x=1754691639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrvEr0EVpf8dmWz6JxMA/zaVvh4qgW9bU7KoA8XyTpI=;
        b=ZbcneFTd1rnsBy794sxkpNms/ylY2t8n4HmmhC2cHt/oi/3TXULmj1PIbVvKb7jrby
         U7HIMo+fupY4akkOzlEckip0NCFyFumoBQ7WNPOZzuyRF36DU2TR2uXXM43gjqZizMA/
         pw5bypdGbdA5qWF7keYjKhkCSgjbAKOtPjWdBkLvBsvksTxRlWc74bmsYn7dCAMn2l1I
         azV4ir+6c2t4VVCTlNuQU0slbCOuyzQ6FABTjBOTn8ObuN8wSTy334BHirvwbskd0NS3
         Rebh/XZ+uwfirwzDxFEWhwXxOutPvUJyUqsK5ErHhc6rT4yoa2piITAby4XjwNBo7/dA
         BU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754086839; x=1754691639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrvEr0EVpf8dmWz6JxMA/zaVvh4qgW9bU7KoA8XyTpI=;
        b=l3JD6Qmf24t/MtxF3e+a3rBGtlja74Uf8YNiHlyhdfnewxCfZ/H/nT9MT7bFlyUdaJ
         bKVCEJoM90CwuYWXvFI6xjAMD3fZLeOyohMMuopbi/1Rt+YJons/8rYDMCO9y9iAT0CI
         sTtnaY5rRs5iTdbzVPP+bQxfFKwQWCh31IRBV0FQ4ZTVwFMheSViBmJ3y1AE21YxS3lq
         GIDCvSqtKQVdPSY8jCe3NqBSlDsYOSN/7VVB3vMlw05X69R/YFvIAkTgFgxx0y48YpEk
         ygl1pQwdNVL86F7s4eFYIaLXmgNHFzWKPGvjDCaKK6FRQXrQkg0Vni8h7DuAWd65d85q
         sBFQ==
X-Gm-Message-State: AOJu0YzIQ4YubO1f9YPtOVVKoP8DjwspShjMiB7hMTRAqB8kENTUznnt
	agnBA6/TAbT2Ir/om+dpn0oJvmJgTlajhzfNSEg2z69eQttA+lA0LZPY
X-Gm-Gg: ASbGncuG57qQnwVeSQvGOTSe08levWYGuU2LKWefbOv6jkaR9fp25YqWhClr6Qj9SOu
	xnzYGEwJRRfo3nWO7rfPIg8vD7wZpugbztANn/jJMSddMOk/l5KhCbEkBzg2yIMoXnoclbZxyRY
	T/1DBJS34tcEn0RDEy2fGwNjFSPuwtacTJ9TP3wO9uBX9+vGNrayUST4fNrEraZ9Sk/JokzWRrW
	IASxdgxpPug+XFvzKfUJKbv8ICDram8BXnbmogQVf8EndRf3/jbEoZaeG4WZBC9GFvN+pVfMRYi
	XiGhmu+WfomdWfWLiI0LDkGDT692p3xRhummMZQJYQTowdgHnj2ne7mWywgvIHDHeDvzotd0Dqy
	/BsWyxi9m15DS6NPnPnGUsLl5djMUgBbjctkR3MqKwUz01rzTVKGsJRrj+8Cnw0Y=
X-Google-Smtp-Source: AGHT+IHseUPD8VQzR9VIJtuBbecfLWE7kOfakxdzFfrIfWQT6c+SmtZt0N4G/8SdfxmPaN7D6mf+9Q==
X-Received: by 2002:a17:902:da8c:b0:240:ce24:20a0 with SMTP id d9443c01a7336-24246f2d3d1mr15862555ad.11.1754086839302;
        Fri, 01 Aug 2025 15:20:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e585sm52185185ad.40.2025.08.01.15.20.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Aug 2025 15:20:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Subject: [GIT PULL] BPF fixes for 6.17-rc1
Date: Fri,  1 Aug 2025 15:20:35 -0700
Message-Id: <20250801222035.69235-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit d6084bb815c453de27af8071a23163a711586a6c:

  Merge tag 'fsnotify_for_v6.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2025-07-31 10:31:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to d8d2d9d12f141302aaec3ff9a3a8cbed4ac0546c:

  selftests/bpf: Test for unaligned flow_dissector ctx access (2025-08-01 14:47:39 -0700)

----------------------------------------------------------------
- Fix kCFI failures in JITed BPF code on arm64
  (Sami Tolvanen, Puranjay Mohan, Mark Rutland, Maxwell Bland)

- Disallow tail calls between BPF programs that use different
  cgroup local storage maps to prevent out-of-bounds access
  (Daniel Borkmann)

- Fix unaligned access in flow_dissector and netfilter BPF
  programs (Paul Chaignon)

- Avoid possible use of uninitialized mod_len in libbpf
  (Achill Gilgenast)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Achill Gilgenast (1):
      libbpf: Avoid possible use of uninitialized mod_len

Alexei Starovoitov (1):
      Merge branch 'support-kcfi-bpf-on-arm64'

Daniel Borkmann (4):
      bpf: Add cookie object to bpf maps
      bpf: Move bpf map owner out of common struct
      bpf: Move cgroup iterator helpers to bpf.h
      bpf: Fix oob access in cgroup local storage

Mark Rutland (1):
      cfi: add C CFI type macro

Paul Chaignon (4):
      bpf: Check flow_dissector ctx accesses are aligned
      bpf: Check netfilter ctx accesses are aligned
      bpf: Improve ctx access verifier error message
      selftests/bpf: Test for unaligned flow_dissector ctx access

Puranjay Mohan (1):
      arm64/cfi,bpf: Support kCFI + BPF on arm64

Sami Tolvanen (1):
      cfi: Move BPF CFI types and helpers to generic code

 arch/arm64/include/asm/cfi.h                     |  7 +++
 arch/arm64/net/bpf_jit_comp.c                    | 30 ++++++++++--
 arch/riscv/include/asm/cfi.h                     | 16 -------
 arch/riscv/kernel/cfi.c                          | 53 ---------------------
 arch/x86/include/asm/cfi.h                       | 10 +---
 arch/x86/kernel/alternative.c                    | 37 ---------------
 include/linux/bpf-cgroup.h                       |  5 --
 include/linux/bpf.h                              | 60 ++++++++++++++++--------
 include/linux/cfi.h                              | 47 +++++++++++++++----
 include/linux/cfi_types.h                        | 23 +++++++++
 kernel/bpf/core.c                                | 50 +++++++++++++-------
 kernel/bpf/syscall.c                             | 19 +++++---
 kernel/bpf/verifier.c                            |  2 +-
 kernel/cfi.c                                     | 15 ++++++
 net/core/filter.c                                |  3 ++
 net/netfilter/nf_bpf_link.c                      |  3 ++
 tools/lib/bpf/libbpf.c                           |  2 +-
 tools/testing/selftests/bpf/progs/verifier_ctx.c | 23 ++++++++-
 18 files changed, 229 insertions(+), 176 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

