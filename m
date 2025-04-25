Return-Path: <bpf+bounces-56752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C2A9D53E
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 00:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842C29C84C5
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9DB2343BE;
	Fri, 25 Apr 2025 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FivIB+Pm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702492327A7;
	Fri, 25 Apr 2025 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745619167; cv=none; b=O8219I8LSNKkvKcllHeeJ2Vbn6KunExUh8xqHKRCNm5b18rt2yVHDV3kykR1H0c8gZE8MfD3oQOlS7kjhM2XO8C0n4+ZB04yjbtdgO3ptn6H+ERm+TbI+uX+XrU5/d9NPrdfaja0m3aZvDO12Xhd7CKqNg7y2epH0M4FMHWtdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745619167; c=relaxed/simple;
	bh=HVW60GVcvknStGI/2n8jjCkFZ00qbE129bLATIlEkN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHs+4daKNSd+2u1f8+gh26HEXwdzA0bfT+/bEMqXtC9UjlA5tt4Xwa0FfBS/KqThkaWvvA5PFBxdR/TupIWAi5jpMPDoQOS4BahJisTKOhBDbDieN/g5RZliqR4BPmS7b3B3KmPWazOcUy0uuU23K7IXMYYJAfwiH+yHjtFiyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FivIB+Pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D678C4CEE4;
	Fri, 25 Apr 2025 22:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745619167;
	bh=HVW60GVcvknStGI/2n8jjCkFZ00qbE129bLATIlEkN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FivIB+Pm8HZm02evZ3ui+z753Sjf4zKmvQTZkr+1Bxxb+sCqGIGw9V8F2UflofBAQ
	 oueav24b8I2W9VYE5pQQBO3dCEp1O7JV0mnuthk/m/tBq7shaxWtgKKipWgI9s4Il9
	 U7oOue/y07MMTZ8nlGu1ht/+0Wq98ArPvUwhr/DbP0eUOGhjDDE6RV9ZbjLGLPdGIs
	 ku63QQIKvEcgH9lCm7F5LEM7f0MHrUtBQT1OzCRfYwtr0OmJMuhR2Gblg9p9PozA+A
	 qSuRl6IsViuSVR7Q3ZfyDNskqZ+Upxu8Z1OBr5STSBTbPqp3kiHqzoYgp+sJ6T1ofR
	 ZZ7vc8I3iymUw==
Date: Fri, 25 Apr 2025 12:12:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC v3 2/2] selftests/bpf: Test basic workflow of task
 local data
Message-ID: <aAwI3k4FeJHmHFKv@slm.duckdns.org>
References: <20250425214039.2919818-1-ameryhung@gmail.com>
 <20250425214039.2919818-3-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425214039.2919818-3-ameryhung@gmail.com>

Hello,

On Fri, Apr 25, 2025 at 02:40:34PM -0700, Amery Hung wrote:
...
> +bpf_tld_key_type_var("test_basic_value3", int, value3);
> +bpf_tld_key_type_var("test_basic_value4", struct test_struct, value4);

I think it'd be fine to always require key string.

> diff --git a/tools/testing/selftests/bpf/progs/test_task_local_data_basic.c b/tools/testing/selftests/bpf/progs/test_task_local_data_basic.c
> new file mode 100644
> index 000000000000..345d7c6e37de
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_task_local_data_basic.c
...
> +	bpf_tld_init_var(&tld, test_basic_value3);
> +	bpf_tld_init_var(&tld, test_basic_value4);

Would it make more sense to make the second parameter to be a string? The
key names may contain tokens that are special to C and it becomes odd to
escape naked strings.

Thanks.

-- 
tejun

