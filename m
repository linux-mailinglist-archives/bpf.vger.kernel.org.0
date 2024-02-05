Return-Path: <bpf+bounces-21199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F251384937B
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 06:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130B31C22661
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 05:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5437B674;
	Mon,  5 Feb 2024 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgWrCX5D"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF6B641
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707111780; cv=none; b=SqYWjY2/hOGF9CUKNk6YMNMN69emuCPxpqlOu7dUBAjtRu5QYHkv3M6aVZDiS/lc7mpheLM0rKZdgkWY6AwyhmD9M+/clCtVYcGi1oKz2uRJuZSqnCQb+iXZhk3C5Wr9p2RFDzUMj/e0eFr/bbY9SRmRlA9kMFues9SJBrfzp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707111780; c=relaxed/simple;
	bh=+hsQoslHTQfDy8/4vdzAjHlOFDg9JTldeedFpeUnIzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3Vs1DY2BhFUeS0QZ6lNyGk9xAJaP1pmO43uTa4m+TB7585eFKZsPzyfwFpRuyIHM1dRinokIh24TyNIIw13JF/k/d4sMIN1a1lh0eAoTfo3FNXLUV3majekP61TPwXR/74Vwak4Yd1YRZ23iM6yi9GYJpRr9Bq2qceNYeCvvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgWrCX5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707111777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+O7i45ZxY5RwQCECw46Rk1LnuCGKB7GSi437XA8QTg=;
	b=UgWrCX5DQDHcT6PsReseoSYrdwbIpW9hinJ6ZiiKlGL+YMWhY8/RZ/8j91v87bGGBIr+MN
	x+WmfODB9+jxkGlzkFy/LFOFeT+xbovPUWczHye5613996OiyGHzK6rTrfNCEXvjAEZJq+
	WuONKpHoVArGDq6hENLEINSs/zCkACI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656--EYBCuewMgm83pH4RQGSQg-1; Mon, 05 Feb 2024 00:42:55 -0500
X-MC-Unique: -EYBCuewMgm83pH4RQGSQg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a372f08a749so79668266b.3
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 21:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707111775; x=1707716575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+O7i45ZxY5RwQCECw46Rk1LnuCGKB7GSi437XA8QTg=;
        b=LBAi4NC59tRegS71za5o7mDFshNE2PHshBFTOxFDxdCE+OYrpcjz3tgk9uELSmJ7b8
         vigUzQRiXHG/sU0WdSCQacqAR1IqJz3dC9vS0CrWhDTIUvcwiS+3lA9ddOzFJ8R2B9za
         i3OPy7uFSHfpROTcsjB2LPq7yy6z3eiNlhdYmtj+7k7d5STe1/a2Cl5spc5Gv7LrmGo0
         GHliJkMRLt3qyjiVJFSP9HmRAbcFpg3Fr3GRmTvYJXpzHyfWgIn+4HW2SUntTMkyzOu4
         PJnH+b3hv4N5kmu1rgF+9k1+3FH1zR+Fgp/iPmxUaI03/Xo3r6omg3AXZrYaPXwxWHZ+
         59Sg==
X-Gm-Message-State: AOJu0Yxbu1qkPrQsUlGemsmJLpLjAZdOTtTyJu9Gl0+51ZZ5qVagR+nE
	t9vKhieLbwT8xipV/1FZUlIYxXd9wrXzHUP/VulvqaW6wt3bYH+x0HnWBkXSzcRqVoNz1esLvDv
	iQtUK9+ZdM5dR7/PABSjd0pS+5nNkOmOCFFMykZXWrESrcuyW
X-Received: by 2002:a17:906:d28f:b0:a37:d098:3525 with SMTP id ay15-20020a170906d28f00b00a37d0983525mr502238ejb.42.1707111774789;
        Sun, 04 Feb 2024 21:42:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHol4w713CyLE8uk6SEZswyaTeMPTHHSv3xZ6O0QJhPqbDsFZRC6U38k6+Fb8M2HX3xqEtk8A==
X-Received: by 2002:a17:906:d28f:b0:a37:d098:3525 with SMTP id ay15-20020a170906d28f00b00a37d0983525mr502223ejb.42.1707111774379;
        Sun, 04 Feb 2024 21:42:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVf8uux0NwUuh7aVKlnBiaHnnPstCvkWSGRBINl12TwJF9pD2baBxslBNn1WVod8cy7LbeV1rQ0Bn/xpZ4KqCES3qlpAU909tsrEnRrcpFSIGOmqb1E2NNV6DV2MSxjFccgPbEeUz8/VleU5NTS+4YMzT6zaixU4swThSOgyrWvFRKdm6Ukkd2BCrp+PTMHRTAL9V53yC5RXrKOPMUgIqx0bPiy6BCE7adQwfHg9EBGat7rdIRFI0TDb10x0li2JwyQPGKcH6+tNoKqYjLx15ecrxn/VZnvI8YNmMU4l7bpD6OXjjcbe/wm/+Qfc/WmX3zYVBAubtuboJWsgRCAHtfsqVl0/i+byNcdo6qUkCpJ1ttyeMm6ZSvPQ5CySxHjHSq1O1T+5QM6u/ze0jibRQ2rtS69W/JLQf5uCYDNYGCcjsmbVSLWvmv1ZvBB4Gg=
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id z20-20020a17090655d400b00a36c5b01ef3sm3880790ejp.225.2024.02.04.21.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 21:42:54 -0800 (PST)
Message-ID: <9a5453ed-2525-4c3a-b61d-942d13604777@redhat.com>
Date: Mon, 5 Feb 2024 06:42:53 +0100
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
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <cover.1706717857.git.vmalik@redhat.com>
 <eafd46de2ff1bfc6103ec466d4fba0861ce416a6.1706717857.git.vmalik@redhat.com>
 <Zbzo4HBVmmkikbhO@krava>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <Zbzo4HBVmmkikbhO@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 14:06, Jiri Olsa wrote:
> On Wed, Jan 31, 2024 at 05:24:08PM +0100, Viktor Malik wrote:
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
>>  tools/bpf/resolve_btfids/main.c | 30 ++++++++++++++++++++++--------
>>  tools/include/linux/btf_ids.h   |  9 +++++++++
>>  2 files changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 27a23196d58e..7badf1557e5c 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -70,6 +70,7 @@
>>  #include <sys/stat.h>
>>  #include <fcntl.h>
>>  #include <errno.h>
>> +#include <linux/btf_ids.h>
>>  #include <linux/rbtree.h>
>>  #include <linux/zalloc.h>
>>  #include <linux/err.h>
>> @@ -78,7 +79,7 @@
>>  #include <subcmd/parse-options.h>
>>  
>>  #define BTF_IDS_SECTION	".BTF_ids"
>> -#define BTF_ID		"__BTF_ID__"
>> +#define BTF_ID_PREFIX	"__BTF_ID__"
> 
> nit does not look necessary to me

There's a conflicting definition of BTF_ID in btf_ids.h, this change is
to prevent a warning after we include the header.

> 
>>  
>>  #define BTF_STRUCT	"struct"
>>  #define BTF_UNION	"union"
>> @@ -161,7 +162,7 @@ static int eprintf(int level, int var, const char *fmt, ...)
>>  
>>  static bool is_btf_id(const char *name)
>>  {
>> -	return name && !strncmp(name, BTF_ID, sizeof(BTF_ID) - 1);
>> +	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
>>  }
>>  
>>  static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
>> @@ -441,7 +442,7 @@ static int symbols_collect(struct object *obj)
>>  		 * __BTF_ID__TYPE__vfs_truncate__0
>>  		 * prefix =  ^
>>  		 */
>> -		prefix = name + sizeof(BTF_ID) - 1;
>> +		prefix = name + sizeof(BTF_ID_PREFIX) - 1;
>>  
>>  		/* struct */
>>  		if (!strncmp(prefix, BTF_STRUCT, sizeof(BTF_STRUCT) - 1)) {
>> @@ -656,8 +657,8 @@ static int sets_patch(struct object *obj)
>>  	while (next) {
>>  		unsigned long addr, idx;
>>  		struct btf_id *id;
>> -		int *base;
>> -		int cnt;
>> +		void *base;
>> +		int cnt, size;
>>  
>>  		id   = rb_entry(next, struct btf_id, rb_node);
>>  		addr = id->addr[0];
>> @@ -671,13 +672,26 @@ static int sets_patch(struct object *obj)
>>  		}
>>  
>>  		idx = idx / sizeof(int);
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
>>  		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
>>  			 (idx + 1) * sizeof(int), cnt, id->name);
>>  
>> -		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
>> +		qsort(base, cnt, size, cmp_id);
> 
> maybe we could call qsort on top of each set type, seems simpler:

That looks much cleaner, I'll use that, thanks!

V.

> 
>  	while (next) {
> +		struct btf_id_set8 *set8;
> +		struct btf_id_set *set;
>  		unsigned long addr, idx;
>  		struct btf_id *id;
> -		int *base;
> -		int cnt;
>  
>  		id   = rb_entry(next, struct btf_id, rb_node);
>  		addr = id->addr[0];
> @@ -671,13 +672,16 @@ static int sets_patch(struct object *obj)
>  		}
>  
>  		idx = idx / sizeof(int);
> -		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
> -		cnt = ptr[idx];
> +		if (id->is_set) {
> +			set = (struct btf_id_set *)&ptr[idx];
> +			qsort(set->ids, set->cnt, sizeof(set->ids[0]), cmp_id);
> +		} else {
> +			set8 = (struct btf_id_set8 *)&ptr[idx];
> +			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
> +		}
>  
>  		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
> -			 (idx + 1) * sizeof(int), cnt, id->name);
> -
> -		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
> +			 (idx + 1) * sizeof(int), id->is_set ? set->cnt : set8->cnt, id->name);
>  
>  		next = rb_next(next);
>  	}
> 
> 
> jirka
> 


