Return-Path: <bpf+bounces-53616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5192CA57399
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 22:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848C816D9EF
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905622580D0;
	Fri,  7 Mar 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtrPQ7sl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9E257AFF
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382982; cv=none; b=meLBlcCsWF708fnsuPjqP/GxrlWeBlqU0t8fqklYxuG9HH3WM9kex4dHF2BsjyrJNYpBClzEyAWA3d5kg90tWXxlIVreNpgodntLDD5RQL3mKuwPFZIsUVj1kx4VTDdlEfN2dOIvoHQ46h3DF0PrRkyMYukauba9U1PbB/6bdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382982; c=relaxed/simple;
	bh=6+Hzu3TD7JLYndiuHh1soH4S+afWzHmwK3LXYRCixVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiHxD/6HfvQjSwVATuWHh12RUgZ6fC7Z+UEhmgsdwdnd9BivZCsNA8alxxHsP6S297iEfxqhZ4NN0uJl08gyX6Fl+6QwsJnLCCwBHD8Fvu7i5Qtg/WzGptlmpLTp6KvNATKRlB+JvYJE5zSv+ZHFL9zIzfJkLpqnCi1/Z6QZReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtrPQ7sl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so13930415e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 13:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741382979; x=1741987779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P48cNMAw/taofa3nP9xQoPJTbO204I9XxNmdCdVNQxc=;
        b=KtrPQ7slCsADntxpYRup8UHcdi4f8apcEBf9R1VFOXm+0KVF8OBgPoxCNqnVqBxDHM
         Y0D4qB6KV7+EM5Au2eodH1vKoK2w9OADu8YD5eEsm/rL3pOBuPywiU9vT0kJJbCT3qzw
         lZIxp+YdPZQYvpLvwVkf4lb6IAZN0K/ASrr4OtVoMH8a1Y6cXaEXArX7Gz5BnPFNtfp1
         3hyGmEoKrTjBEvufYBKa7727yktH9LJg1NwXjnIKfEaNSs+xNi60Zy++B9sEX2/Rt33R
         N5hWOOhXsDvI9sGBtx71f2PRdu3vlNIYx0Yu4eJ9XiyDjWBYAPqwXz/aKFeZ3lETSAxc
         02fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741382979; x=1741987779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P48cNMAw/taofa3nP9xQoPJTbO204I9XxNmdCdVNQxc=;
        b=bK9l5XRtbBwFTL3BKlFZSVaR38oFkZiIb+BQ72T9BH7wKjBCZONnK7rNdACwJny8PP
         jfMBCH46tD8evPK091ngt2VW1bu32Y6xvVaHdPEFwVKhR7jkntU0SJPPz7LLKfkuG8nJ
         3aLQ4ffLKGTqGaniXjEuc4uNFqsji3akpG2E4wMfYRH/xIebYZ6ShQNfZdiXoiwqQbzd
         q2dJzLXdPkB1l5GZuNPJ4KIz37Yf5OfDGHLV1+UAB6viMFdme8hTt10xqVsBZ83dSbDJ
         5gzjJIEOpTEgmmiXhVwSf1kat/0ei5LO7UP8L31gYzdEEMPyV35eeUL67wz6utJTIppz
         fC5Q==
X-Gm-Message-State: AOJu0YzZrH48udAnMOjT/45mr3MqVqFX7cOyZAhQ7BVsETl4nhhOzdhq
	elHP4XEyp4D0lqKlZ3AT5HjBPaMuaXNLayjz90U14PX9dqw3YZaoH+iAMg==
X-Gm-Gg: ASbGnctujTNCSJvnChztIQv9/cctlf7lfL5ppkupasyjEDPENJCHdKbY2crRPG/JBT/
	eb/0PUucsraOU7d4QoGOd2//oJHGBSQ5eHcmOtuuyTKvNukXq7aMwEikN8IcTWEEpI28Fo4new1
	AXNpl8Wn78LKA1R/WLIVK2EQojHRD2knfUkqBGcpU0MCvd5f7lIVL3Bu714M6Ud3w7+4bCnor5/
	kNog9YheweUxhFxNPXjLp2DZ/XauOt8Gv/WzIY6XBo5P17ytegXHl92PUR3NYmk2HlSDl01irRy
	CZ2x5DCOrWFQtlkLCfhD/eIPm8DYBZ+oExe4kAHISDzRP+WdiEQaW/40uZFaqFP1ELxFgw78MCo
	evTCBy+otxs2pL7mjxAJ1eXWRxwkEjgL1Tz07vTaxBXxBgVnIvw==
X-Google-Smtp-Source: AGHT+IEe/JP0Gcg1k8x68c6FayTec2HVzenvadjosgVaHakd4nHnKT2X699qE3aYFxP8khwh67jplQ==
X-Received: by 2002:a05:600c:3c8c:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-43cd169b363mr31008235e9.11.1741382978546;
        Fri, 07 Mar 2025 13:29:38 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352e29sm92203145e9.32.2025.03.07.13.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:29:38 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 0/4] Support freplace prog from user namespace
Date: Fri,  7 Mar 2025 21:29:30 +0000
Message-ID: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Freplace programs can't be loaded from user namespace, as
bpf_program__set_attach_target() requires searching for target prog BTF,
which is locked under CAP_SYS_ADMIN.
This patch set enables this use case by:
1. Relaxing capable check in bpf's BPF_BTF_GET_FD_BY_ID, check for CAP_BPF
instead of CAP_SYS_ADMIN, support BPF token in attr argument.
2. Pass BPF token around libbpf from bpf_program__set_attach_target() to
bpf syscall where capable check is.
3. Validate positive/negative scenarios in selftests

This patch set is enabled by the recent libbpf change[1], that
introduced bpf_object__prepare() API. Calling bpf_object__prepare() for
freplace program before bpf_program__set_attach_target() initializes BPF
token, which is then passed to bpf syscall by libbpf.

[1] https://lore.kernel.org/all/20250303135752.158343-1-mykyta.yatsenko5@gmail.com/

Mykyta Yatsenko (4):
  bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
  bpf: return prog btf_id without capable check
  libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
  selftests/bpf: test freplace from user namespace

 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          | 24 ++++-
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/bpf.c                           |  3 +-
 tools/lib/bpf/bpf.h                           |  4 +-
 tools/lib/bpf/btf.c                           | 14 ++-
 tools/lib/bpf/libbpf.c                        | 10 +-
 tools/lib/bpf/libbpf_internal.h               |  1 +
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +-
 .../testing/selftests/bpf/prog_tests/token.c  | 97 ++++++++++++++++++-
 .../selftests/bpf/progs/priv_freplace_prog.c  | 13 +++
 tools/testing/selftests/bpf/progs/priv_prog.c |  6 +-
 12 files changed, 158 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c

-- 
2.48.1


