Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747AC29B361
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 15:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766444AbgJ0Ost (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 10:48:49 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43886 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766431AbgJ0Oss (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 10:48:48 -0400
Received: by mail-ej1-f66.google.com with SMTP id k3so2584100ejj.10
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwzPKBS10xp0kZ0eSIGEka98bJnI718M6peMcnII3s0=;
        b=gS0Qmln69qwRP6vm8nCUQMt+jleHtvUILQP6a5aeUv0EEWU2WZZ/MkWnVoI5Gg2PBo
         UrRWGPxaeBOPJ9OdKHJXqHUBO9BIlQdNZTfd3xsAI5Xd1gQCyrHpodMhekLH6xEPCOok
         V+zStFbxyf9sBLxc81xYt+7qn47clmnNxIQ1+GZbtgVZZ3CebpuxmAO+tN19c6t4VRcw
         SLoPHqdYM7wT12+ItmV9uryWqbs7vutituOt6M1Th8Wd3nB9SCaDQ7BTp0at5Ucbdcc5
         I1QkySuXvjnX6PfGe/oTPHP5I9udqmQ+UzKeb2Mo1op/m7cHYUrPDXeqEln0ljmPiROp
         bb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwzPKBS10xp0kZ0eSIGEka98bJnI718M6peMcnII3s0=;
        b=DGTz1TwzX7HZMAV7pcpeDhIjn2fG5oYCicbxUTladM03riaum7+vVrjcPcnv2TbB13
         q6dXDHhs8xwf8+fd7Rh0HmDiW3Xqerhn2STm5yZcCfEmD2yTKSrn5Fb58NJD/9sCHRfF
         8k1IKtbndobYPXDjNqYPq3oRDRDVzAq2MMhLoEv0e26OB7GPt0MwIrZBg/XtEXMmLFxn
         unY4fsTGYa5t5JFZsnV/SWSjuLCRjrBBdueQxfKvELuVjKrE0j6uBITVGvtZZ2r7uvip
         PQfubx19jLVs/UzBWW6FwzaUd1i8byd6tFgOXwLV9sFrpLyGRZMjHva33x//I5G5oI3e
         CpxA==
X-Gm-Message-State: AOAM532p9oNyS3UNecMLoEJBj+q8NJMWZWyMrPSg6bYciBh4YgxxqESk
        LJwa920xIbwVOft/EMY8WJy/5/b4s2EeSN1cnpq3/g==
X-Google-Smtp-Source: ABdhPJwWE1LJ1ZI3to6EJIQrY6e4ZoysSouUhDOOa74fUtzLN9La7DPUDFZL6wtiN0JdiQf0PsKqWZI4hUiO55jBhFE=
X-Received: by 2002:a17:906:3a8c:: with SMTP id y12mr2645126ejd.531.1603810126576;
 Tue, 27 Oct 2020 07:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201023123754.30304-1-david.verbeiren@tessares.net> <CAEf4BzZaJaYw0tB0R+q3qoQX7=qy3T9jvzf5q=TH++t66wNd-w@mail.gmail.com>
In-Reply-To: <CAEf4BzZaJaYw0tB0R+q3qoQX7=qy3T9jvzf5q=TH++t66wNd-w@mail.gmail.com>
From:   David Verbeiren <david.verbeiren@tessares.net>
Date:   Tue, 27 Oct 2020 15:48:28 +0100
Message-ID: <CAHzPrnF0yZY8rk6_qMS55_=gLCKwHq1s7LaRtSqGy823gtwLMA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: zero-fill re-used per-cpu map element
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 11:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 23, 2020 at 8:48 AM David Verbeiren
> <david.verbeiren@tessares.net> wrote:
> > [...]
> > +                       if (!onallcpus)
> > +                               for_each_possible_cpu(cpu)
> > +                                       memset((void *)per_cpu_ptr(pptr, cpu),
> > +                                              0, size);
>
> Technically, you don't have to memset() for the current CPU, right?
> Don't know if extra check is cheaper than avoiding one memset() call,
> though.

I thought about that as well but, because it depends on the 'size',
I decided to keep it simple. However, taking into account your other
comments, I think there is a possibility to combine it all nicely in a
separate function.

> But regardless, this 6 level nesting looks pretty bad, maybe move the
> for_each_possible_cpu() loop into a helper function?
>
> Also, does the per-CPU LRU hashmap need the same treatment?
I think it does. Good catch!

Thanks for your feedback. v2 is coming.
