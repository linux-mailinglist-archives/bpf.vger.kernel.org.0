Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03CB2AE422
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 00:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgKJXeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 18:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgKJXea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 18:34:30 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA6C0613D1;
        Tue, 10 Nov 2020 15:34:30 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id n142so161309ybf.7;
        Tue, 10 Nov 2020 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvY8zPFQuXDlXfroxtiIfAkkDMiHwm0Tpk7ZY7XXrsk=;
        b=QF6NRgiQqbvV2EB8gr08K2Tq/IO5H/A8I2NkY/4lVRTUU9SfUVrlGFxetcVZ3bY402
         F/pK+urZult6jT6YUDzumAD0cQJFRT/CsJdzuh0aujhShQi8O8OqHgHvBEUxZuTHeGar
         oDW2p5mnSEOm40eVkiTIHM+JoesXNDwSXSbAsOQ+7abE+JhCPSP96sytbw7WUA6Dqylw
         ITAKY7iql6TZ8sEODdHfW8Os4HSjwEmXIRNP0A4zhhpxl4cdwzWPS5tgAOhMpHI3jj+z
         jmHcUM6/370/htWvKSTbQlMP/A+mnThsBGoRoHwBudXRz+H5NB0H4khnQn1oQWsS9Gpz
         X/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvY8zPFQuXDlXfroxtiIfAkkDMiHwm0Tpk7ZY7XXrsk=;
        b=qGUSABAlBkxpYhBaT+FbORTOXcvzzMrc5FV1pgI8A/CoZlG7vSkH8SWCKajGapkO2o
         cH5hrg267Xe4rXXixFrD6JWViqKMHBTTVLgFqrD918t8n8By2OZrU4N0ERh/dv2mn856
         R7gdA6sahQWl1uviBGAk1jMA4+X3PYWxN0HMKAlphTVdamDn2l3tm738JsgxxOtjQjOZ
         ajrsJFEIA1Lh2lr94ig67ELTbRVriDdszHWWeqdqv6bimFRBfPxXkCUhMt/a89pX9lc0
         EmUqy/5Th1G9nwvJogSCFlMseLPTJXdUh3IUUZtobgTKroUR77mI+mD4OEXXkeqS+x6/
         yYSg==
X-Gm-Message-State: AOAM530/LI4v/sfzOR4k88lArZHgMAglv3JvXB8W99FjO27gphF1ZY8Q
        6U4rp1imAldN/3gpW/hiNdWH33eLjL5G0dkkfSRzEGEY+Ps=
X-Google-Smtp-Source: ABdhPJyZo8hZfKz4G48JpndOJ9Hl29u4F4N1qBlPtaimigPGNkyrrmFowr0YQkPnCbhupx1ReEo2+FvlUEvIJnb7bGs=
X-Received: by 2002:a5b:a87:: with SMTP id h7mr28692535ybq.484.1605051269964;
 Tue, 10 Nov 2020 15:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20201106052549.3782099-1-andrii@kernel.org>
In-Reply-To: <20201106052549.3782099-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 15:34:18 -0800
Message-ID: <CAEf4BzZGXQaDEwASyaJ39AAZ7TWnbi89pgrwXB5uFi861c9CCA@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/4] Add split BTF support to pahole
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 9:25 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add ability to generate split BTF (for kernel modules), as well as load split
> BTF. --btf_base argument is added to specify base BTF for split BTF. This
> works for both btf_loader and btf_encoder.

Arnaldo, can you please take a look at these patches? Would be nice to
get them landed ASAP so that we can start testing out kernel module
BTFs without locally applying patches first. Thanks!

>
> Andrii Nakryiko (4):
>   btf_encoder: fix array index type numbering
>   libbtf: improve variable naming and error reporting when writing out
>     BTF
>   libbpf: update libbpf submodlue reference to latest master
>   btf: add support for split BTF loading and encoding
>
>  btf_encoder.c | 15 ++++++++-------
>  btf_loader.c  |  2 +-
>  lib/bpf       |  2 +-
>  libbtf.c      | 43 +++++++++++++++++++++++++++----------------
>  libbtf.h      |  4 +++-
>  pahole.c      | 23 +++++++++++++++++++++++
>  6 files changed, 63 insertions(+), 26 deletions(-)
>
> --
> 2.24.1
>
