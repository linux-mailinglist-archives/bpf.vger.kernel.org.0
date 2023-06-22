Return-Path: <bpf+bounces-3192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CC273A96B
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B9281B0B
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5A42109A;
	Thu, 22 Jun 2023 20:21:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC27200C6
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 20:21:06 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58F11FCE
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 13:21:02 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39ca48cd4c6so5065993b6e.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687465262; x=1690057262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iLObSacb+R2FNqK5PhZ94jSvEqwa4GArM/35NgcBnUo=;
        b=fNHAmBBqHRnmjfNxqi20UmCL2ALMFhUjqb8rnkLhuSt7U+PRlGFJ4Fu8LYDvxILEhi
         NmXvQNTZey4MFj+mn1HBxCuopbK5WdbzaNZn9JYnbA3qMtyToZBjkQEGlQyVFVmCxes9
         zdMEw+xJ3OJQM/uKO2EtRgppp7VRT7OWi7g70VDDwkJVzw2VKjjE0Brt7wSPnudpegM/
         XRGOff2AU7VteeG5Ai6jAY/adPj3ubvEfJkzFURZWW7lfjRJmnvNFIy5b+h8uclQM7OR
         ZLC73se7uJAL/52xF9ZJwDfAEJlxNt1HuTVtGlTHWLNVtTEr3ymnIAnw4Fq3A3Q9fIuO
         ugLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687465262; x=1690057262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLObSacb+R2FNqK5PhZ94jSvEqwa4GArM/35NgcBnUo=;
        b=Wu2Vz2F3XFGgSDldLaIFe2yAVoZpYCuAmltS4KAbmzvMo7IHn/IPpVTeYSxCWjmYrW
         LXvDDgUnu3P9YfIPUIzZIZrwgHyjej4xTnp/DID/ZRJ9CTa635MEvYBB/mmVOO0nAnm8
         VDTk3y5Y66U+RMHtTQTxnCjhA9gIWmz07GqA4nKkMGF3JkJVh/t2k7usvO+4SwX+zhjE
         ps5+dXAKO+DwlgXlbU0j7pHt/lKsYoDNGDwHooudRfp7onROh6J287Li6wIeKSFa3tSk
         N2rFiykAQGHhaC9InCVQYp/3NFAHuPcK163k8S+oPk7/Af/BK2tB6CNYThFbnxJcV91x
         ZTxw==
X-Gm-Message-State: AC+VfDyMIoNc1S5aA9/+ivCkRRcvmp8IWOstVStNisXh1bgkFuEAzW6c
	6DHdKp4KEAGfIoimddyxnPM=
X-Google-Smtp-Source: ACHHUZ7PvUJwh9mN5bofkLiBNnawLuXJslv6bkmUhfYQtTExJTjRio725zZVQbdkvAtaDbLtyEx/5g==
X-Received: by 2002:a05:6808:3c9:b0:39e:ffc5:c46a with SMTP id o9-20020a05680803c900b0039effc5c46amr3033337oie.34.1687465262053;
        Thu, 22 Jun 2023 13:21:02 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:95b5])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090a9a8f00b0025ec54be16asm2456340pjp.2.2023.06.22.13.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:21:01 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:20:59 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC v2 PATCH bpf-next 4/4] selftests/bpf: test map percpu stats
Message-ID: <20230622202059.ybeta3p3qknqbor4@macbook-pro-8.dhcp.thefacebook.com>
References: <20230622095330.1023453-1-aspsk@isovalent.com>
 <20230622095814.1027286-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622095814.1027286-1-aspsk@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 09:58:14AM +0000, Anton Protopopov wrote:
> Add a new map test, map_percpu_stats.c, which is checking the correctness of
> map's percpu elements counters.  For supported maps the test upserts a number
> of elements, checks the correctness of the counters, then deletes all the
> elements and checks again that the counters sum drops down to zero.
> 
> The following map types are tested:
> 
>     * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
>     * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
>     * BPF_MAP_TYPE_HASH,
>     * BPF_MAP_TYPE_PERCPU_HASH,
>     * BPF_MAP_TYPE_LRU_HASH
>     * BPF_MAP_TYPE_LRU_PERCPU_HASH
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  .../bpf/map_tests/map_percpu_stats.c          | 336 ++++++++++++++++++
>  .../selftests/bpf/progs/map_percpu_stats.c    |  24 ++

please add another patch with an extension to map_ptr_kern.c
where it not only checks hash->count.counter, but new elem count as well.

