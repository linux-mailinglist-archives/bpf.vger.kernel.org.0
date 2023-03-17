Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932466BF626
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 00:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCQXUL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 19:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCQXUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 19:20:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9800399C1;
        Fri, 17 Mar 2023 16:20:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so26122941ede.8;
        Fri, 17 Mar 2023 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679095204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyVTmbTVSjXbyxvFuyac08iu7oVxn+bhU8z80CY/FHY=;
        b=P+GzctP8nFk1SD1AfjJSjbb6wLkTlq5AZxMIu7VU/BbcCd3bYVrFkhcy1lfjqpDJDb
         0q4NOig2WlyVYfC1qpoNb/GANDT5YvnPodcIWEsEHDl7O74YS72LbGCBLxDu2/fSC7Gu
         C5d5+T9S2WaSUrvYthsKb6cY6aUXKJXZCe6/JTG+8Yi0gQ2BhxMuq7934mBEZhK7TQl4
         Tge/JpxeAKXj6MVw8izxAnNE7w97hTZiPNTHqURU1kqrJHyhvHW3lkcNaFq+aeQSyjV3
         flmqel5hnfhcaCEwE7yX8CH+S2Xv7UqRhq04CWJu4M/gg/+x7hxiNybYrbQavY0n+8s9
         6rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679095204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyVTmbTVSjXbyxvFuyac08iu7oVxn+bhU8z80CY/FHY=;
        b=YaIcQB0Th1n3Q72a0+asOYjEvdwc3W3/XnK/pVm3M9xrL06h3kOz5+ZloGYeOPw6Sq
         /ewHwotPFTaVi8/tnprXy7Xx+ZsepcvLGyjIafKGJvcb/Ej0RxE+HfEKEeDpdV9CrN+P
         47F8UyZmSV3l0ssekCqml0WbyrscRszLqxlLf+NfqIhnDWK1GuCY4GSi45BFH20kVJHF
         eJV9+PvCxwiViF8FFIAV9+vtMtxixQu8RwExq2fwV0rvi2Ce4dl3QCTJXOagXlIwRlqN
         YBNX9nuPwYiVrxL34OkdT9RXyWDr/L38Eu93Yey82uWBgX6NTMHyn8BbuDaf7plQUhQn
         BIxA==
X-Gm-Message-State: AO0yUKXhmH8UBLIe2SQiTq9v39AxrC1O3EgmE7ZQyXdIYDvvZUAldxFB
        qB3nziD+P/JZqHkOTV9XLWLdZ4pZDP4DN2k3tSc=
X-Google-Smtp-Source: AK7set9h2id2G0gurvZflYSdEEGkYpWcdfVmBfdlvazFgqJbRJBrgNrY6JehbmwYl20UsZGEv53uW6E5WOvjsftJ7DM=
X-Received: by 2002:a17:906:844d:b0:930:310:abf1 with SMTP id
 e13-20020a170906844d00b009300310abf1mr500288ejy.5.1679095204391; Fri, 17 Mar
 2023 16:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230315195405.2051559-1-ssreevani@meta.com> <20230317225259.GA28462@maniforge>
In-Reply-To: <20230317225259.GA28462@maniforge>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 16:19:52 -0700
Message-ID: <CAEf4BzaZ95Gv3Dkke+1gv1nRG41sroMaFb8Lqv93G7LAL7XBCA@mail.gmail.com>
Subject: Re: [PATCH V4 bpf-next] BPF, docs: libbpf Overview Document
To:     David Vernet <void@manifault.com>
Cc:     Sreevani Sreejith <ssreevani@meta.com>, bpf@vger.kernel.org,
        psreep@gmail.com, andrii@kernel.org, mykolal@meta.com,
        Linux-kernel@vger.kernel.org, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 17, 2023 at 3:53=E2=80=AFPM David Vernet <void@manifault.com> w=
rote:
>
> On Wed, Mar 15, 2023 at 12:54:05PM -0700, Sreevani Sreejith wrote:
> > From: Sreevani <ssreevani@meta.com>
> >
> > This patch documents overview of libbpf, including its features for
> > developing BPF programs.
> >
> > Signed-off-by: Sreevani <ssreevani@meta.com>
>
> Looks great, thanks Sreevani.
>
> Acked-by: David Vernet <void@manifault.com>
>

Applied suggestions and switched to consistent "=3D=3D=3D=3D=3D" over/under=
 top
level header in both files. Applied to bpf-next, thanks!

> > ---
> > Changelog:
> >
> > v3 =3D https://lore.kernel.org/all/20230310180928.2462527-1-ssreevani@m=
eta.com/
> > v3 -> v4:
> >    * Update BTF types link
> >    * Update patch summary
> >    * Indent code options line
> >    * Update "See also" wording
> >
> >  Documentation/bpf/libbpf/index.rst           |  27 ++-
> >  Documentation/bpf/libbpf/libbpf_overview.rst | 228 +++++++++++++++++++
> >  2 files changed, 246 insertions(+), 9 deletions(-)
> >  create mode 100644 Documentation/bpf/libbpf/libbpf_overview.rst
> >
> > diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/lib=
bpf/index.rst
> > index f9b3b252e28f..3ac8c06fb8f4 100644
> > --- a/Documentation/bpf/libbpf/index.rst
> > +++ b/Documentation/bpf/libbpf/index.rst
> > @@ -2,23 +2,32 @@
> >
> >  .. _libbpf:
> >
> > +######
> >  libbpf
> > -=3D=3D=3D=3D=3D=3D
> > +######
> > +
> > +If you are looking to develop BPF applications using the libbpf librar=
y, this
> > +directory contains important documentation that you should read.
> > +
> > +To get started, it is recommended to begin with the :doc:`libbpf Overv=
iew
> > +<libbpf_overview>` document, which provides a high-level understanding=
 of the
> > +libbpf APIs and their usage. This will give you a solid foundation to =
start
> > +exploring and utilizing the various features of libbpf to develop your=
 BPF
> > +applications.
> >
> >  .. toctree::
> >     :maxdepth: 1
> >
> > +   libbpf_overview
> >     API Documentation <https://libbpf.readthedocs.io/en/latest/api.html=
>
> >     program_types
> >     libbpf_naming_convention
> >     libbpf_build
> >

[...]
