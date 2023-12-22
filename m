Return-Path: <bpf+bounces-18614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CDD81CB7E
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108A31F22642
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B422F16;
	Fri, 22 Dec 2023 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpqRjoZi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2023762;
	Fri, 22 Dec 2023 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e6d802507so244922e87.3;
        Fri, 22 Dec 2023 06:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703256363; x=1703861163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6Hq4vW9fNgGpc1tTdXoyGQdaQer83r96MY4PH5v2bY=;
        b=WpqRjoZildY8BxI5JeIY6z6u+Fb8MPZX4seNvGoh7KaH1YHyRYZIABCbqxAGOxex1V
         WfHO6ScZTQEQpuLpNPXRkAl/w4qIwmN733WnOyymB+/k09YepWethlj/Odl6qlZeMf7d
         H8qc7Bak3nf4CK0DopPOBX/m1ED6dI3Op/e9zFtoMUf5cDlSfx4W1wrHwwDgK2W5NI8M
         4f4zL5emYNOeG5jRmIqnH2QYqlI9ai68bC5mvoDuK1tUIjdhHH+kpEmV1d0FjPXaDYzw
         uJgckEE0MSp/sEReaqge7C2RpO6c3RFJVdPD1rjNix1tOMIueyhVOams+uCKcaUZAQjk
         sKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703256363; x=1703861163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6Hq4vW9fNgGpc1tTdXoyGQdaQer83r96MY4PH5v2bY=;
        b=Vr+1dxIkeOMiQElPoMMAhHX6Rna5E5o2DB5L7fT68UFr+KktfYzpaCKczCDXGFH1wY
         2NtD98GrI71+pNg0LdBXiAd0iHsifBDvxiH4+vBi7WZVFCS/hUPRq7v82cS+tx1Cg8Wk
         Sh9LkWpPswFmDUAD913Ne14VGIhcYSn6NjlgAsk7QhozNqGu1xy0MHlO5HyYE7DDayiB
         /UxkS14vD4mxRu0o5FNQrcrKprB6NNd0BuMB8uegYZR1LU7cfEKNtRtroa/yx036ExCi
         tveB4ojAN7Bh6lnUSipsMCSc2BYXX8jfsaEhlvfMh3EZQZ1bNqX2iWO5RVvaiDcSnGiJ
         zwiA==
X-Gm-Message-State: AOJu0YxXs8vwZz09qIY5jTv4/fsEvp/aCcAX0Jft5whaPPuSgPzXn7Q1
	qMXlqjhnoLJS5Yi1wlrn7wA=
X-Google-Smtp-Source: AGHT+IGQT/ZpwVP/54vx177PdrDlnXtJhuJur2CHKuSEFj68B+9kIasgApDJ+o3yggkrQB+Z/M18tw==
X-Received: by 2002:a05:6512:3ca1:b0:50e:6e0a:f01f with SMTP id h33-20020a0565123ca100b0050e6e0af01fmr163769lfv.109.1703256363047;
        Fri, 22 Dec 2023 06:46:03 -0800 (PST)
Received: from krava (host-87-27-10-76.business.telecomitalia.it. [87.27.10.76])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7d0d7000000b005533a9934b6sm2628792edo.54.2023.12.22.06.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:46:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Dec 2023 15:45:58 +0100
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com, hengqi@linux.alibaba.com,
	shung-hsi.yu@suse.com
Subject: Re: [PATCH bpf-next 2/3] bpf: implement map_update_elem to init
 relay file
Message-ID: <ZYWhJh0G8iyVkCWC@krava>
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
 <20231222122146.65519-3-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222122146.65519-3-lulie@linux.alibaba.com>

On Fri, Dec 22, 2023 at 08:21:45PM +0800, Philo Lu wrote:
> map_update_elem is used to create relay files and bind them with the
> relay channel, which is created with BPF_MAP_CREATE. This allows users
> to set a custom directory name. It must be used with key=NULL and
> flag=0.
> 
> Here is an example:
> ```
> struct {
> __uint(type, BPF_MAP_TYPE_RELAY);
> __uint(max_entries, 4096);
> } my_relay SEC(".maps");
> ...
> char dir_name[] = "relay_test";
> bpf_map_update_elem(map_fd, NULL, dir_name, 0);
> ```
> 
> Then, directory `/sys/kerenl/debug/relay_test` will be created, which
> includes files of my_relay0...my_relay[#cpu]. Each represents a per-cpu
> buffer with size 8 * 4096 B (there are 8 subbufs by default, each with
> size 4096B).
> 
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  kernel/bpf/relaymap.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
> index d0adc7f67758..588c8de0a4bd 100644
> --- a/kernel/bpf/relaymap.c
> +++ b/kernel/bpf/relaymap.c
> @@ -117,7 +117,37 @@ static void *relay_map_lookup_elem(struct bpf_map *map, void *key)
>  static long relay_map_update_elem(struct bpf_map *map, void *key, void *value,
>  				   u64 flags)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_relay_map *rmap;
> +	struct dentry *parent;
> +	int err;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (unlikely(key))
> +		return -EINVAL;
> +
> +	rmap = container_of(map, struct bpf_relay_map, map);
> +
> +	/* The directory already exists */
> +	if (rmap->relay_chan->has_base_filename)
> +		return -EEXIST;
> +
> +	/* Setup relay files. Note that the directory name passed as value should
> +	 * not be longer than map->value_size, including the '\0' at the end.
> +	 */
> +	((char *)value)[map->value_size - 1] = '\0';
> +	parent = debugfs_create_dir(value, NULL);
> +	if (IS_ERR_OR_NULL(parent))
> +		return PTR_ERR(parent);
> +
> +	err = relay_late_setup_files(rmap->relay_chan, map->name, parent);
> +	if (err) {
> +		debugfs_remove_recursive(parent);
> +		return err;
> +	}

looks like this patch could be moved to the previous one?

jirka

> +
> +	return 0;
>  }
>  
>  static long relay_map_delete_elem(struct bpf_map *map, void *key)
> -- 
> 2.32.0.3.g01195cf9f
> 
> 

