Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B019427733E
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 15:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgIXN7J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 09:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgIXN7E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 09:59:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89D0C0613CE;
        Thu, 24 Sep 2020 06:59:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q12so1703648plr.12;
        Thu, 24 Sep 2020 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VqKeVQ1TTob+l57hN7CdbLV7X6Dn8oLhoInjEYhe84=;
        b=iJNOg80zt0Ah6l1cspo0ZJjdpKbJBzcvljzpu8+RCIbOrUi40Z1r3x2wlxIWpPzyK+
         eLb7EzZ3TJE+vkIwK2o9x7A+85aoWnqvzUIvkM9O+WkPQwDljpljo07XtixsC/idbiW6
         I5M/0BUAhIm+I37qSCiHIGqWqxsSIrJlkYRe9nvlaEabgDuxyKZeUYBWj1bNi6S9L6iP
         v6NgR7zVnmBQ5+hA1BQ9E+BznV19j8PON6LZah+TVe5iAr7w14Fa3n/BBV7TE960fC+D
         dBaJUb53KMUS/SQi/beDRYuLTahpqbK9FjRD9R5OvwgGQyFM+I59lTUFzO0RrZTU9sIm
         8b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VqKeVQ1TTob+l57hN7CdbLV7X6Dn8oLhoInjEYhe84=;
        b=dBgYZR+o1D8FNFJ/NgZpVxO/0wpQSf7sjJc0Jzi78koDgPlM58NSlXkMk8OlCSsbsj
         WG8jqipyXCEXv3wnCCK4B5mOMTQBkS0A2C/IyR/6LHvadTuEUqGBI6n5BOVrvU6/s1S7
         9Uo9K1wejARa86thWMNMWyVM2tEpGOJdqJxR8BOYy4AafgdF1y2WsDw0QYd7lImbBfDa
         xlxSmj+C12WvcHAgGr+DJ8Kabb5ASfWSHVjMYL8UspA924jdOZFQtOFwtpjrXMLIsTx2
         y59/SI6qprEdWSkX7VbJi+06Wp3rqFqMjpTKWzMLa5l8IzGOxvdCIAIEcp7V/P2O/7fZ
         C35Q==
X-Gm-Message-State: AOAM530XRI+aqXdc/e2YBkad9k4/rA06r53DXsmOAjt+NIWNNDD2qEHU
        ymh7jQ7eZ55S4OkgF6/9/PFwPYjBBICz6AzzM2s=
X-Google-Smtp-Source: ABdhPJyvl17/a3pu9tlrQgIEKe6i/q2CoeM5t9WnXhUUjEFht9tfPbDh6SnabQyrDZfNtd1ZmQpcooqGFz/nEPw+tIA=
X-Received: by 2002:a17:90b:4b82:: with SMTP id lr2mr4074041pjb.184.1600955944381;
 Thu, 24 Sep 2020 06:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org> <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk>
In-Reply-To: <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 08:58:53 -0500
Message-ID: <CABqSeAQKksqM1SdsQMoR52AJ5CY0VE2tk8-TJaMuOrkCprQ0MQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
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

On Thu, Sep 24, 2020 at 8:46 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> But one thing I'm wondering about and I haven't seen addressed anywhere:
> Why build the bitmap on the kernel side (with all the complexity of
> having to emulate the filter for all syscalls)? Why can't userspace just
> hand the kernel "here's a new filter: the syscalls in this bitmap are
> always allowed noquestionsasked, for the rest, run this bpf". Sure, that
> might require a new syscall or extending seccomp(2) somewhat, but isn't
> that a _lot_ simpler? It would probably also mean that the bpf we do get
> handed is a lot smaller. Userspace might need to pass a couple of
> bitmaps, one for each relevant arch, but you get the overall idea.

Perhaps. The thing is, the current API expects any filter attaches to
be "additive". If a new filter gets attached that says "disallow read"
then no matter whatever has been attached already, "read" shall not be
allowed at the next syscall, bypassing all previous allowlist bitmaps
(so you need to emulate the bpf anyways here?). We should also not
have a API that could let anyone escape the secomp jail. Say "prctl"
is permitted but "read" is not permitted, one must not be allowed to
attach a bitmap so that "read" now appears in the allowlist. The only
way this could potentially work is to attach a BPF filter and a bitmap
at the same time in the same syscall, which might mean API redesign?

> I'm also a bit worried about the performance of doing that emulation;
> that's constant extra overhead for, say, launching a docker container.

IMO, launching a docker container is so expensive this should be negligible.

YiFei Zhu
