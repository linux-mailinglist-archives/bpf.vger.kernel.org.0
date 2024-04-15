Return-Path: <bpf+bounces-26852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DFA8A5994
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 20:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC41F22E20
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462F139D1D;
	Mon, 15 Apr 2024 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KipisuSt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A69824B7;
	Mon, 15 Apr 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204474; cv=none; b=R7mMqbrqy6zS6zebTehbcqulv9HJ0AFm/2SKxrpJXdLlZYa+mjxGykQiBpdpWvZ4pGhweJj+5b1q1+Ni6of8H6cwpy8oAXmAqrjSg1mqk6XYAdMDuo/HlzwqUlfYkuDpXIHj8Vqg5EjsKlQnYh0rUfO6AAIzL8TWiwexytTyeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204474; c=relaxed/simple;
	bh=g9JAiRPeZH9fD6H2JsrciNypysCBGBFSrE+abKZyCfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnhkLD22DW17YagNSPNDrIMfXJXHDmDjiN0AP4QGOPGGkVXSvxFSN4OPLcA9fC19cVrTs/UQKOQIImRhk3WhK31WnRDhn6XmU/lrHteAWuHzeUhxRqM26cOTqv2fVYQlHKr580z0imuuxd+4m075uMEFIa6r4WHBfH/XMw2chIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KipisuSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56414C113CC;
	Mon, 15 Apr 2024 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713204473;
	bh=g9JAiRPeZH9fD6H2JsrciNypysCBGBFSrE+abKZyCfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KipisuSti1Ah5JA0E6G4t16RayldXKA/tIPhvE936LFJgM54SFDlWzorRdoqNPoP0
	 anzlGrRUnsQ1ykCW4+DmQFnlNeAcqxb0VYs6SLibXGrPiYZc4ZkNqGvnYGPojuHvxX
	 ZhYNV6+qY4+c/v+2OC5oeM7oRJx3cBW9xGar3eGE5/fd32Y0CVz5Eh6qyOTUCtfSsr
	 +7pOKYKv8WQPB/+mRcMH+GxOSe/0//MQYjaZihsC6i/O36S4cqbG/lqqUr4QvOdZ2w
	 3mBXRZF0xfkRjexMBibLgfpyEWXpB7FsNDyuNKoZvo7W+Hbjv5i8Yv97Iy/geJaj0H
	 xf0sCKKxtY6VA==
Date: Mon, 15 Apr 2024 11:07:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zheng Li <lizheng043@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 jmorris@namei.org, James.Z.Li@Dell.com
Subject: Re: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
Message-ID: <20240415110752.30f6733b@kernel.org>
In-Reply-To: <20240412122538.51-1-lizheng043@gmail.com>
References: <20240412122538.51-1-lizheng043@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 20:25:38 +0800 Zheng Li wrote:
> Inter-process communication on localhost should be established successfully even the ARP table is full,
> many processes on server machine use the localhost to communicate such as command-line interface (CLI),
> servers hope all CLI commands can be executed successfully even the arp table is full.
> Right now CLI commands got timeout when the arp table is full.
> Set the parameter of exempt_from_gc to be true for LOOPBACK net device to
> keep localhost neigh in arp table, not removed by gc.
> 
> the steps of reproduced:
> server with "gc_thresh3 = 1024" setting, ping server from more than 1024 IPv4 addresses,
> run "ssh localhost" on console interface, then the command will get timeout.

Please repost this and CC appropriate maintainers.

scripts/get_maintainer doesn't bite.
-- 
pw-bot: cr

