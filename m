Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11C931C22D
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 20:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBOTHN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 14:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBOTHL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 14:07:11 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2C4C061574
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 11:06:25 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id c17so8132723ljn.0
        for <bpf@vger.kernel.org>; Mon, 15 Feb 2021 11:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=nlK3q0YWLBAVnlXKZxWS33kMLrpccihTVh26VJjnw+I=;
        b=j7s/++HQuwQ0dPkGJVEFaOkmyPWx89p7HYNinQy2Kw+C+ye83h8lIk+xBpcML2iPLN
         cdGQSEuotJSUOQ7DRw1BnXUk9c16a40Bj+En3z3QWuCbSU15II+YMyOE2o3yOZgTpyQx
         IPi5Xc/bjTWf3kr7U0jF5Y82wyhDULg/CRvLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=nlK3q0YWLBAVnlXKZxWS33kMLrpccihTVh26VJjnw+I=;
        b=AepUMxC4KJuhEwmWptqzvxGkTMbnoLbRugpiP8d++4xqeYTVk0mPW9IxwFtHsaEPnz
         3o6yf6srN5sZtsrJ19EU6TL0md1YQpvgMerBYZMlmAOKKMGpNKOV6esygOciiMC8+0nj
         X6H6K2uoNANoRN+YH+61KEYbZLY7IaZv7yJxPol4xCoLA3by56f6vgJcD6Utgl+tp8gw
         Dgi9xe/0FCuX8i8tBKCBVg6OCTrfK2/VEFy3l1M+gtQ+bBWtHUdbmhSq3Zpplxoo/jRu
         +Ag0wVYWTZ4ZGD5o8xkT81jVRvWMR2sJ4hLVCZUboCeVvZU4jzOmSDkHBJv0Mkji8jZy
         ZZKQ==
X-Gm-Message-State: AOAM530k9ST5x9OS6pDf5+klIQv56S22x76O0oDxl6UkKmTxUVwj7nK5
        zC9e5AepUdnxv3l/i7V0us+8rA==
X-Google-Smtp-Source: ABdhPJyab84qkpdHElTAbOYC612cZAhEcRlUrwt3krnBenvG4JjD2TkjUL3Eb8ZyTI94tkx/v8DK/w==
X-Received: by 2002:a2e:9a0a:: with SMTP id o10mr10444014lji.466.1613415984019;
        Mon, 15 Feb 2021 11:06:24 -0800 (PST)
Received: from cloudflare.com (83.24.183.171.ipv4.supernova.orange.pl. [83.24.183.171])
        by smtp.gmail.com with ESMTPSA id o27sm2720795lfi.183.2021.02.15.11.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:06:23 -0800 (PST)
References: <20210213214421.226357-1-xiyou.wangcong@gmail.com>
 <20210213214421.226357-4-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next v3 3/5] bpf: compute data_end dynamically with
 JIT code
In-reply-to: <20210213214421.226357-4-xiyou.wangcong@gmail.com>
Date:   Mon, 15 Feb 2021 20:06:22 +0100
Message-ID: <87k0r940cx.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 13, 2021 at 10:44 PM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> Currently, we compute ->data_end with a compile-time constant
> offset of skb. But as Jakub pointed out, we can actually compute
> it in eBPF JIT code at run-time, so that we can competely get
> rid of ->data_end. This is similar to skb_shinfo(skb) computation
> in bpf_convert_shinfo_access().
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
