Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031A66D2666
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjCaRFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 13:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaRFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 13:05:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61CCE38A;
        Fri, 31 Mar 2023 10:05:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q102so21069417pjq.3;
        Fri, 31 Mar 2023 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680282308; x=1682874308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKD3afd/dAGXfiCR1cGKCTKOhGubTZfFsF8fCBghIoQ=;
        b=WkH4rDy+elmsZkRjR7g8zey1NIy7ZCJWDApx9dSlPTYVKX+mTOvVxAWYj/tcyPKtkH
         IbpPGB1UrPPXg8elixNNZ3W68PDdqrPhH86l+75XXbb88tJPCGLCodgUQO+gyTsvyw9l
         RzVKG2YPiJjbmQKfKqlCzoMkQdGsZ1bU1Es15hV9iwk0lo+TGfwi4DKnlUpm5SNKlzlf
         m2bS7cep6+VESbbcPae5fid0UY1yWo9uL9mPLYGPUgokKHnOEClDTYDQTdJy5JYc7jza
         DcqPqLPa7o/D7nQFKRZuECQNF5syZ6btfe7AchWdWTkmvXeSJdF2iQcC0Kkeyj4fYrL2
         F5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680282308; x=1682874308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKD3afd/dAGXfiCR1cGKCTKOhGubTZfFsF8fCBghIoQ=;
        b=g7IIVw5mpZul53Zs3hdJ3thmimGNpX0RXR4W1LrDgxryey3fjapL4cMmaE0sIt84H1
         x6cejBvmUUCHnj/OsTk8fkR+13sLsQBY3TeI3M9fM97OHp20X11vS7eDLC1snS+XpKs5
         RvbhqhwOclPQUX0ZKTjqlMCgGcw9qSZ8BGgPOx+B3YORPa3r9n/tyXex0AAz0QkRvk52
         cWK+oZH8HX199tAycKWgU4P+2Wde9gDY80GQfy9L8lF19Qa2HrPzlC1P/YUMBWWR9mfA
         jeRVjWTRuvkH+yHK+p1VrJY0hUW2enuzzE+AG8XoquS7ZXZJIkqUtW+MuoXgznDxzv7h
         gJCg==
X-Gm-Message-State: AAQBX9diWXL8QczGeBswpzKpUt+2S1eyqutXyF8cwAp3ixnzMlZcGj/t
        rUpgn6eLDWmrt9EzWzBinKY=
X-Google-Smtp-Source: AKy350azQ89UZLvaddm6Z3VDyst1zflox4clYw4rnfSFxuzoRDeuuV/3Zd6lllztvql9crLxl5/cXg==
X-Received: by 2002:a17:903:22cd:b0:1a1:bcf:db5f with SMTP id y13-20020a17090322cd00b001a10bcfdb5fmr36504598plg.25.1680282308139;
        Fri, 31 Mar 2023 10:05:08 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:3c8])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b0019e88d9bed3sm1798093plb.210.2023.03.31.10.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:05:07 -0700 (PDT)
Date:   Fri, 31 Mar 2023 10:05:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Make struct task_struct an RCU-safe
 type
Message-ID: <20230331170504.umr5zmcraburmtkg@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230331005733.406202-1-void@manifault.com>
 <20230331005733.406202-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331005733.406202-2-void@manifault.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 07:57:31PM -0500, David Vernet wrote:
>  kernel/bpf/helpers.c                          | 11 ++-
>  kernel/bpf/verifier.c                         |  1 +
>  .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
>  .../selftests/bpf/progs/task_kfunc_common.h   |  5 +
>  .../selftests/bpf/progs/task_kfunc_failure.c  | 98 +++++++++++++++++--
>  .../selftests/bpf/progs/task_kfunc_success.c  | 52 +++++++++-
>  6 files changed, 153 insertions(+), 16 deletions(-)

See CI failures on gcc compiled kernel:
https://github.com/kernel-patches/bpf/actions/runs/4570493668/jobs/8068004031

>  __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
>  {
> -	return get_task_struct(p);
> +	if (refcount_inc_not_zero(&p->rcu_users))
> +		return p;
> +	return NULL;
>  }

I wonder whether we should add a bit of safety net here.
Like do not allow acquire of tasks with PF_KTHREAD | PF_EXITING
or at least is_idle_task ?
