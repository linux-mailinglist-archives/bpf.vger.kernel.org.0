Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A016DA3D8
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 22:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbjDFUna (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbjDFUmv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 16:42:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B4AF24
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 13:40:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-4fa3c48480fso1580612a12.2
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680813647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V29RjRfUD79nvg7DQknYm7femdg0VnD/aba75rgMKfw=;
        b=X2/xDG0qRu18aQtcxxnP6CCglRBRwqmsm6FKsaQVnJVh+5OueEe/zdnsrgpxJp+T1Y
         nPwWbNWdpH6DATfBcSISTzf6Q21oOSYptqqtul1kEtFUGk5Pt3dxNEd90AmX2sj0jTVx
         mGDbac58tjuI9J+lrFeqeI23WNvY6bQtnGEvvIl6mUyK7BnvenL0cqqY17BbyECtbnsJ
         AUBru2CGUhOyT14s/sMiB1WIPPl0PjNkB4MqGmnKdFDljKMyj/ViLWTxZH+4E8b13RQo
         M1R6r/RNOuRTCRZf5+JTtsYecHR6ti4H9/tagXxm5LC5o+N36vDB568qtMRKAhWJ6fQG
         JvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V29RjRfUD79nvg7DQknYm7femdg0VnD/aba75rgMKfw=;
        b=iCW3kRJpspXE47rQyDQJfpv8H4f26MA6qDr5oFbosulMVYxtpYsfVm6DLqs3nJ2fzn
         HH61YoEdmYFHLjAwFchUiey1tZIUxnFJZ08iy74uZtTMVbmj7m3EKvMHIXMGMZO90u4f
         onHHKERLGi7Vcab6Xu7pSsvpQ7N24usiEK9vKei+D62kYeDMLtG/OaZy2qJvK5Rv6rx2
         POsZXV42jkj5ThAYOT13giGrxgcPGZOr2M7sDF7JtGM2NET3cUM9fjTf1/la3thZlzIm
         zFS9rJvwt9oV6pIHoFiPujvetkhT8XqJixk0AAoXBgRl+kvU4RenvIVP3s6b+fawekx4
         L82w==
X-Gm-Message-State: AAQBX9fpqTz3FyKy8bUCuaZbxh7eySetAail6/Uf1KFH9SBa+7Hm9L7F
        YmATysDlM1G67jljkYOEI0DIBjGQIMnHGLOEPGg=
X-Google-Smtp-Source: AKy350ZSDhiWxsjm0mnaDH1Npc7/dLZGDTahfLlmR8jnIoVXaxLMsaCJx6ZpyEhC8x7uaBSfCgovlhUshcb2zv8nSK8=
X-Received: by 2002:a50:bae9:0:b0:4fc:6494:81c3 with SMTP id
 x96-20020a50bae9000000b004fc649481c3mr444390ede.1.1680813646909; Thu, 06 Apr
 2023 13:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230406164450.1044952-1-yhs@fb.com> <20230406164505.1046801-1-yhs@fb.com>
 <97ba28ef-b825-94d2-e90f-89969160a86d@meta.com>
In-Reply-To: <97ba28ef-b825-94d2-e90f-89969160a86d@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 13:40:35 -0700
Message-ID: <CAEf4BzY6MiwzJe8OVAsfESV6f1qB4DTCR_tB+EbMaE6Rs15wxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: Improve handling of pattern '<const>
 <cond_op> <non_const>' in verifier
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Thu, Apr 6, 2023 at 11:10=E2=80=AFAM Dave Marchevsky <davemarchevsky@met=
a.com> wrote:
>
> On 4/6/23 12:45 PM, Yonghong Song wrote:
> > Currently, the verifier does not handle '<const> <cond_op> <non_const>'=
 well.
> > For example,
> >   ...
> >   10: (79) r1 =3D *(u64 *)(r10 -16)       ; R1_w=3Dscalar() R10=3Dfp0
> >   11: (b7) r2 =3D 0                       ; R2_w=3D0
> >   12: (2d) if r2 > r1 goto pc+2
> >   13: (b7) r0 =3D 0
> >   14: (95) exit
> >   15: (65) if r1 s> 0x1 goto pc+3
> >   16: (0f) r0 +=3D r1
> >   ...
> > At insn 12, verifier decides both true and false branch are possible, b=
ut
> > actually only false branch is possible.
> >
> > Currently, the verifier already supports patterns '<non_const> <cond_op=
> <const>.
> > Add support for patterns '<const> <cond_op> <non_const>' in a similar w=
ay.
> >
> > Also fix selftest 'verifier_bounds_mix_sign_unsign/bounds checks mixing=
 signed and unsigned, variant 10'
> > due to this change.
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
>
> I still think there's a refactoring opportunity here, but I see your comm=
ents
> on the related thread in v1 of this series, and don't think it's a blocke=
r
> to find cleanest refactor.

Agreed, but current implementation is not wrong, so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
