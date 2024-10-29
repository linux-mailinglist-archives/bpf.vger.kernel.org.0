Return-Path: <bpf+bounces-43385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CDC9B4C64
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 15:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E851F24623
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382462071FC;
	Tue, 29 Oct 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDYMdEzK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0D206E9A;
	Tue, 29 Oct 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213046; cv=none; b=btXIevMPvf2in0feyhXVqNU34D5WD6MNC7PtMysJDrPhJ0q2pHGT8YBqT0IJ5MLmB8mBBjE9dQstG7BAVpyRVkPN8aEPFkYoBNtReN0UjjRvNr/+5fLyYZRJG2ippn5DU+K55eyb920xnxVd9v01iuekPV1ePpG7h/uo2DBcWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213046; c=relaxed/simple;
	bh=0c7KNis399VdnZBFgh040FMCOECS1I/z5+ZRYipp1Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Al/lnVjR9XMf3oNlYaKr4NHKNWlijYyM218qv5pyRLvjfeEXStE17lyAla7l9kdnfZQxzoLRiH4PVQu3sGOdE90dEMMSAsR/oxJGYCiU16loE4Wkil/hoRwN9bVvpr+wdFN2c7Jk+7K/pQmJv7AedH53aNKbO0TC3M0d1AM0vg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDYMdEzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2ACC4CEE3;
	Tue, 29 Oct 2024 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730213046;
	bh=0c7KNis399VdnZBFgh040FMCOECS1I/z5+ZRYipp1Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDYMdEzK/af2sPGLyxSs55A2AlhVBQSNz83EvIMFRCfRf2kP78K8k4lQHHq1XsYmc
	 6i0hsWzIPEMnLVvokVVknOYwfXK0w+YLemnOS8VmfdhKinKpBahxEk+DfUGIcyvwwN
	 o4BmLSjmoIshfwOR1K4/e3/H1oD+ITszggidvHSNuo8dHxNamIa6IOCSFshSYn791t
	 w0aLWhni8xT6ZHBaXpwFBq3XypKM2wRQxdDp6Day/cqCqufmJHkerzM38QP4CB+3AN
	 6C16aVbHm3UWCwE3HvGTybZmv+uE9eplC8dRUB0e6ZmKgRsZny+cDmkkDiWSlSClWG
	 6ZmYEqIHQCBxA==
Date: Tue, 29 Oct 2024 07:44:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <anthony.l.nguyen@intel.com>
Cc: Yue Haibing <yuehaibing@huawei.com>, <przemyslaw.kitszel@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <maciej.fijalkowski@intel.com>,
 <vedang.patel@intel.com>, <jithu.joseph@intel.com>,
 <andre.guedes@intel.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
 <sven.auhagen@voleatech.de>, <alexander.h.duyck@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 0/4] Fix passing 0 to ERR_PTR in intel ether
 drivers
Message-ID: <20241029074404.282e52b5@kernel.org>
In-Reply-To: <20241026041249.1267664-1-yuehaibing@huawei.com>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 12:12:45 +0800 Yue Haibing wrote:
> v4: Target to net-next

Nonetheless I'm going to assume Jake / Tony will take these.
LMK if we should apply directly.

