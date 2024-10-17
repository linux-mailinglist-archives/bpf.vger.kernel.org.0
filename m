Return-Path: <bpf+bounces-42318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1E9A276D
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 17:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0777128552F
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 15:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D521DED7D;
	Thu, 17 Oct 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guVGI8aw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17D17DFEF;
	Thu, 17 Oct 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180456; cv=none; b=lurFQsM/+U1UaT+5PHyC5KgQvcKI+P6ZYNNmkJFtoD7Z9z5Jykx7f0/bbMAp90YN/lRv+aHHkdOQyVnGnHqgfgzat2yzkwalgYW1CFupp3n0BXXowTQhuvJSYcmohhgM48/bdRZHursASmT0sESCTNx6rVFg0IOEcpFclj51bZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180456; c=relaxed/simple;
	bh=Vj5Bq+gB+bpv4p8R97tnG53w/uryiDweze+jbn5vcsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdTWscB8CRuYtNoXZdhV8bFSziGkVMbVfEHp7HnjtkFBHHZErfzwQKrXgixg99/tzpdKvSk/6pFQpqjsNPz96RSCcGneNB5I6eo/Z9nhx3ko0aFlWWJt61Y748c72a2bkeOL4N+doqP00cUtrkBfX1dYHaLJy0cLpJzChzm0K5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guVGI8aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9706EC4CEC3;
	Thu, 17 Oct 2024 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729180455;
	bh=Vj5Bq+gB+bpv4p8R97tnG53w/uryiDweze+jbn5vcsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guVGI8awx7i++fEbaOWcMH1yBcDMJuynRgUt/d0wBOMhkdD+s+UAefuLq+LHkXxYN
	 uQyz/YSnSGJ3aCthP1Y/nVGZWSZU9Dddq7w4dxZwY6xKS1zOjZE5ZvUm7ZfXlOwHez
	 ntmBgcZlKRfgo8qe/IgFIsHVh4Iej8QL2E4/7Mi8xwrY6R5LQRsPo6bQCHGx98mjkU
	 u4biv2OBdcmBnNfckV/zeoB5nhhFKe46d82zRo7scsRZmDr7DMpMTt1SyHnF9kGxmT
	 flb3YyY/M9w5wUtHYEpRICg7KprHN8pPAQ/ndR88faFryZQsgJVxS6LqT73qknP/qV
	 MHe0fAj/OZohw==
Date: Thu, 17 Oct 2024 05:54:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Use btf_ids to resolve task_struct
Message-ID: <ZxEzJiOQA7uDJ38X@slm.duckdns.org>
References: <20241017024412.16914-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017024412.16914-1-dtcccc@linux.alibaba.com>

On Thu, Oct 17, 2024 at 10:44:12AM +0800, Tianchen Ding wrote:
> Save the searching time during bpf_scx_init.
> 
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

