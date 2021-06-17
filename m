Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626453AB74A
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhFQPVT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhFQPVT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 11:21:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E71C061574
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 08:19:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n20so4535860edv.8
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYXm2CwW6ZM8m8SywildHdn0lDCR/kY4BGMcjcdsDNI=;
        b=NoaruBrXuwOsgp6qEjP0Y6PISWblA7+rvXHpRuxjSDACndGHx3MwJ+AGFXuIxtBTHN
         UoAJLpdJ8E/uqYsNAU3g67SVPGhiqIKSyOTnUM+KsSgSumvqqX84emMd823Oolfn51Mt
         SOqeFLf/SuXhaF5qXGIypj+Lj2bwKlcufR2Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYXm2CwW6ZM8m8SywildHdn0lDCR/kY4BGMcjcdsDNI=;
        b=TOfg7vEQnxcjVAASLegQV61DRAfQqjWdFaWWzX4uXQqrhI8DmV68omYE09SnbLnlF8
         j9TxaVsP21Sptdvc2UEFn7GiPyndz3IvtO/Hq0P2QLzk70XqVZhWa8HGYFwcK8PvskLs
         qmlEfl3YvL9z2Q5Y8QzCZFVWpCNjKAwrtSHLFtkPg+SQnCZLxl93r4Ucrwajyod3JF41
         2ed3B5wyBG0LyHAaXpcJDgGbwyQeJzJX9/VgK+TIOLHswGCHBwT3K8t4yEc8yLt1L6K6
         PxwVj+4164aItw9uevzyHFFe0p8TJ+ihrCpdzbhlnQ/Ly2YcfqEbdPMbcUtkl0Q7Kxmc
         AufQ==
X-Gm-Message-State: AOAM531gfL8PT5TWUWqoHb1Gt05y8B7FB+Ge3E4GrXi2esceqoyHEGhf
        0P3JQuvJcMoDeRAbC7YReMc+AkQc8ZZEK7ghoBhF3A==
X-Google-Smtp-Source: ABdhPJzoFXAmT0a1xgwHsNaWoVdQ3SGVonoYDxoxNl0oEaO8JhRqvG9SWItFHos6eCusrlgMO8CzM5kSYeexS3HWJ/M=
X-Received: by 2002:a05:6402:35d3:: with SMTP id z19mr7243887edc.324.1623943150159;
 Thu, 17 Jun 2021 08:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224712.3243-1-zeffron@riotgames.com> <20210616224712.3243-5-zeffron@riotgames.com>
 <5ff53b96-775e-c0af-8b83-d1e366fb2d3c@fb.com>
In-Reply-To: <5ff53b96-775e-c0af-8b83-d1e366fb2d3c@fb.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Thu, 17 Jun 2021 10:18:58 -0500
Message-ID: <CAC1LvL2-v9AjUkakw4Mq6-X-80FrFeSrHNa3p2nrVzxXS0C7VQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add test for xdp_md
 context in BPF_PROG_TEST_RUN
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 2:11 AM Yonghong Song <yhs@fb.com> wrote:
>
> On 6/16/21 3:47 PM, Zvi Effron wrote:
> > Add a test for using xdp_md as a context to BPF_PROG_TEST_RUN for XDP
> > programs.
> >
> > The test uses a BPF program that takes in a return value from XDP
> > meta data, then reduces the size of the XDP meta data by 4 bytes.
> >
> > Test cases validate the possible failure cases for passing in invalid
> > xdp_md contexts, that the return value is successfully passed
> > in, and that the adjusted meta data is successfully copied out.
> >
> > Co-developed-by: Cody Haas <chaas@riotgames.com>
> > Signed-off-by: Cody Haas <chaas@riotgames.com>
> > Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> > Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> > Signed-off-by: Zvi Effron <zeffron@riotgames.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Thank you for all of your feedback on our patchset.

Question about process for Acks: do we add your Acked-by line to the
commit message in our next version of the patchset?
