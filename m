Return-Path: <bpf+bounces-35231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A1939076
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791BC1F22248
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 14:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D41EB3D;
	Mon, 22 Jul 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQBGBUk7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460BD2F5
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657928; cv=none; b=s93WL58K0pYWD0yFSX6BurjJWVV3qej3/pNcBrFUnSvvTRRlCoi8GVIpGMfrjDrCjkB0afVDMz7E+2DdWQdQkfeAOoAu8DRd9X2hms6qEplX1OhYEmqrm0Qjz+aWRaw7CldYEm56jNoZEzOf8hM8FoSxv2f8klhSm6lYzZZctmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657928; c=relaxed/simple;
	bh=zQyVKl6+MOP0lU0rFmbcxmfF2D6RC18bo95WMIYzG04=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DISlI52idVnrjuwRFlax/eDzY1CrBTa6WFfNinkqbpjsdJImz8of4C6MYJW5DQd2qZ7aP665QQK82XXmGT3TiF1iHRLhtoRSBhIVp+yLANqjpQpVFxKzifUwIHgoEgmK6Cr2QpaUYg6nGShTWjI7BBOlf0uA1Z0WSc/r+Sh9vKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQBGBUk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3342C116B1;
	Mon, 22 Jul 2024 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721657927;
	bh=zQyVKl6+MOP0lU0rFmbcxmfF2D6RC18bo95WMIYzG04=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fQBGBUk7z8X54jODmXgDIDqDd2cdWII/Dhmp4uhYyxtPdFy6SmpIHzj96YufSg2BW
	 pbJGqag6pF+6LBDoohDPM68b21GAR9NGzJO+CzXuGgSIJXQgHpJAtQWTEghsCoTv5y
	 JWO4v6R3v5w4+piK7GcoMmuTAYY88DZnVIO5uk/o3nj+7Paak/LBB5GWJCLkqhVSt+
	 w+8/zMnB6FQc/OhE1UNf+Xu1ARVmz39dDLbl4weO7x/Q7RgpDqKw4ERap4IGxte2Q2
	 9L7xRdEcB2Q96i5rozYNsdTxB1KzNFa+vr7tTkwYaY+NPRDAj2PHX6HjLxlU7MDnjF
	 FOkbTAETe73Mw==
Content-Type: multipart/mixed; boundary="===============5756649441662389050=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4c1067fec169076f81beb43499a059b20797dc18c674c53c26f9c23a3756359e@mail.kernel.org>
In-Reply-To: <20240722135253.3298964-1-asavkov@redhat.com>
References: <20240722135253.3298964-1-asavkov@redhat.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
From: bot+bpf-ci@kernel.org
To: asavkov@redhat.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Mon, 22 Jul 2024 14:18:47 +0000 (UTC)

--===============5756649441662389050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872975&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10042325764

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============5756649441662389050==--

