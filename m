Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF63532A46C
	for <lists+bpf@lfdr.de>; Tue,  2 Mar 2021 16:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578096AbhCBKff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 05:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577605AbhCBJph (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 04:45:37 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E04CC061756
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 01:44:45 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q23so23110395lji.8
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 01:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHrxfmV9VqctHmCnIbkXHn8qNGwiob8Qpm1HTJJTCzE=;
        b=juSybNDJO3bTlTow3bGeK0gH+W3PCiBmXGPi96XzJp3+b6j9B13FTZeHyKlAi9NmEg
         BgFqCJ3kayWsop47Bo/5QSNqOZGUp0aDjFeI2qqaTy+11uYpk7+V47GtNvF21Rsm4DCs
         mgE6nOel0fKUZRc1j1VrR8liZO9ZpPsd9O5aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHrxfmV9VqctHmCnIbkXHn8qNGwiob8Qpm1HTJJTCzE=;
        b=GlAtUM2lj49OhZ0g9Tvm46tPi7FCiPJ/W/2P10Cwuqjc79ulIDcRtTKv450YThGKvn
         zNfruGnKEeEE5uF65T21nVJEE+lFPf2IVVCiKxRWQUU07hny2mgOoGFVLlYqDQ/xSaxE
         dDuTrQPQJDpGNM53HrW3Qkfawxp/z+7oLoEN0KE8g3skn5MBf+asooZUMYHK4CmRu2Jw
         z3nChiJHjVdhl21PBgSzX1/yccRVoVDDEe7BDdwgpkdOcwA5nFvAnxX8KTv+ViXaHavv
         TugcYAFuEVAF1bEwMzSDq5jwrJF3tBRm1+2WfeHwSi0KZGBxQ1bsOFqDFNAZL1aqQgjB
         huQw==
X-Gm-Message-State: AOAM533iu3y+LjjMt635sewlFVTq7BsC5Dd3lECq72ze6dFxrMoq7m/q
        MGMT1GDHaY50PVM+DeO7gVCzn6hBwpd6xchH3bG1fw==
X-Google-Smtp-Source: ABdhPJzTqebHkKvN0lljkDSYm953QyV+cMWBqCHz3J49dRqBnAtGo6LTTp0CACJMhLIp5MHuTi0pBc9WhsOO1Z0Lwy4=
X-Received: by 2002:a05:651c:1318:: with SMTP id u24mr11833762lja.426.1614678283978;
 Tue, 02 Mar 2021 01:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20210301184805.8174-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20210301184805.8174-1-xiyou.wangcong@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 2 Mar 2021 09:44:33 +0000
Message-ID: <CACAyw9-sas9U_KKsRjtQUdd=iiBmLmWYup4KFGEmB470H-b4Xw@mail.gmail.com>
Subject: Re: [Patch bpf-next] skmsg: add function doc for skb->_sk_redir
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 1 Mar 2021 at 18:48, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> This should fix the following warning:
>
> include/linux/skbuff.h:932: warning: Function parameter or member
> '_sk_redir' not described in 'sk_buff'

Thanks!

Acked-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
