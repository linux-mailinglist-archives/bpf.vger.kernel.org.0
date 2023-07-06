Return-Path: <bpf+bounces-4229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6625749B2C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7347928127D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41978F4D;
	Thu,  6 Jul 2023 11:53:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9948F49
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 11:53:01 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC951723
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:52:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso815867e87.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688644375; x=1691236375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl39Oxt3/gh/NoyvyKMsA5UxOazizav1+vQ3cIs79tQ=;
        b=IZ7xOxUFLtYNPpRbdXS8pRl2zVCVcqEe7kT6ItOqrnEi7kOiw+1Hx1GZTINcrPORqu
         wGeT0LjR+MbeaTfunobHweaYmIg08MTq6WmKmn68XiQnltQcr6vH+rGz62XV6Tqe1Jmy
         ydUi/PPAo6KuN/TtajtxkHsmPux+lmbgxaRVI2ywtnmaYA0kb8ll1fjhMjd0uRmPwF07
         vwhC5cJo+f2PAzW3gL6oUq/2kKAjkG/7k+7oWlKjuNPzLHelD7qLY97gtNoLM3Xp4inp
         QDmTrbxmwLEuzrjyJptct+Ag5/YVOW6W3h8ETEPaf/V+md3IYpvgOGeRPKpLTKaoAAgB
         R5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688644375; x=1691236375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl39Oxt3/gh/NoyvyKMsA5UxOazizav1+vQ3cIs79tQ=;
        b=OqvIfybI0riRei9L9GfNCkvb7YcJjJNiBf7bQb36/HwnDZC3JcT8OH6F+CKL4a/zS0
         lye+F9O3e0hY4aivkIJHk9+9x8B3MH6DK8tjQmJoeNmPpBDoVZkqYJsHKMFWNT6Z5NmZ
         2sJ9DTE3BmNfdPu1aEWNMyL4HDcgS/FWAbvika5yxoeqoDkGe6biEl7KC2jWBSSOX6Wk
         IUhpH39AZ8Agdcq0Z0qMAPcuROcM3GMiwUX6Gnz9+PYRelcmPZ6eiEZNVifE2kwEO8eF
         9g9fa40ZzYw0NzPw3cvTfNJ2eYZUd0hjVwXKor0UrZEa6cPaCGBroxbVcZGD3oS1aAPF
         OkMw==
X-Gm-Message-State: ABy/qLb44lSKQ3tPhP3JTWsoOPm9Cgg04hvGi2duGwsMmKJ91q4OzoXs
	FBhDfhZ1EBEA5MCNYz18ylyMCA==
X-Google-Smtp-Source: APBJJlF0k9PLjZ9PDTUIPYZWFlP5GE1RXKz9EPisDe1eTHoE3dSREmxMZf5W6jCsjGsR46qte8Spxg==
X-Received: by 2002:a05:6512:3990:b0:4f8:770f:1b01 with SMTP id j16-20020a056512399000b004f8770f1b01mr1345183lfu.19.1688644374984;
        Thu, 06 Jul 2023 04:52:54 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d43cd000000b00314427091a2sm1664137wrr.98.2023.07.06.04.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:52:54 -0700 (PDT)
Date: Thu, 6 Jul 2023 11:54:04 +0000
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
Message-ID: <ZKarXOLIEWxxsQvJ@zh-lab-node-5>
References: <20230705160139.19967-1-aspsk@isovalent.com>
 <20230705160139.19967-6-aspsk@isovalent.com>
 <5efebb7d-138a-5353-2bc2-a2a1ffa66a2d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5efebb7d-138a-5353-2bc2-a2a1ffa66a2d@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 06:49:02PM +0800, Hou Tao wrote:
> Hi,
> 
> On 7/6/2023 12:01 AM, Anton Protopopov wrote:
> > Add a new map test, map_percpu_stats.c, which is checking the correctness of
> > map's percpu elements counters.  For supported maps the test upserts a number
> > of elements, checks the correctness of the counters, then deletes all the
> > elements and checks again that the counters sum drops down to zero.
> >
> > The following map types are tested:
> >
> >     * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
> >     * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
> >     * BPF_MAP_TYPE_HASH,
> >     * BPF_MAP_TYPE_PERCPU_HASH,
> >     * BPF_MAP_TYPE_LRU_HASH
> >     * BPF_MAP_TYPE_LRU_PERCPU_HASH
> >     * BPF_MAP_TYPE_LRU_HASH, BPF_F_NO_COMMON_LRU
> >     * BPF_MAP_TYPE_LRU_PERCPU_HASH, BPF_F_NO_COMMON_LRU
> >     * BPF_MAP_TYPE_HASH_OF_MAPS
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> 
> Acked-by: Hou Tao <houtao1@huawei.com>
> 
> With two nits below.

Thanks, fixed both for v5.

> > +
> > +static const char *map_type_to_s(__u32 type)
> > +{
> > +	switch (type) {
> > +	case BPF_MAP_TYPE_HASH:
> > +		return "HASH";
> > +	case BPF_MAP_TYPE_PERCPU_HASH:
> > +		return "PERCPU_HASH";
> > +	case BPF_MAP_TYPE_LRU_HASH:
> > +		return "LRU_HASH";
> > +	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> > +		return "LRU_PERCPU_HASH";
> > +	default:
> > +		return "<define-me>";
> > +	}
> Missing BPF_MAP_TYPE_HASH_OF_MAPS ?
> > +}
> > +
> > +static __u32 map_count_elements(__u32 type, int map_fd)
> > +{
> > +	__u32 key = -1;
> > +	int n = 0;
> > +
> > +	while (!bpf_map_get_next_key(map_fd, &key, &key))
> > +		n++;
> > +	return n;
> > +}
> > +
> > +#define BATCH	true
> > +
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
> 
> It seems it is a bug in __htab_map_lookup_and_delete_batch(). I could
> post a patch to fix it if you don't plan to do that by yourself.

This should be as simple as

@@ -1876,7 +1876,8 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
        total += bucket_cnt;
        batch++;
        if (batch >= htab->n_buckets) {
-               ret = -ENOENT;
+               if (!total)
+                       ret = -ENOENT;
                goto after_loop;
        }
        goto again;

However, this might be already utilized by some apps to check that they've read
all entries. Two local examples are map_tests/map_in_map_batch_ops.c and
map_tests/htab_map_batch_ops.c. Another example I know is from BCC tools:
https://github.com/iovisor/bcc/blob/master/libbpf-tools/map_helpers.c#L58

Can we update comments in include/uapi/linux/bpf.h?

> > +	CHECK(ret < 0 && (errno != ENOENT || !count), "bpf_map_lookup_and_delete_batch",
> > +		       "error: %s\n", strerror(errno));
> > +
> > +	CHECK(count != save_count,
> > +			"bpf_map_lookup_and_delete_batch",
> > +			"deleted not all elements: removed=%u expected=%u\n",
> > +			count, save_count);
> > +}
> > +
> SNIP
> > +static __u32 get_cur_elements(int map_id)
> > +{
> > +	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> > +	union bpf_iter_link_info linfo;
> > +	struct map_percpu_stats *skel;
> > +	struct bpf_link *link;
> > +	__u32 n_elements;
> > +	int iter_fd;
> > +	int ret;
> > +
> > +	opts.link_info = &linfo;
> > +	opts.link_info_len = sizeof(linfo);
> > +
> > +	skel = map_percpu_stats__open();
> > +	CHECK(skel == NULL, "map_percpu_stats__open", "error: %s", strerror(errno));
> > +
> > +	skel->bss->target_id = map_id;
> > +
> > +	ret = map_percpu_stats__load(skel);
> > +	CHECK(ret != 0, "map_percpu_stats__load", "error: %s", strerror(errno));
> > +
> > +	link = bpf_program__attach_iter(skel->progs.dump_bpf_map, &opts);
> 
> Instead of passing a uninitialized opts, I think using NULL will be fine
> here because there is no option for bpf map iterator now.
> 

