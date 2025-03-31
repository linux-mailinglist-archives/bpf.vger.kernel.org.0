Return-Path: <bpf+bounces-55003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9092FA76F5C
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F65A165DAA
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C321A45A;
	Mon, 31 Mar 2025 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS0sgY50"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695B1BBBFD
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453123; cv=none; b=fzDh4+Ib7uwO6fswwBZPoxMABmlItHnaABNuoZetCFFtqnC4wP7uZOSPVGz257eLzl46Ccb/RiBJyHrOjvikYDi1nO4xHx3OSI3OrHftNICmae5bHvNCf26TKnSjvyvqrg0YyIpImnsbDXqWKybB/IjGN1CS9Rmyee5hhl1OQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453123; c=relaxed/simple;
	bh=e+tQBoVL5aWGWRUYMR6blPrf6R3rHEia843Z2DpupCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q8XY0yQ7s3eAynXJrjU8v3ctPQnqrB4uXLoVHv1CYNoF4jeiDMor6VFkLsixi0UrELY8WcfHE9Gbe9m3mDV/n8xMRcDx1jIOwP1LNtJurWSgMlO1r00mwlPVKFGMTFveVAoowQ1hQfkbhUhyevyihWqu4pSoOTR1vf5jPrg7VVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hS0sgY50; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so5015104a12.1
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743453117; x=1744057917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BG5ukwjAqIGFXmvef5IUOdwrnpl+xmUgyjg6IDS2ivQ=;
        b=hS0sgY50SyRf/SYj61HP8WGecWsh+OxpIoub2X1Wld2Ej9iKAJRVSKLeZemSd3iNsr
         txaPc4HcDqkjpTxC0gTsEmNOL7UDYtR/UD/k4Vbp24AfYbDYeHGtdkO5VIMUFW+aE8iJ
         jjCMx5I2eDzCpYkooayTWGCuAuFgX5K5CnMAxK4a+Bcf9/OUIDXpVlpQVMMMV87hliOC
         yhySysVfQh76vvDEi3+dlEVWyjLmSTEGswpmrzi5QAyfXNqZOUqwvESBbfTtw941F1hj
         bXjOgQOTgvtIYIp32zxojI7qG0REezxJmMtrPF+O6Z3FPsyZP6KPkwqIsGTnK+ODWtyW
         8kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743453117; x=1744057917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BG5ukwjAqIGFXmvef5IUOdwrnpl+xmUgyjg6IDS2ivQ=;
        b=VIA/O+YEnQe59iwNXtISQYKAmOmZpwyXzmO2sLxQBnV0nAuOg8hb9qVCwPTMWsyH/6
         mCoOgq3IWm4FIMWtJYQEaOYl0+wuUQ9ZIQFUKOxHsd9J56iIbyGA1k0nGRqHLXnutZmM
         WJCHs7m51RTgAc0S5hI0E/CeNgRqOHfUnmNPrxOeUasCLuDaCRwHWiTCyRhV1Ch2OsWJ
         9VBLkAYQC5HSKrpYjkYEkD21vwNm+M47jnt5S7L1oL+52uBqrk4NEbyfZRKuo3lICoYE
         C9iJSM7lp1puNY36lMHGddcIWCYhn0RZJMjhIUwaAZOuwLd8yzCs0zvF9Bub6tk8M/CT
         8T3Q==
X-Gm-Message-State: AOJu0Yz3DMeh6gufbkRVRBv5VEWqvgnVtQB5Px6MJ1XLwhfRTYj7ygBy
	rirt/aOZerk/UYEKsDuD2HYIfF6YxlGnhb+MszxFSbsHAEj/qyX+I4LIkg==
X-Gm-Gg: ASbGncvJYYWo26WCez2h5rEGLbhWvpHP4LwF+WvXGtxNXEdOp1LbGUhdawLRycA8BdG
	15/qbS0I+DA6hWFb8vdcY5JSMDHpTTirjJE62Sd2i91+h49yOqyvnml8lHYqnid6izzO+uSH7cS
	sl2eNInjRcLg7tCe+tnbzBDBHmXxnKFtE8IRgE2ANq4IPHeDRY5lf/qfGgiR5KkbTSQ7tGC2p0D
	QJ7Y1h84+w2wXffOet38Uh58wH5zQ2aJJZw23bT7oGkWKOk/gsGeNwMNkI4w5w5nug3Qk7PFMtB
	UIaBzZLM1FHT/hfAMqQ/Q5hdg3PjV28UcbAd0LbKe8vqOCZxoGOJ6qYAvP6hTXVP
X-Google-Smtp-Source: AGHT+IHn31uet7Rxh3TUEMXPSKpat3xoqxC7ZQLsEQz6b/p5gNSUeSOv/AiFv+diLsPWoAafJ7vBCw==
X-Received: by 2002:a05:6402:84f:b0:5ee:497:89fd with SMTP id 4fb4d7f45d1cf-5f02b38ad17mr356105a12.34.1743453116348;
        Mon, 31 Mar 2025 13:31:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae2fsm6030589a12.4.2025.03.31.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:31:56 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 0/2] likely/unlikely for bpf_helpers and a small comment fix
Date: Mon, 31 Mar 2025 20:36:16 +0000
Message-Id: <20250331203618.1973691-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two commits fix a comment describing bpf_attr in <linux/bpf.h>
and add likely/unlikely macros to <bph/bpf_helpers.h> to be consumed
by selftests and, later, by the static_branch_likely/unlikely macros.

v1 -> v2:
  * squash libbpf and selftests fixes into one patch (Andrii)

Anton Protopopov (2):
  bpf: fix a comment describing bpf_attr
  libbpf: add likely/unlikely macros and use them in selftests

 include/uapi/linux/bpf.h                          | 2 +-
 tools/include/uapi/linux/bpf.h                    | 2 +-
 tools/lib/bpf/bpf_helpers.h                       | 8 ++++++++
 tools/testing/selftests/bpf/bpf_arena_spin_lock.h | 3 ---
 tools/testing/selftests/bpf/progs/iters.c         | 2 --
 5 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.34.1


