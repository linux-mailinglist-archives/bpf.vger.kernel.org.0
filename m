Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13C37A168
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 10:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhEKIKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 04:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhEKIKu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 04:10:50 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68FC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 01:09:44 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e14so16393014ils.12
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwCpuy6Ma+B9CLVkSzvCpXN8V8ZZ/aRoBy/1arq/RSs=;
        b=cIV2qx3BeZHVsrdbMvDAznj/cC5pkBGC/EWieQasxU5D18owMSHJRGexygR7IXnTEg
         9CioihJuiKHkbPHv7uBXMjp1JLtNl3zfJVP1Lw8TkJdJmJcX6YCDJ5z7GWkK4eZ0KHKe
         tm5jN1pkHE4g3oToQb/oBJ7jms3zTJqUVlqSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwCpuy6Ma+B9CLVkSzvCpXN8V8ZZ/aRoBy/1arq/RSs=;
        b=Y8P2NENAVrOzuZNa08Le0ppVSd1rnqMA3cwg+Q3cGedRFW6q9gqVEHcjW6KRclvTys
         gfvxOALFbzV6+YDKeFuPOrzaylzaBwSbcL65PpTpnoEway9kYuWAsWtANUh6V/rmFf4C
         zyGnh/LRP31rTExcokkjpFXJtnZ8Ayg5p6ECmXvuc9mfn1pNcCPdBuPA/6e9bPFIqCyX
         D480R2+f+/7NMZTbkwMS1pDa0dy/4QMUJ7J1QBeDGasAnqcw1U0tMUVQWjD7w3JExyBW
         rd464ugejdZ2XePo9YuQvLick04a8GT9OJBBs1oOl7iQLYqdV+mdlFBxqVma/y0aPj+t
         zpiA==
X-Gm-Message-State: AOAM5336Y50IEiqlEDcpwotcRSKmaEwDNg1GuMuxc0GbXmMTLypnCEW5
        T/KMAOFIY0ZOl0Q9obVCDNCOyOwPfZm3kdLiMpMQ1Q==
X-Google-Smtp-Source: ABdhPJxLrTuJ583PDRUD2+IejJpvi7l5xgC6okXhm6P67NpiMu21+S15ALbnCBxCdhErF6041gMD9mC4z+dav0ryQwc=
X-Received: by 2002:a05:6e02:eac:: with SMTP id u12mr25685917ilj.177.1620720584292;
 Tue, 11 May 2021 01:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210510213709.2004366-1-revest@chromium.org> <202105110911.f084GH7J-lkp@intel.com>
In-Reply-To: <202105110911.f084GH7J-lkp@intel.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 11 May 2021 10:09:32 +0200
Message-ID: <CABRcYmK+iEMy-DOp2tyaAVGfQMwhyeZGGs-LyO_RYfFprbs34A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix nested bpf_bprintf_prepare with more per-cpu buffers
To:     kernel test robot <lkp@intel.com>
Cc:     bpf <bpf@vger.kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        syzbot+63122d0bc347f18c1884@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 11, 2021 at 3:58 AM kernel test robot <lkp@intel.com> wrote:
>    kernel/bpf/helpers.c:718:23: error: use of undeclared identifier 'bpf_bprintf_buf'; did you mean 'bpf_bprintf_bufs'?

Ugh, reminder to self: don't zealously rename variables just before
sending a patch out.

I'm sending a v2, sorry for the noise.
