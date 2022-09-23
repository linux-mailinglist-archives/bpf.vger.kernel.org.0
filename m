Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E75E7D1A
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiIWObr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiIWObq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 10:31:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA9813EE9C
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 07:31:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y8so453042edc.10
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1iIymZ4MsZ/27tgz86xKFO23iLkkp8G2o3rlhiFK85o=;
        b=SlhIreW+icqtSYIyLitsWbUql6E/9SSLdSAaIUCuwZHZ7PkA87Fi6NLGtwvqcxbjtP
         eqGvedRTQS4q9MISRCuHS9c1+13jjH148o4akCK9aYOC2N71rXz3WQj3J5E+Q5BlUKN5
         MjkGu3dMJPMJAOV+cS2cGk6sD728FEloFK5f+MCmouEZHa2M1sf/RrDWSB3f78DrDFFh
         zuh4LCCPrsXX6VNT0CRDzDp1Xj7aSyExjw0CtMS8Yipj911jpsMnfvEVeDdHhO3sBenr
         Hk1e/MyXXK771tjyEYOaQls0hzlrwgen+cWTqhpgrmp4rwYO0OXiwfol13XhP4oMwcal
         4TCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1iIymZ4MsZ/27tgz86xKFO23iLkkp8G2o3rlhiFK85o=;
        b=r6w0s1o3wbEz98BlufknRWayjNQvWFAX39ar29Dxxkb62mAWWfQ2Ttg4+X+jzRwhk5
         G7+qNToY4is22YnQQ1Cr4cg1HorGTKuZVN6QxC2kze6Mpn0+FNOALLbxmssYss1ESD08
         RgQ8vHkunwESsVv6UNmtmYpZ1ThRJgeN8VjYjLB2jTxHOZMSfIOHtFr2yuf6c+wZURXX
         78i0tS6Rat2sYJKOg7kT/BYJFvpUUWz+bdY9pShY/UxJyfYG5KulLkXy5zQ25AUJtCCb
         q0mTnA6DAc1WZtCqqfFSwOuNHBiNzwW0er5Um6d8XEZuPJqGd+ZhmsJ1QGUB5oBaBBRY
         Kzgw==
X-Gm-Message-State: ACrzQf0Dq+D3kELkxtosWqtMbssvYa6j7JgFtW5t+YmaTaU03gwQqhy6
        1l6r7jBD76aoZWNC3a7F/BvB0+TWNDJwzID1TdE=
X-Google-Smtp-Source: AMsMyM6DR0Rmr2EWU1uIWHOurl0sOYF0kqjL/JQmkgvsGS47JqVcXfLb5K4mIyKGrTJUegiiGEGskErb1/UFO+GKCNk=
X-Received: by 2002:aa7:c619:0:b0:454:2cca:6c0d with SMTP id
 h25-20020aa7c619000000b004542cca6c0dmr8780673edq.6.1663943503981; Fri, 23 Sep
 2022 07:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220923093509.521560-1-cuigaosheng1@huawei.com>
In-Reply-To: <20220923093509.521560-1-cuigaosheng1@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 23 Sep 2022 07:31:32 -0700
Message-ID: <CAADnVQJu0tRMX1==kbDvmddhXsj5i4BB=WdX+CpmtmVtS5N2Ug@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove obsolete iterators_bpf__open_and_load()
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 23, 2022 at 2:35 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> Commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light
> skeleton.") drops the last caller of generic_free_nodedata(),
> it is useless, so remove it.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/bpf/preload/iterators/iterators.lskel.h | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/kernel/bpf/preload/iterators/iterators.lskel.h b/kernel/bpf/preload/iterators/iterators.lskel.h
> index 70f236a82fe1..e5f9c608f7f7 100644
> --- a/kernel/bpf/preload/iterators/iterators.lskel.h
> +++ b/kernel/bpf/preload/iterators/iterators.lskel.h
> @@ -407,19 +407,4 @@ iterators_bpf__load(struct iterators_bpf *skel)
>         return 0;
>  }
>
> -static inline struct iterators_bpf *
> -iterators_bpf__open_and_load(void)
> -{
> -       struct iterators_bpf *skel;
> -
> -       skel = iterators_bpf__open();
> -       if (!skel)
> -               return NULL;
> -       if (iterators_bpf__load(skel)) {
> -               iterators_bpf__destroy(skel);
> -               return NULL;
> -       }
> -       return skel;
> -}
> -

Top of this file says:
/* THIS FILE IS AUTOGENERATED! */

Please do NOT send such patches for it.
