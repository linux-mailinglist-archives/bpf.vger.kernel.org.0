Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D3629F85
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKOQtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKOQtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:49:05 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CFC10B4F
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:49:04 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso14389348pjc.2
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=52F4/iCQxDUABHh9vrrVVw3vrf3HQelEWXj1pB5jUyE=;
        b=iOerES9uNgJMIIgqxvp7+ASfp+HKr1MAkQjcnpDSqTlfoqH3xY8Ln64oh3zqqQVH5a
         JSP4LjoGhYWyOhj5tDpWeDMSdRks/M0tv3T/dWdzs5ywnAR60sekfsfEvI8perEX9518
         vqKwWIkGJaHl3EXmtDt8/Uo7kc3pifRn5z06+tts9C5AC8aiuzgIgpyL2uK2ZsUEMWOV
         dfSIZajd3L/aEQ+s/kqHtuBc3vqU+Y3CtU7sOKMQkqmywI+yRTjy4rf4mLQDSZ4U+/V+
         6DP9LXUWHKxohLSycKteClLygineZovckhSfLB/xo364UzkBvIzrsdHVuY7Sgz3xiW48
         xuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52F4/iCQxDUABHh9vrrVVw3vrf3HQelEWXj1pB5jUyE=;
        b=InJOqscHKT8V50nRM3rjjFJbDCU+jx25+nBG6Obo4BXyFblWbj6W642hGWDbPzoLWP
         CzqdAKmNhbA7+bzysz+ZDdEUwusudgrFGn5hNVDDHd/YmVbBxIX1cv+sqYPmeEkE+Ouy
         iyxIbfIErsmb4BlwORrnkno3sefDYpYNuMQgkdQF5RS8/GCIZFhQAW2/JLDqMpa65A0V
         t09n4YYGeJgloAO5mkRNXqtvb04UL2O9PYb/t6SCsATEWEGNfHcYuCpC72QIJRk7T74q
         7BxVFhwtWVJwzaSv94dstTmg0u0yNKVUtX30NYj3tNyBlIqSBoB8fGgMl7EaZ+yBALDJ
         WPjw==
X-Gm-Message-State: ANoB5pk8Iy+VdzIeYrAWkl35yxQaONyRJ/X881DBw0akAkIOqeRtPVRe
        Fn3JY1iWIhu4PbzkdpsT56w=
X-Google-Smtp-Source: AA0mqf4C5QA29eQCZa7cV/Bu8w/PF9pibtNfsy6EXmuQ+uullgQOOjsXizeXrnHA744VlLwp8J9sng==
X-Received: by 2002:a17:902:bcca:b0:17f:52af:d022 with SMTP id o10-20020a170902bcca00b0017f52afd022mr4879652pls.122.1668530944340;
        Tue, 15 Nov 2022 08:49:04 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ec9100b0018863e1bd3csm10193087plg.134.2022.11.15.08.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:49:04 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:18:59 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 09/26] bpf: Recognize lock and list fields in
 allocated objects
Message-ID: <20221115164859.mesyjyi4crxl3g3y@apollo>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-10-memxor@gmail.com>
 <20221115055034.pf2onw7iddm2vtku@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115055034.pf2onw7iddm2vtku@macbook-pro-5.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 11:20:34AM IST, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 12:45:30AM +0530, Kumar Kartikeya Dwivedi wrote:
> > +	parse:
> > +		if (!tab) {
> > +			tab = kzalloc(offsetof(struct btf_struct_metas, types[1]),
> > +				      GFP_KERNEL | __GFP_NOWARN);
> > +			if (!tab)
> > +				return ERR_PTR(-ENOMEM);
> > +		} else {
> > +			struct btf_struct_metas *new_tab;
> > +
> > +			new_tab = krealloc(tab, offsetof(struct btf_struct_metas, types[tab->cnt + 1]),
> > +					   GFP_KERNEL | __GFP_NOWARN);
> > +			if (!new_tab) {
> > +				ret = -ENOMEM;
> > +				goto free;
> > +			}
> > +			tab = new_tab;
> > +		}
>
> If @p is %NULL, krealloc() behaves exactly like kmalloc().
>
> That can help to simplify above a bit?
>

Great suggestion, I made the change.

> > +		type = &tab->types[tab->cnt];
> > +
> > +		type->btf_id = i;
> > +		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE, t->size);
> > +		if (IS_ERR_OR_NULL(record)) {
> > +			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
> > +			goto free;
> > +		}
> > +		foffs = btf_parse_field_offs(record);
> > +		if (WARN_ON_ONCE(IS_ERR_OR_NULL(foffs))) {
>
> WARN_ON_ONCE ?
> Pls add a comment.
>

I'll drop this, it doesn't have to be a WARN_ON_ONCE. But still we must fail
when field_offs can't be constructed for a valid btf_record. btf_record enables
field discovery, but without field_offs we will never skip over them or rewrite
them to 0 (and zero init is critical for everything else which assumes it).

I'll add a comment that both should be set or we should simply bail.
