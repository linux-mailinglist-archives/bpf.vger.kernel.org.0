Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E957A9AA
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 00:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiGSWOj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 18:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGSWOj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 18:14:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1E62FFF2
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 15:14:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e15so21507261edj.2
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyc86dgCHsAuUn/FJEph02eP1FvMwhqBCwtA/XAyJZI=;
        b=DodJ3V4HNmxqniLieG1ylx71/G8Fd+h6kL6+ezjar1lxU8rzaKv7KsCKCwDHSFysc/
         vb3k1CJcnohpI60khqlEaUmhRyrb8vAI8s4TQuoPnna9idY1XYTh1g+rFnb9MPa5n6QM
         dGhT2lf74i9PmmgPbE9DUBGXS+Fs08GkHPXDlaD+T2djE0xrn2X/Gq2juLDCf70BSaSh
         tNSk8oJDPT7Qmc3/4QT8gWCGbgLdDqGdOToBBJGObGX1Vkf9433RjwOohAI/vTH7EaPo
         BZtmo9v6KZ0NNrGqXtfAzkK9x6dkAygfNPpQQD09+6LYWApkoijJMT3fEYssmBXKz56S
         3N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyc86dgCHsAuUn/FJEph02eP1FvMwhqBCwtA/XAyJZI=;
        b=OQOcjzsdO0mU+1qfJlPRPxndLqoknCFPFx21n7mmgfrXBEHPr678ktPNezdPUtb4W0
         4NPEhLwXxesQXdEi7yEkF0XIOHYFijDbBhAinzC0QHcRiDd23fiUwp4XXoE15RFmLctb
         MyouiFTIv9qpDc3YDOGiDTBpGab9CLLhafqU+V/jhw3gRuC0htQ//gKD0NkBedZoAjiY
         2Gt3a0m/0I1B/kwjj65SIsxW29IiwZ8FvBRox+/TNsG4eQr77sXEk3DVhx5Zw8zVnJjU
         Xn3CxzyCj9nEharuqqp+bYf5Ei0ZUDMao+O9X4Khwksd9qbGPBThNdTbV8uG+S6xBkZ+
         kFYA==
X-Gm-Message-State: AJIora9L94Pa4MPQXaE2rYY3k4D+bu/cIYA6mrMh+F68knqrUXqdeeTv
        n+sNBvk6P6mNclxBQoVQTEkQOqKWYuhwKeZ/d4I=
X-Google-Smtp-Source: AGRyM1uMCl36Uua5cm6BiTf+wcq9aNZRyfGJBS0hlWSW0qMqt2rf4/TgYl6P+AjtcjvbMg9PWafVQmLp2sVJnHv7isc=
X-Received: by 2002:aa7:d053:0:b0:43a:a164:2c3 with SMTP id
 n19-20020aa7d053000000b0043aa16402c3mr46654985edo.333.1658268876867; Tue, 19
 Jul 2022 15:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220718190748.2988882-1-sdf@google.com> <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
 <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com> <CAKH8qBv66=Fdea0u-vbu-Q=P9pySo+tjy5YpPPcNo8dF0qN8bw@mail.gmail.com>
In-Reply-To: <CAKH8qBv66=Fdea0u-vbu-Q=P9pySo+tjy5YpPPcNo8dF0qN8bw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 Jul 2022 15:14:25 -0700
Message-ID: <CAADnVQ+Gmo=B=NpXofq=LmFq6HsJZ-X9D1a4MwSLK3k_F9SEqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 2:41 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Tue, Jul 19, 2022 at 1:33 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Tue, Jul 19, 2022 at 1:21 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > > Motivation:
> > > >
> > > > Our bpf programs have a bunch of options which are set at the loading
> > > > time. After loading, they don't change. We currently use array map
> > > > to store them and bpf program does the following:
> > > >
> > > > val = bpf_map_lookup_elem(&config_map, &key);
> > > > if (likely(val && *val)) {
> > > >   // do some optional feature
> > > > }
> > > >
> > > > Since the configuration is static and we have a lot of those features,
> > > > I feel like we're wasting precious cycles doing dynamic lookups
> > > > (and stalling on memory loads).
> > > >
> > > > I was assuming that converting those to some fake kconfig options
> > > > would solve it, but it still seems like kconfig is stored in the
> > > > global map and kconfig entries are resolved dynamically.
> > > >
> > > > Proposal:
> > > >
> > > > Resolve kconfig options statically upon loading. Basically rewrite
> > > > ld+ldx to two nops and 'mov val, x'.
> > > >
> > > > I'm also trying to rewrite conditional jump when the condition is
> > > > !imm. This seems to be catching all the cases in my program, but
> > > > it's probably too hacky.
> > > >
> > > > I've attached very raw RFC patch to demonstrate the idea. Anything
> > > > I'm missing? Any potential problems with this approach?
> > >
> > > Have you considered using global variables for that?
> > > With skeleton the user space has a natural way to set
> > > all of these knobs after doing skel_open and before skel_load.
> > > Then the verifier sees them as readonly vars and
> > > automatically converts LDX into fixed constants and if the code
> > > looks like if (my_config_var) then the verifier will remove
> > > all the dead code too.
> >
> > Hm, that's a good alternative, let me try it out. Thanks!
>
> Turns out we already freeze kconfig map in libbpf:
> if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG) {
>         err = bpf_map_freeze(map->fd);
>
> And I've verified that I do hit bpf_map_direct_read in the verifier.
>
> But the code still stays the same (bpftool dump xlated):
>   72: (18) r1 = map[id:24][0]+20
>   74: (61) r1 = *(u32 *)(r1 +0)
>   75: (bf) r2 = r9
>   76: (b7) r0 = 0
>   77: (15) if r1 == 0x0 goto pc+9
>
> I guess there is nothing for sanitize_dead_code to do because my
> conditional is "if (likely(some_condition)) { do something }" and the
> branch instruction itself is '.seen' by the verifier.

I bet your variable is not 'const'.
Please see any of the progs in selftests that do:
const volatile int var = 123;
to express configs.
