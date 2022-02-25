Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D5D4C4AFF
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 17:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbiBYQjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 11:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbiBYQjU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 11:39:20 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA22118F1
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 08:38:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qk11so12008929ejb.2
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XVcaj+oUhdti0I0vXaHOHaOi/a54xbY99IH5vsRL+vQ=;
        b=5B9OsKjc8mHgPbLq7lDz2rqepBFJVFcZpyGP7vmBiB34FfVeA3yP/j4Ag8Ber+EmyZ
         8CE9qcbHXz/ZifEUa3TcS8mRp0t1XOkvbYrZ+7Gv9pbV+gR7hSV6ef0IIS7Tl6uj+A4X
         5toaPhQkjo/CY8UxFipK+pWyVlYpmCdYKxquF5dootFqYOPUnG6a+7aYAq8kW6Mq4Nqp
         7SqdwtLYD86HYSBCehusTCse9Y2LfWulXZVFPIyWYgHLJCxWU7rtZ+XS+mOkYLrINkF3
         ODPJAWbZ1L6iHsk2LGTV3uJQS6mkUGcpnJ/gb3mduvQOKBnOKAT1AP7vVM9by8WpXIcQ
         sGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XVcaj+oUhdti0I0vXaHOHaOi/a54xbY99IH5vsRL+vQ=;
        b=sJLvjtPeRAOzjCeXH8EyHJs+UC0n2LN222ZCTJYLFbUInmhE5jRhpEhs6ivMpeXvMI
         hc9sAcB/rRx1Ceyk+rzL4ERjCg3Vm1vrv/fuBP+0qVfk57J59sTpA5sAuLqtKaBm1uZV
         fqQfgh5RhMd4IeGBi/raLFonHopWFXcXDOMdd8YrXoUP3Fg9rP5dO1NkdNpsflHGkxvl
         LxONXg80icjD/ERRmgqZ6QybRhnXTZ1KpCCRteLXGeDOp2rRU+MpoQkQfLzCwZdLiJIb
         a1LKCuAqX7EIWHwcIxip1//SDr0w46/ArWkSolXpLjwZpnzuxFFly9yAnmybfAV0Ug1K
         yn2g==
X-Gm-Message-State: AOAM533nuiyTVqp3jN1ebTG2q45FApgEEqwZUV4jjNchx3P8Upa601he
        RNkoKNhjxlt4nkKqhLtJiNDPXQ==
X-Google-Smtp-Source: ABdhPJz1JnYhF/HxtfNqnhHGx1AdvoUlppKYhJg0qQH6PqV/eKWZLsZvl2piWXSSHmXaDv8wp+tnwQ==
X-Received: by 2002:a17:906:974e:b0:6bb:4f90:a6ae with SMTP id o14-20020a170906974e00b006bb4f90a6aemr6903846ejy.452.1645807125762;
        Fri, 25 Feb 2022 08:38:45 -0800 (PST)
Received: from [192.168.1.8] ([149.86.73.96])
        by smtp.gmail.com with ESMTPSA id pj4-20020a170906d78400b006ce88d5ce8dsm1180468ejb.108.2022.02.25.08.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:38:44 -0800 (PST)
Message-ID: <cd9f825f-bd00-11da-60fe-b8d075e2a7ba@isovalent.com>
Date:   Fri, 25 Feb 2022 16:38:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next] bpftool: Remove redundant slashes
Content-Language: en-GB
To:     Yuntao Wang <ytcoode@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        =?UTF-8?Q?Mauricio_V=c3=a1squez?= <mauricio@kinvolk.io>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225161507.470763-1-ytcoode@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220225161507.470763-1-ytcoode@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-02-26 00:15 UTC+0800 ~ Yuntao Wang <ytcoode@gmail.com>
> Since the _OUTPUT variable holds a value ending with a trailing slash,
> there is no need to add another one when defining BOOTSTRAP_OUTPUT and
> LIBBPF_OUTPUT variables.
> 
> When defining LIBBPF_INCLUDE and LIBBPF_BOOTSTRAP_INCLUDE, we shouldn't
> add an extra slash either for the same reason.
> 
> When building libbpf, the value of the DESTDIR argument should also not
> end with a trailing slash.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>

Looks correct to me, thanks!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
