Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52763CD04C
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 11:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhGSIeT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhGSIeS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 04:34:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56644C061574
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 01:16:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e14so6816250ljo.7
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5FkYygAP5aYXKhiToJncjQ4pnqt1axbUfxSA6M106E=;
        b=RUoz3S+OzJer2hQ2zynaEh0ahbOByD6Ye2U9E+aySsu09fb59vHB8xqBnMBTNjooXK
         J48srP6gvu9447896+hKmxhF7Yn3jmLZiyQCnSf7eqMm4aPtsMJWS8efN62jjFn9mbAr
         AQL95z7CfrzZnBYbnITt4xTYVjHmXWcnLWPNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5FkYygAP5aYXKhiToJncjQ4pnqt1axbUfxSA6M106E=;
        b=ggZZGVOHsdlNE9yKWydXowkGdvRlXEd60bhYmVLW0tcLtGUgJdpbWtqPV3IyVWmwjy
         nrqdfsHTj/69lLDipw7bkc+dxXVAgmZnkX4PTW6or7WzRjFhkZYx5HOC0HeQWTFrydua
         SxTpgHXiaxq6R+MFeCiGU2TliiFXZ7YsHZsdj/RtbWKi/YKrCviewJ5tms7/Ou0FoRSs
         ZLEW+CXluEquz8Sgq6x7vjcq35ekNlnMfXd6ATDQSrz/Znmm5fccW8nkqeV/U7fEXYuL
         L5PyfZr2lwv5qSMxWfNW+Ac7ForF/bCLRmvxTGZqi1QJe+Ms+MBzANk7kydX5zhZKXh3
         LxJA==
X-Gm-Message-State: AOAM530eu0x8S07NEzYIYZ0whyE5TutTKrA11sZy4amXijhUD/nidiOh
        hIh5tTYYjvajyrH+1U9QU9sp+A+gnDEQy3NB3CLr/DfeK1Q=
X-Google-Smtp-Source: ABdhPJzlxqfFGaZrZ/5HCQxqAtoUQFd+tAAHV7lDvF2Cb/wf0Cnc0joQvV4k+SOZgE1RrpeWhEROVb9+ifjTZjQ6mgs=
X-Received: by 2002:ac2:43d4:: with SMTP id u20mr17544633lfl.451.1626684328396;
 Mon, 19 Jul 2021 01:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210716100452.113652-1-lmb@cloudflare.com> <CAEf4BzauzWhNag0z31krN_MTZTGLynAJvkh_7P3yLQCx5XLTAg@mail.gmail.com>
In-Reply-To: <CAEf4BzauzWhNag0z31krN_MTZTGLynAJvkh_7P3yLQCx5XLTAg@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 19 Jul 2021 09:45:16 +0100
Message-ID: <CACAyw98RaF8SgA9nkduXo-wBdsRN86cP=seX9d83i0Qhi0gbeQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix OOB read when printing XDP link fdinfo
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 16 Jul 2021 at 21:44, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> Well, oops. Thanks for the fix!
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> It would be great to have a compilation error for something like this.
> I wonder if we can do something to detect this going forward?

I had a second patch that introduced MAX_BPF_LINK_TYPE, etc. and then
added explicit array initializers:

     [MAX_BPF_LINK_TYPE] = NULL,

That turns the OOB read into a NULL read. But it has to be done for
every inclusion of bpf_types.h so it's
a bit cumbersome. Maybe add MAX_BPF_LINK_TYPE and then add an entry in
bpf_types.h for it as well?

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
