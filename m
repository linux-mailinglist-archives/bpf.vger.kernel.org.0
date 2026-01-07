Return-Path: <bpf+bounces-78075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDFDCFD026
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7879230049E3
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19132FA2B;
	Wed,  7 Jan 2026 09:54:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailer.gwdg.de (mailer.gwdg.de [134.76.10.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246732FA10
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779670; cv=none; b=JCLUwTUdbkNb6eAMt5jISZ6A/j04PaKNdHm6IufpB4553ntcpn4qpUcdr8cxtbytR7mFi1YnmQJBvcpnzfsDj9aoBf7QJL2fFpoAq2ENCh6S6WzMwjoxXwYl+6fz+ajmf+koWEqdtx+vqueIvDzfZ85458PS/y2Na9/yApzdtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779670; c=relaxed/simple;
	bh=T4idHRVGD/EZcrrQXkuNkZKiTFlhK1Y2Wl+apj5errE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1ibMqAnUZ3H118ovqeepmNKtebeGsK6/rt3eQuxVAKFOS+JWtLhpRrE1NxVpqvOUWJNDgIjF2R2Om1bMLjqOTUxYA9bjnjMwUlHem9lpwXYv0TwIv6TbhnNzoeHS5uR20k4QxuqpkBjSkYKEIZwypZBKaH6jCSMWKNjgD8rfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; arc=none smtp.client-ip=134.76.10.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Received: from mbx19-sub-05.um.gwdg.de ([10.108.142.70] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(GWDG Mailer)
	(envelope-from <lukas.gerlach@cispa.de>)
	id 1vdQF9-000S4B-0L;
	Wed, 07 Jan 2026 10:54:19 +0100
Received: from Mac.lan (10.250.9.200) by MBX19-SUB-05.um.gwdg.de
 (10.108.142.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Wed, 7 Jan
 2026 10:54:17 +0100
From: Lukas Gerlach <lukas.gerlach@cispa.de>
To: <luis.gerhorst@fau.de>
CC: <ast@kernel.org>, <bjorn@kernel.org>, <bpf@vger.kernel.org>,
	<daniel.weber@cispa.de>, <daniel@iogearbox.net>, <jo.vanbulck@kuleuven.be>,
	<linux-riscv@lists.infradead.org>, <lukas.gerlach@cispa.de>,
	<luke.r.nels@gmail.com>, <marton.bognar@kuleuven.be>,
	<michael.schwarz@cispa.de>, <palmer@dabbelt.com>, <pjw@kernel.org>,
	<xi.wang@gmail.com>
Subject: Re: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
Date: Wed, 7 Jan 2026 10:54:05 +0100
Message-ID: <20260107095406.4082-1-lukas.gerlach@cispa.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87y0m996b2.fsf@fau.de>
References: <87y0m996b2.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mbx19-gwd-01.um.gwdg.de (10.108.142.50) To
 MBX19-SUB-05.um.gwdg.de (10.108.142.70)
X-Spam-Level: -
X-Virus-Scanned: (clean) by clamav

Hi Luis,

thanks for the feedback and pointer to the powerpc implementation.

Regarding bpf_jit_bypass_spec_v1/v4(): currently this is per-architecture.
What we need is per-processor granularity, so we can disable mitigations
on in-order cores and keep them enabled on vulnerable out-of-order processors.

Regarding fence.i being an extension: all RISC-V processors supported by the
kernel that are vulnerable to these attacks support this instruction. Also,
if a dedicated speculation barrier becomes available in the future, it would
be easy to switch to that.

Thanks,
Lukas

