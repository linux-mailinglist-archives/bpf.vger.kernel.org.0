Return-Path: <bpf+bounces-7617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1B0779AF3
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 01:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBC01C20ACE
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9922634CDC;
	Fri, 11 Aug 2023 23:05:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB32F4E
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 23:05:37 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EDA3C0F
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:05:36 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bdb3256742so17969965ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691795136; x=1692399936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsqyI+ZWBw7KHSLIbvPUaN5HK5cPMfs7uBGQTl/IL84=;
        b=QQ8wzlcrb5TnefQGvUZLkmmsYLiUNjP9RNPiMgC2UH+bWzSq8Fdm/sXzzuA5UrCDew
         eemcOHY/B2foWz6KhAdaeX3go35h/SpxiwwuDaoiAG91s/sSvgg7ATh+UaMCQ4s4NY+7
         vjvON5NK8hvuUnAwGNCJrG2B0jzuMEYmuHuYXRCel6pc+ttRzTEIajsKNY8k2ViiKxXI
         gTebyjLq9CkzXDHFgA0mOFpyPtzwiF3nFdRPiaxhZV5ElQHoeL6QCHnvmmoGeRu59obZ
         3JkfQo0wVpoYaQAaOF5qFm9IEF0Hxm1u8kgTNtN6HvNbTwWOkUTIRfDYA/lP1ACAt4hg
         I1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691795136; x=1692399936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsqyI+ZWBw7KHSLIbvPUaN5HK5cPMfs7uBGQTl/IL84=;
        b=SMARrgaHl8/wP0nNY/jtTpeLAQEBxJkD9Hwdk36C9fCWO7XZg232JIcZZTn6RcuHOt
         LV0jVryMhIYErCmFbendePlmTojKBQ1czh+ME1W8ymlZqzz1hWImf0tbb1jCATbKPbR/
         SmA86KOW2G1q5axKR2T1Y7N3mx8M24X2m4IIyE8lmaEO/zb6wDBJD+j4fb2nkplwMc9W
         SGr8bWowA0gJK/lVdycLuKEEp9B1fpS+5o66xWXsoHy5PYXb3/bXu+B26OvhFbzi3O5N
         rkO8SDL8N2EFcHOIZZRqscwV7STTENPOg5OFKHDdXLlEIBKCp+DktAKDS5OinihQvUxJ
         Si0w==
X-Gm-Message-State: AOJu0YwoABgWPdnxPo9QTsFemmH9sg5l+wvzvUM8kLPnCt38+PLIOmEa
	eyUVIWB7cAPu8kBXAY1trZDDMu0=
X-Google-Smtp-Source: AGHT+IFO4ZNotuoTxN4ZnC6qyugykDsn/zL+Chp5xlX8svSiLF0g1MJCkmuXJYWngbxTCQSrHJ7G2DE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:c94b:b0:1b5:bd8:5aaa with SMTP id
 i11-20020a170902c94b00b001b50bd85aaamr1142714pla.1.1691795135913; Fri, 11 Aug
 2023 16:05:35 -0700 (PDT)
Date: Fri, 11 Aug 2023 16:05:34 -0700
In-Reply-To: <20230811043127.1318152-5-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811043127.1318152-1-thinker.li@gmail.com> <20230811043127.1318152-5-thinker.li@gmail.com>
Message-ID: <ZNa+vhzXxYYOzk96@google.com>
Subject: Re: [RFC bpf-next v2 4/6] bpf: Provide bpf_copy_from_user() and bpf_copy_to_user().
From: Stanislav Fomichev <sdf@google.com>
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, yonghong.song@linux.dev, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/10, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <kuifeng@meta.com>
> 
> Provide bpf_copy_from_user() and bpf_copy_to_user() to the BPF programs
> attached to cgroup/{set,get}sockopt. bpf_copy_to_user() is a new kfunc to
> copy data from an kernel space buffer to a user space buffer. They are only
> available for sleepable BPF programs. bpf_copy_to_user() is only available
> to the BPF programs attached to cgroup/getsockopt.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  kernel/bpf/cgroup.c  |  6 ++++++
>  kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5bf3115b265c..c15a72860d2a 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2461,6 +2461,12 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  #endif
>  	case BPF_FUNC_perf_event_output:
>  		return &bpf_event_output_data_proto;
> +
> +	case BPF_FUNC_copy_from_user:
> +		if (prog->aux->sleepable)
> +			return &bpf_copy_from_user_proto;
> +		return NULL;

If we just allow copy to/from, I'm not sure I understand how the buffer
sharing between sleepable/non-sleepable works.

Let's assume I have two progs in the chain:
1. non-sleepable - copies the buffer, does some modifications; since
   we don't copy the buffer back after every prog run, the modifications
   stay in the kernel buffer
2. sleepable - runs and just gets the user pointer? does it mean this
  sleepable program doesn't see the changes from (1)?

IOW, do we need some custom sockopt copy_to/from that handle this
potential buffer location transparently or am I missing something?

Assuming we want to support this at all. If we do, might deserve a
selftest.

