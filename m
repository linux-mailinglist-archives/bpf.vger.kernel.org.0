Return-Path: <bpf+bounces-39995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C083979F0A
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 12:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E1D1F22BE4
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EA014D70E;
	Mon, 16 Sep 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc8iPExg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349857641E;
	Mon, 16 Sep 2024 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481657; cv=none; b=KBUrD4Flpr0tXl2xpgP4Nd3IUjI5c8t+fwAhc7saj91mnwuqjXoa1wXEsZ40RL3eAuwBJDF0ne9+1RPGZeqqBA6FH5to7urx7orwSRwqTqcRNM7fVlbYo/Re3UEhYbvVnI+LoOVI/4H1MRVjNJYbefdIrmHqcd7Y4npdZ6E31iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481657; c=relaxed/simple;
	bh=cqd4l5NL96y4FgAJKaSR/KdpC8j3ca5EZ6FXlMbbQRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMPl3a+kjvWyBJk24R1H9u1bbwuX9mfQGa91b7lzdAWNkqWu3BaDa/LB9PEKMpo76dpZ/+K1dyihvcBQqX3GL4/aO/IuccTdj9a+VgCHM2KTacR32gpOzwBtqrMIg4ScECBuD3loRd9Vfv28e9a+gjUNqzb5Ir/EHXFx1baVGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc8iPExg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C569C4CEC4;
	Mon, 16 Sep 2024 10:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726481656;
	bh=cqd4l5NL96y4FgAJKaSR/KdpC8j3ca5EZ6FXlMbbQRg=;
	h=From:To:Cc:Subject:Date:From;
	b=Cc8iPExgf4Br5NGlnb8CCgxowhdlFCFl5jw1b1VvlHkhhuvKGxG7Wy1tlQU9DA9yi
	 8Hxfuc7XdnrdpXsrynpVLj81N+L3yoAnRnMz9It0CYnkfDqGU5vzFVF9mC0ENtlvGE
	 Ald0VOAyrRn7XrpF9kP1fOb/1bfrGOc8iSsaFc2THEbUK11jOI2KH1vOo3BIIvm6p/
	 inExAX+ciGNH9G3zfFPXqSnNFyv75YeC6j+G0/xU4bIWLoBkQusGLroWI1m38G+NCs
	 /KAFJevDXy9B0Vx+nTKULWhwB41RSmYNOwCWvK0Y4/ZXgoSRaRURzud6Rnu/VgKqcl
	 iy0rXExCe2a5Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: kuba@kernel.org,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	dxu@dxuuu.xyz,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	lorenzo.bianconi@redhat.com
Subject: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Date: Mon, 16 Sep 2024 12:13:42 +0200
Message-ID: <cover.1726480607.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
NAPI-kthread pinned on the selected cpu.

Changes in rfc v2:
- get rid of dummy netdev dependency

Lorenzo Bianconi (3):
  net: Add napi_init_for_gro routine
  net: add napi_threaded_poll to netdevice.h
  bpf: cpumap: Add gro support

 include/linux/netdevice.h |   3 +
 kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
 net/core/dev.c            |  27 ++++++---
 3 files changed, 73 insertions(+), 80 deletions(-)

-- 
2.46.0


