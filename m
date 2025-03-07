Return-Path: <bpf+bounces-53589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FCFA56C93
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B37D176DF7
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C165621D3D1;
	Fri,  7 Mar 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P49jbcoa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE3194C78
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362630; cv=none; b=FBPFPxFOvc0Ynw0T7uFYY8LBtXLz2ugKtyspfu2IPVyqoGYUHyI5Ux69ByjGBJBzSqteY5+jVIekIF5EEsZYR3qvoFi1VpDqhmPDNKeS5KtbUQYgjgfQhrEq6+pmwPr24ZDSWAqGj+TOTmqHEechwdyB8CJKREspY/PBj2/5Z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362630; c=relaxed/simple;
	bh=WZzaB1vdIFoj4E5RQ/LUJAJOBuxQ+DwXzp3ZD750nqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cveEjn4KfrGidcNKT54XaXmr7TkrFZhOPSuxgwBzApO0vtqDkBycdCA0wYVB0pG1pQm7mZFD/5i2G6g5Q4M9/tfCS55o/6grykGsCFESXGdEfMlA8CUSGN/LFOqKjuReWc3eio+LyaoQv4RlZisXwapUHK7FBPQCwHGd6xhYZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P49jbcoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4EAC4CED1;
	Fri,  7 Mar 2025 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741362630;
	bh=WZzaB1vdIFoj4E5RQ/LUJAJOBuxQ+DwXzp3ZD750nqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P49jbcoa71nEj8ZL2/g9q9XsSL6VSfTXHfBLxc2R+PW8gqM7YzouNWToRMiN3sI7T
	 +3Ej1QZyvNjMSTxKB9NWDOMZ9Lt98nE29i5NSbjx1ojr+eP1YTFRuEM0jtv8uOI7cZ
	 EuLDg+ASnELjFMJS39oYX2bHABntRd41KrnrJJTi52ZF28xN375Z+7HWuNWEdRslqa
	 Mc4Ek8AdjEjjq4EeSpFm/mcyGB+KC4ij7xZZqkgQ0KCoBdteCX14uhQU7mpiW87jup
	 aN6JOOirSMhFMq2zdSn7cBb9HravJV2EMXV3V1Q53G5HiZo+fDRutuBBg4kdTqf2ol
	 qxol6CApe89Hg==
Date: Fri, 7 Mar 2025 05:50:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	yonghong.song@linux.dev, memxor@gmail.com, houtao@huaweicloud.com,
	Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH v6 1/4] bpf: add kfunc for populating cpumask bits
Message-ID: <Z8sVxBI8B7oga-zL@slm.duckdns.org>
References: <20250307153847.8530-1-emil@etsalapatis.com>
 <20250307153847.8530-2-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307153847.8530-2-emil@etsalapatis.com>

On Fri, Mar 07, 2025 at 10:38:44AM -0500, Emil Tsalapatis wrote:
> Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF memory.
> 
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> Acked-by: Hou Tao <houtao1@huawei.com>

Would a kfunc to transfer it in the other direction be useful too? If so,
how would that function be named?

Thanks.

-- 
tejun

