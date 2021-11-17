Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C048F454C74
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 18:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhKQRvZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 12:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbhKQRvZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 12:51:25 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC54C061570
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 09:48:26 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e136so9935322ybc.4
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVdBhEWIJiEXLqXrTFRUSmCgEfgV0KazniYc2QUVzQI=;
        b=Opvg/QMSP2CWQWyop4c1cfDmzBAl5O2AGqPhmfNfm9EwGffnFlAotnnQPf5UABDMQn
         LZ42RYOtIoMlePgDLef8+xBQ8mKC5jiJUA9mNNLlQDcStSK2B4vD7U8m05+153YLmRNV
         ZPT6+qT9ArUH8dVJ2YbUbrtlPrsoo5JBKGOIM+0rFq/SJdBStttZF5F1UBx7DRjRYWol
         Tzr5HaGg3jLWZ00E+exiRM9rNetJLiPVkvMw2qGto9WZiy2UjJfLk4iWGWt42i2wdcmw
         XgzjvKjWSPxqHTKug5y0DLqr4CNQ6SXu7e3O3ungbp6/wx+tDRUOHvjDawqYcCZKLxjX
         AbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVdBhEWIJiEXLqXrTFRUSmCgEfgV0KazniYc2QUVzQI=;
        b=lQwDv++oN8LQ9L6zotmr2hkVrilDeWg8lbMxDGgk/UWH2XZ9IdBc6ogQQtVyVnNblY
         ebUyoprV1/XE5s07218nJ/SOeJ0FrDAaKI1YZzB42PupFFGV2lUuWuFhQMc2cBheUYuN
         UQcaaDqegiKXnSPxVycZ0hkqt47Qk9sSYcjiYSmn0nHzoT8hAWa3o/cV5r641XlLRXmP
         HpgF8Xeqdp7ltPbe1Znz0m6U8y5yoTkcFrm4RZsbxNkK974NMMIs6snkDeFN3n/DGgP5
         GoJUQa7/VcZjG9X0P18cED4NMTXtfaYZPC/qGoYnglXhgs47m40Lasp5PmMogHRACdLT
         Bp2Q==
X-Gm-Message-State: AOAM531gaZ9PI5N3zuBAshW0WF48SbAMkokLPq5xIzX9tA0bWs4Mocpa
        fCzR38xjnFatlAYULSFMVWJcur3DG+6lnOcXt4Y=
X-Google-Smtp-Source: ABdhPJyq0R76XbvkeNVv2BWT8LBaPUIttnEKyThhrQNUR1YVpUcoA8Hi6BccFEcKk3bl7b1Tb4x/fvjKTiN2V9aQnms=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr20166295ybj.504.1637171305543;
 Wed, 17 Nov 2021 09:48:25 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQKEPYYrr6MUSKL4Fd7FYp0y5MQFoDteU5T++E6fySDADw@mail.gmail.com>
 <6191ee3e8a1e1_86942087@john.notmuch>
In-Reply-To: <6191ee3e8a1e1_86942087@john.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 17 Nov 2021 09:48:14 -0800
Message-ID: <CAEf4Bza3OC1pAvVvwoPhyuixf8_VpA1w0F7HAsX09x2DSYbYbA@mail.gmail.com>
Subject: Re: sockmap test is broken
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jussi Maki <joamaki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 14, 2021 at 9:21 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Alexei Starovoitov wrote:
> > test_maps is failing in bpf tree:
> >
> > $ ./test_maps
> > Failed sockmap recv
> >
> > and causing BPF CI to stay red.
> >
> > Since bpf-next is fine, I suspect it is one of John's or Jussi's patches.
> >
> > Please take a look.
>
> I'll look into it thanks.

Any updates, John? Should we just disable test_maps in CI to make it
useful again?

>
> .John
