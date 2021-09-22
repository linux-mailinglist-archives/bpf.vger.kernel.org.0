Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97802413F22
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 03:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhIVB6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 21:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhIVB6a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 21:58:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA35DC061756
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 18:57:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t4so4085768qkb.9
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 18:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNeVX2/AAU67gCQ2hLPQYiycq7pGX1S/cb+hnnulRMw=;
        b=Hl16FOFhcPKOG3yu6QEh+1sf7oVY/P5Z6rCp241WQfOqSMZID/pCn1e66RwsiAj6+p
         mQKSvbAI+fBwkeW59i9hjFY99JHNIklaNSmeFVpWLb+iZqsxPShD0uwDwyO29txT0tf2
         vvV4brKiBtJ1KNRnM9cCx2B24t7Pe9udL7/qbQIOuNDk7uzde6GVNRKNSP2Zl4UTHwP9
         eWX0ma/R8aurBgiNUi3tQu9HWfwU+lzyMk8quwUEvwGukDHqFo7HRCPJ+WwBYB6gTZpE
         zcEV7F+KyARmpAhcwZzvbja6nuSNnbw2EHcO/vnhdxGxp9eg8Ebs+SBqcS16o0E14T7b
         f0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNeVX2/AAU67gCQ2hLPQYiycq7pGX1S/cb+hnnulRMw=;
        b=y6sopYY1v1eNrA3MDI6yJ+BfJP9eOVEborTSCdi/ejyYKgGIT10QjFT5xc0lbH1EAA
         rxGwk4C1HWbnw4d3H41l89TGLQwYUCQ6GxE0FOoXDOE5+jj2X3lZyEQlguZx2Z0+Ns/Y
         lRfF0iisv2uWWJZRxPmrLd2/dxfm84sdGOhWcIHwe4WStsBBDDKa3/GRtO1uTKCgnhx0
         MjcL6EHxFKG/4bbViIDsZn6FSaGiwRq4j8qmZi9PFKMEHLTa7YmRooNK/xRgTxcG9aEA
         uyKKhqgx8QzD60Jqz/Nf54d0yJOlDjqC4+TS4Bn5ubjWigYA0Z1xxja0h6wyd6UoI4be
         HZrg==
X-Gm-Message-State: AOAM530tBJG20vmCrGSpjDqQPc2B0Wnuitf/+KWAZbQETKF+fhhaLFbJ
        OVk2FXcCh/PAHqTGSifhSTC9KLkFWh/SQIiEizws/A==
X-Google-Smtp-Source: ABdhPJyXlKkrBRzP6q/7fl+IpzJt5IeM7h8bSIaNp6nmoNn0IbOQBmLhN0QxQ/wn+OIjISZduG5Xy0ElJHTvCUrXLpw=
X-Received: by 2002:a5b:783:: with SMTP id b3mr38459854ybq.328.1632275819299;
 Tue, 21 Sep 2021 18:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZC-3nm8FVhVfCAyodxbKAbdxUriZimwdq3JHH1=sxNcw@mail.gmail.com>
In-Reply-To: <CACkBjsZC-3nm8FVhVfCAyodxbKAbdxUriZimwdq3JHH1=sxNcw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Sep 2021 18:56:48 -0700
Message-ID: <CANn89iKVAcX2GnQwVbQLd+ADGRVdWtD07q7=Brw5HRSoc0K2PQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tcp_write_timer_handler
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 6:43 PM Hao Sun <sunhao.th@gmail.com> wrote:
>
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
>

We have dozens of such reports provided already by syzbot.

If you do not provide a repro, there is little hope.
