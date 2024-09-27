Return-Path: <bpf+bounces-40388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD042987FCF
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 09:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F7F1C21EB1
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E91188A2E;
	Fri, 27 Sep 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r02ykaFa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3802F17836E;
	Fri, 27 Sep 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423820; cv=none; b=VVa2sfQ4KqbY7jLlEJsRHPHG5AueKqz886CmrKY4KB6uqdpLWlbDgXisF9MSuxgpKULdeYSL/BpqBj7CcvyvOPJyOXJf2kSdbi+TIY0bIj0tTUoSYNK4uLoFVrZrESv3rZVzaAHULd4oSAyK5vij99KYY7cxycEGRGDW7qC6jhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423820; c=relaxed/simple;
	bh=1v+qaTXLlvinnDY3VMpAzxnQGlQ3K6bKqzeP2/61F2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQhawK8BgxT0tsmNp2n2CZRJWI4wamaPUJOUGZOSmVi0et8NM/XDfzhXUI/mm9JstfdXTViAXtqN/9uSV7g/VxMDU/Fr95OUBWnSLEJV3KP4otv5N1lTHeVqwQ1+vOAbmSCHRqDcHyA/HC+p8jXeuEfUPNYb41q+otVLntukcv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r02ykaFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646B9C4CEC4;
	Fri, 27 Sep 2024 07:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727423819;
	bh=1v+qaTXLlvinnDY3VMpAzxnQGlQ3K6bKqzeP2/61F2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r02ykaFaiLTDy6Pncso4kjxgi2SFdUJ9EyaDkncbdbJGJnDQgseDKlsSIHh1kdcI0
	 ewPtaKjt0TTPja4R4MBYSzv7KWZSlEc7fewwu0v9abbJB9+ajCGERAJol10lixlzOs
	 Fx+AYMNE/JcyJxz/g2AiAJf58+2vhA6tRKwdtOyU=
Date: Fri, 27 Sep 2024 09:56:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Roman Gushchin <guro@fb.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH 5.10] bpf: Fix mismatch memory accounting for devmap maps
Message-ID: <2024092737-flick-commodity-20d5@gregkh>
References: <20240920103950.3931497-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920103950.3931497-1-pulehui@huaweicloud.com>

On Fri, Sep 20, 2024 at 10:39:50AM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Commit 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for
> devmap maps") relies on the v5.11+ basic mechanism of memcg-based memory
> accounting [0]. The commit cannot be independently backported to the
> 5.10 stable branch, otherwise the related memory when creating devmap
> will be unrestricted and the associated bpf selftest map_ptr will fail.
> Let's roll back to rlimit-based memory accounting mode for devmap and
> re-adapt the commit 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check
> on 32-bit arches") to the 5.10 stable branch.
> 
> Link: https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com [0]
> Fixes: 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check on 32-bit arches")
> Fixes: 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for devmap maps")

Should we just revert these changes instead?

thanks,

greg k-h

