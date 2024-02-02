Return-Path: <bpf+bounces-21034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD7846D1D
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 10:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254FDB286E3
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA29277F15;
	Fri,  2 Feb 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSAjkhSF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E36A345
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867712; cv=none; b=WFDM4WxcWr766mt68druRBqz949/MnDQ19IJwqgQbUe87JYIwRW10LfDT7yi/61Jx1OJ3L+b+Rhwr/8ZOyBaC6TCckiYl7Getwhkxf4P7B7fqoKXbDKj554f42OoWIIZsXW27b4XTGb8ryErIn1YTAOxPA6WpQ57W6ySkzBKEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867712; c=relaxed/simple;
	bh=9AzxCt9X6J9jwO0ulQAybaR2iXCCwfoRqdhwhZc+708=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaYgPWxvff3/RmKpFCXWm3qkzmQMZEyutdj2vk3SDJ7FqUn895LIHLYPeRnt3aXt4JpUOQ6KuenZ18XlBvT6MUO7i8Ri29XgVrYyT7ALszglA8B8vzPyw+EsvvRqKz2Alv+SY++eSGPOuHQBXygJDWze0c5GizzhxRMlmWaI528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSAjkhSF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706867709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGOWaTwVM/WiZ0KdYNJzEr4U9udVrCx+CcvhSwzkUD0=;
	b=XSAjkhSFVUn6mSfNM0ucRQcT44oDRHamXBof9ww7+vxid/Isy3q9k8qC5Z9Dj332mrYqh9
	eXywAgFfEfG641Ur2SacSZyjMKbVT2jg/GVk4cEIjeruR1YNznNj1d/ebsylzziMzVC8Hw
	Mkbu21Vtg7/S29SwJ8cyqWKtKJQyFeo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-ZingkH9iP6yGeSTNwtIwbA-1; Fri, 02 Feb 2024 04:55:07 -0500
X-MC-Unique: ZingkH9iP6yGeSTNwtIwbA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2cb0d70d6cso118277366b.2
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 01:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867706; x=1707472506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGOWaTwVM/WiZ0KdYNJzEr4U9udVrCx+CcvhSwzkUD0=;
        b=mnAIAnSANk51rWz/M6G++H6JKxMmH1bAxU7qCzIO8Sesh7FPGwNEpxUAv/s8NH9Sn4
         Q6TvPxZUHz4tazxEBNhm7wE3AMbC2bfxNFGl8lSsEO4cS4RVXK2x9DaGDVeSzGkI8y8A
         3EmpQOepPVMAs5VVFBx3N1z9yJuhphAoy2mcWhPUodynCft6E6CBDj0pqa4CkgGAGzk1
         WtvSVSsOgdfaPBzMxLwZhZXG8fknlg2ttMWArDCCp/kzQ1SV8bQkrzo7ztJCGk2hE072
         qrkvxm9m8HczMbduNuCqSN3H7ZdNJhWTRlUjR2RFG+BwPEtfr4ikIe3eVFAPRy2nvhQO
         gbvg==
X-Gm-Message-State: AOJu0YyRANenybmRX31JzxhVdoOvD07AolGIszkpNnsSilbm9HYOkI3k
	xXFLRMEBEE1o2ZCmHC4rCN34krRRhA2AHTWbaNHyUhH1js5gKJuB1qD0zF322gAaUwgpk0EDn7x
	jcduyvFe2V7z1VLA4l3ZULXQnE1DIu893++HrxUa89JM7FXyW
X-Received: by 2002:a17:907:3602:b0:a35:6c2f:f0e7 with SMTP id bk2-20020a170907360200b00a356c2ff0e7mr1337837ejc.74.1706867706662;
        Fri, 02 Feb 2024 01:55:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGokgw+puk2dhhqRqiSTPEVqQrdQiAfYRzg219+Sjlw3qpRCo5fIjWhD4PFOnOo1WY5rWE2Sw==
X-Received: by 2002:a17:907:3602:b0:a35:6c2f:f0e7 with SMTP id bk2-20020a170907360200b00a356c2ff0e7mr1337822ejc.74.1706867706248;
        Fri, 02 Feb 2024 01:55:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXi9DGbGH5kcBZt6b55LBDKQB4N4XlY4npteqK9e1e/kwGo5A1DEaNHu5IaTdlLx+9jDvpUCzp423Nxk/On3DNngyv5xEw+2NcFAEOqcvppafpvtsWSlWm0jNwcEis3eRcUkLic4yO00jMqFVdSR93Eiv7TdpC29DS/HzL47L53wijNeLDgCgZBGlRBKvyFSiTFgX50gbpsXT6o40NymZNqB1VRiwNkrEq1N44r2OhdS99skkcNdvs8TtBpVwwoucVsgRZQ6zfI840RvdrwSVc2CVegcmzuHXlq0CIUfhh7/95SeFxka69p6h79ZerbMlpgQ6Qc02Vxy3X3cj55diTfozX1Nu+2btc0nocN9YeM1vfgn+brjvE2G2qZplMEyn0HvZ8tXxJIJSkfZEKGdXLh0TN6IX5mObkuEvaPP2w9pqWzzvQTUf5yoVg1Wlxn
Received: from ?IPV6:2a02:ab04:333f:7c00:568:cf09:e97e:e96? (2a02-ab04-333f-7c00-0568-cf09-e97e-0e96.dynamic.v6.chello.sk. [2a02:ab04:333f:7c00:568:cf09:e97e:e96])
        by smtp.gmail.com with ESMTPSA id r15-20020a170906c28f00b00a3633ae53dcsm720015ejz.52.2024.02.02.01.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 01:55:05 -0800 (PST)
Message-ID: <f10d8bb1-fa0f-4157-8887-c6ffddf22575@redhat.com>
Date: Fri, 2 Feb 2024 10:55:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] tools/resolve_btfids: Refactor set
 sorting with types from btf_ids.h
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <cover.1706717857.git.vmalik@redhat.com>
 <eafd46de2ff1bfc6103ec466d4fba0861ce416a6.1706717857.git.vmalik@redhat.com>
 <f932fb45-3cd3-c603-027a-a81f8a63c76e@iogearbox.net>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <f932fb45-3cd3-c603-027a-a81f8a63c76e@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 16:51, Daniel Borkmann wrote:
> On 1/31/24 5:24 PM, Viktor Malik wrote:
>> Instead of using magic offsets to access BTF ID set data, leverage types
>> from btf_ids.h (btf_id_set and btf_id_set8) which define the actual
>> layout of the data. Thanks to this change, set sorting should also
>> continue working if the layout changes.
>>
>> This requires to sync the definition of 'struct btf_id_set8' from
>> include/linux/btf_ids.h to tools/include/linux/btf_ids.h. We don't sync
>> the rest of the file at the moment, b/c that would require to also sync
>> multiple dependent headers and we don't need any other defs from
>> btf_ids.h.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>   tools/bpf/resolve_btfids/main.c | 30 ++++++++++++++++++++++--------
>>   tools/include/linux/btf_ids.h   |  9 +++++++++
>>   2 files changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 27a23196d58e..7badf1557e5c 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -70,6 +70,7 @@
>>   #include <sys/stat.h>
>>   #include <fcntl.h>
>>   #include <errno.h>
>> +#include <linux/btf_ids.h>
>>   #include <linux/rbtree.h>
>>   #include <linux/zalloc.h>
>>   #include <linux/err.h>
>> @@ -78,7 +79,7 @@
>>   #include <subcmd/parse-options.h>
>>   
>>   #define BTF_IDS_SECTION	".BTF_ids"
>> -#define BTF_ID		"__BTF_ID__"
>> +#define BTF_ID_PREFIX	"__BTF_ID__"
>>   
>>   #define BTF_STRUCT	"struct"
>>   #define BTF_UNION	"union"
>> @@ -161,7 +162,7 @@ static int eprintf(int level, int var, const char *fmt, ...)
>>   
>>   static bool is_btf_id(const char *name)
>>   {
>> -	return name && !strncmp(name, BTF_ID, sizeof(BTF_ID) - 1);
>> +	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
>>   }
>>   
>>   static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
>> @@ -441,7 +442,7 @@ static int symbols_collect(struct object *obj)
>>   		 * __BTF_ID__TYPE__vfs_truncate__0
>>   		 * prefix =  ^
>>   		 */
>> -		prefix = name + sizeof(BTF_ID) - 1;
>> +		prefix = name + sizeof(BTF_ID_PREFIX) - 1;
>>   
>>   		/* struct */
>>   		if (!strncmp(prefix, BTF_STRUCT, sizeof(BTF_STRUCT) - 1)) {
>> @@ -656,8 +657,8 @@ static int sets_patch(struct object *obj)
>>   	while (next) {
>>   		unsigned long addr, idx;
>>   		struct btf_id *id;
>> -		int *base;
>> -		int cnt;
>> +		void *base;
>> +		int cnt, size;
>>   
>>   		id   = rb_entry(next, struct btf_id, rb_node);
>>   		addr = id->addr[0];
>> @@ -671,13 +672,26 @@ static int sets_patch(struct object *obj)
>>   		}
>>   
>>   		idx = idx / sizeof(int);
>> -		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
>> -		cnt = ptr[idx];
>> +		if (id->is_set) {
>> +			struct btf_id_set *set;
>> +
>> +			set = (struct btf_id_set *)&ptr[idx];
>> +			base = set->ids;
>> +			cnt = set->cnt;
>> +			size = sizeof(set->ids[0]);
>> +		} else {
>> +			struct btf_id_set8 *set8;
>> +
>> +			set8 = (struct btf_id_set8 *)&ptr[idx];
>> +			base = set8->pairs;
>> +			cnt = set8->cnt;
>> +			size = sizeof(set8->pairs[0]);
>> +		}
>>   
>>   		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
>>   			 (idx + 1) * sizeof(int), cnt, id->name);
>>   
>> -		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
>> +		qsort(base, cnt, size, cmp_id);
> 
> Looks good to me, one small remark: perhaps it would also make sense to have an assert
> on the id location, such that we have a build error in case the id would not be the
> first in the struct / pairs array anymore given then cmp_id would look at wrong data
> for the latter given the plain int cast from there.

That's a good idea, I'll add a BUILD_BUG_ON check for set8.

Thanks!

> 
>>   		next = rb_next(next);
>>   	}
>> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
>> index 2f882d5cb30f..72535f00572f 100644
>> --- a/tools/include/linux/btf_ids.h
>> +++ b/tools/include/linux/btf_ids.h
>> @@ -8,6 +8,15 @@ struct btf_id_set {
>>   	u32 ids[];
>>   };
>>   
>> +struct btf_id_set8 {
>> +	u32 cnt;
>> +	u32 flags;
>> +	struct {
>> +		u32 id;
>> +		u32 flags;
>> +	} pairs[];
>> +};
>> +
>>   #ifdef CONFIG_DEBUG_INFO_BTF
>>   
>>   #include <linux/compiler.h> /* for __PASTE */
>>
> 


