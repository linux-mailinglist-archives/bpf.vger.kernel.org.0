Return-Path: <bpf+bounces-51247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D401A32513
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 12:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B673A500B
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E226420ADC7;
	Wed, 12 Feb 2025 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="YwG/L8Zm"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE420ADD5;
	Wed, 12 Feb 2025 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360087; cv=none; b=siCYMA1n51Em8JpuTHk/OPKf+2BJQdKTqKV+hgtcj05uF626BKLGq0Sc1B7URS1s8B01G3rtKb3hMBRtXbxdvA5J+boVTj0OL/8+iBFpDhwSHdn95WSYZMZDOS4sQG+FpYJ65mM41o276ax9pPmTgNUBqD/GwYruCWZfCI7Sv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360087; c=relaxed/simple;
	bh=qs5Wg9SnP8mEJT2fiF2C/Eoai2zy1zMKwiASuaSkzfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvCwskpvMqggmlIlgyZoQSQVV/y69QBAjFBp0NQWbhF8+YWXkNqwk9YzRZNWi1NVvN9F9WAH573oIz3qJwEGJjSVbjpU88vVdoCXDBTLYeRx4hfeK5KRR8k6f1TR7eEaUZDcQ8tG0/dsnkpe0toDzSW3H6oDwxnqBGg+JgVwtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=YwG/L8Zm; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739360073;
	bh=nwRHhE+bRUftoQ1/jLksgCEVYIY2pDq9KLzXdnmSp3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YwG/L8ZmeCT1ABjP14ZLErvxv4AVAr54R1I5ErwTsbPguAwKy86WG5Mo6tntX/t/c
	 HvOjHwRvVTg0nRyubK4lSuH3XBdtlYI2sPXr+sAF1r2yuLtYjKmmcckH9+1tuO+hYZ
	 hpARMqCKZV41+RYyWXLoYmuHWalWizgl74QzaXR8=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 57BBE49D; Wed, 12 Feb 2025 19:21:59 +0800
X-QQ-mid: xmsmtpt1739359319t3ljxopxl
Message-ID: <tencent_1256C865894AC1EBCFA804628181A1105A06@qq.com>
X-QQ-XMAILINFO: NEq0i4SycP3baJ3pc8FIBFkmo5DKSXBnhJ8IAkxguBuES4K9CeJ8ynh7lxBtj4
	 tdOwlx9sX6oq5tHvYLDd/ES6Pt4C9UDhlczptCubyPfaFoTzc4Eg0Pbla4UQLdPpYi6uRDFmzC6Z
	 I5lFtBu0LsMURqpGTUHRJ9WX7PtFFrGe5iPRgAGglw3NEST+8Fc1t9ww6HZ5rALAlfMZaeqEe5Rd
	 /yJzlYAY6P8p+ABuYOcMCU5Qu/EnpY1VTjI+3qevPj/Knr4oMEV8I2rW0rCIrPQsR48c6LozFKc7
	 gPImMSd8FcbT/k1gCFV1L+5ucilrzovCWg7lYz8bIiol2MxAYHohw7Hto7agYCxfnnRLDtOMxpPP
	 J3tJU0IR4yo7RomTzSRlR3usmUnupnwzsvk4XprcZS9wvWMPwXna5p5rw+J7lb2q9dKp8XfkKT5X
	 lOE6dKpPQqOzd0+B8XQ1X7tAqiaSp+mtsx9JYmr6sOqi/xgegv3pyEP2w9tN09OFG943XBQym/Xw
	 LFCNLs5umM5CtHEdHhfa4HsmCLmsXfepDm5eYXs7xE6rMqeCa7lxm0+T6OZ1+MzuWMlJhmA/Fc/b
	 74046CBWl/ZFQwiWaSC4iMP9BCbdcsT/zBp8Ez2UV8Ga10T6Jg+56AqsTTiNw/FqnydWYpuZJwyh
	 2MaI7s7Km9r4fmgia7Rh3qnfFpAZeki81pheJMYIFAl2ElxdU3me8RSJ0vulFc12wqpNeifHKW7s
	 frp6x0mx0edY4H9Aedm39D6ibdbhm2tq2OPKs9f+fM9qU7W9IlmwZxKy4KG5uHhvVqulNnqqEVaQ
	 W+r80A+4QZfdNKAJgU1jVnjOx+hUO8kfCdQNAX2bogMtoVUwTA7iu1siVOVzkhijVoUgu10/5Uyc
	 XdXq7kUNDaa4wJ8i6R/KtEVzfuV52ohHH3IMSbnHX3xWj9/Mecqfo86W/I3RfLwz7u6phfVZp8Cl
	 HCzHCuhxo=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <0ee5dea2-591d-4a3f-b785-e2ebf21802a2@foxmail.com>
Date: Wed, 12 Feb 2025 19:21:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: bash-completion: Add nopasswd sudo
 prefix for bpftool
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: rongtao@cestc.cn, Rong Tao <rongtao@cestc.cn>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Tao Chen <chen.dylane@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>, Daniel Xu <dxu@dxuuu.xyz>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_515567355C0AA854BDA68C3A219A18040B0A@qq.com>
 <97fd1bbb-1261-4af5-9321-27353547dbf7@kernel.org>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <97fd1bbb-1261-4af5-9321-27353547dbf7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/12/25 19:00, Quentin Monnet wrote:
> 2025-02-12 18:14 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> In the bpftool script of bash-completion, many bpftool commands require
>> superuser privileges to execute. Otherwise, Operation not permission will
>> be displayed. Here, we check whether ordinary users are exempt from
>> entering the sudo password. If so, we need to add the sudo prefix to the
>> bpftool command to be executed. In this way, we can obtain the correct
>> command completion content instead of the wrong one.
>>
>> For example, when updating array_of_maps, the wrong 'hex' is completed:
>>
>>      $ sudo bpftool map update name arr_maps key 0 0 0 0 value [tab]
>>      $ sudo bpftool map update name arr_maps key 0 0 0 0 value hex
>>
>> However, what we need is "id name pinned". Similarly, there is the same
>> problem in getting the map 'name' and 'id':
>>
>>      $ sudo bpftool map show name [tab] < get nothing
>>      $ sudo bpftool map show id [tab]   < get nothing
>>
>> This commit fixes the issue.
>>
>>      $ sudo bpftool map update name arr_maps key 0 0 0 0 value [tab]
>>      id      name    pinned
>>
>>      $ sudo bpftool map show name
>>      arr_maps         cgroup_hash      inner_arr1       inner_arr2
>>
>>      $ sudo bpftool map show id
>>      11    1383  4091  4096
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> Hi, thanks for the patch.
>
> I agree it's annoying to have a partially-working completion for
> non-root users, however, I don't feel very comfortable introducing calls
> to "sudo" in bash completion, without the user noticing. For what it's
> worth, I searched other bash completion files (from
> https://github.com/scop/bash-completion/) and I can't find any of them
> running sudo to help complete commands, so it doesn't seem to be
> something usual in completion. I think I'd rather keep the current state
> (or fix the first example to have the right keywords displayed but
> without running sudo).

Thanks for the reply.

Using sudo to perform bash-completion is indeed not a perfect solution. 
However, using "bpftool map show" to obtain map information may be the 
only way, and this operation requires CAP_ADMIN, which may be a 
compromise. There is no other way.

Rong Tao



