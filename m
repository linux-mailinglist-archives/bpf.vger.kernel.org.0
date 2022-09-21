Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9E5BF81A
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiIUHqu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiIUHqr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 03:46:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1AF75CE0;
        Wed, 21 Sep 2022 00:46:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bj12so11587104ejb.13;
        Wed, 21 Sep 2022 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Jvswl6qPZOcAXOYK+YaACZfbIZSk41zN4O+biBvkXG0=;
        b=YaRXBHJPol1fGJedZAViFdap5ub5A1LUkNMA7njQyXZrRZjoHQt2NhuGJNAwLA3/N6
         eMX8JQjcigJ+P+X0ZNVkZv3IMd2OeoJzZv5kZ0TSe6A9IuEm5WSNwPTPVZCdHgnpu2BA
         ZEQLJsbH9GptoGHCKH65NQyaqavJHZKYNNnIdMDUsOhMDCaAl3hKybZlme+f61t55MWR
         MZl7AjazZAdbHkD0NimC/TxK+g2kW0WNEBpzDs3jXf4akHF048JoJlWm+DithTsi16XB
         IZs8I0wYBzRZTBKK3hERcY/SZ6ST9irLlcGGVSuy/4mYm07ryjg2PT3uXChek+QG4JBe
         vIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Jvswl6qPZOcAXOYK+YaACZfbIZSk41zN4O+biBvkXG0=;
        b=UrtsuI6kFHAUs0wQBVtJbrbR1gbDuGTCwwqLVeYcYxEZ/KAmxa5p3/PJWFLkWPI1IC
         nZIOw/mbw+P2q6lYnWCZCCMhCdJu/M6nLDJtS+7YXYT7hJ9Qf2aHLMQOZtOw1QcjuWpZ
         LBD1Z2jXnr9BmCcJb48+HzW8/utGsM7ofuUr0Hj5O1D+Fi1IG98PQ4dul0uIhJVSuPyQ
         9Q2xWLWlD0jGf3Aa286EBjTmFqLUqtOv98fGNRM0wb/AUe898OBB94SEjd5SS9CuO1jN
         dSi19xb3zzR53YZdSo6A3tuYcOpnOx1Md4eh5Rb+EwVQvI4VaXpLz+vxOQF6pcqyl21G
         m6UQ==
X-Gm-Message-State: ACrzQf3SLLkqMxpKFkw9GPbKvR6xxT7kp70x4VkVcGb88Y0O8BOZWkqa
        yKNhASeUGF7sYLtzSMwJwLW/RczptHs=
X-Google-Smtp-Source: AMsMyM6i4J03MIvteEA1fiiRTP1mwoK51vO3ZiRjvim80xL0CQ2Wl+8A3wdnT2O/PqGP9v1ZjUZCrw==
X-Received: by 2002:a17:906:9b92:b0:780:1f91:30fc with SMTP id dd18-20020a1709069b9200b007801f9130fcmr20501508ejc.142.1663746403733;
        Wed, 21 Sep 2022 00:46:43 -0700 (PDT)
Received: from gmail.com (1F2EF035.nat.pool.telekom.hu. [31.46.240.53])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906a20200b0078020ae040csm869564ejy.219.2022.09.21.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 00:46:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 21 Sep 2022 09:46:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v2] kernel/events/core: check return value of
 task_function_call()
Message-ID: <YyrBYE4iMvei/nNC@gmail.com>
References: <20220919191611.1589661-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919191611.1589661-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Li Zhong <floridsleeves@gmail.com> wrote:

> From: lily <floridsleeves@gmail.com>
> 
> Check the return value of task_function_call(), which could be error
> code when the execution fails. We log this on info level.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  kernel/events/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2621fd24ad26..3848631b009c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13520,7 +13520,10 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
>  	struct cgroup_subsys_state *css;
>  
>  	cgroup_taskset_for_each(task, css, tset)
> -		task_function_call(task, __perf_cgroup_move, task);
> +		if (!task_function_call(task, __perf_cgroup_move, task)) {
> +			printk(KERN_INFO "perf: this process isn't running!\n");
> +			continue;

If this is a 'should never happen' condition, then this should really be 
WARN_ON_ONCE().

(If it can happen, then polluting the syslog is wrong.)

Thanks,

	Ingo
