Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A3126CE96
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 00:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgIPWVJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 18:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgIPWVH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 18:21:07 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA3E2080C
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600294867;
        bh=M150LKiDiDW3DRD1azePQoVjIa7znfbdXjhsLdO+NxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F0ERzzkX3p0M5fu8LyN9p6Tph/TGg6h0HCOv67NYtqVs1/Lztrtp8+KvHxhFnEWLJ
         ZI9fKusOzF3Bj9w0SthAe7ZvMbUyls+1/1U18D8nWHf6tpgTrbfMYq1zzzSwWTNTZa
         pCse+VmW7aa+Q0bsOERfnRDmLOSqLoUWiUcaU00M=
Received: by mail-lf1-f52.google.com with SMTP id w11so8683343lfn.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 15:21:07 -0700 (PDT)
X-Gm-Message-State: AOAM532/B+d+tSCh8HRoixFE3BAF8dX2VsECebb2uLM7ZHRpCffLpf2F
        0p8dDr3fHi0/P+3HK8u1w90oS2CsTMBFjF5RLwo=
X-Google-Smtp-Source: ABdhPJz15MhXDkeC7rcPQCNaAnyWFYM2QesQGWcPrdCWOFdxgfpVaigmpeYTRcedbraZTqEuN9EPDPbuB3mAAKLfO20=
X-Received: by 2002:a19:8907:: with SMTP id l7mr8172376lfd.105.1600294865403;
 Wed, 16 Sep 2020 15:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200915113928.3768496-1-iii@linux.ibm.com> <CAEf4BzaE_gAF7fHyD2HTQRgH0KLgD39yxh7WsJ8SxMrtXj6GKQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaE_gAF7fHyD2HTQRgH0KLgD39yxh7WsJ8SxMrtXj6GKQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 16 Sep 2020 15:20:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4+N0DunytSmbXGcfp=91pod6r_Rm-+i5NC2m6QwPfSGA@mail.gmail.com>
Message-ID: <CAPhsuW4+N0DunytSmbXGcfp=91pod6r_Rm-+i5NC2m6QwPfSGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix endianness issue in test_sockopt_sk
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

On Tue, Sep 15, 2020 at 6:20 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 15, 2020 at 4:39 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > getsetsockopt() calls getsockopt() with optlen == 1, but then checks
> > the resulting int. It is ok on little endian, but not on big endian.
> >
> > Fix by checking char instead.
> >
> > Fixes: 8a027dc0 ("selftests/bpf: add sockopt test that exercises sk helpers")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >
> > v1->v2: Also pass a single byte to log_err.
> >
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
