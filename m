Return-Path: <bpf+bounces-22817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F986A2DD
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C9628A556
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913655C1E;
	Tue, 27 Feb 2024 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLsscx2i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F455C06
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074552; cv=none; b=Q7CcnDyYSB+CEu9wYDm9sTHCrvLk6qKlV3WLz6Zsn5xtkpobxaHgdSPxCjIcUrH8f19M2+CdUzJtK7DXeG9FhVlq2j11zCpDTA4N11mYuurGxDJvV29HuqwDiCAPbFEbCJlus8VIK2WWxiQMEQ6E+FKooEV7yv9uxmQRPpsfV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074552; c=relaxed/simple;
	bh=ARIymJr09MPfIIOhXJgc0u0Lce9qEDyqqO3GXXWFN40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uV/MVd4GPEe93DFjmQ/tT2j33ySwqE2Xo0NT+aSQFs7RWFde8EcwHP/eWj46IpT9O2zp1hweS9//6J/3nvc0Qxp5LV3GMbIwrkucLE+X5p7RGs4kuF52l7mBfiCIdvhdPjYQ0BYKXwYtNDd3yefBxn6/RPmx/BdgCNjGw0g5XcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLsscx2i; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6092387bdd0so14856137b3.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709074550; x=1709679350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBXKUW+Ybv9zLSMqYVpwNjB6rq9+x/ksF5uYs2TmhvM=;
        b=hLsscx2ijSxOYqPWwP9HUZY42F1oVnv8LpemPxSSLT+9eufJM96C8p8lkL0KM/WQvl
         vfydcE/AhqObVO/Sas/B9MFLHpACGWbFnpTIHoErrYGgEVlor86HIPNQmwcXW2597Xke
         8zmKNt4BidIArrOpwNCNhJl6kN2dP/BBYEPiRu/NNV/jDv5jCqtu1X5OZb4h9qqXDWOQ
         1TUHCWamk/A7KiL9QUbFuEWd5jOO8aLkaLGw0IOUb6mAJtusmV+u2hZrFedb6n7+80TV
         Jvso2za0WBPU4BGa/4xh5GglN6F+rZboyzu3pgoGPiugXrctflvRww8ZUEeKW+a3yxFv
         pNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709074550; x=1709679350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBXKUW+Ybv9zLSMqYVpwNjB6rq9+x/ksF5uYs2TmhvM=;
        b=SqgODPGfduNi97VQ3pfMOma7xdZU4caIxcv9SLZKDZsqAOdoWYXoSkNIlUH6HSgMd7
         wSz9V29wy/buZ576dCl2WBVyLKmqaS9kFwVWUY1etrGOjG96H0aRbgZw1noPXetJbNa4
         ollWuDJwHaGzr3tXmgAt9bGMt9ys+DW+/a5AoO/AJkSyrfp8Slhk8OaW1/X6mwf+gLbR
         u+setakJtNYU/2eQeePmA6mTh5RSDLYkcqo+ClMu/r7iEDNMjWm1VCE2G3LRgqDuxqT+
         Zde9Bpt3MqUF+o1Vzdam0hTJPpJESHr14y8jRrCaKr/47o7csBp8uD+t7LKcrmVQd7eB
         Pjhg==
X-Forwarded-Encrypted: i=1; AJvYcCWrBqTOQyGC7s3xANQumVbcTYmBQVsRKVsRb4CBdH7Ue51H3s7DfFCFdXYgeHxuRPYP9cgVlMFGCqZuvlGyMW9PFSTf
X-Gm-Message-State: AOJu0YzN3QORK6Jj48FPg8tSTe/s8BHWBzBFFM78YKvgbilj68BM+8iB
	TTTo8rgBWmXk9MPoq8684NUV8aOrBefZEpWuR/TnYu8xxLKdmgRO
X-Google-Smtp-Source: AGHT+IHN/g5STbUCWzT62JwFKJtos6kDM5o3FUAOB53XoPp5LCWMLFX+zgVLZ6jTqkstnWrJJEPt5Q==
X-Received: by 2002:a0d:df92:0:b0:608:290d:9f1b with SMTP id i140-20020a0ddf92000000b00608290d9f1bmr3374634ywe.49.1709074550229;
        Tue, 27 Feb 2024 14:55:50 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:76a2:1c3:c564:933e? ([2600:1700:6cf8:1240:76a2:1c3:c564:933e])
        by smtp.gmail.com with ESMTPSA id v11-20020a81b80b000000b00608d5de1c94sm1929115ywe.37.2024.02.27.14.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 14:55:49 -0800 (PST)
Message-ID: <ec9d8997-f5a2-44b6-9bc4-2caaf19df8a9@gmail.com>
Date: Tue, 27 Feb 2024 14:55:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-8-eddyz87@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240227204556.17524-8-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 12:45, Eduard Zingerman wrote:
> Make bpf_map__set_autocreate() for struct_ops maps toggle autoload
> state for referenced programs.
> 
> E.g. for the BPF code below:
> 
>      SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
>      SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }
> 
>      SEC(".struct_ops.link")
>      struct test_ops___v1 A = {
>          .foo = (void *)foo
>      };
> 
>      SEC(".struct_ops.link")
>      struct test_ops___v2 B = {
>          .foo = (void *)foo,
>          .bar = (void *)bar,
>      };
> 
> And the following libbpf API calls:
> 
>      bpf_map__set_autocreate(skel->maps.A, true);
>      bpf_map__set_autocreate(skel->maps.B, false);
> 
> The autoload would be enabled for program 'foo' and disabled for
> program 'bar'.
> 
> Do not apply such toggling if program autoload state is set by a call
> to bpf_program__set_autoload().
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b39d3f2898a1..1ea3046724f8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -446,13 +446,18 @@ struct bpf_program {
>   	struct bpf_object *obj;
>   
>   	int fd;
> -	bool autoload;
> +	bool autoload:1;
> +	bool autoload_user_set:1;
>   	bool autoattach;
>   	bool sym_global;
>   	bool mark_btf_static;
>   	enum bpf_prog_type type;
>   	enum bpf_attach_type expected_attach_type;
>   	int exception_cb_idx;
> +	/* total number of struct_ops maps with autocreate == true
> +	 * that reference this program
> +	 */
> +	__u32 struct_ops_refs;
>   
>   	int prog_ifindex;
>   	__u32 attach_btf_obj_fd;
> @@ -4509,6 +4514,28 @@ static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
>   	return 0;
>   }
>   
> +/* Sync autoload and autocreate state between struct_ops map and
> + * referenced programs.
> + */
> +static void bpf_map__struct_ops_toggle_progs_autoload(struct bpf_map *map, bool autocreate)
> +{
> +	struct bpf_program *prog;
> +	int i;
> +
> +	for (i = 0; i < btf_vlen(map->st_ops->type); ++i) {
> +		prog = map->st_ops->progs[i];
> +
> +		if (!prog || prog->autoload_user_set)
> +			continue;
> +
> +		if (autocreate)
> +			prog->struct_ops_refs++;
> +		else
> +			prog->struct_ops_refs--;
> +		prog->autoload = prog->struct_ops_refs != 0;
> +	}
> +}
> +

This part is related to the other patch [1], which allows
a user to change the value of a function pointer field. The behavior of
autocreate and autoload may suprise a user if the user call
bpf_map__set_autocreate() after changing the value of a function pointer
field.

[1] 
https://lore.kernel.org/all/20240227010432.714127-1-thinker.li@gmail.com/


>   bool bpf_map__autocreate(const struct bpf_map *map)
>   {
>   	return map->autocreate;
> @@ -4519,6 +4546,9 @@ int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
>   	if (map->obj->loaded)
>   		return libbpf_err(-EBUSY);
>   
> +	if (map->st_ops && map->autocreate != autocreate)
> +		bpf_map__struct_ops_toggle_progs_autoload(map, autocreate);
> +
>   	map->autocreate = autocreate;
>   	return 0;
>   }
> @@ -8801,6 +8831,7 @@ int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
>   		return libbpf_err(-EINVAL);
>   
>   	prog->autoload = autoload;
> +	prog->autoload_user_set = 1;
>   	return 0;
>   }
>   
> @@ -9428,6 +9459,8 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
>   			return -EINVAL;
>   		}
>   
> +		if (map->autocreate)
> +			prog->struct_ops_refs++;
>   		st_ops->progs[member_idx] = prog;
>   	}
>   

