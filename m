Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADAA57E62D
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiGVSBq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiGVSBp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:01:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D6713F93
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:01:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mf4so9880650ejc.3
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5OsmFRI7KetDyQg13TteOeKfaFUdYSP/HSjomYs1Ns=;
        b=l3oNEeijTmjUQb9L0ABv3EuQAzeAezydv2C7ujGkj76yzWinfZZaZI3Kw+vE2IMykj
         c2JG/RXGwHi5ofwjO7dW0rSJFJhrhmNbta9ZZQ6J14rbyLlfa5Yd2L8widhNWUu1qSV3
         92WLSFIc3H3847Mvy7WRdYX63Bvksr+Eq4mKEwuQzVQOXVBNBRumikzATF8MtM/nifMc
         w/cTAFgx9NGoXoermcc9myOWTqJTHIUe3mNEaLMcazwIlnN5vDSnWviDptJViToTM6Mq
         afDUtbbmZtSmQFGg1Cz4/p7LoJIvB9R4H2E4EZTs5qXMHhVt7xTlODSKLMXYaSmn6pF1
         X5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5OsmFRI7KetDyQg13TteOeKfaFUdYSP/HSjomYs1Ns=;
        b=ZYhndEa+Ju7cfS4AjjekREyba+7EONSoehRiqzZgkqXgK7H7YyGv2kahA0flLcFzFv
         Xs2VP9/BwBHy9LdYYt+/TywgVWFQqnCm+HE4NN8o61ysh5eY9SDQ2CtCl9KaRz2RC++S
         aEFmSpkhvvsoQc0/f8TtbfVFS7IQMpvUCeRqhSEOFnLJFcGGS4qHhtYdSc2TwY3y3a2b
         R/o8N7V1/A+lz3w4VKr1UP2GByzUT2AYSrH2uA7AcvXeIfJnD0qnEI0j3V6Qu1+79i27
         alrPqemkAPrEH3Mnc4ORDcXUzhVxtlG5yHCrJ7n9woSZ4G8RVX41QoX5j3oxJkIgN/C/
         wT9w==
X-Gm-Message-State: AJIora8Rs1zFt14pHMQuLWLaIk5HPU7lBk1Jtl/MKkRj5OVd3AZDncP0
        lZKdK0xsSut6ZVRGKaVw0ND5BKDioIdnuf3JcM+wKK2S
X-Google-Smtp-Source: AGRyM1vKJo2f5aVVRdOF/JaPPzvj4lPn7yaNwRNBAmMkyIB8JO42xnL+4az4QDmEJmDEQ0KpDKOQez5s4s7zAKMzEoI=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr853459ejy.708.1658512902798; Fri, 22 Jul
 2022 11:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
 <20220722171836.2852247-8-roberto.sassu@huawei.com> <CAKH8qBuU4TORtzu-SQg-2y8iAgFe31fLBX2joby2eWJdoXGd2A@mail.gmail.com>
In-Reply-To: <CAKH8qBuU4TORtzu-SQg-2y8iAgFe31fLBX2joby2eWJdoXGd2A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Jul 2022 11:01:31 -0700
Message-ID: <CAADnVQ+9xYy+tAiTrQudS+gTo-VxqUs4y576-DNCbPKASv9RXg@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 07/15] libbpf: Introduce bpf_obj_get_opts()
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Joe Burton <jevburton.kernel@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 10:58 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Fri, Jul 22, 2022 at 10:20 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> >
> > Introduce bpf_obj_get_opts(), to let the caller pass the needed permissions
> > for the operation. Keep the existing bpf_obj_get() to request read-write
> > permissions.
> >
> > bpf_obj_get() allows the caller to get a file descriptor from a pinned
> > object with the provided pathname. Specifying permissions has only effect
> > on maps (for links, the permission must be always read-write).
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  tools/lib/bpf/bpf.c      | 12 +++++++++++-
> >  tools/lib/bpf/bpf.h      |  2 ++
> >  tools/lib/bpf/libbpf.map |  1 +
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 5f2785a4c358..0df088890864 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -577,18 +577,28 @@ int bpf_obj_pin(int fd, const char *pathname)
> >         return libbpf_err_errno(ret);
> >  }
> >
> > -int bpf_obj_get(const char *pathname)
> > +int bpf_obj_get_opts(const char *pathname,
> > +                    const struct bpf_get_fd_opts *opts)
>
> I'm still not sure whether it's a good idea to mix get_fd with
> obj_get/pin operations? [1] seems more clear.

+1

> It just so happens that (differently named) flags in BPF_OBJ_GET and
> BPF_XXX_GET_FD_BY_ID align, but maybe we shouldn't depend on it?
>
> Also, it seems only bpf_map_get_fd_by_id currently accepts flags? So
> this sharing makes even more sense?

+1

Roberto, the patch set is broken in many ways.
