Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E1533CD09
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 06:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhCPFTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 01:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhCPFSt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 01:18:49 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF20C06174A;
        Mon, 15 Mar 2021 22:18:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p186so35605856ybg.2;
        Mon, 15 Mar 2021 22:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aK9FsRGQPpPMLScSBSRXjzFhEgmVttxBWe1gRYwlMdY=;
        b=bVI7B9IjUXbV/MSDUgERCVQ79Wm2/d6CKUkt8iX1Qfeej78B//eGtojA9bz3CkKHXs
         c7ydyaFKuQuTiP+1YGLwWvYqw9Z+5Nga2eJzxjo9p2KYcVdJvRz7WjBvnWDjtJhSFd8N
         vmtqw3+Y49en50TAlzYclhvGB5QGyLlvPPjzqKQvzgKbHeGyBCaxRgLFsO1yhh7wa/U3
         vWhoPAlOH7COxPH+Xdw1wsSpOakpfbQscoe8+JueipKKC8wk7GBMGw9ysVDqU4PPrE93
         R2d1WQ75E0aXHCPLPy9cf2nwo4x8s6ltPD59xX/UKcm7KH8xGPeGm5ki5m9Fim6EP8d2
         E/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aK9FsRGQPpPMLScSBSRXjzFhEgmVttxBWe1gRYwlMdY=;
        b=k7btG/gBxZEQaXS99Q4seYUW73lKO1J5+uSoao11A0ZXzvUBZW7FZXDoLyZscO14lV
         cx6eL+XITOFikLsDr2HhVOXyOR3m0OVHa0xtF6hrVghfgBuE1UEoXOl7GCnnhd1T4qk4
         QFZYY+4aY1Sq+oVt6PmA095Ebd4ES7mGglVhS5lUOGPm2HrgfwCC+jKIR3gX8/3W0dGs
         1Pfq7Fob0yYlbqtr9QBPhwXhy+jL3FlVhfmnMeh+ryV3DPmg+i4Bsq5+ilCLyo2MTlck
         3gyk2dgH6mkiE6dXeYHqDFFbPM1qEkPdHtaC8cc8g256TPzQYASCctDk6HUbo9oMmff0
         61kQ==
X-Gm-Message-State: AOAM5337U0jEdLUKESJik+8BjXGaEYFE/I13jP304NwhgHscITBKs8fN
        n2WWLh5GWKuOWNA3dDcFCw09ORW6A1M9GVCf+LE=
X-Google-Smtp-Source: ABdhPJwMJr9lrktrNDgg4MvRF0E10MHF7/1owaS5TPaECbJ32j5ybO0SKSmWTkkFD2K7tuNeTleCmPoGZvilJ46UVMQ=
X-Received: by 2002:a25:40d8:: with SMTP id n207mr4444934yba.459.1615871928961;
 Mon, 15 Mar 2021 22:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210315124454.1744594-1-standby24x7@gmail.com>
In-Reply-To: <20210315124454.1744594-1-standby24x7@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Mar 2021 22:18:38 -0700
Message-ID: <CAEf4BzZ6BGz68jAnGL0fGAmN1=fbKB3rKdXDUpD-ETSL2abV3Q@mail.gmail.com>
Subject: Re: [PATCH] samples: bpf: Fix a spelling typo in do_hbm_test.sh
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 15, 2021 at 5:45 AM Masanari Iida <standby24x7@gmail.com> wrote:
>
> This patch fixes a spelling typo in do_hbm_test.sh
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---

Thanks, applied to bpf-next. For the future patches, please use [PATCH
bpf-next] subject prefix if you are sending patches against bpf-next
tree (of [PATCH bpf], if it's against bpf tree).

>  samples/bpf/do_hbm_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/samples/bpf/do_hbm_test.sh b/samples/bpf/do_hbm_test.sh
> index 21790ea5c460..38e4599350db 100755
> --- a/samples/bpf/do_hbm_test.sh
> +++ b/samples/bpf/do_hbm_test.sh
> @@ -10,7 +10,7 @@
>  Usage() {
>    echo "Script for testing HBM (Host Bandwidth Manager) framework."
>    echo "It creates a cgroup to use for testing and load a BPF program to limit"
> -  echo "egress or ingress bandwidht. It then uses iperf3 or netperf to create"
> +  echo "egress or ingress bandwidth. It then uses iperf3 or netperf to create"
>    echo "loads. The output is the goodput in Mbps (unless -D was used)."
>    echo ""
>    echo "USAGE: $name [out] [-b=<prog>|--bpf=<prog>] [-c=<cc>|--cc=<cc>]"
> --
> 2.25.0
>
