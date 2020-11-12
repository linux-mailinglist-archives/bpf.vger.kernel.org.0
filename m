Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3188E2B0DD7
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 20:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgKLTYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 14:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgKLTYp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 14:24:45 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493EFC0613D1;
        Thu, 12 Nov 2020 11:24:45 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 10so6404498ybx.9;
        Thu, 12 Nov 2020 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnzRuEV+LobstJGC6w0tpv3PvSKrX4rxoaQQBRAzYiU=;
        b=qsk3kUpZlKRzjcppq/TpRxDrqUJwKXNA+RdYZFuY+2q1qDvz67P5ffJm80V+GDTlmt
         XHNZPw+n8n4X/im0JL3VZqEDaxPzn9JYN2frHecwUGdcKUIXwDhQYWQhUTvhUd0pzUIP
         qzL3ph2DGhvoAY/eZ61I6su8xFDa6DMvRKzfq30ClK/Rx9CjCcUuvmTtYWcjbBEzVrws
         GJryqjb4RnmI1Goml4ZI92c7R5py9JKpj0H9Eg0W7ihYdqLSZcT3xR1dHM/0ihGXaf3g
         eRXBmwEKqQQ79kzxg8ZzYqVc40JJAemb2QFKianeaiBOU6a41fhrEo3an633T509pCG4
         QPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnzRuEV+LobstJGC6w0tpv3PvSKrX4rxoaQQBRAzYiU=;
        b=OjGSOjDL545896JIHpBXE6JO0M6SXFu2erOHKxjRnEcfa+BHec5ZLvLHMdFveq4H6r
         6M4MRnlu0/kucxWuSJLzG4eFXis+F9Qenxx3RjXoP3syRP4By3huWK3Xe9leUR+ov13A
         B075Du0lJok0Q1BAdRiebLEBVbU9YVn9ZDfzZlBB8HemsGd/NlJaITVVq4MARLfTc3hU
         0b00PoHm2NZkubcoG38GySxPIMGQHZE2PSDCqA1UIx1O+EJLdwwg+orezQrSUAz2vIas
         2PhBVRvl6tQVm1IjjjVFt/AdO6Z/e/HCSLFnPlPEgxOIU3ugqTOhnqOmEPepbZIRg6nQ
         J9Fw==
X-Gm-Message-State: AOAM531gAdrP6hbsqM1fZ4tF+Jz9NXDHisPxED+eUymowUnV9dMSVzLa
        IS58IqXG2qWnYXKWfofectNGycoA08+Se3lg0qyaUJA2Y7aCmQ==
X-Google-Smtp-Source: ABdhPJyUinMpjkcfznM+FAC0oxxriKsIXBlmCzj8P5GxmtnV5c6lyXypi9st2/cRl4GZl9weJLe/Bd/BC0g4PX/SOUs=
X-Received: by 2002:a25:df82:: with SMTP id w124mr1332716ybg.347.1605209084086;
 Thu, 12 Nov 2020 11:24:44 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZx=7N6dbKk8Eb_k-FA-PmmPFBJ=V-PLhbDu38wuXkOkw@mail.gmail.com>
 <C71IU5Z0R6UI.29FQP3BCZ65ZC@maharaja>
In-Reply-To: <C71IU5Z0R6UI.29FQP3BCZ65ZC@maharaja>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Nov 2020 11:24:33 -0800
Message-ID: <CAEf4BzadBt2On==P81dQmVbx1Uo8q43-mpCsW_0mS9w2sbrUfA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 0/2] Fix bpf_probe_read_user_str() overcopying
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 11:13 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Wed Nov 11, 2020 at 3:22 PM PST, Andrii Nakryiko wrote:
> > On Wed, Nov 11, 2020 at 2:46 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user,
> > > kernel}_str helpers") introduced a subtle bug where
> > > bpf_probe_read_user_str() would potentially copy a few extra bytes after
> > > the NUL terminator.
> > >
> > > This issue is particularly nefarious when strings are used as map keys,
> > > as seemingly identical strings can occupy multiple entries in a map.
> > >
> > > This patchset fixes the issue and introduces a selftest to prevent
> > > future regressions.
> > >
> > > v4 -> v5:
> > > * don't read potentially uninitialized memory
> >
> > I think the bigger problem was that it could overwrite unintended
> > memory. E.g., in BPF program, if you had something like:
> >
> > char my_buf[8 + 3];
> > char my_precious_data[5] = {1, 2, 3, 4, 5};
>
> How does that happen?
>
> The
>
>     while (max >= sizeof(unsigned long)) {
>             /* copy 4 bytes */
>
>             max -= sizeof(unsigned long)
>     }
>
>     /* copy byte at a time */
>
> where `max` is the user supplied length should prevent that kind of
> corruption, right?

Yes, you are right, I got confused. If the user specified the correct
max, then this would have never happened. Never mind.

>
> [...]
