Return-Path: <bpf+bounces-77936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C562CF78DD
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 10:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32C5B301B589
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE07B3195E0;
	Tue,  6 Jan 2026 09:36:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailer.gwdg.de (mailer.gwdg.de [134.76.10.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147A3148B2
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692213; cv=none; b=qmwI6AgcZC/FTMAnd1y6LCP5buUDFbGh8cbwSBuJZsHmM7C94+1ZyyE9hyJAbS4vDElSEQToGD1Smpvxxf+WJgHIV/v5pEsY7aGfEy6xLNoR97eQP1sVmlF4JETP5zvnBZ7Q2VD/O8PsMWYP44lvzJ7D+6uZDI2AH3orsNciOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692213; c=relaxed/simple;
	bh=hA+cCFbLsftHFm1HlnpzGXxDAQfZy8ZvVwtCDqrKztk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpLymZenKheaJw9nigdgVnunpjWUP1XqG/6udbcAdxBri8wYYFKbxQafmuW5U7s3FRmbTHcovk+lWc3kGwzQohDNjmQuBPz9mtePVHnr+GPiJXiHKTCFxlEqEz2vgmIfNE46J8PWkiTWUgRwJ5YsTQKtTwEAngSt3BLqI6NMvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; arc=none smtp.client-ip=134.76.10.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Received: from mbx19-sub-05.um.gwdg.de ([10.108.142.70] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(GWDG Mailer)
	(envelope-from <lukas.gerlach@cispa.de>)
	id 1vd2fp-000UCM-1H;
	Tue, 06 Jan 2026 09:44:17 +0100
Received: from Mac (10.250.9.200) by MBX19-SUB-05.um.gwdg.de (10.108.142.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Tue, 6 Jan
 2026 09:44:16 +0100
From: Lukas Gerlach <lukas.gerlach@cispa.de>
To: <pjw@kernel.org>
CC: <ast@kernel.org>, <bjorn@kernel.org>, <bpf@vger.kernel.org>,
	<daniel.weber@cispa.de>, <daniel@iogearbox.net>, <jo.vanbulck@kuleuven.be>,
	<linux-riscv@lists.infradead.org>, <luis.gerhorst@fau.de>,
	<lukas.gerlach@cispa.de>, <luke.r.nels@gmail.com>,
	<marton.bognar@kuleuven.be>, <michael.schwarz@cispa.de>,
	<palmer@dabbelt.com>, <xi.wang@gmail.com>
Subject: Re: [PATCH] riscv, bpf: add a speculation barrier for BPF_NOSPEC
Date: Tue, 6 Jan 2026 09:44:10 +0100
Message-ID: <20260106084410.94496-1-lukas.gerlach@cispa.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <83981ed7-9d36-a47a-cf73-9010fceba5f1@kernel.org>
References: <83981ed7-9d36-a47a-cf73-9010fceba5f1@kernel.org>
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

Hi Paul,

thanks for the feedback.

I have not benchmarked fence.i in the eBPF context specifically, but
from my other work on Spectre mitigations on RISC-V I can confirm that
fence.i flushes the instruction cache on all cores I have tested, both
in-order and out-of-order, so there is a performance impact.

I agree that making this conditional similar to ARM64's proton-pack.c
is the right approach. Getting this infrastructure in place is a good
idea regardless, as the RISC-V hardware landscape is very diverse, and
we will likely need conditional mitigation support for other Spectre
defenses as well.

Thanks,
Lukas

