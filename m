Return-Path: <bpf+bounces-64377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0477B1202D
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 16:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB2F7AD48C
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9263020110B;
	Fri, 25 Jul 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQdiR7R6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00C1C6FE1;
	Fri, 25 Jul 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454056; cv=none; b=sC8hp6HPD1Ky9Pw4B26BMlR3jPDHNxXz3cqJAZXqliNuoNFVCEb2fXAEIhmAe8p/7Jpxv5RyQnUa6XKW1PyW2/1BjnGyNHQF/uz5lnJMMnmrQmcLywk7ZbsyQcTtlwmEtNtshxcR3E3e03x7wOVvewwp6DRP7gbk/tN4+1xN5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454056; c=relaxed/simple;
	bh=vMHhOgqBPd2TX5wCHFG0OnlSnpKuD/lBiR+ayVD01QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghL86SOzW+rsJuFlbqxkijWsFl70qBatjUmX89LkOLu8+lMeTd151RyQYfp0UKb08Ntz7K9cje4wPB2cbJ5M9voEx2SxwlVP8QPxDbPjSE7siVZxt04ZeDtljEs6fO4MxgfRrRh1AWn1hi0HMRAykrj52QK5b4mDUxz6QtluDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQdiR7R6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4CDC4CEE7;
	Fri, 25 Jul 2025 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753454055;
	bh=vMHhOgqBPd2TX5wCHFG0OnlSnpKuD/lBiR+ayVD01QQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cQdiR7R6SIyiDfhBrjO0sUZvPs7RV0NITwQoemxP5Lqb4wn7yMzDOQND8TMvcTEf7
	 9z39SL6Em7AWEwlJucngVA09I+QL6Vf4OOtY2cJxxLbJUxgMA7rArwVz00r6hAx3rq
	 n97WZyz+wMf2vcjyPB6YJ+95d920l6Mkwm6UgjZer+AHyNhOYFO06FkfPoO72nWGNs
	 mGSU/tQgeK7aJr5TvJbMd0yx3nOFKDnsXuukrM80qBYhf5dSXEKRKrlYNBqVDprL8W
	 kf+2He2tJ/KZYbunf9lJZGk8GqqJxJUTDRiJNb5oCmm4XQABs018PO/gL20COehWm6
	 0AFmsJiBmxsAg==
Date: Fri, 25 Jul 2025 07:34:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNl?=
 =?UTF-8?B?bg==?= <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org, Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
Message-ID: <20250725073414.649ec615@kernel.org>
In-Reply-To: <87frekwqq0.fsf@cloudflare.com>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	<20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
	<20250723173038.45cbaf01@kernel.org>
	<87tt31x0sb.fsf@cloudflare.com>
	<87frekwqq0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Jul 2025 11:43:19 +0200 Jakub Sitnicki wrote:
> > Taking about the next step, once skb metadata is preserved past the TC
> > hook - here my impression from Netdev was that the least suprising thing
> > to do will be to copy-on-clone or copy-on-write (if we can pull it off)=
. =20
>=20
> Now that Martin has enlightened me [1] how things work today for skb
> payload dynptr's, I will first try to follow the same approach, that is:
>=20
> Make a copy of skb metadata before the BPF program runs, if the program
> may write to the metadata.

=F0=9F=91=8D=EF=B8=8F

On the pskb_expand_head() behavior we should probably ask Daniel?
I suspect it's just to "fail closed". But as you said we can follow
up on that later, not a blocker in practice on Rx.

