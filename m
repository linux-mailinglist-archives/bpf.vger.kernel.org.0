Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C327F443
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 23:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgI3Vdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgI3Vdn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 17:33:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB36C061755
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 14:33:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p15so4951558ejm.7
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=auUqGvs0gHMXAey6wH7F9Apr7r/9WxxEyJFZn6Y4ccM=;
        b=jEZZuulTAkEP8ra+dIdb67z4FyGG96oF+vkHW7GlTvPFyN0nVCVZIn9qGMllZOit52
         xj0H2s8ta9HYmC2xhPb1zHhF4HfH+UhZxwQYGniF7NYVP6OGvTjHST+AO2oYeFOeDzel
         K80B8lQVwG4BEz/c3n+OhRltgv2kxMciDlkUAu7SwpTzBlHY9YZEb+zGocLMIulaTJ3J
         E7rnlY8Jfjcr2wvOlQGr2UqSv2R9Lw2k+Fdc+cXBVe0Ad8TjzEjIzvxQ50rU3fUPEfwn
         gx6czlTmSA/lyvlJ3ErszHDOy3n8+mW25p41M/y9O9bguu9kmnvyQfZQsfnrXknVZngO
         XeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auUqGvs0gHMXAey6wH7F9Apr7r/9WxxEyJFZn6Y4ccM=;
        b=RrDsH5NNMJeh5yOHzcJIEHW3Lz7cY+1FY+lxh28rR4G9WR/XTUGtTw8IF1aFM+skkl
         VNQ2/5/1RLcFVczu7ja0MrJX1v5l2e7vQL7JMu6vlZLCexPwDo7O+BNPruKM1Z1eTDUu
         tGcsfNx9kX7joHXwtGjnhZQ1Bvd8mA0maRdvevhf80TD8EDeWEbQqz+HY5zJDWL8RaRc
         KgAZWKZmh6hg37Uy8J3v3bpPl5j0W+e8mXdX+Qe66c4XxARbpRcysicr685U4MDNEqia
         70be7gBw+1ABPgsNaK3rrbW6zh+Y67g9u3w2qkqMAhv0YqSPg9wff1Kth0FBfC+TUQOa
         NTSw==
X-Gm-Message-State: AOAM532SjAA1Ipn7IZvm/+5imVvzMe827hHsv43C+stEdSCdjDQtZcHv
        XhTDz22zX8l8EgNsYYxRTC8IfJy+vsouf67rO/Ynfg==
X-Google-Smtp-Source: ABdhPJyMPW38MT/cpIj3rWIUCaLGD/HFhM0te7s40TzgBb3ydM7D9Qbrn6/eFy/iZ1fva2zDw42UX+OK4+/N0TeEOLw=
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr5042513ejc.114.1601501622005;
 Wed, 30 Sep 2020 14:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <484392624b475cc25d90a787525ede70df9f7d51.1601478774.git.yifeifz2@illinois.edu>
 <202009301418.20BA0CE33@keescook>
In-Reply-To: <202009301418.20BA0CE33@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Sep 2020 23:33:15 +0200
Message-ID: <CAG48ez3039B+w_D7SJBaGGXw9sd1_SzWO+qUnhMs6tcweGa-+w@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 1/5] x86: Enable seccomp architecture tracking
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 11:21 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Sep 30, 2020 at 10:19:12AM -0500, YiFei Zhu wrote:
> > From: Kees Cook <keescook@chromium.org>
> >
> > Provide seccomp internals with the details to calculate which syscall
> > table the running kernel is expecting to deal with. This allows for
> > efficient architecture pinning and paves the way for constant-action
> > bitmaps.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > [YiFei: Removed x32, added macro for nr_syscalls]
> > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
[...]
> But otherwise, yes, looks good to me. For this patch, I think the S-o-b chain is probably more
> accurately captured as:
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

(Technically, https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
says that "every Co-developed-by: must be immediately followed by a
Signed-off-by: of the associated co-author" (and has an example of how
that should look).)
