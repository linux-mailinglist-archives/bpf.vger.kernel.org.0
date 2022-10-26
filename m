Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB9F60DB56
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 08:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiJZGda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 02:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiJZGdJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 02:33:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD9EA99E6;
        Tue, 25 Oct 2022 23:33:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so13116646ejc.7;
        Tue, 25 Oct 2022 23:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mF6zW9SFm7uxaco2K2CDLfIGBcOnQunLUbLBgwIgUhQ=;
        b=Mm1POrX6xfBCMRhZT8ReywaZqeVagLYUSYmV51+7FJE1cm8Zx9McyYfiGKFnfn6fUz
         dfzUlLnVrsB4zqU0NAuFQ8udQ4ALm1QDYbTAm0odL18FxEi/FR028ecb5YKs/PfebjiO
         8P59bm7H327h6mNW0I9O319E9RIKIT8URtSbQcA8H17PLcP20gIztMvafyPrKx8A1qGE
         ccj383RGlmumOV2u7xoEH1iNQyjyYcZC5vbVEhI2NLrsyhHRtpDo2EQBl9Fbsqm+KDhe
         c3Fa8uBIuEEzq+m6O+MMfxRRz8dcQ5X57C4EVQ4Qo/5H7GHsNSQwAE0tF/b/4l3B6xzu
         fs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mF6zW9SFm7uxaco2K2CDLfIGBcOnQunLUbLBgwIgUhQ=;
        b=IMsHhkAaN9EJWfbHCIyBVejXiWTQVUjS3H7UBp7nImKxnYRli569A9ZMMikYKqYVRk
         b9J02hM/yVAXkqnPU9QqC8emz01VLxh5J/rWMZkg87Xlt/MHhnZeNA+1KgaC3+Uoktqs
         eg63B/gmi4jQL6L1DMDvpnvcVX2jMAy1FLVIaFDcfJK1KYiWA7hX3BC0KW1US6l026Vs
         mJxdEZ3Ixbv+8XhnRyctHCiy4g3vKqd829jgZmdjrHt4oAIlKvrMxcXSa5WZ9RFEzUrG
         iZpzi7Y0AzOogAlxxptaU9P7/xe1rFhKdcT59hI6vgOf4NwQXKOP2J8jPukla8Z9Ci3h
         s5hg==
X-Gm-Message-State: ACrzQf3rknddlG4n+IOeyyevXP5zRas0oldCZ1+38lfFh5HqEu58mM6X
        R4nk8+gsq+2FcnNwZtOz9wc0m3TVzOZnujrLI9w=
X-Google-Smtp-Source: AMsMyM4oc5nOTH7XG4W2jHl5OtAiTtPzLROA0gvIMgTLF94IX2MvxdnuX2LQkafB5AySBX6uWode2zjVpZJ3J/qMFww=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr36870991ejc.676.1666765986787; Tue, 25
 Oct 2022 23:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221026025941.2621795-1-xukuohai@huaweicloud.com>
In-Reply-To: <20221026025941.2621795-1-xukuohai@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Oct 2022 23:32:55 -0700
Message-ID: <CAADnVQ+Pe73yjys+fjW1TBPscCmv6K9ur5bDPr2056ejwBBdZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a typo in comment for DFS algorithm
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
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

On Tue, Oct 25, 2022 at 7:42 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> There is a typo in comment for DFS algorithm in bpf/verifier.c. The top
> element should not be popped until all its neighbors have been checked.
> Fix it.
>
> Fixes: 475fb78fbf48 ("bpf: verifier (add branch/goto checks)")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b83a8d420520..96ba5ea6d1a6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10662,7 +10662,7 @@ static int check_return_code(struct bpf_verifier_env *env)
>   * 3      let S be a stack
>   * 4      S.push(v)
>   * 5      while S is not empty
> - * 6            t <- S.pop()
> + * 6            t <- S.top()

Even with this fix the comment is not quite accurate.
I wonder whether we should keep it or delete it completely.
At least please use 'peek' instead of 'top'.
