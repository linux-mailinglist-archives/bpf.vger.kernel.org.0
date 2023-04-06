Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1C6DA018
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDFSnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDFSng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 14:43:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09F67A8F
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 11:43:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id cw23so3653605ejb.12
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680806614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2f5jwmPOwK6FdhddBeT6++B8yp4DgmEJ094ouoIsIE=;
        b=fXBMYatxiuj50j3CoKJcazsjRigJr9CK7cwPR3e+qTPkNN9xXRtquAqpzx4hyaQvnE
         I/cg3Atx83G7cPj5ZvHRVXd5JiqbRTidFF1r3+kWRKIaGeADjbMCliYCXvQ9XUaPdfTq
         c4+ioXlgnpU0cel2J6zYHWZKpHstuwBEOrHgA0vk7wEPBOXst0K+C8fxvmt67B0W2frN
         QH6ys9XQLYmMAkzPL5WGwr4JQe4drLwcDfuDr0ST5i5fUfQiMNLQ/uaCnkR09WQV6c0P
         qU/Oyfe5kTZ4ia8iWmHTRr3juZbBjOZQNXcQZG2uFmMcrY+ufho3UpjFlI/3Y8nLhg75
         JpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2f5jwmPOwK6FdhddBeT6++B8yp4DgmEJ094ouoIsIE=;
        b=jfVNOkeO+34KH24hrKfTe5gHkLDQmU7XdQLKqyYPOy4yTejH4C9bcblv6clhZGihki
         VfAP/kRmxba7gs3dg3Mfaq5uwueGoy3WkFMia2NFt2MJylwJiejd4HhfF6dP3u9b660t
         tAUfZxhFvvzqtdXqKuLVUgGobXQfUd+x/W9m+orSJ5lk3EKVfB7UUMWL0z/+LM4QdGT0
         yronglrg5L9DBh7/i1qfYY/gxQzvAGX1Y3B7XanQfrcV1jpmAU+9mxvsTOAYrRpBK5A4
         2IY5Wu98oArVQGRxc7ABGNZEy0UbLZYXaD3P/WqFoKOg9PK8MRDoNDwws3bK28YgCd3M
         NTVQ==
X-Gm-Message-State: AAQBX9cYgd0249X2R8bgNnTpb5rXlh5VgC+9DxjiGXSptbmdCaTqSN8m
        OklT+7mUhScnWL2F8atLjOYa9Uehaj9gArDMB5rsyRafNPs=
X-Google-Smtp-Source: AKy350azT0cbFXBHcbxWATf5v5ZGsiZ2y5vmbY8n/c53P7eE8UMAArX+hTX7cTProu5ySnE3qDAcm1l/kMGnwYUuekM=
X-Received: by 2002:a17:907:2112:b0:8ab:b606:9728 with SMTP id
 qn18-20020a170907211200b008abb6069728mr3841372ejb.5.1680806614439; Thu, 06
 Apr 2023 11:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-15-andrii@kernel.org>
 <CAN+4W8hdeEVb=Rs-T+E7QtF++fKYObjb--KmCqqOFg8gL+kocQ@mail.gmail.com>
 <CAEf4Bzbv25n_d3-aCgLMNTu0ZwF2J4srp02QMj0Hs3gh-sGobA@mail.gmail.com> <CAN+4W8hFPwekddJ3TKxy3usdSXA-utYpFsqUVduR4ny=qQX+yg@mail.gmail.com>
In-Reply-To: <CAN+4W8hFPwekddJ3TKxy3usdSXA-utYpFsqUVduR4ny=qQX+yg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 11:43:22 -0700
Message-ID: <CAEf4BzaJTCNZFx_H3GhDmhR7peWTjray+w4V9mNKNR1_L0v8BQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 14/19] bpf: relax log_buf NULL conditions when
 log_level>0 is requested
To:     Lorenz Bauer <lmb@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 9:15=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wro=
te:
>
> On Wed, Apr 5, 2023 at 6:44=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:>
> > We could and I thought about this, but verifier logging is quite an
> > expensive operation due to all the extra formatting and reporting, so
> > it's not advised to have log_level=3D1 permanently enabled for
> > production BPF program loading.
>
> Any idea how expensive this is?
>

It will depend on the specific program, of course. But just to
estimate, here's pyperf100 selftests with log_level=3D1 and log_level=3D4
(just stats, basically free).

[vmuser@archvm bpf]$ time sudo ./veristat pyperf100.bpf.o -v >/dev/null

real    0m1.761s
user    0m0.008s
sys     0m1.743s
[vmuser@archvm bpf]$ time sudo ./veristat pyperf100.bpf.o >/dev/null

real    0m0.869s
user    0m0.009s
sys     0m0.846s

2x difference. So I'd definitely not recommend running with
log_level=3D1 by default.

> > Note that even if log_buf=3D=3DNULL when log_level>0 we'd be
> > doing printf()-ing everything, which is the expensive part. So do you
> > really want to add all this extra overhead *constantly* to all
> > production BPF programs?
>
> No, I'm just going off of what UAPI I would like to use. Keeping
> semantics as they are is fine if it's too slow. We could always use a
> small-ish buffer for the first retry and hope things fit.

It's easy for me to implement it either way, Alexei and Daniel, any
thoughts on this?
