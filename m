Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0DA4E7551
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359376AbiCYOr3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354462AbiCYOr3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:47:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510BED8F74
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:45:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p8so6607897pfh.8
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zhh59ufJ9y7lEFw8C7+jh23OE9XJ3bTSBB58T5fAYa0=;
        b=g1Nykvcjb7dVxun0t6Mo0LQJMcfEBLp9Hi5hRPc1sCcMFcoC17ihAVgzP9rRCahMQD
         oGvOCvUClp6DSY3H+9y+606uz62MXtPF0dnh7UC/8Eu+sZ0hjheUzXT3pHgXEZ5VGfx+
         rLrOlFh2C0NNdVWYYLA6x3m4q0pu2M8HfrBQ2ZpcgBJHqHwI7XpQa6l2hoiN/X15Cj6h
         oJmoBKNLcb5gkcvMgv72TkX4n++oMIiv+CG9NhuZJ+NE+1s9Fvb8u22vFNWf4qGvqB00
         J1NORWedCcEuuuz+6lvNqy/mR4CzA+030NigxnMNfdQhS9SB88KPfiMRzO+D1QMO5wKo
         AYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhh59ufJ9y7lEFw8C7+jh23OE9XJ3bTSBB58T5fAYa0=;
        b=TBCoGfFASIWjQ9qaHQpEsNZATBPErwJSQry5HLraKpfmDrBme3OIGl+ep5nRvNxr4I
         k640xlWIOqCUoasMundsTHYcAutLGeXoHPjhE/ALPDEYLZ+T7La9jwZsONy4/dxO0a+i
         VJBxvk/cb3L+UQjSxb6jIBJrGloXimLiz5Wtcc4GSIN5L0CepX/Pf8AZwagEnCWAm9oC
         SI/CPbPAhe4fBn1eOFAqSGELPxw12ZgZdjk6zVAxwngvzU64VrJndRSIPbjXQ2rKNtaU
         VDziyUr/VOt759U4UVWN/QTxKFQ9R/osvO78ed1JNsa5RAhUvu5gEjfuYKS+QiZNR8li
         Pp5A==
X-Gm-Message-State: AOAM533L6aa849LZV+y+Hv3DhErCrIsPCzN9G7Lc/S4TnntjB8wh7xPc
        8yzjfxbAF7C1VxFDAE++F/s=
X-Google-Smtp-Source: ABdhPJxa5gNIt1S8uO4E7DBO4IwUu6EDthzVTUzqzmpEDZpgaJSQ8cvI81RUMWtd0ruRYFrrjf+zhA==
X-Received: by 2002:a63:4a25:0:b0:382:2f93:546a with SMTP id x37-20020a634a25000000b003822f93546amr13347pga.116.1648219554822;
        Fri, 25 Mar 2022 07:45:54 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id n3-20020a056a0007c300b004fa3e9f59cdsm6801964pfu.39.2022.03.25.07.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:45:54 -0700 (PDT)
Date:   Fri, 25 Mar 2022 20:15:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <20220325144551.35zh4g63i72msahg@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-4-memxor@gmail.com>
 <20220322180655.s6m4yzpkmvgfnk7z@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322180655.s6m4yzpkmvgfnk7z@kafai-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 11:36:55PM IST, Martin KaFai Lau wrote:
> On Sun, Mar 20, 2022 at 09:25:00PM +0530, Kumar Kartikeya Dwivedi wrote:
> > @@ -820,9 +904,31 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
> >  			return -EOPNOTSUPP;
> >  	}
> >
> > -	if (map->ops->map_check_btf)
> > +	map->kptr_off_tab = btf_find_kptr(btf, value_type);
> > +	if (map_value_has_kptr(map)) {
> > +		if (!bpf_capable())
> > +			return -EPERM;
> Not sure if this has been brought up.
>
> No need to bpf_map_free_kptr_off_tab() in the case?
>

Good catch, it should indeed be freed.
For the case of map_check_btf in caller, I'm relying on map_free callback to
handle the freeing.

> > +		if (map->map_flags & BPF_F_RDONLY_PROG) {
> > +			ret = -EACCES;
> > +			goto free_map_tab;
> > +		}
> > +		if (map->map_type != BPF_MAP_TYPE_HASH &&
> > +		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> > +		    map->map_type != BPF_MAP_TYPE_ARRAY) {
> > +			ret = -EOPNOTSUPP;
> > +			goto free_map_tab;
> > +		}
> > +	}
> If btf_find_kptr() returns err, it can be ignored and continue ?
>
> btw, it is quite unusual to store an err ptr in map.
> How about only stores NULL or a valid ptr in map->kptr_off_tab?
>

It allows us to report a clear error from process_kptr_func, similar to storing
error in place of spin_lock_off and timer_off, so for consistency I kept it
similar to those. But IS_ERR_OR_NULL still means no kptr_off_tab is present, in
places where it matters we don't distinguish between the two (e.g.
map_value_has_kptr also checks for both).

> > +
> > +	if (map->ops->map_check_btf) {
> >  		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
> > +		if (ret < 0)
> > +			goto free_map_tab;
> > +	}
> >
> > +	return ret;
> > +free_map_tab:
> > +	bpf_map_free_kptr_off_tab(map);
> >  	return ret;
> >  }

--
Kartikeya
