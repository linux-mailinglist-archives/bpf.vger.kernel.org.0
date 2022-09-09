Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFD25B42FB
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 01:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiIIXR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 19:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIIXR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 19:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ABBD0745
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 16:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4EE46216F
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 23:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C43BC433D6
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 23:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662765476;
        bh=GpF8YfSLE8ppS347as3MVPpVa2WRTyjhNkaLQYeVlfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FZ8ExW6lIcK8R1ZRiV1dEdz+pMBk1FQrPU3YRSqFb//JbljPIGDiuIaIh1HFFdGDu
         uzATmNDrz8luQkEQRd+v7twBgCuu7CUk4ebz+ZzX+6AANJu7c7e5QcK0DYynoLgtFy
         LBir155Pyj2P+dzoDLWKaodJmFdr8L0AVqLljhZnJDCN/pyRab1TfbnUJ2x5+MdG8d
         qQAkdjN0Q+Mxb89Q0TDUEMbNL5VJYWue8HkaO+iNIgf4/tyewiYgaWXI/oQTemd7Qp
         wdgPX0VGFsuM5Aam5gWoE4qkcHlRt/IG8Ft8Y8NaPBHT8N+ZGYAMD3SmBbalBq++u8
         5d3peg+1rrMNA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11eab59db71so7791616fac.11
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 16:17:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo1SW4ENHY61L+ByF8eDteu5nSwY85rM6bliP8uWT9nY5AFDF4Y0
        xGoIRfL2/yv0VUdARjXrs2GehT8NnH5jqxV7xb4=
X-Google-Smtp-Source: AA6agR4ShSoFpYUHYmnyNoT4Hq6S7y3xH2PB++xMwG5wozfNthcFBAReZSNKCn3pvRKT0i4eZ3K7NBs3X6RJQbFo6fU=
X-Received: by 2002:a05:6870:3127:b0:11c:8c2c:9015 with SMTP id
 v39-20020a056870312700b0011c8c2c9015mr6061769oaa.31.1662765475166; Fri, 09
 Sep 2022 16:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-4-joannelkoong@gmail.com> <CAPhsuW5+4xdJRTD-m781c=N_Rvu-aVCO-OgKwJi7i9sgNO4BkQ@mail.gmail.com>
 <CAJnrk1aVsNHeYwYwPGhB5pCyG2uCvYZbMD+eVCuYb+0Z4fc+kQ@mail.gmail.com>
In-Reply-To: <CAJnrk1aVsNHeYwYwPGhB5pCyG2uCvYZbMD+eVCuYb+0Z4fc+kQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Sat, 10 Sep 2022 00:17:44 +0100
X-Gmail-Original-Message-ID: <CAPhsuW4nC1p7EGavWDDhxGBDbq5CT5VemROLcip+dDUAFQa8rA@mail.gmail.com>
Message-ID: <CAPhsuW4nC1p7EGavWDDhxGBDbq5CT5VemROLcip+dDUAFQa8rA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        martin.lau@kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 10:28 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Fri, Sep 9, 2022 at 8:46 AM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Sep 8, 2022 at 1:07 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > Add two new helper functions: bpf_dynptr_is_null and
> > > bpf_dynptr_is_rdonly.
> > >
> > > bpf_dynptr_is_null returns true if the dynptr is null / invalid
> > > (determined by whether ptr->data is NULL), else false if
> > > the dynptr is a valid dynptr.
> > >
> > > bpf_dynptr_is_rdonly returns true if the dynptr is read-only,
> > > else false if the dynptr is read-writable.
> >
> > Might be a dump question.. Can we just let the bpf program to
> > access struct bpf_dynptr? Using a helper for this feel like an
> > overkill.
> >
> > Thanks,
> > Song
> >
>
> Not a dumb question at all, this is an interesting idea :) Right now
> the struct bpf_dynptr is opaque from the bpf program side but if we
> were to expose it (it'd still be read-only in the program), the
> program could directly get offset and whether it's null, but would
> need to do some manipulation to determine the size (since the last few
> bits of 'size' stores the dynptr type and rd-only) and rd-only. I see
> the advantages of either approach - personally I think it's cleaner if
> the struct is completely opaque from the program side but I don't feel
> strongly about it. If the worry is the overhead of needing a helper
> for each, maybe another idea is to conflate them into 1 general
> bpf_dynptr_get_info helper that returns offset, size, is_null, and
> rd-only status?

While all the helpers are fast direct calls, I think they are still slower
than simple memory accesses. It is probably a good idea to benchmark
the difference. While we can inline the helper functions in the verifier,
it is cleaner if we simply expose the data?

Thanks,
Song
