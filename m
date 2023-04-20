Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851206E9CD1
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjDTUDU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 16:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDTUDT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 16:03:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271C4C1B
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 13:03:14 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 826924427A
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682020990;
        bh=me8sddkqoHhu+o5UNk1o5ZrBbxC2BLK+Qjl7lsAFmIU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=Wb6drYyUyhtEMZLUHYqGrrbajoWjKywlBVY8yebytFm0jpGPCa9mxKqITHIAfUjlt
         Q/W1RmqmHgWXp/cYa3+TYjg5RDUhLDJbEG9P/UL4MrL3EN5XwY2AkJn/ZpX6rSJ/y9
         mvuI/Vb21WYS1qJVXCJsTvEmmRc8V0vRlctWZ++7OSV2X6Jwje0SMd85mOQCqY3rUf
         QRD/IaL6yt9CWn0bEuZaTCzJEWp5tfxBO/GSa91KjRyiQwDmSoJUrh8s0a/L54lfWJ
         BPMuxfn5S+b6901A6vWlFnFwG5T5Tx15rIs60dsOjWhrIfUJazs4jgEIdRXQ8uaHEc
         Jv9YuXEYae4qw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a341ee4fcso65368966b.0
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 13:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682020989; x=1684612989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me8sddkqoHhu+o5UNk1o5ZrBbxC2BLK+Qjl7lsAFmIU=;
        b=XVjJD9F7HBYVyQsTRU0qk7SrDA70N8u9hXa4K1wz8Tj6ltoy/2B1cZdP8zDwYDEKoR
         PXwjU6mm3oP25FxNgfQ1SjlzRypIMWb5v0G+fspIqpB30achrFKWXM9Vxm8cGJ/JwWza
         HHGG+61lRZ1vJCguEdpmxQ9BngvxHPKVv3qdJsQDIPAcqiEh6tyOJrnDP9cSkGCDEnM1
         pq40L4PA2IAZDruRb4RGcU1ADzN4WzbPjkwYwbiJCARaNROO9cPgnCa/eq3vYOIX9hlG
         5VgApl77th6h99yZKoFMkV/FxLcAZZmUOdMZUE0XqUrYQrnB5u3xoD2TH/9TIf4kOYGO
         rOJg==
X-Gm-Message-State: AAQBX9fr4jL7x5axDrFx3be86eyfQSSh9OMeRDhTfSx6L0HO6ah07Hzt
        TRi+48qgLx4gD4wlyt0ANzVQlSwuJUy4eEjTTZ5ZRalm0YC1a1ySid2g+mFEOiDk5tg7CiBniX2
        Y89nBPKJkP7s39uxMfMsg0pfuw2ebKA==
X-Received: by 2002:a2e:3019:0:b0:2a8:b2e5:4f65 with SMTP id w25-20020a2e3019000000b002a8b2e54f65mr30942ljw.14.1682020968897;
        Thu, 20 Apr 2023 13:02:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXpwHlruy+jf2ptQ1Zd/wR8j5qrYfqh/7n1iiCVd2ep1fw4ngmPsqejAh0saIE98fHvnXdew==
X-Received: by 2002:a2e:3019:0:b0:2a8:b2e5:4f65 with SMTP id w25-20020a2e3019000000b002a8b2e54f65mr30918ljw.14.1682020968577;
        Thu, 20 Apr 2023 13:02:48 -0700 (PDT)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id e2-20020a2e9302000000b002aa399f6ec5sm72602ljh.132.2023.04.20.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:02:48 -0700 (PDT)
Date:   Thu, 20 Apr 2023 22:02:47 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 24/32] sched_ext: Add cgroup support
Message-ID: <ZEGaZ+lQL7pHpmY5@righiandr-XPS-13-7390>
References: <20230317213333.2174969-1-tj@kernel.org>
 <20230317213333.2174969-25-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317213333.2174969-25-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 17, 2023 at 11:33:25AM -1000, Tejun Heo wrote:
...
> +/**
> + * scx_bpf_task_cgroup - Return the sched cgroup of a task
> + * @p: task of interest
> + *
> + * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
> + * from the scheduler's POV. SCX operations should use this function to
> + * determine @p's current cgroup as, unlike following @p->cgroups,
> + * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
> + * rq-locked operations. Can be called on the parameter tasks of rq-locked
> + * operations. The restriction guarantees that @p's rq is locked by the caller.
> + */
> +struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
> +{
> +	struct task_group *tg = p->sched_task_group;
> +	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
> +
> +	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
> +		goto out;
> +
> +	/*
> +	 * A task_group may either be a cgroup or an autogroup. In the latter
> +	 * case, @tg->css.cgroup is %NULL. A task_group can't become the other
> +	 * kind once created.
> +	 */
> +	if (tg && tg->css.cgroup)
> +		cgrp = tg->css.cgroup;
> +	else
> +		cgrp = &cgrp_dfl_root.cgrp;
> +out:
> +	cgroup_get(cgrp);
> +	return cgrp;
> +}

^ #ifdef CONFIG_CGROUP_SCHED, otherwise we may get build errors, like:

kernel/sched/ext.c:4251:34: error: 'struct task_struct' has no member named 'sched_task_group'

> +
>  BTF_SET8_START(scx_kfunc_ids_any)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
> @@ -3431,6 +3803,7 @@ BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)

Ditto.

-Andrea
