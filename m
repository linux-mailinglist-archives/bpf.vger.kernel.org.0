Return-Path: <bpf+bounces-59320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C62DAC82C2
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 21:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6717B1A0F
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFC23185C;
	Thu, 29 May 2025 19:32:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105143147;
	Thu, 29 May 2025 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748547122; cv=none; b=hWO3xzA1PR0ze+S9/u5IPVHShMK/MQ8HiJf7pCayK/Afxdd9fEU1CzGaHhYKPj7b9ox2ALSfauCrSUZMhU9S/+c8RnoYLjnDBw3fB/BRSvsI+0vxDhpXMm+pag+0aFzAEV/Ao0EAIGXoaooFYLfgKbpi1rQpZK+r0ALsB0UQXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748547122; c=relaxed/simple;
	bh=l342JoDKUWtfju3StaCK8Ywx3sf3YDxLK3WRzN9tELk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJlNK/n2QhW0SoNxhwiSBO4qzVZ5s3aIpKNoNtyD4I9FwtduvvGmyFAcBmQZeobdkUDscVNKARycjqLUbTTqI7vrNIuEDo0sOtz7u8UdRoMrc+P+LcfC0ZCRFktIaIQYMyx9yxJU0Xgv+2E6xwqaXGRFMvO20kwWBnrSvK1JnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 676B22009D09;
	Thu, 29 May 2025 21:31:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 38F2E1B829A; Thu, 29 May 2025 21:31:49 +0200 (CEST)
Date: Thu, 29 May 2025 21:31:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, jarkko@kernel.org,
	zeffron@riotgames.com, xiyou.wangcong@gmail.com,
	kysrinivasan@gmail.com, code@tyhicks.com,
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
	David Howells <dhowells@redhat.com>,
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
Message-ID: <aDi2JWk0jtbUpMhD@wunner.de>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <20250528215037.2081066-2-bboscaccy@linux.microsoft.com>
 <aDgy1Wqn7WIFNXvb@wunner.de>
 <87msave8kk.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msave8kk.fsf@microsoft.com>

On Thu, May 29, 2025 at 08:32:43AM -0700, Blaise Boscaccy wrote:
> Lukas Wunner <lukas@wunner.de> writes:
> > Constraining oneself to sha256 doesn't seem future-proof.
> 
> Definitely not a bad idea, curious, how would you envision that looking
> from an UAPI perspective?

If possible, extend the anonymous struct used by BPF_PROG_LOAD command
with an additional parameter to select the hash algorithm.

Alternatively, create a new command to set the hash algorithm for
subsequent BPF_PROG_LOAD commands.

Use enum hash_algo in include/uapi/linux/hash_info.h to encode the
selected algorithm.  You don't need to support all of these
(some of them are deprecated), but at least the sha3 and possibly
sha2 family is a good idea.

Note that CNSA 2.0 has raised the minimum approved hash size to
384 bits both for sha2 and sha3 in light of PQC:

https://www.fortanix.com/blog/which-post-quantum-cryptography-pqc-algorithm-should-i-use

https://media.defense.gov/2022/Sep/07/2003071836/-1/-1/0/CSI_CNSA_2.0_FAQ_.PDF

Granted, there's no mainline support for PQC signature algorithms yet,
but there's at least one out-of-tree implementation, it's only a question
of when not if something like this is submitted for mainline:

https://github.com/smuellerDD/leancrypto

Thanks,

Lukas

