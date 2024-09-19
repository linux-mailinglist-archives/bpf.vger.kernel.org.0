Return-Path: <bpf+bounces-40076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BECB97C2DE
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 04:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DA028387C
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B633F10A19;
	Thu, 19 Sep 2024 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rP6DyHue"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06619320F
	for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714279; cv=none; b=VWan04k/X9cQPfnEQ+aryJOyvhvcK+PA1vBMxIKWenTXW4aVOkf6qqkoYPxBQX5lA0H7t9nMu/38OJPmJnucHExUT1erwbNlMOZ8MMpykKJYcCUerY4ofGGxDpd1SXtKjwo9xlHkqmv4GFmcMwzRNwQ1NNKYF1Y62vBsgVQVCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714279; c=relaxed/simple;
	bh=OSiXU/+uvfsndAGcFPqZZE4BYZtgOY+nJK8DCuyP7DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLnFNYmZmu2HbTnUCUDVXpXE+vs5MJeq9stNe14kZEcfbwn+uXJkU+DUJsTDShODiqluUYnmlw2rqr9FQw5oJvSYqYYDshPgom0u0i7UkfvcY+NIccW+DorSh2KdfYP98v30J/f5oLbv3sB/Sl6aypSOx71Jw9UE0OVWxfAcHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rP6DyHue; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726714269; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u5hc43kSFa07ghw0F9OCsqek5rY4RBziETZio6OaaW0=;
	b=rP6DyHueAblBf0BSxwLj/CImmMu1FmPS8ZGT05w0VCQMbmg3fNT38Rh9crGH0Q3WzW/EMiYqqbF1UY+c6MeSAadsnBn6Xhv+FNOLbu1dUV/uOyjqFdiNNIFzF/pirocz7PFWPkBYvau20RkdC/GsNeZ4ViM0egei+/SuRUlO8Kc=
Received: from 30.221.128.108(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WFG3hml_1726714268)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 10:51:08 +0800
Message-ID: <2a5997cd-ef30-42e6-b89b-6a1841e0c822@linux.alibaba.com>
Date: Thu, 19 Sep 2024 10:51:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: emit top frequent code lines
 in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Mykyta,

On 2024/9/19 04:39, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Production BPF programs are increasing in number of instructions and states
> to the point, where optimising verification process for them is necessary
> to avoid running into instruction limit. Authors of those BPF programs
> need to analyze verifier output, for example, collecting the most
> frequent source code lines to understand which part of the program has
> the biggest verification cost.
> 
> This patch introduces `--top-src-lines` flag in veristat.
> `--top-src-lines=N` makes veristat output N the most popular sorce code
> lines, parsed from verification log.
> 
> An example:
> ```
> $ sudo ./veristat --log-size=1000000000 --top-src-lines=4  pyperf600.bpf.o
> Processing 'pyperf600.bpf.o'...
> Top source lines (on_event):
>   4697: (pyperf.h:0)	
>   2334: (pyperf.h:326)	event->stack[i] = *symbol_id;
>   2334: (pyperf.h:118)	pidData->offsets.String_data);
>   1176: (pyperf.h:92)	bpf_probe_read_user(&frame->f_back,
> ...
> ```

I think this is useful and wonder how can I use it. In particular, is it 
possible to know the corresponding instruction number contributed by the 
source lines?

Assume a prog is rejected due to instruction limit. I can optimize the 
prog with `--top-src-lines`, but have to check the result with another 
"load" to see the total instruction number (because I don't know how 
many instructions reduced with the optimized src lines).

Am I right? or is there any better method?

Thanks.
-- 
Philo


