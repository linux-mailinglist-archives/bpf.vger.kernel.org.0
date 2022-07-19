Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5418357A841
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238954AbiGSUdl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 16:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbiGSUdl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 16:33:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55492509DD
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:33:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r24so1919111plg.3
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IolBtxP9r1Lhy6+RYa8eQjBwVQE3BG30+ac3ky5QQmc=;
        b=JjvpGMudJ23k0mhTLneG+gPJW7TXI7IDbmOmUxJFqO9DX/Isxs/H/dfm4gOTWE8azk
         YxR1niwRra28om/67kCpOda3WYh5mnvvBYwLXaJwVjhWTn+XiohftpRzJhao6KzEjGvr
         tIjUafWtd3zhSvJ0Jrg+yhQx/oXqfAKKY7Bbfq02Kpe+WdMkSLCC71gHCqDRAwmquAgY
         uidLOIkRVanTe5f3XnfGaRoOUBFe8qtfogjkyksnttt2GFx5Vffdj0K3afJoQrqsXrfn
         DTuEbu/ytJaX0JQKQLTCJZwGGe2d37zirnEjeD/84uS39VXQJDbpLBta7sTVNt09M/Bx
         8xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IolBtxP9r1Lhy6+RYa8eQjBwVQE3BG30+ac3ky5QQmc=;
        b=RrR6OZbXNXronBGsHnfBoPP16wnwmGq/MbDoFNDLcBob3CHmpQcwU4pnnwdhuD4CVM
         AugufaHwgFjurj4poolDHV8LYL+VcHK9WueUeu7ddelT+4kW4VKdBtsD4vbKfJOrE0c1
         tM1tm6hgngqloyD2k7Q8QLuciyh7UI5bQVAaPidg2LJT4Ck3VtSihOgsLETtznR7cJSr
         mPw9rvaSNaID6VHYHhCW81kfpM1aXTGVaWobEi/i7nG0zmfxHl/nuW5aZutPi12klvx9
         eCHBzHj7GkIwSLZ8J/x9YwWR8RKnc9p9umwln0KECqXYCrg0Gt9Nt+cdz1PsCfkPd+CQ
         +DLQ==
X-Gm-Message-State: AJIora9J3lNXu3S1pqeLp0IUEzxllw06A0Wdm2+ObT2dzsShw7nO7qBf
        +GduplzXDkcQVe7pL1DQliX/qiPCTNb0HX+eD0hLHQ==
X-Google-Smtp-Source: AGRyM1s4d2puB33O/T9ZpMjvcYVD7S+oZ6RWLXb6XSF9I5UfGhYLCPIUKNnXwENHXXVBA4rkxX/fWgn+dH+JerCBU+s=
X-Received: by 2002:a17:90b:388e:b0:1f0:3d7f:e620 with SMTP id
 mu14-20020a17090b388e00b001f03d7fe620mr1297053pjb.31.1658262819698; Tue, 19
 Jul 2022 13:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220718190748.2988882-1-sdf@google.com> <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
In-Reply-To: <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 19 Jul 2022 13:33:28 -0700
Message-ID: <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 1:21 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Motivation:
> >
> > Our bpf programs have a bunch of options which are set at the loading
> > time. After loading, they don't change. We currently use array map
> > to store them and bpf program does the following:
> >
> > val = bpf_map_lookup_elem(&config_map, &key);
> > if (likely(val && *val)) {
> >   // do some optional feature
> > }
> >
> > Since the configuration is static and we have a lot of those features,
> > I feel like we're wasting precious cycles doing dynamic lookups
> > (and stalling on memory loads).
> >
> > I was assuming that converting those to some fake kconfig options
> > would solve it, but it still seems like kconfig is stored in the
> > global map and kconfig entries are resolved dynamically.
> >
> > Proposal:
> >
> > Resolve kconfig options statically upon loading. Basically rewrite
> > ld+ldx to two nops and 'mov val, x'.
> >
> > I'm also trying to rewrite conditional jump when the condition is
> > !imm. This seems to be catching all the cases in my program, but
> > it's probably too hacky.
> >
> > I've attached very raw RFC patch to demonstrate the idea. Anything
> > I'm missing? Any potential problems with this approach?
>
> Have you considered using global variables for that?
> With skeleton the user space has a natural way to set
> all of these knobs after doing skel_open and before skel_load.
> Then the verifier sees them as readonly vars and
> automatically converts LDX into fixed constants and if the code
> looks like if (my_config_var) then the verifier will remove
> all the dead code too.

Hm, that's a good alternative, let me try it out. Thanks!
