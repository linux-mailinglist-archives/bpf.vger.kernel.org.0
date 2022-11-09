Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589D8623031
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 17:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKIQeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 11:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIQeA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 11:34:00 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160E412AB7
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 08:33:58 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id k22so17190861pfd.3
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 08:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BRNKofCO4axNKhJQw2nNX1TtMf9Uuve+u5bSJS9XJE=;
        b=Ch2MxWBtz5ka6BF12mWwspmevALDI2rY/HigmYbbEVcktBtN5sAcPvthryJhmdFzUY
         GpWBTE1roVLznNYBwcX3QOvzyCUU5dYTsSmUHQzHOPa62Z2B2t79feJNbL9Pi+QXsQCA
         B46nHM9qmJdiz5JRv1ZUViOTK/qRlEeW7W/xInRHcnskSWFXibomC3bSK8bpZKz9/zvW
         4PQNwxtaifqlxuW7BXYpKUkw6TOjDqvYna2ULVWVdcOxr79HO/xc7LEy9zAEHDIgvVSE
         kSG1FMBsGRaRsXVSa6vsAoaGuPFYdcCkLUDlmPExZ3O/PihxNAAzvozM7lOUbZ8aU+J9
         TAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BRNKofCO4axNKhJQw2nNX1TtMf9Uuve+u5bSJS9XJE=;
        b=bEWK8RxwQZEqO5jBx2iLE2tnJkaonVApn/ByiqlrAzstxutcP3mBpZjmYpLb8b3leC
         12TjSQ2d1GfCka/B+kl+1am5SgtcgUTR9cmomfcVnOAfre5W3lAbubufG1l27ASWB4Xf
         ypX4Ew3b+hD0c5ANaZakrGbFzlKyG5Hi7KhE4sgFYsFKjtE+xAG7GAliikk/l9G263aF
         Wqrsbvs5/GENQhaUBMCAqKoOXe+/3frRYJbr0sHKT2HpQyE2tx8jg5c9b/8y6IYR43mp
         K47NQ1P2edYp5FM6D/Fb2RtsJaSTazQlRq/zHIojNhMRGUQalj1WMHJC0s17kcy0+tHm
         ZpPA==
X-Gm-Message-State: ACrzQf0M1genvyQ6vNU5p8YSmCaQzfbzmcaDy/U4ou2Z+mpIDTRnmPQd
        eHmCuOayyJoBxll899rC0yg=
X-Google-Smtp-Source: AMsMyM58q5DNjGrESAwwACwxyEGwZyaWl6q9fCk7tNFytZJsdIIIJaT5jEhphEK9oNRViQfCbFp3Cw==
X-Received: by 2002:a63:a06:0:b0:458:2853:45e4 with SMTP id 6-20020a630a06000000b00458285345e4mr51271361pgk.20.1668011637450;
        Wed, 09 Nov 2022 08:33:57 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090a670400b0020dda7efe61sm1461610pjj.5.2022.11.09.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:33:57 -0800 (PST)
Date:   Wed, 9 Nov 2022 22:03:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v5 25/25] selftests/bpf: Add BTF sanity tests
Message-ID: <20221109163351.tjharqbhffnmebqq@apollo>
References: <20221107230950.7117-1-memxor@gmail.com>
 <20221107230950.7117-26-memxor@gmail.com>
 <CAEf4BzZCki9Dmqms4E643t6RctZxo3BowQvPY1u5Ht1zdiOxHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZCki9Dmqms4E643t6RctZxo3BowQvPY1u5Ht1zdiOxHg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 05:48:00AM IST, Andrii Nakryiko wrote:
> On Mon, Nov 7, 2022 at 3:11 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Preparing the metadata for bpf_list_head involves a complicated parsing
> > step and type resolution for the contained value. Ensure that corner
> > cases are tested against and invalid specifications in source are duly
> > rejected. Also include tests for incorrect ownership relationships in
> > the BTF.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/linked_list.c    | 271 ++++++++++++++++++
> >  1 file changed, 271 insertions(+)
> >
>
> Have you considered using BTW write API to construct BTFs?
> btf__new_empty() + btf__add_xxx()?
>

I didn't know about these. Let me give them a shot!
