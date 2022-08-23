Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7590159EE25
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiHWVWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 17:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiHWVWr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 17:22:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B6870B5;
        Tue, 23 Aug 2022 14:22:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g18so15185971pju.0;
        Tue, 23 Aug 2022 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=wOND1V135ybVgBeyri71HQXulvGc+Y6tAvCHYnlfi6k=;
        b=ogDnY8T52ORM/8gqc/hAW0UAHi4wiv+vhBMGFZaT5dH0F4JeKpLUWcNE+l1BwBlm82
         G2qgNbNTtS6fMvKyi6SxLyXgwSjMEvnMyr3Poeq/3/siN/wWsw/35fBiiCuYR+kGtIsC
         u8bJIq2A5umMuhWTnsCOvLy38kiLduPqULm/cR/ILYhYM/K/ekv+kcV4KWX9Vbp2X42Y
         p8RK/UllDJR5iB7pW5LMe3UyqDGPmgMiYG7JR3qBnwOwPStBh38q12i3UUY0SJhe7psT
         /BX2vFzCWJ/MoK98DC+YGcqELHZI0Rm0t0aMNY1IZPhblGBk6js9E+XduSOMxCBdYDBk
         0R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=wOND1V135ybVgBeyri71HQXulvGc+Y6tAvCHYnlfi6k=;
        b=xrDWUTjqq9csL3m6oe+S+Te2G1YJX99FrlP8rU3ij95RQFbu4jjdf6oXHzVMZrw5Df
         5s53CmjMpQ0vAuKdSZdgqBRC/f88sVQI5Y0FKTk2TvcMDVGMqN9hKLAWjeNmIvGwHgxK
         J4sWUYc6le8j2sAKNl5FebTWGnztqJcugZr5WRoV99/TtSj+MUvz7u4TFGEcqTxAplH1
         AovoEAMCvoI74i+MO61gyQANatA4RHiAwzAxUsq8wZDa94GNvKusQUSoEeaAcXeU9a5O
         hgYec+gud7gd2c0h2WKR9J/VfNsjJISDeJNnB8Wy12otX4gMmGSYGqj5sn6/stAIiK9+
         ArOw==
X-Gm-Message-State: ACgBeo1+X5W6CDegHj/QFvzw8gG432VXk36Lh88S5n1GGIYhjYrI1dbn
        LaIEGAMI3fFmf8r3gntLSs0=
X-Google-Smtp-Source: AA6agR6doRoOFuOAiwu4jGggUP+8g4MGwgZtBahxEvo6lKJpHzkUzDnlfScOGMdwoOTMchQmtjkWpQ==
X-Received: by 2002:a17:903:41c5:b0:172:fc8b:d186 with SMTP id u5-20020a17090341c500b00172fc8bd186mr5907355ple.90.1661289766379;
        Tue, 23 Aug 2022 14:22:46 -0700 (PDT)
Received: from localhost ([98.97.33.232])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b00172ff99d0afsm2296428plr.140.2022.08.23.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 14:22:45 -0700 (PDT)
Date:   Tue, 23 Aug 2022 14:22:38 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Pu Lehui <pulehui@huawei.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@goddogle.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
Message-ID: <6305451ee5e7e_292a82086e@john.notmuch>
In-Reply-To: <20220820120234.2121044-2-pulehui@huawei.com>
References: <20220820120234.2121044-1-pulehui@huawei.com>
 <20220820120234.2121044-2-pulehui@huawei.com>
Subject: RE: [PATCH bpf-next 1/2] bpf, cgroup: Fix attach flags being assigned
 to effective progs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pu Lehui wrote:
> Attach flags is only valid for attached progs of this layer cgroup,
> but not for effective progs. We know that the attached progs is at
> the beginning of the effective progs array, so we can just populate
> the elements in front of the prog_attach_flags array.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Trying to parse above, could you add a bit more detail on why this is
problem so readers don't need to track it down.

> ---
>  kernel/bpf/cgroup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 59b7eb60d5b4..9adf72e99907 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1091,11 +1091,14 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>  		}
>  

Because we are looking at it let me try to understand. There are two
paths that set cnt relative bits here,

  if (attr->query.query_flags & BPF_F_QUERY_EFFECTIVE) {
      ...     
      cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);                                       
      ...     
  } else {
     ...
     progs = &cgrp->bpf.progs[atype];
     cnt = min_t(int, prog_list_length(progs), total_cnt);
     ...
  }

And the docs claim

 *              **BPF_F_QUERY_EFFECTIVE**
 *                      Only return information regarding programs which are
 *                      currently effective at the specified *target_fd*.

so in the EFFECTIVE case should we be reporting flags at all if the
commit message says "attach flags is only valid for attached progs
of this layer cgroup, but not for effective progs."

And then in the else branch the change is what you have in the diff anyways correct?

>  		if (prog_attach_flags) {
> +			int progs_cnt = prog_list_length(&cgrp->bpf.progs[atype]);
>  			flags = cgrp->bpf.flags[atype];
>  
> -			for (i = 0; i < cnt; i++)

Do we need to min with total_cnt here so we don't walk off a short user list?

> +			/* attach flags only for attached progs, but not effective progs */
> +			for (i = 0; i < progs_cnt; i++)
>  				if (copy_to_user(prog_attach_flags + i, &flags, sizeof(flags)))
>  					return -EFAULT;
> +
>  			prog_attach_flags += cnt;
>  		}
>  
> -- 
> 2.25.1
> 
