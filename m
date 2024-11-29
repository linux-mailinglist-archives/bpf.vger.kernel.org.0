Return-Path: <bpf+bounces-45871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675A29DE775
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 14:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C141281794
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614D19E826;
	Fri, 29 Nov 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Hp58cj8n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CB19C566
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886757; cv=none; b=tyJnFbF/5Pl/2QNB9YCxwvht9NdsYc1/6/v2UKwm5a3b6tU8F2YbH3F1g5f3JuxiqxLMFaF4P1iqZIo5FqtzBui5/7k+6rxeFBh7vJVqbfATRsU2QJTK19zBnSjzsqpatFiZ74E6YkcZ8AbvsmHc9YZVMGf4ywa2/wAp5tSEAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886757; c=relaxed/simple;
	bh=EbqQOYmvU0HOylNCWGPSatmxbm1FJ6kKXn0PapaUQFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GIkuxMQlZelvt4yioH1h0VZgN93iDhf5npuMrXRYHwRQAcvL4XzWFUaqVrRlUajYnHPPxVfByJ+ckzwAKnk4YRqmhU1aHNgI0dE9wk67ZvnpUuWoNnjPMPVXpacLZa1bGmzFAHEz8MKjSJuS46niYlPvEo9H4vlQD3YaofFcpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Hp58cj8n; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df7f6a133so1894734e87.3
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 05:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732886753; x=1733491553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPrqDR5aZMH+JKW958GM/gBIWGFsUJdf4oS+dWpc8Hs=;
        b=Hp58cj8nEFP9SR52f/EwyG2adzoFS6NamXa2L3snoX/AvATKUVG1640/NMOvecD9J+
         lFHudzt20CkuefQOfSy15vBwQLHa3f3vokR7nB7Glylw/ZdztoUsvx+AXiWRXQB23ZVe
         PFV9bYKB+gI4FsLVk9OrpTT4XONY0fSdibV2OPgRTxEbRkvGgY3xk+KYsdtdWH7wSTff
         aujT47Zr54rUsFSpa1tdZO8MAJS6Wm12BIiYwABgvdieIy6Bqm4VaGK3TwRqlTV165xG
         eSXjfbwQz4FLmWepkgt6d1yxz0wxK9f9Wnboyfxz6SXU6aeBZxaGP5rvBbKmlPUNZ3NL
         YqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732886753; x=1733491553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPrqDR5aZMH+JKW958GM/gBIWGFsUJdf4oS+dWpc8Hs=;
        b=k1cphjuDfRCIxQkOrOSBMZQevOE9ouNwDGhR9EXIkDF+8fE6FT5OOBkjRH34Uy59Pu
         vIapaQfYbslI/ubMRP8FFO0MtGFJPX55WU67C6iBzg15vXsfTRyDNSR2Sa4fKfIc6LPA
         BhDrGW/wqXa8PUex/pxENDFnqVSLjXyjXCXqTmxBQer/tJUX6HeRPkk/TsvHo9iqumDw
         9MPh0tNPRxu2TEeKlPIg/SRjwjToRG9WHNQCUpXz7HFKFEciqUfbaavZ8lbJ0+YnkpHy
         5ujHugSP3N1PWVfC8G2i6//XPcxd6P1dxEPd2rL1HnvGjS2Mj9OgynobTSUbnkUfMSJD
         813g==
X-Gm-Message-State: AOJu0Yw7gDEjGxXUoJb6YeKuel3attvGvbyEA5k3BMrB4cmrx2g0l+d1
	Cfyjqmu79MhLWCD9ZuNZT77v0FiHPIJqM1aJLtI1g3uu8oaXCgKeueVLG2TcBwVTRRJt2QMdqQy
	c
X-Gm-Gg: ASbGncs01nYHtiIX8ZgINlCtI7GpQVrEnaZ731dl2/MUf7jXmPbWi63uf0jt0EDuFCI
	ukVhktLtA5gKhX40LxevgmYbxlGketmmxpADpHr08+2wv7Hb7fif1XYZO/RPDmz1mmDOJ+2SVA8
	Mp9S7idCS0f1mYL1yiqCXOiJdz6NRkwz7p2jRSLULcqxDkdMTZ0o8oZ812XZ/tfKXUzi0Uh/mKG
	RKKCRBscl3IjjGq1NsuKFJiq73wrqUcEUlI0tMyECodGVHNpypdl67giWefiBw=
X-Google-Smtp-Source: AGHT+IGRiJQxABLu69fXh/nsrYWA1CCRR7eX5L8PVwixvGRLrIimrR5wfEUYdYuvfUCxA/6/NwI57w==
X-Received: by 2002:a05:6512:3ba2:b0:53d:ab21:4e17 with SMTP id 2adb3069b0e04-53df010e3dcmr6697435e87.55.1732886753341;
        Fri, 29 Nov 2024 05:25:53 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599904f33sm173295066b.135.2024.11.29.05.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:25:52 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v3 bpf-next 0/7] Add fd_array_cnt attribute for BPF_PROG_LOAD
Date: Fri, 29 Nov 2024 13:28:06 +0000
Message-Id: <20241129132813.1452294-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new attribute to the bpf(BPF_PROG_LOAD) system call. If this
new attribute is non-zero, then the fd_array is considered to be a
continuous array of the fd_array_cnt length and to contain only
proper map file descriptors or btf file descriptors.

This change allows maps, which aren't referenced directly by a BPF
program, to be bound to the program _and_ also to be present during
the program verification (so BPF_PROG_BIND_MAP is not enough for this
use case).

The primary reason for this change is that it is a prerequisite for
adding "instruction set" maps, which are both non-referenced by the
program and must be present during the program verification.

The first four commits add the new functionality, the fifth adds
corresponding self-tests, and the last two are small additional fixes.

v1 -> v2:
  * rewrite the add_fd_from_fd_array() function (Eduard)
  * a few cleanups in selftests (Eduard)

v2 -> v3:
  * various renamings (Alexey)
  * "0 is not special" (Alexey, Andrii)
  * do not alloc memory on fd_array init (Alexey)
  * fix leaking maps for error path (Hou Tao)
  * use libbpf helpers vs. raw syscalls (Andrii)
  * add comments on __btf_get_by_fd/__bpf_map_get (Alexey)
  * remove extra code (Alexey)

Anton Protopopov (7):
  bpf: add a __btf_get_by_fd helper
  bpf: move map/prog compatibility checks
  bpf: add fd_array_cnt attribute for prog_load
  libbpf: prog load: allow to use fd_array_cnt
  selftests/bpf: Add tests for fd_array_cnt
  bpf: fix potential error return
  selftest/bpf: replace magic constants by macros

 include/linux/bpf.h                           |  17 +
 include/linux/btf.h                           |   2 +
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/btf.c                              |  13 +-
 kernel/bpf/core.c                             |   6 +-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 215 ++++++-----
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/lib/bpf/bpf.c                           |   5 +-
 tools/lib/bpf/bpf.h                           |   5 +-
 tools/lib/bpf/features.c                      |   2 +-
 .../selftests/bpf/prog_tests/fd_array.c       | 340 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/syscall.c   |   6 +-
 13 files changed, 535 insertions(+), 98 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c

-- 
2.34.1


