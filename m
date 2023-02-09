Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1104C68FC7B
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 02:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjBIBOx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 20:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjBIBOr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 20:14:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DBDF2
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 17:14:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qb15so14604ejc.1
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 17:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DF0dqdRSyQOQ9sB7BlswYy+TEzCFrxU4U976rBlE6tI=;
        b=XP2U5pmeHBIupbRlq0EdSZAXBCkRJYnlkkyO7N1tttWvC9EF4IsIapTi/PaMr01BvE
         8vPK5mrI1ByG+wOcI2Fi6lynZN46UYzj29s+Zg53sVsMF4PlqqnJ80aKUSiwqfTQrU6x
         ay9MFNd+uNxA4KvY9h6JNBhdj1IIsvsICFoyu91fMZwVj7PNvxoGYC3a1y4z6kJiQMke
         EmL+dZ8uZiwch8tAQ7qz6rj38gIrS5RbOgSlMpV75mJelGSiaHkKfBJxUGS/lDDzldqn
         4B6pLiGLgCzOsYfX6N8myJQz6D+fszpL7kbUVbESir2m22BuKNA/AJMn8D+/NEVKtZl+
         XgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DF0dqdRSyQOQ9sB7BlswYy+TEzCFrxU4U976rBlE6tI=;
        b=WpKcQfilI34JGCMSGBEVicEGDxZNVwx2xNIK02hsqfVNZknO5+U4QTohFX6wSNJRcV
         TZvEsm56Zmab9dqLHOXRR2Wm6KOxzD6FtDA1bywwYGwvvvnpgYE6nTbaJsHqsAUq+eB+
         PKMwMlmBWucS/A+HDHZ/5YTHcv/EgC5EiK1HUip+tw6BUppRPwYBcLSYAU+LEWrwPs25
         /xXnK0lp20GkZBkYEa0m9bF+59HykH4sKBLjR9q4Un+Owounu4mG4/kl84EYwToVd4Ab
         cxqBUjE6isvpHRI1hWT760LSR27AvVTI9+77nO1rT5O0he4IWsoReIHHLv17hw6TU6xo
         CjFg==
X-Gm-Message-State: AO0yUKWpVyxalWjvdqfrCKe9Y7qAtd8ckg6hfyI5x/POUDL4eXlNYXQg
        KvRMNN0AfKAmwQK6UU04058sm5cU4n/aON/dGCs=
X-Google-Smtp-Source: AK7set/Zqu8kTv53KjR4HqEThjgenEQUu2NYPioO/T37Wr/LeGEFNrJuSzKNIbgyexVmlXinOhIrwtoTmS+Y2R57Vrs=
X-Received: by 2002:a17:906:5a60:b0:8aa:bdec:d9ae with SMTP id
 my32-20020a1709065a6000b008aabdecd9aemr1338338ejc.12.1675905284855; Wed, 08
 Feb 2023 17:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20230208205642.270567-1-iii@linux.ibm.com> <20230208205642.270567-8-iii@linux.ibm.com>
In-Reply-To: <20230208205642.270567-8-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 17:14:32 -0800
Message-ID: <CAEf4BzaCs+SPDoWO+hRL1t-3KYy4e6NGEK5j4OrSR5a63qA3JA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/9] libbpf: Fix alen calculation in libbpf_nla_dump_errormsg()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> The code assumes that everything that comes after nlmsgerr are nlattrs.
> When calculating their size, it does not account for the initial
> nlmsghdr. This may lead to accessing uninitialized memory.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/nlattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
> index 3900d052ed19..c5da7662bb04 100644
> --- a/tools/lib/bpf/nlattr.c
> +++ b/tools/lib/bpf/nlattr.c
> @@ -178,7 +178,7 @@ int libbpf_nla_dump_errormsg(struct nlmsghdr *nlh)
>                 hlen += nlmsg_len(&err->msg);
>
>         attr = (struct nlattr *) ((void *) err + hlen);
> -       alen = nlh->nlmsg_len - hlen;
> +       alen = (char *)nlh + nlh->nlmsg_len - (char *)attr;

we use (void *) for pointer manipulations, let's be consistent?
Otherwise looks good (I think, this whole nlattr stuff is very cryptic
to me).

>
>         if (libbpf_nla_parse(tb, NLMSGERR_ATTR_MAX, attr, alen,
>                              extack_policy) != 0) {
> --
> 2.39.1
>
