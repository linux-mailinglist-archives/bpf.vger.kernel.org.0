Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78165341121
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 00:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhCRXhl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 19:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhCRXh2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 19:37:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A2C06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 16:37:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m17so7220892lfg.0
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 16:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxrt/ZcF7pxUVsfziWDrBGJQ6N8Z76SteHyfoOQ3J7w=;
        b=UPo2PPunigtRQ9zFZ7VJoigZYo4c1YV+bNfYcN6MGlbAxBU/mj/zFAJFCVK5x/cyvA
         MRIksVgbzHjjPNsrwkl1KNgrvNjLZO8Es2M0J/xjCLLZNjnIT2CVTKIIaw4ks10U3mx2
         JAJjjCl+YQSJMWBHuxZxEcmO5/eKs3s8CiQpfeEtCeuMpGmhJUTZIsdHO87L5gTaX1pt
         uta6xe5OPK+xifKo9WkkjH4Dq5V0K/9Z1wUBQoP4uXZKQybfIa6oshC3lQp5pP85kg77
         EgYNGvrsa8TpB38LFVvw0Oa/LKdVbxny+NlRI29Exew6QHbQhYyaJGt0bzhfBGck6xbj
         qqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxrt/ZcF7pxUVsfziWDrBGJQ6N8Z76SteHyfoOQ3J7w=;
        b=Zm/y1oB4ti/Nrl9NMMlmLlM2FV7YIzbMC8uh9YGOT2XyhefNN1PcoM9+ys7nGDKwOw
         yxBFd2k/vp8OSRv+PHrIv2YJvFwLKHtlZcOa74If/v2DIlxHoBWTv52nohSEXgF6QsCT
         d03xPklJphvbPnFa1D1tHp2au5XrTqkTCJMjuk8vQmn7I5qEl1irGVmlmZvGJ6XGvVvO
         2+lp29Ue5qa9huee4WuDk/hYctEarM9F5JwNHwomdNcNeQSm01PfFg6i1AfTaC5vWMaK
         SbtDYNKwxeec+qY1VWB2wfOP5NrKilqiBlVlBjCdm6++H4hdxCjW3mleJEPrMe2lOmtw
         wAbA==
X-Gm-Message-State: AOAM5327L9CvEDZepA4+Fh2eA9ztdBb/pzDVGxSIS4UnEgpmlCdxvH4A
        180PvYAedZDtL40gUQqgTc5qQsXE6gWrGKlaqmU=
X-Google-Smtp-Source: ABdhPJxmztXHcYCxgIsaP7o73yDBVwxDxHGO2IsNIFLPmGjMrDsUHq25Z07umtiEq1Kw49zdGdXQLhAdICWSotQcHgQ=
X-Received: by 2002:ac2:5ec2:: with SMTP id d2mr7015543lfq.214.1616110646833;
 Thu, 18 Mar 2021 16:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZ2t_VbdtSde9uPEYNaggZLj3peyA8opHj1Ao_FO8AVrQ@mail.gmail.com>
 <CACYkzJ5eynv81uQ9_PA9uA=FUqva_j8MmpCgM1Pv=urVkXZsWA@mail.gmail.com> <CACYkzJ75+ie6H5rsd467TgaznpNkEuEYa9+Ux9Wv9zUXF01KwQ@mail.gmail.com>
In-Reply-To: <CACYkzJ75+ie6H5rsd467TgaznpNkEuEYa9+Ux9Wv9zUXF01KwQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 Mar 2021 16:37:15 -0700
Message-ID: <CAADnVQLLuNvmFwemopqohwFCFLLNJcmCv=q-6CSgrqnjZnVQyQ@mail.gmail.com>
Subject: Re: test_ima passing only first time
To:     KP Singh <kpsingh@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 4:24 PM KP Singh <kpsingh@kernel.org> wrote:
>
> The important bit is having CONFIG_IMA_WRITE_POLICY and CONFIG_IMA_READ_POLICY
> which allows reading and overriding the IMA policy.

I was missing that. Thanks!
