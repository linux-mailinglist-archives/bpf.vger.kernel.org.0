Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB95439215
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhJYJNn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbhJYJNm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 05:13:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02790C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 02:11:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso8778548pjf.3
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcW3pl4R8WFRyrGyotJtCPUK+gsqiQaeO26LUHm4wkQ=;
        b=Z2EGhTLukm0MioMX2f+Ijs7DkwetSji6d1QSufJjRomXBtokg4NUuZsYAzgKvf2bWj
         7fS1jSB/HOwFtC2tmGK3rhfc05vzRnoymZ2MgciYqS4cYD2Hzmi1Y7WB41QI/djFFGP4
         uJryQra/7wv5WNLqxJV7CIgr980/gNZMyyOUdai0Xs7adbCEIfPKKH3lse4pIfpPpGUZ
         afbD3Ai6KhUNReewINWUYkwhmvwUPKd+dKkrZMXY1NXWoa9/CO0smnal4NlVNymdZtzp
         Y7OkpK+jaYYptUYQXXFGH8KPEwQMXilFjTgPki3T864mFbQcFcXcbNPAZyFmOkpgEFei
         1Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcW3pl4R8WFRyrGyotJtCPUK+gsqiQaeO26LUHm4wkQ=;
        b=NCf4Vzv60V+u90MwETMDzHooKDxUjMvYqVPntcW4pV68sNcyKXZycj21xldI+8/pf4
         TGwf6d4klXvzviIRg5H1cQKovy3WTc7d6bHe6xIOeoIX25yAxuFz9AT4z3OkWKqN8fhr
         S6CAs+ETKvFMpwQEkrD4++wgNfSEFRIlagLC72Vnm82JdKqNhkbZYEHy/ZEbga35kkMZ
         f7zBTW1YZuVyanRRMYOD8Szw4mHKeDbr3I1atnMHQqwg0L3c17GTXEp/dqW+k6r7lzC1
         HX7JW1UpC28G3QfgPjJPkQXERb1P1LZl6Hn7f1kSujJvmJIBUUZ4KvLC8W979RmAysw1
         SnfQ==
X-Gm-Message-State: AOAM5331Y0N4g6e3cLcT6chM18010sa2R7Oe7M0XHt5tV93dX3h5z8+v
        MCX6jvFm92fW4xs5OBTE+QeS1C63gEAXrwEVmMM=
X-Google-Smtp-Source: ABdhPJzoz7rgWYD8SSy943SgQqeYqZf2j4IG/+0GcuTkRWAiPZe/99V8GK+S+i+g0Ef203JG8R3zBRXblu58y8hXubU=
X-Received: by 2002:a17:903:11d0:b0:13f:ecf6:26ce with SMTP id
 q16-20020a17090311d000b0013fecf626cemr15502049plh.2.1635153080448; Mon, 25
 Oct 2021 02:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZ5Uajg5548=vpq8O2L5VLrONmr8h2O-6X6H0urMDXEqA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ5Uajg5548=vpq8O2L5VLrONmr8h2O-6X6H0urMDXEqA@mail.gmail.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Mon, 25 Oct 2021 11:11:09 +0200
Message-ID: <CAJ8uoz35Xqx1YCnxB0wCd-58_u9fdzEy5xS45Jcs82gXiAnK1Q@mail.gmail.com>
Subject: Re: libxsk move from libbpf to libxdp
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 7:49 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Hey guys,
>
> It's been a while since we chatted about libxsk move. I believe last
> time we were already almost ready to recommend libxdp for this, but
> I'd like to double-check. Can one of you please own [0], validate that
> whatever APIs are provided by libxdp are equivalent to what libbpf
> provides, and start marking xdk.h APIs as deprecated? Thanks!

Resending since Gmail had jumped out of plain text mode again.

No problem, I will own this. I will verify the APIs are the same then
submit a patch marking the ones in libbpf's xsk.h as deprecated.

One question is what to do with the samples and the selftests for xsk.
They currently rely on libbpf's xsk support. Two options that I see:

1: Require libxdp on the system. Do not try to compile the xsk samples
and selftests if libxdp is not available so the rest of the bpf
samples and selftests are not impacted.
2: Provide a standalone mock-up file of xsk.c and xsk.h that samples
and selftests could use.

I prefer #1 as it is better for the long-term. #2 means I would have
to maintain that mock-up file as libxdp features are added. Sounds
like double the amount of work to me. Thoughts?

/Magnus

>   [0] https://github.com/libbpf/libbpf/issues/270
>
> -- Andrii
