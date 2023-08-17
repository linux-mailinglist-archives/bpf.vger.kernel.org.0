Return-Path: <bpf+bounces-8012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78F77FD8F
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 20:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4A01C20FEF
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDCB174E1;
	Thu, 17 Aug 2023 18:12:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843414F7B
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 18:12:42 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF7526A5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 11:12:41 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58c92a2c52dso1072657b3.2
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692295961; x=1692900761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvA8V4VBERQfa2KXdmXQNYjXidBE3AnjMb1f/+2fTdE=;
        b=EBGj09cNkKZj0wArNVZ+KcbsijOlpwLRP1MdILpZIY4e5Q54wD89UVzOraXCaVWmKY
         IjcUX46QcjsEP3ZsPyWU05dNd5Q9RUb5B5ySTozeR9v9xQ4Zgm+GPk1bgcj74PqyFxtt
         Qf8ruCKbCYxSt6srCLPIDDZ+K6En3oLMBGlinpBL/aWQYAHGMc4xC2UyeJKvE7htJY0Z
         bqP7viLISPhgBDx+K0xczSd39hl8fG9xuRMgYJuHqpS0G3DPWNz4pRhgNE2HGQeMTcF+
         +Idsb9OhN0+Pd5P20qf9ZBcbWuTO9dT2qNVNhHRFGNEP70C98ep4KvdjwntDX2f+7xYz
         SgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295961; x=1692900761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvA8V4VBERQfa2KXdmXQNYjXidBE3AnjMb1f/+2fTdE=;
        b=XtZx4CIonXQ+EBWfWwT9JzIoxBs9LQMcRzhF/Sf6c3idfFZofU3e9W0++BraEpMIR9
         eQv4Vq0ufi9+PoVou9B3q++nzlOwEoWoZIlumnVROPDbRAZkrDBEiWMONiRf+IwAd2nC
         HvlnkNXR+b8IhHwysyKWt0bFwVG2d9r2D38nOJ1U7qzxZ0CPqKkU74Xka6lD/RKit0Vx
         Rk7mPoWVlWQqn8/Z4vnr/Xu1HOHWtNuObh54X4fze+oElY3FCPuzt8oMS9VCCUQuFT7G
         8q/zo/K5HOEPql7XvBdA6e45K2Q3WNe++v5WZOkriuVK97eye8Qrc6Wq2BGfb7vBGGU3
         pRhw==
X-Gm-Message-State: AOJu0Yy3GU+XwKjzRlRz/0KGbMkZtuPwaDMYfBdBxS5f6hBWudj2Ruja
	OgvEbMPduw+ttbwawl4/HuY=
X-Google-Smtp-Source: AGHT+IFe52eST/qMfXZ948p1ewdlYiJQNzHfQecxNJJdtZBzZ4xLR93f3/79+Q4mALyBhX+T7Oexjw==
X-Received: by 2002:a81:8406:0:b0:577:21ff:4d47 with SMTP id u6-20020a818406000000b0057721ff4d47mr174668ywf.7.1692295960743;
        Thu, 17 Aug 2023 11:12:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:5ef6:83:35d0:e69d? ([2600:1700:6cf8:1240:5ef6:83:35d0:e69d])
        by smtp.gmail.com with ESMTPSA id w193-20020a8149ca000000b00585e2c112fdsm19682ywa.111.2023.08.17.11.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 11:12:40 -0700 (PDT)
Message-ID: <646588b9-e094-eb14-a400-475a542bf23c@gmail.com>
Date: Thu, 17 Aug 2023 11:12:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v3 3/5] bpf: Prevent BPF programs from access the
 buffer pointed by user_optval.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, sdf@google.com,
 yonghong.song@linux.dev, kuifeng@meta.com
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-4-thinker.li@gmail.com>
 <20230817011742.lgouyc4hx5ayihco@MacBook-Pro-8.local>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230817011742.lgouyc4hx5ayihco@MacBook-Pro-8.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/16/23 18:17, Alexei Starovoitov wrote:
> On Tue, Aug 15, 2023 at 10:47:10AM -0700, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Since the buffer pointed by ctx->user_optval is in user space, BPF programs
>> in kernel space should not access it directly.  They should use
>> bpf_copy_from_user() and bpf_copy_to_user() to move data between user and
>> kernel space.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/cgroup.c   | 16 +++++++++--
>>   kernel/bpf/verifier.c | 66 +++++++++++++++++++++----------------------
>>   2 files changed, 47 insertions(+), 35 deletions(-)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index b977768a28e5..425094e071ba 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -2494,12 +2494,24 @@ static bool cg_sockopt_is_valid_access(int off, int size,
>>   	case offsetof(struct bpf_sockopt, optval):
>>   		if (size != sizeof(__u64))
>>   			return false;
>> -		info->reg_type = PTR_TO_PACKET;
>> +		if (prog->aux->sleepable)
>> +			/* Prohibit access to the memory pointed by optval
>> +			 * in sleepable programs.
>> +			 */
>> +			info->reg_type = PTR_TO_PACKET | MEM_USER;
>> +		else
>> +			info->reg_type = PTR_TO_PACKET;
>>   		break;
>>   	case offsetof(struct bpf_sockopt, optval_end):
>>   		if (size != sizeof(__u64))
>>   			return false;
>> -		info->reg_type = PTR_TO_PACKET_END;
>> +		if (prog->aux->sleepable)
>> +			/* Prohibit access to the memory pointed by
>> +			 * optval_end in sleepable programs.
>> +			 */
>> +			info->reg_type = PTR_TO_PACKET_END | MEM_USER;
> 
> This doesn't look correct.
> packet memory and user memory are non overlapping address spaces.
> There cannot be a packet memory that is also and user memory.

Got it! I will find a new type to replace this one.

