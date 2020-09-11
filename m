Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E193265634
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 02:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725300AbgIKAxv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 20:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgIKAxt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 20:53:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11C5C061573
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 17:53:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b12so4577986lfp.9
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kjhRCz3N7HYsmLDkYpqLl5xVkjaxnKuKdhSit7HuDo=;
        b=JCTa7yg7nHik/yqVoKB7E/n1LLghJGpCtldPatpxD6pUGfAEFsVnr5Di8eGkqjfAJ6
         QDzrYgAw5rIWu2jqguvpO7GLZjN65qR3IC9Q5a4YG92GsxyhEx8uz+vUNtMP6e1I15V1
         Vb518p+eoXcYsMS9GIeoFNs9EmffOhYe82CCykD3CWvXIApaVhTNNA+WF9tIq9wgSQFe
         kwvvNE1IYxAXJ2KiWm94EICWB2NuTHsL8u/axhc3LRXx4IeWAmhnBoBV+xBheypHxJq4
         mn0ieN3qIomo16IR2+hSIkTJGvxIeFbXPC6qnCPLNmgqdFsG1/DN/wIJPUqy46huzFKI
         hksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kjhRCz3N7HYsmLDkYpqLl5xVkjaxnKuKdhSit7HuDo=;
        b=c+x/sLqTpnZlYuG2KPctJuurS+WfXbYCE3x3kID39YZD0ySVmzeYU4Gv4LVESPK5pn
         u411R13tTKssGb4pJaszf+fU1bxu2OApyXZFS6BhTE6nF5MyH5iEiMre4xUv/h5//lV1
         YZxRn8GF0Qp/khTsuAP0gN4B6+GSDPq9kGNVsfqIX0Yqm8ZQUr87WvaWb53uFQBDc+bp
         VhBFrOT+xXjFJ/jyHcGfBzlt8wk1SWnkYZwGv9NbRKh6CsFSFzc89jSDwM4wONFRxkR7
         UZzu6EuUq7gffrc6th/fPGfIgvfiDb6zQHNZJbzTFxuKNP5Bl79iybo+6A09D4GpsASP
         p8Xw==
X-Gm-Message-State: AOAM530Dg0Gd/zJk+aZyf1ZYkTX/lJ2kVQfATKKiyzMXGyCxtbLORKmA
        3NGiDqmOwNWM8/qk45lBNJFloKZTRVWrFHx/oJs=
X-Google-Smtp-Source: ABdhPJwQtaA6qKW/5cn3xBL6RqFcMdz7D10mE5oWpPiaJr3qPIcjY7nXbboen0jqLqPNtWDSXmaJtBhA940Ca0boiLE=
X-Received: by 2002:a05:6512:2101:: with SMTP id q1mr5321451lfr.157.1599785627053;
 Thu, 10 Sep 2020 17:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200910110248.198326-1-lmb@cloudflare.com>
In-Reply-To: <20200910110248.198326-1-lmb@cloudflare.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Sep 2020 17:53:35 -0700
Message-ID: <CAADnVQ+FuthVsgOGeSLA27js-JKi5-OvheQDuFN4cM3V-MpN1g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: plug hole in struct bpf_sk_lookup_kern
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 4:03 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> As Alexei points out, struct bpf_sk_lookup_kern has two 4-byte holes.
> This leads to suboptimal instructions being generated (IPv4, x86):
>
> Fix this by moving around sport and dport. pahole confirms there
> are no more holes:
>
> Fixes: e9ddbb7707ff ("bpf: Introduce SK_LOOKUP program type with a dedicated attach point")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>

Applied to bpf-next.
I feel it's a bit of a stretch to consider it a fix, but if you really
insist I can let it go as a fix
and reapply to a different tree. Just let me know.
