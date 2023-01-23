Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764F2678541
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 19:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjAWSsf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 13:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjAWSsd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 13:48:33 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFFB10A9A;
        Mon, 23 Jan 2023 10:48:28 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id y8so9694470qvn.11;
        Mon, 23 Jan 2023 10:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5MyD6fIRFKu+jhSA4qPFQumxMz6XFXiYHlIS1K9ueo=;
        b=nNd2c50bWIb/VvPLRKyytvcpbBE6zq2q0EPxAQ46KXTQhunMO1RhKP5ReRTFxLLvA8
         DPzLDZ82Y0olNflTqV1DmEMf1HWJjqz2AjxHsUjnRuH93ODYjEWb37vnZ74to8DOwVLj
         znf2dM9Q9LLvx9GHC61DUh6YQyyg4sDLncteGzqds0Ucb14xenBMdc+MTPzAi+rqODDz
         ZorGZTHhU6UvT7OToLGPZT7S2juM72BVHZgCokrPnYkwnMVdY8QCs6VxK0V7SKeJErt8
         m/O4rrXX5N4XNmqh8ve29y6tlt9XyA3sWxIcutjra5fp8FQfFJLJgwxTuEGgDKjUe/GM
         0W6g==
X-Gm-Message-State: AFqh2kqGTEf/jOI9xcK8Zw9DNAX3f8BjKK+RweTYxOiJOcgiFr0o9UAu
        M1fJvjUt1iahfYtSVA9kjf8=
X-Google-Smtp-Source: AMrXdXvAn3suxRRTmSY5JV+xXVEwuN5YGro9JvhukSOj6j3T7x7TY9t4ZSSpNStVF+sNERsgKkedCA==
X-Received: by 2002:a0c:fc03:0:b0:537:4b09:670f with SMTP id z3-20020a0cfc03000000b005374b09670fmr18245525qvo.25.1674499707443;
        Mon, 23 Jan 2023 10:48:27 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id l14-20020a05620a28ce00b007062139ecb3sm20778988qkp.95.2023.01.23.10.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 10:48:27 -0800 (PST)
Date:   Mon, 23 Jan 2023 12:48:27 -0600
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
Message-ID: <Y87We/92xiv5/+g+@maniforge.lan>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 10:33:05AM -0800, Alexei Starovoitov wrote:
> On Mon, Jan 23, 2023 at 11:15:06AM -0600, David Vernet wrote:
> > -void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > +BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
> >  {
> >  	struct btf_struct_meta *meta = meta__ign;
> >  	u64 size = local_type_id__k;
> > @@ -1790,7 +1786,7 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> >  	return p;
> >  }
> >  
> > -void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
> > +BPF_KFUNC(void bpf_obj_drop_impl(void *p__alloc, void *meta__ign))
> >  {
> 
> The following also works:
> -BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
> +BPF_KFUNC(
> +void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> +)
> 
> and it looks little bit cleaner to me.
> 
> git grep -A1 BPF_KFUNC
> can still find all instances of kfuncs.
> 
> wdyt?

I'm fine with putting it on its own line if that's your preference.
Agreed that it might be a bit cleaner, especially for functions with the
return type on its own line, so we'd have e.g.:

BPF_KFUNC(
struct nf_conn *
bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
) {

// ...

}

Note the presence of the { on the closing paren. Are you ok with that?
Otherwise I think it will look a bit odd:

BPF_KFUNC(
struct nf_conn *
bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
)
{

}

Thanks,
David
