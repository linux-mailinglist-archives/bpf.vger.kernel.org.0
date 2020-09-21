Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA2271E45
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIUIoR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 04:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUIoQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 04:44:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FB1C061755;
        Mon, 21 Sep 2020 01:44:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so8676096pfd.3;
        Mon, 21 Sep 2020 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6HsE0eELlrQcO4TsI+wuslBDDzb2aL9SpkP/LH0CIY=;
        b=ek4wQqo0O3ZGYyvYSjADpuQBIyKJvqJn96byne7W9z8hxqA7ObjP8v2koIzhgAK06d
         jr/OFBqkNo6kjEtRVyrnJ9Uit+jePWzqU5NwGg7EX3TS8q6BvFlymmL35lJLcB4pnAsV
         TzfNFIay6DhV3PLywG7v+bMu9feD2UNR9O2aUXxR8Ycg8XeLrvs5xv7LQ2+7YIopSjL/
         xP41By3T8tO/cvDZErBwjLJuVNpSKrOTR06E7waMwMUDGMSJEHphAJEPf6nKl6Uqj+qe
         OCtNgQPcYvM6RA3b8+0rMwVCpiokVuzc3SkXhWcoV+zE5CxwbwG7emEGIwb0QDR9zcIX
         fqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6HsE0eELlrQcO4TsI+wuslBDDzb2aL9SpkP/LH0CIY=;
        b=P+2uumnLLRMf686gOR8BM1n1SgfbTWWhNLAG1VLric1O3xsgy5KjrSbQrkWqVwm3Gu
         g5eALGZezBgprptZkYC8vpEsKnreSeJzUHxTVuffklZQWBNtgHroQesZ4QUnKjEjwhmF
         a9KDc4Y1h6wSdduwKRlZ90jQUSL4OPn7gNGRk5OjLHfQi4xOSxN9CgGs+TWP4Qhg0cG1
         1PXTBsN2GKFcMCxk/RWIb4q4P72sbjRpGWn+rJDyPmRIBdxpkG5F8YjQPNIs7hTE3SDp
         hVtLh/pbef2LMfi0MQyFqpLjLeHVMUJFCq+J7/b7z9TM9owlt5yNIDmHrtlX1+ZrmMhq
         zSPw==
X-Gm-Message-State: AOAM5330XEfOzEW+Xmjq8BNSrbktXwGXAF6lu4kud/hAHwKDf/81pjYM
        gh9zNJyGx5Asz+16xYblWVK6j16xgXn+H4Fhdpk=
X-Google-Smtp-Source: ABdhPJyuD0wgIhq/Njnt6OzmDC+28Wcv88zDghEUZLrz87lUZKbyXKYes2bnZfRIKPdt9jZqlbuFftCYX6vas/RmQBI=
X-Received: by 2002:aa7:9491:0:b029:142:2501:396b with SMTP id
 z17-20020aa794910000b02901422501396bmr26157810pfk.48.1600677856250; Mon, 21
 Sep 2020 01:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <20200921083045.ojlswvusrfzohp2d@wittgenstein>
In-Reply-To: <20200921083045.ojlswvusrfzohp2d@wittgenstein>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 21 Sep 2020 03:44:05 -0500
Message-ID: <CABqSeARK=fzjBqO178pbzSXbazzDdxTmpA33pnvSy=rk9WYnJA@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 3:30 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> This is missing some people so expanding the Cc a little. Make sure to
> run scripts/get_maintainers.pl next time, in case you forgot. (Adding
> Andy, Will, Jann, Aleksa at least.)
>
> Christian

ok noted. Thanks!

YiFei Zhu
