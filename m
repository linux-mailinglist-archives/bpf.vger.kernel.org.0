Return-Path: <bpf+bounces-79054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98010D24BED
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 14:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A70330B2103
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2E39E6DD;
	Thu, 15 Jan 2026 13:28:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailer.gwdg.de (mailer.gwdg.de [134.76.10.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BA618DB01
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483712; cv=none; b=DcOLbhBYmiG8QumXdqjcAczXVO0AL0diNnTgGmN+WLw3Hs6ZUIDeSHMfEn0iUUXj+e/PGJGSJNrBPi5DDeWBRJPvCbWRwu/dZot+Fnnm6zs9jO4WjHNx0YAIdtVJ7hi6uHsWsn4ZRnS3OjCxcBDakNhroFavqMHw80vwezMrn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483712; c=relaxed/simple;
	bh=HbHo0I8lv/Mti2wo+z53uNWSoWXplnKDPJaQi7jteh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fF5su7uVwEv7lMHDp/EztE595B4S2m5IYc0lBkIRmhzChd/TPpanqzY39GczFG3H/y2Hpnm3YBc01S+VrP7QbklYglGZVKJY1X7RSgyyqZenXYih5CfPokX8iDsO8sBIhTxxExEzHycsYH3skx30zWgZoKG2NmkZJpKbwyqIu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; arc=none smtp.client-ip=134.76.10.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Received: from mbx19-sub-05.um.gwdg.de ([10.108.142.70] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(GWDG Mailer)
	(envelope-from <lukas.gerlach@cispa.de>)
	id 1vgNAY-000WhK-0w;
	Thu, 15 Jan 2026 14:13:46 +0100
Received: from Mac.lan (10.250.9.200) by MBX19-SUB-05.um.gwdg.de
 (10.108.142.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Thu, 15 Jan
 2026 14:13:45 +0100
From: Lukas Gerlach <lukas.gerlach@cispa.de>
To: <pjw@kernel.org>
CC: <ast@kernel.org>, <bjorn@kernel.org>, <bpf@vger.kernel.org>,
	<daniel.weber@cispa.de>, <daniel@iogearbox.net>, <ganboing@gmail.com>,
	<jo.vanbulck@kuleuven.be>, <linux-riscv@lists.infradead.org>,
	<luis.gerhorst@fau.de>, <lukas.gerlach@cispa.de>, <luke.r.nels@gmail.com>,
	<marton.bognar@kuleuven.be>, <michael.schwarz@cispa.de>,
	<palmer@dabbelt.com>, <tech-speculation-barriers@lists.riscv.org>,
	<xi.wang@gmail.com>
Subject: Re: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
Date: Thu, 15 Jan 2026 14:13:39 +0100
Message-ID: <20260115131339.16372-1-lukas.gerlach@cispa.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <65f1b958-e420-c517-9a60-86f9085de702@kernel.org>
References: <65f1b958-e420-c517-9a60-86f9085de702@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-05.um.gwdg.de (10.108.142.64) To
 MBX19-SUB-05.um.gwdg.de (10.108.142.70)
X-Spam-Level: -
X-Virus-Scanned: (clean) by clamav

Thanks for the discussion.

I agree with Paul that waiting for the TG to complete is not practical
given the timeline. There are vulnerable cores in silicon now.

On fence.i's effectiveness: Stefan and Ved are correct that it only
architecturally guarantees a retirement barrier. However, we tested
fence.i on C910/C920 and P550 and found it does prevent Spectre-PHT
attacks on these cores because they drain the pipeline.

On performance: on the cores we tested, fence.i flushes the instruction
cache, so the overhead is significant. The barrier should be configurable
per-microarchitecture. In-order cores like U74 and C906 are not vulnerable
and don't need it.

More broadly, getting selectable per-microarchitecture mitigations in
place for RISC-V now seems valuable. Implementations vary significantly
and will likely need different mitigation strategies going forward.

Lukas

