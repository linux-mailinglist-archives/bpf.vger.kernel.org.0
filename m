Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6343A9195
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFPGEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 02:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhFPGEr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 02:04:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAA4C061574
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 23:02:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id h15so1324188ybm.13
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 23:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8TGpwDW+dSCR99ealAtWOZ3uvDztPaaXyin6unvPDo=;
        b=pieeQtg1MgInSafToAPfAV9RijDU/TbtQanN0BX7QSkk22S/6az5rhFLN/dVsmN0Td
         1EY8SKOV9Hm9vhJVNX6buCNuRuTWU/0lmpGWRJa1Sb80EDA76Oq+XklUCTY/DYZbSo9m
         za2oi26W0Dnde8pn0fuk73Ssuw5uUohdNqgVCCDRocFinRC53iYwzyRBV4JnYULBDnFK
         18wFXX2UVI33GRuE6viYXEe+TgJlzDRu6BTKl9+AEt8HpzSnnTgncACnLe02Ft3DQGoP
         s8sFm/WATyM8mUMrTqHo/NjAqHYF/1CBClYjuxXf3DobRq1hglqQj4F2bc1UlInE57GI
         sBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8TGpwDW+dSCR99ealAtWOZ3uvDztPaaXyin6unvPDo=;
        b=Vo4Ky5ty+VONW2SKXkn8ZeqhBHh8UH1lW5hiF2kZ7Zimoqb0lkvYfi8QlbtZ5amlbf
         o6+7Hf/zNlUPSvFi51Ccb8Sa313li//l/37cNrj9d27iZwKQ78LswWks5LMmQ6fy5qSn
         +2OYUeVk7Ua1757qAG8t7RhcgJ0voUevvrOaWqukOpbBdyOVdagcwhrwe7X5tUfPKKFR
         ZQVKVJ+R+LOR4iIJRZ4x2sW3nbaFtlHGtsG9H/95juoRtEWujjVz4u4tTIuRwJgE4jEj
         8t2daqBgZoDPaPrZms79FHbI8OQoshMOkH03yL5QZKvyY5LxzwmNKgP61HPzeIEktQDP
         ZQuQ==
X-Gm-Message-State: AOAM533JnL611gP7oU0gApCRFOJGgfjXbrJHGiuPjwOtx9CGCqsJDXtH
        D4mz5yvpiiRRnmBnFsvA6JbCaN1vM7ja6kJgh90=
X-Google-Smtp-Source: ABdhPJwo+0bSIm1AfpwUHGB4lfZulqKKAn/Cxrq5qsVq91GMNZUTvz0GAwRIDf63HZsanEUSANVOOS3MH4HBtCzKw7s=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr3717862ybg.459.1623823361476;
 Tue, 15 Jun 2021 23:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <756efe9a-a237-e5d1-17fc-47936e76dacc@linux.alibaba.com>
In-Reply-To: <756efe9a-a237-e5d1-17fc-47936e76dacc@linux.alibaba.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Jun 2021 23:02:30 -0700
Message-ID: <CAEf4Bza2ytug5PMzTcXZjggZU-Zo63XJZzmw0ZoLHJ3-erJkpg@mail.gmail.com>
Subject: Re: How to avoid compilation errors like "error: no member named xxx
 in strut xxx"?
To:     Shuyi Cheng <chengshuyi@linux.alibaba.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 15, 2021 at 9:06 PM Shuyi Cheng
<chengshuyi@linux.alibaba.com> wrote:
>
> I am trying to write a bpf program that supports multiple linux kernel
> versions. However, there are some differences in the definition of
> struct net in these multiple kernel versions.
>
> Therefore, when we include a certain kernel version of vmlinux.h, the
> compilation error "error: no member named'proc_inum' in strut net" will
> appear.
>
> However, when we include another kernel version of vmlinux.h, the
> compilation will appear "error: no member named'ns.inum' in strut net".
>
> Anakryiko mentioned in the issue of libbpf/libbpf-bootstrap: vmlinux.h
> is just a convenient way to have most of kernel types defined for you,
> so that you don't have to re-define them manually. Link here: https:
> //github.com/libbpf/libbpf-bootstrap/issues/31#issuecomment-861035643
>
> But struct net is a very huge structure, and it may be very difficult to

You don't need to declare the entire struct, it's enough to declare
only fields that you need and use.

If the type has incompatible changes between kernel versions (e.g., if
some field changed it's type), you can use my_type___suffix approach,
see [0] and struct kernfs_iattrs___old example. Let me know if you
need more concrete example (but then also provide more concrete
explanation of what you actually need).

  [0] https://nakryiko.com/posts/bcc-to-libbpf-howto-guide/#dealing-with-compile-time-if-s-in-bcc

> add it manually. So, how can we avoid compilation errors like "error: no
> member named'xxx' in xxx"
