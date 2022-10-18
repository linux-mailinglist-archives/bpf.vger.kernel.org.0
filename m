Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCCF6031FE
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 20:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJRSJD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJRSJA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 14:09:00 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4924A5D719
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:08:58 -0700 (PDT)
Message-ID: <67048049-dee4-3ff0-035c-65af34555725@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666116536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcBt8n259OXgHUHwaBe4UV4ilVQ3sCLcRXjhJyDn3V4=;
        b=gE4wkuBlSgzkBYOueKlHfaouT7tDPDqOUGI9cxWLij4YahcZiQkHoE1gXx8Bkv7eYErxGO
        BzNWlGyx6B+fdvUOetDxknunyFzrKJL1tAED4p0obL8iCTdTGaUh0fkrizVkPx0edCDaB4
        N1HO/N4NuTz3YFq1O204ckAyJkvooS8=
Date:   Tue, 18 Oct 2022 11:08:46 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, Yosry Ahmed <yosryahmed@google.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, Stanislav Fomichev <sdf@google.com>
References: <Y02Yk8gUgVDuZR4Q@google.com>
 <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com>
 <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev>
 <Y03USAeiBL5Ol22E@google.com>
 <06e37b29-b384-7432-d966-ad89901de55d@linux.dev>
 <fdc0484e-c2da-a118-b845-f937f0ef5688@meta.com> <Y07dlsqt9u3BYF2U@google.com>
 <CAADnVQKPMaU5av0soDh+ddnqpLbjDHEVyFpK9hX4g+99cBiJdQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQKPMaU5av0soDh+ddnqpLbjDHEVyFpK9hX4g+99cBiJdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/18/22 10:17 AM, Alexei Starovoitov wrote:
> On Tue, Oct 18, 2022 at 10:08 AM <sdf@google.com> wrote:
>>>>
>>>> '#define BPF_MAP_TYPE_CGROUP_STORAGE BPF_MAP_TYPE_CGRP_LOCAL_STORAGE /*
>>>> depreciated by BPF_MAP_TYPE_CGRP_STORAGE */' in the uapi.
>>>>
>>>> The new cgroup storage uses a shorter name "cgrp", like
>>>> BPF_MAP_TYPE_CGRP_STORAGE and bpf_cgrp_storage_get()?
>>
>>> This might work and the naming convention will be similar to
>>> existing sk/inode/task storage.
>>
>> +1, CGRP_STORAGE sounds good!
> 
> +1 from me as well.
> 
> Something like this ?
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 17f61338f8f8..13dcb2418847 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -922,7 +922,8 @@ enum bpf_map_type {
>          BPF_MAP_TYPE_CPUMAP,
>          BPF_MAP_TYPE_XSKMAP,
>          BPF_MAP_TYPE_SOCKHASH,
> -       BPF_MAP_TYPE_CGROUP_STORAGE,
> +       BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
> +       BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,

+1

>          BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
>          BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>          BPF_MAP_TYPE_QUEUE,
> @@ -935,6 +936,7 @@ enum bpf_map_type {
>          BPF_MAP_TYPE_TASK_STORAGE,
>          BPF_MAP_TYPE_BLOOM_FILTER,
>          BPF_MAP_TYPE_USER_RINGBUF,
> +       BPF_MAP_TYPE_CGRP_STORAGE,
>   };
> 
> What are we going to do with BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE ?
> Probably should come up with a replacement as well?

Yeah, need to come up with a percpu answer for it.  The percpu usage has never 
come up on the sk storage and also the later task/inode storage.  or the user is 
just getting by with an array like map's value.

May be the bpf prog can call bpf_mem_alloc() to alloc the percpu memory in the 
future and then store it as the kptr in the BPF_MAP_TYPE_CGRP_STORAGE?
