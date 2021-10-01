Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA83041F717
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355005AbhJAVtH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 17:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232171AbhJAVtG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 17:49:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF30961A05
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 21:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633124841;
        bh=K15d2htnQQRQGjSh1KETNXGrI6qWCe4RIy/ofj0rvFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pl7Bh6SbauOYHQHTtCVn08y5cKd/NTs81T/kdX0b5uznQurLwBb5XQ+IeV0Tkkrmn
         a1/rtkLoQfHDS+7ioJX4EzVnxiDkvtHbcC82kYV8BK7jkICWdSNBNpT18VWp6jzTGl
         /ktMKBaDYkCPf8hi5zZP4C5VUFdBi+/3McR1x4UyDwKnOhGhWVKPwflI5Wxbkmvt1W
         GSgUwMoq81FshwBQiH3jmMXh+FSbc6Txg73YQ78PDv2vXL7ZsynMsURPMdLxYQLqr/
         8Z06oB/gbMVieHvOUFVjF3kfQrgEH8UmUdDE3eJiy5IxWxB3URUR15hLMzxqjnEVDH
         zetXca+bj6cQQ==
Received: by mail-lf1-f42.google.com with SMTP id i25so43748737lfg.6
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 14:47:21 -0700 (PDT)
X-Gm-Message-State: AOAM533u2gUnmIRcMKLWuB8PBQB5HNscarerPenLxwReVe6PbisvHx2v
        4Z5l+Gg0O//2DvzLrnkfFTBVe7L9XjI2j+Ov7Uw=
X-Google-Smtp-Source: ABdhPJzJtB3ipPnC4kLyUHDhkTd9/lZ0YzwbjDxV9lloxrVPznT2/i+4ojmIh5hqpCVie1sVhz/DdNKHUzCQpQiSYrg=
X-Received: by 2002:ac2:5582:: with SMTP id v2mr361410lfg.143.1633124839988;
 Fri, 01 Oct 2021 14:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 1 Oct 2021 14:47:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6LjB2-OaeHtePeM_v16oSOw5+3uJuUVNKqY6XEKjyg0A@mail.gmail.com>
Message-ID: <CAPhsuW6LjB2-OaeHtePeM_v16oSOw5+3uJuUVNKqY6XEKjyg0A@mail.gmail.com>
Subject: Re: [PATCH 3/9] powerpc/bpf: Remove unused SEEN_STACK
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        bpf <bpf@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 1, 2021 at 2:16 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>
> SEEN_STACK is unused on PowerPC. Remove it. Also, have
> SEEN_TAILCALL use 0x40000000.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  arch/powerpc/net/bpf_jit.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 7e9b978b768ed9..89bd744c2bffd4 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -125,8 +125,7 @@
>  #define COND_LE                (CR0_GT | COND_CMP_FALSE)
>
>  #define SEEN_FUNC      0x20000000 /* might call external helpers */
> -#define SEEN_STACK     0x40000000 /* uses BPF stack */
> -#define SEEN_TAILCALL  0x80000000 /* uses tail calls */
> +#define SEEN_TAILCALL  0x40000000 /* uses tail calls */
>
>  #define SEEN_VREG_MASK 0x1ff80000 /* Volatile registers r3-r12 */
>  #define SEEN_NVREG_MASK        0x0003ffff /* Non volatile registers r14-r31 */
> --
> 2.33.0
>
