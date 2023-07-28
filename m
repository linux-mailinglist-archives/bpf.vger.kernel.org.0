Return-Path: <bpf+bounces-6157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F49766353
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1E91C217CA
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 04:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DE5244;
	Fri, 28 Jul 2023 04:47:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47023AE
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 04:47:42 +0000 (UTC)
X-Greylist: delayed 548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 21:39:17 PDT
Received: from out-82.mta0.migadu.com (out-82.mta0.migadu.com [91.218.175.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD551113
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 21:39:17 -0700 (PDT)
Date: Thu, 27 Jul 2023 21:30:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690518606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oeaug6qzs0eQ4nGc13g81NO3qlYaI9kruXZlcPjaNCA=;
	b=mFlae5nXrmsuM6Egk52j6FYIY+Lq7QvVDzhZCO2GLmFC95ZCfzdRDMco0VY+XaYuUHq80R
	UXA2NUruCrkIObnRt8kUAVneAxUw4Uo270c1Mo/C8CNDhJebnCki0OOkfpBU01OQJiCXHk
	vjfNw79nij9z/kdzQydGw4x3YY/jt2A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com, robin.lu@bytedance.com
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Message-ID: <ZMNESaE/tWgRd4FI@P9FQF9L96D>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 10:15:16AM +0200, Michal Hocko wrote:
> On Thu 27-07-23 15:36:27, Chuyi Zhou wrote:
> > This patchset tries to add a new bpf prog type and use it to select
> > a victim memcg when global OOM is invoked. The mainly motivation is
> > the need to customizable OOM victim selection functionality so that
> > we can protect more important app from OOM killer.
> 
> This is rather modest to give an idea how the whole thing is supposed to
> work. I have looked through patches very quickly but there is no overall
> design described anywhere either.
> 
> Please could you give us a high level design description and reasoning
> why certain decisions have been made? e.g. why is this limited to the
> global oom sitation, why is the BPF program forced to operate on memcgs
> as entities etc...
> Also it would be very helpful to call out limitations of the BPF
> program, if there are any.

One thing I realized recently: we don't have to make a victim selection
during the OOM, we [almost always] can do it in advance.

Kernel OOM's must guarantee the forward progress under heavy memory pressure
and it creates a lot of limitations on what can and what can't be done in
these circumstances.

But in practice most policies except maybe those which aim to catch very fast
memory spikes rely on things which are fairly static: a logical importance of
several workloads in comparison to some other workloads, "age", memory footprint
etc.

So I wonder if the right path is to create a kernel interface which allows
to define a OOM victim (maybe several victims, also depending on if it's
a global or a memcg oom) and update it periodically from an userspace.
In fact, the second part is already implemented by tools like oomd, systemd-oomd etc.
Someone might say that the first part is also implemented by the oom_score
interface, but I don't think it's an example of a convenient interface.
It's also not a memcg-level interface.

Just some thoughts.

Thanks!

