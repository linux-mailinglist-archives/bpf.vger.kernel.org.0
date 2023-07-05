Return-Path: <bpf+bounces-4068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A41748818
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0D61C20B4D
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A111CB0;
	Wed,  5 Jul 2023 15:33:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F852D526
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 15:33:01 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86D171C
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 08:32:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc0981755so77765575e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688571178; x=1691163178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1Q2WBPiU+a447wQ6AIF6oSydJXukz8tbL9yWQBlQjA=;
        b=YaW8j7yzU6bHEXJ5ZD7q5U35VirSPd0++L0eBDTrM2J6X5cB5C3I+yGSDVrAZP/JJ8
         XkDfEAcO8LYE5eMN93MKyzjmMlFPtQwHo1RepeVj9KaK53h0GwUIiS8tc8rh/J0hgZoI
         T19vlpE765Kw5jtgG6CU/2zRrcnKi1AClDf8zgrfCSHMNI3yC/CJCbT353PWL8NJ6xkD
         2iPZc5wjxR6LjlzqhxoTu1FV9lIoG9p96t0DJ9V+MkPAQ4SeS0QyRvbLf5mhsqwG4y+a
         uPlLylEw3UwYJtY+f/Re10/xGj/v5Jw3JGY0zIbByOLZghE3K7Y6YapNYjkOuGgEYTUY
         fN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688571178; x=1691163178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1Q2WBPiU+a447wQ6AIF6oSydJXukz8tbL9yWQBlQjA=;
        b=YrEk7mMwVYELc7DI2qvOeC3w4x+N++xJX480vHJIQo5rADn5HfgaLFHEQgeTPo+D6x
         50Rwr11n/3DOHtD70DRZCiT+/s2KgmLO57CqNlUdbCVFeWF1FyuDVoNGVC/dknKqPcFp
         pgKiG2ujJCmqWiwENpZQC1HuZiZlTszdf/+35HFVbRkYLTlb2eJbTF4aRZ/MeRwMb2XS
         yiF9WvmCrCo0WYfmuZcbRX5gClwCUgt6Sd9ue2uOmAT1XXhuGvEIYYCZ+LsnKwXwWaYq
         Q23sk8IGVwwej9WoK4p0wbzzie1Y1TlGMUfHIl1S3BC5G6NopzbYdd6q+Fys1qripDOb
         Fy0g==
X-Gm-Message-State: AC+VfDytCtM7ZUSOtQG+RxeJOseoDuq2PMt1PId8zQHRVjO+KAx3/Ilx
	ZzSJeOJy8m54ZImyGMFl7SqcBw==
X-Google-Smtp-Source: ACHHUZ591dCfNqKHmzmIr1fP3CrjEgW6sCbas0VyWjBDXeComWiqCfFzpI+2wRx8TKxAMpC/GCF6+g==
X-Received: by 2002:a7b:cd11:0:b0:3f7:b1df:26d with SMTP id f17-20020a7bcd11000000b003f7b1df026dmr14190964wmj.38.1688571177839;
        Wed, 05 Jul 2023 08:32:57 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c029900b003fbb06af219sm2461044wmk.32.2023.07.05.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:32:57 -0700 (PDT)
Date: Wed, 5 Jul 2023 15:34:08 +0000
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
Subject: Re: [v3 PATCH bpf-next 5/6] selftests/bpf: test map percpu stats
Message-ID: <ZKWNcE5emIW9X1O1@zh-lab-node-5>
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-6-aspsk@isovalent.com>
 <3e761472-051d-4e46-8a66-79926493e5db@huawei.com>
 <ZKQ0iF+8fMND5Qmg@zh-lab-node-5>
 <525f2690-f367-6296-8dde-0138ba8aa42f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525f2690-f367-6296-8dde-0138ba8aa42f@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 11:03:25AM +0800, Hou Tao wrote:
> Hi,
> 
> On 7/4/2023 11:02 PM, Anton Protopopov wrote:
> > On Tue, Jul 04, 2023 at 10:41:10PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 6/30/2023 4:25 PM, Anton Protopopov wrote:
> >>> Add a new map test, map_percpu_stats.c, which is checking the correctness of
> >>> map's percpu elements counters.  For supported maps the test upserts a number
> >>> of elements, checks the correctness of the counters, then deletes all the
> >>> elements and checks again that the counters sum drops down to zero.
> >>>
> >>> The following map types are tested:
> >>>
> >>>     * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
> >>>     * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
> >>>     * BPF_MAP_TYPE_HASH,
> >>>     * BPF_MAP_TYPE_PERCPU_HASH,
> >>>     * BPF_MAP_TYPE_LRU_HASH
> >>>     * BPF_MAP_TYPE_LRU_PERCPU_HASH
> >> A test for BPF_MAP_TYPE_HASH_OF_MAPS is also needed.
> We could also exercise the test for LRU map with BPF_F_NO_COMMON_LRU.

Thanks, added.

> >
> SNIP
> >>> diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
> >>> new file mode 100644
> >>> index 000000000000..5b45af230368
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
> >>> @@ -0,0 +1,336 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/* Copyright (c) 2023 Isovalent */
> >>> +
> >>> +#include <errno.h>
> >>> +#include <unistd.h>
> >>> +#include <pthread.h>
> >>> +
> >>> +#include <bpf/bpf.h>
> >>> +#include <bpf/libbpf.h>
> >>> +
> >>> +#include <bpf_util.h>
> >>> +#include <test_maps.h>
> >>> +
> >>> +#include "map_percpu_stats.skel.h"
> >>> +
> >>> +#define MAX_ENTRIES 16384
> >>> +#define N_THREADS 37
> >> Why 37 thread is needed here ? Does a small number of threads work as well ?
> > This was used to evict more elements from LRU maps when they are full.
> 
> I see. But in my understanding, for the global LRU list, the eviction
> (the invocation of htab_lru_map_delete_node) will be possible if the
> free element is less than LOCAL_FREE_TARGET(128) * nr_running_cpus. Now
> the number of free elements is 1000 as defined in __test(), the number
> of vCPU is 8 in my local VM setup (BPF CI also uses 8 vCPUs) and it is
> hard to trigger the eviction because 8 * 128 is roughly equal with 1000.
> So I suggest to decrease the number of free elements to 512 and the
> number of threads to 8, or adjust the number of running thread and free
> elements according to the number of online CPUs.

Yes, makes sense. I've changed the test to use 8 threads and offset of 512.

