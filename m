Return-Path: <bpf+bounces-70859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81322BD6E7C
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 03:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AD7D34F655
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 01:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCED22ACF3;
	Tue, 14 Oct 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3PK4HS/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177F2AD2C;
	Tue, 14 Oct 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760403598; cv=none; b=XUAUKKruWlABVc0ewl5jtvgIrCq7haE5LhduL5D//gZB5PPWXbVUJFDs06XMaPgezAYSbOVczlMmSrilrKEjj4TuCd6fl3s1c4f+nssVw8q5oBoWKJkLdCz5NZkbXdDzKVvaJHptj20vJABEPXOVx7BFpuEg0BVTCyiu2Swpuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760403598; c=relaxed/simple;
	bh=jyIGK6CqZ70vitj4rxxyNXFbD+WRSwokQAcb0XcUpYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOrdYnYEbO4v76L67vwC7+i+2KRYDdZ/z94/XsNSYzMpIzCwG/dymf1g3COKZlALeOaimxt59TcEIPmQ+IAhu+19t6i5j/IUkLm4VJu1O6P/qPCLUoVHZg0aSVP+8NMMFjwKS1AJo5bUINkzd1mz41XaGDpAN2WwcVREQRwfZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3PK4HS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BA8C4CEE7;
	Tue, 14 Oct 2025 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760403598;
	bh=jyIGK6CqZ70vitj4rxxyNXFbD+WRSwokQAcb0XcUpYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a3PK4HS/B++6pWmOFHjg5/TLu5KnclqML9r+rOrlEuVVPPLYY0HK1WhSCQrZ7TCrl
	 F01l5BIKXKozpuaMzOKylsyMOEyUlIvhXuLR8CIls1ybUCjhETYBk/X5TvfJ8mxoYV
	 D0i8kauhEN77I0mcBQKdSJAEtqP9PWd10JKwHPGqgpJSzxdBip6EUGdpeYAGbYefJx
	 yICC0q2JnfPLHCgsifhNdOpp9EnqJiw2PZosc+3Qy3Y7Lb+DWQQo4Ph7oO4B8mvRPk
	 RMM207VuJGLbBfLKxHGc+V9u3G7+lRfB0I/hByEkcynnPlA6SFIg4cTz/c8qYLl2Pd
	 PxnjWKZXa9jVg==
Date: Mon, 13 Oct 2025 17:59:56 -0700
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
Subject: Re: [PATCH net-next 3/6] tools: ynl-gen: use uapi mask definition
 in NLA_POLICY_MASK
Message-ID: <20251013175956.7a2fcf6d@kernel.org>
In-Reply-To: <20251013165005.83659-4-ast@fiberby.net>
References: <20251013165005.83659-1-ast@fiberby.net>
	<20251013165005.83659-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2025 16:50:00 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Currently when generating policies using NLA_POLICY_MASK(), then
> we emit a pre-computed decimal mask.
>=20
> When render-max is set, then we can re-use the mask definition,
> that has been generated in the uapi header.

This will encourage people to render masks in uAPI which just pollutes
the uAPI files.


