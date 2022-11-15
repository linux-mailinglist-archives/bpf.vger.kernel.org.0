Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E5E62A149
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 19:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKOS0V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 13:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKOS0V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 13:26:21 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC0113CEA
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:26:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v17so13953485plo.1
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rPHSnauYY4zffLg6cRQMCQegEOu5nJtuVBpj8l37BQ=;
        b=FUFCLVw6MBmY5bBVWwGJ+wkotNm3Ll8Q9ZV+Bb2sKesKywN5YTfEX5NhEaCcdSwJ23
         duZkBLLIWl31TEj7OjwPC0OfPjh7gq8dwNXboqKmK1SkIIyPA3zbXNxlZN/Kr1dAKJfv
         iUgDJ5zXFLIElYYPQ6ALRTtz55pi+iwG6tfxxV0heU6E0pZYPWgaoYfpqMIBSDZHiwoj
         mgSaSIWdEcOFg89Eso17/9Pql1ON2lWbs18as03OkvWyCz3rcAISRB+3BSWFmZVXKNr9
         9j/eLYeVsMhmtWoJkhchVsCIq4mvaTDxTe0wpnVJIc0dN51cXiiAMs3zLLqmFv8K10kE
         lDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rPHSnauYY4zffLg6cRQMCQegEOu5nJtuVBpj8l37BQ=;
        b=7OXVDSt27hp2YAoMU1Bq3865wENaHB+PARmJxxZgyLq5lQBYoumSg44oXPNK01rmEO
         IVwYb/kNzkwqPs1U4zGeYAxrth6J4cXTWE0fUHV0iseD02Aehj7aKLQp5DkEZBywpKaV
         xW3u1/oTqGknLIjSrzDg89KerSy5udROrkIVJrKls8D6eaIoxR8huRthsQd9tsbdaXL5
         25PMJ0tK6WFc47bOx/6Mr47sUZudsdi3iUnpDdlQCxxzaSJK/aCYXbSd8L2WNqbUNaxQ
         KHj/X7s1xHFPnJFYheW0jyYu0kRc69MbZr1qBuiypih7KnwUobwcmT4spHBfNnqtq9CW
         qo5w==
X-Gm-Message-State: ANoB5pm6zvSFithc8N3WjQOWJTObuUJKn2QmYjSXICsocm+Xk1AnNqse
        7ZeQKn5Z/+h+QW6VnbVB7C2BGy1Q4A8=
X-Google-Smtp-Source: AA0mqf4RqPO2xDR8ugm3r4wQtTKSh9LFpFOhxwhGlhpvDURNn4shE0JcN1GN2SM0xIi5D76sOWIeAg==
X-Received: by 2002:a17:90b:2547:b0:215:db2e:bb17 with SMTP id nw7-20020a17090b254700b00215db2ebb17mr3465039pjb.166.1668536779956;
        Tue, 15 Nov 2022 10:26:19 -0800 (PST)
Received: from MacBook-Pro-5.local.dhcp.thefacebook.com ([2620:10d:c090:500::7:32e])
        by smtp.gmail.com with ESMTPSA id e4-20020a6558c4000000b0044046aec036sm8079823pgu.81.2022.11.15.10.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:26:19 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:26:16 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 20/26] bpf: Introduce single ownership BPF
 linked list API
Message-ID: <20221115182616.ctmabyirb7vdpa66@MacBook-Pro-5.local.dhcp.thefacebook.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-21-memxor@gmail.com>
 <20221115062637.hzuo7ehffpuxflsw@macbook-pro-5.dhcp.thefacebook.com>
 <20221115165951.fy7bqwcum3veiz2d@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115165951.fy7bqwcum3veiz2d@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 10:29:51PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Tue, Nov 15, 2022 at 11:56:37AM IST, Alexei Starovoitov wrote:
> > On Tue, Nov 15, 2022 at 12:45:41AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > +}
> > > +
> > > +static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> > > +					   struct bpf_reg_state *reg, u32 regno,
> > > +					   struct bpf_kfunc_call_arg_meta *meta)
> > > +{
> > > +	struct btf_struct_meta *struct_meta;
> > > +	struct btf_field *field;
> > > +	struct btf_record *rec;
> > > +	u32 list_node_off;
> > > +
> > > +	if (meta->btf != btf_vmlinux ||
> > > +	    (meta->func_id != special_kfunc_list[KF_bpf_list_push_front] &&
> > > +	     meta->func_id != special_kfunc_list[KF_bpf_list_push_back])) {
> > > +		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
> >
> > typo. bpf_list_node ?
> >
> > > +		return -EFAULT;
> > > +	}
> > > +
> > > +	if (!tnum_is_const(reg->var_off)) {
> > > +		verbose(env,
> > > +			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
> >
> > same typo?
> >
> 
> These two are typos.
> 
> > > +			regno);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	struct_meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> > > +	if (!struct_meta) {
> > > +		verbose(env, "bpf_list_node not found for allocated object\n");
> > > +		return -EINVAL;
> > > +	}
> > > +	rec = struct_meta->record;
> > > +
> > > +	list_node_off = reg->off + reg->var_off.value;
> > > +	field = btf_record_find(rec, list_node_off, BPF_LIST_NODE);
> > > +	if (!field || field->offset != list_node_off) {
> > > +		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	field = meta->arg_list_head.field;
> > > +
> > > +	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->list_head.btf,
> > > +				  field->list_head.value_btf_id, true)) {
> > > +		verbose(env, "bpf_list_head value type does not match arg#1\n");
> >
> > and the same typo again?!
> >
> 
> This is probably just poorly worded.
> The value type (__contains) of bpf_list_head does not match arg#1 (node).
> 
> What's better, maybe:
> bpf_list_node type does not match bpf_list_head value type?

That would be the case when user is trying to bpf_list_push_head
to head that has __contains tag that point to a different node ?
It feels the users will be hitting this error case from time to time,
so the most verbose message is the best.
Both options above are a bit cryptic.
