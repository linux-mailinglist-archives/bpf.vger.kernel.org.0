Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EB3251EDB
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHYSGt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHYSGs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 14:06:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89491C061574
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 11:06:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c15so6937251lfi.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbgV1ue27TVRMGaAdUZvt1XEH/MXY/5HeqmliZ5UI6w=;
        b=YFeSB2fnLie+kG2zUF0WmxuHroAZBJ0C1+Wi8aWwq38AgrtppEypFsnM+xJYaXKDBS
         roLTpajtV+zdg6Et0xxXfyv11j1T4Clh2R7BGynMPGx3Umy1yz1qGzW7Ll2GKKXP6+SE
         2VwA4gcANr9PWRTAuydbs9SmeLJ/zxmNgGPfCEbL5jIEtFRGthjksR878qWBTpkwmDS7
         Ao8moC0/GUIz3qt3E+HMKHFRpemEcRrvaWNd05B/AeK2iJNsOk5j7uUy0GjSMuXkNpg5
         h+XQSCYCtwIKYd2gpIJQBfYSFQclwL/7igwUWq/Afmc8H5z3Jfkge33pWG87L4Hfv2j7
         r/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbgV1ue27TVRMGaAdUZvt1XEH/MXY/5HeqmliZ5UI6w=;
        b=lkh9LKcPxOWIfQOm66Sgiasxfle1ADnLEhCSNxlalbS43+iDrMTUeSO38v/mdwl1Cf
         95o+Ng67JzRW4CQOMu6/TLl1mvTKJt1rlM9nnb54VfnKqW+8scXPI0lcHx351qZ5VeEa
         vdbxF58HisMi+K4v7RfKNv3Dup8cRmFanxibynFF62aSe9Wl3r1xv+pOxuzFsIkd74mv
         Z080vEE7+JJjGI8QjBHExMIL3no/VXjST/ewZ/QavCsOIw3uuY9oXiDlB43U0QnTtX5n
         /MbJB4R/mPgw4ogFN3zI6CftjPohomu9+ExbBs5ospqrBzC5EEhhllQqNI5o6NZx/dgS
         Xx/w==
X-Gm-Message-State: AOAM532QYNiUcwUx17ONo57Un6/Ihx6OeNJVNvYj1189Djh/UDEyBCdM
        16wTUez273/0kegYxvOx4qc2BnCADQQNnMyTm6g=
X-Google-Smtp-Source: ABdhPJzq4L2pxXfvu2YVFiYwXGSEmxVmft6v/6jRgYs2iPwjT9FztV9zj2lhtNh6d1hL46xkZ8rmmRcof4KQpLoIXSM=
X-Received: by 2002:a05:6512:74b:: with SMTP id c11mr5300640lfs.119.1598378805791;
 Tue, 25 Aug 2020 11:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw98fJe3qanRVe5LcoP49METHhzjZKPcSGnKQ-o=_F3=Hfw@mail.gmail.com>
In-Reply-To: <CACAyw98fJe3qanRVe5LcoP49METHhzjZKPcSGnKQ-o=_F3=Hfw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Aug 2020 11:06:34 -0700
Message-ID: <CAADnVQLji8CMCVoefHPqc457Fz1xZ+yEnogHXpghhx6=GPYTbg@mail.gmail.com>
Subject: Re: Advisory file locking behaviour of bpf_link (and others?)
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 25, 2020 at 6:39 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Hi,
>
> I was playing around a bit, and noticed that trying to acquire an
> exclusive POSIX record lock on a bpf_link fd fails. I've traced this
> to the call to anon_inode_getfile from bpf_link_prime which
> effectively specifies O_RDONLY on the bpf_link struct file. This makes
> check_fmode_for_setlk return EBADF.
>
> This means the following:
> * flock(link, LOCK_EX): works
> * fcntl(link, SETLK, F_RDLCK): works
> * fcntl(link, SETLK, F_WRLCK): doesn't work
>
> Especially the discrepancy between flock(EX) and fcntl(WRLCK) has me
> puzzled. Should fcntl(WRLCK) work on a link?
>
> program fds are always O_RDWR as far as I can tell (so all locks
> work), while maps depend on map_flags.

Because for links fd/file flags are reserved for the future use.
progs are rdwr for historical reasons while maps can have three combinations:
/* Flags for accessing BPF object from syscall side. */
        BPF_F_RDONLY            = (1U << 3),
        BPF_F_WRONLY            = (1U << 4),
by default they are rdwr.
What is your use case to use flock on bpf_link fd?
