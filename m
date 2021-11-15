Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92344FE25
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 06:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhKOFYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 00:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhKOFYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 00:24:08 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820DC061746
        for <bpf@vger.kernel.org>; Sun, 14 Nov 2021 21:21:11 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w22so19661421ioa.1
        for <bpf@vger.kernel.org>; Sun, 14 Nov 2021 21:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=K/du4LuLyFgRVeI0c6urbpLLrOOx7mRgAuN+3DTwtBY=;
        b=eCAwoF/U2mRxCTxESkyHvu6ragO4Qh8uqq3tGV0WuK9QKa+8X5rYKt57j30XM4M+Co
         tfendU7Mh5RAR6pejY7PDlGZqdqvgDyrFrNKQCLB/YMou9MhuhDe2tsQWrNQr8f4GgDR
         XzPFuByHzhMNMz6fNri0+VLMjiWKLiBIgXj9K+oBoEcdxPA4vNHjxEwBpms/PBGwNPet
         QEBdG7zSj+sGCfj9CZ+ERicdics2Qr3opma3u30Uq4z3rdOm8i+C4qN7GE16hqzkJKKM
         ERS16BZq3L9h2NjVoVK3u6Kpyre/PbiyjFJzCa/i6XfKFpPUP+GZSPPDidOLHtdRrwy8
         Pahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=K/du4LuLyFgRVeI0c6urbpLLrOOx7mRgAuN+3DTwtBY=;
        b=wVynziPMJXTcTy9pjo6Ox1m097x1Y0fluq2VCwSO6kavL+gE1Cf36s+1VZ+s0ev7Bn
         nVsiHLuR2lbL+eC3NrJk7DYNy3w1gj6ieO7gaifFQqvur6IDeUyVstOx4tYm0tZJ6jaZ
         dCycxJDvPQG1Khz9e80bN08A4aOg/ZvQ8cuRIC2cgqFBWRmDPhTxuQk9ReNyQv1YJBjv
         L9OBD7rLuzgX5a5la14lSVt5IPiSZXvodoeTA5CCjPDb8v5atq9I8nymCle3AE8lB3ud
         Vm+2BXvhPL72IgNIQJpdlJLoWzemiz250EIrUjjG0Dd4wttmJmgLcBf77CrqSJulnZ5R
         tmRA==
X-Gm-Message-State: AOAM533vuMvyacXADEUvs72KSUNLShemLibCbfo6Cfx/f/41FKRwTnF/
        cMBE5oQ+iTsWNSl+PS0OKpc=
X-Google-Smtp-Source: ABdhPJxR3Dl7LLOcFWqi9eLwCxA+JFPrYtjnY4O1fdAPFdZcpNZvxUcNfAICWQk71/IUVNKpFSEvgQ==
X-Received: by 2002:a6b:700e:: with SMTP id l14mr23751617ioc.20.1636953671033;
        Sun, 14 Nov 2021 21:21:11 -0800 (PST)
Received: from localhost ([172.243.151.11])
        by smtp.gmail.com with ESMTPSA id g11sm8588873ioo.3.2021.11.14.21.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 21:21:10 -0800 (PST)
Date:   Sun, 14 Nov 2021 21:21:02 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        joamaki@gmail.com
Message-ID: <6191ee3e8a1e1_86942087@john.notmuch>
In-Reply-To: <CAADnVQKEPYYrr6MUSKL4Fd7FYp0y5MQFoDteU5T++E6fySDADw@mail.gmail.com>
References: <CAADnVQKEPYYrr6MUSKL4Fd7FYp0y5MQFoDteU5T++E6fySDADw@mail.gmail.com>
Subject: RE: sockmap test is broken
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> test_maps is failing in bpf tree:
> 
> $ ./test_maps
> Failed sockmap recv
> 
> and causing BPF CI to stay red.
> 
> Since bpf-next is fine, I suspect it is one of John's or Jussi's patches.
> 
> Please take a look.

I'll look into it thanks.

.John
