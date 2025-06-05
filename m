Return-Path: <bpf+bounces-59754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E7ACF172
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF06C3A2A33
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51BE2741CE;
	Thu,  5 Jun 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgCfynbo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774E1DD9AD;
	Thu,  5 Jun 2025 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132094; cv=none; b=twqPFNi1VzeSQ/1cYIkhHPvmEkMROhg8S4U/FpOLlSwCQ71TGGac5Fa2keRHtY3Q2zNJoyKb/c5RCQ9dL1t7RSU3RL1oDXvi3imILefjSQeX75C24mv7+Ka4POSya1tPvRYEJ3ug2/DhOTvWvMU2ccxCHxgLzbvoAnwJNx4HYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132094; c=relaxed/simple;
	bh=1ed5iLGRXVaQHfOf0Zj7ng95yJ0hlYFMtMNrRHDgmIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uxiwu+4D+UQ0YQ9/sy5LGg8t8ZcvYGMGJZdLN9C8GVbJoPVXlq4jM31L05g+vbvr+e64W4hWTJE1j9UKqNvtU5r6VRv+ivNcH1TfEvKu14mEfun1Vdqyn73KD3cy6CfYp02g61wtuNqT4+A0Fi7XuZ7Fh2qjf03nn0QpxX3MVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgCfynbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8E3C4CEE7;
	Thu,  5 Jun 2025 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749132093;
	bh=1ed5iLGRXVaQHfOf0Zj7ng95yJ0hlYFMtMNrRHDgmIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgCfynborg8AMQONHWEyRuSiwZ8I0303C21MbVqqZpd2NPMpcTD4t5NZu3PWQ4zlv
	 NWL2taKpGX+cD1b5UkNtlt5TzQ3Y/itq77XBJFJ7QOIbW9U3HhkDhBpkWAax4DeFh4
	 uvgqUeRbWgTePwBd26oP4YuW69Xdcl5IBszjDMeGHltova7N7wl24dIuaY3MXpLFO/
	 uDim7gLg8U+8pngU3HVYzH88kv3FlfU0hBOj52j5T86yNQxHthWw4PDi6GOIP1Z6GK
	 d4rrWLWbrv58y8+cK8Jq4AF14lUCRAyN0j+6/F2nqKUwPJfwSfKc0iKICOZfJ8UpAZ
	 WOMMUfbfhJ6wQ==
Date: Thu, 5 Jun 2025 07:01:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com,
 william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
Message-ID: <20250605070131.53d870f6@kernel.org>
In-Reply-To: <CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
References: <20250604210604.257036-1-kuba@kernel.org>
	<CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
	<20250605062234.1df7e74a@kernel.org>
	<CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Jun 2025 15:50:31 +0200 Maciej =C5=BBenczykowski wrote:
> On Thu, Jun 5, 2025 at 3:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > > I wonder if this shouldn't drop dst even when doing ipv4->ipv4 or
> > > ipv6->ipv6 -- it's encapping, presumably old dst is irrelevant... =20
> >
> > I keep going back and forth on this. You definitely have a point,
> > but I feel like there are levels to how BPF prog can make the dst
> > irrelevant:
> >  - change proto
> >  - encap
> >  - adjust room but not set any encap flag
> >  - overwrite the addrs without calling any helpers
> > First case we have to cover for safety, last we can't possibly cover.
> > So the question is whether we should draw the line somewhere in
> > the middle, or leave this patch as is and if the actual use case arrives
> > - let BPF call skb_dst_drop() as a kfunc. Right now I'm leaning towards
> > the latter.
> >
> > Does that make sense? Does anyone else have an opinion? =20
>=20
> It does make a fair bit of sense.
> Question: does calling it as a kfunc require kernel BTF?
> Specifically some ram limited devices want to disable CONFIG_DEBUG_INFO_B=
TF...
> I know normal bpf helpers don't need that...
> I guess you could always convert ipv4 -> ipv6 -> ipv4 ;-)

Not sure how BPF folks feel about that, but technically we could
also add a flag to bpf_skb_adjust_room() or bpf_skb_change_proto().

