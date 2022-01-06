Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB2486861
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbiAFRXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 12:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbiAFRXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 12:23:51 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94ADC061212
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 09:23:50 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id w184so9420255ybg.5
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 09:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yi+iNCvwz+kpe6GsRBnjeTUzjVTeWQd1aYc7A1omaWk=;
        b=fx5ALr+uJFgKpXTeYgkhnEsCtOuelz7sC4rEHjEdH37yr8MqDZGGJjcdXhXzf5B0NW
         UCgFMksyQU9ctv3lOqnIIGcH76f6yPjaPJfa14FW5MeA9KLhHaOjC1sshe4wtYxkOzJE
         iU94+lmnXB5olrYFC0sWyPD/eRVpB8J+1s0hsYVk0ouXfX0F6T0kJmlJOsbBy38r7awm
         24t2jTOgW2XlYA7vebaXw8PLP3Ek/+3o56JNh8GDT/sM/npQFWnCfOZegeUqs9zTnbXV
         LdB4X/MA6Ou4NKnFJVriUKmhzPtB96QmuFTtOEEwpwEPYUqDf9KgYcetik11fBHM3EHK
         dxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yi+iNCvwz+kpe6GsRBnjeTUzjVTeWQd1aYc7A1omaWk=;
        b=CgHGYOPYPkj4KsbugrJcJEk10I5et8BLXksBh7hQnuRtDsFaBii5gNxPQCcUc9ULEI
         jxfsXW3QyOKolB4Q/VYtgWT0m1aPfsdvyoKoHNzbesym03V6ILaRHJCUCQv2yhLbL1r/
         BmYLLMO4PmZwIAs3ZrtnBooWtFgMiPQvDTpT10KY3SKuvp0irQiLL2Fw0MJJZUpByKpO
         68Fqtq74ePpJzgOEVuPi/XKkyTJazj/qf6i0wKpxvO/mv6WkAZl7waIo9Bb8PK7GYpZk
         FbpLl2LlFuoqOpG6c07fw/L7ALtfWLl1HUwR56F3xIiNDKnPUgFRjwARdQNgK5Q/0fOx
         6xaA==
X-Gm-Message-State: AOAM531MK1U/kgtfgFwM1cPEscKEbskvpAba+7ECuiHY6dd9Xvzyr0wU
        N5pTj0bRICBptoWr9P3IYUa1pH5zu+/y8MhvYiB+/Q==
X-Google-Smtp-Source: ABdhPJwfZP1m9v3L/YZ2JpfPrIAxecC0DQ9roBguX/Tj/f3gJ1bU/ksEbLHQXGKCyXcdkAJ74bm/s7Lv7mxjOrSb7Wg=
X-Received: by 2002:a25:9d82:: with SMTP id v2mr74979615ybp.383.1641489829648;
 Thu, 06 Jan 2022 09:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20220106003245.15339-1-yan2228598786@gmail.com>
In-Reply-To: <20220106003245.15339-1-yan2228598786@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 6 Jan 2022 09:23:38 -0800
Message-ID: <CANn89iKaekDBCzPMeoKsnyWSfQof5ZXMzR568XrgA2aC8Joexg@mail.gmail.com>
Subject: Re: [PATCH] tcp: tcp_send_challenge_ack delete useless param `skb`
To:     "Benjamin.Yim" <yan2228598786@gmail.com>
Cc:     kuba@kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 5, 2022 at 4:33 PM Benjamin.Yim <yan2228598786@gmail.com> wrote:
>
> From: Benjamin <yan2228598786@gmail.com>
>
> After this parameter is passed in, there is no usage, and deleting it will
>  not bring any impact.
>
> Signed-off-by: Benjamin <yan2228598786@gmail.com>

SGTM, thanks !
Reviewed-by: Eric Dumazet <edumazet@google.com>
