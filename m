Return-Path: <bpf+bounces-43005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121249ADAC8
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B774D1F22AB6
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB41167271;
	Thu, 24 Oct 2024 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eC+RghMl"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD72C9A;
	Thu, 24 Oct 2024 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729742688; cv=none; b=LbyVseByIMJOaxTUAfIVpt+PfmHxcVtWDPwoUeyBeaUfLGX4lDrfxrt/lMg4BsMRIEoqTlUQHNcvzYdmudX+f9oDhekUuUfijUs2YCCLH1DwS3wY2Hv0Zy3J/FB91km6KDcO0UNpb3pWuV1ymiL5IOUKsQPW6klAnTunMxDq6ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729742688; c=relaxed/simple;
	bh=BN4KxyJeSbI9lrleBa12C+6OpbPXEGBtF1/wBfL+vzc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xv1IC3GFV0j4AEiFaNjUCF3KrC2XjZq49cU2D+UGqZurpYPoWKGH8z1sUZdeosvB2vau15eLj8KhIv+IujO5C6rhdqzaIAnKggdKZFjLq6EcQucCMWePn0b24ok4D+dObc6gQL72FvsYhNR3juttd521Fw+Ao/cCRkFjCCjFzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eC+RghMl; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729742676; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=mRJXIoF9p2pnVpRbIFNfNZ8xFxJdIE7RijO56fWUVqo=;
	b=eC+RghMlTskUNq2zNSFRSaazk9gde8FgNhJaB/hXgQ2h4GXr8s9YZiIIebRZyNGJaZ3ad+rVfPzrmXsRakVR8rfnSpcsHWFXrM/bXA5iUxo+DcFHfpKwftRhzt9QtjJr4ILT4RzLVJ1NC4nJNb76m3StVS4SynCr/74pQJsVKQs=
Received: from 30.221.147.97(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WHne6jJ_1729742673 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 12:04:34 +0800
Message-ID: <2006b84c-e83a-431b-ac35-bb357459fa96@linux.alibaba.com>
Date: Thu, 24 Oct 2024 12:04:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] bpf/selftests: add simple selftest for
 bpf_smc_ops
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, sdf@google.com,
 haoluo@google.com, yhs@fb.com, edumazet@google.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 dtcccc@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-5-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <1729737768-124596-5-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/24 10:42 AM, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This PATCH adds a tiny selftest for bpf_smc_ops, to verify the ability
> to attach and write access.
> 
> Follow the steps below to run this test.
> 
> make -C tools/testing/selftests/bpf
> cd tools/testing/selftests/bpf
> sudo ./test_progs -t smc
> 
> Results shows:
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED


Sorry for just found an issue with vary config. I will fix this issues
in the next version.

D. Wythe

