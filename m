Return-Path: <bpf+bounces-70773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075DBCED51
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 02:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F2119E2223
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F42CCC5;
	Sat, 11 Oct 2025 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJfDQHqU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5529CE1
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760143647; cv=none; b=hO4Z73Nd9MduzlopeSfF9wPiAkYT6ddPeSLrVhO7PSEYJzddmmCQdl8GDjW8g6Bdjaq5rAHmrOxZaQdoxEe6t1hsGuXYx/ikBZXZXLDikFYdTjIa4ddihEHn21sIDFP5dQCWsEyL89Kus08+Mb6vm0SUKKN0iYw4hym+xyOOiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760143647; c=relaxed/simple;
	bh=IzZwqQlJmdFgvIfSo90c57b6XMhjEuThr1Pzx0MCdlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siSS86c+18omxGCgtWKhvQmdhoNk/kUhnIXcEcXepIo8RCdZveMsquN47AIpXwPTGNmmj3pZtEBD6+USLYvAc/f02y1ED83C99BTw/8yH5t33W8/paB4FFNqJTXWVL0jn7wBGMBfecaiMpRg9Av8R6ztHCmcmJhIO1joOB6vDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJfDQHqU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7811a02316bso1882142b3a.3
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760143645; x=1760748445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05i/RZmvfNgYX6pYfdtCIi7ufvv1hAR0P/892TqUbb8=;
        b=lJfDQHqUXeKPjzzZ9Foy5suhD/ak8PFcak+PeZdCddB8corwe+8krW425WyivJlWY/
         n1Uw23lgfzXCGLfEYHQzYJorZG41ugf5bX6ICEQXlucysvWICC0pomyeGvbaA4lwstc4
         qORdQ4hgH/j9JxGO85lc5dBt2SxjBQa9Rst25xfArBacL6eJKdHYKs0HkpZqgDVuv8hd
         CTW/teF08mvWNSHzdv+BNJ/QoCi2nP/elMWwXXGaQWGxfOoSCMNsnziMQSIboTZOat+y
         YumItVMt+15thKqy3yfzc7pjx/QF/wu9EuucwdVWBF7b5mNk98M6AscHcqFKQxQg4Ux0
         JdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760143645; x=1760748445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05i/RZmvfNgYX6pYfdtCIi7ufvv1hAR0P/892TqUbb8=;
        b=GNwE/muzlCXuNzNJK8dA9T3kYNs9fLhrPuxW0U4LjLlu9i1GosGRUzLAeMnExzPqdn
         Gi+sZal8bKgsZ99CT9Q8f1Y5S/OcvBw8boVk70HkdoiysP6gf9UbFhbnsPkLA1yTERUE
         dYQlQV3xGMOSM2mRiYs7ehpY5j/yCuw23oY0IkLLdT8DUGxKD43eMk9/Sv4EmM+sj+Xd
         6TEHadbeiHThzKZBnORbd9PMgrPYOuicaYIE5jaDZDUnw4UDO0ig4OT5IlH4vFPr8W4M
         oCz9X258x5BfMnKf1OHVrmmZLmHFe6INKOUo+dFX3bFasQbiylHlTD+hF7rBz2Qs5cZD
         RQlA==
X-Gm-Message-State: AOJu0Yzi8/sA7Tp0l4A0BTFR5iXDQJHUS8wVmTqbZPqG/ZkGliNYsfCv
	GC4UdtRGQn6EpYECECfyMubfZECQuBAz+DjNeFIuOEldbgPVGLdyMTOtlHc8tA==
X-Gm-Gg: ASbGncuMnzsqlyTUrtO1uYrGPpKGLS/doPSbg0q/jNr2QkkW+UBrcYlJXZAaMxRNxRG
	ie1NIiDGHHMIM595FOTfZ/EoqkefZTrz1EMCZpLOsVm4pp0L1auNshWaUu/eXz7jK/KMCKUMw6K
	VW09/isbvSa62Lr9/k7cgZTWUXuq8KtlKJK8KoIOQfCy0eBmAuexwehMVeffirTdsDIw2y4ytFN
	Oh+YgW4byp3sUam4LoY91El4fwPjuVsX1oJzn+r4CzMXPv6ieu/5DpPT+Kmor2hZNQ2WUyAwslW
	6K/bX+AINPLA1Npe9COs8shJqyPEQtPEL3+HeSHpn2djlJMH38V3mF9HSnfzWbVwDbwonVfHHkz
	rwmWCM9LP5Nmc5aAY/XpTH4mMrU+osHj9xePfsLwQb6fJwKt1BbTVpHcF0DESTjNfvehmCtXsQc
	c4TGprQJghaTuoy/GMfBci
X-Google-Smtp-Source: AGHT+IFZL7uHCvmIyUTsrsHRVHWCccP9V2g+EBYfkeUcgB4vuaWc/slpC40MFav4lOTbFSfuMZPGjQ==
X-Received: by 2002:a05:6a00:2e96:b0:781:d163:ce41 with SMTP id d2e1a72fcca58-79385ce7bfcmr15164602b3a.11.1760143644884;
        Fri, 10 Oct 2025 17:47:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837e:3c50:1021:a424:7dd1:a498])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060c4esm4329077b3a.14.2025.10.10.17.47.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Oct 2025 17:47:24 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.18-rc1
Date: Fri, 10 Oct 2025 17:47:22 -0700
Message-ID: <20251011004722.81978-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit cbf33b8e0b360f667b17106c15d9e2aac77a76a1:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2025-10-03 19:38:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to ffce84bccb4d95c7922b44897b6f0ffcda5061b7:

  Merge branch 'bpf-avoid-rcu-context-warning-when-unpinning-htab-with-internal-structs' (2025-10-10 10:10:09 -0700)

----------------------------------------------------------------
- Finish constification of 1st parameter of bpf_d_path() (Rong Tao)

- Harden userspace-supplied xdp_desc validation (Alexander Lobakin)

- Fix metadata_dst leak in __bpf_redirect_neigh_v{4,6}() (Daniel Borkmann)

- Fix undefined behavior in {get,put}_unaligned_be32() (Eric Biggers)

- Use correct context to unpin bpf hash map with special types (KaFai Wan)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexander Lobakin (1):
      xsk: Harden userspace-supplied xdp_desc validation

Alexei Starovoitov (1):
      Merge branch 'bpf-avoid-rcu-context-warning-when-unpinning-htab-with-internal-structs'

Daniel Borkmann (1):
      bpf: Fix metadata_dst leak __bpf_redirect_neigh_v{4,6}

Eric Biggers (1):
      libbpf: Fix undefined behavior in {get,put}_unaligned_be32()

KaFai Wan (2):
      bpf: Avoid RCU context warning when unpinning htab with internal structs
      selftests/bpf: Add test for unpinning htab with internal timer struct

Rong Tao (1):
      bpf: Finish constification of 1st parameter of bpf_d_path()

 include/uapi/linux/bpf.h                           |  2 +-
 kernel/bpf/inode.c                                 |  4 +-
 net/core/filter.c                                  |  2 +
 net/xdp/xsk_queue.h                                | 45 +++++++++++++++++-----
 scripts/bpf_doc.py                                 |  1 +
 tools/include/uapi/linux/bpf.h                     |  2 +-
 tools/lib/bpf/libbpf_utils.c                       | 24 +++++++-----
 .../selftests/bpf/prog_tests/pinning_htab.c        | 36 +++++++++++++++++
 .../selftests/bpf/progs/test_pinning_htab.c        | 25 ++++++++++++
 .../selftests/bpf/progs/verifier_vfs_accept.c      |  2 +-
 10 files changed, 118 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_htab.c

