Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C993437E9D
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 21:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhJVT2f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 15:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbhJVT2e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 15:28:34 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7C6C061764;
        Fri, 22 Oct 2021 12:26:16 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id o17so9292754ybq.4;
        Fri, 22 Oct 2021 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kjFVYyZDuuF+EL0ZNFMRLD5Ub7SUklZXemiD8dj4nu8=;
        b=AlcRkbliBroMe95h1np6Dp2heCHNBL2t/AagarT9oD3DpY+rEh8d1eZ02+93CUPZMb
         XquxYDAAGXV50gkC6kGjy2feM+XrJTFZvt24WYFvHAam6rF5k8HkvsVafUqTz+ub8nOn
         Y8exOb4i7alO86Y1oHeD1RfP6Zng2NK0/dFByzp8NAU00URyWdAKPQ3uWFa8K+6JgPh6
         NovkApO1VUz4gpjwMC+4sV9IqSRbZTlVzHRAORqG9MTDZrp3DnY3Ut9pO0xd50zpXzH2
         I/8KCjNApcNl2Wh2Y56nZeIeP72NLFEf5koueJEMXZdlTopThK3Cls9E2y2ABSZiUNNY
         0Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kjFVYyZDuuF+EL0ZNFMRLD5Ub7SUklZXemiD8dj4nu8=;
        b=L+oxbo9yGidNedpXBkve1EONLVqXz8z+WfBWnerxnqAqIxMDtam5jNJ6HwDqcx80R4
         MV+BSCg9HKhIdqXMXs2O8F6D+q/5CNM60Dtm/GCGstVSj2YtJv14WJGMN9ERDVXTbijL
         hryX/pZtkSvFVct7TTLo86Dkt2qzB+oN6dXx0JvmZ2WQWIX3abUGBa3BSvaXL93GORzY
         c2RBKAeDjnXzsaZM4chnUKZnE0tN229HlSTDruxZown4gUpE2lHIAPTrmNlNyGETFAJG
         F6iGYIAuriMkXRPftOriGgSjdRe/M5Q6oRIYN8Dtx9XY77pMMh4ywOboxKeJBy8hdsJk
         fiEQ==
X-Gm-Message-State: AOAM530gOQeAq4WZ9GWqdUeKoaD+WRtmluXOju02HKhcSdv7a9WudSHI
        kESgxKL/NSa0RKPxgC68YS9ZCQAHkkO7ke6KVzc=
X-Google-Smtp-Source: ABdhPJzRIraq6n30h7CFDfVm0wqO3ZrygEZ0QfNQsiSxmr0WrxCfNMViGYkvbH+tpDkvAzf9cKKPXa1eX0MEPiW3Zl8=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr1818947ybj.504.1634930775935;
 Fri, 22 Oct 2021 12:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211011082031.4148337-1-davemarchevsky@fb.com>
 <20211011082031.4148337-5-davemarchevsky@fb.com> <CAEf4BzbY+OMR_=JJHdzJpiuar_giusd0sb1LKoCQ7BEDYh57NQ@mail.gmail.com>
 <87o87je7hn.fsf@toke.dk> <d3de589a-21f3-7a0d-59de-126d3c70fba1@fb.com>
In-Reply-To: <d3de589a-21f3-7a0d-59de-126d3c70fba1@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Oct 2021 12:26:04 -0700
Message-ID: <CAEf4BzaGH63-kaM40ifCWBLncEn7tfJcKxGdVKOR0_jcdpeX1g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] libbpf: deprecate bpf_program__get_prog_info_linear
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 12:18 PM Dave Marchevsky <davemarchevsky@fb.com> wr=
ote:
>
> On 10/20/21 5:01 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >
> >> On Mon, Oct 11, 2021 at 1:20 AM Dave Marchevsky <davemarchevsky@fb.com=
> wrote:
> >>>
> >>> As part of the road to libbpf 1.0, and discussed in libbpf issue trac=
ker
> >>> [0], bpf_program__get_prog_info_linear and its associated structs and
> >>> helper functions should be deprecated. The functionality is too speci=
fic
> >>> to the needs of 'perf', and there's little/no out-of-tree usage to
> >>> preclude introduction of a more general helper in the future.
> >>>
> >>> [0] Closes: https://github.com/libbpf/libbpf/issues/313
> >>
> >> styling nit: don't know if it's described anywhere or not, but when
> >> people do references like this, they use 2 spaces of indentation. No
> >> idea how it came to be, but that's what I did for a while and see
> >> others doing the same.
> >>
> >>>
> >>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >>> ---
>
> [...]
>
> >> we can actually deprecate all this starting from v0.6, because perf is
> >> building libbpf statically, so no worries about releases (also there
> >> are no replacement APIs we have to wait full release for)
> >
> > Just FYI, we're also using this in libxdp, and that does link
> > dynamically to libbpf. It's not an issue to move away from it[0], but
> > perf is not the only user :)
> >
> > -Toke
> >
> > [0] Track that here: https://github.com/xdp-project/xdp-tools/issues/12=
7
> >
>
> I submitted a PR to migrate the xdp-tools usage as well. Strange that
> this didn't show up in an "all github" search.
>
> Andrii, should the DEPRECATED_SINCE stay at 0.7 in light of this?

There is no replacement API that we need to wait to go through full
libbpf release, so no, it can stay as is.
