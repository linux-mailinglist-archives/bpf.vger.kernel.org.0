Return-Path: <bpf+bounces-27495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B1D8ADB57
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 02:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A401C21122
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 00:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D4E576;
	Tue, 23 Apr 2024 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rnUpWbLO"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8B2C9D
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833930; cv=none; b=diIdBQlGJJ0RbpAtgiM68PwkCuVSwcpQitbntI6SuOXwVFn/nKMxRGxYokx4G5nDVbJhnpMd8rj1m5qCZBWpk+qb9bEDWmVvVmX+UHXKMof2Xdh6rryDV4Sy+ssbtrdjBQVNPe5nNzVV/MiW6zuJxZoU6XKs/9igRbd/ZVcnt5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833930; c=relaxed/simple;
	bh=fu2lGIuP5SRVAnE/ZcD/RzQ4Dm2nPlMBR59X5aUtDBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGhflcEOcGxBJ4EkPPlNdmZSBN/I1UFX46nzTKJpS6AaXawvZ0aO0QdDGNg934UKtp75S1KtSMVCWkoMr/3buOSJhVRAQE9f/jyNanDtvrqf4o8h0KVdxvQ0CrOyZ7DdG5hK/Yrk4a5YVWxtsn9BnwiCnjE8ubBIiDlryFl739M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rnUpWbLO; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713833925; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=op1BDD/rLzu9RJ1XlBzPQbzfn7yhzD5ZribYjviIp20=;
	b=rnUpWbLOc2kDCIHO9FDZpRW6prjBtpbaJ9QtCZwADcEN/0XkxQoHLA5Ac5j1NlIi/+IC0UeNoHeV+Gu9W/QZYX6myasSZ8slDGjVUJ35pcy4dkmcIVFuFfgY1kQRDXWO3pzjOckNXEK9P5IlBofgAsmkKYIihpoHFjW6ba5N448=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W56wtV1_1713833923;
Received: from 30.221.128.133(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W56wtV1_1713833923)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 08:58:44 +0800
Message-ID: <19614ca4-d905-4562-a528-9766021d4ee2@linux.alibaba.com>
Date: Tue, 23 Apr 2024 08:58:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: add mrtt and srtt as BPF_SOCK_OPS_RTT_CB
 args
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 laoar.shao@gmail.com, fred.cc@alibaba-inc.com, xuanzhuo@linux.alibaba.com
References: <20240421042440.33125-1-lulie@linux.alibaba.com>
 <ZibuF9_INOxYUVch@google.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <ZibuF9_INOxYUVch@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/23 07:09, Stanislav Fomichev wrote:
> On 04/21, Philo Lu wrote:
>> Two important arguments in RTT estimation, mrtt and srtt, are passed to
>> tcp_bpf_rtt(), so that bpf programs get more information about RTT
>> computation in BPF_SOCK_OPS_RTT_CB.
>>
>> The difference between bpf_sock_ops->srtt_us and the srtt here is: the
>> former is an old rtt before update, while srtt passed by tcp_bpf_rtt()
>> is that after update.
> 
> Can you also extend the rtt selftest to exercise there new numbers?
> Something simple like making sure they are non-zero should be enough.

Of course. I will add it in next version.

Thansk.

