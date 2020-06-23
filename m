Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687EC2049E1
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgFWG1o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 02:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbgFWG1o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 02:27:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF471C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 23:27:43 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so14208666qkc.6
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 23:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x8Acjt9hVyv7g76Rk337tx1a0xfF34h/1M5zu0zPcW4=;
        b=OAWuJXIMCA+f+o9dEIcOLwZqQy4tAx7hZzni370NOPElo+iJvof0iaxWUICNY4hzFt
         gUyHC+Db47WGpT2qi38h4tdkbD86IC+QXSIhaehVhQMWUKED97/1Uh5LFcrl1G9D8FmB
         HofNyAfjEPt039Rwi9P0xBoqrnYZtdiU4ClwtujDhi2YyX+C+4wAOlgl2f0ehwa0MJAT
         tFJsa4w8e55FsVqFqIkdYFh69+ZUe67P/WTZOicHFJnXYN7+C4Re6TrCLZ/OrQPJiZOT
         AJ77WKaAtfp/iZdxUski1VfgGiu1QImtCBzXVBqTOGuZ+MbE/eKIYQKeXzNXVKXzEGYo
         HBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x8Acjt9hVyv7g76Rk337tx1a0xfF34h/1M5zu0zPcW4=;
        b=LQhVHoPzPFUMcx22fgOz5sRdP4tE9J1eTNsywKZ+sWgLHefFkEo2KzDwU3y/Pgku2n
         1iRZagpObCD42TnOZDLmvJBIcjHpdXpBRkZJJFDFyt6/uupYz/xqik2hMNiwupG56Tiq
         ccb/o/B0J7iVO2RrEjAAXJH3H0Zeh8G5QDgxvx3VrkvyIVIELyaXwXu9Bz4lUGn65JMN
         1FXQNij4XSaXYtsAsRkDGwKzm2o7Xw+Ao3Bsqb0iTov1j0I8RPDegnP/stQwIGE0lHe2
         LBrqu6lB7AHJq4IipTdzyM7W9g+36nrt6xjX+XwSq+5jnBRVjvQPsy7TrBRz9fLjnkTB
         kvqg==
X-Gm-Message-State: AOAM530UZPQarV97kJ4G4WlNj2ypPG6eRp3WzgdVUjKy6nzoTx3WvJS8
        JoC29jQXsTSe6icbG0S1jAp+/RRhTUiXrHcRsEI=
X-Google-Smtp-Source: ABdhPJyQZRY6dB5yMSqbupcj/VJTTeDqS23uGemtzrpi0OUrZu3QgmeFW2VOQfs/JPATJNJjFtKU/xg4olfkkJMvlh0=
X-Received: by 2002:a37:8d82:: with SMTP id p124mr4921067qkd.488.1592893663241;
 Mon, 22 Jun 2020 23:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200622090824.41cff8a3@hermes.lan>
In-Reply-To: <20200622090824.41cff8a3@hermes.lan>
From:   Yahui Chen <goodluckwillcomesoon@gmail.com>
Date:   Tue, 23 Jun 2020 14:27:30 +0800
Message-ID: <CAPydje_wetJEwWKqFEVgOjh=huJ9+_kEHd_6R77vouV15L-grw@mail.gmail.com>
Subject: Re: Fw: [Bug 208275] New: kernel hang occasionally while running the
 sample of xdpsock
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Bjorn, Thx for your response.
I can not get it exactly. Could you describe the details more clearly?
Thx.

Stephen Hemminger <stephen@networkplumber.org> =E4=BA=8E2020=E5=B9=B46=E6=
=9C=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:08=E5=86=99=E9=81=
=93=EF=BC=9A

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
