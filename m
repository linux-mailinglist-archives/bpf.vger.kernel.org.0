Return-Path: <bpf+bounces-44989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B7E9CF592
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 21:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E32286317
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EC81D63FC;
	Fri, 15 Nov 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TOTFCvd1"
X-Original-To: bpf@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F49F1DA23
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701785; cv=none; b=S6unmuI75CIJWmeNtHI/0MwUqn9Yfr2KqWJdUQ4cXABRroySFhV8DFBq/0DY4qAE8qZy3NAssuJd6+DTyqpyermu3gxjlZMOv7Px3GaPx5Lh16yNgHfqqqiOqu+LwkkVIOFnVXAEPb3cha8jYMmK1RMM23U5PXVtMkfj/GdJaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701785; c=relaxed/simple;
	bh=DKfTA6II8cbRCnMAs2X/IOwIOAkJ6eyltZAGZayf0rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFXW9D7HqK9X/qWiB1ofsjCDyDKpV+rar1eRSnC8kORLOpK5OQ7X4qYVus4NEHCuCXdpHABkHbacTpacUy1pT2ZCO/ZERW80h8rYeOKFrhDOOC/eDXuX8PMPGEJ0B/3ARcU1SSXrIvgGYfZg0Af7WKu20Y9g5D2nDTDyEqzx62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TOTFCvd1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EF39540E0263;
	Fri, 15 Nov 2024 20:16:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dyj76k8Q-koL; Fri, 15 Nov 2024 20:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731701774; bh=HE0Pv5x7MIkmn2h9knLUcC7mPFR1lKzYw9O+YCbio4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOTFCvd1Oas4D7h3jBi3I+mzkbCc5e0rUgbZ/4j3c0qqZ+L0EfgJL5tXguaxIpDxX
	 ao5FSsVCa7qjaydGWUr7b98mFSHI+CNrb7FK1B3SXrLvuDtClWbaTyZxDUo/c64hG8
	 PgQ/dEmt+ghMzfEJukW+yGzfMfKIRilHPGh5LQp7zqQ3fRpw5jRv4h1gDgdZfPnK/E
	 jx1HTr4PHtB3UUinbmWaCAy4zE2Nv0kGxF6vyPuUFP6oeTvxfTLQlo8nAX8n8kfP1q
	 4nbKYtHZVT7TfZWbt1Pkeo/Xd7DDHU6XV6vtqyUpt3buNGegMqgJRtsVZU8FAL/STX
	 JxReFHQO7z2z9fAVaCd7LLryIDRjr37Ehf8XE34Z0hLKQqIolAN4HJPsisdzELLDE0
	 +NMY6WWA42KbRD3nt7VhEeKn7nEiE7/KmLPYMtnfn78hID7FIVKifrkH2QLLtVIckP
	 vfGAqCvILabbdnz6Cz0H5VV41mpTQCp2zO+FSaE+V4SLUwK6RZ/TpSGMglFGRYIcNz
	 H3bE5ZdWjM0ebN9EPhmPl+K33uUSTwRyyySo7iflGTtQ+vrQAarhVUlI4lQxQuPttU
	 rBq17MXuOdMB+V0HAz5h+zr9gjofpynGb+iGLszMgv4KB+P57O+skDEO0GQ3IaAF5a
	 5PNKSvpnk22wlmhdDX7Ao+1Q=
Received: from zn.tnic (p200300ea9736a1b1329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a1b1:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28BE440E0220;
	Fri, 15 Nov 2024 20:16:03 +0000 (UTC)
Date: Fri, 15 Nov 2024 21:15:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: add cpu cycles kfuncss
Message-ID: <20241115201554.GBZzer-s-_-k6aLlJ9@fat_crate.local>
References: <20241115194841.2108634-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115194841.2108634-1-vadfed@meta.com>

On Fri, Nov 15, 2024 at 11:48:37AM -0800, Vadim Fedorenko wrote:
>  arch/x86/net/bpf_jit_comp.c                   |  60 ++++++++++
>  arch/x86/net/bpf_jit_comp32.c                 |  33 ++++++
>  include/linux/bpf.h                           |   6 +
>  include/linux/filter.h                        |   1 +
>  kernel/bpf/core.c                             |  11 ++
>  kernel/bpf/helpers.c                          |  32 ++++++
>  kernel/bpf/verifier.c                         |  41 ++++++-
>  .../bpf/prog_tests/test_cpu_cycles.c          |  35 ++++++
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/test_cpu_cycles.c     |  25 +++++
>  .../selftests/bpf/progs/verifier_cpu_cycles.c | 104 ++++++++++++++++++
>  11 files changed, 344 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_cpu_cycles.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c

For your whole set:

s/boot_cpu_has/cpu_feature_enabled/g

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

