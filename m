Return-Path: <bpf+bounces-7556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADC779283
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1152281ECE
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B3829E1A;
	Fri, 11 Aug 2023 15:09:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25B63B6
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 15:09:39 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394D4171F;
	Fri, 11 Aug 2023 08:09:38 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1a28de15c8aso1766413fac.2;
        Fri, 11 Aug 2023 08:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766577; x=1692371377;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=debaR9w83oy3hy7pUMTqrCGw8R8d+IK8qQ6gmlwHI6E=;
        b=j+dNrUsMR0gbBJmqLl6vS7qOcY9VBHi+e7Zym12MklQnkXtabIQNq01xv8d4YVJvsv
         gzC9/Pfz6jFDroxizEiCmJvopmMrK3FDUvaeILXfO2nEIPml7PaWRahQ5u+nysryg5Aw
         voO5NG8ffW30ENC9xoop8IQyTDQpZoeyKo4IF51Kz+g8MK068VRIx+iZeLimvg/aUFzw
         kKR2e3SNE/Iwkbd4aknLGUGKkWa4ejKLwLXcnRkZbPqAmnHb6YqOcXFw0o5uSlCyaelC
         6mqhMra985OrnwI1Wn48d581NHVGX1BMr6LkBRMbiONXviI23g8pqNFdwR+j0DN7WMZF
         YfNQ==
X-Gm-Message-State: AOJu0YzXtPizTSWP0qIneFHq7pda4ydaw4CpdueAIG3q43Ll5QlW7/Up
	mvVsOR6CSzehk8kpJLvCy3I=
X-Google-Smtp-Source: AGHT+IFeGwTh9IZhXRWR8Y++SyaE1HUn3wCocYTxJwLj8RTVcxi5sOkSV1Dq/lqXvwcPGMow1RX4Sg==
X-Received: by 2002:a05:6871:1cb:b0:1b0:12d7:1ef6 with SMTP id q11-20020a05687101cb00b001b012d71ef6mr2405364oad.25.1691766577381;
        Fri, 11 Aug 2023 08:09:37 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id p188-20020a0dcdc5000000b00583f8f41cb8sm1048301ywd.63.2023.08.11.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:09:37 -0700 (PDT)
Date: Fri, 11 Aug 2023 10:09:34 -0500
From: David Vernet <void@manifault.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
	clm@meta.com, thinker.li@gmail.com
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Message-ID: <20230811150934.GA542801@maniforge>
References: <20230810220456.521517-1-void@manifault.com>
 <371c72e1-f2b7-8309-0329-cdffc8a3f98d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371c72e1-f2b7-8309-0329-cdffc8a3f98d@linux.dev>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 11:43:26PM -0700, Yonghong Song wrote:
> 
> 
> On 8/10/23 3:04 PM, David Vernet wrote:
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
> 
> Maybe you want to add one map_flag to indicate validate/update callbacks
> are optional for a struct_ops link? In this case, some struct_ops maps
> can still require validate() and update(), but others can skip them?

Are you proposing that a map flag be added that a user space caller can
specify to say that they're OK with a struct_ops implementation not
supporting .validate() and .update(), but still want to use a link to
manage registration and unregistration?  Assuming I'm understanding your
suggestion correctly, I don't think it's what we want. Updating a
struct_ops map value is arguably orthogonal to the bpf link handling
registration and unregistration, so it seems confusing to require a user
to specify that it's the behavior they want as there's no reason they
shouldn't want it. If they mistakenly thought that update element is
supposed for that struct_ops variant, they'll just get an -EOPNOTSUPP
error at runtime, which seems reasonable. If a struct_ops implementation
should have implemented .validate() and/or .update() and neglects to,
that would just be a bug in the struct_ops implementation.

Apologies if I've misunderstood your proposal, and please feel free to
clarify if I have.

Thanks,
David

> 
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
> >   	err = st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
> >   	if (err)
> >   		goto err_out;

