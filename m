Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1165DD45
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 20:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjADT4K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 14:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbjADT4F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 14:56:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE73B88
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 11:56:04 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k19so15933840pfg.11
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 11:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GL9qc3LxvXagBCtSqVAYj+m4hsRmatQLtuw0RiWDYZw=;
        b=M6OzN8cFTpXG1AaQfjdrhd6bJFBZTFEsy8BRCI18XoNXqShKbqXfpBMF1lvMBXnVD3
         PqZ/S/KAbZ8SLlP2242LgNqrtdNHoJca6UUhY+twr1KZ2NbbBvUbh6EBd+/WicFynccS
         ViPFqW835zbUqgPWpe14rsTHuaSEyQCLEaHnaHOxJ6CkQPqXG14SqenPK+9NPFU8MHSf
         fheii8MJ76vUp5UIPtcNpdSu7tZZWCxQ9UeSyaS0JvCtXPTh+yR64MFqAIK2AgSxmvzA
         u60iWNN0IgZLJ9Ch2PBzKfs27dVX+zmkVOz634nEAOIkxBpWkAeyqoO5IN3FtL3lE5Ih
         5/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL9qc3LxvXagBCtSqVAYj+m4hsRmatQLtuw0RiWDYZw=;
        b=KiOJv2FV2T9AtfzSKyJa0R0S3zJvctbC/j21eXTQTKUIOKoomfociT7eJGltLlM8zm
         3m0YzW3NOH6jo4Q3BqIZJaRiCFDFKRys/yhiTdKLwjrRPFk8G67uCWrVM4KW9YhyVUX5
         L1MMuZzG0QbWzIF46PNRQYG1qd7jYWPrBCI5fcqFjkaX/mN6FUqXGgAwcxxkU/p2LeYX
         CiVOY4mYkqNRC9Xg5LBxEtu3vOqbgHlbC77kjHph+zu++oe9+lbm/nSMb5sZ6p+bfsfv
         kav9C3bfGStXwsF0teM7dtFqg9KIknIR62LJ7PUFSo2nhHjQhvFYT8w0/viXtnwUD6wK
         j3Cg==
X-Gm-Message-State: AFqh2ko+JCMMpJarEkT4U6fOMiXfYlH+GpYBiPzhyKqDmILBvWo/7bYO
        k3nRr4uXcFwMtftJNB5SxY4=
X-Google-Smtp-Source: AMrXdXvDxj6OWhvB+z6dp3oQEmUXi493uoKuI3Uf/nL5R5v+vOdJAQTO7h4JRBNthI1uhB/cP3w9sQ==
X-Received: by 2002:a05:6a00:1d8e:b0:578:16e6:815d with SMTP id z14-20020a056a001d8e00b0057816e6815dmr52387236pfw.21.1672862163527;
        Wed, 04 Jan 2023 11:56:03 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id 63-20020a620542000000b0056be1581126sm23573708pff.143.2023.01.04.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:56:02 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:56:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <20230104195600.wmsgfuhtjlzbgyrc@macbook-pro-6.dhcp.thefacebook.com>
References: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
 <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4Bzb06r3bbkngJDYD-XjHJ1ibW_eqr5JwSBATEqJFM0umuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb06r3bbkngJDYD-XjHJ1ibW_eqr5JwSBATEqJFM0umuQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 04, 2023 at 10:44:07AM -0800, Andrii Nakryiko wrote:
> >
> > Agree that any hard policy like 'only kfuncs from now on' gotta have its limits.
> > Maybe there will be a strong reason to add a new helper one day,
> > so we can keep the door open a tiny bit for an exception,
> > but for dynptr...
> > There are kfuncs with dynptr already (bpf_verify_pkcs7_signature)
> > So precedent is already made.
> 
> bpf_verify_pkcs7_signature() is using dynptr as a pointer to memory.
> It's a totally valid and intended use case, to pass memory area of
> statically unknown size, yes.
> 
> But that's very different from having basic dynptr helpers like
> is_null() and trim/advance as kfunc. Such helpers are stable, they
> manipulate generic attributes of dynptr: size, offset, underlying
> memory pointer. There is nothing unstable and potentially changing
> about them.

dynptr is defined in uapi as:
struct bpf_dynptr {
        __u64 :64;
        __u64 :64;
} __attribute__((aligned(8)));

So sizes, offset and memory pointer are not stable today and
there is no need to stabilize this part of it.

> From original exchange:
> 
> > > > So just because there is no perfect way to
> > > > handle all the SKB/XDP physical non-contiguity, doesn't mean that the
> > > > dynptr concept itself is flawed or not well thought out. It's just
> > >
> > > I think that's exactly what it means. dynptr concept is flawed.
> 
> Must be a lot of typos in here ;) because as written it clearly states
> that the whole concept of dynptr is flawed.

Maybe will we realize a year from now that it is?
We have some uapi exposure of dynptr in uapi. I think it's a safer bet
to keep it to the minimum.
