Return-Path: <bpf+bounces-78536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5932D12181
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48EA7301FD20
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E57F352FA5;
	Mon, 12 Jan 2026 10:58:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4A3559C6;
	Mon, 12 Jan 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215511; cv=none; b=C5ez9nfmsozceocn1hhCg2i1G6iLsxOfdhSLUtNuo0FepDjjdlwljLurrmXLcIRs38uJjgXgNDqckuuHzUWtBCgJ8plOhUYCR2T2/EsIKM3Bf6O4ngT0FecOchiG1xE3rg0B2m7EjOVeTLvpHJnxbEATOCSeRRgOtcC3b8btK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215511; c=relaxed/simple;
	bh=bW5RpmxuKPFfjs2iXKDUMFTP0SRtJ9fwSlkkNCrcwGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9eFEAskEtvnY9vv1+7vTcXiIzJCbJ04yFXRRLv902SWhExTKR+N0jeQVbWnLcVOIECegdh/UqHqcTKeNHZHUS/lSvzz6AwQErsxhjeTJngO+Qq9lUyIHMaeckiV7cJI7ywzHPM6XkM2nbjW2g/QL9ORlgdGQAc+vQziCkCjBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dqTc73xfXz1sG8X;
	Mon, 12 Jan 2026 11:47:51 +0100 (CET)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dqTc50Kz7z1sG8K;
	Mon, 12 Jan 2026 11:47:49 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4dqTc450Rtz1qqlW;
	Mon, 12 Jan 2026 11:47:48 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 5xyWnyBHaP_3; Mon, 12 Jan 2026 11:47:47 +0100 (CET)
X-Auth-Info: SSvjvNtRh5vfqOJuaTWqGcpcynIQ3r1wcZPSLPTfB+jtBxxbGYpGhF5kFG0qbYIO
Received: from igel.home (aftr-82-135-83-110.dynamic.mnet-online.de [82.135.83.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon, 12 Jan 2026 11:47:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 588F32C21A6; Mon, 12 Jan 2026 11:47:47 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org,  daniel@iogearbox.net,  andrii@kernel.org,
  martin.lau@linux.dev,  eddyz87@gmail.com,  song@kernel.org,
  yonghong.song@linux.dev,  john.fastabend@gmail.com,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,
  bjorn@kernel.org,  pulehui@huawei.com,  puranjay@kernel.org,
  pjw@kernel.org,  palmer@dabbelt.com,  aou@eecs.berkeley.edu,
  alex@ghiti.fr,  bpf@vger.kernel.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2] riscv, bpf: fix incorrect usage of
 BPF_TRAMP_F_ORIG_STACK
In-Reply-To: <20251219142948.204312-1-dongml2@chinatelecom.cn> (Menglong
	Dong's message of "Fri, 19 Dec 2025 22:29:48 +0800")
References: <20251219142948.204312-1-dongml2@chinatelecom.cn>
Date: Mon, 12 Jan 2026 11:47:47 +0100
Message-ID: <87zf6jayzw.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

It's rc5 and this is still not merged.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

