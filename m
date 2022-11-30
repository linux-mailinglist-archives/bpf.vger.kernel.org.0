Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2790C63D51C
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 12:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiK3L7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 06:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiK3L7a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 06:59:30 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C86F361
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 03:59:29 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id bn5so20620639ljb.2
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 03:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gj7/aud18c79UPbap/PjZJH8sdKYK9iCcm0MZSTkJY8=;
        b=lurYD+lbiutg+lLBuuahQLmjQUlfbUUlGaDa5R71T1Huvfc30m29Wcvn5+Kb1qc+KA
         0wk+NQ7/PrSVLcC871d0QNKkjqNhT/nqrL/+/NFs+A6MiwjWheRghbKlGDqDglTWDa8Y
         Br33Zt+uAKX/vymjHMFmXrxkB37IUCaJQeYZqHcFrZpzSYxh1G6jBD5/IB/JteKnttPU
         oeSY6d3T9iwNrsG+6QLt4HnH95056BYCp/HbyGlEo473tRQK+mVMakDF8CrXmEL3ALCZ
         ZlGHe4T0QkZXsvj/9vi+t6cu/bdwPwbWJ62uPPCNkTv//8mm2UKyu/JImRRDrUgYY+An
         MCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gj7/aud18c79UPbap/PjZJH8sdKYK9iCcm0MZSTkJY8=;
        b=gL/y00gmxezT0qfyzavA8ZgGtfRMPSpAHD1de34Vrj3j4muilNfghnr7K/UytR8scp
         CgmTAR6mdi8706dsLexBXk3ZA961YWdBnmhV8M80rsa4UPseTb0mD3BoXN2dICJQfrHf
         +XvNniFJi952lOOtCuteFK8JEmrSUqCY2EbarlyxTwCM9DuRGuy80qfZvd9lKQiG2ijK
         Ls0P1Hjjs/DwXsEJ1jr9NE3HzxOG03Z81Wccg0qsbhY2LDbwjFIEvpAjmy9KDuTW5Dtv
         D/Nw4TL0ZsStkq61kxlzBH++Ikuws7EXGX3yjV71OVr9XwQCbf2PZi5SRctCdKrOLOPO
         /YMQ==
X-Gm-Message-State: ANoB5pkwzGWiqSn+sgyrPAQnEeXfolGseHvwM216ZWEDB3CZjMBFzupx
        raX1wBv5RMTtIaOzutRogpCBaROadNr0Y0W59GfMKGeYW/8DhKtf
X-Google-Smtp-Source: AA0mqf4/i5vTJO1S4IahzwbCFE9UoTPyoMttY0kEoCvdnh61LonmYmwV3XYuhLh2UreT7UBwRapsPt+fszqM1hGMML0=
X-Received: by 2002:a2e:b004:0:b0:279:c02e:7457 with SMTP id
 y4-20020a2eb004000000b00279c02e7457mr1800903ljk.475.1669809567901; Wed, 30
 Nov 2022 03:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20221129161612.45765-1-laoar.shao@gmail.com> <CA+khW7jjfQOLnx6-4UyJ8sYTj12qzp_NmiZJ-uiSwGU754hbXg@mail.gmail.com>
In-Reply-To: <CA+khW7jjfQOLnx6-4UyJ8sYTj12qzp_NmiZJ-uiSwGU754hbXg@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 30 Nov 2022 19:58:51 +0800
Message-ID: <CALOAHbCGSigE9vjvw6DczLbRF=TaQ3vmh6SHvMvoAChM_6Mdfg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Allow get bpf object with CAP_BPF
To:     Hao Luo <haoluo@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
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

On Wed, Nov 30, 2022 at 8:44 AM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Nov 29, 2022 at 8:16 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > In the containerized envriomentation, if a container is not
> > privileged but with CAP_BPF, it is not easy to debug bpf created in this
> > container, let alone using bpftool. Because these bpf objects are
> > invisible if they are not pinned in bpffs. Currently we have to
> > interact with the process which creates these bpf objects to get the
> > information. It may be better if we can control the access to each
> > object the same way as we control the file in bpffs, but now I think we
> > should allow the accessibility of these objects with CAP_BPF.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/syscall.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
>
> As far as I can tell, requiring CAP_SYS_ADMIN on iterating IDs and
> converting IDs to FDs is intended and is an important design in BPF's
> security model [1]. So this change does not look good.
>

I understand that allowing ID->FD transition for CAP_SYS_ADMIN only is
for security.
But it also prevents the user from transiting its own bpf object ID,
that is a problem.

> From the commit message, I'm not clear how BPF is debugged in
> containers in your use case. Maybe the debugging process should be
> required to have CAP_SYS_ADMIN?
>

Some container users will run bpf programs in their container,
sometimes they want to check the bpf objects created by themselves  by
using bpftool or read/write the bpf maps with their own tools. But if
the bpf objects are not pinned, the only way to get these bpf objects
is via SCM_RIGHTS.
There should be a general way to get the FD of their own objects when
CAP_BPF is enabled.
With CAP_SYS_ADMIN, the container user can do almost anything, which
is very dangerous.
While with CAP_BPF, the risk can be kept within BPF.

I think we should improve this situation by allowing the user to
transit its own bpf object IDs.
There are some possible solutions,
1. introduce BPF_ID namespace
    Let's use namespace to isolate the bpf object ID instead of
preventing them from reading all IDs.
2. introduce a global sysctl knob to allow users to do the ID->FD transition
    for example, introduce a new value into unprivileged_bpf_disabled.
    -0 Unprivileged calls to ``bpf()`` are enabled
   +0 Unprivileged calls to ``bpf()`` are enabled except the calls
   +  which explicitly requires ``CAP_BPF`` or ``CAP_SYS_ADMIN``
    1 Unprivileged calls to ``bpf()`` are disabled without recovery
    2 Unprivileged calls to ``bpf()`` are disabled
  +3 All unprivileged calls to ``bpf()`` are enabled

WDYT ?

-- 
Regards
Yafang
