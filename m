Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE92A5A62
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 23:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgKCW6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 17:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgKCW6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 17:58:39 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF34C0613D1
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 14:58:38 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s30so2246780lfc.4
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 14:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNac8HNLE00Dbwz8t1yzhVyitl7+yNqN0tC3TOZ7uVU=;
        b=lL9nbjzjMJDsdViJoWfCpeQI+/QggG5+5MAJjiaBqsnftDueWMr+NLcxM87G0Bov5h
         lf/3wEi/V+f23ndIkCpyOco/b01/JwHobRGP3moJPD/0cRC0H7dgalEHDrSNbEWtWq6c
         Y0xYV2hQfWFzrsz5edWvgTas04uKm4p4PDEjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNac8HNLE00Dbwz8t1yzhVyitl7+yNqN0tC3TOZ7uVU=;
        b=s2N7cDkpm0qAzJ6Vvh3n0YU48zem3fWK7a2H+7khmbqlb8++Szr+wuZdzas6yilKlZ
         6znkSiJSwW0GIc9rFAys+mBLv9bwd1OlUJzwIIyg8vU8HeUN2MWDbyzn5Z7VvhEXhMRM
         C1Sl8o4yC9F3/jCiA0u9+Mv3gBRKek1H+WB7zTcJD0G+okGkh8+GhNaMtgjG1sxhBYlq
         HCr71QVetlaVV00+kUddpaARIJjjCvhXRH7TfK2X7TA1veAjMo8fDoryjsJcZRYuY2ZX
         l8is62b/s5cLZVOOUFO4ZZXUtyveHtlG2LOJSzRauVvdem9/FAcn1QFwV1D7cu1LUTw6
         coNw==
X-Gm-Message-State: AOAM532P62cuN0R5vr/ID7uGvR/WZDGteGxXRvL5pKuKDivkUP9PZ8Im
        +5qysC1n/wmwNIAup+enqIRp+zsju2Cmdd/DIDcq2g==
X-Google-Smtp-Source: ABdhPJzAAQm6lplXZGkvzp/jqHJ1GiOKomPzELC3I1EzT5pG1/JVMXWKMFt6iG7S/Hcm7zuNq4FhL8v9WrNb9yWWv+A=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr8030260lfr.418.1604444317196;
 Tue, 03 Nov 2020 14:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-9-kpsingh@chromium.org> <87AD7DC4-63DD-4DE2-B035-A3FA2D708601@fb.com>
In-Reply-To: <87AD7DC4-63DD-4DE2-B035-A3FA2D708601@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 3 Nov 2020 23:58:26 +0100
Message-ID: <CACYkzJ4nFq9ugMvW9K9yO8JK8uv1Q86aCh5wsnPPhR7_7=TQJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 8/8] bpf: Exercise syscall operations for
 inode and sk storage
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 3, 2020 at 11:32 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Nov 3, 2020, at 7:31 AM, KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
>
> A short commit log would be great...

Sure :) No excuses for not having one, will add it in the next revision.

- KP

[...]

> > +                                   serv_sk))
> > +             goto close_prog;
>
> We shouldn't need this goto, otherwise we may leak serv_sk.

Good point, I will just move the close(serv_sk); along with the other
descriptor clean up.

>
> > +
> >       close(serv_sk);
> >
> > close_prog:
> > +     close(rm_fd);
> >       close(task_fd);
> >       local_storage__destroy(skel);
> > }
> > --
> > 2.29.1.341.ge80a0c044ae-goog
> >
>
