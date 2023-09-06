Return-Path: <bpf+bounces-9310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAA07933B9
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 04:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36431C20382
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A13F65B;
	Wed,  6 Sep 2023 02:23:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B8662B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 02:23:32 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89349ED
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 19:23:31 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3aa1443858eso2471388b6e.3
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693967010; x=1694571810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ufYxGVgy6kxpaQvxt4YMhL93Nv3FlUxj/qlCWiKDcY=;
        b=REkljljlwbYFPIH6K+GatBfpFGkhTBZwy/tgXxwRoI3eKEhfktDf1w5ANjIsvrZwCM
         qkvy9k+eBMWgjQbG4hLq30cHq8/cvcF+OLBl7Pn8v2+3IMZ/X0/2UVpAWsM7ePXTC71s
         B+ZY8DBPrL58hIEwGRa8OxCn2dEutDo+dvha7KIueQdYb3n+xzFmvfcddkr3jTFEwvvv
         PO+KGfMBPqpacsPig1OjVWk2sdeUKHL3s8/1D0zmZAx63hPscwd/VK0JBVjLuJ7REoui
         KB6sa8ZLMXNxgdpn2tQRGllmH37rOaYlaGbc6esru7kBZ4pXNDx3tHbpvAb3hk4jRTGJ
         S/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693967010; x=1694571810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ufYxGVgy6kxpaQvxt4YMhL93Nv3FlUxj/qlCWiKDcY=;
        b=NPymAdTKArUZyMDuiz+hMTxIV4L01hkJPAS5/LjBv3AKM49OmVDdtdGaBwDtvsITZO
         kQ5M8DKIiWvpLN0JMSn7l5FC4DDEz3HiEJ/RcZKWxrBEJIxL/AzVKNvwn4ctV5tGQt+Y
         4eorn/lvPDs4mgKg7o1BXp0Mhb71ZCcItkdjBJKPAX/S8uKI7SW4JBhHBy63c4KH5M3k
         Af+7pmXaBahlbEPvnZHI05A1yo9Dp1Nm5MlcNj3E/X4fS5OkZGohphNfivsZgPadsFop
         lb1lDt69ofmrhg7zuA/wiUC1ddqAMq51L5YlhK52gAp77zdF3yCFe0lB92y9iPrsd16Y
         ctSA==
X-Gm-Message-State: AOJu0Yz2AhdliMs1CDUqyVbzS6CiY95zjWQvblHBwPovDLNe3ZdrYrOw
	hQnTu2LLzOzrI+QfW0ZWsa8=
X-Google-Smtp-Source: AGHT+IE9tpL09Y1bZxceemfQz2X65TVQbqmbs1DTWRPlNMQE7E2/GG2xTCQwuMeO5tHqghURMw/H7Q==
X-Received: by 2002:a54:4d92:0:b0:3a8:43d5:878b with SMTP id y18-20020a544d92000000b003a843d5878bmr14522671oix.2.1693967010575;
        Tue, 05 Sep 2023 19:23:30 -0700 (PDT)
Received: from [10.22.67.252] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id v3-20020a655c43000000b00565e2ad12e5sm8950058pgr.91.2023.09.05.19.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 19:23:30 -0700 (PDT)
Message-ID: <148dbaae-4aa5-eaab-2fec-89d06cebf103@gmail.com>
Date: Wed, 6 Sep 2023 10:23:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH bpf-next v4 1/4] bpf, x64: Comment tail_call_cnt
 initialisation
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 iii@linux.ibm.com, jakub@cloudflare.com, bpf@vger.kernel.org
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
 <20230903151448.61696-2-hffilwlqm@gmail.com> <ZPeA/XoEQn+OCk/l@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZPeA/XoEQn+OCk/l@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/9/23 03:26, Maciej Fijalkowski wrote:
> On Sun, Sep 03, 2023 at 11:14:45PM +0800, Leon Hwang wrote:
>> Without understanding emit_prologue(), it is really hard to figure out
>> where does tail_call_cnt come from, even though searching tail_call_cnt
>> in the whole kernel repo.
>>
>> By adding these comments, it is a little bit easy to understand
> 
> s/easy/easier

Got it.

> 
>> tail_call_cnt initialisation.
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> 
> I was rather thinking about dropping these comments altogether. We should
> be trying to provide fixes as small as possible IMHO.
> 
> Having this as a separate commit also breaks logistics of this set as
> the fix + selftest should be routed towards bpf tree, whereas this
> particular commit is rather a bpf-next candidate.
> 
> PTAL at https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html

Thanks for your review.

I'll keep this commit as one of this set.

Thanks,
Leon

> 
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index a5930042139d3..bcca1c9b9a027 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>  	prog += X86_PATCH_SIZE;
>>  	if (!ebpf_from_cbpf) {
>>  		if (tail_call_reachable && !is_subprog)
>> +			/* When it's the entry of the whole tailcall context,
>> +			 * zeroing rax means initialising tail_call_cnt.
>> +			 */
>>  			EMIT2(0x31, 0xC0); /* xor eax, eax */
>>  		else
>> +			/* Keep the same instruction layout. */
>>  			EMIT2(0x66, 0x90); /* nop2 */
>>  	}
>>  	EMIT1(0x55);             /* push rbp */
>> -- 
>> 2.41.0
>>

