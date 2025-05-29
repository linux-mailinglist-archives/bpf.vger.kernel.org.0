Return-Path: <bpf+bounces-59280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE9AC7BA6
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 12:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EEB4E3E92
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C016F28DB73;
	Thu, 29 May 2025 10:11:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F3A55;
	Thu, 29 May 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748513498; cv=none; b=Eas8Vj+WtBkJL6Nzykv3g5Ytegg6zGoLCBoMrMCDTn43zhYu0A1w/lwekve8XBajH2+6srHBAB+thY3GedQT6A+V1oR+Ux6qgVha28r2gidMh0b1TwiucInskpMnIvwli9ynkdS/ydw9qj1eMYn1IZ511tsYdL9Rr+AglM4Mgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748513498; c=relaxed/simple;
	bh=n1ZSZRRIrTneaJFYpJvpb9/RGVcZ0hY1kPCFwceGKRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqcdyyvr6O1qaScbqi4I/k7vzvGsJhxJCPRypF3S5TfLPkGZcM1kSZe+ualpBiaNS4AfBA6/ZSW0X+ebCyl1LSQ4A4+5d/8ZPindSEwCRuX6V6sy+69ry37+MN8xKT0EX1jMkl9B1Z7nC6UsdqJf3ptXT7F8sraHJa7bXnnbQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 69A492C051D4;
	Thu, 29 May 2025 12:11:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4D594244B9E; Thu, 29 May 2025 12:11:33 +0200 (CEST)
Date: Thu, 29 May 2025 12:11:33 +0200
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
Message-ID: <aDgy1Wqn7WIFNXvb@wunner.de>
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
> +	if (!attr->signature_maps_size) {
> +		sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_insn), (u8 *)&hash);
> +		err = verify_pkcs7_signature(hash, sizeof(hash), signature, attr->signature_size,
> +				     VERIFY_USE_SECONDARY_KEYRING,
> +				     VERIFYING_EBPF_SIGNATURE,
> +				     NULL, NULL);

Has this ever been tested?

It looks like it will always return -EINVAL because:

  verify_pkcs7_signature()
    verify_pkcs7_message_sig()
      pkcs7_verify()

... pkcs7_verify() contains a switch statement which you're not
amending with a "case VERIFYING_EBPF_SIGNATURE" but which returns
-EINVAL in the "default" case.

Aside from that, you may want to consider introducing a new ".ebpf"
keyring to allow adding trusted keys specifically for eBPF verification
without having to rely on the system keyring.

Constraining oneself to sha256 doesn't seem future-proof.

Some minor style issues in the commit message caught my eye:

> This introduces signature verification for eBPF programs inside of the
> bpf subsystem. Two signature validation schemes are included, one that

Use imperative mood, avoid repetitive "This ...", e.g.
"Introduce signature verification of eBPF programs..."

> The signature check is performed before the call to
> security_bpf_prog_load. This allows the LSM subsystem to be clued into
> the result of the signature check, whilst granting knowledge of the
> method and apparatus which was employed.

"Perform the signature check before calling security_bpf_prog_load()
to allow..."

Thanks,

Lukas

