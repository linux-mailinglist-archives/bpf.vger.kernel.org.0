Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EDE603955
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 07:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJSFoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 01:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJSFoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 01:44:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513B750F9F
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 22:44:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p14so16259658pfq.5
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 22:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kMThIkweOsDNjCxaEvQpI3K7iJsdLhvrFipiaGZbdc=;
        b=Hy0HZWpnRv/Y2ydA3bSIktx5wi0/DG3zVnTXxHtTRDty1L8smxW8iXe1JhCTC8zE+c
         yK6Xn7xgc1y7XdzZzRTNmmUPARDIsp3FI82/o/TIkljPMqifnG3MNU5LGATY2UjdZB2U
         +IVvm5Qcz2XJvZvMSOiULhXHXc07AXf0MQvpSBuk8fQtQyif6gy5DzhgShAYxr6SDL2h
         80F6fmokl1VDuMYqPjTwFWqoA2bWsKRPLK+0bfjaRcczR5f2Jhh34oj/EHlJ5VsIeg7I
         Gdq+E3yiG1e313x89+wAHSzcKPnoBjTMcg8PcEp5dHGY3KdCHlRPtAXsX6K3FyIDze0n
         XIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kMThIkweOsDNjCxaEvQpI3K7iJsdLhvrFipiaGZbdc=;
        b=rEKWdrNCFiAuknJlZYP/GgWmHSEXGJ4tmd4MltvNaWQ60+hheew4ZC0pDsqqs3gI9r
         VoRlmp2KQtBDZsRl/3W+8d99VvjuTh8CDMSFOt2C7+F2Tph+t3anNDCpbCeOQ1Si5rMY
         W3RU0wPgU3fa1Z9qEo31/PiBCDVXS0OMpml2HEJk75IyJNvw6D1gB3cUZGZQIRYziC3L
         q6mlTPC3RGHhnOs6NhszZhmwHC1FVTOeqx074RxTpYX3SLQi2o1CSSTFyHdWyoA2n4eA
         iPyBannHgRDhKYemLiGodDNXJk3nRjN1svEzJ6o/RfF5HnYh06Neio9lz+LAOfEuSN9H
         d0QQ==
X-Gm-Message-State: ACrzQf3ue3ZiCQmuuRpRkV2Km8KBoXcm9pD24QztY8Jm/kgaM67A27PJ
        1M301yWqSbqC08AaUsXoXtz+DA1PjZfQcg==
X-Google-Smtp-Source: AMsMyM6ukXXlb8zDb3HW8lzIexCKnHnjTDQpUEQEWGrvP3X0rG67CWvEmzYDNbBpkRr+Nc/3AJTeFg==
X-Received: by 2002:a63:d34c:0:b0:462:589b:b27e with SMTP id u12-20020a63d34c000000b00462589bb27emr5922569pgi.418.1666158250776;
        Tue, 18 Oct 2022 22:44:10 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 73-20020a63064c000000b0043c732e1536sm9076129pgg.45.2022.10.18.22.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:44:10 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:13:59 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 07/25] bpf: Consolidate spin_lock, timer
 management into fields_tab
Message-ID: <20221019054359.ffsw5psanndy25ow@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-8-memxor@gmail.com>
 <20221019014050.5w5s3ocr6sptmylu@macbook-pro-4.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019014050.5w5s3ocr6sptmylu@macbook-pro-4.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 07:10:50AM IST, Alexei Starovoitov wrote:
> On Thu, Oct 13, 2022 at 11:52:45AM +0530, Kumar Kartikeya Dwivedi wrote:
> >  	if (unlikely((map_flags & BPF_F_LOCK) &&
> > -		     !map_value_has_spin_lock(map)))
> > +		     !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
> >  		return -EINVAL;
>
> ...
>
> >  	/* We don't reset or free fields other than timer on uref dropping to zero. */
> > -	if (!map_value_has_timer(map))
> > +	if (!btf_type_fields_has_field(map->fields_tab, BPF_TIMER))
>
> ...
>
> > -		     !map_value_has_spin_lock(&smap->map)))
> > +		     !btf_type_fields_has_field(smap->map.fields_tab, BPF_SPIN_LOCK)))
> >  		return ERR_PTR(-EINVAL);
>
> ...
>
> > -	if (!map_value_has_timer(&htab->map))
> > +	if (!btf_type_fields_has_field(htab->map.fields_tab, BPF_TIMER))
> >  		return;
>
> ...
>
> >  	if (unlikely(map_flags & BPF_F_LOCK)) {
> > -		if (unlikely(!map_value_has_spin_lock(map)))
> > +		if (unlikely(!btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
> >  			return -EINVAL;
>
> ...
>
> > -	/* We don't reset or free kptr on uref dropping to zero. */
> > -	if (!map_value_has_timer(&htab->map))
> > +	/* We only free timer on uref dropping to zero */
> > +	if (!btf_type_fields_has_field(htab->map.fields_tab, BPF_TIMER))
> >  		return;
>
> ...
> >  	if ((elem_map_flags & ~BPF_F_LOCK) ||
> > -	    ((elem_map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
> > +	    ((elem_map_flags & BPF_F_LOCK) && !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
> >  		return -EINVAL;
>
> ...
>
> >  	if (unlikely((flags & BPF_F_LOCK) &&
> > -		     !map_value_has_spin_lock(map)))
> > +		     !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
> >  		return -EINVAL;
>
> ...
>
> > -	if (map_value_has_spin_lock(inner_map)) {
> > +	if (btf_type_fields_has_field(inner_map->fields_tab, BPF_SPIN_LOCK)) {
> >  		fdput(f);
> >  		return ERR_PTR(-ENOTSUPP);
>
> ...
>
> >  	if ((attr->flags & BPF_F_LOCK) &&
> > -	    !map_value_has_spin_lock(map)) {
> > +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
> >  		err = -EINVAL;
> >  		goto err_put;
> >  	}
> > @@ -1440,7 +1428,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
> >  	}
> >
> >  	if ((attr->flags & BPF_F_LOCK) &&
> > -	    !map_value_has_spin_lock(map)) {
> > +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
> >  		err = -EINVAL;
> >  		goto err_put;
> >  	}
> > @@ -1603,7 +1591,7 @@ int generic_map_delete_batch(struct bpf_map *map,
> >  		return -EINVAL;
> >
> >  	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> > -	    !map_value_has_spin_lock(map)) {
> > +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
> >  		return -EINVAL;
> >  	}
> >
> > @@ -1660,7 +1648,7 @@ int generic_map_update_batch(struct bpf_map *map,
> >  		return -EINVAL;
> >
> >  	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> > -	    !map_value_has_spin_lock(map)) {
> > +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
> >  		return -EINVAL;
> >  	}
> >
> > @@ -1723,7 +1711,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >  		return -EINVAL;
> >
> >  	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> > -	    !map_value_has_spin_lock(map))
> > +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK))
> >  		return -EINVAL;
> >
> >  	value_size = bpf_map_value_size(map);
> > @@ -1845,7 +1833,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
> >  	}
> >
> >  	if ((attr->flags & BPF_F_LOCK) &&
> > -	    !map_value_has_spin_lock(map)) {
> > +	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
>
> All of these btf_type_fields_has_field() is quite an eyesore.
> That was the reason to suggest btf_record_has_field() in the previous email.

I agree, what do you think of calling it btf_type_has_field? You pass in the
btf_type_record and the field type.
