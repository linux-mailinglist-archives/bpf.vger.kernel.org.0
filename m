Return-Path: <bpf+bounces-70921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 797DCBDB0E1
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 21:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 462583567C3
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3182C0F70;
	Tue, 14 Oct 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT64Sr2v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE21F63F9;
	Tue, 14 Oct 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469966; cv=none; b=hDZEosLzhPSqlnYe2nkwJPLUza4JhI46MjtEGubUjAjHUXc8uyba+/mPNn0m9RzijGa7WE+TmiROP4fuK5VEndMuQmWZSkSx03wKU5lo9SxJuVHSFOi94U1pfwvxX2IZOIuibca8veLbTCNRCOonnkXrL3hBySKnmUlWzeE2lxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469966; c=relaxed/simple;
	bh=o+wwp6IjOSEDNpKADFKUpT3S4jbIVkhAPLG7zoNAIqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7KG0+Hj0jIW5FgPLgAm6RELCpXEWc1aBIAf1c+GDEtmUty9bgY0GN4qE97BZsnD9xYBt46znMQPCCatzrsYL/2hciLnWadFJ+PFUX0wAjSeuViqoR0gGZdKjzf28jT+oLyogOOVZBaDK6uI0wOq4VY5mxeP7Ms1Gq6YbxeJhuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT64Sr2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0737CC4CEE7;
	Tue, 14 Oct 2025 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760469963;
	bh=o+wwp6IjOSEDNpKADFKUpT3S4jbIVkhAPLG7zoNAIqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XT64Sr2vFmARywIxifSZhgSjBV70Jp/cQCdfLth0BrBiwBJkOl4X/AUthefUrRmr6
	 NGcZ39MRuFCV3lB6yyAkwYgZTZBj3RR1hKv3uFC5Vda+GNPK6TLTDgdoP82HNFv+ZD
	 3BnwWI/f2RPC9k5zJMqGpOqhB8g+RaTa4LkCtnfvEE0fj0WB6QNk382GVUudL2P/n6
	 KlKsxfs5IXdmDVV+Pta+bEbWC06SzC+IFTkfUFLnJLKZEJvFMflF/mMnB7FDnXPz2/
	 woCrQBPyVatqXz/IfagkwabVwX5aXEYuGvpFcsp8KdlmRZsWxVTfBDlg3H2h2OlHpW
	 VfM/t5DnSNjaA==
Date: Tue, 14 Oct 2025 12:26:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Joe
 Damato <jdamato@fastly.com>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] tools: ynl-gen: refactor render-max enum
 generation
Message-ID: <20251014122601.3ebcbf5a@kernel.org>
In-Reply-To: <5c944395-141c-415b-b29a-8f70cafaa24d@fiberby.net>
References: <20251013165005.83659-1-ast@fiberby.net>
	<20251013165005.83659-3-ast@fiberby.net>
	<20251013175826.6dbf6c78@kernel.org>
	<5c944395-141c-415b-b29a-8f70cafaa24d@fiberby.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 17:04:14 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> On 10/14/25 12:58 AM, Jakub Kicinski wrote:
> > On Mon, 13 Oct 2025 16:49:59 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wro=
te: =20
> >> +        suffix =3D yaml['type'] =3D=3D 'flags' and 'mask' or 'max' =20
> >=20
> > This construct looks highly non-pythonic to me =20
>=20
> I don't mind changing it to it's multi-line form, but this line might go
> away (see below).
>=20
> >> +        self.enum_max_name =3D f'{self.value_pfx}{suffix}' =20
> >=20
> > sometimes its max sometimes is mask, so we shouldn't call it max always=
 =20
>=20
> I'm fine with splitting them to render-max, enum-max-name, render-mask and
> enum-mask-name. I was just following along the current lines in the code,
> as started in commit 96a611b6b60c.

Ideally we'd find a general noun to describe both max and mask..
I don't have any great suggestions tho

