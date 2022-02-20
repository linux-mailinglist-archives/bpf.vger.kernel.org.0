Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7F4BCBCB
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 03:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiBTCtj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 21:49:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiBTCti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 21:49:38 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A78522FC
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:49:18 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso13426478pjs.1
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g1ne7toJWpb6oXURVIFa40VJHHB00+qQqDWiMkF8yNM=;
        b=lvaMYi/pvD0GJo/1MDJAdiUaeMcMlpNkJofJires/fQqduZiTH8dn06VIYqp8Pa9+Z
         M8X4H5d+GxRqWVD8vX57yPfpZ5VjKxOW/jgE+Z+KCq4TwBSDFOVMlPD7acqoNmTb6BKe
         Det+pHSSkf2RLXaTXDsBtGCvRXl+mwBsRd3ifIawh+T72GESO77b5OY5+8+WVpvT0jDo
         JhQOjxIFxuvfRjGnjxmcS0AAPTsFlnqHOLqHFzOp+1ixOje5mAWaL65Z4VjIYiJf3DOV
         FW6OmqR/OjmnWLC9QbOJ0MxGLUqRQOMxhEXT7wwh1A3X8nO1XNpwGXiSae2a2/tiKKoa
         TXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1ne7toJWpb6oXURVIFa40VJHHB00+qQqDWiMkF8yNM=;
        b=iNfHTckcjCPB+EL3JyFVarcu9jDC2oxkLGDfPVYON1y0aVscSd6V3YX/gBhiLpmsiR
         liL7Qc4zMAsHQ51UEOWNpKGW8q3BW3bE5GFwwBllaHqnvyvqV/kXTJUpkIOvr597wZi/
         uG46X9KpNAjH20YRLo7FhaVsnVTGvVLP8EthZLoBo6OwKRKghm7xTwlXRVGDh9IyKSwp
         mKDhDT5NcdX6UJ7RQaJjSQR/xg+7MjokJvxuwCahvKdq199ZWLQu0RRZu353WpXZt3IB
         DVDRvDZD0UhQ82U01/g5mfRiUpBdNWWI5x3J3Wzt5SZOZO7eWagLQl87UEn/r++uha8U
         BuMw==
X-Gm-Message-State: AOAM530blYlp/d6eBC68aeLoOQH06scszgu0gdQyrPUExtiFPrF6XmO0
        g19BXYLl9zCp1l7jkOsg3zc=
X-Google-Smtp-Source: ABdhPJxUeJZdqc44NOWclEG6P2ivYT15Cv3603Eqax/RygJEbL3oFc8UODn5fChT7GJlGQkidz51gw==
X-Received: by 2002:a17:902:8d8b:b0:14f:795a:977a with SMTP id v11-20020a1709028d8b00b0014f795a977amr8988012plo.104.1645325357962;
        Sat, 19 Feb 2022 18:49:17 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id w16sm5930706pfu.33.2022.02.19.18.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:49:17 -0800 (PST)
Date:   Sun, 20 Feb 2022 08:19:15 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf v1 1/5] bpf: Fix kfunc register offset check for
 PTR_TO_BTF_ID
Message-ID: <20220220024915.nohjpzvsn5bu2opo@apollo.legion>
References: <20220219113744.1852259-1-memxor@gmail.com>
 <20220219113744.1852259-2-memxor@gmail.com>
 <20220220022409.r5y2bovtgz3r2n47@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220022409.r5y2bovtgz3r2n47@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 20, 2022 at 07:54:09AM IST, Alexei Starovoitov wrote:
> On Sat, Feb 19, 2022 at 05:07:40PM +0530, Kumar Kartikeya Dwivedi wrote:
> >
> > +/* Caller ensures reg->type does not have PTR_MAYBE_NULL */
> > +int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > +			   const struct bpf_reg_state *reg, int regno,
> > +			   bool arg_alloc_mem)
> > +{
> > +	enum bpf_reg_type type = reg->type;
> > +	int err;
> > +
> > +	WARN_ON_ONCE(type & PTR_MAYBE_NULL);
>
> So the warn was added and made things more difficult and check had to be moved
> into check_mem_reg to clear that flag?
> Why add that warn in the first place then?
> The logic get convoluted because of that.
>

Ok, will drop.

> > +	if (reg->off < 0) {
> > +		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
> > +			reg_type_str(env, reg->type), regno, reg->off);
> > +		return -EACCES;
> > +	}
>
> Out of the whole patch this part is useful. The rest seems to dealing
> with self inflicted pain.
> Just call check_ptr_off_reg() for kfunc ?

I still think we should call a common helper. For kfunc there are also reg->type
PTR_TO_SOCK etc., for them fixed offset should be rejected. So we can either
have a common helper like this for both kfunc and BPF helpers, or exposing
fixed_off_ok parameter in check_ptr_off_reg. Your wish.

> The patch seems to be doing several things at once. Please split.

--
Kartikeya
