Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B04920FC8E
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgF3TQi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 15:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF3TQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 15:16:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C826C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 12:16:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so10679986ljm.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkZmMe34dyy9WEeA4F2WVAexPguuMv7kGbcG3CWAMdY=;
        b=vIWz3bAXk6kPP6iJIiH1yjPEBYIsG5GjZw4b4FXJqUTloKA9IgFsFkpx4iIlab/R9+
         +RqhDDa84yF7KDZeWq/ul056MoO+E+pCCo8zLvfdDKhpLxnS+HcBIcIiHnubpmHPM86d
         vjfavaEB6x5udKZQ5qYIXvcyRiRkbzCAEWUjumP8+h3Z3IFhu8GsVkdr3XJp+XT2L2SU
         K/JB8HMvaqAkJWoyPN1fJ8c9ouOXKZEfqwuwqTCGUvoELjXwcExBu1gy0N3Hhau9IaDc
         gWCb7L73YYNFvCPcebH1bjUGQZdv64toHYm5ocXtv5rzAGRDKGVreBCtfo5oHA/eDXKx
         r20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkZmMe34dyy9WEeA4F2WVAexPguuMv7kGbcG3CWAMdY=;
        b=aF4ODGYWrjK52uAO26BL4YF4b4STuUg5g6ouw6NgOwu/hu/OOyJ/XmAzXDlT96NMq7
         J3UYIlYxDj1GHoRvr0HInuOtxKLOwbM2j/ZXtNV37crBm6N7cJgR3Ec+OYzag1Cq2dpS
         0+Zl5Dks4A0F35s0NPUWYnZmW98q5+VpjgxbKekO5GacXJDd99w6X7Ph9Q1jGbDMh7Li
         /wSNi9PWKQh+ibNXy4ztsQoqKF5JW6e4qjAiufaTKMAFYvllHKzOdaLtg+nibhnN+DRr
         cQakJJiCIF0e2eeeYUFegTWojNuXlwR9tY9dFBQCwTC14I6Y3tDCf+jTPRM1RMOq1ozQ
         ebGQ==
X-Gm-Message-State: AOAM531MEOaJf7jb/3nkNJ4bZshvB5RMVEdobdXTsH4PMD1StR/vF9nJ
        co4b3j49SGQaK6I/FbQsWzo2yAE9qowl0+jQMDA=
X-Google-Smtp-Source: ABdhPJx1gyxcAkmATxH5FC2bNB45NFGiTGJo8UMWI4oKV3hzeLd3M/MLrQWatzlTkm28nhCQVPPip12SpU2n8rds0ek=
X-Received: by 2002:a05:651c:284:: with SMTP id b4mr330663ljo.283.1593544595819;
 Tue, 30 Jun 2020 12:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200630171240.2523628-1-yhs@fb.com> <20200630171240.2523722-1-yhs@fb.com>
 <5efb7ba67bae6_3792b063d0145b4b4@john-XPS-13-9370.notmuch>
 <c7416fc5-b9b6-7778-9ec3-0c4634e3e902@fb.com> <5efb86067d541_3792b063d0145b4f1@john-XPS-13-9370.notmuch>
In-Reply-To: <5efb86067d541_3792b063d0145b4f1@john-XPS-13-9370.notmuch>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 30 Jun 2020 12:16:24 -0700
Message-ID: <CAADnVQKESTpB_BaMMVvV7GTvbJcnDMv8V_ZdvtZiCZ6N97PbgA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix an incorrect branch elimination by verifier
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Wenbo Zhang <ethercflow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 11:36 AM John Fastabend
<john.fastabend@gmail.com> wrote:
> > >
> > > Also, we probably shouldn't name the type PTR_TO_BTF_ID if
> > > it can be NULL. How about renaming it in bpf-next then although
> > > it will be code churn... Or just fix the comments? Probably
> > > bpf-next content though. wdyt? In my opinion the comments and
> > > type names are really misleading as it stands.
> >
> > So PTR_TO_BTF_ID actually means it may be null but not checking
> > is enforced and pointer tracing is always allowed.
> > PTR_TO_BTF_ID_OR_NULL means it may be null and checking against
> > NULL is needed to allow further pointer tracing.
> >
> > To avoid code churn, we can add these comments in bpf-next.
>
> Agreed code churn would be not worth changing type but I'll send
> some patches for the comment changes.

+1
I think for bpf tree the minimal fix is better.
So I've applied this set.
A follow up to bpf-next after bpf->net->linus->net-next->bpf-next would
be really good.
We'll make sure that all trees converge soon.
