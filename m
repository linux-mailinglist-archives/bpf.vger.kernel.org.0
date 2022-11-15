Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15F462A204
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 20:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiKOTga (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 14:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiKOTg3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 14:36:29 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B469FC8
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:36:28 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j12so14090120plj.5
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga/EMhRwwsGebJ4GWq98CXPy+A/eMGDF57GCfjJZmyo=;
        b=UpeVSPd4DQslOHqHns4Gobpc3oS1A/T8rwYniDI3sprWKPn0G2NcDKDg7aJzTQYkpJ
         tXbJrfuqXY5d6QM1RaX+XDCvFMESfkE+gyUfh4dqzIvvOIfiewSHP+R4H94Oo3wP+2Qw
         UV+CeyTKjbAL7eB/hEx4K7UBQ+XMwPKqlHn4KzbBOqFlEPtwVBL+t06Ne2YgqQiUaL0+
         H+gC+a1KkavgflfC+xUaDESWHfOMk7j/i6zWnljHKEwkROjb5i9/HZxai2jfXgK90gvj
         iazicyghUbXQjscQ3jMpoxnecJDINS1uvA7gv8DjWs6tY0YwJ6amd+2tlYHWApkg2ORt
         DnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ga/EMhRwwsGebJ4GWq98CXPy+A/eMGDF57GCfjJZmyo=;
        b=urbJs4JRfTOWJdv3xaS6UilSHhtuyP1rxzgZ0pwgahgQVxtgvmT+isP//g9PvysBI3
         ObMP4bxiWT4fjVtIMPIpd2jzGPuULtoqwCQxPvqQgllaB01XWMh1kbVdF2Rkysn101Cx
         PTm9HIXhwHsnzM+aJsWwSQVB6kMBW/quIdtzB7odDwY9SO6erDprOWO0gJwVAcJTLYGf
         z5LXyO/VdWlwfTC0MTNssFJofZCB+atHrpswMcvPJ0f4GBXa+1iFdJiGIdwnR/H4ADmu
         MLtdHBi/s/7rztSuIlvW4jlsIeMksQOky4hzo/UiWpJl+zxwlDiYnVy0VI8uMEylEjMS
         qqfA==
X-Gm-Message-State: ANoB5pl709ibQ45+n6t7UmuHyvz8kLdvA4yufua3y2zFsu89gTyD51gL
        km+RhzhhClTNFmz4BBeDpcejO+i46rI=
X-Google-Smtp-Source: AA0mqf6gv7q1CcOk1uFsnjSJ/obP033SfnxL6dElHgc7hpXGd2YO49Z1J4PSdr1S4+JmrYFQXQDu/A==
X-Received: by 2002:a17:903:228e:b0:177:faf5:58c5 with SMTP id b14-20020a170903228e00b00177faf558c5mr5524016plh.166.1668540987468;
        Tue, 15 Nov 2022 11:36:27 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b0017f72a430adsm10447344plh.71.2022.11.15.11.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:36:27 -0800 (PST)
Date:   Wed, 16 Nov 2022 01:06:23 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 20/26] bpf: Introduce single ownership BPF
 linked list API
Message-ID: <20221115193623.ncblmxapyiljqsuw@apollo>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-21-memxor@gmail.com>
 <20221115062637.hzuo7ehffpuxflsw@macbook-pro-5.dhcp.thefacebook.com>
 <20221115165951.fy7bqwcum3veiz2d@apollo>
 <20221115182616.ctmabyirb7vdpa66@MacBook-Pro-5.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115182616.ctmabyirb7vdpa66@MacBook-Pro-5.local.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 11:56:16PM IST, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 10:29:51PM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Tue, Nov 15, 2022 at 11:56:37AM IST, Alexei Starovoitov wrote:
> > > On Tue, Nov 15, 2022 at 12:45:41AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > +}
> > > > +
> > > > +static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> > > > +					   struct bpf_reg_state *reg, u32 regno,
> > > > +					   struct bpf_kfunc_call_arg_meta *meta)
> > > > +{
> > > > +	struct btf_struct_meta *struct_meta;
> > > > +	struct btf_field *field;
> > > > +	struct btf_record *rec;
> > > > +	u32 list_node_off;
> > > > +
> > > > +	if (meta->btf != btf_vmlinux ||
> > > > +	    (meta->func_id != special_kfunc_list[KF_bpf_list_push_front] &&
> > > > +	     meta->func_id != special_kfunc_list[KF_bpf_list_push_back])) {
> > > > +		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
> > >
> > > typo. bpf_list_node ?
> > >
> > > > +		return -EFAULT;
> > > > +	}
> > > > +
> > > > +	if (!tnum_is_const(reg->var_off)) {
> > > > +		verbose(env,
> > > > +			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
> > >
> > > same typo?
> > >
> >
> > These two are typos.
> >
> > > > +			regno);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	struct_meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> > > > +	if (!struct_meta) {
> > > > +		verbose(env, "bpf_list_node not found for allocated object\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +	rec = struct_meta->record;
> > > > +
> > > > +	list_node_off = reg->off + reg->var_off.value;
> > > > +	field = btf_record_find(rec, list_node_off, BPF_LIST_NODE);
> > > > +	if (!field || field->offset != list_node_off) {
> > > > +		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	field = meta->arg_list_head.field;
> > > > +
> > > > +	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->list_head.btf,
> > > > +				  field->list_head.value_btf_id, true)) {
> > > > +		verbose(env, "bpf_list_head value type does not match arg#1\n");
> > >
> > > and the same typo again?!
> > >
> >
> > This is probably just poorly worded.
> > The value type (__contains) of bpf_list_head does not match arg#1 (node).
> >
> > What's better, maybe:
> > bpf_list_node type does not match bpf_list_head value type?
>
> That would be the case when user is trying to bpf_list_push_head
> to head that has __contains tag that point to a different node ?

Right.

> It feels the users will be hitting this error case from time to time,
> so the most verbose message is the best.
> Both options above are a bit cryptic.

How about something like this?

operation on bpf_list_head expects node at offset=X in struct foo, but
node is at offset=Y in struct bar
