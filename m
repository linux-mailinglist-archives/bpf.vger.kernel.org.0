Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C653C9530
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 02:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhGOAdK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 20:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhGOAdJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 20:33:09 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1BC06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 17:30:15 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a11so3396927ilf.2
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vwvvLTlJPGFSt/NndbPfEzDNZgaqEkkoYgh6UCfNASg=;
        b=LtHejQRgiAQuXT+DuoQTv72U04SdM5Ugdm+5x31rKfR4R0J7zrEP0HbOTk579diAAS
         qOO1qlOLrO2uUF/+NxDJ8VuP94ggWhSijaez94OY5+eTO9jPobPSKu41gJ7VADRW5xaj
         GrA0rzcL/9MMIrA2PYqhE8i5hzjEWPWlO3gqVIVirmWbuWy4ARo5VzoyDpiPNOavWOT9
         UcY2ZQ4YT3b9SpR9V+bslxrheVEitQ7YlY4vrAOXwwO4w71MuhodP+XUExfWgKOXze3u
         fnRNlM+SnIRGNH4Zuk4BTZEC4SO6j/F2cU3eRz/OtrTnYDu6F8YdhzXpu5bQWGpkrQvx
         bvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vwvvLTlJPGFSt/NndbPfEzDNZgaqEkkoYgh6UCfNASg=;
        b=tF+5sQDUZsIIJVVnl7mi8W38Kh32h09bW/sN03WGZF1X7R9jM7/Yw2o+B+g2WWpWMN
         TsXqdBfOublARmcmI8swqXiSGJlrOaSZJTMJcmD387k3sAZ79LCVKSXR3CoRULdd+snO
         EBbswUHXt85idwaGvUgu7jpATXGBOFVR1CGPC+hpHdzHm7xwZOauNi1gC9m5Z5W+iad4
         8SCyuV/3d+JdHxHTUuccFqlkCCnYQzUfU7i2ej9pj5flqWjl9J2uqpKXEG/DoskFYceD
         t0E3mGicsx8h7r+6H91qlu8FYivtv4V73I/NRxVmg0As4AJaORfihF0UBDegSdxK+2iF
         eBIw==
X-Gm-Message-State: AOAM533CqqLJGlOKRF+BOf6IURxi+Fbh72Pa6mTZHxL+OOlYsQhZmpqM
        Hlr9AGLYvgmqJjEyW2KqUfh4qGSqmQdn6A==
X-Google-Smtp-Source: ABdhPJzD4k7nv8CmuYB8xihO4Hmb1lJk21ic9AjNXQ0iqSyxWptP60c4Ya2sZ8B2maFn9BBzl5y+XQ==
X-Received: by 2002:a05:6e02:198f:: with SMTP id g15mr394980ilf.120.1626309015027;
        Wed, 14 Jul 2021 17:30:15 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id i29sm1219556ila.14.2021.07.14.17.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 17:30:14 -0700 (PDT)
Date:   Wed, 14 Jul 2021 17:30:07 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Message-ID: <60ef818f81c18_5a0c120898@john-XPS-13-9370.notmuch>
In-Reply-To: <20210714165440.472566-2-m@lambda.lt>
References: <20210714165440.472566-1-m@lambda.lt>
 <20210714165440.472566-2-m@lambda.lt>
Subject: RE: [PATCH bpf 1/2] libbpf: fix removal of inner map in
 bpf_object__create_map
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martynas Pumputis wrote:
> If creating an outer map of a BTF-defined map-in-map fails (via
> bpf_object__create_map()), then the previously created its inner map
> won't be destroyed.
> 
> Fix this by ensuring that the destroy routines are not bypassed in the
> case of a failure.
> 
> Fixes: 646f02ffdd49c ("libbpf: Add BTF-defined map-in-map support")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  tools/lib/bpf/libbpf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6f5e2757bb3c..1a840e81ea0a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4479,6 +4479,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>  {
>  	struct bpf_create_map_attr create_attr;
>  	struct bpf_map_def *def = &map->def;
> +	int ret = 0;
>  
>  	memset(&create_attr, 0, sizeof(create_attr));
>  
> @@ -4561,7 +4562,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>  	}
>  
>  	if (map->fd < 0)
> -		return -errno;
> +		ret = -errno;
>  

I'm trying to track this down, not being overly familiar with this bit of
code.

We entered bpf_object__create_map with map->inner_map potentially set and
then here we are going to zfree(&map->inner_map). I'm trying to track
down if this is problematic, I guess not? But seems like we could
also free a map here that we didn't create from this call in the above
logic.

>  	if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {

        if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
                if (obj->gen_loader)
                        map->inner_map->fd = -1;
                bpf_map__destroy(map->inner_map);
                zfree(&map->inner_map);
        }


Also not sure here, sorry didn't have time to follow too thoroughly
will check again later. But, the 'map->inner_map->fd = -1' is going to
cause bpf_map__destroy to bypass the close(fd) as I understand it.
So are we leaking an fd if the inner_map->fd is coming from above
create? Or maybe never happens because obj->gen_loader is NULL?

Thanks!


>  		if (obj->gen_loader)
> @@ -4570,7 +4571,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>  		zfree(&map->inner_map);
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
> -- 
> 2.32.0
> 


