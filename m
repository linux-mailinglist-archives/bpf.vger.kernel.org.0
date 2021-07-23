Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690423D4362
	for <lists+bpf@lfdr.de>; Sat, 24 Jul 2021 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhGWWnH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 18:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhGWWnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 18:43:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF2DC061757
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 16:23:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n192-20020a25dac90000b029054c59edf217so4130886ybf.3
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ACK2zFOGRnTq5KCIypURS3GDVHBxYVLVyqsJJVg0FMk=;
        b=lLNcg4psUOsaKRc+CNNdYSAdADUFX3ztqdNssUg2Jxn1i3imcx9/YMFcpmS03Ns+Zw
         lrEbcrtdW7Yq5cletMp6tXk//4eq9KIgDi1l1Uog/peo6CQjLEDbC9wIjz4VSkfHKPi6
         BONAzgEG46QB1ON4Y85n574u7w2ocy4/wJdZOIEND1szbNaMnCFPzKQLmuyWcSWu0DxY
         fTqKE1FDLXYMbGgIkmpAy0toNlWpLLcEBBoT7Qwm05bSdNt0GvgcHEhc8PKfrySpcmMq
         SKzFPwHuaL/M/ZOVlcSTV7DbS6VwjwRyJk0sN9/E2yFnpHwJBJGsD4HAlsWqnNVGIl6z
         GkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ACK2zFOGRnTq5KCIypURS3GDVHBxYVLVyqsJJVg0FMk=;
        b=RxNS4buVGPwfk+BjdIDVifYB2t/HJh4ioWqZ2qG6fkOwdq9ZZpTx0xtVu5CWyMcRt1
         d3mFTVqK8ABjf1tfMmeieq5+KTB/4hUzRF7chjWyxhLdp5goAK2mPtRiDBiEwyKaNxKi
         FjlKT1sNyBNC3VKIT/vePEzDywIegEQZG/4buUvMExPf0cq+guimwgybayEHa9uhvNAC
         NcgUfpo4Xg71RJOZfkuc6UA7TFu14hh2nPUDm22ytx+8i7qPKhYS7kNQsKWAvPaKqI5F
         dSWsIP+IwOdl20g610Ezg+zLOlQ6QK1j3ztoXH6eRsxVVbWZyO/aQ1P4nad/3Gpasstn
         64Hw==
X-Gm-Message-State: AOAM530ggW14FOJEo3zWWmFigO1dmsLtCwPUqyT7greatINHQAxffcmA
        vrDOncAr/Igx1fVQEpqwX+DUaLE=
X-Google-Smtp-Source: ABdhPJzf9DgQIK26kVbu7pPykg/NVubmu8bIChdrZgeFH9zr6i4c53MppWWXMpjUrWkzUiJDJTQS0aI=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:627f:b1f:13ac:723b])
 (user=sdf job=sendgmr) by 2002:a25:30c2:: with SMTP id w185mr9411883ybw.321.1627082618018;
 Fri, 23 Jul 2021 16:23:38 -0700 (PDT)
Date:   Fri, 23 Jul 2021 16:23:35 -0700
In-Reply-To: <20210723223939.fr45rzktocvg5usw@kafai-mbp.dhcp.thefacebook.com>
Message-Id: <YPtPd8x+XlLSSpXp@google.com>
Mime-Version: 1.0
References: <20210723002747.3668098-1-sdf@google.com> <20210723223939.fr45rzktocvg5usw@kafai-mbp.dhcp.thefacebook.com>
Subject: Re: [PATCH bpf-next] bpf: increase supported cgroup storage value size
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/23, Martin KaFai Lau wrote:
> On Thu, Jul 22, 2021 at 05:27:47PM -0700, Stanislav Fomichev wrote:
> > Current max cgroup storage value size is 4k (PAGE_SIZE). The other local
> > storages accept up to 64k (BPF_LOCAL_STORAGE_MAX_VALUE_SIZE). Let's  
> align
> > max cgroup value size with the other storages.
> >
> > For percpu, the max is 32k (PCPU_MIN_UNIT_SIZE) because percpu
> > allocator is not happy about larger values.
> >
> > netcnt test is extended to exercise those maximum values
> > (non-percpu max size is close to, but not real max).
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  kernel/bpf/local_storage.c                    | 12 +++++-
> >  tools/testing/selftests/bpf/netcnt_common.h   | 38 +++++++++++++++----
> >  .../testing/selftests/bpf/progs/netcnt_prog.c | 29 +++++++-------
> >  tools/testing/selftests/bpf/test_netcnt.c     | 25 +++++++-----
> >  4 files changed, 73 insertions(+), 31 deletions(-)
> >
> > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > index 7ed2a14dc0de..a276da74c20a 100644
> > --- a/kernel/bpf/local_storage.c
> > +++ b/kernel/bpf/local_storage.c
> > @@ -1,6 +1,7 @@
> >  //SPDX-License-Identifier: GPL-2.0
> >  #include <linux/bpf-cgroup.h>
> >  #include <linux/bpf.h>
> > +#include <linux/bpf_local_storage.h>
> >  #include <linux/btf.h>
> >  #include <linux/bug.h>
> >  #include <linux/filter.h>
> > @@ -284,8 +285,17 @@ static int cgroup_storage_get_next_key(struct  
> bpf_map *_map, void *key,
> >  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
> >  {
> >  	int numa_node = bpf_map_attr_numa_node(attr);
> > +	__u32 max_value_size = PCPU_MIN_UNIT_SIZE;
> >  	struct bpf_cgroup_storage_map *map;
> >
> > +	/* percpu is bound by PCPU_MIN_UNIT_SIZE, non-percu
> > +	 * is the same as other local storages.
> > +	 */
> > +	if (attr->map_type == BPF_MAP_TYPE_CGROUP_STORAGE)
> > +		max_value_size = BPF_LOCAL_STORAGE_MAX_VALUE_SIZE;
> > +
> > +	BUILD_BUG_ON(PCPU_MIN_UNIT_SIZE > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE);
> If PCPU_MIN_UNIT_SIZE did become larger, I assume it would be bounded by
> BPF_LOCAL_STORAGE_MAX_VALUE_SIZE again?

> Instead of BUILD_BUG_ON, how about a min_t here:

> 	if (attr->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> 		max_value_size = min_t(__u32,
> 					BPF_LOCAL_STORAGE_MAX_VALUE_SIZE,
> 					PCPU_MIN_UNIT_SIZE);

Sounds like a much better idea, thanks, will incorporate into v2.
