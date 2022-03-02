Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C54CB276
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 23:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiCBWqI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 17:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCBWqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 17:46:08 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE72125C92
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 14:45:18 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t14so2895186pgr.3
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 14:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFQG+6kZG13cRzcVw5sdXMiwmqZRNHoyAGSTXlkjVVk=;
        b=PMmfKdV7zJWymaAL9lvAVw58IAeEH0cxqEz80WdkJzaMQ9nQpDN4RUN52vCyxs0nqj
         ZsseffgjfmPApoZuzFHYeqOY3jwajYkye7erYXM7RbK+qxsEIvxWv+HUyBCm+djnmkd+
         4eT+8Q58EJFLHJ02GzS06D03zk1uu6F9++Gn9nh3xn08CCNuvL6ypMOyOk3ChKS2Zbaz
         ZIlS/of+Kdr6d3G28ZbzHZYD8zTUVz5GHcIT+KAr9iWQIUq8XCz2WvzlFYC4qu/SlijU
         cor4hzk3wMVqkqnTKkaTaZgS66k3XX6Z8lQaWcDk3vTqb67QcvFFGSMFNd7O8U7xawju
         lGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFQG+6kZG13cRzcVw5sdXMiwmqZRNHoyAGSTXlkjVVk=;
        b=bVVtoM6tyN2GugpIqjf144WCI7CUEA9Fy+pjuG4+PFqDVUs+Sjf6pWqE7nbvs2GTqH
         yluH+z9Yfq/YoTPuzPz+4wHy3koR/fm4AsjB11qfeEPxlQ05ZkrtY0vgb50UNu4kj4Zm
         4u6leOFjDNGuWlbPu1JvpV+xE7mStUfVOoKTnOv378R6h4OIjKPYQRnxYXT915TAks4v
         a1Qkhb3c+XfQ05OM9L5vrCWcvl9FSZUvKNfIG1H1YQZCSde5YYOJ4OI2vHj5XsVWTpSj
         L774MPaXf1hKx4+gmS7IUuGiKB4PWKnzxnhyV7Gtah0Zzx1Oei5ZSGicpjnZwyxbpdy7
         cWQg==
X-Gm-Message-State: AOAM533D+AevoK4ik50HCK5hJvQf5OhZFi+H71HzcSk49C0dw62Tf0Fs
        L81Q1TE08eIkoibtroXKkxv5YHFoLq4z5QwsZdA=
X-Google-Smtp-Source: ABdhPJwP/A6hZ2zc0W3JY4iFVYzig6D+m5k9TxiAtnnOu5/CXP5B+Bpd/oRdC7sYQI0Qw5ZUEVrxhyXjHrFs8jhjxnI=
X-Received: by 2002:a05:6a00:809:b0:4f1:14bb:40b1 with SMTP id
 m9-20020a056a00080900b004f114bb40b1mr35459745pfk.69.1646261118106; Wed, 02
 Mar 2022 14:45:18 -0800 (PST)
MIME-Version: 1.0
References: <20220301065745.1634848-1-memxor@gmail.com> <20220301065745.1634848-6-memxor@gmail.com>
In-Reply-To: <20220301065745.1634848-6-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Mar 2022 14:45:06 -0800
Message-ID: <CAADnVQKXrPu4DB_5MnzC+E2aiebex9CqLD=rOUdGd0mKo_szBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/6] selftests/bpf: Update tests for new errstr
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 28, 2022 at 10:58 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Verifier for negative offset case returns a different, more clear error
> message. Update existing verifier selftests to work with that.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/testing/selftests/bpf/verifier/bounds_deduction.c | 2 +-
>  tools/testing/selftests/bpf/verifier/ctx.c              | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/verifier/bounds_deduction.c b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
> index 91869aea6d64..3931c481e30c 100644
> --- a/tools/testing/selftests/bpf/verifier/bounds_deduction.c
> +++ b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
> @@ -105,7 +105,7 @@
>                 BPF_EXIT_INSN(),
>         },
>         .errstr_unpriv = "R1 has pointer with unsupported alu operation",
> -       .errstr = "dereference of modified ctx ptr",
> +       .errstr = "negative offset ctx ptr R1 off=-1 disallowed",

Should this be a part of patch 3 to avoid breaking bisect?
