Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95134D0D9C
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 02:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiCHBmK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 20:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiCHBmK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 20:42:10 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25D3917B
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 17:41:15 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v3so14908866qta.11
        for <bpf@vger.kernel.org>; Mon, 07 Mar 2022 17:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErKRE5mbBNHWyIMWkZ+Y1JDfrp1HxcmRHBAjIGcM8Zk=;
        b=YK++WPa825qy/2r0ssbk2brsXUVrfaf2YKYyOoy5+OFGNzTZxozoH4rUkdypQv1yZN
         UCOfbDuG51INRVxWDIzIwnMEPGpanhWYyElL7fQaI8sjdFeM0rc5z+nCmbyPnm/Q2tas
         blPhwHjZZqq2LTUIvpCBuLgDb4gaQP0y8DLbG2N8T+KQMvMd2CJIhNyAbQalK/JtpBz1
         7p+mQbMbwVTOOZYERejEo7cIJ+TqXehZrN/sg6lMCBCUi/PZDPIxprJdHFS18fl59fCI
         jTpDde1VzLqGPAmLgutkQ6GETL8t5mFwBmbiWwn5lIkfoldBSL/zlqlsEA57ar4ubTq5
         bSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErKRE5mbBNHWyIMWkZ+Y1JDfrp1HxcmRHBAjIGcM8Zk=;
        b=qIwQHcekLlKXEOYqgsyWO2E3ZrV7IkjdwU1wD7pPTqW+wA5VEgSuQKdTImiWtOpjnB
         kl+R3qISfdGhWvsmZUcttcNC7YGd/v3txcwQu1ItuIZyUQLUWWAixU3Z77vjWefcRK3v
         cSAXEX43JXYbOJuML2+D04lmRjaDl/XwM9gq9IYebJFDoEv8vKH5vXL/nCJfyloHd8cO
         zBLdcD3kJagt9s/qJtTxAR6l2GJIM6PWL9wfGg3o/d02QkKxiGWCMl678zS93hjGnfHo
         n6FlNn4675vFTKFfd7gHcElLbfrzzIa/dtKMKiqzAoJhBocXUfdcsY50WuLX5iI8totP
         w33g==
X-Gm-Message-State: AOAM530oFjiKJMzCdhIOf8UXmnKJ2hX2DQsj7Fa3DWpHfwF9C7iOzikH
        2vmXrqv44oRdMpNSSs0wrp++7DFKNITp04fANDM4/qYyP8M=
X-Google-Smtp-Source: ABdhPJzLF1oHhhxqy3UUFRbzQORjgV+Duw7uWm3INPE6fGHg+8MDQIp83xZY4ZvwbZdQsWb09FW5YgoYhkK3+/34WMQ=
X-Received: by 2002:ac8:5a4f:0:b0:2dd:e0d4:a4f1 with SMTP id
 o15-20020ac85a4f000000b002dde0d4a4f1mr11811151qta.478.1646703674076; Mon, 07
 Mar 2022 17:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20220304191657.981240-1-haoluo@google.com> <20220304191657.981240-5-haoluo@google.com>
 <b26d6c7d-cba1-8b54-2939-95f4232e3c4c@fb.com> <20220306024905.ienwjn3vs2ecjavk@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220306024905.ienwjn3vs2ecjavk@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 7 Mar 2022 17:41:03 -0800
Message-ID: <CA+khW7h6T0RGSJf6vYeeYJLdqJWPHCAaD3dGYYrnAEnFSDmWXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Add a test for
 btf_type_tag "percpu"
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, acme@kernel.org,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 5, 2022 at 6:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 05, 2022 at 01:20:42PM -0800, Yonghong Song wrote:
> >
> > On 3/4/22 11:16 AM, Hao Luo wrote:
[...]
> > > ---
> > >   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  17 ++
> > >   .../selftests/bpf/prog_tests/btf_tag.c        | 164 ++++++++++++++----
> > >   .../selftests/bpf/progs/btf_type_tag_percpu.c |  66 +++++++
> > >   3 files changed, 218 insertions(+), 29 deletions(-)
> > >   create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
[...]
> > > +noinline int
> > > +bpf_testmod_test_btf_type_tag_percpu_1(struct bpf_testmod_btf_type_tag_1 __percpu *arg) {
> > > +   BTF_TYPE_EMIT(func_proto_typedef);
> > > +   BTF_TYPE_EMIT(func_proto_typedef_nested1);
> > > +   BTF_TYPE_EMIT(func_proto_typedef_nested2);
> >
> > Are these necessary? They have been defined in
> > bpf_testmod_test_btf_type_tag_user_1().
>
> Yonghong,
> Thanks. Good catch. I've removed those while applying.
>

Thanks Yonghong and Alexei. I wasn't sure their purpose and not sure
whether I should include them, so copy-pasted it.

> Hao,
> Great work.
> I really liked how patch 3 discovers MEM_PERCPU flag from
> two sources: percpu_datasec and clang tag.

Thanks Alexei! The BTF infrastructure together with clang tag is
really amazing! [thumbs up]
