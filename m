Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F005960C1
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiHPRBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbiHPRBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 13:01:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1003780E9D
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:01:50 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u10so8282627qvp.12
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YMl9KRPZA1tYlpY7uwctkgt1uil4+N34mu7o843qNlM=;
        b=BE6TH2bExTZsoiHpqlDIgw05eAEJ6ZRzNepEZ80SsbRWw+olYfdtnLgZrIGZxX6REY
         enoYyfkq8EQthlhq1aCXkwoX9+Sy4MB7eI0NVAHhTyInYPmEi83k8IgqduOBA6Pu27cV
         1yzA5lB5rszbVO3H2c4qvLSGpCHiXiGh7Z58+OWeU8dr+pzqvrqpaIr7/f3vzOKC4ODu
         c0Rije/86zqWuYz8CHuc1EPU50vkNVzLoG4aSOW4g/7eajrAPtA20SkRWEPoVquvMner
         +oZuXIOCZ+msQ9sBkWtC2rERiq4fxGvPUWF0TkP4tIuow7HLxfAukP0t5sl2NsKgAEqB
         J2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YMl9KRPZA1tYlpY7uwctkgt1uil4+N34mu7o843qNlM=;
        b=Phi0J/JubMaqj46tTDKooiZPSRknPN03s1awjZY2uunK0Tig4xBD7xNr7XNrL6v6RM
         rN4dsLNJKrycq9ujcfMaqtIBxqFC8sDkuBosHM5rxW0di+OFjtuQsNIPzJ3+v8420Hpz
         t2R70Gs3WtC0vZRinWITnOg4AfepyxN8s1bdxxQ5/6JZe671Qsp7APdEcVlS2yt/qlGa
         Hq9wNIAWWEXwHzLPKDouueTPbPgSQITbEhcIuBufOmulDPn+/0RqLgWBddgXGrjijWxi
         td+O0St3biki2FL9crCfu9ZccWD79OeYYYANOPsJGgFxHp3l8D5b09f8SIwTKR1XyHQW
         0SlQ==
X-Gm-Message-State: ACgBeo2nmdSfX/HmsoJQFJaqxODF4ueng9OIJPcMS3VwTeTiikyS2RME
        r97fBNt9rWCylP8+b/uCmqanHK4KRjNj633+mlqpeA==
X-Google-Smtp-Source: AA6agR6ky4IGIxPLHhYV/8b2uxiAAYt+pZFHM3JktXk12uHP3jVa/AarKFhfi8Td1DFgzcnQxQKbVuSvWbob6B028VI=
X-Received: by 2002:a05:6214:2267:b0:474:8ff7:a21c with SMTP id
 gs7-20020a056214226700b004748ff7a21cmr18778338qvb.56.1660669308955; Tue, 16
 Aug 2022 10:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155248.2475981-1-void@manifault.com> <CA+khW7iuENZHvbyWUkq1T1ieV9Yz+MJyRs=7Kd6N59kPTjz7Rg@mail.gmail.com>
 <20220810011510.c3chrli27e6ebftt@maniforge> <CA+khW7iBeAW9tzuZqVaafcAFQZhNwjdEBwE8C-zAaq8gkyujFQ@mail.gmail.com>
 <YvuzNaam90n4AJcm@maniforge.dhcp.thefacebook.com>
In-Reply-To: <YvuzNaam90n4AJcm@maniforge.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 16 Aug 2022 10:01:38 -0700
Message-ID: <CA+khW7gXXEtRg-m5NY16PG1hCMJb2-Bnfrp7rkedAz8JHC5HWA@mail.gmail.com>
Subject: Re: [PATCH 0/5] bpf: Add user-space-publisher ringbuffer map type
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 8:10 AM David Vernet <void@manifault.com> wrote:
>
> On Mon, Aug 15, 2022 at 02:13:13PM -0700, Hao Luo wrote:
> > >
> > > Iters allow userspace to kick the kernel, but IMO they're meant to enable
> > > data extraction from the kernel, and dumping kernel data into user-space.
> >
> > Not necessarily extracting data and dumping data. It could be used to
> > do operations on a set of objects, the operation could be
> > notification. Iterating and notifying are orthogonal IMHO.
> >
> > > What I'm proposing is a more generalizable way of driving logic in the
> > > kernel from user-space.
> > > Does that make sense? Looking forward to hearing your thoughts.
> >
> > Yes, sort of. I see the difference between iter and the proposed
> > interface. But I am not clear about the motivation of a new APis for
> > kicking callbacks from userspace. I guess maybe it will become clear,
> > when you publish a concerte RFC of that interface and integrates with
> > your userspace publisher.
>
> Fair enough -- let me remove this from the cover letter in future
> versions of the patch-set. To your point, there's probably little to be
> gained in debating the merits of adding such APIs until there's a
> concrete use-case.
>

Yep, sounds good. I don't mean to debate :) I would like to help. If
we could build on top of existing infra and make improvements, IMHO it
would be easier to maintain. Anyway, I'm looking forward to your
proposed APIs.

> Thanks,
> David
