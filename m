Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1067855E
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 19:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjAWSyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 13:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAWSyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 13:54:38 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8205B83;
        Mon, 23 Jan 2023 10:54:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a184so9549978pfa.9;
        Mon, 23 Jan 2023 10:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KazLxPsscj62JorH0IsS9xsF3e/aKwEvSqPvgJLeLNE=;
        b=FVQZ0hckM6I9dlwb//e9HcHPtVXrzDGzpjqfu8xEaZvyuxDt6i2+kCxgw2GliLdveL
         b06efFcnnZT1171CeDayMXKvOUAWyIgCgSeoYxVHAaxdd/Qo+OF6g4+hUbaNQfvXKtji
         GOo1/Ltk/oyVtKHyvME40gPijUVyxtRCcLEVOMxG0yX7y8gc/GIevGhpo54WZyXT8Suo
         pVHRBsSl7gV3NrvQw7EQApb6E8hQqq5lunC+J+Rsk43ENIZltG57WIBCO3XbOLwpS63+
         RunJIf5K5CQlD2k8aLvq7SlPsupcnlJ8eadIvcbkWmOHXDOGt428D4PrxV/NBazqp2LN
         FEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KazLxPsscj62JorH0IsS9xsF3e/aKwEvSqPvgJLeLNE=;
        b=oWMr8wjdS0HFkzzZrDrHqgb6FQzl9LO2vtkmZyifsj2lHz5W5HCEDKBux9y3QFtoxs
         tuWksbTYps6wctw0WRa7fd6sv/hSJKRbLt9BrHO6MMB90R6jvSUrrMQSvhBo8SfeIk9F
         PXIfak5U1tN0GeJ/89Ccy4OJ+0pgOfthyoX0Cs0xOhS2OM3JCGVlk6LDgbsTsSZTye5j
         Wmu6+IfTU8i+jOKBq+hOFICT5ftvAoUNVovkeQPTk2K2nHPkrfuse6XVFP02bes8VtIm
         P7VazQNZC8zabS19ODMZ/sDS2/axIxd7iiritpzxz5KJjeNKxKNU/N2bLqgAkGQ53FsM
         5JGw==
X-Gm-Message-State: AFqh2krCT8kyvOgGP3VeMD5YsQHPucIm2ZSbDckIysnWXJb5k0xjFIdB
        VvvtVNcgdElHs2V3Ozat/AE=
X-Google-Smtp-Source: AMrXdXup5GKBpxx8kBofhhkREs74t4HOfW+zEnOjXl3OKAJYorZ/5IZhj198DjmS1455fnZoSPCo2A==
X-Received: by 2002:a62:1488:0:b0:586:b33c:be2 with SMTP id 130-20020a621488000000b00586b33c0be2mr26740363pfu.26.1674500077441;
        Mon, 23 Jan 2023 10:54:37 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:500::5:458c])
        by smtp.gmail.com with ESMTPSA id t16-20020aa79470000000b00580f445d1easm20108472pfq.216.2023.01.23.10.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 10:54:36 -0800 (PST)
Date:   Mon, 23 Jan 2023 10:54:34 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
 <Y87We/92xiv5/+g+@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87We/92xiv5/+g+@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 12:48:27PM -0600, David Vernet wrote:
> On Mon, Jan 23, 2023 at 10:33:05AM -0800, Alexei Starovoitov wrote:
> > On Mon, Jan 23, 2023 at 11:15:06AM -0600, David Vernet wrote:
> > > -void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > > +BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
> > >  {
> > >  	struct btf_struct_meta *meta = meta__ign;
> > >  	u64 size = local_type_id__k;
> > > @@ -1790,7 +1786,7 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > >  	return p;
> > >  }
> > >  
> > > -void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
> > > +BPF_KFUNC(void bpf_obj_drop_impl(void *p__alloc, void *meta__ign))
> > >  {
> > 
> > The following also works:
> > -BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
> > +BPF_KFUNC(
> > +void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > +)
> > 
> > and it looks little bit cleaner to me.
> > 
> > git grep -A1 BPF_KFUNC
> > can still find all instances of kfuncs.
> > 
> > wdyt?
> 
> I'm fine with putting it on its own line if that's your preference.
> Agreed that it might be a bit cleaner, especially for functions with the
> return type on its own line, so we'd have e.g.:
> 
> BPF_KFUNC(
> struct nf_conn *
> bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
> 		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)

Yeah. Especially for those.

> ) {
> 
> // ...
> 
> }
> 
> Note the presence of the { on the closing paren. Are you ok with that?
> Otherwise I think it will look a bit odd:

Yep. Good idea. Either ){ or ) { look good to me.

> BPF_KFUNC(
> struct nf_conn *
> bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
> 		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
> )
> {
> 
> }
> 
> Thanks,
> David
