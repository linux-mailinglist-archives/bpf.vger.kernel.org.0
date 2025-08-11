Return-Path: <bpf+bounces-65376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB9B21614
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C970F7B4EC5
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B82DEA73;
	Mon, 11 Aug 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg2a0ZZn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF42D6E41
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942346; cv=none; b=XREzYz61YcBLkWGaZ6IH2g+/Szs+jN0HirFszIsrv63UlWVY7yCc8aVaTlWKRKwKdzoQdw95TGCoby3+XmF8WftQqWdttw7XbHV6lxpZDlkPBTwAJx2iBVe6sWPTHuM3vS3ZQ1Kf48B2f5tuEauDGy9STFcpEclyylhohJ+wPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942346; c=relaxed/simple;
	bh=kcOj5CT6DwROS/30k8OWZd07kNJm2KE1ZsH6JUjVVp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7HAuOqUtBXsvU4JlC2otVqYqFHx5ekvLQVJOJm2TLH9MfuRFzjjPDB8LQ4AV+aXOl1lxcs8llee06QPhXpNYznWQP/DmStio0g4Sj8xtu2gBboDe8EMIUI2j2Lx5dk3f3jGEgHSZz+Ur7OVU56LphoFy2+JT7sgRbCenmmqf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg2a0ZZn; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so6555498a12.3
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754942343; x=1755547143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQwV0QReLL9ZqKSXIzsQbtiJXIgkPCOv0plDyOP2KEw=;
        b=dg2a0ZZnGclwtQfXx+mfmp+K83tj4AktrVRp8vZ4d+GSh/Yp/DBJQJfS2XuYzL6hLf
         TAi45QmTfzqfCth4P1Xkcj8pXlebzlMsqYxnkS+1MLe3m4m22a1mTaAAMoCBdYip2+o1
         05xIGprdbkZ9qbmCuE+qJXqVgIG7sWPN7uRMlMuJiL2211g5Nz7CSRJRCtEV1bTuIQ/9
         fDe4xLEDeE0ZdlyyL+VGz4BnhXDsWaX7E+tgw8sJhKxMJPDVGB9aVbpj/oVSvVITOO8n
         IT93s9t7cV9pI3+Hx39J4n5Tg3cnH5XpZqrnVfwUqR+p6PiLKE5iaVOUi+Cj+en8NeVW
         BJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942343; x=1755547143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQwV0QReLL9ZqKSXIzsQbtiJXIgkPCOv0plDyOP2KEw=;
        b=vHObOUx57k53wC7QqRXTD4WUGJDtSF/cD4iY7M39cJtt/edPvVdaWCvLQR2JymrGCw
         tRgQWbVe3r1TKE5orhVzFbaYiysUynGBMJXJmSpnX9j7lJof8bpfic+JPksw8zn10+AU
         8gnUM1dSH5ZIar+DdiNrrGzPfBQAzcVTM1gHDYQd11fTnfj1vyoStc4MDDs8fz2WuRU8
         9Y2n7cPpGJ2xLEW/YJbSuxXVzJzETJhGGbOYQnP1fOXHMlNiscYdyJMoBqCPjUMoTjct
         sZfIQzGLQdCsz3T/aJsInpL6Bqkx21X/d5cpVorkAEhZfvwgMl0SFv7wS/cVcbroI98M
         +KAg==
X-Gm-Message-State: AOJu0YzTxJ/DAxmCoi/JhMbVjTfz5XQh0/G7+DERube5uxt98KTE9YAu
	TxjBjRNqVwtehq8aVDv4NbcC02qqfJyq2ArFJEkDX5ILPoNvGi0G6x8ofM6SVBGMY4Q=
X-Gm-Gg: ASbGncvsrgYva7KAHW6jOns6AfrnSHFMHHHM/VTjcVuI0ovWn3FMuTTotrn+m2Z115U
	uJzOvzX0srUDgWFNUSgy/732A3meP4ITjz9kt97kJNDALRGthaIvj0dLQ99bqLhW9S1lgGmyN7f
	kYG0CxSoj/E5NiHBHAR1QLX+Xhh7aNyNyHkdwEfIqH1luUE5NmxOH/hTsgejleLU8BAItikJ8/y
	yYGY7kWsn3sYyv1z4RPxKlFcttao+G4rfrVSrPJDAF/VwScTrcAUVT3XUSrp0Kb5y6mj38tjYLc
	k0qToJeWSKOZ/gepnQoJjAwfR4jf7HAaC0Sebl1sZ5zZAVer/+d+gyZ1qpaYHP9+glGBGjbSX5K
	PAnW+SapqhGo=
X-Google-Smtp-Source: AGHT+IFesO6qTYuqBm+dw6H5GaNzWU+o7vaM8DtJvBOfZwhunrLZCotXwsIemArYBbAkEHswrpdVKw==
X-Received: by 2002:a05:6402:510b:b0:615:8db4:2602 with SMTP id 4fb4d7f45d1cf-617e2c4bbfamr11893963a12.22.1754942343056;
        Mon, 11 Aug 2025 12:59:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6176052d163sm12928628a12.48.2025.08.11.12.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:59:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	tj@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Remove use of current->cgns in bpf_cgroup_from_id
Date: Mon, 11 Aug 2025 12:58:59 -0700
Message-ID: <20250811195901.1651800-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; h=from:subject; bh=kcOj5CT6DwROS/30k8OWZd07kNJm2KE1ZsH6JUjVVp8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBomkt4lQxjLxNNnRxppF1hymo/JhQZdY8nBUOI41br XTfTGFuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaJpLeAAKCRBM4MiGSL8RyglkD/ 9uD5gnsaU+TjnfJafuiIO02/xHhpmPGupv1EJgDQTrifHVvBNxxWIphJn8EDxInGt7or5nlCbW7Pqm 8xO9DhP2NZqcpQrCardyBVTMInV7+BxMmmmKzVMjmBX3Z6CrurKFg327UtE9pTl7pGXUV+JnShsLue x4CEN10paBJGcchj1XmjAq4NdMBBJ2sUO1kjkhAuYq0tx8O5BwpdEdO6zzdqOT3HdhSvaf++Uk/oEj dx8mL7m54Up5N+wZzIOTMYgAV7wNsKSmc7S9pSByrvVekw3fSdL0WxDPeXpSYGKQK4zhiCffKpkdoh DHs9jyFzHckzBqtb0LHjkmq2Un5oNUQhwlj1lBkDkWvD2RMfiiZIqT7uyizRO37mLtHvdBPNiolBaU Bd0ebuxBcrYQLymzMWpRXM3G7zvFRuijSFWwHbPYLfAEbhpqdD69CBB88el2pBulqj+souqwQhWWyS fen5H9FQUqTgoWoLmuYX5V/5MBzvHrFYm29TI1s5Nd71lRuv/3rR6EZne3HWq2kBrAcDCwXFzTxIj8 NxVQXMgL3nLR65rp/mUv2mhDDhtV9t2q0CdtchkOJY+1eV3DI6uuiYy3K6IL4neZQ9IiOkKP+IGXsc l8iQyFn33TG03OCqi9b2IuSE7akigpopY+K4QAln46thVA/ch8T1Na8r31Tg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

bpf_cgroup_from_id currently ends up doing a check on whether the cgroup
being looked up is a descendant of the root cgroup of the current task's
cgroup namespace. This leads to unreliable results since this kfunc can
be invoked from any arbitrary context, for any arbitrary value of
current. Fix this by removing namespace-awarness in the kfunc, and
include a test that detects such a case and fails without the fix.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20250811175045.1055202-1-memxor@gmail.com

 * Add Ack from Tejun.
 * Fix selftest to perform namespace migration and cgroup setup in a
   child process to avoid changing test_progs namespace.

Kumar Kartikeya Dwivedi (2):
  bpf: Do not limit bpf_cgroup_from_id to current's namespace
  selftests/bpf: Add a test for bpf_cgroup_from_id lookup in non-root
    cgns

 include/linux/cgroup.h                        |  2 +-
 kernel/bpf/cgroup_iter.c                      |  2 +-
 kernel/bpf/helpers.c                          |  2 +-
 kernel/cgroup/cgroup.c                        |  7 +-
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 76 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 12 +++
 6 files changed, 97 insertions(+), 4 deletions(-)


base-commit: fa479132845e94b60068fad01c2a9979b3efe2dc
-- 
2.47.3


