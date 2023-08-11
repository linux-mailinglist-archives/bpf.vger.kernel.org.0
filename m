Return-Path: <bpf+bounces-7557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58FD779290
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2C6282382
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E4E2AB29;
	Fri, 11 Aug 2023 15:11:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2963B6
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 15:11:04 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04652D78;
	Fri, 11 Aug 2023 08:11:03 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-586a684e85aso23169497b3.2;
        Fri, 11 Aug 2023 08:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766663; x=1692371463;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/CYVLCrkE1ApXeKmNRKbHX2DlTn9R8U9zKDOGqrr0o=;
        b=kRCvhsZAsBCSWMyi5V7e/80YKGGNGxk7BiNmxeT6eGbz2KKTVBMAz77FgO2V+H8f++
         GlhLCRKGBK9+FuuQmAX2aHg0+dZhWJG4KJxLPUaqvs20HvRfssCeyh7YcS38+MU6Xihi
         Jiv10QzQcK/tPsCq/j5WxnsYAgTC0rrMkqBh/z5CmSZFE0qnY2sCWnR/sWJzcVzjhT/E
         dE2bjDGyM3ET5QsBtka9ShjO+/RzCjkIf79xetGbn4MSIZS3G2tWtAeOMlY8lY5e42aj
         nKW/eqYZG7OXbp50LDFlBwmH8RUSr/WP/JmmH+Z12Z6v/detZp28tZiCXutdZDe1DfIs
         ea3w==
X-Gm-Message-State: AOJu0Yx6h5RLflqeJQ/cZaDVK+HVFTau7UDNu2N1zg92FgGW/J2oZb97
	0loqnj3tmG8VzyjfVZAK/x8=
X-Google-Smtp-Source: AGHT+IGPiYcQorhGbIlOVwG0FmdMZh6kLVstbsq2Y8WuI0ZXLlpGhgwgJaHxBxYKLNS/akfJinyCCQ==
X-Received: by 2002:a25:77c9:0:b0:d3c:5c3e:c2a with SMTP id s192-20020a2577c9000000b00d3c5c3e0c2amr1921241ybc.24.1691766662763;
        Fri, 11 Aug 2023 08:11:02 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id 62-20020a250241000000b00d51f2b8e7fdsm200802ybc.55.2023.08.11.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:11:02 -0700 (PDT)
Date: Fri, 11 Aug 2023 10:10:59 -0500
From: David Vernet <void@manifault.com>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
	clm@meta.com, thinker.li@gmail.com
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Message-ID: <20230811151059.GB542801@maniforge>
References: <20230810220456.521517-1-void@manifault.com>
 <1fb5d153-7f5d-0024-92e0-8ae75a2eb7cc@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb5d153-7f5d-0024-92e0-8ae75a2eb7cc@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 11:22:04PM -0700, Kui-Feng Lee wrote:
> Overall, this patch make sense to me.

Thanks for the review.

> On 8/10/23 15:04, David Vernet wrote:
> > Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
> > define the .validate() and .update() callbacks in its corresponding
> > struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
> > in its own right to ensure that the map is unloaded if an application
> > crashes. For example, with sched_ext, we want to automatically unload
> > the host-wide scheduler if the application crashes. We would likely
> > never support updating elements of a sched_ext struct_ops map, so we'd
> > have to implement these callbacks showing that they _can't_ support
> > element updates just to benefit from the basic lifetime management of
> > struct_ops links.
> > 
> > Let's enable struct_ops maps to work with BPF_F_LINK even if they
> > haven't defined these callbacks, by assuming that a struct_ops map
> > element cannot be updated by default.
> > 
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >   kernel/bpf/bpf_struct_ops.c | 17 +++++++++++------
> >   1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index eaff04eefb31..3d2fb85186a9 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -509,9 +509,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> >   	}
> >   	if (st_map->map.map_flags & BPF_F_LINK) {
> > -		err = st_ops->validate(kdata);
> > -		if (err)
> > -			goto reset_unlock;
> > +		err = 0;
> > +		if (st_ops->validate) {
> > +			err = st_ops->validate(kdata);
> > +			if (err)
> > +				goto reset_unlock;
> > +		}
> >   		set_memory_rox((long)st_map->image, 1);
> >   		/* Let bpf_link handle registration & unregistration.
> >   		 *
> > @@ -663,9 +666,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
> >   	if (attr->value_size != vt->size)
> >   		return ERR_PTR(-EINVAL);
> > -	if (attr->map_flags & BPF_F_LINK && (!st_ops->validate || !st_ops->update))
> > -		return ERR_PTR(-EOPNOTSUPP);
> > -
> >   	t = st_ops->type;
> >   	st_map_size = sizeof(*st_map) +
> > @@ -838,6 +838,11 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
> >   		goto err_out;
> >   	}
> > +	if (!st_map->st_ops->update) {
> > +		err = -EOPNOTSUPP;
> > +		goto err_out;
> > +	}
> > +
> 
> We can perform this check before calling mutex_lock(), and
> return -EOPNOTSUPP early.

Yep, let's do the check outside of that global mutex. Will make that
change for v2.

Thanks,
David

