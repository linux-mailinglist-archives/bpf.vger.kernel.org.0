Return-Path: <bpf+bounces-4236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CEA749BA3
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1861C20B43
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF38F5C;
	Thu,  6 Jul 2023 12:23:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0C8F55
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 12:23:59 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F88F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 05:23:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313e09a5b19so1621524f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688646236; x=1691238236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFDs5cFl9SHGaYW3wSEbu47pGuAEqgjSurwcZ14XDs0=;
        b=UzBbagadOsNwvPjM5MU+Pg0f3SJjYdkd8fifVxVVIP6Y+i5jFlB340cjZwKugGD3ld
         pvN9RzNNHFMTgVpXrVHEhrn5DdmjLHdoBiAfLRsBiNUbDW06zEL4hgQoVWESNERjW3XK
         otgq4wCFJGF5zJA4B5krp6L8JbgaOyYtc1dBpuRY3f69Jla/I5wmtujzzSRUDe0Xcy8r
         q25TdWzSMhbEFYd1bIs/0h4TkI1N+iXkh9/GK9RVw5LyJcTwQ6FxmDpHW+guuV84mw2E
         3t1NE5zvnTF+RqT/D0J6kcinjIA2yEYox1zauCKXucGBzZlLfCLKImaSqdPIcVxLAI2e
         c3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688646236; x=1691238236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFDs5cFl9SHGaYW3wSEbu47pGuAEqgjSurwcZ14XDs0=;
        b=g/hMqSk7Zkc+Hfv5qX5PfjBLQ04ZnqnkUex1hIem9pJ+vBQEWyf0LAEu+YsBRLI8Re
         NQMWizkXI8fq85EayBgD5P4ts6MucgTYpZmmKAdZcD0kY9+nmQwp7IKnmOQkP0iM9xSW
         HD1B7V+1dqaH6Qcm/ioAoXqLQRiUO72hkApfiyeuyA58WDzrma7zUicZWINGeHHUlFLs
         XAMXj1S46KmKi0zA9C1HWhRdo2GVjZ0JCWssad6DiJDCKLjVufbJ9LOCd9m87aQn+Qb/
         5qwZBs4gmCWGnhBV1wShYapO8NiJhRDzdu8b3RmMVfktmZal1WLukq7zAuM8LydZ4yhl
         KmkA==
X-Gm-Message-State: ABy/qLZmuKCzZmMvxra63bLOILQgNTV+l3QGZRvy3vKkB26m7lM+ys5g
	rllZdQaIXyWvzB0KMXc5ATB+X1W2QVLbo+SUjzlnnA==
X-Google-Smtp-Source: APBJJlGomYBhTbmGP7dcXsJcgh4mNc3wkg5sIAL8X8ViDfMVLIDl4XjCRu9pp2lyZV/w7GRh3n9GBA==
X-Received: by 2002:a05:6000:1103:b0:313:e2e3:d431 with SMTP id z3-20020a056000110300b00313e2e3d431mr4468787wrw.12.1688646236067;
        Thu, 06 Jul 2023 05:23:56 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id k21-20020a7bc415000000b003fbd1c8d230sm5012421wmi.20.2023.07.06.05.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:23:55 -0700 (PDT)
Date: Thu, 6 Jul 2023 12:25:05 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: Re: [v3 PATCH bpf-next 3/6] bpf: populate the per-cpu
 insertions/deletions counters for hashmaps
Message-ID: <ZKayoTYomkVc/i3r@zh-lab-node-5>
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-4-aspsk@isovalent.com>
 <05a3c521-3c6f-79c2-a5a8-1f8ab35eb759@huaweicloud.com>
 <ZKQt84Qz0A0ZkgN1@zh-lab-node-5>
 <b1b9e2b8-f31e-abf5-8853-cb64bb0232a6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b9e2b8-f31e-abf5-8853-cb64bb0232a6@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 10:01:26AM +0800, Hou Tao wrote:
> Hi,
> 
> On 7/4/2023 10:34 PM, Anton Protopopov wrote:
> > On Tue, Jul 04, 2023 at 09:56:36PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 6/30/2023 4:25 PM, Anton Protopopov wrote:
> >>> Initialize and utilize the per-cpu insertions/deletions counters for hash-based
> >>> maps. Non-trivial changes only apply to the preallocated maps for which the
> >>> {inc,dec}_elem_count functions are not called, as there's no need in counting
> >>> elements to sustain proper map operations.
> >>>
> >>> To increase/decrease percpu counters for preallocated maps we add raw calls to
> >>> the bpf_map_{inc,dec}_elem_count functions so that the impact is minimal. For
> >>> dynamically allocated maps we add corresponding calls to the existing
> >>> {inc,dec}_elem_count functions.
> >>>
> >>> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> >>> ---
> >>>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++++---
> >>>  1 file changed, 20 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >>> index 56d3da7d0bc6..faaef4fd3df0 100644
> >>> --- a/kernel/bpf/hashtab.c
> >>> +++ b/kernel/bpf/hashtab.c
> >>> @@ -581,8 +581,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >>>  		}
> >>>  	}
> >>>  
> >>> +	err = bpf_map_init_elem_count(&htab->map);
> >>> +	if (err)
> >>> +		goto free_extra_elements;
> >> Considering the per-cpu counter is not always needed, is it a good idea
> >> to make the elem_count being optional by introducing a new map flag ?
> > Per-map-flag or a static key? For me it looked like just doing an unconditional
> > `inc` for a per-cpu variable is better vs. doing a check then `inc` or an
> > unconditional jump.
> 
> Sorry I didn't make it clear that I was worried about the allocated
> per-cpu memory. Previous I thought the per-cpu memory is limited, but
> after did some experiments I found it was almost the same as kmalloc()
> which could use all available memory to fulfill the allocation request.
> For a host with 72-cpus, the memory overhead for 10k hash map is about
> ~6MB. The overhead is tiny compared with the total available memory, but
> it is avoidable.

So, in my first patch I've only added new counters for preallocated maps. But
then the feedback was that we need a generic percpu inc/dec counters, so I
added them by default. For me a percpu s64 looks cheap enough for a hash map...

