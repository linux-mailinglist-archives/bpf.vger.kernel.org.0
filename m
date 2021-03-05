Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB35432DFB2
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 03:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhCEChG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 21:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCEChG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 21:37:06 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ADBC061574
        for <bpf@vger.kernel.org>; Thu,  4 Mar 2021 18:37:05 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k12so874296ljg.9
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 18:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpJ277df+Fia8oQok5QcUbiisnmqwp2+mDXYdVg8wUA=;
        b=cw7Jq+PTBAbR+gZBO0Jg36LMtwPi97lVpiU1hkCblPXSAyDTmytemj2SfTJkG4TFyk
         2s1SFgRWJ+ZOmgeymm7PPE7Huf9ZgcYau0KZB1cRkTAkDjtP53U7S9cgZzpOBf/MeIdo
         8ASzGAIx/xKygl6gdo74RnEF9udioLmcKSJrg7s7M6FVwrYgXzH9yuO1ZAfxGlaPgsE+
         /cuxHtxSOztiKgLKJmZwqXq5nUX8mIBfgpF8JDaxZAZIyl9TYO6DWRb9vA+ZGYd1EAR+
         V0+5izPzvIhwq+CsWGc3D2M/TgvO6jXcgafmzkoMVjYOyp4mwPk9GA9aPR/Ah7DqLm2N
         wstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpJ277df+Fia8oQok5QcUbiisnmqwp2+mDXYdVg8wUA=;
        b=RlsSVdMdp9eyJt37pUaAtWPeTPoduVqmWNRbhiKs/3zxObszDdOmRc+Ihklgcq3YwY
         2QCXokEXs90sp7orqHBJumKf6dB3oAe+vn8N3aSOkR6R+wOA0JfaO3gbv5TTUiA85NG+
         zwhKNGSGsceElCUcpvE8p8SaOgVItPTWthzYSL6UmYykj2qKvgfAlOucQ+buCdCqNAhq
         wis9uGAdm2qarkVi8cPwfJCVUDuR8jhBiHdnFnS2+sEPKF1sgQ4+uOp/pHn5IVJqxUIT
         aU2xI5FNONGhGGTelxVYYcuKptN0gI9u41LeH2p5XZQUif2u1aVuvdK6d/1q1efrQhwF
         0ehQ==
X-Gm-Message-State: AOAM531uRGsTKwn6lHvFVCQ8LB+qWLWt80ggRnJBcYLovi6NCLtw8UWJ
        0SBLA5rhb9yS1W5niAsRp4+PxxQOYY0braOHklk=
X-Google-Smtp-Source: ABdhPJwDrs8wteH1MujGLzfS6IvsdBbKGgyz52oEB244UFI+H65sjUJ6/JwxCVaHHx7NItt5VnFcJjf08gz+vfoNE9c=
X-Received: by 2002:a2e:3608:: with SMTP id d8mr3783313lja.21.1614911824151;
 Thu, 04 Mar 2021 18:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20210226202256.116518-1-iii@linux.ibm.com>
In-Reply-To: <20210226202256.116518-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 Mar 2021 18:36:52 -0800
Message-ID: <CAADnVQ+21PGMnZAOb5oU7o9Gami2qE-UtqF0H2xcWy=WA9q93w@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 00/10] Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 26, 2021 at 12:23 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Some BPF programs compiled on s390 fail to load, because s390
> arch-specific linux headers contain float and double types.
>
> Introduce support for such types by representing them using the new
> BTF_KIND_FLOAT. This series deals with libbpf, bpftool, in-kernel BTF
> parser as well as selftests and documentation.
>
> There are also pahole and LLVM parts:
>
> * https://github.com/iii-i/dwarves/commit/btf-kind-float-v2
> * https://reviews.llvm.org/D83289
...
> v6 -> v7: John suggested to add a comment explaining why sanitization
>           does not preserve the type name, as well as what effect it has
>           on running the code on the older kernels.
>           Yonghong has asked to add a comment explaining why we are not
>           checking the alignment very precisely in the kernel.
>           John suggested to add a bpf_core_field_size test (commit #9).

Applied without patch 9, since it crashes current llvm.
Please work with Yonghong to land llvm support
and resubmit the selftest along with an update to selftest/bpf/README.rst
that needs to explain which llvm commit is needed to pass the test.

Thanks!
