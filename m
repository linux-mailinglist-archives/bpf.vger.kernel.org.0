Return-Path: <bpf+bounces-44138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78E69BF687
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B859284911
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A7199247;
	Wed,  6 Nov 2024 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hGHRdNQ9"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9E1F9EB5
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921500; cv=none; b=KWcT6AyPplnLPmFIW0cF3YsV9m67/LNxeY+8Zbo9tToP5MMd/69mayFeMF8B2HAFE4KTumHdJqgd9dPWCf6p5WHwyhtxlyeJIYa+5Avrl1ejbbV8sU2qmbwT2nOSo3rQWVtXy3MTvJ5dd5t3o1T1OsOyKob2Xml48UL4S/ZKTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921500; c=relaxed/simple;
	bh=/UcuruJa42sc5tKj4vxaMmVizalVGohRb2HuSg/bXQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2Z9IAo+ozYXMPN/6Qf4oYoCBZUULdGAGBCQHfWrzevLxa0M17D6/j4TBDj9VKLIW77alXucqxtZJua7cjAuRk9YTTXYaZwtY1FSMeUSM5Fdm2j7jZQXSNedfUpd3ntKLfQLuWV9s2fQNLjG92ykfUMwgcaX3Swna64NyYJvR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hGHRdNQ9; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <047c7b32-8b69-4816-bf8b-dba0b806ec93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730921495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl+PF8Annjz6dZXcbBpVCQu4sOBNEmwujzdtgiLPrxU=;
	b=hGHRdNQ9zPnfHVpZaJ8k+YZ1sRAR5BZfur1YBe0XPP8w8wrUvlWx1W2Tqqyi4KEWR3yFiN
	YDyL5GUvVUC2DtLWPePbDj5NqLC02iwXs7d48M0FeeZehnJDQLYgkqOEbSv0oH01yQDYwP
	7r09jh5ugBmPSS9kmI/gk998G/khK3o=
Date: Wed, 6 Nov 2024 11:31:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 0/8] Fixes to bpf_msg_push/pop_data and
 test_sockmap
To: zijianzhang@bytedance.com
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, jakub@cloudflare.com, liujian56@huawei.com,
 cong.wang@bytedance.com, John Fastabend <john.fastabend@gmail.com>,
 bpf@vger.kernel.org
References: <20241024202917.3443231-1-zijianzhang@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241024202917.3443231-1-zijianzhang@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/24/24 1:29 PM, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Several fixes to test_sockmap and added push/pop logic for msg_verify_data
> Before the fixes, some of the tests in test_sockmap are problematic,
> resulting in pseudo-correct result.
> 
> 1. txmsg_pass is not set in some tests, as a result, no eBPF program is
> attached to the sockmap.
> 2. In SENDPAGE, a wrong iov_length in test_send_large may result in some
> test skippings and failures.
> 3. The calculation of total_bytes in msg_loop_rx is wrong, which may cause
> msg_loop_rx end early and skip some data tests.
> 
> Besides, for msg_verify_data, I added push/pop checking logic to function
> msg_verify_data and added more tests for different cases.
> 
> After that, I found that there are some bugs in bpf_msg_push_data,
> bpf_msg_pop_data and sk_msg_reset_curr, and fix them. I guess the reason
> why they have not been exposed is that because of the above problems, they
> will not be triggered.
> 
> With the fixes, we can pass the sockmap test with data integrity test now.
> However, the fixes to test_sockmap expose more problems in sockhash test
> with SENDPAGE and ktls with SENDPAGE.

Please carry over the Reviewed-by tag from John and usually you should cc the 
reviewers in the new revision.

Please respin and tag with "bpf-next". Thanks for reporting the CI failed to 
apply issue on v1. The bpf CI has been fixed to automatically try the 
bpf-next/net branch after failing to apply to the default bpf-next/master branch.

pw-bot: cr

