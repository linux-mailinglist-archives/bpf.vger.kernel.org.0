Return-Path: <bpf+bounces-7505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A657783E5
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 01:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911A7281DC3
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 23:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7720F6ADE;
	Thu, 10 Aug 2023 23:01:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416786AB2
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 23:01:46 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E456272C;
	Thu, 10 Aug 2023 16:01:45 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-63d0d38ff97so6877826d6.1;
        Thu, 10 Aug 2023 16:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691708504; x=1692313304;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=min45GO03G5ejCVsU6IZ3PRdKPBNDci/T2vJ/EmcOvc=;
        b=bb9dMRDjao7lpudt2gCH47X+qfA23iEONWofEiw1DesQyP2F5ikV77CzyE0ygPK9DO
         1CLqj2ddP0omUxdH0UkCi9Oc/HNhm22Mubt03iMJIGRugivIZBXswoDvlN8UY0AXikqq
         NuWnt4yS3HNbgIuNSbfk4LrW6gIr005SmusNAySVzmWroe/VID+ZEhAM3DXCDhai5l7V
         h2E9gaMj0mYk/8NmD9lx5oXMTSQ9//PV9Ui/NzR7zPYef0bGAG5Lrk1Mw9DY/6yF4dkp
         4KyiJmW4MqHptqL7IYwXeH8lTXueYndh8g7kDhvxDYNEaYxmH9MhRaOPYUed8myPUfuf
         4l3Q==
X-Gm-Message-State: AOJu0YxamQ7FqS6RJzjuMRRkRcw/pLmJVam+/UOwBUp3+0kQrtawgwzE
	G7StiGWZoQCn6DE5lyRcUpFMmZKG+/HnhHst
X-Google-Smtp-Source: AGHT+IGcSNBAzlMcwrKA/RhQr83P2GFCxsynQjFm1trn6cD5OGPUK0p5+SfVKj8wUBy/S9MC/8Ih7A==
X-Received: by 2002:a0c:9a92:0:b0:639:ea27:701e with SMTP id y18-20020a0c9a92000000b00639ea27701emr378331qvd.1.1691708504143;
        Thu, 10 Aug 2023 16:01:44 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:d81f])
        by smtp.gmail.com with ESMTPSA id a1-20020a0ce381000000b006365b23b5dfsm797747qvl.23.2023.08.10.16.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 16:01:43 -0700 (PDT)
Date: Thu, 10 Aug 2023 18:01:41 -0500
From: David Vernet <void@manifault.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, tj@kernel.org, clm@meta.com,
	thinker.li@gmail.com
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Message-ID: <20230810230141.GA529552@maniforge>
References: <20230810220456.521517-1-void@manifault.com>
 <ZNVousfpuRFgfuAo@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNVousfpuRFgfuAo@google.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 03:46:18PM -0700, Stanislav Fomichev wrote:
> On 08/10, David Vernet wrote:
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
> Any reason this is not part of sched_ext series? As you mention,
> we don't seem to have such users in the three?

Hi Stanislav,

The sched_ext series [0] implements these callbacks. See
bpf_scx_update() and bpf_scx_validate(). 

[0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/

We could add this into that series and remove those callbacks, but this
patch is fixing a UX / API issue with struct_ops links that's not really
relevant to sched_ext. I don't think there's any reason to couple
updating struct_ops map elements with allowing the kernel to manage the
lifetime of struct_ops maps -- just because we only have 1 (non-test)
struct_ops implementation in-tree doesn't mean we shouldn't improve APIs
where it makes sense.

Thanks,
David

