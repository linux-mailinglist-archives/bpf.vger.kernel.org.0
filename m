Return-Path: <bpf+bounces-1304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A3712671
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 14:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322B21C21072
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 12:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191EE171BC;
	Fri, 26 May 2023 12:18:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB423742D5
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 12:18:58 +0000 (UTC)
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [95.215.58.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D785195
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 05:18:56 -0700 (PDT)
Message-ID: <4365dadc-05f3-c0ea-3318-3c55cef177be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685103534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1O94xTqJWYAGB+q9RdqebVuhnUTDFy1EyCCAi+GAN4=;
	b=U54bwkHChglSvXvUnOuOn1UI1/2PAVLD9hTRJuQLrsPByj1wkINNoA1ygosLNJMgUcvdF/
	YAYyJmLVFaEujXhHW/kyIwbIUk41STeKFdI3oSU9mUf8+g9D7n3yQgWuzG1bteI6sSlUV6
	XpY53fQrgqHCfJW+cQTNKYIbBSqDpns=
Date: Fri, 26 May 2023 20:18:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] libbpf: kprobe.multi: Filter with
 available_filter_functions
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 bpf@vger.kernel.org, liuyun01@kylinos.cn
References: <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
 <20230526021047.368833-1-liu.yun@linux.dev> <ZHCBfW6AAxCO53mC@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <ZHCBfW6AAxCO53mC@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/5/26 17:53, Jiri Olsa 写道:
> On Fri, May 26, 2023 at 10:10:47AM +0800, Jackie Liu wrote:
> 
> SNIP
> 
>> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>> -			const char *sym_name, void *ctx)
>> +kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>> +				 const char *sym_name, void *ctx)
>>   {
>>   	struct kprobe_multi_resolve *res = ctx;
>>   	int err;
>> @@ -10431,8 +10438,8 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>>   	if (!glob_match(sym_name, res->pattern))
>>   		return 0;
>>   
>> -	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
>> -				res->cnt + 1);
>> +	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap,
>> +				sizeof(unsigned long), res->cnt + 1);
> 
> hum, looks like this is just formatting change, AFAICS we don't need that
> 
>>   	if (err)
>>   		return err;
>>   
>> @@ -10440,6 +10447,75 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>>   	return 0;
>>   }
>>   
> 
> SNIP
> 
>> +
>> +static void kprobe_multi_resolve_free(struct kprobe_multi_resolve *res)
>> +{
>> +	while (res->syms && res->cnt)
>> +		free((char *)res->syms[--res->cnt]);
>> +
>> +	free(res->syms);
>> +	free(res->addrs);
> 
> we should set cnt and cap to zero for the fallback sake

It is necessary to set cap to 0, cnt is already 0, if syms exists.

> 
>> +}
>> +
>>   struct bpf_link *
>>   bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>>   				      const char *pattern,
>> @@ -10476,13 +10552,20 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>>   		return libbpf_err_ptr(-EINVAL);
>>   
>>   	if (pattern) {
>> -		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
>> -		if (err)
>> -			goto error;
>> +		err = libbpf_available_kprobes_parse(ftrace_resolve_kprobe_multi_cb,
>> +						     &res);
>> +		if (err) {
>> +			/* fallback to kallsyms */
> 
> we need to call kprobe_multi_resolve_free in here and set
> cnt/cap to zero in kprobe_multi_resolve_free

Yes.

> 
> jirka
> 
>> +			err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb,
>> +						    &res);
>> +			if (err)
>> +				goto error;
>> +		}
>>   		if (!res.cnt) {
>>   			err = -ENOENT;
>>   			goto error;
>>   		}
>> +		syms = res.syms;
>>   		addrs = res.addrs;
>>   		cnt = res.cnt;
>>   	}
>> @@ -10511,12 +10594,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>>   		goto error;
>>   	}
>>   	link->fd = link_fd;
>> -	free(res.addrs);
>> +	kprobe_multi_resolve_free(&res);
>>   	return link;
>>   
>>   error:
>>   	free(link);
>> -	free(res.addrs);
>> +	kprobe_multi_resolve_free(&res);
>>   	return libbpf_err_ptr(err);
>>   }
>>   
>> -- 
>> 2.25.1
>>

