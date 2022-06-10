Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2875546EDF
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348862AbiFJU4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348091AbiFJU4g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 16:56:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4169858E
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 13:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1408BB83277
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 20:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BBDC3411C
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654894591;
        bh=e2O9D52fiLQbLPE08FRNkYv8RE4vF9DnOCPOG3OqD4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iLIl2ISfqC+zdlIihsuQYtUYKRzNLcOeFjlNCwly/frQXmuS+sdaPR95aIzZ6sAMo
         I+Wgl0VmEb4E40Ni0SGTviNIz2r7yc5VUuM1xrEDKgi5E3gszg3wGcNZ5yP5+FvnWT
         GKHIxG2H0b0nbZ3T/2aVTBa98Fq+AI7txAH38lGQqn7gafxn754hb/Ap0V4tzR5mK1
         5YOi/RvrdG5YPudYif5NWGubkoDgMO2vAHFh3hqtb66DbIjVLM+lBLn+sUstY5EBek
         WOjEc7g8WwMCte9yEIKGVDPzf+iwIMrEo4KzX6iYLO01M8z+VWIsdZsuzbOSPG91Yl
         q5YZdvOmQfBZg==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31332df12a6so3720347b3.4
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 13:56:31 -0700 (PDT)
X-Gm-Message-State: AOAM532rI22pKmMfJEORsPCaoS62ogAbLuYkNYbkC+QvsB2xeuV86Ndz
        JGoJ1cMvM+skMWRLxIudL/nbahncb96yOZwn3fQ=
X-Google-Smtp-Source: ABdhPJyoAFcbQO4TL1BknHub/gsOqvpBnpWQaUf8wyF04YoeDdGhocu9FKKbedXgIfII5jseNuwtNeoNVMXOy1blLDk=
X-Received: by 2002:a81:3904:0:b0:310:cc3:15a2 with SMTP id
 g4-20020a813904000000b003100cc315a2mr45575178ywa.447.1654894590733; Fri, 10
 Jun 2022 13:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-3-eddyz87@gmail.com>
 <CAPhsuW4+BVYjodLT2tH3emqXzZxv1D7c3Tu5YuYtpB-1Vwtn5w@mail.gmail.com> <d28e28eafdd3f62160aa01f21d75b5c6581aaac2.camel@gmail.com>
In-Reply-To: <d28e28eafdd3f62160aa01f21d75b5c6581aaac2.camel@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 13:56:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7-3HVHHw8kYbUGMLpLrj5BoetpjBsV9KJ9u48a1M2MGw@mail.gmail.com>
Message-ID: <CAPhsuW7-3HVHHw8kYbUGMLpLrj5BoetpjBsV9KJ9u48a1M2MGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] selftests/bpf: allow BTF specs and func
 infos in test_verifier tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 10, 2022 at 12:16 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> > On Fri, 2022-06-10 at 11:09 -0700, Song Liu wrote:
>
> > > +static int load_btf_for_test(struct bpf_test *test)
> > > +{
> > > +       int types_num = 0;
> > > +
> > > +       while (types_num < MAX_BTF_TYPES &&
> > > +              test->btf_types[types_num] != BTF_END_RAW)
> > > +               ++types_num;
> > > +
> > > +       int types_len = types_num * sizeof(test->btf_types[0]);
> > > +
> > > +       return load_btf_spec(test->btf_types, types_len,
> > > +                            test->btf_strings, sizeof(test->btf_strings));
> >
> > IIUC, strings_len is always 256. Is this expected?
>
> Yes, as long as strings are zero terminated the actual buffer size
> shouldn't matter. So I decided that it would be better to avoid
> strings length specification in the test definition to keep things
> simpler.

Hmm.. OK, I guess this is acceptable for the test.

Acked-by: Song Liu <songliubraving@fb.com>
