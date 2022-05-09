Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061E6520580
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 21:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbiEITwu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 15:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbiEITwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 15:52:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B2A3D1D1
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 12:48:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so248070pjb.3
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTK8z47V6qkv5ZONU04tsUwj/ztrROmxaApguf+uIGo=;
        b=AR/ri373fCt5Vi/hBFzVXDkd/EUToSAonmm7WX6GYnrooL5415OLlNj4mDfHYIyAPo
         uOXZNuY4mZvQ1uabHBoYJZUvn6K4k7RSkRHuEMkUursy6/EsqI7kXGDSWLcD4u8DpZxg
         7Z/7heXHqN3eubmOmbUet62QzY5p7Vclw4abgPUn7U9f48BTUfITC+Wl9J5mhMpMkjt1
         JvYJtrAZhdaLHQ5zEvvX7r/I0MaDCewS/bMJ0BwsQuArXZSgRO/o+SPdr+5Ts9Wni6v9
         vibjyLfsaJsCl/nserMKEv4iJIfH3pzTig1MOsHQ8ZpfitZFTDHgK+/5+8ncTtUn0ygs
         7Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTK8z47V6qkv5ZONU04tsUwj/ztrROmxaApguf+uIGo=;
        b=jOEKSD/vTchhzETeEXtuVindpZ/++eGiZ7BeLrGssCqwFOi1pO2rd3WwwnTWHWvIZJ
         gWJk4MtiVQjIR6i2UMOEzJHLnq0d1X24O660Zafrhr2V6A8kNDaYE4bEl4ZsPyXyM2dQ
         3XRQ/Dqea2QYgmBWpjlyZOEPHP6L5o+fi0NJAe9bJkT7DFVfuvUWh4mZpN0osqUw6wwK
         jdDYvU9OaoI9Rtc+Vo5FryOcDmOG0vyfYnW/wr7pRv8+yvn+rSuHJzCgsvaWZ+kYaB7r
         a15fUyftIsWCddjI6BFIuZln0rw8SjLPMXmjJgjS20SKq+HgN23+wr9Iwuljwy9RanfH
         fsvw==
X-Gm-Message-State: AOAM531omZQSpkLE/RbxmAEwV4U1cZT9DG2bqV9PO1MBc+GyCkBRzb4n
        maVrOddy1rd0t8X5RSpDIHCDCd01zcI=
X-Google-Smtp-Source: ABdhPJzA1VrbKYXpa4P/S0azGw5CoeDZABKvsQVLFVsgoRDo+yXqruj8xSDp00YKgh1LfSqpA3r73w==
X-Received: by 2002:a17:90b:4a01:b0:1dc:b062:da0e with SMTP id kk1-20020a17090b4a0100b001dcb062da0emr19495837pjb.87.1652125730079;
        Mon, 09 May 2022 12:48:50 -0700 (PDT)
Received: from localhost ([157.51.71.11])
        by smtp.gmail.com with ESMTPSA id h27-20020a056a00001b00b0050dc76281d7sm9314477pfk.177.2022.05.09.12.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 12:48:49 -0700 (PDT)
Date:   Tue, 10 May 2022 01:19:23 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v6 13/13] selftests/bpf: Add test for strict BTF
 type check
Message-ID: <20220509194923.sgqurmefkaunpqat@apollo.legion>
References: <20220424214901.2743946-1-memxor@gmail.com>
 <20220424214901.2743946-14-memxor@gmail.com>
 <20220426033937.jjcua6zchnka5dco@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAADnVQKdB13TUDUsKPUEtgMgKWDG9xUDa1WO3v7HSufqU-sE-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKdB13TUDUsKPUEtgMgKWDG9xUDa1WO3v7HSufqU-sE-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 09, 2022 at 03:29:13AM IST, Alexei Starovoitov wrote:
> On Mon, Apr 25, 2022 at 8:39 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 25, 2022 at 03:19:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> > >
> > > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> > > index 2e03decb11b6..743ed34c1238 100644
> > > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > > @@ -138,6 +138,26 @@
> > >               { "bpf_kfunc_call_memb_release", 8 },
> > >       },
> > >  },
> > > +{
> > > +     "calls: invalid kfunc call: don't match first member type when passed to release kfunc",
> > > +     .insns = {
> > > +     BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +     BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> > > +     BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> > > +     BPF_EXIT_INSN(),
> > > +     BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> > > +     BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> > > +     BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +     BPF_EXIT_INSN(),
> > > +     },
> > > +     .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> > > +     .result = REJECT,
> > > +     .errstr = "kernel function bpf_kfunc_call_memb1_release args#0 expected pointer",
> > > +     .fixup_kfunc_btf_id = {
> > > +             { "bpf_kfunc_call_memb_acquire", 1 },
> > > +             { "bpf_kfunc_call_memb1_release", 5 },
> > > +     },
> > > +},
> >
> > Please add negative C tests as well.
> > Consider using SEC("?tc") logic added by commit 0d7fefebea552
> > and put a bunch of bpf progs that should fail to load in one .c
>
> Kumar,
>
> ping?
> Are you still working on the follow up?

Yes, just got a bit stalled due to some IRL stuff... I'll post the follow up set
tomorrow.

--
Kartikeya
