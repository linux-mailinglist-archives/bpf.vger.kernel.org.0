Return-Path: <bpf+bounces-53387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1971A509F4
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052C3164028
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8BD78F3A;
	Wed,  5 Mar 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqmRHzPL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D2199E89
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199225; cv=none; b=DYzjnm8XyTWeJJXz6vT5p0MwI3ZIF5/HFYEqMqNp/fcN7rzzlYosaYrTIo4UC/rPZL9gQyfC2Yi8MuGCi7BdV8I9bdCkn7/nGH0elU3LWiSWWLkynivjGRJcTLqRehezE8vIXZJaSeAFIt4/BXHVtvig8II89tmoZ1TTDqUogTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199225; c=relaxed/simple;
	bh=2iKweFzd6Z0tflKSb0TvhArWmdH+dphGUlgqhtGV0gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFPac+7uL/CQsWedVqP1aZ7h/fymsGmnxOUnTDVk1zfOJnBLji9cw/Y2QVZOM6OY7K06M2kwQLB6J+4neAWrAf1GT+qLd/opaDG6gpf9hxBpVpqCSQxMqzTIoVP7ztsFKkD8Z8w01pk77AZ+EGBtVQQsP9IvQlGu3TWdNg3vHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqmRHzPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8C7C4CED1;
	Wed,  5 Mar 2025 18:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199225;
	bh=2iKweFzd6Z0tflKSb0TvhArWmdH+dphGUlgqhtGV0gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqmRHzPLmumCAAGXvI6aN/B6lHoVXwanX1aiG7XNWGYeOuOV/L5tqIRBLCTwfEkDW
	 MTo4qqDtiFohtXrxTSGoDzSw6EUx6XbpnAYit3zDnWInfDzl6QgktGxomQX12iQAGN
	 azJg32DnjCN42jGChGazgEeEqQEFSHPSDTN3JymecOiX22BCqIovRPKDBG8kXobthE
	 9M9FYcUHGpC3ktI7IeTQm9/v3v5g5GoZ4r614SXoajPpQIH4gGhURpQmSEtxALEo+H
	 10sqmmHqRJs4s6bXy1hH+OUnnWv2gh0h7U2OKbNnC35jM/Aiy+uAFxIbZeH53WMKAx
	 6UXzizh7KOlaQ==
Date: Wed, 5 Mar 2025 08:27:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	yonghong.song@linux.dev, memxor@gmail.com, houtao@huaweicloud.com
Subject: Re: [PATCH v3 1/2] bpf: add kfunc for populating cpumask bits
Message-ID: <Z8iXeDlDVbZUG_aD@slm.duckdns.org>
References: <20250305161327.203396-1-emil@etsalapatis.com>
 <20250305161327.203396-2-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305161327.203396-2-emil@etsalapatis.com>

Hello,

On Wed, Mar 05, 2025 at 11:13:26AM -0500, Emil Tsalapatis wrote:
...
> +/**
> + * bpf_cpumask_fill() - Populate the CPU mask from the contents of
> + * a BPF memory region.

bitmap_fill() fills the bitmap with all 1's, so this name can be pretty
confusing. Maybe bpf_cpumask_populate_from() or something like that?

Thanks.

-- 
tejun

