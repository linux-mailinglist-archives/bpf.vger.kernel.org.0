Return-Path: <bpf+bounces-64077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF7AB0E156
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB9D1C81780
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0EB27A47E;
	Tue, 22 Jul 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XxBLjvhf"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A21E5B69
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200669; cv=none; b=QK4HVdUL2VBxAsTEaqRqQjOJoILaNKL+dXoKGGvTX2/GjW6KIn8rj3ot6n7aOdDxO+BsgGEm3/32vYQVU1QZOKUgUrKo5CbZlM1PFO+tPlpaT8S4tR8GuqkQ9X/qNXPvkMj/DyeFL/REhaU0Z4grIcASfQ9XuFhuElJ4BW7uFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200669; c=relaxed/simple;
	bh=yzgMOc1JqPvse/2WCjNPKlC8bdQPxErL7KFyqlOB8RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Suj9FKOS8nUV9ZSBbv0e1yVOqF7zCvn2sofr4No13G2Ap5l4X42WhnCef2T89pT4+klt61wF0g1tj6gZEFGbZK06SiU+QCpp5pAzLHftbf0qB4FBkCHvih6dafQVSVNbPfEY5/181ryL9EMcLLD8eRJH9eRClEtTFj7K2YBu9vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XxBLjvhf; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dbc46a1a-9363-4ef7-ae70-d02fca6ecd37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753200666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ2Wt/wnzLVk2kOpzHZkebHiwy8smKpH0cZX7371W9M=;
	b=XxBLjvhfL+sLo0qId3z5iZM8W5TwjKDDKi+M8gxV64bl86GGoEXgbJ10KM4o04Kdm40ph7
	pnwj4kchOBRBvUVsBJ8ICTdHwvK2hajM00+FyM8pTH3LpgbMmGgqwm+chGikUxIqunTd3/
	2RL9Hi5Rou6ELHix7LcfEJxvWIUedB0=
Date: Wed, 23 Jul 2025 00:10:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpftool: Add bpf_token show
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250722115815.1390761-1-chen.dylane@linux.dev>
 <4dcd2d25-5955-4364-9b6a-42d66dee0a6b@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <4dcd2d25-5955-4364-9b6a-42d66dee0a6b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/22 23:01, Quentin Monnet 写道:
> 2025-07-22 19:58 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
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
>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>> new file mode 100644
>> index 00000000000..f72a116f9c6
>> --- /dev/null
>> +++ b/tools/bpf/bpftool/token.c
> 
>> +static int show_token_info(void)
>> +{
>> +	FILE *fp;
>> +	struct mntent *ent;
>> +	bool hit = false;
>> +
>> +	fp = setmntent(MOUNTS_FILE, "r");
>> +	if (!fp) {
>> +		p_err("Failed to open: %s", MOUNTS_FILE);
>> +		return -1;
>> +	}
>> +
>> +	if (json_output)
>> +		jsonw_start_array(json_wtr);
>> +
>> +	while ((ent = getmntent(fp)) != NULL) {
>> +		if (strncmp(ent->mnt_type, "bpf", 3) == 0) {
>> +			if (has_delegate_options(ent->mnt_opts)) {
>> +				__show_token_info(ent);
>> +				hit = true;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (json_output)
>> +		jsonw_end_array(json_wtr);
>> +
>> +	if (!hit)
>> +		p_info("Token info not found");
> 
> Woops I take this one back. It made sense to have a p_info() message in
> your v1 because you were only looking at one bpffs mount point, but now
> we list all the ones we find, we should remove this message and silently
> ignore mount points without token info (and I think we can remove the
> "hit" variable entirely). Sorry! :)
> 

It‘s okay, i will remove it in v3, thanks anyway.

> The rest of this patch looks good to me, thank you
> 
> Quentin


-- 
Best Regards
Tao Chen

