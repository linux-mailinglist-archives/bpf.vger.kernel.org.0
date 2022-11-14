Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0186286C7
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 18:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiKNRPj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 12:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiKNRPi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 12:15:38 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874031A059
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:15:37 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 36-20020a17090a0fa700b00213d5296e13so6106982pjz.6
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4VmFtJSnc4RstdqQpqN8mmAHg/Dq/mwoQmgl3yfBCY4=;
        b=joWTVGRAfz51lqAQC/R5oQXu9JUR0IlFveXK6+NQC2iWV4mGXBFMBkVgU9LA23l7li
         crTszedR3Wo6/Z+fgeV74SlCAu8zvjI/aRbmNMLItlaQ/Mbsgs+EaS6OIgkb0v6CERwm
         MlUmk+5QxvYn6txRiwHabxcU1O7inQSew8IWK6A9dIPIfvvUbN1IArsiAueje1ec5kMY
         vIFYQ02hKqgwq/bepTYQcX59LYcc+otkkOUO7d1bLQZ75crFxvizCgi/YCli73FZy41a
         Z9XIRMzQCJF0ImLaZXnhOB9CBgxHlh/3hSbxB8PLF8hqDn1f5xrlenj4TTVX+5SlTSsH
         BDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VmFtJSnc4RstdqQpqN8mmAHg/Dq/mwoQmgl3yfBCY4=;
        b=OoMSQu0VaXVXLOvnxAeppU4aUsdSKqa72PfiZhqDbXY3xRutNAEoNBX/IYvdGm94q6
         P2BIR8uvegmlrUUioRROLhg+R/tE/5cPfmv+r7jO9b4MJiZxgAqAq/NzOnwb7SzcLfu4
         FuGIvng4alWs38twwPK4CDiFoI573YhH8knme8xSs44Ieo3N9kb6J2mpWW2+00IfUUwt
         ktBYd0UkLEPTtM7b8LqXXYLSfJJ8toiXeXd4rSzKJCx3SbZqxWYWTKdczCbCvuZmP7su
         UqVP/D5bFytMXWge5kJMC03NQRImk1LK5WV5vioBiSMJceUSDuPkS5kkgE32UAknm+fE
         IIzA==
X-Gm-Message-State: ANoB5pk5EHmalvsqabPrOqZgHBUJhVuI75IE6057YRqPxq1t83gVtRXY
        Uk6rqjcWLMpTNDFZ9PdCHXsj2o0=
X-Google-Smtp-Source: AA0mqf5UrCTJsrqV+j4F0Gb2xTiXQLBMwhqp56TIjyWob0OTnomLr6++Np9qAXQ0B4LZIjfvdz+wBpw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:134c:b0:56c:31e:b0f6 with SMTP id
 k12-20020a056a00134c00b0056c031eb0f6mr14914336pfu.1.1668446137049; Mon, 14
 Nov 2022 09:15:37 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:15:35 -0800
In-Reply-To: <2b3f2420.130.184706d34e6.Coremail.wangkailong@jari.cn>
Mime-Version: 1.0
References: <2b3f2420.130.184706d34e6.Coremail.wangkailong@jari.cn>
Message-ID: <Y3J3t/ieGaOG8Qjl@google.com>
Subject: Re: [PATCH] samples/seccomp: fix array_size.cocci warning
From:   sdf@google.com
To:     wangkailong@jari.cn
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        keescook@chromium.org
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

On 11/13, wangkailong@jari.cn wrote:
> Fix following coccicheck warning:

> samples/seccomp/bpf-fancy.c:83:39-40: WARNING: Use ARRAY_SIZE
> samples/seccomp/bpf-fancy.c:86:44-45: WARNING: Use ARRAY_SIZE

Not sure this should go via bpf tree. CC'ed Kees

> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>   samples/seccomp/bpf-fancy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/samples/seccomp/bpf-fancy.c b/samples/seccomp/bpf-fancy.c
> index 1ccb435025b6..548f038924d6 100644
> --- a/samples/seccomp/bpf-fancy.c
> +++ b/samples/seccomp/bpf-fancy.c
> @@ -80,10 +80,10 @@ int main(int argc, char **argv)
>   	};
>   	struct sock_fprog prog = {
>   		.filter = filter,
> -		.len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
> +		.len = (unsigned short)(ARRAY_SIZE(filter)),
>   	};
>   	ssize_t bytes;
> -	bpf_resolve_jumps(&l, filter, sizeof(filter)/sizeof(*filter));
> +	bpf_resolve_jumps(&l, filter, ARRAY_SIZE(filter));

>   	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>   		perror("prctl(NO_NEW_PRIVS)");
> --
> 2.25.1
