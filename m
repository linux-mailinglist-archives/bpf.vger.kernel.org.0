Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C9241424
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 02:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHKA12 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 20:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgHKA11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 20:27:27 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722F5C06174A
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 17:27:27 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id e187so6116664ybc.5
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 17:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCELKvewJ25oPpL9m2h6vwGEUGM/6cJQi6GwCIuOS9Q=;
        b=j7AdXxYHgcuE5nTT0FBITY99XIxMUZvzmWiZxdN0XptapZ9Ej3JTU9ZD1WFHTaaIhX
         Bn1jzblQzXGkjpqi048tYrAoaBa2S9A7ULbO33CmiBWCS2mgJmv8txI7joBHoiWbQ+DK
         ny0pa4rc9ffahF75O24yg/axobIJveqbS/kUI8oqDXbyNkSCzncurHsW6Gq9BXcKTxOw
         wtdrp1PhQUDx8bBjd3KfgiAL20f7lATB8hEJM5woIzo27whrkoRonv62njhafJzyhSD7
         SI8R49K140DpqifqaFcy+XigjP88CZD6n6H4O+AZn1/IrQYV4apjTa6q8/doE3ZmjB31
         ITlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCELKvewJ25oPpL9m2h6vwGEUGM/6cJQi6GwCIuOS9Q=;
        b=A97tO6ZiauOabtsGWfBGNWzMes1HnSHuMI344HmHG0U3fQg8QehX44xBxmx8lvVcZF
         lHdpmZ7YsnBfd7QbzABghVwHghQrDvj4za5SnR01R4FQqUK0XbRSSEocCsXM2VyAdVYC
         FHjlsDGTb4el558jMWse92ZkIfIgw556kYoCBgVOXjo15kIlGCdQXjiAZoDT8Ck+iTbe
         kZafs3bI8nT+NZRWgpf0SqoUAPJSGcKjwnQABzTEO486Cp+MDeK7iBF92lBR8MaWZK7Y
         C0yAjrvx+BUeASIeeq456RLSijk/0XeqwlEyqx7njH/mwsEVRgxkQj8xYRNXs2kHbVTr
         bC/g==
X-Gm-Message-State: AOAM530/O8gV0B1kv4BI1vqeH8GzRiwlAeW7kxRQZBmignI7WWYPuVH9
        ctRQTip2/Z0RwYmnNpHlwMIlgNdFA03e7P41bqM=
X-Google-Smtp-Source: ABdhPJzp43PzC3UzS+gkqdSeW3HK6QgtEgpPcaqewacS1vV1/OCoAm87yZtl1NLKCUN//H0sYKvJu0GPJ3eGJ3QbJ/k=
X-Received: by 2002:a25:c048:: with SMTP id c69mr16945466ybf.459.1597105646778;
 Mon, 10 Aug 2020 17:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <xunyft9i1olx.fsf@redhat.com> <CAEf4BzZGUB5oqmFnV8Xmw+hXGr3fxRno0nkOuG+f5b9vNhbEHQ@mail.gmail.com>
 <CANoWswm-8oV5vQmcq68ncwCU5QhqRv12v8BMpsMO2rOeox-F8A@mail.gmail.com>
In-Reply-To: <CANoWswm-8oV5vQmcq68ncwCU5QhqRv12v8BMpsMO2rOeox-F8A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 10 Aug 2020 17:27:16 -0700
Message-ID: <CAEf4BzaLYefQJUxrOqtPRPcqFdN6EEN7_Xq5wa912mi6wDojNA@mail.gmail.com>
Subject: Re: selftests: bpf: mmap question
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 8:31 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi!
>
> On Tue, Jul 28, 2020 at 8:15 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jul 23, 2020 at 4:02 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> > >
> > > Hi!
> > >
> > > I have a question about the part of the test:
> > >
> >
> > [...]
> >
> > >
> > > In my configuration the first mapping
> > >
> > >         /* map all but last page: pages 1-3 mapped */
> > >         tmp1 = mmap(NULL, 3 * page_size, PROT_READ, MAP_SHARED,
> > >                           data_map_fd, 0);
> > >
> > >
> > > maps the area to the 3 pages right before the TLS page.
> > > I find it's pretty ok.
> >
> > Hm... I never ran into this problem. The point here is to be able to
> > re-mmap partial ranges. One way would be to re-write all those
> > manipulations to start with a full range map, and then do partial
> > un-mmaps/re-mmaps, eventually just re-mmaping everything back. I think
> > that would work, right, as long as we never unmmap the last page? Do
> > you mind trying to fix the test in such a fashion?
>
> Sorry for the delay. I don't sure, sending the patch.
>

No worries! Meanwhile there has been an alternative fix for the same bug: [0]!

  [0] https://patchwork.ozlabs.org/project/netdev/patch/20200810153940.125508-1-Jianlin.Lv@arm.com/
