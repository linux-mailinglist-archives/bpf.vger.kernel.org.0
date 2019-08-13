Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3878C1B2
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2019 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfHMTxk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Aug 2019 15:53:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45856 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfHMTxk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 15:53:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id k13so10349214qtm.12
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwKP6h3wqQTUJUVhxAtcIxrVHzgswBcFAWmrRP3kEto=;
        b=lzD+asSEt8bXciZ3oKYdGwJH/uQIe4zoLWBlebat72C+UWpbcBXBEp7KTiUO9k60G2
         hdWVx4msZXg68ijOUeXyQL9ySThblrHgGQO/L7gfTnktsXonOy1hbMh3vJPTnwp6I1jv
         8zsOTV+erSvBZl9Aaihx/NLtoxrQpc+dSBozsmgO89+5u2QVc95YSOJEIPHHLCOC2XUM
         5qLNMfO8O2ThjBoVLRIP8JaYHMAcP25uNXSK942H5XEw3MKMb6UwPgHC8++vVZWd0Otm
         EJmqhK3a5KYjwlDxQYx+5i240ZAUZMthdF/cN4RzOl2DHkvXXM3Lo3FJiz1HycnRytS6
         lVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwKP6h3wqQTUJUVhxAtcIxrVHzgswBcFAWmrRP3kEto=;
        b=IjVCc94GmsHqG1+yBNC+rSzJlaOsuS2Obn43BGAtB+C5RIZaNf0LuaSF2oNexSBZG+
         2xYjbZSNIJ4TqcH2bPRH0hnxlYNyLEXtiTi9dp36Z1v8anvIlHCAuiDrLw3G8LErVM6F
         lne7UEu7erLDuj0aYOT6w8MZfeqiv8sStrXYFra73hR/vu1NA0KlUdoxzPtI62J7LHsz
         Zm+U0XXvcj+E9I/OeJpvkanzaZD8yQezVDcqn6HJ8yJirxSZD9qfNbr3qHBbYBvtebAK
         is2OHDg2zllXpitb64OywGVwx67zPZGzUuq+vwSQJTVbmJ6sk79ejCH6oLKY6gLyVrpT
         3/7w==
X-Gm-Message-State: APjAAAX0FSzi2siri/dz0M9cdpERnrXcxVFmVm2K2mx4tcuk8B0t5t7r
        RA7+CqxmSEOx7rWFkWfbz4PNbo+ber5Wmt/HhMg=
X-Google-Smtp-Source: APXvYqyvu0B8e/lrrt9OcfhRpdXv/soZ7mxvJ9q7DHqlbdD4MzCkBBLi3MpxP1E1jE0aI6qTBaW4wTXaRcnKFp3OtBI=
X-Received: by 2002:aed:26c2:: with SMTP id q60mr29589038qtd.59.1565726018963;
 Tue, 13 Aug 2019 12:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190813162118.17957-1-iii@linux.ibm.com>
In-Reply-To: <20190813162118.17957-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Aug 2019 12:53:28 -0700
Message-ID: <CAEf4BzaVOC3Sx_XkDPiv=b4xq7ieXE1Vh9iqGqbWy_Wb2+b4Ag@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix "bind{4,6} deny specific IP &
 port" on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 13, 2019 at 9:22 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> "bind4 allow specific IP & port" and "bind6 deny specific IP & port"
> fail on s390 because of endianness issue: the 4 IP address bytes are
> loaded as a word and compared with a constant, but the value of this
> constant should be different on big- and little- endian machines, which
> is not the case right now.
>
> Use __constant_ntohl to generate proper value based on machine
> endianness.
>
> Fixes: 1d436885b23b ("selftests/bpf: Selftest for sys_bind post-hooks.")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/test_sock.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
> index fb679ac3d4b0..5c092a85125f 100644
> --- a/tools/testing/selftests/bpf/test_sock.c
> +++ b/tools/testing/selftests/bpf/test_sock.c
> @@ -8,6 +8,7 @@
>  #include <sys/types.h>
>  #include <sys/socket.h>
>
> +#include <asm/byteorder.h>

Maybe use bpf_endian.h and bpf_ntohl instead, sticking to BPF stuff
already used by other tests?

>  #include <linux/filter.h>
>
>  #include <bpf/bpf.h>
> @@ -232,7 +233,8 @@ static struct sock_test tests[] = {
>                         /* if (ip == expected && port == expected) */
>                         BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
>                                     offsetof(struct bpf_sock, src_ip6[3])),
> -                       BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x01000000, 4),
> +                       BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
> +                                   __constant_ntohl(0x00000001), 4),
>                         BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
>                                     offsetof(struct bpf_sock, src_port)),
>                         BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x2001, 2),
> @@ -261,7 +263,8 @@ static struct sock_test tests[] = {
>                         /* if (ip == expected && port == expected) */
>                         BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
>                                     offsetof(struct bpf_sock, src_ip4)),
> -                       BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x0100007F, 4),
> +                       BPF_JMP_IMM(BPF_JNE, BPF_REG_7,
> +                                   __constant_ntohl(0x7F000001), 4),
>                         BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
>                                     offsetof(struct bpf_sock, src_port)),
>                         BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0x1002, 2),
> --
> 2.21.0
>
