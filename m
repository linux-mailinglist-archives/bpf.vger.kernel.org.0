Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A956F40BC85
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 02:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhIOATa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 20:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhIOATa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 20:19:30 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22079C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:18:12 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y16so1977677ybm.3
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3BneG17ljf0jkzY3hmwCnJNgAasZLWDKwSlKfweCyI=;
        b=ZcgcsemtF1zbhhXHWDuwIdZDFz1j2YpW9qWY618TJay1ahO4vcRqIzTtuXom6KDwNE
         FR7E3EjsXmR+0C0VHpTm0WoutT7c0UkhMYER6EaTnaPxBvcfrEgVPxYK4Ol2RR0HnzNO
         IUOADFWEFopdPVrzjfGtA+qz4ybLMGiwTe0uiYOXA7o78Iok1VDCfIeljv+rAgKGykmO
         3HrDd/zTEVNDGzTSediRntSr+VpzN/6uG2uaLA2biuj9CeVD6uZ5Xl97am/pg3R8WMBx
         62GM/dF03jvZ07ZPhf4VUJW92sPfXAb6Ai5DZ13WqMpo965M2ddKS2mKF8wtPupanU1t
         Faig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3BneG17ljf0jkzY3hmwCnJNgAasZLWDKwSlKfweCyI=;
        b=eZP9h2riulDSqLVA5iWun8tgQS6DELIaTKfsKpNeUtwYDoX7tZSgy+I8tO/YdUccFA
         uzA+/8XzvmbpMZt0McKDaPdcOgQ2O+n/aT0QTRVWMIUP+XGDBDCnE7HBhOk2govBiVBI
         gNOaeJr774seSTq32mmDdjrK2XW/IFD1y+OXSv1WvctFO8gs5GFHOgWAimHsdSF43pTQ
         J/q7nJ5ckLnxc6ThVtrw0a/POiGjBVr218Kmgp+CW8b640pKxsJLKsXgbCZhvQ4ju3Je
         ZJ7zRUeYC1Jm4bbB5HZ8xRv9/8nOh1cpS0xED45GViKRJoiisbZWH0nSDaTTdNU0syS7
         SRYg==
X-Gm-Message-State: AOAM531+6WAPQbaiZtGYcFuYpVuhTMugG996CxO98HFXuIjJj/yY+40Y
        CobaE5Klw/RVXVs+f6Ypopapu0HKA+lqLCDbtl8=
X-Google-Smtp-Source: ABdhPJx2XULWzhWInZkxW2x+vskUSKWD44zf6Mqpko0IfUPtLXlPgLMGe0gYwkIcnOvjaU4t6D4gU4Z/tan+jCDiSQw=
X-Received: by 2002:a25:bbc4:: with SMTP id c4mr2610916ybk.114.1631665091313;
 Tue, 14 Sep 2021 17:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210914223004.244411-1-yhs@fb.com> <20210914223025.246687-1-yhs@fb.com>
In-Reply-To: <20210914223025.246687-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 17:18:00 -0700
Message-ID: <CAEf4BzZ7z3Of3Rqo5Dv2WYehNtL=xjyEvkBW3pF-cjWqfN145Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/11] libbpf: add support for BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 3:30 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add BTF_KIND_TAG support for parsing and dedup.
> Also added sanitization for BTF_KIND_TAG. If BTF_KIND_TAG is not
> supported in the kernel, sanitize it to INTs.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/btf.c             | 68 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h             | 15 ++++++++
>  tools/lib/bpf/btf_dump.c        |  3 ++
>  tools/lib/bpf/libbpf.c          | 31 +++++++++++++--
>  tools/lib/bpf/libbpf.map        |  2 +
>  tools/lib/bpf/libbpf_internal.h |  2 +
>  6 files changed, 118 insertions(+), 3 deletions(-)
>

[...]
