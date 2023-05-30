Return-Path: <bpf+bounces-1419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F4171555B
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 08:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0F128106A
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 06:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CA8F71;
	Tue, 30 May 2023 06:09:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAEF8F60
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 06:09:16 +0000 (UTC)
Received: from out-25.mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D61E40
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 23:08:44 -0700 (PDT)
Message-ID: <aa14123d-6213-da9a-37f2-986b9670bb23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685426883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7RUsqQ3/wmIK2cXr56Z6runhHT2oIWOz7SyQ0VwfF4=;
	b=Dbnat/DcS9lmYwk3otsq8LedZpE3r34ZS/t5vKPt24itZtlzHd0gSzofZcrICdfVoX4mDV
	NXdw73qZUVAgAu/fFWHVsuKimv9dEeBzzb/Ubp3gFafoeBK4Xkm01Ve+4S0kbNfON06i+3
	5BAHg7z4g0Vreg/zUeAwidSgZnrfxD0=
Date: Tue, 30 May 2023 14:07:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7] libbpf: kprobe.multi: Filter with
 available_filter_functions
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, olsajiri@gmail.com,
 andrii@kernel.org
Cc: bpf@vger.kernel.org, liuyun01@kylinos.cn, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com
References: <20230530010801.1558937-1-liu.yun@linux.dev>
 <20230530010801.1558937-1-liu.yun@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <20230530010801.1558937-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/5/30 11:44, Ratheesh Kannoth 写道:
> From: Jackie Liu <liu.yun@linux.dev>
> 
>> +
>> +	if (!glob_match(sym_name, res->pattern))
>> +		return 0;
>> +
>> +	err = libbpf_ensure_mem((void **) &res->syms, &res->cap,
>> +				sizeof(const char *), res->cnt + 1);
>> +	if (err)
>> +		return err;
>> +
>> +	name = strdup(sym_name);
>> +	if (!name)
>> +		return -errno;
>> +
>> +	res->syms[res->cnt++] = name;
>> +	return 0;
>> +}
>> +
>> +typedef int (*available_kprobe_cb_t)(const char *sym_name, void *ctx);
>> +
>> +static int
>> +libbpf_available_kprobes_parse(available_kprobe_cb_t cb, void *ctx)
>> +{
>> +	char sym_name[256];
>> +	FILE *f;
>> +	int ret, err = 0;
>> +	const char *available_path = tracefs_available_filter_functions();
> Dont we need to follow reverse x-mas tree ?
> 
>> +
>> +	f = fopen(available_path, "r");
>> +	if (!f) {
>> +		err = -errno;
>> +		pr_warn("failed to open %s, fallback to /proc/kallsyms.\n",
>> +			available_path);
>> +		return err;
>> +	}
>> +
>> +	while (true) {
>> +		ret = fscanf(f, "%255s%*[^\n]\n", sym_name);
>> +		if (ret == EOF && feof(f))
>> +			break;
> why fscanf() is not setting EOF. Why did you use feof() ?

The fscanf function returns EOF (End of File) when one of the following 
conditions is met:

End of file is reached: When fscanf reaches the end of the file being 
read, it returns EOF. This indicates that there are no more characters 
to read from the file.

Input error occurs: If fscanf encounters an error while reading input, 
such as a format mismatch or inability to read the expected data type, 
it returns EOF.

Stream error occurs: If an error occurs with the stream itself, such as 
an error in the underlying file system or I/O error, fscanf may return EOF.

-- 
Jackie Liu

> 
>> +		if (ret != 1) {
>> +			pr_warn("failed to read available kprobe entry: %d\n",
>> +				ret);
>> +			err = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		err = cb(sym_name, ctx);
>> +		if (err)
>> +			break;
>> +	}
>> +
>> +	fclose(f);
>> +	return err;
>> +}
>> +
>> +static void kprobe_multi_resolve_free(struct kprobe_multi_resolve *res)
>> +{
>> +	while (res->syms && res->cnt)
>> +		free((char *)res->syms[--res->cnt]);
>> +
>> +	free(res->syms);
>> +	free(res->addrs);
> 
> it looks odd to do allocation in libbpf_xxx (libbpf_ensure_mem ) function and
> freeing in a static function.
> 
>> +
>> +	/* reset to zero, when fallback */
>> +	res->cap = 0;
>> +	res->cnt = 0;
>> +	res->syms = NULL;
>> +	res->addrs = NULL;
>> +}
>> +
>> struct bpf_link *
>> bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>> 				      const char *pattern,
>> @@ -10476,13 +10558,21 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>> 		return libbpf_err_ptr(-EINVAL);
>>
>> 	if (pattern) {
>> -		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
>> -		if (err)
>> -			goto error;
>> +		err = libbpf_available_kprobes_parse(ftrace_resolve_kprobe_multi_cb,
>> +						     &res);
>> +		if (err) {
>> +			/* fallback to kallsyms */
>> +			kprobe_multi_resolve_free(&res);
>> +			err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb,
>> +						    &res);
>> +			if (err)
>> +				goto error;
>> +		}
>> 		if (!res.cnt) {
>> 			err = -ENOENT;
>> 			goto error;
>> 		}
>> +		syms = res.syms;
>> 		addrs = res.addrs;
>> 		cnt = res.cnt;
>> 	}
>> @@ -10511,12 +10601,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>> 		goto error;
>> 	}
>> 	link->fd = link_fd;
>> -	free(res.addrs);
>> +	kprobe_multi_resolve_free(&res);
>> 	return link;
>>
>> error:
>> 	free(link);
>> -	free(res.addrs);
>> +	kprobe_multi_resolve_free(&res);
>> 	return libbpf_err_ptr(err);
>> }
>>
>> --
>> 2.25.1

