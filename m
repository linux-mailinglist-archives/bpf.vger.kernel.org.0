Return-Path: <bpf+bounces-38155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A2960AC8
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F9283C73
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB31A08DF;
	Tue, 27 Aug 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EcUAECZN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964019CCE7;
	Tue, 27 Aug 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762735; cv=none; b=RWqnQfen3Z2K+aJ7Cdnw8MsFSnZUCayGC6/KADFJeYqVOOpsyK4th+aGhIcxnmPLIk5oUFVM4THBoTWNnsYP0+CaRNDlosTIbCgeVPFSWJ8IezIFb/U9oMmaiTBTgcbi4+sDNR90vNQzTxJg/iumiSJXN3x2dr2eps8Ow07lMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762735; c=relaxed/simple;
	bh=np1f0iS3PKRxhLTFgfc1+lPPEbJpFk1twIwEjdOV8ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAecPfcLkLra6vor3LXEW6wGRbOBq98VftSD9hrjRKRg6YkydBxWk1VfF8n4RzdKzEhLxRUmWGPWVLQBR1XywMiLYdyGS5Bt3lzunmPdRyaGmQm9jKFMHugQOBIVfHPg+qQxVrA7BsXpEzNgPpJiXuQCxiea48INya9F5tyU90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EcUAECZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C14C4FF6A;
	Tue, 27 Aug 2024 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724762734;
	bh=np1f0iS3PKRxhLTFgfc1+lPPEbJpFk1twIwEjdOV8ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcUAECZNhSB2x2eOlnV0jR0nN4+IghP1CVbG1UWYwRA1IzJSU95LxaHjmE1i0/mob
	 iNn+34Pqdxu76j/pPE+RnGD5MWPzwZuDRdgFY7WWfb1l1ggiijJHL1Ri/8hIeGw39q
	 vRG5icPKtiiJuwP7ReXgP2AzybZu1gvum4aKgecI=
Date: Tue, 27 Aug 2024 14:45:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.6 2/2] selftests/bpf: Add a test to verify
 previous stacksafe() fix
Message-ID: <2024082722-carwash-reaffirm-f23c@gregkh>
References: <20240823014829.115038-1-shung-hsi.yu@suse.com>
 <20240823014829.115038-2-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823014829.115038-2-shung-hsi.yu@suse.com>

On Fri, Aug 23, 2024 at 09:48:29AM +0800, Shung-Hsi Yu wrote:
> From: Yonghong Song <yonghong.song@linux.dev>
> 
> [ Upstream commit 662c3e2db00f92e50c26e9dc4fe47c52223d9982 ]
> 
> A selftest is added such that without the previous patch,
> a crash can happen. With the previous patch, the test can
> run successfully. The new test is written in a way which
> mimics original crash case:
>   main_prog
>     static_prog_1
>       static_prog_2
> where static_prog_1 has different paths to static_prog_2
> and some path has stack allocated and some other path
> does not. A stacksafe() checking in static_prog_2()
> triggered the crash.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Link: https://lore.kernel.org/r/20240812214852.214037-1-yonghong.song@linux.dev
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  tools/testing/selftests/bpf/progs/iters.c | 54 +++++++++++++++++++++++
>  1 file changed, 54 insertions(+)

Both now queued up,t hanks.

gre gk-h

