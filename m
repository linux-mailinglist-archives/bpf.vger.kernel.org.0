Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F3526C04
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 23:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384601AbiEMVCc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 17:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384519AbiEMVCa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 17:02:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BAC4ECD5
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:02:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e3so10006642ios.6
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wi9I+cw66mnnBSpYn67WdJibt0c1sCeoFvt/OmPw35c=;
        b=CUEiheGNCMkEGLHva64q3cxELlUsudL6VYdd7KWTuomS867sMiJxjQ2pqDtQPKObtA
         nVWrxtCJNmsCBOztP2oaRa8PJ9YCEZVjlOAvJDUBlmYcmmMvcQXukL8AhV0WE4GeLNah
         OR1pzAQTfZWwyNto8OGGwuB83nAHbpmLNKO9qf3CJiC4RzQUdVVAVACDH4eshFMsQvBk
         AjE98Exb2FUvG8slRPJFbVhm1jC33IreAVs3jGCLHCcOdFfcP+/N7NLh7zC/JDPQyNTG
         /66tJENCxzCP3LnCP/C6QuqtreEgtUrbMEWHbVtl5bX6pqu3N6oF1LXUWp5bvaHpqvxa
         i1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wi9I+cw66mnnBSpYn67WdJibt0c1sCeoFvt/OmPw35c=;
        b=dxRIyyh+rdMmjvDmpaueeYniC23kQzA2PKM9mQ96QJrFa2mtGoJcCjr05lXN20Xjgu
         rSNvTzcpmA4kA+yZdvOzJDNZZ4Rrqv9e0GMGbnLtqNozY3gK2hKbVC811PwL/NZruA6U
         LBRVWV0eb8s362BiNWlIVXQRRDlmyE3a51ThqIEMSizXDCvunQ4kyLNPVnnRvvl+Wm48
         e3+MdUI6/bua6D6mKftoqg1OgtK+86J7txFh45MUzEkDJD74+vZszRDCos6dEvowInMQ
         GNmJsNj4ui7wxIHKdWfagTkaSX6jVG5hdcz3E40R/4Hu+dZg7B/v+jF/oxXY4Na9Jcz6
         XB8A==
X-Gm-Message-State: AOAM530S/HKeC7+62U/6M1jQs46cFr2b+qiIlc7L5//IaAGQ78PplVGU
        Ej+CpQ/lW4S2GqIf7n03eqbogIR8CgTBddgX0Vs=
X-Google-Smtp-Source: ABdhPJw3BfxQ7Oir/7feeWETphzO0vu673SVObrxG/NElk+qxQsLPm3SdX32DTunsHsCMWdAMtT0tV36lszm4Tcm/mo=
X-Received: by 2002:a05:6638:468e:b0:32b:fe5f:d73f with SMTP id
 bq14-20020a056638468e00b0032bfe5fd73fmr3707410jab.234.1652475748876; Fri, 13
 May 2022 14:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com> <20220509224257.3222614-4-joannelkoong@gmail.com>
In-Reply-To: <20220509224257.3222614-4-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 May 2022 14:02:18 -0700
Message-ID: <CAEf4BzbuAT-Tnv4fETHyOJEZuOw39ouwwcFOYKBchcMZLTEWZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/6] bpf: Dynptr support for ring buffers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 9, 2022 at 3:44 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Currently, our only way of writing dynamically-sized data into a ring
> buffer is through bpf_ringbuf_output but this incurs an extra memcpy
> cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
> memcpy, but it can only safely support reservation sizes that are
> statically known since the verifier cannot guarantee that the bpf
> program won=E2=80=99t access memory outside the reserved space.
>
> The bpf_dynptr abstraction allows for dynamically-sized ring buffer
> reservations without the extra memcpy.
>
> There are 3 new APIs:
>
> long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, struc=
t bpf_dynptr *ptr);
> void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags);
> void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags);
>
> These closely follow the functionalities of the original ringbuf APIs.
> For example, all ringbuffer dynptrs that have been reserved must be
> either submitted or discarded before the program exits.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h            | 14 +++++-
>  include/uapi/linux/bpf.h       | 35 +++++++++++++++
>  kernel/bpf/helpers.c           |  6 +++
>  kernel/bpf/ringbuf.c           | 78 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c          | 16 ++++++-
>  tools/include/uapi/linux/bpf.h | 35 +++++++++++++++
>  6 files changed, 180 insertions(+), 4 deletions(-)
>

[...]
