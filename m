Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33156D84D7
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjDERZq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjDERZp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:25:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D303559E6
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:25:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-947cd8b2de3so75007466b.0
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680715543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+2RSIkiPIp4EaMGOsGWYGENd1oT1YPqzzMXhyq+Rfg=;
        b=hEVnQ6pMTcqMQW4yRbk3qJ5sSqWqTmBbc4AWDtQiauAUEM/ThwStswAt+qOFXC+2+N
         PpCoimdyT3NobKQP77YnMTilJ97csWVra01jD71A1AYJKOgmHM/YCxAG9cf/HA5sZVer
         DSmhWDc9YSE1TUM3i++D1i3v4H8/STD/dGOjXUJ7oI6PEltIihReuaSl/trhLkZrlOpI
         t+9tNbmExx9bJ7vnAdASjNcZMzuZBqRtmqPdgBGTm3+mg6XNUQLwUznJZQISfRBOd2DT
         v8OQWC1Ubr9aU5Hi7R1Gc/dah5RDjarWbTrOoFuvMFFJrhwJ9in2qF6b9CLBp5FsHCmq
         JY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+2RSIkiPIp4EaMGOsGWYGENd1oT1YPqzzMXhyq+Rfg=;
        b=6IYV9HWtrfAcpZ6sUDeZdOsYG9mjkKgw5cBifjomRyyultzYUt1Pg+aGvOEyPXT8NI
         P2h4hvOJpoai8J9GsVTbE6zO8Z6GcWV/hrJo8yfeBxX8ukiaxuGuTHM53z2eQ/waMoSw
         tHfLaHg9TUbREiexr6dOA6X8uWskRd3drS1rgAXtnjInD2h0yUMZIc1AHNxGXftqn4PD
         NRkvHqSQ8rnPdeZX6Ngm6+yWb4OhZKvn2svFRFMOAQSR/88RBmfruzydKvYP6rLKtIyL
         U6H4Vk0quUKPrgn7rNGAGu14+kbPlxdkVHzLk/YalxH2NExehjXTBxuyxk6o7jcTUzrd
         yWhQ==
X-Gm-Message-State: AAQBX9cJyNSBy5OpkH5Zx1zkAmvzrjdS26e5t/ZXRmImOAVvOm/0Gqdw
        slQ7gyNC9Ng40RCNuXUlkg5hduNZEqtR8XTcslFpOR/J
X-Google-Smtp-Source: AKy350YqfnmDOHGXbRPUB3u9e5WYPH92nVGz30fK5NmxmRXLAT1Tq33UARt0913ifhaTFhj6GiN8U4ORHWAUoYfKMZM=
X-Received: by 2002:a50:8e02:0:b0:4fb:f19:883 with SMTP id 2-20020a508e02000000b004fb0f190883mr1642677edw.1.1680715543241;
 Wed, 05 Apr 2023 10:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-13-andrii@kernel.org>
 <20230405032443.tcfnfjsp4jko4gek@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20230405032443.tcfnfjsp4jko4gek@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Apr 2023 10:25:31 -0700
Message-ID: <CAEf4BzaLL+KFyha8nsi-gRyC2E68EF7c25AghCmdocbLHF90CA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/19] bpf: add log_size_actual output field
 to return log contents size
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        lmb@isovalent.com, timo@incline.eu, robin.goegge@isovalent.com,
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

On Tue, Apr 4, 2023 at 8:24=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 03, 2023 at 09:36:52PM -0700, Andrii Nakryiko wrote:
> > @@ -1407,6 +1407,11 @@ union bpf_attr {
> >               __aligned_u64   fd_array;       /* array of FDs */
> >               __aligned_u64   core_relos;
> >               __u32           core_relo_rec_size; /* sizeof(struct bpf_=
core_relo) */
> > +             /* output: actual total log contents size (including term=
intaing zero).
> > +              * It could be both larger than original log_size (if log=
 was
> > +              * truncated), or smaller (if log buffer wasn't filled co=
mpletely).
> > +              */
> > +             __u32           log_size_actual;
>
> Naming nit..
> In the networking subsystem there is skb->truesize.
> The concept is exposed to user space through tracepoints and well underst=
ood in networking.
> May be call this field 'log_truesize' ?
> With or without underscore.

Sounds good, naming pretty much the only part I wasn't sure about.
log_size_true or log_true_size, any preference? Latter reads more
naturally, so I'm guessing you'll prefer that one? Unless naming
"regularity" of log_size_true is preferred?

>
> Other than this the rest looks good and I believe it addresses Lorenz and=
 Timo concerns.
> Would be good to hear from them.

+1, yep. I'll wait a bit more before resubmitting.
