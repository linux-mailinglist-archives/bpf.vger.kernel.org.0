Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6565F5295DB
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 02:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiEQAJN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiEQAJK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 20:09:10 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF374B4A7
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:09:05 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e3so17729472ios.6
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JImfElIWZxZOXRMum8HqBW0jBEAyGi0XmMKLkRmX4EE=;
        b=dmEZvBQQxtJq2QTS3wGY933dJTQp1hftL3np2PkdOeNE7LtIoQiP8/+b4m+og0Enax
         +KCbMDR0uCcb5yh7fmGlHYz6NmPlto98qlpJHW7hJmZa5OOeLHp6jXnXQS5VvHP9+clG
         KZXy6L6srHCE4F+kjuUdnCclAM1Sx/bT2cUZmpvdMnzZBdWudxyLj51rVO3CrP0qgiuH
         IvWpqAZZVkpt11c1v28yw1Gwlqo1d45e1JeGH+fdKrhUnKopPJT8DRIstZoVNOGvJOx4
         jMScTUkL+RhQMAz9xGF0XlogZ9vfPj/MrkC34zZgZj3rvLcaG847vcrLDrZ7axbM8RI8
         JB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JImfElIWZxZOXRMum8HqBW0jBEAyGi0XmMKLkRmX4EE=;
        b=WkI7iwoRjKSBsYMywPgeTJ+EKwofTDpnDldg649X0r3mIn9CEKu47uliB5S4ahLe4b
         jOsX2cG9RqMD0CLloflN7K6e9bJRbCmOKUGBZlo03S198AUy5f4Br6mlJLG5wclp2euO
         fGq4DghlQx7sPTLy4XiR0dCdeU+t0xla/IzBm7z7OHo1b4YyHn8qRXJZdabtW59EoACc
         V10j9QKAFb/j4GXn37PQTZUCwUBgrN1s9fj6fSGE2qgAzApm/FYXs1e6JQB+1Tqmtzrz
         JRup6LyZDriSjzAEVihUlqwMsREADSAoH1z6j9Y14xVMD6hQB1aSldO5BJULApxWJepA
         c2xQ==
X-Gm-Message-State: AOAM533J7yDC1Dv6p+NE9hEuXwgpgd2WkrRzS2LORFCJMwh4NheGploD
        mY+9eBvJDRN0YKG2ohBz0nJqdPTXrCrcG5kThSQ=
X-Google-Smtp-Source: ABdhPJxwz3D4+3BaPeAY8+p7obljpZipbyxiwrK0WxjAVREyl+xU/1ZCpaCgePwUCS00NbTb69Lw2BfKoZfrUqnUx2g=
X-Received: by 2002:a05:6602:1695:b0:65d:cbd3:eed0 with SMTP id
 s21-20020a056602169500b0065dcbd3eed0mr8950215iow.144.1652746145219; Mon, 16
 May 2022 17:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031232.3241300-1-yhs@fb.com>
In-Reply-To: <20220514031232.3241300-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 17:08:54 -0700
Message-ID: <CAEf4BzYgODLe4Vkc0yx4zUjATQ6RvmRyeCmKs=1Pi=PRxfo4zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/18] libbpf: Permit 64bit relocation value
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 8:12 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, the libbpf limits the relocation value to be 32bit
> since all current relocations have such a limit. But with
> BTF_KIND_ENUM64 support, the enum value could be 64bit.
> So let us permit 64bit relocation value in libbpf.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/relo_core.c | 49 +++++++++++++++++++++------------------
>  tools/lib/bpf/relo_core.h |  4 ++--
>  2 files changed, 29 insertions(+), 24 deletions(-)
>

[...]
