Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9165A1B2F
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 23:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiHYVg2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiHYVg1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 17:36:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3CBC12F9;
        Thu, 25 Aug 2022 14:36:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gb36so41967578ejc.10;
        Thu, 25 Aug 2022 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3AHnMG+3jAegfBoDtUEnVJPMlQVvj/FsI6PElDkS+iI=;
        b=c1EVdPbyQROQgHBvNFT33Cb0Mwn/qhfMMtEtxL0m+sqVgBOcBkkoZhqC2jqYnrbsde
         KoglFX4A2Lc2HI8BIruqK4y3Rg+zwkwRDUevQ/jI5ReRkTuSS6Bab5AzO+axZk+w1aop
         lRTJejVBTsqFOEHeexlrEK02GLeK9bSb7sAW5lQev2CC6NGoLLSHT5gU772UWl+4CEzK
         XEseDgsKcL6oIfiAqHfw7ONHbLbCYsooUqJvo8eu27Mt44XVXiR0/0f/CFepP5nh2b7X
         oqG42UgmJNtivSLV0Kd7bjtUp9IqYDT1bj+nuKM4ni1gwRgiukbpS4d4gpFUg5K2Viem
         ZenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3AHnMG+3jAegfBoDtUEnVJPMlQVvj/FsI6PElDkS+iI=;
        b=CKeTx3w7102aC57WfM8tmpi3/nkrtuUMkxz0yti30WbS/QfJq41Xf7/8aG/i7xKzmZ
         Sr61bm0XXKc5BxUpGXe4WgllL05pjGcZNL1WrTQs5n21qflRYfC8ixhv2X/4yVcsRjER
         uvXNj0Od5X+y6J1hznhn7IWZlMGMbSJVyUPcVNTJHxIxkFgHF4o14ekJ37EqjWVKMOKi
         bkBoO1I37hW/DTwelYNx8mXNIlegUIOERGo3I6zU+Q+oIW+p8zLcB9bte/HjUgIzBIOo
         oeVY4fCpBiXXedJj8MmGkcZY9Gm37snwzM6MhUenksQmWjJI7z0E4JOd0gfcpiyLkYLe
         Migg==
X-Gm-Message-State: ACgBeo2WujniLrgTu+nHHn5JUn/RRMogZIVBCW+wq7S4IliZ7d3vsRwf
        DhHwvk3OLyk2naVoyMciEjJaCif2kb/MGaYMGK4Sb8kQ
X-Google-Smtp-Source: AA6agR6CohKMhzhhQZErZ5uCvFYZaP5GqU6VNFllmnje3gV/BRQZyiwjB7Cy13UqEkvMGSqTup8RREDUEaiuvQiAyCI=
X-Received: by 2002:a17:906:8a43:b0:73d:7cc2:245e with SMTP id
 gx3-20020a1709068a4300b0073d7cc2245emr3657661ejc.114.1661463385435; Thu, 25
 Aug 2022 14:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220825175653.131125-1-alx.manpages@gmail.com> <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
In-Reply-To: <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 14:36:14 -0700
Message-ID: <CAEf4BzbCgHp0MtsSm_ExPO+EGhFWzLUOiFuh1jyrhWfbsDtL3A@mail.gmail.com>
Subject: Re: [PATCH] Fit line in 80 columns
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        bpf <bpf@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
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

On Thu, Aug 25, 2022 at 11:07 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 11:02 AM Alejandro Colomar
> <alx.manpages@gmail.com> wrote:
> >
> > That line is used to generate the bpf-helpers(7) manual page.  It
> > is a no-fill line, since it represents a command, which means that
> > the formatter can't break the line, and instead just runs across
> > the right margin (in most set-ups this means that the pager will
> > break the line).
> >
> > Using <fmt> makes it end exactly at the 80-col right margin, both
> > in the header file, and also in the manual page, and also seems to
> > be a sensible name.
>
> Nack.
>
> We don't follow 80 char limit and are not going to because of man pages.

And it's questionable in general to enforce line length for verbatim
(code) block. It's verbatim for a good reason, it can't be wrapped.
