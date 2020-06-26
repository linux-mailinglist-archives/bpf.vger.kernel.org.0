Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C083620AA29
	for <lists+bpf@lfdr.de>; Fri, 26 Jun 2020 03:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgFZBg4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jun 2020 21:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgFZBgz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jun 2020 21:36:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B0BC08C5C1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2020 18:36:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so5011877ljp.6
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2020 18:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBlssWGvZOAUnwbFE+tTOZwoNXNhC7FxvKiwWZijAmg=;
        b=Qby8f0yox/HTyimDKy8WH3QjOnsg/2FljFlSp/oNDI3KhHpuZAxj1N6Z18mesHmIms
         NOZMN7rYftj4wIT3wsgRxLsZf9lBCRiKDlD1XlyYLBOunfkrsxx012pA879ViQA3++T/
         co+GFPa4HCJ+SssCzgmGMtkAllEXMS8wzS4JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBlssWGvZOAUnwbFE+tTOZwoNXNhC7FxvKiwWZijAmg=;
        b=UjUgJnten/jFCXfj/4m+RnH5eeKWZ4LQa7HzHP4QSzwcVo/Ay6d4VMeqtq+vbXPCGY
         8OXHzWlM9dmNbQ3707jNdF+rubuz0n2Of+0I6gaPEvhtt4YzE8/nI5xiHoMkkVIhG0qW
         on5ycqckI3giKJJg5iNJ3k1qJLq0N/xJIP+CQOicLtmoPTIfVQ7vBLl5Pkq+MXwBNqlH
         mo+pbC8RBnjVjcH+QGm6rkis1q9awXZOnVXU0qQ371RTHU6fxXM80TWstmMfFR6EgWef
         9KIfdNIqkvgEVeOB4ZqA+tw4OT0vZD3HghlclZJ46AubgnmLgfv1RBZfq8C08VL7qAqs
         DR2Q==
X-Gm-Message-State: AOAM533F8NMFjtxYDh7cUzOV88ycp1U5kigzocIDeTDDT5nOJ7PvDrnr
        PpPzdmXaWRD9qlTceW1Bbc0ciOw5plU=
X-Google-Smtp-Source: ABdhPJzusRBzmv9cyATl7JVHK3hDExdMa+noG6PuL070iZnny5eMFAw2nJa8YIbHb3ipiJfiWVmuXw==
X-Received: by 2002:a2e:3808:: with SMTP id f8mr212978lja.165.1593135413324;
        Thu, 25 Jun 2020 18:36:53 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id b7sm6381496lfb.53.2020.06.25.18.36.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 18:36:51 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id b25so5011774ljp.6
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2020 18:36:50 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr215388ljn.70.1593135410467;
 Thu, 25 Jun 2020 18:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200625095725.GA3303921@kroah.com> <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com> <20200625.123437.2219826613137938086.davem@davemloft.net>
In-Reply-To: <20200625.123437.2219826613137938086.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Jun 2020 18:36:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
Message-ID: <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     David Miller <davem@davemloft.net>
Cc:     Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 25, 2020 at 12:34 PM David Miller <davem@davemloft.net> wrote:
>
> It's kernel code executing in userspace.  If you don't trust the
> signed code you don't trust the signed code.
>
> Nothing is magic about a piece of code executing in userspace.

Well, there's one real issue: the most likely thing that code is going
to do is execute llvm to generate more code.

And that's I think the real security issue here: the context in which
the code executes. It may be triggered in one namespace, but what
namespaces and what rules should the thing actually then execute in.

So no, trying to dismiss this as "there are no security issues" is
bogus. There very much are security issues.

It's just that the current code that is just a dummy wrapper around
something that doesn't actually do anything doesn't happen to _show_
those issues, because it does nothing.

I've stayed away from this discussion because I wanted to see if it
went anywhere, but it doesn't seem to.

My personally strongest argument for remoiving this kernel code is
that it's been there for a couple of years now, and it has never
actually done anything useful, and there's no actual sign that it ever
will, or that there is a solid plan in place for it.

So to me, it really looks like it was an interesting idea, but one
that hasn't proven itself, and most certainly not one that has shown
itself to be the _right_ idea.

We can dance around the "what about security modules", but that
fundamental problem of "this code hasn't done anything useful for two
years and we don't even know if it's the right thing to do or what the
real security issues _will_ be" is I think the real issue here.

Hmm?

             Linus
