Return-Path: <bpf+bounces-4241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452B8749CCC
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E781C20D80
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C8D8F75;
	Thu,  6 Jul 2023 12:56:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A38F6A
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 12:56:14 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF7AF
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 05:56:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31434226a2eso682996f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688648168; x=1691240168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EiFzalnz/r18fx8xuZCgQRLqeV+3fRm6l/qL6yD4p2Q=;
        b=WSPV6V8NNHL6JocY6NdejyBtvvko/ZGe6t8Y3+2wddDVDVy3c01Y8MKKJn+NxNFKMG
         P3q/K+f/2bkupAG81BJZPYMD0U/t6+KKqX4YnCuUtTMKBNhCQB1XNT/JbRe0pGcaD+YJ
         54PLHTeoUrum5/AFnvjFqxE1jYjTWtxO0lwOrdmSDH042yVtC7ojJa+yH7217BdOAJJl
         xumuWTUQe4++oWxAp1kjH6WWIrK3JZXMgjWx64Ul3dxq0jMhzY2AnnUoSnz/xy7w+15R
         HrYAzZrx0/3bRffdV8hpxofw4yu+DqhJEZUosToWxVrPuOxIJ1OQa6b9wKgi6qZv6CsA
         S/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648168; x=1691240168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiFzalnz/r18fx8xuZCgQRLqeV+3fRm6l/qL6yD4p2Q=;
        b=kd6d3RK/q8UuedMyTiu9dM3XYjS1BV8ZsAsC0LUESsKUgo//ZVXchNGOWVkUcqz22+
         mm3xK8NXFuNSPBFz+37EUuBPfpPHSuNXcWKvKVQvhYNAva0UYGz5sJ3RyN4/7Awmn3yg
         uYYcXg22+zjh59NWYrWRUJ5IHBPIvH7VZdXd6i8FUvq9J8eVcobSeqtma16tDUIOZWHx
         D8JLKCGMMaE54J6zhxhd2ESnRFeDg9dqYQNSt0MUPGZJGb0fXJ5QYYClq7G582SU60aZ
         FSuDWRfLeXSE8EF2f8x+EpfRLe8B47dPR736NdykmwJX8pjM4/RSVeLuBgvknLvyBUNz
         M6mw==
X-Gm-Message-State: ABy/qLZyEVQdwkWd5/GuaAeXxtd4cbRbhCkubHOUDBzllntYRDClXfKY
	KQdjg7SqAXOO3FO+rGDkmeJDmw==
X-Google-Smtp-Source: APBJJlEuWKZvvPVvA7W928F0zh8Z2cmOMMIYuJISqrNpX8Y4EPOjOHy2hiJ8q6Ci4unZDpqzNGaUfQ==
X-Received: by 2002:adf:ea10:0:b0:314:77a:c2b9 with SMTP id q16-20020adfea10000000b00314077ac2b9mr2126231wrm.39.1688648167443;
        Thu, 06 Jul 2023 05:56:07 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l25-20020a1ced19000000b003faef96ee78sm5051673wmh.33.2023.07.06.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:56:06 -0700 (PDT)
Date: Thu, 6 Jul 2023 12:57:16 +0000
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
Subject: Re: [PATCH v4 bpf-next 5/6] selftests/bpf: test map percpu stats
Message-ID: <ZKa6LHj295dY7G+q@zh-lab-node-5>
References: <20230705160139.19967-1-aspsk@isovalent.com>
 <20230705160139.19967-6-aspsk@isovalent.com>
 <5efebb7d-138a-5353-2bc2-a2a1ffa66a2d@huaweicloud.com>
 <ZKarXOLIEWxxsQvJ@zh-lab-node-5>
 <43425377-667b-ab01-951a-0513ef79a59d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43425377-667b-ab01-951a-0513ef79a59d@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 08:21:17PM +0800, Hou Tao wrote:
> Hi,
> 
> On 7/6/2023 7:54 PM, Anton Protopopov wrote:
> > On Thu, Jul 06, 2023 at 06:49:02PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 7/6/2023 12:01 AM, Anton Protopopov wrote:
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
> >>>     * BPF_MAP_TYPE_LRU_HASH, BPF_F_NO_COMMON_LRU
> >>>     * BPF_MAP_TYPE_LRU_PERCPU_HASH, BPF_F_NO_COMMON_LRU
> >>>     * BPF_MAP_TYPE_HASH_OF_MAPS
> >>>
> >>> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> >> Acked-by: Hou Tao <houtao1@huawei.com>
> >>
> >> With two nits below.
> > Thanks, fixed both for v5.
> Great.
> SNIP
> > +static void delete_and_lookup_batch(int map_fd, void *keys, __u32 count)
> > +{
> > +	static __u8 values[(8 << 10) * MAX_ENTRIES];
> > +	void *in_batch = NULL, *out_batch;
> > +	__u32 save_count = count;
> > +	int ret;
> > +
> > +	ret = bpf_map_lookup_and_delete_batch(map_fd,
> > +					      &in_batch, &out_batch,
> > +					      keys, values, &count,
> > +					      NULL);
> > +
> > +	/*
> > +	 * Despite what uapi header says, lookup_and_delete_batch will return
> > +	 * -ENOENT in case we successfully have deleted all elements, so check
> > +	 * this separately
> > +	 */
> >> It seems it is a bug in __htab_map_lookup_and_delete_batch(). I could
> >> post a patch to fix it if you don't plan to do that by yourself.
> > This should be as simple as
> >
> > @@ -1876,7 +1876,8 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
> >         total += bucket_cnt;
> >         batch++;
> >         if (batch >= htab->n_buckets) {
> > -               ret = -ENOENT;
> > +               if (!total)
> > +                       ret = -ENOENT;
> >                 goto after_loop;
> >         }
> >         goto again;
> 
> No. I think changing it to "if (max_count > total) ret = -ENOENT;" will
> be more appropriate, because it means the requested count couldn't been
> fulfilled and it is also consistent with the comments in 
> include/uapi/linux/bpf.h

Say, I have a map of size N and I don't know how many entries there are.
Then I will do

    count=N
    lookup_and_delete(&count)

In this case we will walk through the whole map, reach the 'batch >=
htab->n_buckets', and set the count to the number of elements we read.

(If, in opposite, there's no space to read a whole bucket, then we check this
above and return -ENOSPC.)

> > However, this might be already utilized by some apps to check that they've read
> > all entries. Two local examples are map_tests/map_in_map_batch_ops.c and
> > map_tests/htab_map_batch_ops.c. Another example I know is from BCC tools:
> > https://github.com/iovisor/bcc/blob/master/libbpf-tools/map_helpers.c#L58
> I think these use cases will be fine. Because when the last element has
> been successfully iterated and returned, the out_batch is also updated,
> so if the batch op is called again, -ENOENT will be returned.
> >
> > Can we update comments in include/uapi/linux/bpf.h?
> I think the comments are correct.

Currently we return -ENOENT as an indicator that (a) 'in_batch' is out of
bounds (b) we reached the end of map. So technically, this is an optimization,
as if we read elements in a loop by passing 'in_batch', 'out_batch', even if we
return 0 in case (b), the next syscall would return -ENOENT, because the new
'in_batch' would point to out of bounds.

This also makes sense for a map which is empty: we reached the end of map,
didn't find any elements, so we're returning -ENOENT (in contrast with saying
"all is ok, we read 0 elements").

So from my point of view -ENOENT makes sense. However, comments say "Returns
zero on success" which doesn't look true to me as I think that reading the
whole map in one syscall is a success :)

