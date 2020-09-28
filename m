Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D234027B60F
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 22:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgI1UQP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 16:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1UQO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 16:16:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8914DC061755;
        Mon, 28 Sep 2020 13:16:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so2163887pfc.7;
        Mon, 28 Sep 2020 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n5fs9N7O7kX4WZI+JaZ5Zk9F/Ve3sjOEq/KE/y3eZEA=;
        b=NZZZsyHQde4tfNecmEB/UwHVyhxXIFIl6/O1nny0WP+j9dJhH+pBYRPhP8MSl140QK
         InD9RjbRzHGBObk/JneSjeXMH4JucKSx5DzB6OkVmm8Eh5WPSjtBdcsguuEF+L1tOBHS
         0teuOg7LPUKGVf57kIlbHTpiFvwupixku8VU27OI5vaz5j1nxcPKWmaLg7rMWTJrswgI
         C9T0DsyuqYa5HIzqBoRia9AbvGc0R5CX+a2uZ/KLHwrWKmVetxKxydeVw/vuljEdRP4D
         hE89hploklteLSgB9Ht4BjNaRzMziS1T7Le8UKp1ypjmAGEq1T721TB89vB+LHMCBIGf
         sQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5fs9N7O7kX4WZI+JaZ5Zk9F/Ve3sjOEq/KE/y3eZEA=;
        b=WhyxRoG4SYOl4p9uIfs+M9W3qIAWPAwEpqqfuQTCGpMl6/QJXFdoKRpyLrjTIEuRDB
         Z9hPgeCpx8AbT2j5p0PRbJkkZQRi9f6HySkX4vAcE7g0/7Jq92dM0IEAQzK8eeARN6an
         3UJRWcFKthujh2q3/4euURMXv0UuxawbUmUkXZlP77AtY7dk7+Dv234JHJFgrK3etJBl
         QkwFESwbTyIAQ6CGFLIEVXLbe6CP88XlkfqACU6TMY5gc2qhRQBy5dksYOhq6aA3ymr4
         HFvqkszZoQ3DfmfrQoLIvPb8Z77hOSg4rDA7XRsTaIntFAumKLs0T7PTGhjZdHCatqNa
         dpEA==
X-Gm-Message-State: AOAM531SpE6A/9GTDWdKKtmQevLHfrWMfBQbwjPLP63wPA7HyVfBbwED
        8zBmJbycfH9ShMOHm3a7/zyzHi+aB1+z0tnotGc=
X-Google-Smtp-Source: ABdhPJwD//xv3MXMApixX8ayuv2V0hLURpgssTUGig7LrHLy6w9oveNK0ZVrUSLMjUtZsjaxR0mfr9O6qxu7It2uvY8=
X-Received: by 2002:a17:902:778e:b029:d2:8046:efe2 with SMTP id
 o14-20020a170902778eb02900d28046efe2mr1026132pll.44.1601324174119; Mon, 28
 Sep 2020 13:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk> <CABqSeAQKksqM1SdsQMoR52AJ5CY0VE2tk8-TJaMuOrkCprQ0MQ@mail.gmail.com>
 <27b4ef86-fee5-fc35-993b-3352ce504c73@rasmusvillemoes.dk> <CABqSeATHtvA7qm7j_kxBsbxRCd5B=MHtxGdsYsXEJ-TRRYKTgA@mail.gmail.com>
 <CABqSeASMObs7HtwfM=ua9Tbx1mfHZaxCMWD6AP6-6hR4-Xcn=Q@mail.gmail.com> <202009281259.D7D18AE95@keescook>
In-Reply-To: <202009281259.D7D18AE95@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 28 Sep 2020 15:16:02 -0500
Message-ID: <CABqSeAT4Qaq6BrYYc2S974b8ejKB4j4R+y3tMk_P7wTPxYNgGg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Valentin Rothberg <vrothber@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 28, 2020 at 3:04 PM Kees Cook <keescook@chromium.org> wrote:
> Regardless, let's take things one step at a time. First, let's do
> the simplest version of the feature, and then let's look at further
> optimizations.
>
> Can you send a v3 and we can continue from there?

ok, will do later tonight / tomorrow.

YiFeiZhu
