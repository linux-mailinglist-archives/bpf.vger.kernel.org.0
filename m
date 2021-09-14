Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9556440A4E0
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 05:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhINDtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 23:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbhINDtB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 23:49:01 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2295C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 20:47:44 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a93so25173213ybi.1
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvRhVVCBVmTld8Xr7W9nsB3L7knHeam0iofkM+gkE8U=;
        b=KSZXCdj7Z0Mj3k4z1fXFQljtl+E5pbRjcVc63ZyvBlw7CKCYO2JxQvQD3x/MiPl5Ob
         l0zjEZGA/Of7osUqwZqiOevQL9lvC1MlIsoOzuzuH/elczbHSuKoHpXCCARGpupnYGMp
         oW7yo89JnyjaNdU21uEZXnvzA1fIoB1dWQ1rgpTQjyo26dGCt92DUfgOrcy/3UMqnRvy
         UsKWvEWTdN5KUQzm88f82vhUlf2OQzwAdxfP8oLLTeYyapyeVA0VPZTqNPZRTdDFDHhK
         e0ye1zsYk/W//qWimfK2IH8xD4RJRUpZrUwz8XSEWGmluWg1o1nwOZ5IASTOJRSSNYhK
         WC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvRhVVCBVmTld8Xr7W9nsB3L7knHeam0iofkM+gkE8U=;
        b=UlvxdxfZ6vb5ttZqMEQhIKPVSJyPDHzFOG5lIqOnavbOMZHRPM5LQWqvc3KjwsYmum
         cv7neBhBnXXmegfTwvUuGg8m4L6H3I0ONjl4M60Ol5YFZHhu6cAnHG3FSgW0PdNWEbzr
         +SeoPbMOCU/UZE8qjIUoNc3zzqDTYw6WiwcxhWfqPXSsXzb6dbhKdH5WpXHS6Z8holcT
         M2d/mYLrVW4Kq+e5xbAZhOBrHjql0EHCbCYbkviCYMmXx+k5BpNX7ovopJiWSrzWdoSV
         3u0xxDhFbOjdMGLWp3Uwprs+k7h7UZUIs7AGff2LSX+6weZiFJ/lWEAQd6sA8EIOKE6L
         VkRQ==
X-Gm-Message-State: AOAM532fKIHaixzN5cuvtHPHdAVoHCCixOO/9yehr1nHcte2O6O0vCL3
        K7PUt+z1wboG8MwqNpXH1C4KfmiElDgcm1iou1b9tn0a
X-Google-Smtp-Source: ABdhPJwv1YnhLSsc7i65g12nNZW8vclgUgzYHqYWwZga0BSNkJQ3s6iO3B9sFdDtN3HywVqaWTkz2aETvPaBjTgNMVE=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr19963317ybj.504.1631591264087;
 Mon, 13 Sep 2021 20:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnuNNuenDT4Y_UHsny6BK_b1+g2joePAdapdn7aLCi99Rh3bg@mail.gmail.com>
In-Reply-To: <CAGnuNNuenDT4Y_UHsny6BK_b1+g2joePAdapdn7aLCi99Rh3bg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 20:47:33 -0700
Message-ID: <CAEf4BzZokm=_5vdf3sCccTf2Enf0-kwij7dusykcgtWPkM=95g@mail.gmail.com>
Subject: Re: Read process VM from kernel
To:     Gabriele <phoenix1987@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 11, 2021 at 2:05 AM Gabriele <phoenix1987@gmail.com> wrote:
>
> Hi there
>
> I recently started playing around with libbpf and I was wondering if
> it is possible to read a process' VM from the kernel side. In
> user-space one could use process_vm_read, but I haven't been able to
> find an equivalent BPF API for that.

Currently only current process's memory (in which BPF program is
running) can be read with bpf_probe_read_user(). I don't think there
is anything that allows reading some other process' data like
process_vm_read allows.

>
> Cheers,
> Gab
