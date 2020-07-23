Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165E522A6F0
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 07:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgGWFfT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 01:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgGWFfT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 01:35:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391AC0619DC
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 22:35:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r19so4964582ljn.12
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EP/AQNT6xXd5KDDpqbWlEcCngVz5lTKZeNI5M8bpAM=;
        b=jg1+w0OVXsJjdVKYDoLJqSugqz8VbG6+9OkZmmPcKqG5vFHhU+pVMYVWBjlN2HGlaG
         ysZWf2U6R+h9f77jAi4Dequ+UCP7I0pgtyv2lvgwZXODhAiZuVd3GFo++ZkAtOg1ZOnK
         j3d0GJNQxfKR75wxipLljJkL4BTNRdCvy1tqjLYvezgo0Nn4Cw/lBFPgvHskSUCe7XIq
         6snFu1zpY3IdvetMIbLcuU7XUKRJOqakBhEHtBKuhAXMXFPXKXdANJQmW1BjyjrHzkEp
         PSM19crhw2zkixfCXIjkHs/kmSurXLf3RhmZnJ3bnY/iia5XNviiZ2wpEU2BQep502bj
         rjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EP/AQNT6xXd5KDDpqbWlEcCngVz5lTKZeNI5M8bpAM=;
        b=JSIZvGEFURAbIwRYG2FhkTq1VDQXAD0a4aSP5DK/R0qoV28DYC6rQSa9L5J61h81xK
         vU/dXl94a105JKEzhSwjvU3HC8EIBmjgFh1YFvUDgA5jB3mv5vt4pPO6mXm0hFD7IOvX
         JCBz71Rf9znuNO+bCDUomtAPb/mgxOw2CkzImWC+A21sv7mAIkKBBufDZPOS5M5n9UjU
         z2k5u2l3EzdIhhWK6wH+NDsQLI/h5U/NYlkX0yN7rlP/OyPyIyCBYf1ESNps0180jUjs
         MVNghRl7tkF6c9FvycaLmDb1eajL/a6vbn41J622/pswWfTAMihAgf/tROtCh0VJsKXL
         hRUw==
X-Gm-Message-State: AOAM531YsygrrzxEqyeydjdRToDDCPlXt1ecUMP1CLRAZVOYXGcN9GEl
        50PMjEpzW9LvFTd0Efkuwm2pui8UcppekKHbmg8=
X-Google-Smtp-Source: ABdhPJy3x8zYwgpd0gOT7q4/S64iApxCj2tfWL9Izlx1z5kNSj/BB9zkxLZeiYuB4W7mgBH9O1YDXMmxekqwWuY8sOo=
X-Received: by 2002:a2e:9bc3:: with SMTP id w3mr1229091ljj.121.1595482517400;
 Wed, 22 Jul 2020 22:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200722195156.4029817-1-yhs@fb.com>
In-Reply-To: <20200722195156.4029817-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Jul 2020 22:35:05 -0700
Message-ID: <CAADnVQJiEES3xaE_PRWSYmfLG1L1p3ie8nx=o66E-2SGxLrK7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix pos computation for bpf_iter seq_ops->start()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 22, 2020 at 12:52 PM Yonghong Song <yhs@fb.com> wrote:
>
> Alexei, I also made the change of "mid"->"map_id"
> and simplified the logic in map_iter seq_file->next()

Thanks!

> the same as your patch in
>   https://lore.kernel.org/bpf/20200717044031.56412-2-alexei.starovoitov@gmail.com/T

I've rebased that one on top of your patch and applied to bpf-next.
Thanks
