Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4046665A2
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 22:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjAKV3k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 16:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjAKV3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 16:29:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038B45FBD
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 13:29:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9152461EDE
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 21:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0941C433F0
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 21:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673472571;
        bh=HTHuKO95Fe89VkAjQ/9y5aaIVDgYW1MOqdx459KaH54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p3D5rqpxeMW0rAuPl+VTG+iNANqVI4TO2WY/kzPUPpHi6qzbaf+lUGv4e0rHwBp2f
         at9R4P70MVkzEZEljp41AlxqTjS/s76Ft+GoW1SOcyWXxfTsBthjKYSLWnPTbULb4g
         nXCdtEd6Tgy38C2m5axKj7NuHRjY5WCOwE/zFobTcUHSjGEhGPsjnjIZUdDDJjJStF
         WgAvjjyQ4EcHEUY8sZFXK/IRKg/vcXC3jeZn5FQhYtyc7JAOFJdPPOwHCl2WN48qaz
         +OfWRizgiaP05xSyOLP1i4RIFUDZw/iKx2A1bzR7U4j4KK1RYAoxc+NjXwD+ugAPMm
         CmR/i+OqeKVGQ==
Received: by mail-lj1-f171.google.com with SMTP id n5so16855248ljc.9
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 13:29:30 -0800 (PST)
X-Gm-Message-State: AFqh2kqW1PzmjFp+PoenmcuTp/FDlzfezTYrcC72cCl2YEW4GK22MtOt
        qnv9H8JOOs6ruL/S1x1X4Z31w60d2MKZ1jYjbaI=
X-Google-Smtp-Source: AMrXdXtnbJhPqplI3/BK8VxdnUDcN4RE8RSvVrjHGYFxeVmTwaI4vfO3rD15KrcEnceyxLxWNrZ20tgIGeDbz2FJA3c=
X-Received: by 2002:a2e:86c3:0:b0:287:14be:5d05 with SMTP id
 n3-20020a2e86c3000000b0028714be5d05mr388503ljj.495.1673472568993; Wed, 11 Jan
 2023 13:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
 <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4Bzag8K=7+TY-LPEiBJ7ocRi-U+SiDioAQvPDto+j0U5YaQ@mail.gmail.com>
 <Y7YQHC4FgYuLWmab@maniforge.lan> <CAEf4BzaJ4h4o+nrApBPABZ8zu-f+TpuV4FUvEfHsrLRsu1bObw@mail.gmail.com>
 <20230106025420.6xdhhjsknhdhbu3d@MacBook-Pro-6.local> <CAEf4BzZTYcGNVWL7gSPHCqao_Ehx_3P7YK6r+p_-hrvpE8fEvA@mail.gmail.com>
In-Reply-To: <CAEf4BzZTYcGNVWL7gSPHCqao_Ehx_3P7YK6r+p_-hrvpE8fEvA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 11 Jan 2023 13:29:14 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4ix_Q_nBSMnOzQr3GJAozN0PUcgh2K=4mcYpUXQDTYYg@mail.gmail.com>
Message-ID: <CAPhsuW4ix_Q_nBSMnOzQr3GJAozN0PUcgh2K=4mcYpUXQDTYYg@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

 ()

On Mon, Jan 9, 2023 at 9:47 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 5, 2023 at 6:54 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jan 05, 2023 at 01:01:56PM -0800, Andrii Nakryiko wrote:
> > > Didn't find the best place to put this, so it will be here. I think it
> > > would be beneficial to discuss BPF helpers freeze in BPF office hours.
> > > So I took the liberty to put it up for next BPF office hours, 9am, Jan
> > > 12th 2022. I hope that some more people that have exposure to
> > > real-world BPF application and pains associated with all that could
> > > join the discussion, but obviously anyone is welcome as well, no
> > > matter which way they are leaning.
> > >
> > > Please consider joining, see details on Zoom meeting at [0]
> > >
> > > For the rest, please see below. I'll be out for a few days and won't
> > > be able to reply, my apologies.
> > >
> > >   [0] https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit#gid=0
> >
> > Thanks for adding it to the agenda.
> > Hopefully we'll be able to converge faster on a call.
>
> Yep, hopefully. Looking forward to BPF office hours this week.
>
> >
> > There are several things to discuss:
> > 1. whether or not to freeze helpers.
> > 2. whether dynptr accessors should be helpers or kfuncs.
> > 3. whether your future inline iterators should be helpers or kfuncs.
> > 4. whether cilium's bpf_sock_destroy should be helper or kfunc.

I think these are all big questions. Maybe we can start with some
smaller questions? Here is a list of questions I have:

1. Do we want stable kfuncs (as stable as helpers)? Do we want
   almost stable kfuncs? Will most users of stable APIs be as happy
   with almost stable alternatives?

2. Do we decide the stability of a kfunc when it is first added? Or
    do we plan to promote (maybe also demote?) stability later?

3. Besides stability, what are the concerns with kfuncs? How hard
    is it to resolve them?
    AFAICT, the concerns are: require BTF, require trampoline.
    Anything else? I guess we will never remove BTF dependency.
    Trampoline dependency is hard to resolve, but still possible?

4. We have feature-rich BPF with Linux-x86_64. Do we need some
   bare-minimal BPF, say for Linux-MIPS, or Windows-ARM, or
   even nvme-something? I guess this is also related to the BPF
   standard?

Thanks,
Song
