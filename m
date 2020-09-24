Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326E7276BB2
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgIXIWm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgIXIWm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 04:22:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716EAC0613CE;
        Thu, 24 Sep 2020 01:22:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so1466390pgl.2;
        Thu, 24 Sep 2020 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VffSKFOKcNEqzHH96dUPgeCMOjgSgi5QH+6TbDKTeEM=;
        b=HipLz25IFRXLxQfyxq4wFJF7SpeY50MTG/68Rn/bZPdFoaCB5RgVZiDO4bHvmNvvZ4
         p6sy/hJUOSKo+2YZx+a56N8Jo1WSofPDYjUzrdr0Y9+lMc/FYU6gFdDq++W+y6HTyIKr
         6mX4yJsgG5TwesHDZi2GvGeqpZfz7eeXMfifbLMX3X53uJX3I7PNLjiYgbYEiM3GObBZ
         dHckkMr2aM7gdOwFHBRH+P5Nt7EophqGBog+xZTERCxnN0mRajqsDE4Hzhxfbw75pTON
         f/koI/Lz+OIUxDB7Lc9S4XTXrzH4IG0HToeF13Cq1r6oyNExplV1dMJJ5LN2muREHtWZ
         2Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VffSKFOKcNEqzHH96dUPgeCMOjgSgi5QH+6TbDKTeEM=;
        b=Yg2vYYvEwN/EIhJ5sH4rui34bi3aIeATPtEdfZh24Wt3rZaMSXOqeu/B0Y62rDj2eh
         6Mfu/GFMfnd3g/gpQWIRBUNdh0AlYi/+49y9VbQOwACR2iN3dAxmE4IXjp9s9ITumtzR
         aE5oda5KVgd5BVgu+1T3qXcqJcoYkn9+lWMyGeT4m7ztTJnOvTKrzCbOf+K/1RMo57ig
         ONd+XW3LtIREU7Uh0RNIIX6TgMsUx2+IVK+Vjpns0szpuXBCy26ayD1gzirmjvznHN6p
         9uJrtMvxz+wVIOnCX7d5mNNAHUipjGkrw+A9XxRhMmX+owXemXaalC1ywsOG4TFktgm/
         hCOw==
X-Gm-Message-State: AOAM5317x7b/oo/Evc5PlxSyPYxys2kj4EAQyjdPyZtdUumzU1B2h23y
        SKdiBTM24ZhVVZEyaKirxMsBLTd+liliSJS25rk=
X-Google-Smtp-Source: ABdhPJyN6S3PvfBf/m7CmcAzF+8SBUXc1APBXPdomlmhd7pAkzxdoiweeazvaxZ3itj9ZG2VZdsL6HkmkZuhi7/iYzU=
X-Received: by 2002:aa7:8d4c:0:b029:150:f692:4129 with SMTP id
 s12-20020aa78d4c0000b0290150f6924129mr3496844pfe.11.1600935761975; Thu, 24
 Sep 2020 01:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org> <CAG48ez0d80fOSTyn5QbH33WPz5UkzJJOo+V8of7YMR8pVQxumw@mail.gmail.com>
 <202009240018.A4D8274F@keescook> <CABqSeARV4prXOWf9qOBnm5Mm_aAdjwquqFFLQSuL0EegqeWEkA@mail.gmail.com>
 <202009240112.C48EF38EC2@keescook>
In-Reply-To: <202009240112.C48EF38EC2@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 03:22:31 -0500
Message-ID: <CABqSeAR+DO3=Gt1KAAYKTJd7k07sH+aQCkofXxm7nX2TXh=w6A@mail.gmail.com>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
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

On Thu, Sep 24, 2020 at 3:15 AM Kees Cook <keescook@chromium.org> wrote:
> I was trying to be helpful: you hadn't seen the RFC, and it was missing
> the emulator piece, which I wanted to be small, so I put got it out the
> door today. I didn't want you to think you needed to port the larger
> emulator over, for example.

There's no architecture-dependent code in the emulator. It just has to
iterate through all the arch numbers. So I don't know what you are
referring to by "port ... over".
The logic is simple. If the emulator determines the filter must be an
allow for a given arch / syscall pair, then it is "cached by bitmap".

> I'm open to ideas, but I want to have a non-optional performance
> improvement as the first step. :)

How about "performance improvement by default"? It's not like most end
users / distros would turn off something that's enabled by default
when they upgrade to a new kernel.

YiFei Zhu
