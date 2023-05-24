Return-Path: <bpf+bounces-1144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455D670EA8F
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 03:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8491C20A08
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792461365;
	Wed, 24 May 2023 01:09:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE91118
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 01:09:22 +0000 (UTC)
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 18:09:20 PDT
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287D90
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 18:09:19 -0700 (PDT)
Message-ID: <f3b21f27-a284-a42c-8636-181e24c325fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684890233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jh7iBS5FHLBGopmkuw15BWqC3kdUoGkTqYatZ49q0Ds=;
	b=t6NwXSr1AKcmm9VqFGAOaj10q/l0YGQsh+jQCugxcGk+hRMvmZannWy83Ez1k3nYld3okS
	pdfwpK7iMsBHa7EdolYt+mOHCL3GVzfgaaZ4k7s2Uk4cjGIo8ifu5HNZ5+wFG/wmX916NO
	EM2Vfytbilx1j2t8tcnfBA/QOhzRcxA=
Date: Wed, 24 May 2023 09:03:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: kprobe.multi: Filter with blacklist and
 available_filter_functions
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 bpf@vger.kernel.org, liuyun01@kylinos.cn
References: <20230523132547.94384-1-liu.yun@linux.dev>
 <ZGznHMU1uhdPnE/F@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <ZGznHMU1uhdPnE/F@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jiri.

在 2023/5/24 00:17, Jiri Olsa 写道:
> On Tue, May 23, 2023 at 09:25:47PM +0800, Jackie Liu wrote:
>> From: Jackie Liu <liuyun01@kylinos.cn>
>>
>> When using regular expression matching with "kprobe multi", it scans all
>> the functions under "/proc/kallsyms" that can be matched. However, not all
>> of them can be traced by kprobe.multi. If any one of the functions fails
>> to be traced, it will result in the failure of all functions. The best
>> approach is to filter out the functions that cannot be traced to ensure
>> proper tracking of the functions.
>>
>> But, the addition of these checks will frequently probe whether a function
>> complies with "available_filter_functions" and ensure that it has not been
>> filtered by kprobe's blacklist. As a result, it may take a longer time
>> during startup. The function implementation is referenced from BCC's
>> "kprobe_exists()"
>>
>> Here is the test eBPF program [1].
>> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867
>>
>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> ---
>>   tools/lib/bpf/libbpf.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index ad1ec893b41b..6a201267fa08 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -10421,6 +10421,50 @@ struct kprobe_multi_resolve {
>>   	size_t cnt;
>>   };
>>   
>> +static bool filter_available_function(const char *name)
>> +{
>> +	char addr_range[256];
>> +	char sym_name[256];
>> +	FILE *f;
>> +	int ret;
>> +
>> +	f = fopen("/sys/kernel/debug/kprobes/blacklist", "r");
>> +	if (!f)
>> +		goto avail_filter;
>> +
>> +	while (true) {
>> +		ret = fscanf(f, "%s %s%*[^\n]\n", addr_range, sym_name);
>> +		if (ret == EOF && feof(f))
>> +			break;
>> +		if (ret != 2)
>> +			break;
>> +		if (!strcmp(name, sym_name)) {
>> +			fclose(f);
>> +			return false;
>> +		}
>> +	}
>> +	fclose(f);
> 
> so available_filter_functions already contains all traceable symbols
> for kprobe_multi/fprobe
> 
> kprobes/blacklist is kprobe specific and does not apply to fprobe,
> is there a crash when attaching function from kprobes/blacklist ?

No, I haven't got crash before, Simply because BCC's kprobe_exists has
implemented it so I added this, Yes, I also don't think 
kprobes/blacklist will affect FPROBE, so I will remove it.

> 
>> +
>> +avail_filter:
>> +	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
>> +	if (!f)
>> +		return true;
>> +
>> +	while (true) {
>> +		ret = fscanf(f, "%s%*[^\n]\n", sym_name);
>> +		if (ret == EOF && feof(f))
>> +			break;
>> +		if (ret != 1)
>> +			break;
>> +		if (!strcmp(name, sym_name)) {
>> +			fclose(f);
>> +			return true;
>> +		}
>> +	}
>> +	fclose(f);
>> +	return false;
>> +}
>> +
>>   static int
>>   resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>>   			const char *sym_name, void *ctx)
>> @@ -10431,6 +10475,9 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>>   	if (!glob_match(sym_name, res->pattern))
>>   		return 0;
>>   
>> +	if (!filter_available_function(sym_name))
>> +		return 0;
> 
> I think it'd be better to parse available_filter_functions directly
> for kprobe_multi instead of filtering out kallsyms entries
> 
> we could add libbpf_available_filter_functions_parse function with
> similar callback to go over available_filter_functions file
> 

Sure, if available_filter_functions not found, fallback to /proc/kallsyms.

-- 
BR, Jackie Liu

> 
> jirka
> 
>> +
>>   	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
>>   				res->cnt + 1);
>>   	if (err)
>> -- 
>> 2.25.1
>>
>>

