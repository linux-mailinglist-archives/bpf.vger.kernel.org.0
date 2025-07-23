Return-Path: <bpf+bounces-64160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B230FB0F065
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 12:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321A93A149D
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F101C2DECBB;
	Wed, 23 Jul 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beB2H1SN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63748279327;
	Wed, 23 Jul 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267837; cv=none; b=iatd3knwYO6n5R8iymnKas6A1fr+ZZZHk+eBYr/Ci7yU143zGpvAXIp6zolT3+eHfp3/vDgzWBEyJfhAPA68TP2GNg1LWRfiJ2AqJnIJAqQ94/iWmRN7QPb+P40Pu0dkqdrtAXp+4r+3bByDJxWLoT1Hr3yz1G6S/DGLvb5VGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267837; c=relaxed/simple;
	bh=+7U/XbRB5FPTa99oy/KCh6Z6mrxWRz6MpFm/ujghB0o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o29za3lhMxVPESTbzzosIf3Py6Ayplk6xyqhZF2D0Zi/pEHeUeJTjI7tpcWiIkDX5v8+F6kyhTkXbsU1rMbCaP5YQSEymO7K0LP6OlExOy//FW7xzEUN+yGnT1bZTmNr9E9LYL/Mzpw7L9BP+XVXI1Fj7fMBtjgzJarLgFezqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beB2H1SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89A9C4CEF5;
	Wed, 23 Jul 2025 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753267835;
	bh=+7U/XbRB5FPTa99oy/KCh6Z6mrxWRz6MpFm/ujghB0o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=beB2H1SNmOswraWKSFQFSqG3iC61n05JQXqJUx6h4P+3ZX2f6imU0iiO7nQIWEOh0
	 4ztEEvEF0NHBjhEDgijPiNEoU9sPUdaHaMUcJ+3iN7GpXp3Pd5Ce4AjiJGGT7fESyq
	 zRi73t5j4ai7Y6l0fMVsT56UMctrqkqO2jMVH5OYGLkkTWtjs9A85T9F80gRlntSs7
	 09ULcA9r3c3B/I6cbRQyh1nuWX3pfrrzvQ1Wl6Rew2v7b+IJ+CAIZKZwiYQ+3Iuk5m
	 /k59eEKr3S2dJBq11DAZ+zfc4biVckpXR+V7x7eTWCAJz72fCPSdZ1oI9El3kTkK+0
	 61HejS9Jl9kUQ==
Message-ID: <bf0c416f-5384-4c22-99de-bfef9ba3da03@kernel.org>
Date: Wed, 23 Jul 2025 11:50:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Add bpf_token show
From: Quentin Monnet <qmo@kernel.org>
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250723033107.1411154-1-chen.dylane@linux.dev>
 <1dd1a433-ecdf-437d-bc71-6d1b65b74cc8@kernel.org>
Content-Language: en-GB
In-Reply-To: <1dd1a433-ecdf-437d-bc71-6d1b65b74cc8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-23 11:40 UTC+0100 ~ Quentin Monnet <qmo@kernel.org>
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
>     $ ./bpftool token help
>     Usage: bpftool token { show | list }
>             bpftool token help
> 
> The two "bpftool" should be aligned. This is because you use a tab for
> indent on the "help" line. Can you please replace it with spaces to fix
> indentation, and remain consistent with what other files do?
> 
> After that change, you can add:
> 
>     Reviewed-by: Quentin Monnet <qmo@kernel.org>
> 


Please also take a look at the "CHECK" reports from checkpatch, some of
them are worth addressing:

https://netdev.bots.linux.dev/static/nipa/984952/14165722/checkpatch/stdout

(accessed via
https://patchwork.kernel.org/project/netdevbpf/patch/20250723033107.1411154-1-chen.dylane@linux.dev/)

Thanks,
Quentin

