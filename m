Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1249312F
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 00:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbiARXIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 18:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbiARXIk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 18:08:40 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A80C061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 15:08:40 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e8so565849ilm.13
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 15:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4UumiRDs/D5ZsRASQ2oOCt01MbwexjnDDcSW5pE8nc=;
        b=MSqavQr2/YnYc1/N4en1IhGKcmY9dKbTyTGuQVsfLK4zqx9YJt852o1AS9yWvDQ39j
         W6qGiATGJw90bLdtRVufQ14aWrgkJXnbBUm6AKqrvNafcAdCQlMoJk6qjN9+EtEHxwgy
         YzHYz9HRM6GSQuH863SUCM3xKoDFh70uri+fvKkW5wAlhGhxVnuJAuz15+Q0CvUsoN2O
         RdWrkJ5uRccawVSRxG8wwKTDa6c8ikrvIDt+KwZlSAxJU3RVpSyqLzSrUyiM1ZcFUevb
         t4AzeDM2rw81wfJ80Y+pPYUCzyGy7eOL90WxJ9Cb3w7BVe4YIUaOPDzyCoxnvopKdeBR
         t+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4UumiRDs/D5ZsRASQ2oOCt01MbwexjnDDcSW5pE8nc=;
        b=D5ayLblTKwXFoe40CfD2LHovv4xZJiMszrw1oH52gVh2FsuB20EzK/fMlyynsdhu0d
         YLXrrGvhunlZb9t+ePsiHvYtFp3tHJJUEhUSCgcHtWorM1ilyAWg0aniFJRdSxt9GJ/h
         n2Zwj/YIUy7eGQWe50x8wIgdIG5dYk7hDcke7/Ca9bLxj8g2BPdxzLWXbqbJ+9OS7/Yj
         NNVerg+uQ5HE1x1OHe5sTtqb5l9jjNxr69bmIAC0ztOtOQGSi3uUayOJ+EpIQ1h1tTUW
         UisMrltYB2aUxM0/+Oi5um7/63uLYSvK2cAOfI23GtHe4hh0Zk9JFZxmzKMYvPBs7tgb
         49MQ==
X-Gm-Message-State: AOAM533xSD5+aZxMJsjCx5akg8CUE7C+WPWeCpdT0hri8pqO+w+rrxrr
        7+42tAO7RfYztNdOPBiyDnsf8lkmXqRSrtYYd2A=
X-Google-Smtp-Source: ABdhPJzadWQgeB7/QCoCYjWzAvmaQhzX6YQ0lckpdckaqPGgpRKpDZ+L6Yg2BNXDaXHrE18vSHWmfjHjiHFEdkDH3ks=
X-Received: by 2002:a05:6e02:1749:: with SMTP id y9mr14067099ill.252.1642547319769;
 Tue, 18 Jan 2022 15:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20220118171609.1044550-1-usama.arif@bytedance.com>
In-Reply-To: <20220118171609.1044550-1-usama.arif@bytedance.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Jan 2022 15:08:28 -0800
Message-ID: <CAEf4BzZ+7u9cNbVeAoikfiJsbCr0XgmJNB9cCyz12Sb79rA_6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf/scripts: Make description and returns
 section for helpers/syscalls mandatory
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        fam.zheng@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Song Liu <song@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 18, 2022 at 9:16 AM Usama Arif <usama.arif@bytedance.com> wrote:
>
> This  enforce a minimal formatting consistency for the documentation. The
> description and returns missing for a few helpers have also been added.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> ---
>  include/uapi/linux/bpf.h       | 13 +++++++++++++
>  scripts/bpf_doc.py             | 30 ++++++++++++++++++------------
>  tools/include/uapi/linux/bpf.h | 13 +++++++++++++

let's keep UAPI header improvements separate from bpf_doc.py script
changes. Otherwise it looks good to me.

>  3 files changed, 44 insertions(+), 12 deletions(-)
>

[...]
