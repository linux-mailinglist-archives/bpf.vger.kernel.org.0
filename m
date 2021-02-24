Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89EC323851
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 09:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhBXIKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 03:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhBXIKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 03:10:17 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C016C061574
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 00:09:22 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id g5so1515644ejt.2
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 00:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hXopz/XWSSH0QBUDbuWuPX2XcafKxOnD39fxX8+oe0=;
        b=DwsOIjDOmi8nKDZFszozTfmjsY50FEYCU8ib9Lt3Kx7M48MYhKEI1sJmq9DNvT60U0
         /dEXOQkfiAuoVLmHUNp6VeEzx62rXRMrGyN1ostqhKjGKYL/8z2KcmedKN9w/s1Sxn/3
         Qj8lBzq4tdl8nsX1/PjeULpHrqvrQ3HRyqIcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hXopz/XWSSH0QBUDbuWuPX2XcafKxOnD39fxX8+oe0=;
        b=VIWWNCDlNOG1g76lD+MFKwnUfg+N4YuUETkbplJhXqm15aK24JKI/SniwcYpLdwSIl
         vXAULF2wyFwPWtq5oBGpoD+SAgKUR9531L8zIkac06+BQL17eND7hqPLCuNoMfRChKD6
         LtlPkrIhxb+kq1ZIfMhIo0aKMFCXnqjbbE6tMVEB/Yk7b0lzIwqYwRj9gRTSzJVm6NLm
         ssWrosPW13z53B4qOxMQtdoyhltJF4KWKNMIEBj0xPQJKhTXuMtl/0iXWzpTs5BQ2ypY
         rg/6ov8bZNGkOqqHsADvKpSqjfVtMQLoFesfM3xWd/KbQTKsdkY5pn+gOU+R+pT+FIWO
         tfkQ==
X-Gm-Message-State: AOAM533vQB+vaL6PK+JY4LGYexjjtWOnR5Qqejy33NBNfJmnMTxP4Y0m
        IrYfQYch1abinLg2XWkYNT8kTg==
X-Google-Smtp-Source: ABdhPJxZEY7qzmfMH7xYdxlxTvQdmAU3JLHzK0xyoshe55PvYKLy1v7HK27rwqWOh/OLELd1hoP47A==
X-Received: by 2002:a17:906:934f:: with SMTP id p15mr25483543ejw.473.1614154160886;
        Wed, 24 Feb 2021 00:09:20 -0800 (PST)
Received: from toad (79.184.34.53.ipv4.supernova.orange.pl. [79.184.34.53])
        by smtp.gmail.com with ESMTPSA id y20sm859782edc.84.2021.02.24.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:09:20 -0800 (PST)
Date:   Wed, 24 Feb 2021 09:08:55 +0100
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch bpf-next v7 9/9] skmsg: remove unused sk_psock_stop()
 declaration
Message-ID: <20210224090855.718e8ad6@toad>
In-Reply-To: <20210223184934.6054-10-xiyou.wangcong@gmail.com>
References: <20210223184934.6054-1-xiyou.wangcong@gmail.com>
        <20210223184934.6054-10-xiyou.wangcong@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Feb 2021 10:49:34 -0800
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> From: Cong Wang <cong.wang@bytedance.com>
> 
> It is not defined or used anywhere.
> 
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
