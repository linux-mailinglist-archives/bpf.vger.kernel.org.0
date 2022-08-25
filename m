Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0171F5A1856
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbiHYSHK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 14:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiHYSHI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 14:07:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6D0BD102;
        Thu, 25 Aug 2022 11:07:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v14so4550406ejf.9;
        Thu, 25 Aug 2022 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PbnNsoOGBtV1fJn01TE08zIsKcL4sGhm/016ARM/Ov8=;
        b=nfJeuSNwIXF3pmbGxgAOHsBaeTxt0ZUa1DcBfx8ODJGzDhw8npM0OXCapx8o3UGGEB
         3NV2YZrKQuqyivIRo/RwORXt1Mm/ptnE7JKxzCg5QvpcdkVXjSZSn7LDvu69cGsN8aHI
         87b+aS6kazCpsWeg1B3XBJtX3KLQN/PH/NisxQQkT2iEQUNeg3KUObC9XEDtFsprEwfw
         xsBHpBVKuOU6HvHikwky+D0AUkdvXSSlsMujC1rpSjcno0ES1JAlmEpRF51/+wv8lnqp
         dZJOk81HKuQWH4soiLYdYDGpIQ1kGAC7OVA0jLbMcjefbR28ad8Mvt1Q3ZwwJ/0Ly7Ea
         m/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PbnNsoOGBtV1fJn01TE08zIsKcL4sGhm/016ARM/Ov8=;
        b=b6vbDD8DMXvrWLXJX+CgwuhviftbH5AF/gMvGDfqYwoPGgTNbUDyw751NvGIBEDeBy
         rH71MzA049aQwo9sKZpOqbtYS7wXGEi8VW2z1PgkSnSph2zc84sKTFVCCGUdugSOpEnD
         DHeBtEXskrdHBmUfHjuHYyuTGyCWIr03bsy+xP7cvPQ+ryDRJ2uBGw6H2GbOhvp6rsqn
         dIm1dOHQG7JmU/lzT5UOuDkyKlCvrGXGbzKSfRJ9kwNOK/9nuLyHHkFkPafHcWEsBvel
         o/Pu7ixRqowoDvR65OMaqKNhFe/N0vkp+uwvnb8TXXw7OniiosLGhJMzh7ad1+K/VdOu
         HFkA==
X-Gm-Message-State: ACgBeo0cfU1hNJ4WUM82lMD0msLI2LJSGdbZlBfWGabWWxLDLxh3RAd2
        Gdctht0PSBjhGy9n17hamOA1FgcD7Ybi4YrNqcc=
X-Google-Smtp-Source: AA6agR5OR/v+eQxDiw3/CIqWoeZPpihWB0x921WI3aYOrAX4sTG94Py08W12Ft3EU1CdzLoaCWfo6SJELKwJjU3mvWE=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr3301224ejc.676.1661450826646; Thu, 25
 Aug 2022 11:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220825175653.131125-1-alx.manpages@gmail.com>
In-Reply-To: <20220825175653.131125-1-alx.manpages@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Aug 2022 11:06:55 -0700
Message-ID: <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
Subject: Re: [PATCH] Fit line in 80 columns
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Thu, Aug 25, 2022 at 11:02 AM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> That line is used to generate the bpf-helpers(7) manual page.  It
> is a no-fill line, since it represents a command, which means that
> the formatter can't break the line, and instead just runs across
> the right margin (in most set-ups this means that the pager will
> break the line).
>
> Using <fmt> makes it end exactly at the 80-col right margin, both
> in the header file, and also in the manual page, and also seems to
> be a sensible name.

Nack.

We don't follow 80 char limit and are not going to because of man pages.
