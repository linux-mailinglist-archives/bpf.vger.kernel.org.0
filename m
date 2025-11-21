Return-Path: <bpf+bounces-75237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7781BC7A3FC
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 15:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 280FB2E3B2
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590734EF00;
	Fri, 21 Nov 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5r98A9n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397231196D;
	Fri, 21 Nov 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736215; cv=none; b=rtccP4BMXcf2EGJEX3wy0VApSDub0t2jXaFMIxlF9UCB8q48OrAqIOj/IJl7n/lK/IBW1dJsc+YvdkyNQiIMrpRi4LlFWeFsGH7KEk2nlEYKj5m1J+LK586Ymd1I3Tuq7KImG+427+MdMJ9ldevu/GOWoXLVwLrQAL2FOKb2rRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736215; c=relaxed/simple;
	bh=YhcX8VhMtAVt8k5k8wYMLk4jqVlIEYqDl5rIiTVOg6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdCcGOhd93tEH9/TgxWc/OajCToAJYxr4vrYEfiNwlg3AOcigsPN8rBmUmResum8HoZMlXq7c1jvMp3NCczx9Zk6h3NVF4VYFoHbehlQ+qXIO011V+8jcH4aRuWsiBscQqu/Q3WhWMgChFqGbxy+VLUq+92mAuy1y59qnC+kNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5r98A9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55589C4CEF1;
	Fri, 21 Nov 2025 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763736214;
	bh=YhcX8VhMtAVt8k5k8wYMLk4jqVlIEYqDl5rIiTVOg6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X5r98A9n66hIaKAkJoTWGk9D3W8A21MzNhZwlJyTHEOWr7ByGPzTjtjBSSNnVyVv2
	 C8VHB2plTBHp3pZwhWk1bl9sT0ueH4oyl7vfnGoBp2WXfWhDb7uP6Pf1ghCHWhzAY1
	 O3XoV+aQ35uo1TGShcpS2hjXnAPVfB6+vNpGBrRYfblv1bo7T920SmJXZOJTxf9ILq
	 vfJdsTKveTyTe8fg7hRKj4Nx5zd+1iSMeD6qlcH4Np0pF08q5gorOqxW++ie9kBk2h
	 qOYAWRaeRlq7sUQx5z4rHfwMyJovAfib3X1JrcsgJtQkAUu5HruDkD5BOQoKwKGl4U
	 ZuYq1GmGmrsSQ==
Date: Fri, 21 Nov 2025 06:43:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Colitti <lorenzo@google.com>, Neal
 Cardwell <ncardwell@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: fix propagation of EPERM from tcp_connect()
Message-ID: <20251121064333.3668e50e@kernel.org>
In-Reply-To: <CANP3RGeK_NE+U9R59QynCr94B7543VLJnF_Sp3eecKCMCC3XRw@mail.gmail.com>
References: <20251121015933.3618528-1-maze@google.com>
	<CANP3RGeK_NE+U9R59QynCr94B7543VLJnF_Sp3eecKCMCC3XRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Nov 2025 11:05:39 +0900 Maciej =C5=BBenczykowski wrote:
> Perhaps I should have sent this as an RFC, as I haven't had the
> opportunity to test this fix in the full blown environment where we're
> running into problems.
>=20
> I'm hoping to at least get feedback on whether this is acceptable
> and/or even the right approach -- or if someone has a better idea or
> if there's some fundamental reason we cannot return EPERM here.

FWIW this breaks the mptcp_join.sh test, too:

https://netdev-3.bots.linux.dev/vmksft-mptcp/results/394900/1-mptcp-join-sh=
/stdout

