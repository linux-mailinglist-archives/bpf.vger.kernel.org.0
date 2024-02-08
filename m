Return-Path: <bpf+bounces-21537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896E384E929
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798881C230B1
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B742E381D3;
	Thu,  8 Feb 2024 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pSbJMCfV"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A8381C1
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422032; cv=none; b=AK8Bvxm5cdEkZN9bu3x9SY3GrGP8r9WUWq5cxD7pjPprH//eSB5u3r8aUrG8B+TRcVUK8BzQnDrE97bhpGxBBnjt1lSTNyXnQHBY9K2aEAQ9Tvlxu3bLWPYTihFlgHAjyUq76Wg2tBz8fo2yQzOFY65lqioDEpS3NizgUpRVvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422032; c=relaxed/simple;
	bh=m/4TVRxkje0X/PulgW1Zro0vTN8VaiUTq4UWZeQxNvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+qIAqtOJ1yNG/zkcMdlnee9gjRrznrMj8/RwGz2DpgMzjfI3s34figzODpNuUUDWJzpNxnC2/mTfSWbVGJxtSJvC1JjgCr3MfXYPZtnzvY2V163cFB8ouASP5iVstrYfSoSC7WeTSmrwDyOrpU6vnU1lYhuE8SkUOgV+F3rkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pSbJMCfV; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d1b6428e-7ee2-4bb7-a902-8b45d8beed5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707422028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4oi9wR7knQrZcH788HBL3OYMquK77TCy3eNska9jYI=;
	b=pSbJMCfVwQg0a26otc8YgvDwM4jTSS9LuLrHJALjWuXYxCmDmYl5uGNZYJzgGpcAaM5TMI
	68MX9E2tETwD6DxKVz444Nh2aXCYsOsWLOBsS+6bjlXE1BSydBJXCHyte8zytT3/UvvIu9
	ys5jhCNWoiTsGZmchdW2dddw2iL0R+k=
Date: Thu, 8 Feb 2024 11:53:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/3] bpf, btf: Add check_btf_kconfigs helper
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Matthieu Baerts <matttbe@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev, Jiri Olsa <olsajiri@gmail.com>
References: <cover.1707373307.git.tanggeliang@kylinos.cn>
 <fa5537fc55f1e4d0bfd686598c81b7ab9dbd82b7.1707373307.git.tanggeliang@kylinos.cn>
 <ZcSn24Isfsg45jBJ@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZcSn24Isfsg45jBJ@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/24 2:07 AM, Jiri Olsa wrote:
>> +static int check_btf_kconfigs(const struct module *module)
>> +{
>> +	if (!module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
>> +		pr_err("missing vmlinux BTF, cannot register kfuncs\n");
>> +		return -ENOENT;
>> +	}
>> +	if (module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
>> +		pr_warn("missing module BTF, cannot register kfuncs\n");
>> +	return 0;
>> +}
>> +
>>   BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
>>   {
>>   	struct btf *btf = NULL;
>> @@ -8098,15 +8109,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>>   	int ret, i;
>>   
>>   	btf = btf_get_module_btf(kset->owner);
>> -	if (!btf) {
>> -		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
>> -			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
>> -			return -ENOENT;
>> -		}
>> -		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
>> -			pr_warn("missing module BTF, cannot register kfuncs\n");
>> -		return 0;
>> -	}
>> +	if (!btf)
>> +		return check_btf_kconfigs(kset->owner);
>>   	if (IS_ERR(btf))
>>   		return PTR_ERR(btf);
>>   
>> @@ -8214,15 +8218,8 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
>>   	int ret;
>>   
>>   	btf = btf_get_module_btf(owner);
>> -	if (!btf) {
>> -		if (!owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
>> -			pr_err("missing vmlinux BTF, cannot register dtor kfuncs\n");
>> -			return -ENOENT;
>> -		}
>> -		if (owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
>> -			pr_warn("missing module BTF, cannot register dtor kfuncs\n");
> nit, we do lose the 'dtor' from the message but I think it's ok,
> for the patchset:

I added "const char *feature" argument to check_btf_kconfigs(), so it is like 
check_btf_kconfigs(, "kfunc"), check_btf_kconfigs(, "dtor kfunc"), and 
check_btf_kconfigs(, "struct_ops"). Applied. Thanks.


