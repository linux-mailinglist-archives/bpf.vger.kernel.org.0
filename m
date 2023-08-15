Return-Path: <bpf+bounces-7845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7877D4C3
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 23:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F23C1C20E04
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033118B14;
	Tue, 15 Aug 2023 21:04:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AFA17FEA
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 21:04:16 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5261FDD
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 14:04:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso5733835276.2
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692133445; x=1692738245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AvILb4VSSYcxbHuZE2dmL1cPxsXggzq/wD0ZAAG09s=;
        b=cLuSebsukiUAKZ29eWTXpJj9Ds6ZMX1/T21TXDa87387fAnndiarTYbbko5TeXQghM
         AXQ+DOVY8P4lJA+YU2Jqf4n/tk9dMVLO5AXKp0Es4Qo5fVrPjf4ZjPDHmE51OVC4IJ4I
         RO/PHDc74L4YOPi+kitsXFzWveiL1K5jyLTBFulL89TydZBiyPTK4ICdcAiy0vv8Dzz6
         X3wBV0Y/WLzmLKG/goixQeg1hnyhMp7+3Qo8VHPexfDVz89ReTfjn4+DLHU0AwAFFeGJ
         xbllV3yzHQcjkeLPFj1CB1URCE7pupITGpWQNVt4pnTLf25m0EzFBRYt3KAFU9vvFd10
         vY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133445; x=1692738245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9AvILb4VSSYcxbHuZE2dmL1cPxsXggzq/wD0ZAAG09s=;
        b=Aw9wbWBLlzg3QlmH1pSOhXOSn9+dpBgqosfpf5IMXgemHf9VH491lLhMzhM12dZoVZ
         Z0vqACOlaQWo4ifcDUWzHpRWcAELEviGJ645g38Q8FCnTkSALSwaZLexbsiaPQqxoRJH
         KsvoQxy5fJ6qHF2jGnXoCR6Mq4fRAvV3rai4ja/XEGmuzq2fyjcxpGRf2PJ3XUmiGKo5
         PytS8tLi6rgj463gwTGa0xRb4SZiNzgKibqpRPE16Uz2sUuGqUtxh063r5iZpK3nuzlp
         zTXQmRTCuNx+lL/MqBEuvjhW6+Hx+FcDBYTCJI5T28NzpysywvVAn1FAirO7ias0++6/
         +qXg==
X-Gm-Message-State: AOJu0YyzOmwuxslvUecp4aqsH5DCCuZlQVTqiK7PWijCmpMxOdqwUVyz
	rfDdTN4zghpqSCPnvlRUy90=
X-Google-Smtp-Source: AGHT+IHYGtzxm/IcxQ4qGTvZLV66EdzzuJ4wxctY3LTuYocsnOro/jn/t27w0jef1MAy894BBo+9yA==
X-Received: by 2002:a25:293:0:b0:d62:bacb:4122 with SMTP id 141-20020a250293000000b00d62bacb4122mr16154783ybc.3.1692133445625;
        Tue, 15 Aug 2023 14:04:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d686:9541:9913:97aa? ([2600:1700:6cf8:1240:d686:9541:9913:97aa])
        by smtp.gmail.com with ESMTPSA id x8-20020a5b0808000000b00babcd913630sm1123823ybp.3.2023.08.15.14.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 14:04:05 -0700 (PDT)
Message-ID: <b54d513e-5bd5-4bbb-856b-d6f4673f25b7@gmail.com>
Date: Tue, 15 Aug 2023 14:04:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v3 1/5] bpf: enable sleepable BPF programs attached
 to cgroup/{get,set}sockopt.
To: Stanislav Fomichev <sdf@google.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 yonghong.song@linux.dev, kuifeng@meta.com
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-2-thinker.li@gmail.com> <ZNvm9/P1NJ6mecI7@google.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZNvm9/P1NJ6mecI7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/15/23 13:58, Stanislav Fomichev wrote:
> On 08/15, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>

>> +bpf_prog_run_array_cg_cb(const struct cgroup_bpf *cgrp,
>> +			 enum cgroup_bpf_attach_type atype,
>> +			 const void *ctx, bpf_prog_run_fn run_prog,
>> +			 int retval, u32 *ret_flags,
>> +			 int (*progs_cb)(void *, const struct bpf_prog_array *),
>> +			 void *progs_cb_arg)
>>   {
>>   	const struct bpf_prog_array_item *item;
>>   	const struct bpf_prog *prog;
>>   	const struct bpf_prog_array *array;
>>   	struct bpf_run_ctx *old_run_ctx;
>>   	struct bpf_cg_run_ctx run_ctx;
>> +	bool do_sleepable;
>>   	u32 func_ret;
>> +	int err;
>> +
>> +	do_sleepable =
>> +		atype == CGROUP_SETSOCKOPT || atype == CGROUP_GETSOCKOPT;
>>   
>>   	run_ctx.retval = retval;
>>   	migrate_disable();
>> -	rcu_read_lock();
>> +	if (do_sleepable) {
>> +		might_fault();
>> +		rcu_read_lock_trace();
>> +	} else
>> +		rcu_read_lock();
> 
> nit: wrap 'else' branch with {} braces as well

Got it!


