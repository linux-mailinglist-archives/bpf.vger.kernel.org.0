Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6399589493
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 00:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiHCW7a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 18:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCW73 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 18:59:29 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29698167DB
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 15:59:29 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id j10-20020a62b60a000000b0052b30f6626bso7057365pff.17
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=oWv8gQNZioaNWfZY4VWI1UA8rpMmTlOzBEW8u+A5nck=;
        b=bUlcrVMQa/lRN91UGS5DI7iUwLnJygWcFXBBRrb9CJRuuQCwyxSnWgXatqK3nkQkb6
         JuS4wuRF/+JgHbA8uWBg0haFCU4xo7TCOzHU6t0BBO9dVuyEbeMaAj4IIzixQhFEO2fo
         yOdsqm3OSQ4/VLmgLC4HmFhlHhxYW8nXQOCbpOKuLhutzpN/wwHQv1Udzvkj59AOnV23
         lRVtuUCxR2lQDMDJcB5D51OOLKngIBpzQpby3BJ6Fuoafwj9l3M7XneibSzLSvmw4j9P
         Uz8Jj48lvUgOczguz6406OZ3urtiNaRR9cL+bEUmZo10aTuOBmfS4gjv7brhAv0W4KRF
         RhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=oWv8gQNZioaNWfZY4VWI1UA8rpMmTlOzBEW8u+A5nck=;
        b=WuMPyBj67sWkI6c2gmM2OQMsFK8TMroE2PMyiyIc8THRlJRVPV6cC6mxVP8/o20OUb
         R84JxJeODI8Jvcoh+y/9S1u7fnXu5/hpQUj5LKZCgmsgEo9CMeHAGdkofdoeMijYR6Ww
         ZckIaIDDhjzkcQjh1QkgCY9DkYtzhFAoAkaUtC0im26TcQrwXY9TMNZJTZK3dowKkb59
         d/+PT9q8srnHCmeDTsOUL+5MUuXVJGz091qfaPghTwgLJOuln4hzVfbAfHZlmXWLtUvl
         hVSynpPizgCY4iduQaw0Cy7OIdWmZUYoYHBaDSmZd32kAgz8vPqNItOlwvU4Y+6sq2IT
         sEQA==
X-Gm-Message-State: AJIora81ZakPbOAkmP++7CfhGrYt5/Fqh9rKWC+PkJTxmKt3RYPTEg2l
        3Lo0lW6yTN2v63E8Cww0KJO8QCk=
X-Google-Smtp-Source: AGRyM1u0wfwdD4zYu+Erg+2ODZS8zzaLZ9lvuiRbhcKzx2wKsGjKnphMFL9KUz7sippixs59xZ/mXTg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:9d48:0:b0:419:f140:2876 with SMTP id
 i69-20020a639d48000000b00419f1402876mr22758081pgd.303.1659567568543; Wed, 03
 Aug 2022 15:59:28 -0700 (PDT)
Date:   Wed, 3 Aug 2022 15:59:26 -0700
In-Reply-To: <20220803204614.3077284-1-kafai@fb.com>
Message-Id: <Yur9zosqo4zpVBx5@google.com>
Mime-Version: 1.0
References: <20220803204601.3075863-1-kafai@fb.com> <20220803204614.3077284-1-kafai@fb.com>
Subject: Re: [PATCH v2 bpf-next 02/15] bpf: net: Avoid sk_setsockopt() taking
 sk lock when called from bpf
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, kernel-team@fb.com,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/03, Martin KaFai Lau wrote:
> Most of the code in bpf_setsockopt(SOL_SOCKET) are duplicated from
> the sk_setsockopt().  The number of supported optnames are
> increasing ever and so as the duplicated code.

> One issue in reusing sk_setsockopt() is that the bpf prog
> has already acquired the sk lock.  This patch adds a in_bpf()
> to tell if the sk_setsockopt() is called from a bpf prog.
> The bpf prog calling bpf_setsockopt() is either running in_task()
> or in_serving_softirq().  Both cases have the current->bpf_ctx
> initialized.  Thus, the in_bpf() only needs to test !!current->bpf_ctx.

> This patch also adds sockopt_{lock,release}_sock() helpers
> for sk_setsockopt() to use.  These helpers will test in_bpf()
> before acquiring/releasing the lock.  They are in EXPORT_SYMBOL
> for the ipv6 module to use in a latter patch.

> Note on the change in sock_setbindtodevice().  sockopt_lock_sock()
> is done in sock_setbindtodevice() instead of doing the lock_sock
> in sock_bindtoindex(..., lock_sk = true).

> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>   include/linux/bpf.h |  8 ++++++++
>   include/net/sock.h  |  3 +++
>   net/core/sock.c     | 26 +++++++++++++++++++++++---
>   3 files changed, 34 insertions(+), 3 deletions(-)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 20c26aed7896..b905b1b34fe4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1966,6 +1966,10 @@ static inline bool unprivileged_ebpf_enabled(void)
>   	return !sysctl_unprivileged_bpf_disabled;
>   }

> +static inline bool in_bpf(void)
> +{
> +	return !!current->bpf_ctx;
> +}

Good point on not needing to care about softirq!
That actually turned even nicer :-)

QQ: do we need to add a comment here about potential false-negatives?
I see you're adding ctx to the iter, but there is still a bunch of places
that don't use it.
