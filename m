Return-Path: <bpf+bounces-4423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C574AF79
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 13:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AF01C20FCD
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB16C13C;
	Fri,  7 Jul 2023 11:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC7BA47
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 11:06:15 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF651725
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:05:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so2603471e87.3
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688727947; x=1691319947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PMAZP+FtCiLtD819FWH3KgGQOQryYY6K8KcRsYSCxmI=;
        b=MLr3Oy6xMe+8qUSHbGGnnVGN56Qn0vSQ2xSC1BGuRzkL9QYeSC/IDnjTPeyqBXbLq4
         hss0P83Or5R0RpFCHeTyMSSrqYI9JPB5ChQCm3pMWv2Piq2sPB/U7kovRd5MPw9FAM7k
         lEPVahiSd4Gi7Uo3No1mRO7NdLeraiQsWdAToHY/BfDOuItP+qUpFf+t1rMOTyRgTqX0
         bj/yeGWZ3Bv1xhaGNitom/CJGn6BxTPxyMQ88sOURAIpcWNDHSAX749L2xpel32lC9iD
         dDytbDg8Em/++xJrllyI6AXq1WaJ6pgZUYH+BelFdW+7iBtiZvTyJdXb81PeDMNrjZLa
         VH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688727947; x=1691319947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMAZP+FtCiLtD819FWH3KgGQOQryYY6K8KcRsYSCxmI=;
        b=IdvGNJWFpQJ9mCkyYSApgRUIx5xEJhVBXRm54RHs4h/iUf2cOobWi21Nuf5PNeICOm
         ENjnzn4wMOaBIf7rjKBLSFJtgtUzgQhTedI/ySJQudsYL1U5JOuHiNM++8fkQRWGZIav
         cAIZx5Bxnmmv0AkuwEZN5JW3AspkpB9bsfB/Fgz68A9naowArDM8Sx2gLv46DGIRj7d+
         5OOV/znJVo0a2QkMmW9y7Mqk4OAADYDzEcQmkkWCxMOwOaTwJBM5Hb7FvKIXRuiqDsGL
         wcq/Wz/q8aZ22AajQycVXdUTLraWxCwDqfG7jPHnsXUztKI+pm1TyNWsi8Q+mIO9NONS
         BKbA==
X-Gm-Message-State: ABy/qLZ9HGthuUkk7Gz+hVh91ROWv3NBfvS+Za5fLVGaLFHSXlztrtW1
	Xtmievgh6+xz/b2SuStJVNz+fw==
X-Google-Smtp-Source: APBJJlHYNbK2rPp79KArzxkWDmyJdNI+a9psruXFlZ6V6EHAnz80JTfB6mvPoMESG2VguXzX+SOh/g==
X-Received: by 2002:a19:6705:0:b0:4fb:8939:d962 with SMTP id b5-20020a196705000000b004fb8939d962mr3504934lfc.19.1688727947055;
        Fri, 07 Jul 2023 04:05:47 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bcb90000000b003fbdd5d0758sm2117981wmi.22.2023.07.07.04.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:05:46 -0700 (PDT)
Date: Fri, 7 Jul 2023 11:06:55 +0000
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
Message-ID: <ZKfxz2BB83jGwQJG@zh-lab-node-5>
References: <20230705160139.19967-1-aspsk@isovalent.com>
 <20230705160139.19967-6-aspsk@isovalent.com>
 <5efebb7d-138a-5353-2bc2-a2a1ffa66a2d@huaweicloud.com>
 <ZKarXOLIEWxxsQvJ@zh-lab-node-5>
 <43425377-667b-ab01-951a-0513ef79a59d@huaweicloud.com>
 <ZKa6LHj295dY7G+q@zh-lab-node-5>
 <6bf45335-67ef-4eb0-0e97-c3b3ee55a451@huaweicloud.com>
 <ZKe+kudf9kSQatjB@zh-lab-node-5>
 <25b0dd44-ecd5-989a-63b5-d0156b5e4b34@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25b0dd44-ecd5-989a-63b5-d0156b5e4b34@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 05:40:28PM +0800, Hou Tao wrote:
> Hi,
> 
> On 7/7/2023 3:28 PM, Anton Protopopov wrote:
> > On Fri, Jul 07, 2023 at 09:41:03AM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 7/6/2023 8:57 PM, Anton Protopopov wrote:
> >>> On Thu, Jul 06, 2023 at 08:21:17PM +0800, Hou Tao wrote:
> >>>> Hi,
> >>>>
> >>>> On 7/6/2023 7:54 PM, Anton Protopopov wrote:
> >>>>
> >> SNIP
> >>>>> +static void delete_and_lookup_batch(int map_fd, void *keys, __u32 count)
> >>>>> +{
> >>>>> +	static __u8 values[(8 << 10) * MAX_ENTRIES];
> >>>>> +	void *in_batch = NULL, *out_batch;
> >>>>> +	__u32 save_count = count;
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	ret = bpf_map_lookup_and_delete_batch(map_fd,
> >>>>> +					      &in_batch, &out_batch,
> >>>>> +					      keys, values, &count,
> >>>>> +					      NULL);
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * Despite what uapi header says, lookup_and_delete_batch will return
> >>>>> +	 * -ENOENT in case we successfully have deleted all elements, so check
> >>>>> +	 * this separately
> >>>>> +	 */
> >>>>>> It seems it is a bug in __htab_map_lookup_and_delete_batch(). I could
> >>>>>> post a patch to fix it if you don't plan to do that by yourself.
> >>>>> This should be as simple as
> >>>>>
> >>>>> @@ -1876,7 +1876,8 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
> >>>>>         total += bucket_cnt;
> >>>>>         batch++;
> >>>>>         if (batch >= htab->n_buckets) {
> >>>>> -               ret = -ENOENT;
> >>>>> +               if (!total)
> >>>>> +                       ret = -ENOENT;
> >>>>>                 goto after_loop;
> >>>>>         }
> >>>>>         goto again;
> >>>> No. I think changing it to "if (max_count > total) ret = -ENOENT;" will
> >>>> be more appropriate, because it means the requested count couldn't been
> >>>> fulfilled and it is also consistent with the comments in 
> >>>> include/uapi/linux/bpf.h
> >>> Say, I have a map of size N and I don't know how many entries there are.
> >>> Then I will do
> >>>
> >>>     count=N
> >>>     lookup_and_delete(&count)
> >>>
> >>> In this case we will walk through the whole map, reach the 'batch >=
> >>> htab->n_buckets', and set the count to the number of elements we read.
> >>>
> >>> (If, in opposite, there's no space to read a whole bucket, then we check this
> >>> above and return -ENOSPC.)
> >>>
> >>>>> However, this might be already utilized by some apps to check that they've read
> >>>>> all entries. Two local examples are map_tests/map_in_map_batch_ops.c and
> >>>>> map_tests/htab_map_batch_ops.c. Another example I know is from BCC tools:
> >>>>> https://github.com/iovisor/bcc/blob/master/libbpf-tools/map_helpers.c#L58
> >>>> I think these use cases will be fine. Because when the last element has
> >>>> been successfully iterated and returned, the out_batch is also updated,
> >>>> so if the batch op is called again, -ENOENT will be returned.
> >>>>> Can we update comments in include/uapi/linux/bpf.h?
> >>>> I think the comments are correct.
> >>> Currently we return -ENOENT as an indicator that (a) 'in_batch' is out of
> >>> bounds (b) we reached the end of map. So technically, this is an optimization,
> >>> as if we read elements in a loop by passing 'in_batch', 'out_batch', even if we
> >>> return 0 in case (b), the next syscall would return -ENOENT, because the new
> >>> 'in_batch' would point to out of bounds.
> >>>
> >>> This also makes sense for a map which is empty: we reached the end of map,
> >>> didn't find any elements, so we're returning -ENOENT (in contrast with saying
> >>> "all is ok, we read 0 elements").
> >>>
> >>> So from my point of view -ENOENT makes sense. However, comments say "Returns
> >>> zero on success" which doesn't look true to me as I think that reading the
> >>> whole map in one syscall is a success :)
> >> I get your point. The current implementation of BPF_MAP_LOOKUP_BATCH
> >> does the following two things:
> >> 1) returns 0 when the whole map has not been iterated but there is no
> >> space for current bucket.
> > The algorithm works per bucket. For a bucket number X it checks if there is
> > enough space in the output buffer to store all bucket elements. If there is,
> > ok, go to the next bucket. If not, then it checks if any elements were written
> > already [from previous buckets]. If not, then it returns -ENOSPC, meaning,
> > "you've asked to copy at most N elements, but I can only copy M > N, not less,
> > please provide a bigger buffer."
> Yes.
> >
> >> 2) doesn't return 0 when the whole map has been iterated successfully
> >> (and the requested count is fulfilled)
> >>
> >> For 1) I prefer to update the comments in uapi. If instead we fix the
> >> implementation, we may break the existed users which need to check
> >> ENOSPC to continue the batch op.
> >> For 2) I don't have a preference. Both updating the comments and
> >> implementation are fine to me.
> >>
> >> WDYT ?
> >>
> > I think that (1) is perfectly fine, -ENOSPC is returned only when we can't copy
> > elements, which is an error.
> 
> Maybe I misinterpreted the comments in bpf.h. As said in the comment:
> "On success, *count* elements from the map are copied into the user
> buffer",  I think the count here means the value of count which is used
> as input instead of output.

Yes, also may be updated, as this is actually "up to *count*" (*count* is an
output parameter which is not mentioned in the LOOKUP_BATCH description, only
in LOOKUP_AND_DELETE_BATCH). On the other side, the LOOKUP_AND_DELETE_BATCH
comment says "delete at least count" which is not true as well.

> > The (2) requires updating docs. The API is similar to get_next_key, and docs
> > can be updated in the same way. By updating docs we're not changing any uapi,
> > right?
> I think it is fine.

