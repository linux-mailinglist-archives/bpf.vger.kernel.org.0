Return-Path: <bpf+bounces-39704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C7897639D
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E5A1C23566
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 07:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE68018FDCE;
	Thu, 12 Sep 2024 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuOGQPtO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D618BC14
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127746; cv=none; b=i0x6EJCOhwjQsCymtA3b/Cz99QGhvPftH4SZqaKP1DR7fnX1m9x2BgmbbIx0ck0P7NMU6KKQYiJ56cnYSmJrGQ01Nt15W7zZLz4icxmqFOL5YgDS/8TQ7ULYi+Wn9SYH3TMT9yl4ctCoN7bGDEEuR7hIO44hj+ZrA2WOh86jP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127746; c=relaxed/simple;
	bh=ddRh97Ob7Gjl02+y8r3wkzu1oYIxqKFs8osHNEZC6+k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojh3oYS9qnKYGwfiIL1d9786cH7u2nelRrC7Wfev+cYyinSle07A9o7jPaLRY1l4TACOHFckCRFPTmWCYOfpcX3LQVYwcBYW4NDafETJcGydCKAmYEIZQi30KU85j0FvqLPxOMET4PLgJdvV0G0a/VNqz+qpvx0mEYdGWON7olo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuOGQPtO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37747c1d928so461119f8f.1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726127743; x=1726732543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCrifiw6EMhK+wujQqxRX8Gq1g6Ilmg1U5LR3nqzhrA=;
        b=ZuOGQPtO6zhTF7+wMTFOpQB/cls5u+54CDb/vlQGdcad01Dl8oamNs3MbJFJ1rUfcb
         vsbkyyPBp9lSRSS42JvU40ypx5b4ezYGF+PMnT8DZMafZQOFKzq2G7Rg+9w7Gfy/ZcoV
         IgAc4RM34wBtWID3ji35GJwQhJCrRoePGp2m4hD1zK0zBlsFhygE8a+xdAtAPu3f3Mdl
         mPq0X4UV8RG0TwmdUeC4YAMLi01RPEzKZkeHX6EWoDKVauttjFo5rDOLMDlraDsu8pqP
         gLxlD26qNSdwQEazyVlwbRq0GL1G+5WQfDHndv5eNG19VEESpWt8bSt2J1Kpclb77lEe
         ecLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726127743; x=1726732543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCrifiw6EMhK+wujQqxRX8Gq1g6Ilmg1U5LR3nqzhrA=;
        b=BU3LZei5iAyVS5qUdKqPRYqsEUidFAEBlW2NoEADeKY0aalY2MnrvFs2gW+3UMOWHk
         WuwEsVncBnhp10t8RW/JK/oQNwI5G3z4cfJmATTE4nmx2Wu45k9iHXGgCKkEPEawvsmq
         4RBA7pfZVirB8O44MTVMUrwzYQNo4E23U496cgjTsxcWsw8JdjVyEA1lQrjoNWUOz3MZ
         kvnA3EAZl+aOLjo7zessgMaDQJU0gCF6+KxPAye8+jOuAY+zsR7PmuHbrKjml+/Gv83P
         oYm2z/A0KqBCGOp2FkmS8xAx203RAqEfwxVTj9Jp+0E7J5TH0UrgQoecH13wiyabTyhP
         HEZw==
X-Gm-Message-State: AOJu0YyaeSuxvs1ZVQ0OfKI+ihjm8H6MHcH1Te3I7dpf66F0FIZUozcd
	UUlmbt3hRveXzUBo8+VvUD70dNMJJOBVowGn5dm7cLiPcW8AaijS
X-Google-Smtp-Source: AGHT+IHT39SAikqeH8nkOi6ToJhE5hIPZGkDfXaIYxN0Ukcj1O4El5WKvMnGPpgBUvnOy7JJaHFBRg==
X-Received: by 2002:adf:f502:0:b0:374:d28e:c8f0 with SMTP id ffacd0b85a97d-378c2cd3be8mr1029689f8f.11.1726127742476;
        Thu, 12 Sep 2024 00:55:42 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caf016a08sm163689645e9.16.2024.09.12.00.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:55:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Sep 2024 09:55:40 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>, houtao1@huawei.com,
	xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 1/2] bpf: Call the missed btf_record_free() when
 map creation fails
Message-ID: <ZuKefIJpkLcBeL-i@krava>
References: <20240912012845.3458483-1-houtao@huaweicloud.com>
 <20240912012845.3458483-2-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912012845.3458483-2-houtao@huaweicloud.com>

On Thu, Sep 12, 2024 at 09:28:44AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When security_bpf_map_create() in map_create() fails, map_create() will
> call btf_put() and ->map_free() callback to free the map. It doesn't
> free the btf_record of map value, so add the missed btf_record_free()
> when map creation fails.
> 
> However btf_record_free() needs to be called after ->map_free() just
> like bpf_map_free_deferred() did, because ->map_free() may use the
> btf_record to free the special fields in preallocated map value. So
> factor out bpf_map_free() helper to free the map, btf_record, and btf
> orderly and use the helper in both map_create() and
> bpf_map_free_deferred().

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/syscall.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6988e432fc3d..1a0dc1d81118 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -735,15 +735,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  	}
>  }
>  
> -/* called from workqueue */
> -static void bpf_map_free_deferred(struct work_struct *work)
> +static void bpf_map_free(struct bpf_map *map)
>  {
> -	struct bpf_map *map = container_of(work, struct bpf_map, work);
>  	struct btf_record *rec = map->record;
>  	struct btf *btf = map->btf;
>  
> -	security_bpf_map_free(map);
> -	bpf_map_release_memcg(map);
>  	/* implementation dependent freeing */
>  	map->ops->map_free(map);
>  	/* Delay freeing of btf_record for maps, as map_free
> @@ -762,6 +758,16 @@ static void bpf_map_free_deferred(struct work_struct *work)
>  	btf_put(btf);
>  }
>  
> +/* called from workqueue */
> +static void bpf_map_free_deferred(struct work_struct *work)
> +{
> +	struct bpf_map *map = container_of(work, struct bpf_map, work);
> +
> +	security_bpf_map_free(map);
> +	bpf_map_release_memcg(map);
> +	bpf_map_free(map);
> +}
> +
>  static void bpf_map_put_uref(struct bpf_map *map)
>  {
>  	if (atomic64_dec_and_test(&map->usercnt)) {
> @@ -1413,8 +1419,7 @@ static int map_create(union bpf_attr *attr)
>  free_map_sec:
>  	security_bpf_map_free(map);
>  free_map:
> -	btf_put(map->btf);
> -	map->ops->map_free(map);
> +	bpf_map_free(map);
>  put_token:
>  	bpf_token_put(token);
>  	return err;
> -- 
> 2.29.2
> 

