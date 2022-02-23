Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD464C0C3B
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 06:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiBWFi5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 00:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiBWFi4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 00:38:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D214EF45
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 21:38:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B902B81E79
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 05:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B013EC340F1
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 05:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645594706;
        bh=j1UHD1iBqyuUCEmqJS8KgDmwadtFOAKs8V7aUgCm3RM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XKEEfClVQWffiH86niB+0yDbNLydNbE2TmbkDyGI6vqte8+2BhtpijLCMRdnClJaE
         il5fO0dR8GNSymA+IiuFrOAvjHKWLOVuhcxiQjd8ZM45GIrQ1GgldycPowHNYJ1hO4
         iEDufrmGth/m5fMQOr9DuH3zoeYN6iOrL7TTPaoy1odWTPYYpf3omT+kjAD+Ik6WbD
         B58ZXsaIrvVAncs9ikcIQsnVtr3H14kytGV8vvq+7Fm+eqzsdK3rNGwHD2dIbn5RY+
         DKdx1sdF6cKCn938UfNPyONO25BsCzBQRrMTrkbJhiQBk/t0UghtiPvwqxDIfVGglJ
         VUV9kgyfxVdIQ==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2d07ae0b1c0so198555047b3.2
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 21:38:26 -0800 (PST)
X-Gm-Message-State: AOAM531VvOcSeRyXxCZEXodAVAXvtDR6pXXW9KcDhazwwJpLe6wD2TiM
        xzT3qtVQ/wGLCbSnVphksogPXcOb0otBl54uXCE=
X-Google-Smtp-Source: ABdhPJwS7xHYPmdbccGTEynDgQG2vNC7aov1tLO5z0+eqb8yclQ4i0lqyNmMtLuCOPLKLvrlC+WUPGoVpKpxG6m7JrE=
X-Received: by 2002:a0d:fb45:0:b0:2d0:d09a:576c with SMTP id
 l66-20020a0dfb45000000b002d0d09a576cmr27934176ywf.447.1645594705742; Tue, 22
 Feb 2022 21:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20220222074524.1027060-1-xukuohai@huawei.com> <20220222074524.1027060-2-xukuohai@huawei.com>
In-Reply-To: <20220222074524.1027060-2-xukuohai@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 22 Feb 2022 21:38:14 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5vNLo13r42Foh+U92Qx8WkiJqq115+JPWr-9=SOgWKLw@mail.gmail.com>
Message-ID: <CAPhsuW5vNLo13r42Foh+U92Qx8WkiJqq115+JPWr-9=SOgWKLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Skip BTF_KIND_FWD when counting
 duplicated type names
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 21, 2022 at 11:41 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> If a FWD appears in the BTF before a STRUCT with the same name, the
> STRUCT is dumped with a conflicted name:
>
>     $ bpftool btf dump file vmlinux format raw | grep "'unix_sock'"
>     [81287] FWD 'unix_sock' fwd_kind=struct
>     [89336] STRUCT 'unix_sock' size=1024 vlen=14
>
>     $ bpftool btf dump file vmlinux format c | grep "struct unix_sock"
>     struct unix_sock;
>     struct unix_sock___2 {      <--- conflict, the "___2" is unexpected
>                     struct unix_sock___2 *unix_sk;
>
> Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Acked-by: Song Liu <songliubraving@fb.com>
