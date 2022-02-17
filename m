Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4724BA8EF
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 19:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbiBQS6f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 13:58:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiBQS6e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 13:58:34 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40285BDC
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 10:58:09 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id m185so4813246iof.10
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzILrClDrPo8seLR3WyVC62NzbWCMz/nzk8ZwRCOcg0=;
        b=EQrSSgG0enuL2fsWNngBE78h5q6y2iDmZgJYqivg0wn3CS2lCtL91ESluPZDcqpcG6
         bRvtSn2nZD8HNekWpbO0eJX5gGEyIP6Inxs9jddyQutXTKib9GdnP7HDzuKPAVR4ODEm
         Kt3WJ3Q99aCWIr9m/77PpkQ4qldIFHXRrNqPQbXO56gYb1klAXjh4NCAPGFle3fwPyMv
         DoALUZs7pKbetY5Sbw02ENYSanlP6FrqDkD1DxLuf1exLJaumcinjDW+vw7mxoAqJOWB
         U+9ymv/N7g8I0DQodTZQHZKPkoFNptLnYi90G3+NjVlHurF6+FDoQGp8ihd0EHxN60SW
         ygWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzILrClDrPo8seLR3WyVC62NzbWCMz/nzk8ZwRCOcg0=;
        b=FxF7eQ3ec9gpKR+BliYf11B6406P2GeBPctoYXNy+24sOySQsZ492tYr97Sr3ofTgm
         t2/5LrhEihLR3vr4/747vZbLR1mfgv8wFLZY6xTmAkU67mI4fP6KtKHVDb1SjQFmF/of
         w2b9vP+VUDTLXvG7efs4Zb2QsnGAg9ziIGZ2N0aoolb8fcDjyE4SatueImzxqeNGY/eE
         9nFI5us4YoOXzlDK7OZJ1LSMdM488qUz8r6SxUqdRKSLWOdwFMm0fw73wNRT+5xyjcfP
         5pj4398l5uVtNxlfCT2RElHe22fQbWbVBdJ7LU83hgqheSiyYr6GN/I3ZnH1c+uk3Q0V
         5dMQ==
X-Gm-Message-State: AOAM533qRSetzpXjDNVqEPlqNGIWVj3rLR5lxGyjNYJzOyeUP71Bue5n
        aYb3ksYO2ygFrB86baxRQhLBYtiEStQ/gx4aXEA=
X-Google-Smtp-Source: ABdhPJyyrzMAvE60AmUQ4v0zYeCUzAMpbgJnSVGJmL+IE1zFY1/5p4w7939aXWenOlAxgMcbGO0sE4C5+l1pyBfH5v4=
X-Received: by 2002:a05:6638:2656:b0:30d:23ec:fcbf with SMTP id
 n22-20020a056638265600b0030d23ecfcbfmr2965300jat.103.1645124288494; Thu, 17
 Feb 2022 10:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20220217180210.2981502-1-fallentree@fb.com> <20220217183253.ihfujgc63rgz7mcj@kafai-mbp.dhcp.thefacebook.com>
 <CAJygYd3m0_EkqD8DepPLX0rk48BO0TwHkqJ81KRfOvaygMg9_w@mail.gmail.com>
In-Reply-To: <CAJygYd3m0_EkqD8DepPLX0rk48BO0TwHkqJ81KRfOvaygMg9_w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Feb 2022 10:57:57 -0800
Message-ID: <CAEf4BzZjCRt5OmrSem5MZCOJRo2Ghv2TR60w4kEphGWGDf7mxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix crash in core_reloc when
 bpftool btfgen fails
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Yucong Sun <fallentree@fb.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 10:55 AM sunyucong@gmail.com
<sunyucong@gmail.com> wrote:
>
> > Should it be:
> >                 bpf_object__close(obj);
> >                 obj = NULL:
>
> No, the actual crash is caused by this line:
> https://github.com/kernel-patches/bpf/blob/bpf-next/tools/testing/selftests/bpf/prog_tests/core_reloc.c#L896
>
> When run_btfgen fails, the obj contains uninitialized data and then
> bpf_object__close(obj) crashes.


Martin's point is that you have to NULL out obj so that on the next
iteration this doesn't crash again. I'll fix it up while applying.
