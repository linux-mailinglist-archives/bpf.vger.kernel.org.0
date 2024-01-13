Return-Path: <bpf+bounces-19502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D7682C8CD
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 02:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A62E1C21A93
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 01:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E746171DD;
	Sat, 13 Jan 2024 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbH4SvXV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C51A594;
	Sat, 13 Jan 2024 01:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7D7C433C7;
	Sat, 13 Jan 2024 01:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705109612;
	bh=PHzx3gJ6hnCv3VfcEhNzHYMyKUNAcxT04KDHTrh9tAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cbH4SvXVjyY0LR+FiwUrFbH4h6iqSSMwz5QQJ9LYT7KxjHyJcqnG0MD4Oy5y127I7
	 VHTWzDnCwihFwGfw6Gfzoyyp2s334edjiQavmppF7HSGv3NUvkiFQt/xBWqW2uGIim
	 YFGuqmz16qH8q8bthOgFKn5ywYQbrr4shwbyZnF1ZoglLN2PK4glVBXrR3S4V3pBkW
	 RdnNlCPLjpBCmEQ393uThtjVypEDb8CLkASrZrpbSFPt5x1SOcAPVjTzBhpz4fBqC9
	 haYz95cdA/LunkoWpbGHxPSfF5KzR9s0Uz9I7XMWS6L2NqLAs/DlNCfJr9BvY0FHOE
	 k2hvBCVsA0cSQ==
Date: Fri, 12 Jan 2024 17:33:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, cake@lists.bufferbloat.net, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Stephen Hemminger <stephen@networkplumber.org>,
 Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, Martin
 Wilck <mwilck@suse.com>
Subject: Re: [PATCH v3 0/4] net/sched: Load modules via alias
Message-ID: <20240112173330.075e5969@kernel.org>
In-Reply-To: <20240112180646.13232-1-mkoutny@suse.com>
References: <20240112180646.13232-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jan 2024 19:06:42 +0100 Michal Koutn=C3=BD wrote:
> These modules may be loaded lazily without user's awareness and
> control. Add respective aliases to modules and request them under these
> aliases so that modprobe's blacklisting mechanism (through aliases)
> works for them. (The same pattern exists e.g. for filesystem
> modules.)

## Form letter - net-next-closed

The merge window for v6.8 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after January 22nd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#de=
velopment-cycle
--=20
pw-bot: defer

