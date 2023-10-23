Return-Path: <bpf+bounces-13009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDAA7D3946
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B39B20E5C
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A471B29F;
	Mon, 23 Oct 2023 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhG63FUi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC41B292;
	Mon, 23 Oct 2023 14:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E094C433C8;
	Mon, 23 Oct 2023 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698071199;
	bh=p2y3WlKWMWCwJ0nsz6Tduo3jHWpXvj9LTx0Tabn/ZsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HhG63FUiPW9BxI0n2o5zfOSEO7M0eLWRC17BsSejPKyZ4foYQmYHfWlfmF0qDDg3m
	 gpmzHedZuK++tf0IVhwIxVOnEzDLhzobWtantOPgEiqP+VdkIb/8OtInYci2dzX5Tk
	 hahEydOJ/3BKGy+rN1Y9iA6ClA6GOxhSB8PGCTqUKXaM7QaZh2GEol/Cnb1DmvTWhM
	 E//sgpg8BkBhGDf8WPhfI923s9dSnL6pb1IoaVp5gV9/vyQlOhtR8sDdzT8sMe9hij
	 1IFhdzgJyJxYEESVVAvx9Mh+pRuGidfyHyG7R13nIt2O9wAbZkPskArLQQR1GjvG8S
	 nzwlySFX7EVEA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4DFF6EB2CB2; Mon, 23 Oct 2023 16:26:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
 sdf@google.com, Daniel Borkmann <daniel@iogearbox.net>, Quentin Monnet
 <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next v2 4/7] bpftool: Implement link show support
 for netkit
In-Reply-To: <20231019204919.4203-5-daniel@iogearbox.net>
References: <20231019204919.4203-1-daniel@iogearbox.net>
 <20231019204919.4203-5-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 23 Oct 2023 16:26:37 +0200
Message-ID: <87lebtqusi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> Add support to dump netkit link information to bpftool in similar way as
> we have for XDP. The netkit link info only exposes the ifindex.
>
> Below shows an example link dump output, and a cgroup link is included for
> comparison, too:
>
>   # bpftool link
>   [...]
>   10: cgroup  prog 2466
>         cgroup_id 1  attach_type cgroup_inet6_post_bind
>   [...]
>   8: netkit  prog 35
>         ifindex nk1(18)
>   [...]

Couldn't we make this show whether the program is attached as
primary/peer as well? Seems like that would be useful (like in the
cgroup output above)?

-Toke

