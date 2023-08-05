Return-Path: <bpf+bounces-7088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2317711F6
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 21:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534061C20A3B
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07293C8DE;
	Sat,  5 Aug 2023 19:59:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423CC8D4
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 19:59:03 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F444FA
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 12:59:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so5525791e87.2
        for <bpf@vger.kernel.org>; Sat, 05 Aug 2023 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691265541; x=1691870341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrmsO5kbeLCgoLNRUeCbTqmbonHAao1zR+4IiEZ1vbI=;
        b=Mv5M/toV1VKXj/5+2HzMWhaVwkqB016YU3SMyxDBLb/7CvxKmhKqyBCjgglqxbvDBK
         bHcnH82unHx5gRrbjOck3ockId/XzEWDnV4BXVBVtBo3R42wd+Jw13oz/dkmgNgsYFBz
         7N0HQBOVs8RGNr9oYF2b/65MPrmBztCdgUYZz0XgAwYvvhnDsuJ20HR7EYyMUKVUqJfN
         yg7Mpw6X350Hoy4mhykgkSpSzwIbpp9rZni7XGT1InTPtdVDe7oq2gzqqvBv5S6iCrNk
         9PzdpEGW65dvc/T7VfFo/JJxQVg4doVXMv9VlzGNGtUmP3MO6lys4jJNVksjwRP5DF7L
         VzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691265541; x=1691870341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrmsO5kbeLCgoLNRUeCbTqmbonHAao1zR+4IiEZ1vbI=;
        b=c0MPHVhi4NKI9NLQa9N3pqSzt/S8obfz6++Lfv6vO63k+JU13dP2X2C5DAsliBrZMZ
         hcddXZz3uap9KvCnNtS8f4TY5Byq+Xq+6FiSwa7DN4O9QUZ9SulBpZuCuZw9/u9MhK8Q
         eS0ym+uPoYCc8LzRLwr/LR/rs7rARpVvtf8mzuQAmen1cT5N5eyyZ4IO/fu+9H5gg2rx
         c261EffhJkgvoxrZ9BKfA9qaj+jzen+apZndR3GwBHPknMnwPoh9pjrXM7z25CJtW/Nh
         hU/vJPAfnZtn4wlU5Ck9O8vy6z/MHqDLRUXAQxRU4rDairIUNcMEIqo9KvJAe8LnJ0sL
         uNZA==
X-Gm-Message-State: AOJu0Yz1e61uX8ZnXZW2Fj9jK0C39Qb/pxyNKe7o9TihEMm/Bdl4ZP1m
	fqqQQ5z41687KnPKvUQT8oQ=
X-Google-Smtp-Source: AGHT+IHx71kv0J30EPJTJTxKfpdLFbpzoCPN84cgtduN3tP2KmDKEq32ngZBTY/9waQboxYB+O7x2g==
X-Received: by 2002:a05:6512:20cc:b0:4f9:5d2a:e0f6 with SMTP id u12-20020a05651220cc00b004f95d2ae0f6mr3170538lfr.14.1691265540503;
        Sat, 05 Aug 2023 12:59:00 -0700 (PDT)
Received: from krava ([83.240.60.134])
        by smtp.gmail.com with ESMTPSA id g17-20020aa7c591000000b00522d742bc4bsm2984720edq.62.2023.08.05.12.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 12:59:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 5 Aug 2023 21:58:58 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: Fix uninitialized symbol in
 bpf_perf_link_fill_kprobe()
Message-ID: <ZM6qAt6gVSJIyy21@krava>
References: <20230804105732.3768-1-laoar.shao@gmail.com>
 <20230804105732.3768-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804105732.3768-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 10:57:31AM +0000, Yafang Shao wrote:
> The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
> perf_event" from Jul 9, 2023, leads to the following Smatch static
> checker warning:
> 
>     kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
>     error: uninitialized symbol 'type'.
> 
> That can happens when uname is NULL. So fix it by verifying the uname
> when we really need to fill it.
> 
> Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain/
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7f4e8c3..166390f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3378,14 +3378,14 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
>  
>  	if (!ulen ^ !uname)
>  		return -EINVAL;
> -	if (!uname)
> -		return 0;
>  
>  	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
>  				      probe_offset, probe_addr);
>  	if (err)
>  		return err;
>  
> +	if (!uname)
> +		return 0;
>  	if (buf) {
>  		len = strlen(buf);
>  		err = bpf_copy_to_user(uname, buf, ulen, len);
> -- 
> 1.8.3.1
> 

