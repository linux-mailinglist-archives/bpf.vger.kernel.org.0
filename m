Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145AD3FC19C
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 05:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbhHaDio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 23:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbhHaDio (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 23:38:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E720C061575
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 20:37:49 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id a93so32349237ybi.1
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 20:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6IAgnB9Pe6CLivHCE/OznHn7S6PuNxP29znf9fC+iR0=;
        b=suJLbdwQKybWyLW1zAYhkvdTg1RUUdvFG9NIyTs8m/I/8KPNB+PDNmQK3aYpEUHcr4
         yjtKYq/fq6e0XK2b9Gj/QI2gPdjNLet075muMTdiju0m/5tQpgDFirYXVxYD36dYaqj0
         +LiKaIPjK0e+NQHCempUE4SV0vQqOvB4ZzOaw4akeVUb2JSJb58VR/hKyZehmvh2HO4V
         P6he4Fy2T9qbQvTJDegGEQJmiBz9maMlZexOHO0JknkBdz7dRyYI1wavdhuKVb38liOH
         visL02UuLHu+cX7UfqTJipBIG2ZDDz99q8pOM7lDsR1Vj7gLBS8wdGtG08Mw5+okCamG
         qdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IAgnB9Pe6CLivHCE/OznHn7S6PuNxP29znf9fC+iR0=;
        b=FwRYh3fUW+CFZqHfM3dA0tAA510DwilQtTDw8gac0VGCuYmj1CI3CFKJN/JsAP1Ijg
         c56dk+ON3KRSAPbF1ZRhI6SuQq2OuruP7ZZqwQkLeDViV4Hap18q8CcEm1XeKmBY8S2y
         K3x6XJPis7Hylczsp8F/IH6Gztth1CaK3+Rv+cqtYfGsaQ01G2JST5gtzOu9Zd/L6iB4
         XEZXcJ0kTjIPmJfhlL4jW4Ea2bCK1M30QTq8IMkeBxulvNR3MEER+gsdwW/5JJFvDaV0
         IIB4oY+GtNDrRnSbF1fhWjBti5OEi+U/OT1WOlwjVvPcPsxJvvBN4DrxyAMaR/81gAvg
         dIPA==
X-Gm-Message-State: AOAM531I5JUInClTvStd15DSPyA2SW+SHzJK01JywfLaBoANdeKfeBPE
        OPbx0KhJuQEGno8gy9sfkLVfOWFVP/xlcD1sino=
X-Google-Smtp-Source: ABdhPJzlXgxiydGaHOpzkyI9emX+Rq7tnU3E9rkRJUdLYH8K1oBNtwNOL362A/ttb96FnO/ph5P1Db4ggX9KUbPpb3Y=
X-Received: by 2002:a25:4941:: with SMTP id w62mr27726780yba.230.1630381068612;
 Mon, 30 Aug 2021 20:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210827231307.3787723-1-fallentree@fb.com> <20210827231307.3787723-2-fallentree@fb.com>
In-Reply-To: <20210827231307.3787723-2-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Aug 2021 20:37:37 -0700
Message-ID: <CAEf4BzaSO3jfomcwTwtGJpTj730RdVuO714=tXA6pxNRzGKESQ@mail.gmail.com>
Subject: Re: [RFC 1/1] selftests/bpf: Add parallelism to test_progs
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 27, 2021 at 4:13 PM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch adds "-p" parameter to test_progs, which will spawn workers and
> distribute tests evenly among all workers, speeding up execution.

make and pahole use -j for parallelism, let's use the same for
familiarity? pahole (make gives a bad example in this regard) is using
a good convention that if no number of workers is provided with -j, it
assumes number of CPUs. I think that's a good default, let's do that
as well.

>
> "-p" mode is optional, and works with all existing test selection mechanism,
> including "-l".
>
> Each worker print its own summary and exit with its own status, the main
> process will collect all status together and exit with a overall status.

Signed-off-by: is missing, don't forget about it.

> ---
>  tools/testing/selftests/bpf/test_progs.c | 94 ++++++++++++++++++++++--
>  tools/testing/selftests/bpf/test_progs.h |  3 +
>  2 files changed, 91 insertions(+), 6 deletions(-)
>

I'll add high-level comments on the cover letter (which single patch
submissions don't really need, cover letter is required only for patch
sets with more than one patch; no big deal, but keep this in mind).
