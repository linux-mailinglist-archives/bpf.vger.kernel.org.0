Return-Path: <bpf+bounces-20986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA48461FE
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 21:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D569728FE7D
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 20:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FEC20DEB;
	Thu,  1 Feb 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NUE3BJkW"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12276111E
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819822; cv=none; b=iyoWsn7i/K51+u1q3Kxh5InEF0IXYPID5x00jd0BmFV2rg/CV8BSjvrUcwX+efFwj+4bW76GbKy1E87vHN4Yl5La1oQIjFX0f0R2dcywKEXyLEtemlToKmpfaRdqgION1Yw8h47uFb9+FTOtAHJVIRaCWw1axp8nKXsZbwtdXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819822; c=relaxed/simple;
	bh=YWcSO2WqYtq8IwvArpM/Sk4c+4+IuctSh1cYtHhFQPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHhc0ugEszWi8b42enD7WnkkTXRWUvYapWpxa59zi5rT13OtJLHHjiwlcCwhzGb7JVhrr4kuGVFsEAMNQ8uxDodDN3n5VHpyOGdqdHTMJFpMSWRpZUU90hH6wr6cxfDlsU+Z/QaIkoZpQ6KHx6QmaXzQ72rR9M0P4OWAPj8T25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NUE3BJkW; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79df5a1a-3d7d-4a6a-8ebb-aaf4d9e89aaf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706819818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yylA87TsSfOMt8vwcbgPf2+PmgS7E4FJCrI1OfEuefk=;
	b=NUE3BJkWdykRE1qA/AJYkmIngfGjkZrF7KvsZKbiZQfQaEhI6gw32VNVVc6cePrJO0PhxA
	pBw7GwmqihzmL8U/LwqNdeZDBvpKdbGqVj7kEVLPkvoOuQNC6B/RMm9EDrKcFPp0B5lqiY
	8Euh1eYTlHBL8UQNwPRkhpn2wqJPgEU=
Date: Thu, 1 Feb 2024 12:36:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linux-next:master 1465/2825]
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:557:13: warning:
 variable 'r' set but not used
Content-Language: en-US
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Martin KaFai Lau <martin.lau@kernel.org>,
 kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>
References: <202401300557.z5vzn8FM-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <202401300557.z5vzn8FM-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/29/24 1:36 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   596764183be8ebb13352b281a442a1f1151c9b06
> commit: 0253e0590e2dc46996534371d56b5297099aed4e [1465/2825] selftests/bpf: test case for register_bpf_struct_ops().
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240130/202401300557.z5vzn8FM-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401300557.z5vzn8FM-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c: In function 'bpf_dummy_reg':
>>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:557:13: warning: variable 'r' set but not used [-Wunused-but-set-variable]
>       557 |         int r;
>           |             ^
> 
> 
> vim +/r +557 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> 
>     553	
>     554	static int bpf_dummy_reg(void *kdata)
>     555	{
>     556		struct bpf_testmod_ops *ops = kdata;
>   > 557		int r;

Kui-Feng, Please take a look. May be change the ".test_2" return type to "void" 
since it is not used.

>     558	
>     559		r = ops->test_2(4, 3);
>     560	
>     561		return 0;
>     562	}
>     563	
> 


