Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA463A7715
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 08:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFOG3T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhFOG3R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 02:29:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5622C061574
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 23:27:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i4so18950167ybe.2
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QG8dhKDfM70srkOQTm9DlVSQKp7s28uJ5Z1NK8YYq40=;
        b=M6OVVKS/PiIIHvv9f1ECH2qd/gUj+PwBz0teTJ/eSzV+IspOU3O6fxCLUqnMQriRGS
         LVPETRaNa9+ILuJDMHYoL3e25wus9uMw8SQWzD3S4tjNrKrOaisR9gKJU53VuJaZPnrU
         Vgy3Vic8AzUn384X0biCvCtCwDLMWLlPgih/WVaUSdhAcbG2z/pbVmIJLHyJtKa3Xfrk
         Spvmc5PInwnqXEWpOOX5HA4XRmk+cGUJiSKeylFghU8+kKTZ1hXqDOHsUjUNgFSi7I5n
         1CIC0D10xN/yLH+RvDZv5HUC3jtiEz2vxCTW40NypQ++sfKYDECb11Jh0HEBDIn5B1ib
         uBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QG8dhKDfM70srkOQTm9DlVSQKp7s28uJ5Z1NK8YYq40=;
        b=HnweH8vh6sZgUc+krknLt07CagML/4j0VTI6HbmfTDxLfi8JTQGnnkQ9gbboMX2mHS
         W/v073idUTtU2P9vne/oZpiiw36mc8Sg2ZVq6SVBGXS0JBE1j23muC/Unsh/oNTBv3uG
         wCAvoZSs/9ypNpJv9F1nDvpnIAf4b+3EofrvRSTmHDYWFIaL/jqXSBFqqT+5Qk+2ZX2F
         ngHiT7V0Ag3H+iOxnE2l5qCVAcjz2Bd4vYvZB8HC/aD2A+Y/Qcf+qjKSsYX4vzxIYAEx
         cNcqqoK3SrVjhgbLBG6EBpTxB5MEBlwgSBX6GAdbJfmUUHa2eJ0RtTrBA8mH7neocLNu
         ke0Q==
X-Gm-Message-State: AOAM531QNTC9I4J+qHepy3xTAojgOzPMVqj4GFf/V2UTSVoW4ouZWAYn
        yhhrlo793U3D7D906T7keuk/NULCLbMx3xEVAcpPqDWnguU=
X-Google-Smtp-Source: ABdhPJyPOkcmgJWvZsFAcstoR6NbQ2CSn5uM0CEJEJ2Jl2GMENTq7esgKBLCkoggULPGFnI/JUQ1REls2EOgalJphL8=
X-Received: by 2002:a25:aa66:: with SMTP id s93mr30770751ybi.260.1623738431940;
 Mon, 14 Jun 2021 23:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
In-Reply-To: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Jun 2021 23:27:01 -0700
Message-ID: <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
Subject: Re: kernel bpf test_progs - vm wrong libc version
To:     "Geyslan G. Bem" <geyslan@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 11, 2021 at 1:23 PM Geyslan G. Bem <geyslan@gmail.com> wrote:
>
> Trying to run vmtest.sh from the bpf-next linux
> tools/testing/selftests/bpf on Arch Linux raises this error:
>
> ./test_progs
> ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found
> (required by ./test_progs)
>
> VM:
> https://libbpf-vmtest.s3-us-west-1.amazonaws.com/x86_64/libbpf-vmtest-rootfs-2020.09.27.tar.zst
>
> [root@(none) /]# strings /usr/lib/libc.so.6 | grep '^GLIBC_2.' | tail
> GLIBC_2.30
> GLIBC_2.5
> GLIBC_2.9
> GLIBC_2.7
> GLIBC_2.6
> GLIBC_2.18
> GLIBC_2.11
> GLIBC_2.16
> GLIBC_2.13
> GLIBC_2.2.6
>
> It would be nice to have
> https://github.com/libbpf/libbpf/blob/master/travis-ci/vmtest/configs/INDEX
> updated to refer to a new image with GLIBC_2.33.
>
> Host settings:
>
> $ strings /usr/lib/libc.so.6 | grep GLIBC_2.33
> GLIBC_2.33
> GLIBC_2.33
>

It seems kind of silly to update our perfectly working image just
because a new version of glibc was released. Is there any way for you
to down-grade glibc or build it in some compatibility mode, etc?
selftests don't really rely on any bleeding-edge features of glibc.

> $ uname -a
> Linux hb 5.12.9-arch1-1 #1 SMP PREEMPT Thu, 03 Jun 2021 11:36:13 +0000
> x86_64 GNU/Linux
>
> $ gcc --version
> gcc (GCC) 11.1.0
>
> $ clang --version
> clang version 13.0.0 (/home/uzu/.cache/yay/llvm-git/llvm-project
> ad381e39a52604ba07e1e027e7bdec1c287d9089)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
>
> P.S.: This issue was started in
> https://github.com/libbpf/libbpf/issues/321 and brought to here.
>
> Thank you.
>
> Regards,
>
> Geyslan G. Bem
