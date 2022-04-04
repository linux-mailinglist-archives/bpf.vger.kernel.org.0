Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE04F1FB4
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241160AbiDDXDV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 19:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345893AbiDDXB5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 19:01:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0000A614D
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 15:21:24 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z6so13168369iot.0
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sieiTGyFmlRHToihCI4ecZTQmncTyv2GcLF4vLaUSoQ=;
        b=WmeqOxtngldcF3QvKDnTcuTp5a5C/O5p6oFVhOFEeT3jqTy3x1oqECWBKsZNsZuzRp
         n4kwiN7rL3XBb/AdSIZ6EtmIzbNF/KjIZMoVfe/taK5rvFac6YqU2uwjXyP0/vsRVMEk
         efNNzCcyilW7OziII7CwMnAZnLLlKHty7klBR4VcI1EjV0J5+gMtK7CMDDOH8pc2GEbj
         v1jERqWI7Qw7tHtWv+ntjVju+itrA98wjgo6I+zvIgXJLrBBrSwGyq9uZbSJNXAWfoGd
         9WYQMQ3r1XfoAIP3984hF0f5rSD2XcLg0VghzaPi5NrwyV7LgEaZYlzAMG6C2BAH9m2q
         qgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sieiTGyFmlRHToihCI4ecZTQmncTyv2GcLF4vLaUSoQ=;
        b=WUEZ+/GYRxnwusKWotF+2z+CMVX9upYtVDzRucDobbUgi/lIPMv5ygGNJNZni/q5gE
         72Dz17e8Cdjz/RsVyln/KTPJjxlWcrhHG8BUtC6omANy/e8u0Dz7QC0s5sZOR/OhP4ax
         ux2oJ3tRYz7z+KJR1/9fxOviAdrcSljKc5Cr4zDyJ5ujq0luIsyKuFnknAXCPmAq0Dei
         0gWcBRUHGGdcRZYRdmkJusuMUj/T/TyFZXzKCoVkXXfgQI7zLUuzXpVy/VEHofFAcKeh
         4L8uCYusvibdMfXC3krA+6TsVE5cgqydKDyhgUGx4+il1Ge5sNpXqVMFpXOn1GQCk7TS
         G9GA==
X-Gm-Message-State: AOAM5316ST/cw484IoDUjsnhaFiQ/h4joYT86WvVyAMSL0L/OuidTuBf
        RlF+LpuOT8Pis59sw3vNlKiN+TBXSZc6WBJlrvQ=
X-Google-Smtp-Source: ABdhPJyh5tF7lgcuffugyWkc/nvnh+KJNnAZ765WWNxM0oNZ2NWy/PRCa4c2B/Fh22MLGp5hE0q4Oz7Vg3clkciCh9c=
X-Received: by 2002:a05:6638:2105:b0:323:68db:2e4e with SMTP id
 n5-20020a056638210500b0032368db2e4emr323433jaj.234.1649110884290; Mon, 04 Apr
 2022 15:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220402002944.382019-1-andrii@kernel.org> <20220402002944.382019-5-andrii@kernel.org>
 <37157072-3350-65b0-e0d5-222ace84ba8c@fb.com>
In-Reply-To: <37157072-3350-65b0-e0d5-222ace84ba8c@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 4 Apr 2022 15:21:13 -0700
Message-ID: <CAEf4BzbLM-1CJhLC=tNhq5hg8BOP9h19vcQnE=q=OR4nQqGpog@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/7] libbpf: wire up spec management and other
 arch-independent USDT logic
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 4, 2022 at 12:59 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 4/1/22 8:29 PM, Andrii Nakryiko wrote:
> > Last part of architecture-agnostic user-space USDT handling logic is to
> > set up BPF spec and, optionally, IP-to-ID maps from user-space.
> > usdt_manager performs a compact spec ID allocation to utilize
> > fixed-sized BPF maps as efficiently as possible. We also use hashmap to
> > deduplicate USDT arg spec strings and map identical strings to single
> > USDT spec, minimizing the necessary BPF map size. usdt_manager supports
> > arbitrary sequences of attachment and detachment, both of the same USDT
> > and multiple different USDTs and internally maintains a free list of
> > unused spec IDs. bpf_link_usdt's logic is extended with proper setup and
> > teardown of this spec ID free list and supporting BPF maps.
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/usdt.c | 168 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 167 insertions(+), 1 deletion(-)
>
> [...]
>
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index c9eff690e291..afbae742c081 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
>
> [...]
>
> > +static size_t specs_hash_fn(const void *key, void *ctx)
> > +{
> > +     const char *s = key;
> > +
> > +     return str_hash(s);
> > +}
> > +
> > +static bool specs_equal_fn(const void *key1, const void *key2, void *ctx)
> > +{
> > +     const char *s1 = key1;
> > +     const char *s2 = key2;
> > +
> > +     return strcmp(s1, s2) == 0;
> > +}
>
> IIUC, you're not worried about diabolical strings in strcmp and str_hash here
> because of sanity checking in parse_usdt_note?
>

Yeah, we perform parse_usdt_spec() before we get to hashmap, so if
there is anything too funky about spec string we'll error out much
sooner.

> Anyways,
>
> Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
