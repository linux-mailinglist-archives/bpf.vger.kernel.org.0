Return-Path: <bpf+bounces-18273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D5E8185F4
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 12:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C131F2528D
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BBE14F7E;
	Tue, 19 Dec 2023 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEeU/ma1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B5168AB;
	Tue, 19 Dec 2023 11:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E35C433C8;
	Tue, 19 Dec 2023 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983620;
	bh=WmywoZqCQCI+Za9fjHWCHh0YK4XKWWcoHTQX1Ku1Vp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEeU/ma1mlMdSGMkSzyfsHzsfHaieGz6nljrCUJiyZZ88YN1jmfS4VyzoL0sOseNL
	 7yjYFxrtox6VLMT83dOX9Aa9RXWzCv/wrfUkxD4suBjJk8KZp/6CTpkogRkSO13Qjc
	 +l0g6c4WcQI+LIikGBF4HmxaTNaBXDqrscfK3R08cYLtGp5boGgkoQsSUMnL6DcVv6
	 BB2foEp/gw1hZTbG7qiuoLWUZvxl0/bCSFFQMxuSZvqyXGYeEfOFNLvyZn76jnn76s
	 QpVSpxc8u7sNPInfg4Ez6WLmGddLlxP60UeeHuYccZndxkvvFNj1v7P2JHeeQcN+sS
	 fcke/PTDd94oQ==
Date: Tue, 19 Dec 2023 11:00:15 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ast@kernel.org, netdev@vger.kernel.org,
	syzbot+f43a23b6e622797c7a28@syzkaller.appspotmail.com,
	martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, keescook@chromium.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: use nla_ok() instead of checking nla_len
 directly
Message-ID: <20231219110015.GG811967@kernel.org>
References: <20231218231904.260440-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218231904.260440-1-kuba@kernel.org>

On Mon, Dec 18, 2023 at 03:19:04PM -0800, Jakub Kicinski wrote:
> nla_len may also be too short to be sane, in which case after
> recent changes nla_len() will return a wrapped value.
> 
> Reported-by: syzbot+f43a23b6e622797c7a28@syzkaller.appspotmail.com
> Fixes: 172db56d90d2 ("netlink: Return unsigned value for nla_len()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

