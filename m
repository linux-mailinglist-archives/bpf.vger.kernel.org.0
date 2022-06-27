Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041BF55D544
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbiF0Uii (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 16:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiF0Uig (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 16:38:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDB8B29
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 13:38:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o10so14767019edi.1
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 13:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzzQTGImZTE3jed6uGE3sGYhVcak3SDF4WFGnEwYiuA=;
        b=XNbhgQXJQiiQ4w7XUfuoeHkZKypjnQacode/yi0FJwsQxc99iX6caSiTQAsdivVPq7
         OCeRqzL6UCq12Q9O7Ea6MGSKtieyYxVtd0iiX7QBy7M70g84dUgZlv5VSB/EdIruzmxg
         3x1HMcXU0YvKGAexnVdR5WMiUV1wS672HZCt/+nrqf1izVFCvlYZKwYXiLo0mRqHSvar
         Jhrtblw6SX3b4ZoHWhuJvWGWrFJCI8WsluuRB5y9LiN2+ZWEncMuCTYFv7UzYwnw+fJS
         xs9+iTo5zRzlRTG4XhddSQ58xFPFCxxyidEBMzWCAul+KYunglFM++slXRmHbXgo59nQ
         HQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzzQTGImZTE3jed6uGE3sGYhVcak3SDF4WFGnEwYiuA=;
        b=k7r3AnCJf408h3kEZxMeoviszZPZU96URMDp9koaIM6RsdgieU+Bk2eNtIfQO0pSLt
         7/+fD/yW/0BW9C3Uefstkg/iTzziid99s1TFqncZ3uWTbrC2BR66fnGPj1iA3E/XQtIA
         ASDybUs2OdrdId+iSnn0p+3zv90LM260ycA1lfKrRnIM+Ethj4ckAYLoEoKdPVKPvSzT
         W+90bJ7RSvnqgR2LKLvzzw+mb5UeQ52+ECZ4sI8xiqhyanRAqhuADRqoS2JWN/RuhTRe
         BHmbJhOSbCoCf0e2Ips1qNLKX5rJzGbqxlPzPDUOGDqUk/TfrNIdYne66P55W7GmSd8b
         +ihg==
X-Gm-Message-State: AJIora+2gb9Z46s6EFzrggs39U9f9muoMJcAAK7Ns8hnMf9TSjcYJLuK
        hFcanLSVhs70dgLdp+4/ALX+EXkvqZzuDnjJd0s=
X-Google-Smtp-Source: AGRyM1v8zCM2CnQN5bPQZJZqApMMYm0HKQeAyW2vaqrmo7n6W0UFfTn/jiV67GBGD+DwBqE/93Kz2Z4+LOJqqYJXRyo=
X-Received: by 2002:a05:6402:1459:b0:437:9282:2076 with SMTP id
 d25-20020a056402145900b0043792822076mr8701909edx.6.1656362313702; Mon, 27 Jun
 2022 13:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <5bdc73e7f5a087299589944fa074563cdf2c2c1a.1656353995.git.daniel@iogearbox.net>
 <20220627122535.6020f23e@kicinski-fedora-PC1C0HJN> <CAADnVQLOS4kvmcp+aaX6gtDUCUfoL906K+Y4KUZOsYBDso_xMw@mail.gmail.com>
 <20220627133027.1e141f11@kernel.org>
In-Reply-To: <20220627133027.1e141f11@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 27 Jun 2022 13:38:22 -0700
Message-ID: <CAADnVQKf8huK_bdGPQzOZwXJD7aqr-2a3jFPfhYrEz8BD115qw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, docs: Better scale maintenance of BPF subsystem
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 27, 2022 at 1:30 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 27 Jun 2022 12:57:21 -0700 Alexei Starovoitov wrote:
> > And that's a good thing.
>
> My concern is that folks will rebel against populating the CC list if
> they never receive feedback from the CCed. I often have to go and
> manually trim the CC list because I don't think Jiri, KP, Yonghong etc.
> care about my random TLS patch, or removal of a driver which happens
> to contain the letters "bpf".

but they might! Trimming the cc list doesn't help anything.
We used to trim cc list only because of silly vger anti-spam
feature which is dropping emails with long cc.
Since vger is broken anyway we should be increasing cc where we can.

> I was hoping the delegation you're
> performing could help with the large Cc list. Would you perhaps
> consider moving the K/N regexes to the "Core" entry? It'd lower
> the pain of false positives.

sure. but I'd rather address the misconception that
long cc list is somehow bad. It's good!

>
> > vger continues to cause trouble and it doesn't sound that the fix is coming.
> > So having everyone directly cc-ed is the only option we have.
>
> Yeah, Exhibit A - vger is lagging right now...
> I guess the "real fix" is on the vger, trying to massage MAINTAINERS
> now is not a great use of time..

The real fix is to move away from vger and adjust get_maintainer
script to be smarter when the mailer can do its job.
MAINTAINERS file should list everyone who performs code reviews
and maintains the code.
