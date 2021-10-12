Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD5429EDE
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhJLHrF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 03:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhJLHrF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 03:47:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0338BC061570
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 00:45:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u18so83835178lfd.12
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=9Q9SuO5C0iwIKXcp9Q9f5rj29mbddspWpU7SkymsaQY=;
        b=N+RkAQfRZjNhGe/LRXQX/vfUeRRe/2ocYAfu/hjDQ1EJKCLTr+8fdEi3Z9z/AskaQB
         t9mzoV3BRb0TeBGM8kJkr0UIQ2d5xwdnR2e2dRKtnO5fWj5wBY+YlABp3KFK1pkc/o3L
         5X1yO/DrMdBcEi6ImcrRk2oMH67c0wpEZFKNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=9Q9SuO5C0iwIKXcp9Q9f5rj29mbddspWpU7SkymsaQY=;
        b=BccI7QquJjEh80I5j34+rhPnC2ssIg+A659N6d7r7Tq0LezmOPqbou4BwYjEitKbcA
         O12t5uZPExsQVVe8WGz4grCRGPJM+Rv9MMj91+OoXKERZ3vJdfG33S9/shoLs1nC/pwH
         C1jmsis6rMwDGYDAvoStUE8FDxyM9bmxOGB81aq+Y678/zTwV+nB73r5nVkwLK56DLBX
         ypNtysS0AnJV767Kwa5rHOy6Mn1IhN7s4rGP6KfVREEB7nZVRVUVHvi6UOvB0oqKjRsc
         +Hg+5dF8+jzuCa47EevBper/Q+HMxzzkLpI/O1dbnOQg9Hte6XajzT4mWrjTEebnWQLM
         f5nA==
X-Gm-Message-State: AOAM533tXzPwaVleF7TKa8xpEpVAPEoG05QDiP4Xaw2qRVXRjHCQj5W/
        gscE6Xh/yzf847b1RGC7SPUovg==
X-Google-Smtp-Source: ABdhPJw4KnqaR+4CKcH38sB0dURaJ7ebz4zp8Ww09NWvO0OY7hQ6buvStGWBoz+P4ZdV+If3QTNc/w==
X-Received: by 2002:a19:4409:: with SMTP id r9mr8213422lfa.683.1634024702310;
        Tue, 12 Oct 2021 00:45:02 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:480d:6f00:ff34:bf12:ef2:5071])
        by smtp.gmail.com with ESMTPSA id q12sm1092759ljg.19.2021.10.12.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 00:45:01 -0700 (PDT)
References: <20211008203306.37525-1-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch bpf v4 0/4] sock_map: fix ->poll() and update selftests
In-reply-to: <20211008203306.37525-1-xiyou.wangcong@gmail.com>
Date:   Tue, 12 Oct 2021 09:45:01 +0200
Message-ID: <87y26yg002.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 08, 2021 at 10:33 PM CEST, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> This patchset fixes ->poll() for sockets in sockmap and updates
> selftests accordingly with select(). Please check each patch
> for more details.
>
> Fixes: c50524ec4e3a ("Merge branch 'sockmap: add sockmap support for unix datagram socket'")
> Fixes: 89d69c5d0fbc ("Merge branch 'sockmap: introduce BPF_SK_SKB_VERDICT and support UDP'")
> Acked-by: John Fastabend <john.fastabend@gmail.com>
>
> ---

For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
