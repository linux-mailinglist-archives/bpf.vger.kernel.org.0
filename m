Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C5518D6A3
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCTSPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Mar 2020 14:15:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43821 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTSPb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Mar 2020 14:15:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id l13so5713310qtv.10
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2020 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vUXen2iIlMjfSR8XJP+wQy0shIEQXlmIwbyN8Yn1aOg=;
        b=LVggOYD8AtbpP8jq1T7p4KosGtdQ8qRIJnh4ZBdUP+4137cuhRbL0CbU5kll7i04Tx
         lqxxGEGImOCmen8Dwoo9rJaAj1MhwoWrM+SaK65KKMKK1IXUfvh/dz+jsLEFmZMHouMk
         xDVAiqaCBIOv0JTw/0Yu8xi4f/vGSm3trFL0LEn4jg5Ofkz/OtObyJDeCIQSfVX/GOwn
         Brv5VfpB146adpFpslijDd6AM9odFFBZfTIBmzlb+to+fH7M10FfMi+pJYfz6iktI6mm
         9qwvUl21vvRDCHjWrwOsgZSbwOTh7HCzZY8xmV5yvbcAFalrgzrjIqgu8VIsYTht1vTj
         h5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vUXen2iIlMjfSR8XJP+wQy0shIEQXlmIwbyN8Yn1aOg=;
        b=UkzdFbdvlGIyL7VT7cz3YX+AkKoCFQUYs/XvP744MBNVhNX5aPXKJ4kUqmoM8BzfyO
         TcnrEju/KYwkwjLjWMGpkPaO8b3FUP0/OPB63axo3Tiw4m5QX2AAb+Om2HNF3uAXc9XR
         qk1Sil84PGYiEYiknSxD8UEXul1PSQTSNJDLCKGTnu4mBIZ+O0/LH4UurrFwpqEnB5ry
         Dwja8UW1B8PPLeZaLo9QNAg8m6/O5tctMnmpnF/7t+oZlzel77y6+ZGhGcm9AlJ23ttI
         Cpu3/8sukcubLUONXGDfMMczXmJx7h0pZPpkNDKEM9bdlv26yZ4MCyu8PXd6j+M5Euxd
         Dv1g==
X-Gm-Message-State: ANhLgQ2kUOB/rvorlxe/cwfzOeh7rrSJADllJ6C1/B7/NpVotMa9Z+RQ
        oRgL5FRSByrRGJjr1OaHAd17EoWW9C1Ld7VTP8Y=
X-Google-Smtp-Source: ADFU+vsLN8LMRhBEDmwQ7axr9sm26/pgs7fSytZHkb6j+h84fDKnr87RUGmgtgmpqA8PfTa37wFxUoe/wG4xO/OOZag=
X-Received: by 2002:ac8:3f62:: with SMTP id w31mr9418563qtk.171.1584728129623;
 Fri, 20 Mar 2020 11:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZX76w6Dhkgi6HkQzgvLjoNDsSJ8zg9HQ5yirKj_PDgAw@mail.gmail.com>
 <20200320135555.GC29833@kernel.org>
In-Reply-To: <20200320135555.GC29833@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Mar 2020 11:15:18 -0700
Message-ID: <CAEf4BzZyh--Vo_bCWfDV5VSHdrJpWhTG+=ovSuMUiUTism0POw@mail.gmail.com>
Subject: Re: [ANNOUNCEMENT] Automated multi-kernel libbpf testing
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Julia Kartseva <hex@fb.com>, osandov@fb.com,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 20, 2020 at 6:55 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Mar 19, 2020 at 04:24:55PM -0700, Andrii Nakryiko escreveu:
> > # Why does this matter?
> >
> > - It=E2=80=99s all about confidence when making BPF changes and about
> > maintaining user trust. Automated, repeatable testing on **every**
> > change to libbpf is crucial for allowing BPF developers to move fast
> > and iterate quickly, while ensuring there is no inadvertent breakage
> > of BPF applications. The more libbpf is integrated into critical
> > applications (systemd, iproute2, bpftool, BCC tools, as well as
> > multitude of internal apps across private companies), the more
> > important this becomes.
>
> Great news, just adding that at each perf pull request libbpf has been
> continually compile tested in most of these containers, for a few years
> already, with gcc and clang:
>

Yep, that variety is great! We've been compile-testing for a while in
Github across few architectures (amd64, arm64, s390x, ppc64le),
running selftests was necessary to capture issues beyond compilation
errors and warnings. Plus a lot of old kernel regressions could be
detected only in runtime, which is what motivated this work.

[...]
