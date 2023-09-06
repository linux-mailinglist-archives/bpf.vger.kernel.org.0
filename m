Return-Path: <bpf+bounces-9368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795857943F7
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8090D1C20A78
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CF7111B8;
	Wed,  6 Sep 2023 19:53:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA416AB1
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 19:53:53 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161595;
	Wed,  6 Sep 2023 12:53:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso1661265ad.1;
        Wed, 06 Sep 2023 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694030031; x=1694634831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6RLg+POdRGD0L8+2lqSSropHtZ6QvcmXiJIAf4zj1Y=;
        b=srLzk93V7v3lv3920rpFLZD+/3cxcpPAgmCD3eeSeVw/x14HHkU01qvUbVa+/khkHf
         5Bqa275SvH7gKFHfUEBWNPMHr3NvF/2lRtblbio1MmbKsWHmOoerNqXGYi0dPBP1n0b/
         3Fa0xeOOpfZ5UCmrAZGYc6nPP3uxxvHU6N+L32qmfEpL/lOZr09+p7RnH00WR4l4okep
         JobC1UjvGcJwK0KY5Nv2brdAWVTs2KkAwLSnbmLce8HaBpBMPiegmY8FEhwJNolmsGnu
         3+fGr59MFwKb3CIILiB+MDgnLP1JRL3c6FpnLpg8zyQM9QP0xJQmv+8XDRgpDkKYvFjt
         5K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694030031; x=1694634831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6RLg+POdRGD0L8+2lqSSropHtZ6QvcmXiJIAf4zj1Y=;
        b=Yfw6aRkea9p3tZ6KVsv5wPBbb+CjUKR6I3DvVrzpxl+AC+/ejPmjb7sM3XpKOdZrjb
         3T4LQnwXc0Zp1rD9YKMAsC+my3uLhvibRDDMVcWoEsRwRt91TqK1E0IJrhQ8ZE4iaYyR
         yMouZMkEnvD0EITx2jjOI8NkiWPHyc3eQWKj+4FzHW/ooeX6rLKJioLRKmu3yNn7bq1J
         r7+iEJy08WeWjQIWLuREFX/iR51EeGLenWvw+zBNKu/Ik5IP07M1LCuFMq0183jd7LtG
         taRMI99+lYiPC//0n+Wcwg7hKLhooGmJZz6GamBrvkqy4OD9rB7Dnh+KOVQVmEBYaIZF
         KKJQ==
X-Gm-Message-State: AOJu0YyENNWwh7G9VM+Ee0KirMMCXMWkmmN9815d4/1Dp7vKFLhqawq9
	TfC9DRBuDJVBo2kfkR1j5Fw=
X-Google-Smtp-Source: AGHT+IG0ee2z+hTx2vD4efDO2aJiDvDLpk7CwEEStt96qq+RQZmqP433AtY3APFchEbgtx3/OFNkVQ==
X-Received: by 2002:a17:903:22c4:b0:1c3:343c:f8b0 with SMTP id y4-20020a17090322c400b001c3343cf8b0mr12405100plg.66.1694030031184;
        Wed, 06 Sep 2023 12:53:51 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:d4aa])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902704a00b001b9da8b4eb7sm11356199plt.35.2023.09.06.12.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:53:50 -0700 (PDT)
Date: Wed, 6 Sep 2023 12:53:46 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
	cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/5] cgroup: Enable
 task_under_cgroup_hierarchy() on cgroup1
Message-ID: <20230906195346.ghrmpku47tmrgnsv@MacBook-Pro-8.local>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
 <20230903142800.3870-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903142800.3870-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 03, 2023 at 02:27:56PM +0000, Yafang Shao wrote:
> Currently, the function task_under_cgroup_hierarchy() allows us to
> determine if a task resides exclusively within a cgroup2 hierarchy.
> Nevertheless, given the continued prevalence of cgroup1, it's useful that
> we make a minor adjustment to extend its functionality to cgroup1 as well.
> Once this modification is implemented, we will have the ability to
> effortlessly verify a task's cgroup membership within BPF programs. For
> instance, we can easily check if a task belongs to a cgroup1 directory,
> such as /sys/fs/cgroup/cpu,cpuacct/kubepods/burstable/ or
> /sys/fs/cgroup/cpu,cpuacct/kubepods/besteffort/.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/cgroup.h | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index b307013..5414a2c 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -543,15 +543,33 @@ static inline struct cgroup *cgroup_ancestor(struct cgroup *cgrp,
>   * @ancestor: possible ancestor of @task's cgroup
>   *
>   * Tests whether @task's default cgroup hierarchy is a descendant of @ancestor.
> - * It follows all the same rules as cgroup_is_descendant, and only applies
> - * to the default hierarchy.
> + * It follows all the same rules as cgroup_is_descendant.
>   */
>  static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
>  					       struct cgroup *ancestor)
>  {
>  	struct css_set *cset = task_css_set(task);
> +	struct cgroup *cgrp;
> +	bool ret = false;
> +	int ssid;
> +
> +	if (ancestor->root == &cgrp_dfl_root)
> +		return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
> +
> +	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
> +		if (!ancestor->subsys[ssid])
> +			continue;

This looks wrong. I believe cgroup_mutex should be held to iterate.

Tejun ?

>  
> -	return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
> +		cgrp = task_css(task, ssid)->cgroup;
> +		if (!cgrp)
> +			continue;
> +
> +		if (!cgroup_is_descendant(cgrp, ancestor))
> +			return false;
> +		if (!ret)
> +			ret = true;
> +	}
> +	return ret;
>  }
>  
>  /* no synchronization, the result can only be used as a hint */
> -- 
> 1.8.3.1
> 

