Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0734603799
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 03:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJSBkz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 21:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJSBkz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 21:40:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974F7D57EA
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 18:40:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12so15746688pjk.0
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 18:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iaKG9n/sg4IYk4sZm7zjjZa5+xiKvd5HW7L/b2NdfDc=;
        b=TQvSnqWp/DQV8U7g0oszHpofhuwo9n6iAijPVyAJebtCqluoKHBPpkyZ85uAxVeow1
         EUU367oCZKPlErXe861I/eYOOuBt+OWM77LwOgeLkmBqglRA+1kNGEgJ6CvjIj2hRw9e
         YFQ5tP0JVJuZxRwpX2huqGC/Nu/bbN1o91MNQyDp6EfAvfFWZOozu7WQtmaDfWCdkW9f
         pgXKAOo6XxLkRksA9Ohqc1V2YxMm3zqH4HMVsZ6RusK6wMSi9w5rNwjNJgKUitr2Wf+1
         0EGOg4FQgCHfi7DMyFB2tfnXGFzFvPvZAQxhUHIG1hToYjwi5BLPOVizgVkfSa4nRkxm
         dCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaKG9n/sg4IYk4sZm7zjjZa5+xiKvd5HW7L/b2NdfDc=;
        b=kVwb7mfu2T6p1ws3gsNJbySDvnxIlpeBld7nFViFoahyv2Pw2btm+ityUNpdRx7hRX
         XzRgdlBILXN6HsEDtE4IUZkKi9bwxQKI10OZYGvuFODK6Datyg8x7uo7ylQMLtM33V70
         ynj5vbyQ3p9WR5A06B85L2qC9p2gXzHMASSs61+orOKBD+rWqlVGQWY2mnbCaK6ZVzJg
         EonOQcdzokW70DS5l+x34bctUo9+t+uB6O57WrAGBy+GAy2eI/BnWjwktgfKdlKmPYAD
         pu4LICbXB9Xpo7+HCo1WmG6t83sRTesb2v5AIYpMNtfDCxDmBGkzVWNOy4uE9JUmpPws
         tVJQ==
X-Gm-Message-State: ACrzQf2tCk1zzOBikDfYUZuBOhBPWiks5uqvwf8vfUNk1dKDJFf0Y0e0
        I0ddoYialR/SUk1Z9WJWur0=
X-Google-Smtp-Source: AMsMyM6X8Wm3vNbNumbyJqzHLZTQKVo5z/KyNLCAEB/ZJv9nDv8pCFjANNqk8Jvfv4QpW2xhC3+1gQ==
X-Received: by 2002:a17:90b:4b8b:b0:20d:ac2f:8bb2 with SMTP id lr11-20020a17090b4b8b00b0020dac2f8bb2mr33135088pjb.194.1666143652995;
        Tue, 18 Oct 2022 18:40:52 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:a07d])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b00177fb862a87sm9503118plg.20.2022.10.18.18.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:40:52 -0700 (PDT)
Date:   Tue, 18 Oct 2022 18:40:50 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 07/25] bpf: Consolidate spin_lock, timer
 management into fields_tab
Message-ID: <20221019014050.5w5s3ocr6sptmylu@macbook-pro-4.dhcp.thefacebook.com>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-8-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013062303.896469-8-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 11:52:45AM +0530, Kumar Kartikeya Dwivedi wrote:
>  	if (unlikely((map_flags & BPF_F_LOCK) &&
> -		     !map_value_has_spin_lock(map)))
> +		     !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
>  		return -EINVAL;

...

>  	/* We don't reset or free fields other than timer on uref dropping to zero. */
> -	if (!map_value_has_timer(map))
> +	if (!btf_type_fields_has_field(map->fields_tab, BPF_TIMER))

...

> -		     !map_value_has_spin_lock(&smap->map)))
> +		     !btf_type_fields_has_field(smap->map.fields_tab, BPF_SPIN_LOCK)))
>  		return ERR_PTR(-EINVAL);

...

> -	if (!map_value_has_timer(&htab->map))
> +	if (!btf_type_fields_has_field(htab->map.fields_tab, BPF_TIMER))
>  		return;

...

>  	if (unlikely(map_flags & BPF_F_LOCK)) {
> -		if (unlikely(!map_value_has_spin_lock(map)))
> +		if (unlikely(!btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
>  			return -EINVAL;

...

> -	/* We don't reset or free kptr on uref dropping to zero. */
> -	if (!map_value_has_timer(&htab->map))
> +	/* We only free timer on uref dropping to zero */
> +	if (!btf_type_fields_has_field(htab->map.fields_tab, BPF_TIMER))
>  		return;

...
>  	if ((elem_map_flags & ~BPF_F_LOCK) ||
> -	    ((elem_map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
> +	    ((elem_map_flags & BPF_F_LOCK) && !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
>  		return -EINVAL;

...

>  	if (unlikely((flags & BPF_F_LOCK) &&
> -		     !map_value_has_spin_lock(map)))
> +		     !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
>  		return -EINVAL;

...

> -	if (map_value_has_spin_lock(inner_map)) {
> +	if (btf_type_fields_has_field(inner_map->fields_tab, BPF_SPIN_LOCK)) {
>  		fdput(f);
>  		return ERR_PTR(-ENOTSUPP);

...

>  	if ((attr->flags & BPF_F_LOCK) &&
> -	    !map_value_has_spin_lock(map)) {
> +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
>  		err = -EINVAL;
>  		goto err_put;
>  	}
> @@ -1440,7 +1428,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>  	}
>  
>  	if ((attr->flags & BPF_F_LOCK) &&
> -	    !map_value_has_spin_lock(map)) {
> +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
>  		err = -EINVAL;
>  		goto err_put;
>  	}
> @@ -1603,7 +1591,7 @@ int generic_map_delete_batch(struct bpf_map *map,
>  		return -EINVAL;
>  
>  	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> -	    !map_value_has_spin_lock(map)) {
> +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
>  		return -EINVAL;
>  	}
>  
> @@ -1660,7 +1648,7 @@ int generic_map_update_batch(struct bpf_map *map,
>  		return -EINVAL;
>  
>  	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> -	    !map_value_has_spin_lock(map)) {
> +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
>  		return -EINVAL;
>  	}
>  
> @@ -1723,7 +1711,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  		return -EINVAL;
>  
>  	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> -	    !map_value_has_spin_lock(map))
> +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK))
>  		return -EINVAL;
>  
>  	value_size = bpf_map_value_size(map);
> @@ -1845,7 +1833,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>  	}
>  
>  	if ((attr->flags & BPF_F_LOCK) &&
> -	    !map_value_has_spin_lock(map)) {
> +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {

All of these btf_type_fields_has_field() is quite an eyesore.
That was the reason to suggest btf_record_has_field() in the previous email.
