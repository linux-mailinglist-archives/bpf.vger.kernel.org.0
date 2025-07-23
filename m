Return-Path: <bpf+bounces-64161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75550B0F075
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 12:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5BB5673F4
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F582D3EF6;
	Wed, 23 Jul 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4Ucak01"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDD27145D
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268151; cv=none; b=RQjHATObgZHoU7Zy1rL72mXpprv0j6ESt54hYrvZLgPRKLwPohv95iQG7uudaVm4/RcKcX5RrooJYQ8sP+IuOSLOUYVPDtgURPIzCw0Aay+ouzZtRzId4y82eWQlFIF3WE+/lF/BJph/SDUPxPm2Q/WzxDd+B4fo+Ufy1Ap3vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268151; c=relaxed/simple;
	bh=m43EYY6q+XvOfeXV3GPp4XFcqABOWCC0aWg0XAAXamM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCaG2iLVo8xmTjE0f+Sn9fGDvqYAHTyXM8wVWv6UzFz+m6yjTkj1Yy9SLg4bHKMookTt3MrrCTttrEBtFUqAS4C8hUGLhj7RhkJv4yfECT3zBoxZ/OYn4IwjW5Hjtmgp3Ft7jHYRw4q4Zy1Kv+kx7iazoRZx/o7o+mI2dS3Dqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S4Ucak01; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <393b7e0e-2240-49c5-9ff7-8efa07a11d3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753268136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYI4IOaiJ64Vf6dp+PDO/cqw+3AhfpJbd/gGnQR4Krs=;
	b=S4Ucak01dKys0gBZgwAJY0O/HeDXEdpglcJx9M10oPvLNUmZwQxFY9YeCJ21xWHJ9esC7k
	ZgWO0NhpOTWh7nOCsapziZDvN1pYsjnKm6a/2MHCihuxR07Y9uiMAjgSejnLMbu+fnCiP2
	WBQjgB5I5O1icPeJG4STrEioJ44ax3c=
Date: Wed, 23 Jul 2025 18:55:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Add bpf_token show
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250723033107.1411154-1-chen.dylane@linux.dev>
 <1dd1a433-ecdf-437d-bc71-6d1b65b74cc8@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <1dd1a433-ecdf-437d-bc71-6d1b65b74cc8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/23 18:40, Quentin Monnet 写道:
> 2025-07-23 11:31 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> Add `bpftool token show` command to get token info
>> from bpffs in /proc/mounts.
>>
>> Example plain output for `token show`:
>> token_info  /sys/fs/bpf/token
>> 	allowed_cmds:
>> 	  map_create          prog_load
>> 	allowed_maps:
>> 	allowed_progs:
>> 	  kprobe
>> 	allowed_attachs:
>> 	  xdp
>> token_info  /sys/fs/bpf/token2
>> 	allowed_cmds:
>> 	  map_create          prog_load
>> 	allowed_maps:
>> 	allowed_progs:
>> 	  kprobe
>> 	allowed_attachs:
>> 	  xdp
>>
>> Example json output for `token show`:
>> [{
>> 	"token_info": "/sys/fs/bpf/token",
>> 	"allowed_cmds": ["map_create", "prog_load"],
>> 	"allowed_maps": [],
>> 	"allowed_progs": ["kprobe"],
>> 	"allowed_attachs": ["xdp"]
>> }, {
>> 	"token_info": "/sys/fs/bpf/token2",
>> 	"allowed_cmds": ["map_create", "prog_load"],
>> 	"allowed_maps": [],
>> 	"allowed_progs": ["kprobe"],
>> 	"allowed_attachs": ["xdp"]
>> }]
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
> 
> [...]
> 
>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>> new file mode 100644
>> index 00000000000..06b56ea40b8
>> --- /dev/null
>> +++ b/tools/bpf/bpftool/token.c
> 
> [...]
> 
>> +static int do_help(int argc, char **argv)
>> +{
>> +	if (json_output) {
>> +		jsonw_null(json_wtr);
>> +		return 0;
>> +	}
>> +
>> +	fprintf(stderr,
>> +		"Usage: %1$s %2$s { show | list }\n"
>> +		"	%1$s %2$s help\n"
> 
> 
> One more nit: applying and testing the help message locally, I noticed
> that the alignement is not correct:
> 
>      $ ./bpftool token help
>      Usage: bpftool token { show | list }
>              bpftool token help
> 
> The two "bpftool" should be aligned. This is because you use a tab for
> indent on the "help" line. Can you please replace it with spaces to fix
> indentation, and remain consistent with what other files do?
> 

Thanks for your testing, i will fix it, thanks again.

> After that change, you can add:
> 
>      Reviewed-by: Quentin Monnet <qmo@kernel.org>


-- 
Best Regards
Tao Chen

