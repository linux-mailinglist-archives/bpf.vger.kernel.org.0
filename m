Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9860937EF52
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347513AbhELXEp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239747AbhELW51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 18:57:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD9BC06135A;
        Wed, 12 May 2021 15:55:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m190so19500718pga.2;
        Wed, 12 May 2021 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U6Yw/aST6fr+ZgDp8ejO8NenUGdJg/UmhmI/pM7yQvE=;
        b=OBMINBawBSAXl5ymaYMRHcQ7jBGlJX8tbkO+VDxVWQFkkMqUmGwpUW/EI8uwfC35Af
         7jrxzoUCEKD+RVwXcId53ScX0ROrj4stQcBLQdt7DOeIcGksJ4RewjD/XsYkc1CxeW9C
         YMAmVQJC9F67Fm7IUt8bDpgAnKweWXaUCWpDPjG4pGmvYCdOnMQXUSsP7X11psFmjjZ6
         7iZJgFV8qKb8kXGB6vAqaJP1xwP9ExtIwn5BhDax1NFeDSSVjZXyriZnadAjUDlX8uPN
         9lsw0ve/FlR/wmzqIPINV1FURx/IR613DoOLN063LoDxA6cJtf0LBLy4TfORhgsqjkty
         sFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U6Yw/aST6fr+ZgDp8ejO8NenUGdJg/UmhmI/pM7yQvE=;
        b=IuoNWs0RlR9EKYhhjVB/RJ6EHXMCh4EftKzHRQyaXb2D7HBL4USwBemZJ+SMHKppbS
         nEmAkIEx/xBHxGZrfi+bDQdWj9kZl8N6mPK7GJ6/MmOVD81VaY9FC3MUkpMQ9ln+4hd6
         5MZgBv8pOUNtlcvucEKbFKwHWLfsCLi9G15pk/v02oWsTYTcnqr/1iu7clVahkp8GaMo
         0h3Uf0AL7vsBvnmBaBt7AD+/XOtazafoW3FV2iMxGZakum2cEb4NMAEUW9GS4ob52D2j
         7NTcY6Ae+SMyAEt4yYXikyKthT8ScOLdpyMM5kQIwfTKBQo7kPlKnTBBqELxLWH7qq/l
         KPug==
X-Gm-Message-State: AOAM531Vu/Xv0EydsZsCiL8pv8cWQIVbMJihKSZX1R5LCcOgV+Pbm4z6
        AQytvUmWMgNRG0ITBY0ZZx8=
X-Google-Smtp-Source: ABdhPJx7mjAd5lZDATnx+mICrKQl/DuyOhr4TIbBH8Fq3HOgYrji+F7V3/xAsrmyf0Nhzbl9imJ1bw==
X-Received: by 2002:a63:4f4a:: with SMTP id p10mr886589pgl.384.1620860109475;
        Wed, 12 May 2021 15:55:09 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:c6f4])
        by smtp.gmail.com with ESMTPSA id p11sm642052pjo.19.2021.05.12.15.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:55:08 -0700 (PDT)
Date:   Wed, 12 May 2021 15:55:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
Cc:     kpsingh@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, revest@chromium.org,
        jackmanb@chromium.org, yhs@fb.com, songliubraving@fb.com,
        kafai@fb.com, john.fastabend@gmail.com, joe@cilium.io,
        quentin@isovalent.com
Subject: Re: [RFC] [PATCH bpf-next 1/1] bpf: Add a BPF helper for getting the
 cgroup path of current task
Message-ID: <20210512225504.3kt6ij4xqzbtyej5@ast-mbp.dhcp.thefacebook.com>
References: <20210512095823.99162-1-yunbo.xufeng@linux.alibaba.com>
 <20210512095823.99162-2-yunbo.xufeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512095823.99162-2-yunbo.xufeng@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 12, 2021 at 05:58:23PM +0800, Xufeng Zhang wrote:
> To implement security rules for application containers by utilizing
> bpf LSM, the container to which the current running task belongs need
> to be known in bpf context. Think about this scenario: kubernetes
> schedules a pod into one host, before the application container can run,
> the security rules for this application need to be loaded into bpf
> maps firstly, so that LSM bpf programs can make decisions based on
> this rule maps.
> 
> However, there is no effective bpf helper to achieve this goal,
> especially for cgroup v1. In the above case, the only available information
> from user side is container-id, and the cgroup path for this container
> is certain based on container-id, so in order to make a bridge between
> user side and bpf programs, bpf programs also need to know the current
> cgroup path of running task.
...
> +#ifdef CONFIG_CGROUPS
> +BPF_CALL_2(bpf_get_current_cpuset_cgroup_path, char *, buf, u32, buf_len)
> +{
> +	struct cgroup_subsys_state *css;
> +	int retval;
> +
> +	css = task_get_css(current, cpuset_cgrp_id);
> +	retval = cgroup_path_ns(css->cgroup, buf, buf_len, &init_cgroup_ns);
> +	css_put(css);
> +	if (retval >= buf_len)
> +		retval = -ENAMETOOLONG;

Manipulating string path to check the hierarchy will be difficult to do
inside bpf prog. It seems to me this helper will be useful only for
simplest cgroup setups where there is no additional cgroup nesting
within containers.
Have you looked at *ancestor_cgroup_id and *cgroup_id helpers?
They're a bit more flexible when dealing with hierarchy and
can be used to achieve the same correlation between kernel and user cgroup ids.
