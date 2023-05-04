Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170AB6F62B2
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjEDBmr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 21:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDBmq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 21:42:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA6BF;
        Wed,  3 May 2023 18:42:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b8b19901fso6536611b3a.3;
        Wed, 03 May 2023 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683164565; x=1685756565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XcGkVsRC1Mly66mIRH3sgXxcvKbRwV8ccC9kJDf3cZI=;
        b=rKeFJ7FrJuCJU1MY0YLaF3YZwzV8IIqQ27nnnhc280qXmTj/otFy0lNdOq7W2AJa8Y
         i6c3FLhyOHVER4CJ9sKduplxL5BjzTuVgoeCXr+FzoGYKlJTfXfY9hYcU9bT2GQFahTx
         yk9NxM/bLvhjc8C8UFLm0E9cAvzT5x8fQyuoOEkKR9w949yc9vRIV3jHIAyZbSe0LvhF
         Xh/+OmkZFa36b60YrfLFQOgu0z7Mr7bqDqsNGzllEtXISdmtnbfqvT24KsgLX7fliAY/
         DrbAiz+DqJxxoO4NMXjaXhRbkJScjaTLxY7/4ApYy5Wjhs3WRj/z/mmMEzWFtT1L7J3N
         8ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683164565; x=1685756565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcGkVsRC1Mly66mIRH3sgXxcvKbRwV8ccC9kJDf3cZI=;
        b=M6CnSG4r8trGnzQJI7zSv2svFoERrI2F8X2Y45DBBIWMGvh+bobLTXhU9HOl7OOHU/
         ecAmuAXXzfMgTJKYYShFoKIL/6wWZR7ZxWwQP8l5tt/KMlrNYCbeTIEyB2Lh/4pNNt9Z
         1mMhFk9ay0jr5sB1Z5okTpp5ikmTYcWzZeZ20PvmgdAA/j8lAzwuYbbaVSIK+h1jN0dN
         5TxgscQm9ovFFOoAcqcXtNNddaOtA0z/+XkoHrrvOvIEQSplGleymy9x8kiUAGYrkoPK
         Khc7jVfH5Cey7xTR74RSkeMNTp8OCQbqNXX2OhB46y3/QtwE0H1oZ+K0NuFF/AVO/klx
         FB8w==
X-Gm-Message-State: AC+VfDyj//uaDY4ldNVXMomXXU3zoZQjEsZeestvYB4qxhEDn1cgEy7y
        iqRXOWKTImayXiy7OQwb6eA=
X-Google-Smtp-Source: ACHHUZ50B/rYzHfeTqtpcB5yf1jrorg5jtcOwqF8mrhBPEXTlbeTczNt5lYuwiTX8p6JuYLL4MtwvQ==
X-Received: by 2002:a05:6a00:cc4:b0:63b:8a91:e641 with SMTP id b4-20020a056a000cc400b0063b8a91e641mr750518pfv.11.1683164564953;
        Wed, 03 May 2023 18:42:44 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:396f])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a00238e00b00640e64aa9b7sm16916842pfc.10.2023.05.03.18.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 18:42:44 -0700 (PDT)
Date:   Wed, 3 May 2023 18:42:41 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
Message-ID: <20230504014241.bw62lwtxwllyzjqm@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
 <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
 <0fc99af7-fa0d-c5c7-00c4-3f446a5ad77b@linux.dev>
 <20230503230603.auijigbydnifxah5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <145d1fb6-93c7-ac5d-7818-9a9cca542dbf@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145d1fb6-93c7-ac5d-7818-9a9cca542dbf@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 03, 2023 at 04:39:01PM -0700, Martin KaFai Lau wrote:
> On 5/3/23 4:06 PM, Alexei Starovoitov wrote:
> > On Wed, May 03, 2023 at 02:57:03PM -0700, Martin KaFai Lau wrote:
> > > On 5/3/23 11:48 AM, Alexei Starovoitov wrote:
> > > > What it means that sleepable progs using hashmap will be able to avoid uaf with bpf_rcu_read_lock().
> > > > Without explicit bpf_rcu_read_lock() it's still safe and equivalent to existing behavior of bpf_mem_alloc.
> > > > (while your proposed BPF_MA_FREE_AFTER_RCU_GP flavor is not safe to use in hashtab with sleepable progs)
> > > > 
> > > > After that we can unconditionally remove rcu_head/call_rcu from bpf_cpumask and improve usability of bpf_obj_drop.
> > > > Probably usage of bpf_mem_alloc in local storage can be simplified as well.
> > > > Martin wdyt?
> > > 
> > > If the bpf prog always does a bpf_rcu_read_lock() before accessing the
> > > (e.g.) task local storage, it can remove the reuse_now conditions in the
> > > bpf_local_storage and directly call the bpf_mem_cache_free().
> > > 
> > > The only corner use case is when the bpf_prog or syscall does
> > > bpf_task_storage_delete() instead of having the task storage stays with the
> > > whole lifetime of the task_struct. Using REUSE_AFTER_RCU_GP will be a change
> > > of this uaf guarantee to the sleepable program but it is still safe because
> > > it is freed after tasks_trace gp. We could take this chance to align this
> > > behavior of the local storage map to the other bpf maps.
> > > 
> > > For BPF_MA_FREE_AFTER_RCU_GP, there are cases that the bpf local storage
> > > knows it can be freed without waiting tasks_trace gp. However, only
> > > task/cgroup storages are in bpf ma and I don't believe this optimization
> > > matter much for them. I would rather focus on the REUSE_AFTER_RCU_GP first.
> > 
> > I'm confused which REUSE_AFTER_RCU_GP you meant.
> > What I proposed above is REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace
> 
> Regarding REUSE_AFTER_RCU_GP, I meant
> REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace.
> 
> > 
> > Hou's proposals: 1. BPF_MA_REUSE_AFTER_two_RCUs_GP 2. BPF_MA_FREE_AFTER_single_RCU_GP
> 
> It probably is where the confusion is. I thought Hou's
> BPF_MA_REUSE_AFTER_RCU_GP is already
> REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace. From the commit message:

Sorry. My bad. You're correct.
The difference between my and Hou's #1 is whether rcu_tasks_trace is global or per-cpu.

> 
> " ... So introduce BPF_MA_REUSE_AFTER_RCU_GP to solve these problems. For
> BPF_MA_REUSE_AFTER_GP, the freed objects are reused only after one RCU
> grace period and may be returned back to slab system after another
> RCU-tasks-trace grace period. ..."
> 
> [I assumed BPF_MA_REUSE_AFTER_GP is just a typo of BPF_MA_REUSE_AFTER_"RCU"_GP]
> 
> > 
> > If I'm reading bpf_local_storage correctly it can remove reuse_now logic
> > in all conditions with REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace.
> 
> Right, for smap->bpf_ma == true (cgroup and task storage), all reuse_now
> logic can be gone and directly use the bpf_mem_cache_free(). Potentially the
> sk/inode can also move to bpf_ma after running some benchmark. This will
> simplify things a lot. For sk storage, the reuse_now was there to avoid the
> unnecessary tasks_trace gp because performance impact was reported on sk
> storage where connections can be open-and-close very frequently.
