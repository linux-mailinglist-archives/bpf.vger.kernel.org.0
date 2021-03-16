Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3555C33CA7B
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 01:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhCPArn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Mar 2021 20:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCPArg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Mar 2021 20:47:36 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD1C06174A
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 17:47:36 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id n195so35084592ybg.9
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 17:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7y9W973XNEprtm/UExLk1MQ1zUsByybQiN3TeElX3C0=;
        b=AXDzdkI8vMhLXdj737mTfk40nqB2KA2OOTtuxAfZ9UtjgJc9pXNg3dZDNpJ1CdRrRd
         +MJzZ9Bplqx6WirX2n58yvdMQdpXmoy6+AnGFa6W4GLlshwZhigEml7A7gmXBVCGsnPH
         3qwuiz9w2ZYdy9TkEXF1HGIG9VUlU9KlJrlRe8Rr+9QMJcMgYA82DGWQUm7IdNF7UaVm
         0WjqYjoN+h1z7Zs2JwYB7J0KNqlUsNP3OPZwyaxpmMeThZsBI/Eo/VM9JxllOOkeu9E7
         FMqGzoS4O/2pMEppr8czglDYqE7Gxqwo4ErGclxsFuRbIjMygBVRzc80k03PeuwDyo0F
         1gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7y9W973XNEprtm/UExLk1MQ1zUsByybQiN3TeElX3C0=;
        b=XCc02jbtEfDTQ6erWpqtJuajsKBdHYxEfWJg8Ni1pGgD/9BkGfpzlke+ktvN3MPya8
         sIYJi10wTwHUA4P64ETVDsiRWfNqmqIsokRRHBOJzF5Zj/6pjHjIxM3XvCJHXAVdE69B
         QXZZk6emO5XFNJw+bgep1RQeygtpWf90MIVtIr5QbgNZdpofx8B4GYqrEsvKgOvVP/b6
         7ZPhwXiQA2gV/OoKcGlpqTyMqSoWH8dyYxB/Wfz39Cqf91S/B1jraHs4qFR8xZAYXoOK
         wJm4QV6X9rPVtxZ85FIa3tvU+G6yL6hmND3Yoavyj+67QXIv/nTBtulVap0YFPmTrWeT
         rJTw==
X-Gm-Message-State: AOAM531BlPAy1qpHmo87zmsGrprNm8Y9ZpcVkI/k2dQcvJ+1xjIIdaqE
        7hd/OQylMIjh5b9e6ri78j0AFWFV6WDExyt9MO8=
X-Google-Smtp-Source: ABdhPJzNDNpuykhKyUuk2nLJyKzY1StCqruIPX854c1di0IqtYx5E5Llp7x0e4RnxaV8mgomrnUv9KGEj0WsOPEhH5k=
X-Received: by 2002:a25:40d8:: with SMTP id n207mr3325928yba.459.1615855655671;
 Mon, 15 Mar 2021 17:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oXG4HEm0rGEW-==0kaTmqenDUC_GM-qi7CEjwSakbnJRw@mail.gmail.com>
In-Reply-To: <CAO658oXG4HEm0rGEW-==0kaTmqenDUC_GM-qi7CEjwSakbnJRw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Mar 2021 17:47:24 -0700
Message-ID: <CAEf4BzZy0XDYcchPkarUw5AusO7LZfOnswuOyUqakkVJ-ksCDQ@mail.gmail.com>
Subject: Re: Generating libbpf API documentation
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 15, 2021 at 9:51 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> Hi all,
>
> I have been experimenting with ways to contribute documentation to
> libbpf to make it easier for developers of bpf projects to use it.
> With the goal of making a documentation site that is easy to
> maintain/generate I found Doxygen (many of you may have experience
> with it, I did not). I set up a CI/CD workflow using github actions
> that runs doxygen on the libbpf mirror hosted there, and hosts the
> produced HTML using netlify. You can find the currently hosted version
> of it at https://libbpf-docs.netlify.app (I would gladly donate a real
> domain name for this purpose). The docs generation workflow is in my
> github repo here: https://github.com/grantseltzer/libbpf-docs

Thanks for investigating this! I've look at libbpf-docs.netlify.app,
and it seems like it just contains a list of structs and their fields
(both those that are part of libbpf API, as well as internal). Out of
all functions only two are listed there (libbpf_nla_parse_nested and
libbpf_nla_parse) and both are not part of libbpf API as well. So I
understand that I don't see any comments due to the '/**' format
(though it would be easy to run sed script adding it everywhere, just
as part of an experiment), but I'm not sure why none of API functions
are present there?

I think kernel docs used to be hosted on readthedocs.org, seems like
they are also providing hosting for open-source projects, so that
would solve the problem of the hosting. Have you looked at that
solution? It definitely has a bit more modern UI that
Doxygen-generated one :) but I don't know what are the real
differences between Sphinx and Doxygen and which one we should choose.

>
> In order to make this work all we would need is to format comments
> above functions we want to document. Doxygen requires that the comment
> just be in a block that starts with `/**`. I don't think doxygen
> specific directives should be committed to code but I think this is a
> fine convention to follow. Other doxygen directives (i.e. having
> `@file` in every file) can be faked using a step I have in the github
> actions.
>
> What does everyone think? Can we agree on this convention and start
> contributing documentation in this way? Any pitfalls to doxygen I'm
> not familiar with?
>
> Thanks!
