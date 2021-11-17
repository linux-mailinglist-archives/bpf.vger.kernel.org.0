Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96496453F61
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 05:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhKQET3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 23:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhKQET3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 23:19:29 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61440C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:16:31 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e71so3333716ybh.10
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01IZMrDXr/PrLZGafRfry4varVbWB/PhP+V1/tPfmHw=;
        b=Xk9c+oLyq6c/tsoN7zUCQzDkEpZMlwjeiNQ38+qCcjvkOolhozkIFuXQJqBJ2inNgS
         Y4q3wbCaMIY5/Syrxiobu/NSR3igLesepDnU5vOmGL3md2Z7CtID/ghb7E/5/Wm2kA1l
         g2lSUBS9BGCsWtviLhW+P0ExXHnLhSe0g6rs1wR8LjLCDUq+i2QOdHTV8oge84K/mltt
         sPyYXZ1+eBtcNT1uf0hKxk7gvgWyb3+QrrAjK41Ucz10ugGi23dqlNZNVkLwQovvUHZa
         9Zb0vOacOLxi1pThn+sxZ0zUKm4j/S1uQ3XETwggUkudPk38/BE9mhYxlH50SO9OEYCh
         7BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01IZMrDXr/PrLZGafRfry4varVbWB/PhP+V1/tPfmHw=;
        b=cjLSmdTlORdoV59IBxNXTW6fgK8lubL1bv685AvNx65K6s12MCh4AA02i6Lipjo5zh
         +ay3TPdo+vdp/LvGQh8Mk1Kek3/ha54bY36bDulx3+MSqBpOKbiojgIT7dtIZ4F0WUgV
         H4h88nzTbWfu+rUIE+HdTxgPQ/cON+4I8A8ctV93Ok7egCIDs91g5vaHWumiX7StmiMv
         V3fm4sB+kHoC0f12mpidq6Lpi3JFmFhDQay0WaWUF7IhQ4hbYV68u7I6Hmccwa1p1TUI
         aRTqFnKDNcB0SCi1Fr9MhfwIBY2/C/oGsZXP3ncifOc8fTsXAKjCjFWcKxztsD+lOBfY
         kVpw==
X-Gm-Message-State: AOAM5328FKuLxyDKH+ftOUEdFU2AyvH3nJIl6Q0Yi/tWAewgfyJ7C1F8
        rvfWuM4gVJM6SxhSRG/CMWQbxFvA/rbST6HqGiY=
X-Google-Smtp-Source: ABdhPJwukuOJlhPEHJ/nSAsgOxZpYl2QOIMl3isP9Sx+06t9y7P2vOAqvZVt/TM+hYiUjfKzoUzmOnaEeg/faNtFG70=
X-Received: by 2002:a25:d187:: with SMTP id i129mr14133977ybg.2.1637122590701;
 Tue, 16 Nov 2021 20:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-12-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-12-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 20:16:20 -0800
Message-ID: <CAEf4BzbOR4Ge6NdnEB0rQSmUyxB85cna0jB7Nnt7hKWJYevk3g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 11/12] selftests/bpf: Convert map_ptr_kern
 test to use light skeleton.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 9:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> To exercise CO-RE in the kernel further convert map_ptr_kern
> test to light skeleton.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

We have plenty of CO-RE tests for libbpf mode, so it's fine to convert this one.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile             |  2 +-
>  tools/testing/selftests/bpf/prog_tests/map_ptr.c | 16 +++++++---------
>  2 files changed, 8 insertions(+), 10 deletions(-)
>

[...]
