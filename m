Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA225DDF1
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIDPkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIDPkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 11:40:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35168C061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 08:40:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e17so6487818wme.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UepLnAGm5bpwluzF27iv5ycWf6F3L6iDFJ3ntJ9ckZg=;
        b=jSPhItzH6eO3u/bMnEUH4xaq9AJJQ6o+lNBN59ZfglzixygO7mU4VVuLyE3D0dDuAq
         TbJrs5fgZ/m/f/stUao8puIG6GCwidql8MqK+8rFbC5bO1b+F3AmXWw7teBa1bUUGxaL
         fxwBMtBxeKPkFCEl7FukzhH4z9lxm8vtgFp7GtCQQAr6UJ1mJ7kuisOojJGNHxAcFvDd
         TJc5red2dosvE6ZKsaJfkT+JeO45WzV8O4apR4v7b62k4Rt0D8ZQpCmEFdS2Efst6w/K
         MBgRjZ18nGnX0s9CrEPyj6MDEeaN6yXFsCTxDOcJ11GrU5a4GU5kE5mh40panD0jXzX5
         X6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UepLnAGm5bpwluzF27iv5ycWf6F3L6iDFJ3ntJ9ckZg=;
        b=AKrw0Np4yJT5SpW7XsBTDmnNipc4e1LWF4r9g7+wnLz9xHCYAYvJFwatdBchMaZUvZ
         0YIXCQpClBErXY4lNU1l1McdaWooBPZiDnHGCnqFnS4pUXTRfPUIN+DHw0U3suEDNC+C
         z8r1GSIkbdlyMc2Tb0gLsFQTFnPZTV4XFiIMNEMZ3nKIgMVD/DqoBYaepNp2s/ZN2g/i
         8Z5rrQtQ6KHUbFgJzEGBnGy3PfYKZO5/yZYzDdZT6B0fK9penRVwOzUIHWZ1EQBXPVG2
         pC/M/hktKpcgV/9E1SB6DIsQTZ9xPnSX2otv6HMDs4f0PK8EBJ8HiDi3ZcrmPAslViY7
         x6FA==
X-Gm-Message-State: AOAM531dmqDSBmF6ObEcpD8Y5agZv65htOP2IMFq06Rb3KhAaVO1bS8q
        YMmDXV+D09v/gutB6h3wltqhpcndwe/ojmjWUVfw1GsIttWLgCME
X-Google-Smtp-Source: ABdhPJyOHGWdYHjjqz9taAXAaSUcXyhVQZWHBugoOMThXpF6W61e7ex+bOl9+1PKDtu/pFpLGyURNTEEWbGpAiZfChQ=
X-Received: by 2002:a1c:28d5:: with SMTP id o204mr8635570wmo.104.1599234015016;
 Fri, 04 Sep 2020 08:40:15 -0700 (PDT)
MIME-Version: 1.0
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 4 Sep 2020 11:40:03 -0400
Message-ID: <CAOWid-e1m_S7_o35tDis1KMZcwaDPbCH8WTKrZG7_4QZsHS9XQ@mail.gmail.com>
Subject: BTF for kernel module, and other general questions
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I have been reading this
https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-and-co-re.html
and understand that btf is generated with CONFIG_DEBUG_INFO_BTF=y and
is made available at /sys/kernel/btf/vmlinux.  Is it possible to have
similar functionality for kernel modules?  For example, is it possible
to generate BTF for the XFS kernel module and have it made available
at /sys/kernel/btf/xfs ?

An unrelated general question: are there
documentation/guide/conference talk that talks about BPF from the
kernel space perspective?  For example, is there a checklist of what
needs to be done if I want to add additional hook or new bpf program
type?  I have been doing some research and I have found a lot of
guides and tutorials from the user space perspective (writing bpf
programs, attaching them, etc.) and some deep bpf internal (like the
verifier and jit) but I am having trouble finding something that
covers the topics above.

Regards,
Kenny Ho
