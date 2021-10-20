Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495CF435291
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJTSYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhJTSY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 14:24:29 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F438C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:22:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b15so3971397qkl.10
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Amx5b9ulkowQsD/+s+Yg7t/EHUFV5O46vZ+modI/J9Q=;
        b=VokNfouG2ShPNUs4b9HK/dITE9lFDGh7m73vDpIYpw3clsLAOqWGixjkmGkaIFpzTY
         vzuzkp4ul4JAPYvDt3uphigFOlhBhGcllooR0ysMehsQH8+wF7Du9dRU8+Mdda/ZdItC
         I6wsK3n4ipvllkhnNU8TjpB+tawmE4yK8/GRx38iKRTW+cNXxxs1bSHO7byuFr0RyUmv
         1C1qZZPcX9+Rb3cdCe/wb78+/kVTBd+aV1h2ZG3fLxC9O+mswNluoGVC7qmy6mUun0Vc
         b1SkUrduycB5NVN1ZcWtYAY4atd5NfFdlqrzbAbT8i5VGb0OYGPWMLE09Vqf8AclS9OL
         rsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Amx5b9ulkowQsD/+s+Yg7t/EHUFV5O46vZ+modI/J9Q=;
        b=wWsZqHRb/EDxmiUAceSVCgPueRD8fMzwbaAE//mfqTtoN8zC/tZDFnQ9qXIV7bQmlx
         d9c6XXs/Ub+cSK4qRn2C5emBOwPLbPw1v3a5Cb4v2is7vZW2JdpW0kjzaTlciElFNhBY
         X7Gww2uX1+5HovSIXnSTsYytQnaKsETdT3qC6FxWO7v+THrF1nlM+RtuwjUnZGu0YjWy
         HFDReHzmnQnEypFwOm77LZB+odAyYpf1l1WyzOzpWId+4kCrz/uMcJ7/PstIDtZyS00T
         34bbgcdjXfeR9+llddd2EBjBGAwzLome9v3OnK4108YoD2mkwG1P+dwl9HD8nHswwCji
         r9uQ==
X-Gm-Message-State: AOAM531GujpKNFoG5uUnIkAGxJL4OBeJtaLb46PAT1MdZ+r4VNhePK2c
        l3BOLNifzxhpV8bfPUU4hBX2+dukOR3SI8V1B6hjow==
X-Google-Smtp-Source: ABdhPJzANFvQBoBjcEiZAzOegEyIbaVvY7XBPVzPUNWDzseoLE+HO37abNnIAg8MVcqufnnxmwaEvb+cuwMWsE//904=
X-Received: by 2002:a37:d53:: with SMTP id 80mr617420qkn.490.1634754134036;
 Wed, 20 Oct 2021 11:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211012161544.660286-1-sdf@google.com> <CAEf4BzZ0-BeNmd9AuyLF1QZvmH4xNjAXPC2TsUN++D2WkuN5UQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ0-BeNmd9AuyLF1QZvmH4xNjAXPC2TsUN++D2WkuN5UQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 20 Oct 2021 11:22:03 -0700
Message-ID: <CAKH8qBt5dLs8UN4YnRj7mkG2KmqrRKLj5QTGdFZ-OKDkz+vkwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] libbpf: use func name when pinning
 programs with LIBBPF_STRICT_SEC_NAME
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 11:14 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 12, 2021 at 9:15 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Commit 15669e1dcd75 ("selftests/bpf: Normalize all the rest SEC() uses")
> > broke flow dissector tests. With the strict section names, bpftool isn't
> > able to pin all programs of the objects (all section names are the
> > same now). To bring it back to life let's do the following:
> >
> > - teach libbpf to pin by func name with LIBBPF_STRICT_SEC_NAME
> > - enable strict mode in bpftool (breaking cli change)
> > - fix custom flow_dissector loader to use strict mode
> > - fix flow_dissector tests to use new pin names (func vs sec)
> >
> > v2:
> > - add github issue (Andrii Nakryiko)
> > - remove sec_name from bpf_program.pin_name comment (Andrii Nakryiko)
> > - clarify program pinning in LIBBPF_STRICT_SEC_NAME (Andrii Nakryiko)
>
> I could not find this, can you please point me to where this is
> clarified/explained in your patches?

Sorry, I don't see it either. I remember I've added some comment to
LIBBPF_STRICT_SEC_NAME in tools/lib/bpf/libbpf_legacy.h but I don't
see it in the paches / my local tree. Will add back and resend.

>
> > - add cover letter (Andrii Nakryiko)
> >
> > Stanislav Fomichev (3):
> >   libbpf: use func name when pinning programs with
> >     LIBBPF_STRICT_SEC_NAME
> >   bpftool: don't append / to the progtype
> >   selftests/bpf: fix flow dissector tests
> >
> >  tools/bpf/bpftool/main.c                       |  4 ++++
> >  tools/bpf/bpftool/prog.c                       | 15 +--------------
> >  tools/lib/bpf/libbpf.c                         | 10 ++++++++--
> >  .../selftests/bpf/flow_dissector_load.c        | 18 +++++++++++-------
> >  .../selftests/bpf/flow_dissector_load.h        | 10 ++--------
> >  .../selftests/bpf/test_flow_dissector.sh       | 10 +++++-----
> >  6 files changed, 31 insertions(+), 36 deletions(-)
> >
> > --
> > 2.33.0.882.g93a45727a2-goog
> >
