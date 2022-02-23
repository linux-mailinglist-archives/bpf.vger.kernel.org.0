Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C794C200A
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 00:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244992AbiBWXlV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 18:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245107AbiBWXlO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 18:41:14 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72045FF39
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 15:40:28 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 8so966757qvf.2
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 15:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CESrRoy9BdwzH7JJF6s4JyS7FHvpssnFdmkEU9LaGng=;
        b=Nyd1OHJQg+vWRzBSlkdXEVZNzWPjcgTqw7n5BzDUAdnwNYCQ8LoyAh1+UF3bMnj7P6
         7ET2tqC40l1m7UflEYd0J3sor3102ZzaENiQj+x0ygCPAr6uh9T8Ll4ieh2Kc8wDPDjt
         uvYEY16wchls1F1bSKcFMOc9vo/+3U8QsKh3ktMD3na7hS+ay2vJ+obzkQOIKh9mhtKC
         sWPfuu3K/ZC6zsey7UtoahL32q4Q5FVRsoc+dzrS0QnnBpocYaHqgoA1c5RIyZq0DzB2
         a3ZNfwslGS/wBDh1pTpvAIqWVHAvBRTWr0Snwq/z/3I1nzFG0KgwcZh6BoGVteBoggWY
         YlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CESrRoy9BdwzH7JJF6s4JyS7FHvpssnFdmkEU9LaGng=;
        b=UKQ52b5CsXnye/PZ+DPMQ881yCae41rFcHw38vl0FdInqZdBn0O72eLeWNoPSYkGJl
         okCG2k2I9+Y/A82c5blhKVFjJjjOZTPB4oW2UsbR2EfdDt/8QhF5JODfPy+ZH5Mq9HWM
         NBECGzTp/ZX0oGl7MS4O3cVp0+gm8UY59FBDtR4t5kNBY4b4WYRHl39Q+IFM2tS/jgNN
         kKVWmCwf2q8lDqRo0GBRbXcfzSiseGZkQwZIOp2DhJLm7B4v5IEpsH48ZCpS5qEJVfRI
         uNGLlHkNdOkBbFzu1y33itd9/dZFqb1XaKIHDHfdaXtYo/UiA0ISP1Ixv6OquzoeySMu
         f80g==
X-Gm-Message-State: AOAM532YH3xuYOye3SqsbFID0I6iNs/ErRVSaXdzHGsSnX862KVyFJOV
        +cTGi6sUZMsaH1xkZzmvVGz9w91SRRqR1DgaKaa/Tw==
X-Google-Smtp-Source: ABdhPJyQPswivyLx10GCllDeDv2v+KRpFhg5sA++diMjhYKqxR/Xemu9PESgutAiJzGQ4TXkIsbBJjvxPFf8oxygG8o=
X-Received: by 2002:ac8:58d5:0:b0:2de:2dfc:77d3 with SMTP id
 u21-20020ac858d5000000b002de2dfc77d3mr174413qta.168.1645659627725; Wed, 23
 Feb 2022 15:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20220223222002.1085114-1-haoluo@google.com> <CAEf4BzbjxwEukaZfW9qCLwXeyS32WeNQ_8MvUqRd-JA7cZzuGw@mail.gmail.com>
 <xr9335k918eh.fsf@gthelen2.svl.corp.google.com>
In-Reply-To: <xr9335k918eh.fsf@gthelen2.svl.corp.google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 23 Feb 2022 15:40:16 -0800
Message-ID: <CA+khW7hKQcJ30om+XzrCa-Aj=r9eHAHETS=7qtVW6+t480w2uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Cache the last valid build_id.
To:     Greg Thelen <gthelen@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Feb 23, 2022 at 3:16 PM Greg Thelen <gthelen@google.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> >
> > as a further optimization, shouldn't we first check if ips[i] is
> > within prev_vma and avoid rbtree walk altogether? Would this work:
> >
> > if (prev_vma && range_in_vma(prev_vma, ips[i])) {
> >    /* reuse build_id */
> > }
> > vma = find_vma(current->mm, ips[i]);
> >
> >
> > ?
>
> Yes, that's a nice addition. Good idea.

Yes, great point!

I noticed range_in_vma() already has a check on the null-ness of
prev_vma. I am going to send a v2.
