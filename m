Return-Path: <bpf+bounces-59644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C1ACE22E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054333A51AD
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1A41DF990;
	Wed,  4 Jun 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB8BIpHd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E1339A1;
	Wed,  4 Jun 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749054346; cv=none; b=iXZ+emyUKnEMAqqZbQu9P21cZtww+kf2LFTcw2zmWXfuVq8i9kHaa1i81PQYD6SGb+md+Rr4F5QyEiQSCinzB7uzlXYRVIsf/3mLGkxZAzlJ8zMXgV8Bc0L2VcIDn2BbwZggWEjsWG29S3b2eV7NWTSsfsLeSAX/hHUQRzKpjn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749054346; c=relaxed/simple;
	bh=ghWPhTJt8vtU/IFkZSAXQHMW5a8nxv+PINVZ/OZqkAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1zlC0TJKH8YvpgrXzSlBlvCiU7FgVDhi3cQoRye/Pv2G3CBF5sLYntkzNtARS3SxfpT2SHSOo1Tu3Nud5MNJkgtsXgHCcN1tIH0bPZ1yZuPfKC4zVBppR8HLwz/UKfIpsJul8yXALt4DPIyohWGYBD593ja68+pw2emRuwkD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB8BIpHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647F0C4CEE4;
	Wed,  4 Jun 2025 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749054345;
	bh=ghWPhTJt8vtU/IFkZSAXQHMW5a8nxv+PINVZ/OZqkAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RB8BIpHdGyIOP+ZMGEj9My7w1u3/zdQFKRAKSB2KnrlZyS46581SBgBip0r/ATuJN
	 tTsF6Kyb9q4XzqtCj+j1idCwZMCq68jfE2vqO87sry+de6j1PJFckCmkq7TChQIUPs
	 xRcJW58dWb25CW+Mt5Arqe/du2QfeIIL+rz6eVj08qgLadKtv3UxUKhFvEooAkUpZX
	 XCKqFwImpwE+4J0908tC/rO1LXfWB6m1NN/de91WtAn89yONW0nN/luRPQE0V5wL7e
	 0R3ATaLXYnEPGNF87cB7dzsNPK44LJLHsxeMKQGXPN8YlhOfMp+ldxUBQihgaMTk0j
	 VTcmlDR0cEKJw==
Date: Wed, 4 Jun 2025 19:25:42 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, zeffron@riotgames.com,
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, code@tyhicks.com,
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
	James.Bottomley@hansenpartnership.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Quentin Monnet <qmo@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	Jordan Rome <linux@jordanrome.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Matteo Croce <teknoraver@meta.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/3] bpf: Add bpf_check_signature
Message-ID: <aEBzhhqab75jE080@kernel.org>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <20250528215037.2081066-2-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528215037.2081066-2-bboscaccy@linux.microsoft.com>

On Wed, May 28, 2025 at 02:49:03PM -0700, Blaise Boscaccy wrote:
> This introduces signature verification for eBPF programs inside of the

s/This introduces signature verification/Introduce a signature verification ???/

I.e. Explain what sort of "thing" is "signature verification thing" ...

BR, Jarkko

