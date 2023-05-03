Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEE26F61B8
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 01:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjECXGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 19:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjECXGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 19:06:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760CA5FD9;
        Wed,  3 May 2023 16:06:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64115eef620so8502903b3a.1;
        Wed, 03 May 2023 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683155167; x=1685747167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M47T+MkfXcL+iES+vO37bcdby6t+YHTMo4v4UpuapmA=;
        b=GyjtyxzzPJIzKLNckzBqhGn6EsHcW13SH4Ki9P94TvYHM/nQ4czEHPAYkzgf+csxqG
         Fyizd6OJ+I2C09BwSgegy5CjhhFqMyjDHv20WOORrAARntsm+r+RlT1aLs99TYjqt9D/
         kWpnm4QQ2ZskjjfPwcL0Ve4Rm9orMV2uzI9SKJUx5FBC7OsjuvhbEaA360KgwtDSS7ov
         q3QsRLMtRGE5hSB56uvSDaQUPy6KE7lfJEVTjBXQn/r8qlc/8x4U/jfrgp033cpS0PWg
         jwEpFx5ReowWxIfxZ/c5DBSAFOxFdgpFBQBKBhKNOoQWZVTJ+tmXPN4Qj00oxUnQ/Nj5
         fw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683155167; x=1685747167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M47T+MkfXcL+iES+vO37bcdby6t+YHTMo4v4UpuapmA=;
        b=TsZvS5DWKanVXJ7r37BgotLdLb1yVTTd4fMENjcJpUAj+qbHbk1TXfiWlWyL6fUsVE
         htnmlz60O6Vdebe62nKU57v/2+l/KjHSZmHcnOpsJmGIZ20xaYovtj7N5+D23j7rsrw/
         8QTq6W7TgvjdmmrTFDdY3Ycq8tHOZekl2uu8Yeh7rFqBDuF9Yf1SnQop1edwJXEct/kU
         P45uWiwJjPA/yvabfELUYu/AQo2RbEhwvnDc9POWpnL/aNPFgoGiWMMMLAtvp8dEPFQ8
         6SMJXRaVFhoo+gp6fduiEg7hsKezaw52EhEs0S1UEliPrPN4zcYCkwGKWpDKpeEvtmyt
         /pNQ==
X-Gm-Message-State: AC+VfDyTnMxl4u+uij5xrno8lRA2NH6mxxFhdmxfOtFjSWnDRYAmptyp
        1iEX66tEpuldteRoZ8CJoW8=
X-Google-Smtp-Source: ACHHUZ6IdITKuMcPrZQPXVzz8DxHIwMl89ft/AfZdh9W5CLXG7fE4eF57eRLOYAeLuPhJiDTe4faUg==
X-Received: by 2002:a05:6a00:a28:b0:63b:8dcc:84de with SMTP id p40-20020a056a000a2800b0063b8dcc84demr95158pfh.4.1683155166682;
        Wed, 03 May 2023 16:06:06 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:396f])
        by smtp.gmail.com with ESMTPSA id a24-20020aa795b8000000b0063d2dae6243sm24051211pfk.115.2023.05.03.16.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:06:06 -0700 (PDT)
Date:   Wed, 3 May 2023 16:06:03 -0700
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
Message-ID: <20230503230603.auijigbydnifxah5@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
 <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
 <0fc99af7-fa0d-c5c7-00c4-3f446a5ad77b@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc99af7-fa0d-c5c7-00c4-3f446a5ad77b@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 03, 2023 at 02:57:03PM -0700, Martin KaFai Lau wrote:
> On 5/3/23 11:48 AM, Alexei Starovoitov wrote:
> > What it means that sleepable progs using hashmap will be able to avoid uaf with bpf_rcu_read_lock().
> > Without explicit bpf_rcu_read_lock() it's still safe and equivalent to existing behavior of bpf_mem_alloc.
> > (while your proposed BPF_MA_FREE_AFTER_RCU_GP flavor is not safe to use in hashtab with sleepable progs)
> > 
> > After that we can unconditionally remove rcu_head/call_rcu from bpf_cpumask and improve usability of bpf_obj_drop.
> > Probably usage of bpf_mem_alloc in local storage can be simplified as well.
> > Martin wdyt?
> 
> If the bpf prog always does a bpf_rcu_read_lock() before accessing the
> (e.g.) task local storage, it can remove the reuse_now conditions in the
> bpf_local_storage and directly call the bpf_mem_cache_free().
> 
> The only corner use case is when the bpf_prog or syscall does
> bpf_task_storage_delete() instead of having the task storage stays with the
> whole lifetime of the task_struct. Using REUSE_AFTER_RCU_GP will be a change
> of this uaf guarantee to the sleepable program but it is still safe because
> it is freed after tasks_trace gp. We could take this chance to align this
> behavior of the local storage map to the other bpf maps.
> 
> For BPF_MA_FREE_AFTER_RCU_GP, there are cases that the bpf local storage
> knows it can be freed without waiting tasks_trace gp. However, only
> task/cgroup storages are in bpf ma and I don't believe this optimization
> matter much for them. I would rather focus on the REUSE_AFTER_RCU_GP first.

I'm confused which REUSE_AFTER_RCU_GP you meant.
What I proposed above is REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace

Hou's proposals: 1. BPF_MA_REUSE_AFTER_two_RCUs_GP 2. BPF_MA_FREE_AFTER_single_RCU_GP

If I'm reading bpf_local_storage correctly it can remove reuse_now logic
in all conditions with REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace.
What am I missing?
