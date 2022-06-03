Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6949153D349
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 23:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346915AbiFCVpG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 17:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiFCVpB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 17:45:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25650447
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 14:45:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m25so6440289lji.11
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEWfbu38SiCe5ncDAGxfC4saLVA5etWJTy3+Lo03qN4=;
        b=nxr+wBNuoreiv0seqpCOvVsa5PJa/q2Zh31eESWWOnmiBQmNK3deh5eQUkqu3ALH4A
         aN03TGwwhIEljprKfvRlYMIOFHMk8CKfC8nVrX6atifGu6rQkNmVJaI9E/kZHCwxvOXP
         lAyyX+n7k/m1wWFtwNmE7s68GuFFAfnczfgbQn4CjyW4kngn0SZP3Gw5628/ST63pAnh
         j0Xnp1PGSyvW5vUFKvfGnw2/J5maYGtQbzVLLWziFLZjGAyH2hw5Ysm2nG8hCh2KhQUa
         +Fw9bRIr7pZEHkHW5hruMyzcIJEk8lWD/SHMIM/MzTvlXE6eOvISLIzm2YM5kXRIrUBm
         Aj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEWfbu38SiCe5ncDAGxfC4saLVA5etWJTy3+Lo03qN4=;
        b=HlozKyjqbMXpncbCtZZviVGzKcGbmmq2dsrVXa+KJvGwbmP1ZVs5blevFkuenuti/r
         qxCRmuaU4Or7jpvVpAusvTJw13o5hknYttmtyhPGPYrY4e+/h+hnk8RrnP8mna9wgJks
         0Jd8w8fecblUicvHe2i6JYB9ASBCPGQSYLPWEluIBSaOy+IuwpswsSEUDnllwGTV9Wf3
         W8LtQhUZpSSwMMdwWEtdg0O+0k3+d5u8oU4373khtBVL/JoKxkeAn+RT+zUcsY1Pkr/x
         r/gr6d7S233u77G6yFNsOcRw2C9hDhapsxziEiZsF1uO0nZVsIv76GhAbuEKY0NNQf96
         kLBg==
X-Gm-Message-State: AOAM530yHAdRgY4DpHJUpa1z/cpDTYLFiIJcNU1mEjt4EM1O8XyU8ZRo
        YVfzPmWR7Ib2iNofG6CUdZzjFfx6mZ2BTFgMpkE=
X-Google-Smtp-Source: ABdhPJxouQ/er0BuajqOcG6Ka863bZUjWva9Dg9aQY7QYCKjnVABnVr2SeL0a8Rb4zA34nCIBARH8OaYzVh6oS5/C4M=
X-Received: by 2002:a2e:bd13:0:b0:246:1ff8:6da1 with SMTP id
 n19-20020a2ebd13000000b002461ff86da1mr45027139ljq.219.1654292698974; Fri, 03
 Jun 2022 14:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220603015855.1187538-1-yhs@fb.com> <20220603015926.1190572-1-yhs@fb.com>
In-Reply-To: <20220603015926.1190572-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Jun 2022 14:44:47 -0700
Message-ID: <CAEf4BzbsraTLh43uypkeUHT58sAOi2Gf8Nq5_ZZnodJLxO_+9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/18] libbpf: Add enum64 deduplication support
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

On Thu, Jun 2, 2022 at 6:59 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add enum64 deduplication support. BTF_KIND_ENUM64 handling
> is very similar to BTF_KIND_ENUM.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/btf.c | 62 +++++++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.h |  5 ++++
>  2 files changed, 65 insertions(+), 2 deletions(-)
>

[...]
