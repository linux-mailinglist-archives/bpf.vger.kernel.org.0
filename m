Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188F826CE94
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 00:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIPWUF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 18:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgIPWUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 18:20:03 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF2621D7D
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 22:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600294802;
        bh=4+mfEs1aZjtR2ASe/GE8FAR4O/a46qEuwPDl4yXlogA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tUAMWcX92MjbdvPwSw8kMj5ZG/HU0LsbXCzAtQJye5m+83JkeEtCdG4R6TiKuq/Tj
         RHsNLb0pNW6L6hUce3aB0huUoIFQW9FMb5mq7g0t0f9xvzpl2c4cQGggNqMcQpN1YW
         OKi7rgDH/taQowLy0JPGi9m2WOWALGDsYrPmRJnE=
Received: by mail-lj1-f178.google.com with SMTP id y4so244636ljk.8
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 15:20:02 -0700 (PDT)
X-Gm-Message-State: AOAM5302raoWNdswhf5C5IsV5ZGhhb5W+5TuNoHY5/fDDcm8Z47AjoaL
        /D+K7/CwGVwdjTXLXKKhdA6vo0dc9ZOOMGiJiEQ=
X-Google-Smtp-Source: ABdhPJy9HxLrEhNTsPgJXCDaw5dx55MrjdEhgbQX/JNxVcYeaSK3z/uuptxVuxWOEzEe24it2isP6Xf84BVjcFkExEs=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr9444863lji.41.1600294800805;
 Wed, 16 Sep 2020 15:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200915113815.3768217-1-iii@linux.ibm.com> <CAEf4BzbJ++yj_-p0Yw+1ki4ZJBGFZXEq_bWi3Cf_H-5bkpnfNg@mail.gmail.com>
In-Reply-To: <CAEf4BzbJ++yj_-p0Yw+1ki4ZJBGFZXEq_bWi3Cf_H-5bkpnfNg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 16 Sep 2020 15:19:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW58JYL8R2ZuMX+125a2W61+SgNad0RyxsA21TWFXVCrnQ@mail.gmail.com>
Message-ID: <CAPhsuW58JYL8R2ZuMX+125a2W61+SgNad0RyxsA21TWFXVCrnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix endianness issue in sk_assign
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 6:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 15, 2020 at 4:38 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > server_map's value size is 8, but the test tries to put an int there.
> > This sort of works on x86 (unless followed by non-0), but hard fails on
> > s390.
> >
> > Fix by using __s64 instead of int.
> >
> > Fixes: 2d7824ffd25c ("selftests: bpf: Add test for sk_assign")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >
> > v1->v2: Use __s64.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

[...]
