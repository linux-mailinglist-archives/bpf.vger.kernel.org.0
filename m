Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434EE63DCAD
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 19:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiK3SHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 13:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiK3SHG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 13:07:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BC81380
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 10:07:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1FB7B81C89
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 18:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C9BC433C1
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669831619;
        bh=gHBGkQE/15kIFbFX/pYnySaoBdoXJY4s8Kq52CGH+Z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YlzCVm+pUb2MindAjLmQ3CYk5GJBPv3eFL0DgH1p66yFV3D20v4qdpWhfoEYQej7S
         Zcp2AXyDINIPrZTIsYAGQl4fF0RjMXNFAP7aYDton5hG31AtTZdnOJ8FibPtCT4yY8
         s/fycPRHVygWFEdNSOPPZvm2rlETia87HKn6B5pNCwoOLyDBZzQYLzQHRI9v6HQLO6
         gKZW8aTJ4nNPDzOu9Kyr52r4qohJUB/GkxpMUmAqYfu3zCSj8ScHJ5idmefRznNgIp
         uszyUXGOxiGMMvNjp06YrP061tlrsS6SDExsVi/f0lJHFCBl4ammzRYUdyg4QyVWGr
         0Ax53UEa4inNQ==
Received: by mail-ed1-f49.google.com with SMTP id z20so25134463edc.13
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 10:06:59 -0800 (PST)
X-Gm-Message-State: ANoB5pnwJTMPluLh6zZG09WgY/RDJSBmqBB3AaVAk7+OfzYWsjQk/lGy
        jc1T4wkqr0vmt1TodDvvfHWctpPiShgxgpGh03w=
X-Google-Smtp-Source: AA0mqf6RJlgZPCdUAejqoYDt88WeLLL14wM98Zbnx4hCZdCQCgoKFmlR9WjRKzl9PX5WDEdp7EOo9Myy9s6Zh3VMjco=
X-Received: by 2002:a05:6402:240c:b0:462:2c1c:8791 with SMTP id
 t12-20020a056402240c00b004622c1c8791mr43434744eda.29.1669831617889; Wed, 30
 Nov 2022 10:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20221129161612.45765-1-laoar.shao@gmail.com> <CA+khW7jjfQOLnx6-4UyJ8sYTj12qzp_NmiZJ-uiSwGU754hbXg@mail.gmail.com>
 <CALOAHbCGSigE9vjvw6DczLbRF=TaQ3vmh6SHvMvoAChM_6Mdfg@mail.gmail.com>
In-Reply-To: <CALOAHbCGSigE9vjvw6DczLbRF=TaQ3vmh6SHvMvoAChM_6Mdfg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 30 Nov 2022 10:06:45 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7B1fM=JYG0OeHPZU7isv+O2_OPc22EBsdC6ZNEWusqXA@mail.gmail.com>
Message-ID: <CAPhsuW7B1fM=JYG0OeHPZU7isv+O2_OPc22EBsdC6ZNEWusqXA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Allow get bpf object with CAP_BPF
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 30, 2022 at 3:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
[...]
> I understand that allowing ID->FD transition for CAP_SYS_ADMIN only is
> for security.
> But it also prevents the user from transiting its own bpf object ID,
> that is a problem.
>
> > From the commit message, I'm not clear how BPF is debugged in
> > containers in your use case. Maybe the debugging process should be
> > required to have CAP_SYS_ADMIN?
> >
>
> Some container users will run bpf programs in their container,
> sometimes they want to check the bpf objects created by themselves  by
> using bpftool or read/write the bpf maps with their own tools. But if
> the bpf objects are not pinned, the only way to get these bpf objects
> is via SCM_RIGHTS.
> There should be a general way to get the FD of their own objects when
> CAP_BPF is enabled.
> With CAP_SYS_ADMIN, the container user can do almost anything, which
> is very dangerous.
> While with CAP_BPF, the risk can be kept within BPF.
>
> I think we should improve this situation by allowing the user to
> transit its own bpf object IDs.
> There are some possible solutions,
> 1. introduce BPF_ID namespace
>     Let's use namespace to isolate the bpf object ID instead of
> preventing them from reading all IDs.
> 2. introduce a global sysctl knob to allow users to do the ID->FD transition
>     for example, introduce a new value into unprivileged_bpf_disabled.
>     -0 Unprivileged calls to ``bpf()`` are enabled
>    +0 Unprivileged calls to ``bpf()`` are enabled except the calls
>    +  which explicitly requires ``CAP_BPF`` or ``CAP_SYS_ADMIN``
>     1 Unprivileged calls to ``bpf()`` are disabled without recovery
>     2 Unprivileged calls to ``bpf()`` are disabled
>   +3 All unprivileged calls to ``bpf()`` are enabled
>
> WDYT ?

Personally, I think some namespace might be the solution we need.
But adding a namespace is a lot of work, so we need to make sure to
do it correctly.

This might be a good topic to discuss in the BPF office hour.

Thanks,
Song
