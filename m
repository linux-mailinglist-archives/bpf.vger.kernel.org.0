Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84EC588F52
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiHCP1Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiHCP1Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 11:27:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5211658B;
        Wed,  3 Aug 2022 08:27:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a89so21932188edf.5;
        Wed, 03 Aug 2022 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=NstIhUvDndfhWQhjJY54RegUN1YZlKiUPmz8PG5jen0=;
        b=kbUTCYf8W9wxbL8ZzhcpD7tffIrDNB7uTgsF2jrAZFtiH+/oSbwNJ/59q6xBEJMGW5
         J3+Df/AJ1ckT1I2e92XqpTGaXS6Cd9em/LvZQCXHq6f7fhkMGIWbyPCI6oEzx9Hvu3Pv
         wjv7zFVW5UrS4uZtf8ARoixOmHUNRriP/9I7fJ8GMQFZrYESpmtz2o93ThkCuW6iGey1
         pAd+d48rHt6aNNq1H3yPQvdXUOyxSpCh4LKrA1wk1vok3txU+BKqUC0V92iqewwTQOtZ
         t3sO+fNKrrLbURpfaz5bhhn4diPvgIRrI7dIn8C69gYPh0CGplwCVPPGRsLQaNa16pss
         Q3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=NstIhUvDndfhWQhjJY54RegUN1YZlKiUPmz8PG5jen0=;
        b=HVbillenALsdSzjVlD3Vfy+i8MVLYbCt29sWITwvNO+H/QdKtTOBovHWnhIczvauWz
         0XyqsyFDeCwF2mupe/hlGglalfTkqkAMPsRV6M6/9s54dumKDUFHiBhFr5RfO85Iu4YS
         I2lcg7msl1rNQ3lX8dHdGNo9YokyOE/zoOYNlAg18g59jytAK9uhZR5xvWWpvFawoPS6
         gA1nsH7D2OYo3oIharMmR6xBk7GC0PM4FBEU23SbBx67WN3++9QUamDQ3wOBKB1VJlS1
         Dn4IjpM8NoxNvrqjsw9M/gKydCtkz1zM1rQLl/FQ9tHzSygga8hSau5IJMXr3YQemGvp
         T9LQ==
X-Gm-Message-State: ACgBeo0RH5l+2LeuhLNrlHB1MQF4CaIbfmnQDJDnUdp5BQ5gO8OrvkCU
        Vhm/HewO6cu6vJ6dhWIHX8o=
X-Google-Smtp-Source: AA6agR6UzGbLznDIzufozkxc3QxIbkRILg9KQkRnk76qQftIeadMR3af1KL/ug7WWsuNc+O45rYqbw==
X-Received: by 2002:a05:6402:3583:b0:43d:6943:44a with SMTP id y3-20020a056402358300b0043d6943044amr18876184edc.409.1659540441529;
        Wed, 03 Aug 2022 08:27:21 -0700 (PDT)
Received: from krava ([83.240.61.12])
        by smtp.gmail.com with ESMTPSA id s10-20020aa7c54a000000b0043d1eff72b3sm8280323edr.74.2022.08.03.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:27:21 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 3 Aug 2022 17:27:19 +0200
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <YuqT17dTbHK521pC@krava>
References: <20220803134821.425334-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803134821.425334-1-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 03, 2022 at 02:48:21PM +0100, Lee Jones wrote:
> The documentation for find_pid() clearly states:

nit: typo find_vpid

> 
>   "Must be called with the tasklist_lock or rcu_read_lock() held."
> 
> Presently we do neither.
> 
> Let's use find_get_pid() which searches for the vpid, then takes a
> reference to it preventing early free, all within the safety of
> rcu_read_lock().  Once we have our reference we can safely make use of
> it up until the point it is put.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> Signed-off-by: Lee Jones <lee@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> 
> v1 => v2:
>   * Commit log update - no code differences
> 
>  kernel/bpf/syscall.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 83c7136c5788d..c20cff30581c4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>  	const struct perf_event *event;
>  	struct task_struct *task;
>  	struct file *file;
> +	struct pid *ppid;
>  	int err;
>  
>  	if (CHECK_ATTR(BPF_TASK_FD_QUERY))
> @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>  	if (attr->task_fd_query.flags != 0)
>  		return -EINVAL;
>  
> -	task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> +	ppid = find_get_pid(pid);
> +	task = get_pid_task(ppid, PIDTYPE_PID);
> +	put_pid(ppid);
>  	if (!task)
>  		return -ENOENT;
>  
> -- 
> 2.37.1.455.g008518b4e5-goog
> 
