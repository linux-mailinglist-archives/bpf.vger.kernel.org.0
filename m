Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BDF203E44
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgFVRrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 13:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVRrL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 13:47:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADCFC061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:47:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so17571384wrr.10
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iNkIMe5O7FcZq6fSfWxYQiTobzuRcKG0L4oaE8J54Ww=;
        b=AB5GBRe8x3qy3H7XuftJsJSiLiCGAqq0u64OtisbOOYiPBJ9PMzHLXvePRRYXCtxqf
         E5CutnIkQV4xIqCTl8Ex65R/I0Fl6k63rWNgwX/tcKexxaJBu/6z5Z1/X9MPn85nnWSk
         VxiuLrCbORVdCiZb5CVJ4pUK68XYAOKWlFFFqQdBiYIU6dKkRW9oXBLtUAs7XXEcR8yE
         6zJ5+JTZvn9rv2PRv2aVj8uJDLBf1RdKcQAIvU9NgkxKl626menX2RDksclXWj3hEfvr
         0opGc1a1Eqgdm3K03jmj//DnczJaeJWOY8WD6nRQTjfc94c2kLI0DzbfIgoIuZce+lNo
         rVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iNkIMe5O7FcZq6fSfWxYQiTobzuRcKG0L4oaE8J54Ww=;
        b=Jm2d9Eiyfj6trn00z6h35i4zrccHIkpfsBETajf2PT1uxcQYBEEBaOnFyfCDI7DM/U
         cjT6ZkGgaR4lRmRMynC4v0RztlM1u92UjwD0aSHoQqy+M3aBtxFCuYn1Letd4qdpPtPg
         7G0LQw4Ww/PVFus/d01ioxv/QaIq0pGcnf9OVYeENMfsh1yDdZEUfRrJu5II+ynhXS3w
         skhSyd77kJQZliWbu36V9E3FVB75Ui9e2J5UAJlEdw1yRFuRj3GhZsMRF9Talzga/BMm
         ZAoOKoz8cjjO/bnRmpy5A4NwrRgvUUxs/vejF35tmZjTLfBjxdUF4dDK5UPJIFxZ6PNf
         W3Lg==
X-Gm-Message-State: AOAM531ZekRUC4Zj4FcFSutJWUpFas/IIjO/qPvg9UP6EgwyuWDUM0HL
        0eFyk47X3ZmFwgd1E4Mg9sS7suM+A1c63wyI6YU=
X-Google-Smtp-Source: ABdhPJwc/wgrt0Aemr6DWrIQBMqhZ1p8cmyixp7e+i63SkMKHniABSRhzJRfjwPcnmwyHTS2w1I+hWOx5apD/d8iknM=
X-Received: by 2002:adf:ec90:: with SMTP id z16mr20086896wrn.52.1592848029604;
 Mon, 22 Jun 2020 10:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200622090824.41cff8a3@hermes.lan>
In-Reply-To: <20200622090824.41cff8a3@hermes.lan>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Mon, 22 Jun 2020 19:46:58 +0200
Message-ID: <CAJ+HfNhhpZoeoZC5gS93Lbc5GvDUO9m0RrKNFU=kU0v+AXe=ig@mail.gmail.com>
Subject: Re: Fw: [Bug 208275] New: kernel hang occasionally while running the
 sample of xdpsock
To:     Stephen Hemminger <stephen@networkplumber.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 22 Jun 2020 at 18:08, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
>
>
> Begin forwarded message:
>
> Date: Mon, 22 Jun 2020 10:13:52 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 208275] New: kernel hang occasionally while running the sam=
ple of xdpsock
>

Thanks for forwarding, Stephen.

I'll have a look!


Bj=C3=B6rn

>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D208275
>
>             Bug ID: 208275
>            Summary: kernel hang occasionally while running the sample of
>                     xdpsock
>            Product: Networking
>            Version: 2.5
>     Kernel Version: 5.7.0
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: goodluckwillcomesoon@gmail.com
>         Regression: No
>
> Distribution:
> 5.7.0-1.el7.centos.x86_64
>
> Hardware Environment:
> Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.1.7 06/16/2016
>
> Software Environment:
>
>
> Problem Description:
> kernel hang occasionally while running the sample of xdpsock
>
> Steps to reproduce:
>
> I want to test the rx performace of AF_XDP. I change the nic to 4 queues =
by cmd
> `ethtool -L p6p1 combined 4`, then I will create 1 socket for every queue=
.
>
> for ((i=3D0; i<4; i++));
> do
> ./xdpsock -r -z -i p6p1 -m -q $i &
> done
>
> I run the xdpsock in samples/bpf using the shell command above.
> And occasionally the kernel hang, so I have to power off and on.
>
> Additonal information:
>
> --
> You are receiving this mail because:
> You are the assignee for the bug.
