Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985A762F094
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 10:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbiKRJJf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 04:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbiKRJJe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 04:09:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E85140D7
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 01:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668762510;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXM84DaBN5AZrX/vJHAzXbI0N4xm2A1YhPGzhtFicxY=;
        b=JmdBDLW2QIUeEOVKSTiHh0jRiEhKF8OehhROyFqTU3lhPjzUTsGQpyyBMWXdeAzc2HLL4e
        RVYlwqEiQz2rSCmPiv69bMbq+qY/vM1PH5DopkGN53gjMCQGchIBOljEpnxQxjIEgpJo9w
        G2gkakpyPGeg7plrcELnBJKvng+ZI8Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-533-Bfa6j0wLNIqRJ9a84uvV0w-1; Fri, 18 Nov 2022 04:08:29 -0500
X-MC-Unique: Bfa6j0wLNIqRJ9a84uvV0w-1
Received: by mail-wm1-f72.google.com with SMTP id c126-20020a1c3584000000b003cfffcf7c1aso1925102wma.0
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 01:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXM84DaBN5AZrX/vJHAzXbI0N4xm2A1YhPGzhtFicxY=;
        b=i1Pqgxmm7xAwzUpnBb33ZbWnAmVuT8QDSlihkDJ7A6eFJsx2brV2M6sOy69x4OJqQi
         nzQrI6FiAa+PVmZcfXDWHms8nSYZs+lnqvUH8st2cid6vMJvLX2JwgdtY4g7AyX1CcV2
         4f5r6XwgQYG7rsBgfHUSjfhVJH75h9skezcPsQtm1RHYSA+j0kDWLfKsfBVXYXHB6maN
         Uy/FrJTbn07GSj2tsdJAVP3SRiOXNh6kppSP1yze7mo6XdJ449dMWoVVGymWh1mYtZUw
         vLvQ+WM6a+PDvmGXcqlwKcQ2cy/VewSl0TqZKeekTjB0VZOi3CnAvJ6PfstJnH46mdR9
         AAtQ==
X-Gm-Message-State: ANoB5pk5NhCU9Chu2ubHxiZyf3+ndHqu2NrglPjuTJ0wdDaINsGsM0mk
        xMfFjBZTN6olKFOC9YQl9cBZOTsejgezWjjnAwK4J0VJSRXsaH8FKol5azzoUrcOGDnn1f+ixlp
        TvzxqnpfvM4Vg
X-Received: by 2002:a5d:4c4d:0:b0:235:25b7:5084 with SMTP id n13-20020a5d4c4d000000b0023525b75084mr3687571wrt.135.1668762508191;
        Fri, 18 Nov 2022 01:08:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7S2ZztXQpu74tY6qMZ8bGYs0jf9hhJcId6BWRRAo3bBJp7imdNVYU/FaWEHzD9sFXAJBwi3Q==
X-Received: by 2002:a5d:4c4d:0:b0:235:25b7:5084 with SMTP id n13-20020a5d4c4d000000b0023525b75084mr3687521wrt.135.1668762507845;
        Fri, 18 Nov 2022 01:08:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id r10-20020adfce8a000000b00241b371d73esm3107407wrn.77.2022.11.18.01.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 01:08:27 -0800 (PST)
Message-ID: <ab66bcf6-43ff-3676-7b7d-c8afa00ad0b0@redhat.com>
Date:   Fri, 18 Nov 2022 10:08:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 07/19] kernel/user: Allow user::locked_vm to be usable
 for iommufd
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <7-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/16/22 22:00, Jason Gunthorpe wrote:
> Following the pattern of io_uring, perf, skb, and bpf iommfd will use
> user->locked_vm for accounting pinned pages. Ensure the value is included
> in the struct and export free_uid() as iommufd is modular.
>
> user->locked_vm is the good accounting to use for ulimit because it is
> per-user, and the security sandboxing of locked pages is not supposed to
> be per-process. Other places (vfio, vdpa and infiniband) have used
> mm->pinned_vm and/or mm->locked_vm for accounting pinned pages, but this
> is only per-process and inconsistent with the new FOLL_LONGTERM users in
> the kernel.
>
> Concurrent work is underway to try to put this in a cgroup, so everything
> can be consistent and the kernel can provide a FOLL_LONGTERM limit that
> actually provides security.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/linux/sched/user.h | 2 +-
>  kernel/user.c              | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> index f054d0360a7533..4cc52698e214e2 100644
> --- a/include/linux/sched/user.h
> +++ b/include/linux/sched/user.h
> @@ -25,7 +25,7 @@ struct user_struct {
>  
>  #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
>  	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
> -	defined(CONFIG_VFIO_PCI_ZDEV_KVM)
> +	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD)
>  	atomic_long_t locked_vm;
>  #endif
>  #ifdef CONFIG_WATCH_QUEUE
> diff --git a/kernel/user.c b/kernel/user.c
> index e2cf8c22b539a7..d667debeafd609 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -185,6 +185,7 @@ void free_uid(struct user_struct *up)
>  	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
>  		free_user(up, flags);
>  }
> +EXPORT_SYMBOL_GPL(free_uid);
>  
>  struct user_struct *alloc_uid(kuid_t uid)
>  {

