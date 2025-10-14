Return-Path: <bpf+bounces-70858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A967EBD6E70
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 02:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66AF402773
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 00:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8C22248B4;
	Tue, 14 Oct 2025 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFf+JeBi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D93194A6C;
	Tue, 14 Oct 2025 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760403509; cv=none; b=WGNaztAtnvKJdBhU9YJPwcjcxZ4adraqPFeNHDAq1Z4O1pHO2sWAWhWyK7pQlzJHgGCIQ30VHT8RKesqa+9orvtHas/aPaUv5J1e3p9FBZYtYfNzYwuli/W3E7BRaAzX5IgxnIDl9IjBe5HPnxDPMMykIMmVC4Zvk4U2Z58u//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760403509; c=relaxed/simple;
	bh=fR1GbH4jH+eHBEKl6QXivIFd/noo72P+BXJVX78dR70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSD7EX+Gog6BKnIYPoySI8/5Ivn815CEEl7Nmww/LeoAwDPRPljOu0qVRX1wpEteM3ito8lDFaBtUiVN936/dGcd7eo1fq/O67nsqM1n7zAhu3P4HRBl8eTnWfCUKAajgDxm0kWq+AzRYE4DxXaZoStfqk8iH4/WPdnyJ9D2GAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFf+JeBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53368C4CEE7;
	Tue, 14 Oct 2025 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760403508;
	bh=fR1GbH4jH+eHBEKl6QXivIFd/noo72P+BXJVX78dR70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mFf+JeBieDFBbka+0kxEoD2TrmFOXP1EMPqrOMQlAFDWz7uzHABwiqeMgJ6l7S20y
	 LZN5IAchz0o+8IqQ59AwSxoSxWjSXi8px19tD0TUvbkUL+WclQVxJGqYu7picMQZVK
	 zMWW2NVeGQLeUuaqsOXKSOsCy+ZJ/vcoXgQyTEVcbSCdrfo0aXKG8Kn2gziC5g/mn1
	 P7nBr54MbDWLQZjESLHaunbQM52PWBy0I+LENBRnLLlaaJro9pzmZUhWOP6EnzRozb
	 u2thQfAD60EESH8hz5wakOrJSvvroKrLSN+Hnu51UMZvPMGp7k/nx0x52nHqhSX5wo
	 /tzUROKiqX1Qw==
Date: Mon, 13 Oct 2025 17:58:26 -0700
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
Message-ID: <20251013175826.6dbf6c78@kernel.org>
In-Reply-To: <20251013165005.83659-3-ast@fiberby.net>
References: <20251013165005.83659-1-ast@fiberby.net>
	<20251013165005.83659-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2025 16:49:59 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> +        suffix =3D yaml['type'] =3D=3D 'flags' and 'mask' or 'max'

This construct looks highly non-pythonic to me

> +        self.enum_max_name =3D f'{self.value_pfx}{suffix}'

sometimes its max sometimes is mask, so we shouldn't call it max always

