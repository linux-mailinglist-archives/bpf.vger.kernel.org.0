Return-Path: <bpf+bounces-34952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C4933ED9
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 16:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4165D2837CA
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029D518133B;
	Wed, 17 Jul 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0OfsMRU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED544180A6A;
	Wed, 17 Jul 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227891; cv=none; b=Wqm6KZbE3oCLHNZAmswpl09nYGjYHeBM/DQcsgBNEdtnGHOABJq5FZxlYnnxWVMSQ7KNlH1EgPKJKyB8Zu3Y4PzR/wu+SWIZrzz7tkSVLZgpTeSuQVCA8oMpBWloY+AI/cA7bzzQPYLEDfuv5VI+ljakT7aPOC/sYMhX4M9KFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227891; c=relaxed/simple;
	bh=5aElQ6NQm8on75otjRbfNAUFj5rE/Qw80X7CWZBYbq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRrkOKqTyjSnCzX59ktuh9a4M521tPHv+6HmFY+KEBAU3gAkCdq1YNa8LWjKcCTsRPfftLCTNStRR6U/FltwTfQPYBkB2y2UiJRW5zMCIu9t85WbA82l4Atp137plN65FWLY9LiVCz5A9CAnjoVRnrHJH9GnYTkfrr71X83Y2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0OfsMRU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8036ce66134so40137139f.3;
        Wed, 17 Jul 2024 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721227889; x=1721832689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9rCufypQzQi3mGViVF+O5wWbjvU3WJ3Ong0x55wGhc=;
        b=e0OfsMRURD/DvZxUckYEpz3jwo9fAsWNKu9Kk9IkrD3nV0WbhN5lv/zETHjjnLjMhg
         QooX4B45zJHfpck4td+uA5xwGMO/9KHaZF1ohTu5Qj2MJhGgRk7W0NmmeCWXsFryh6sA
         FrUsnEaeorXmMHEZxfgYojNxgDpD8fQ+UfCFRr5OGXLWnPp+eRKBDjUHaViBVPjk6yq1
         xOONmI+43k6IDc7ODqcev9dPyx3sgGvSQNxRnnnNoyXEmfZs8VW/29roJD/mEpuBejjo
         TvCuoBHOw53+1Gb/1+X+IsqlZuNd60JPAZ5nON1CyqiQEYowqi+XZTh1jqgBPnAkrvre
         5OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721227889; x=1721832689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z9rCufypQzQi3mGViVF+O5wWbjvU3WJ3Ong0x55wGhc=;
        b=OTvJmSStuOhC/Y1hkMefW8ll/lJOIGRGDTbR8pAeXyJYZkhyJx2oVIq1jbaKaFh1Lc
         c7XOkQ5AFkUCJ03rjok3nXCoyu2UqBa5iel5Y/aE3a2CTPYudbxyMbcvCflGsJirPOsZ
         tLh5ZM/k17Mz8yg6IjA6Mmgh/KXZ80mSMz5kkRd6pVoF0cR0fzqTgY9EDhsuKiUWcBRl
         ftx2cAyE1zThPw4ri6O0I4vocdD7aCj4yZof8rgXMqFw0y7JMhWy/vOIaKMhBcmzXw1g
         kXCbsj53/yw8RIXIbs86Wvkd21mlKoKD0dLMaHVAvSHBRa2J1527rcb5lETJEs0bemKV
         GxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP0btQ6mSbJH8hGMB80gtjACt0ntIV5UjquGfckNcPfO0lgigArBz5sOOboEnYLUDo3CcLPr5ZhNCGBtS4Ln8j3kn0Ba213OwSgFC5soZV1uB36MWjKGFcLGtfeyY5sYwD
X-Gm-Message-State: AOJu0Yz6D5NGVMTRd7M0wmYv7Tu2JJr64blWKJWTTwtO6THo77kIDSwQ
	kcNOPjsqJL11WqoGaIQkBFYxGb5opioBsRBdTq8xVKUUEgmQeuFVmjrmGg==
X-Google-Smtp-Source: AGHT+IFVagRdXtnzk/L3PmRIBcMIpFdQG9XkHPXrLVFeHo0Ylo4l09OknxL2+81GV1a88g5IbZFXFg==
X-Received: by 2002:a5d:8610:0:b0:7fb:86c:321 with SMTP id ca18e2360f4ac-81710040e4dmr228123839f.1.1721227888654;
        Wed, 17 Jul 2024 07:51:28 -0700 (PDT)
Received: from [192.168.0.107] ([117.147.31.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c974sm8501524b3a.10.2024.07.17.07.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:51:28 -0700 (PDT)
Message-ID: <ae8d45ac-b39d-46b5-8010-2cfe3cceff27@gmail.com>
Date: Wed, 17 Jul 2024 22:51:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 1/3] bpftool: add net attach/detach command
 to tcx prog
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715113704.1279881-1-chen.dylane@gmail.com>
 <20240715113704.1279881-2-chen.dylane@gmail.com>
 <0284ae6e-0187-4a72-a855-ba1afeb9af2e@kernel.org>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <0284ae6e-0187-4a72-a855-ba1afeb9af2e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/7/17 01:23, Quentin Monnet 写道:
> 2024-07-15 12:37 UTC+0100 ~ Tao Chen <chen.dylane@gmail.com>
>> Now, attach/detach tcx prog supported in libbpf, so we can add new
>> command 'bpftool attach/detach tcx' to attach tcx prog with bpftool
>> for user.
>>
>>   # bpftool prog load tc_prog.bpf.o /sys/fs/bpf/tc_prog
>>   # bpftool prog show
>> 	...
>> 	192: sched_cls  name tc_prog  tag 187aeb611ad00cfc  gpl
>> 	loaded_at 2024-07-11T15:58:16+0800  uid 0
>> 	xlated 152B  jited 97B  memlock 4096B  map_ids 100,99,97
>> 	btf_id 260
>>   # bpftool net attach tcxingress name tc_prog dev lo
>>   # bpftool net
>> 	...
>> 	tc:
>> 	lo(1) tcx/ingress tc_prog prog_id 29
>>
>>   # bpftool net detach tcxingress dev lo
>>   # bpftool net
>> 	...
>> 	tc:
>>   # bpftool net attach tcxingress name tc_prog dev lo
>>   # bpftool net
>> 	tc:
>> 	lo(1) tcx/ingress tc_prog prog_id 29
>>
>> Test environment: ubuntu_22_04, 6.7.0-060700-generic
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/bpf/bpftool/net.c | 52 ++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
>> index 968714b4c3d4..be7fd76202f1 100644
>> --- a/tools/bpf/bpftool/net.c
>> +++ b/tools/bpf/bpftool/net.c
>> @@ -67,6 +67,8 @@ enum net_attach_type {
>>   	NET_ATTACH_TYPE_XDP_GENERIC,
>>   	NET_ATTACH_TYPE_XDP_DRIVER,
>>   	NET_ATTACH_TYPE_XDP_OFFLOAD,
>> +	NET_ATTACH_TYPE_TCX_INGRESS,
>> +	NET_ATTACH_TYPE_TCX_EGRESS,
>>   };
>>   
>>   static const char * const attach_type_strings[] = {
>> @@ -74,6 +76,8 @@ static const char * const attach_type_strings[] = {
>>   	[NET_ATTACH_TYPE_XDP_GENERIC]	= "xdpgeneric",
>>   	[NET_ATTACH_TYPE_XDP_DRIVER]	= "xdpdrv",
>>   	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
>> +	[NET_ATTACH_TYPE_TCX_INGRESS]	= "tcxingress",
>> +	[NET_ATTACH_TYPE_TCX_EGRESS]	= "tcxegress",
> 
> 
> Hi, thanks for this work!
> 
> I wonder whether "tcx_ingress" and "tcx_egress" might be more readable?
> I know we don't have underscores for XDP types but I'd be tempted to add
> it for the tcx types, what do you think?
> 
> 
Hi，Quentin，thanks for your reply!
You are right, tcx_* looks more readable, i will change it in v2.
>>   };
>>   
>>   static const char * const attach_loc_strings[] = {
>> @@ -647,6 +651,32 @@ static int do_attach_detach_xdp(int progfd, enum net_attach_type attach_type,
>>   	return bpf_xdp_attach(ifindex, progfd, flags, NULL);
>>   }
>>   
>> +static int get_tcx_type(enum net_attach_type attach_type)
>> +{
>> +	int type = 0;
>> +
>> +	if (attach_type == NET_ATTACH_TYPE_TCX_INGRESS)
>> +		type |= BPF_TCX_INGRESS;
>> +	else if (attach_type == NET_ATTACH_TYPE_TCX_EGRESS)
>> +		type |= BPF_TCX_EGRESS;
> 
> 
> Why the logical OR in this function? This seems to be copied from the
> XDP code, where we need to set flags. Here we just need the type, if I
> remember correctly, so we could have:
> 
> 	switch (attach_type) {
> 	case (NET_ATTACH_TYPE_TCX_INGRESS):
> 		return BPF_TXC_INGRESS;
> 	case (NET_ATTACH_TYPE_TCX_EGRESS):
> 		return BPF_TCX_EGRESS;
> 	}
> 
> (or if/else, works as well) which would be easier to understand in my
> opinion.
> 
It seems more reasonable, i will change it in v2.
>> +
>> +	return type;
>> +}
>> +
>> +static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex)
>> +{
>> +	int type = get_tcx_type(attach_type);
>> +
>> +	return bpf_prog_attach(progfd, ifindex, type, 0);
>> +}
>> +
>> +static int do_detach_tcx(int targetfd, enum net_attach_type attach_type)
>> +{
>> +	int type = get_tcx_type(attach_type);
>> +
>> +	return bpf_prog_detach(targetfd, type);
>> +}
>> +
>>   static int do_attach(int argc, char **argv)
>>   {
>>   	enum net_attach_type attach_type;
>> @@ -694,6 +724,15 @@ static int do_attach(int argc, char **argv)
>>   		goto cleanup;
>>   	}
>>   
>> +	/* attach tcx prog */
>> +	if (is_prefix("tcx", attach_type_strings[attach_type]))
>> +		err = do_attach_tcx(progfd, attach_type, ifindex);
>> +	if (err) {
>> +		p_err("interface %s attach failed: %s",
>> +		      attach_type_strings[attach_type], strerror(-err));
>> +		goto cleanup;
>> +	}
> 
> 
> This introduces a second check on "err" in the function: if we attach an
> XDP program we'll try to attach then check "err" twice. Same for a TCX
> program, we'll check "err" before even trying to attach.
> 
> I understand this replicates what we do for XDP, but I'm not sure the
> sequential calls to 'is_prefix("...")' is the cleanest approach. We
> should probably change the XDP case a bit and integrate with TCX better.
> Expanding the different attach types is more verbose, but remains the
> most straightforward way in my opinion.
> 
> 	switch (attach_type) {
> 	case NET_ATTACH_TYPE_XDP:
> 	case NET_ATTACH_TYPE_XDP_GENERIC:
> 	case NET_ATTACH_TYPE_XDP_DRIVER:
> 	case NET_ATTACH_TYPE_XDP_OFFLOAD:
> 		err = do_attach_xdp(...);
> 		break;
> 	case NET_ATTACH_TYPE_TCX_INGRESS:
> 	case NET_ATTACH_TYPE_TCX_EGRESS:
> 		err = do_attach_tcx(...);
> 		break;
> 	}
> 
> 	// Single check on "err" for both XDP and TCX here;
> 	// Or moving it to the switch statement if checks/error messages
> 	// needed to be different, but that's not the case in your patch
> 	if (err) {
> 		p_err(...);
> 		goto cleanup;
> 	}
> 
> 
My bad, i will add another patch to refactor this as you say.
>> +
>>   	if (json_output)
>>   		jsonw_null(json_wtr);
>>   cleanup:
>> @@ -732,6 +771,16 @@ static int do_detach(int argc, char **argv)
>>   		return err;
>>   	}
>>   
>> +	/* detach tcx prog */
>> +	if (is_prefix("tcx", attach_type_strings[attach_type]))
>> +		err = do_detach_tcx(ifindex, attach_type);
>> +
>> +	if (err < 0) {
>> +		p_err("interface %s detach failed: %s",
>> +		      attach_type_strings[attach_type], strerror(-err));
>> +		return err;
>> +	}
> 
> 
> Same here.
> 
> Got it.
>> +
>>   	if (json_output)
>>   		jsonw_null(json_wtr);
>>   
>> @@ -928,7 +977,8 @@ static int do_help(int argc, char **argv)
>>   		"       %1$s %2$s help\n"
>>   		"\n"
>>   		"       " HELP_SPEC_PROGRAM "\n"
>> -		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }\n"
>> +		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload | tcxingress\n"
>> +		"			| tcxegress}\n"
> 
> 
> Please use spaces only for indent inside of the string, and add a space
> before the ending '}'.
> 
> 
ok, i will fix this.
>>   		"       " HELP_SPEC_OPTIONS " }\n"
>>   		"\n"
>>   		"Note: Only xdp, tcx, tc, netkit, flow_dissector and netfilter attachments\n"
> 

-- 
Best Regards
Dylane Chen


