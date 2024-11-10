Return-Path: <bpf+bounces-44456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB0B9C3159
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 09:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476AF1F21660
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D6152E0C;
	Sun, 10 Nov 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="But623dP"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315E014D70E;
	Sun, 10 Nov 2024 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731227840; cv=none; b=Jqw//LGQeFCQJt3RLv2rWDDq2zQu+gKeNWWAC6yfXeiOceHG7y/SbzK5d8yjCAj9RNiBkCDcexEZZ9609IboYsSshCCB3TZUBjYL7iLyuf/hqjx5hNNeb5YFEuR5J1lXQhQZLhqyeeK1ULKlyO6RWv9UbxJA7yK2foVjckl5YUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731227840; c=relaxed/simple;
	bh=wXJjexJY/+pibG8nCaNFkp8io3YCMgfgRrl0fX5PLvc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTyuXREbp5MLz4XfgUjbB2/ixYzRKuDQWnnqLyxhvbyQkvT6CmbErxo4R8nRoSuiSJCgXr/jdZ4UritMVjxuMoNIhxF5pdkF4NR/HuWIVIFcDtBSHCtP+tjgtAqPEEbszoFPJwIGCmaHRnbDaRzmCD9++nNy6UHukMOPwmao7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=But623dP; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Q9MDlHLhRBCC/FowPzthZ3lSPHtwKksm/TWLW2AM+is=;
	b=But623dPXF1lQYVcP3H/DPD9nGIwh6dHfu27H6gUfnoKOkGBzcU5RTEKG/fyl1
	Ai2Kn2dSfDHzAKRfaU3e9SUTMzJDvSySMHtHPJ6jG6aMoKO0KXMp0Cw7WlEbwJ4U
	a8iM5OOlqC9Ffy4jb34jLehVB6fl6+d0T9DTmzNEYgJiU=
Received: from osx (unknown [139.227.12.77])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3H4mZcDBnBVbMGA--.16005S3;
	Sun, 10 Nov 2024 16:36:43 +0800 (CST)
Date: Sun, 10 Nov 2024 16:36:40 +0800
From: Jiayuan Chen <mrpre@163.com>
To: martin.lau@linux.dev, edumazet@google.com, jakub@cloudflare.com, 
	davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2 0/2] bpf: fix recursive lock and add test -
 updated to [PATCH bpf v3]
Message-ID: <wmexc72od3rsa5ayrmsuhhbozrr22yxkynspz46swyrcyp77bm@pjfwspeu2b7r>
References: <20241109150305.141759-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109150305.141759-1-mrpre@163.com>
X-CM-TRANSID:_____wC3H4mZcDBnBVbMGA--.16005S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF45urW3tr1UGFy7Ary3XFb_yoWDXFb_ur
	4Uu3s7J3srAFs8KFykWa1rCFyq93yxt34UAFZrKr47ur47ZrZ5JFs2gr90ya4DZa1xA39x
	tF1ruFWIyr4UXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjsNVPUUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwCTp2cwbcolyAAAsm

On Sat, Nov 09, 2024 at 11:03:03PM +0800, Jiayuan Chen wrote:
> 1. fix recursive lock when ebpf prog return SK_PASS.
> 2. add selftest to reproduce recursive lock.
> 
> Note that if just the selftest merged without first
> patch, the test case will definitely fail, because the
> issue of deadlock is inevitable.
> 
> ---
> v1->v2: 1.inspired by martin.lau to add selftest to reproduce the issue.
>         2. follow the community rules for patch.
>         v1: https://lore.kernel.org/bpf/55fc6114-7e64-4b65-86d2-92cfd1e9e92f@linux.dev/T/#u
> ---
> 
> Jiayuan Chen (2):
>   bpf: fix recursive lock when verdict program return SK_PASS
>   selftests/bpf: Add some tests with sockmap SK_PASS
> 
>  net/core/skmsg.c                              |  4 +-
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 53 +++++++++++++++++++
>  .../bpf/progs/test_sockmap_pass_prog.c        |  2 +-
>  3 files changed, 56 insertions(+), 3 deletions(-)
> 
> -- 
> 2.43.5

patch v3: https://lore.kernel.org/bpf/20241110082452.40415-1-mrpre@163.com/T/#t


