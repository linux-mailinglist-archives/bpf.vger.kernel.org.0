Return-Path: <bpf+bounces-29051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CD98BFAE3
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA3028130C
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642EF7C08F;
	Wed,  8 May 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+S+UYBj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656A2575A;
	Wed,  8 May 2024 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164020; cv=none; b=WCZ9Vgu8exbAh9frplYzt05GKOWShXYAASZmCO1GyENGq4Y/0cRR/o00FN2Pv6AYiKv+nJjCpc8wC6BYk7SpZiDQDRXIGznLEOufjhHjYofz/CJwDprzRLOUmwk2fQJxJunbHHMlt7/RVSz452a+qp/+1cq9wwPnCbXETsHLm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164020; c=relaxed/simple;
	bh=TDjcRvvAfwwjF7nDIlrDZmJd8qCh0KeSglQB1DiOab8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BjhRLQq+DKMklJr41OBDtVW6/sPJzDn7Cm54PZ073hbuKK8tLP/yASMRg2rchKK6ejN1tjPo9yrl+OopiaG4PKUuIiBmVjD9pPHsmWSDGnqkbmNQ2eTE7OURoY08RYjH0I2Lo6doMEz3dGSvpCBBKDf8H2+1KgOwUukl3CG/AXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+S+UYBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DC7C113CC;
	Wed,  8 May 2024 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715164019;
	bh=TDjcRvvAfwwjF7nDIlrDZmJd8qCh0KeSglQB1DiOab8=;
	h=From:Subject:Date:To:Cc:From;
	b=p+S+UYBj0vyhNBr2JGrtR3vISEggONWqaZnfbY6Um6zWEtcXnXQqIkBmTCQyQ7fA6
	 mJg6/uUW7jNf4Y723UYTXYbTsmwOXg9087wXYnae7YxahNdoS4Aa69qbIQH9kMwfYz
	 A2tYdS2HM1q0jvtK0BK61xXmezs/KcQkvTrqJxjdI1sL2mU41hkxUjHK0p2p9QC4PB
	 cV8tuPBlTvDZ+UfTRfI2+pev7DtaL5CIm5nzPiZvzMthOE3eWa2MGpA7baSWY4blx1
	 E1rFQ3Cv6cOmZkW+shbkRjOj0SAMM0+MLSphl0xuiPp/fXGsikMRKUjDnfRCkGTIoo
	 8VTmJmE4H3/EQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH RFC HID 0/7] Use the new __s_async for HID-BPF
Date: Wed, 08 May 2024 12:26:35 +0200
Message-Id: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtTO2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwML3YzMlPikgrT4xOLKvOT4tNI8XSPTRIskS/MkU2NTIyWgvoKi1LT
 MCrCZ0UpBbs4KHp4uSrG1tQDRfoztbAAAAA==
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715164017; l=2093;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=TDjcRvvAfwwjF7nDIlrDZmJd8qCh0KeSglQB1DiOab8=;
 b=PUIB8qS1sxw4D6ki+B5ZdIu5R3yjVUMPLnLrLl7kfEhIR/xZHUkd2Kw93x21KsIw4Cxe8ISh9
 eJEJJkLt2OyC5SQ+hGbmL3pIZQIj1g0Vd1S8eAaFBUdfwsnHKcJ/CBp
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is not meant to be applied as of now.

This is just to show what I meant for [0].

And of course, this doesn't even compile because you need [0] to be
applied and the branch for-6.10/hid-bpf on the hid tree.

The purpose is to remove the bpf_tail_call from the preloaded bpf at
boot time.

Cheers,
Benjamin

[0] https://lore.kernel.org/bpf/20240507-bpf_async-v1-0-b4df966096d8@kernel.org/v

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (7):
      HID: bpf: change the prog run logic
      selftests/hid: fix bpf programs for the new attachment logic
      HID: bpf: allow for sleepable bpf hooks
      HID: add source argument to HID low level functions
      WIP: add HID-BPF hooks for hid_hw_raw_requests
      WIP: selftests/hid: add tests for hid_hw_raw_request HID-BPF hooks
      HID: bpf: prevent infinite recursions with hid_hw_raw_requests hooks

 drivers/hid/bpf/entrypoints/Makefile               |  93 --------
 drivers/hid/bpf/entrypoints/README                 |   4 -
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c      |  25 --
 drivers/hid/bpf/entrypoints/entrypoints.lskel.h    | 248 --------------------
 drivers/hid/bpf/hid_bpf_dispatch.c                 | 252 +++++++++++----------
 drivers/hid/bpf/hid_bpf_dispatch.h                 |  12 +-
 drivers/hid/bpf/hid_bpf_jmp_table.c                | 199 ++++------------
 drivers/hid/hid-core.c                             |  91 +++++---
 drivers/hid/hidraw.c                               |  10 +-
 include/linux/hid.h                                |   6 +
 include/linux/hid_bpf.h                            |  33 ++-
 tools/testing/selftests/hid/hid_bpf.c              |  61 ++++-
 tools/testing/selftests/hid/progs/hid.c            |  91 +++++---
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  60 ++++-
 14 files changed, 449 insertions(+), 736 deletions(-)
---
base-commit: 89ea968a9d759f71ac7b8d50949a8e5e5bcb1111
change-id: 20240508-hid_bpf_async_fun-25a8b97b5352

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


