Return-Path: <bpf+bounces-77146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C8CCF9E9
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 12:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A36EA301596F
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82B318146;
	Fri, 19 Dec 2025 11:41:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C82D73BD;
	Fri, 19 Dec 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144508; cv=none; b=skWaNl5ssWNrCOOOuIEGcItO6GNH/DGH/YdOimP7SeG32vyiwBHMP4PWF6UcIctNgDnexyFETf5sxxA0qGcI4JSNy72bGTp+ookKZ7tyBuiMl4VBa67DKaHF82jC1vBQLWJsBxXH5siU3++orpUWrdU24vymLd6CtywCpgwIVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144508; c=relaxed/simple;
	bh=x0W6EBDjHgwyMt4d65/PXQGDvq+nrVv+WCtHzooRlhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t6jb7L+BJO/yV8/1MyHqH99gAnS4/IntVmLc8jPjfGoxLGjD2CLFNWeWJ4xLpROsuCrXHJ00fO6TQl8vBmnLUXbyqFN+u9yBXG2imqq004CHmgPeduCajj+yYYYUXQDo1jqRQWrcSGnP0w5wkySMVamNOLxWaWX/iJgbstsawws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dXlxL19g8z1sFNW;
	Fri, 19 Dec 2025 12:41:42 +0100 (CET)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dXlxH1dJCz1sFNH;
	Fri, 19 Dec 2025 12:41:39 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4dXlxG5Zj7z1qqlS;
	Fri, 19 Dec 2025 12:41:38 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id yUPy3BUYOinu; Fri, 19 Dec 2025 12:41:28 +0100 (CET)
X-Auth-Info: NdOAqSKqpUa2L5w9K1GQfsmLFAunuGbI2egYxigMFH/QHOan6ylJbRSfO4blGbe+
Received: from igel.home (aftr-82-135-83-185.dynamic.mnet-online.de [82.135.83.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 19 Dec 2025 12:41:27 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id AA7802C199C; Fri, 19 Dec 2025 12:41:27 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>,  ast@kernel.org,
  rostedt@goodmis.org,  daniel@iogearbox.net,  john.fastabend@gmail.com,
  andrii@kernel.org,  martin.lau@linux.dev,  eddyz87@gmail.com,
  song@kernel.org,  yonghong.song@linux.dev,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,
  mhiramat@kernel.org,  mark.rutland@arm.com,
  mathieu.desnoyers@efficios.com,  jiang.biao@linux.dev,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org
Subject: Re: [PATCH bpf-next v3 3/6] bpf: fix the usage of
 BPF_TRAMP_F_SKIP_FRAME
In-Reply-To: <3730454.R56niFO833@7940hx> (Menglong Dong's message of "Fri, 19
	Dec 2025 10:22:01 +0800")
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
	<20251118123639.688444-4-dongml2@chinatelecom.cn>
	<874ipnkfvt.fsf@igel.home> <3730454.R56niFO833@7940hx>
Date: Fri, 19 Dec 2025 12:41:27 +0100
Message-ID: <875xa2g0m0.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Dez 19 2025, Menglong Dong wrote:

> BPF_TRAMP_F_ORIG_STACK

How can that ever be set?

	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
		return -ENOTSUPP;

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

