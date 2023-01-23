Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3AE6785A8
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 20:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjAWTB0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 14:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjAWTBZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 14:01:25 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1CE1716;
        Mon, 23 Jan 2023 11:01:25 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-15ebfdf69adso15160690fac.0;
        Mon, 23 Jan 2023 11:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OULmjoxrXNFfajsRwEYVpdk0IuyLfogzJsALOOwtL2c=;
        b=ls1s3XX/FGw4CP9T4NRI7erMiaGxXVIws51ToVCP2lIdQDN8qn2r6B7IS2AdXWGvnO
         UD4pcc03l/qTnusDO8p/+DjWf5z9T1GSfFXqV60CdPZcXPFwUyOsxTy5zA6errt0kpQY
         x7EQ4f/g3BWDp8LPYqTG1diSuSGi8UNYoYLcAOTDl8kd8xXeEQ7ZO7oDVbFM9a6LGHKI
         wO8eQNv8/ykNlLfwbLHElMZdY3/h90eZqiSftFo+zuTLmZQ+J8YHr36tTbFqia/zgw4k
         n8w0nLog294wOGuOP+8mJGaDbUMmc69S9Sx/SdJsQW98fJpIA6c38IUd2Z61CvWdCrpP
         uzxg==
X-Gm-Message-State: AFqh2koJ7RpuOVTm5duQYdlGnLJQd16Sakpfxvw3LQVYi+MqcWtbSRD2
        Y+S23j5NIrFoxEmMeUnWn9U=
X-Google-Smtp-Source: AMrXdXuirt+zBacvFuxugJc4Y3mxgRfVkz+LUawTMuxHLQ5y4JP9qo+PRdmW7oFHFMBDNmT9ySMIGA==
X-Received: by 2002:a05:6870:812:b0:15f:58fd:2b59 with SMTP id fw18-20020a056870081200b0015f58fd2b59mr13801368oab.3.1674500484176;
        Mon, 23 Jan 2023 11:01:24 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id a69-20020ae9e848000000b006ce580c2663sm2990qkg.35.2023.01.23.11.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:01:23 -0800 (PST)
Date:   Mon, 23 Jan 2023 13:01:23 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <Y87Zg1SEOwDmpwmx@maniforge.lan>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
 <Y87We/92xiv5/+g+@maniforge.lan>
 <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 10:54:34AM -0800, Alexei Starovoitov wrote:
> On Mon, Jan 23, 2023 at 12:48:27PM -0600, David Vernet wrote:
> > On Mon, Jan 23, 2023 at 10:33:05AM -0800, Alexei Starovoitov wrote:
> > > On Mon, Jan 23, 2023 at 11:15:06AM -0600, David Vernet wrote:
> > > > -void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > > > +BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
> > > >  {
> > > >  	struct btf_struct_meta *meta = meta__ign;
> > > >  	u64 size = local_type_id__k;
> > > > @@ -1790,7 +1786,7 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > > >  	return p;
> > > >  }
> > > >  
> > > > -void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
> > > > +BPF_KFUNC(void bpf_obj_drop_impl(void *p__alloc, void *meta__ign))
> > > >  {
> > > 
> > > The following also works:
> > > -BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
> > > +BPF_KFUNC(
> > > +void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > > +)
> > > 
> > > and it looks little bit cleaner to me.
> > > 
> > > git grep -A1 BPF_KFUNC
> > > can still find all instances of kfuncs.
> > > 
> > > wdyt?
> > 
> > I'm fine with putting it on its own line if that's your preference.
> > Agreed that it might be a bit cleaner, especially for functions with the
> > return type on its own line, so we'd have e.g.:
> > 
> > BPF_KFUNC(
> > struct nf_conn *
> > bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
> > 		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
> 
> Yeah. Especially for those.
> 
> > ) {
> > 
> > // ...
> > 
> > }
> > 
> > Note the presence of the { on the closing paren. Are you ok with that?
> > Otherwise I think it will look a bit odd:
> 
> Yep. Good idea. Either ){ or ) { look good to me.

Ack, will send v3 with that change later today, along with anything else
if someone else reviews.

> 
> > BPF_KFUNC(
> > struct nf_conn *
> > bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
> > 		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
> > )
> > {
> > 
> > }
> > 
> > Thanks,
> > David
