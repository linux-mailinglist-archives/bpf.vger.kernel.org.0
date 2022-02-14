Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FEB4B5B77
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 21:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiBNUuy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 15:50:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiBNUuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 15:50:46 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBB16BCF0
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 12:50:25 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id b22so15475587qkk.12
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 12:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDLiuYUP5DHdmjW4f062r2zlI41NFhxRv09UtgBUw+M=;
        b=QnBu1cdZSNMZMwTUOhTAgwrDV0UDotuXjd+L9tGoRib5LiAOViseQ3Shth3I3/9cUX
         F9FE9WP/n9IXs5G/YdanGCNFX3mwzenNKyGas7OHzij+neOt+7N0L8gulZksssphH0JK
         ZdAH701JpydqzO4zSQ63RxEFI/i6gMAqnIMJnBkw252CYXQsB0CmiD9JEAKRqabXkDss
         C24cvW5+nsV74dkDMeh0PKiv6q73XtCwF3kNhQmHGY7iVbEX5fIf1tLZZzQ/qHEwjapy
         YPS22mz/ReXGyT+0yl9O+kILA0cSXtpXCAn5q4MdtEBUg/J2KAwutMzm1ZQ8iCW+2Fdu
         29yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDLiuYUP5DHdmjW4f062r2zlI41NFhxRv09UtgBUw+M=;
        b=MI0B1NDhkdunAhF3tytghF4GvgOLMYSbAXbKG8fdvAJNi8IYVsi7ZjtHLqvAW45vlr
         Crq3BiAyEJDcathBmr4jB15ZqHcWEbGd7kZn/2qGeY8QNCmmRrfnOynp0u8yWNs82iMW
         pjOzhbbO+6h73T4Zf/W2jPptKYsjn1iqJzDaUPDfAURsq7y+JNBMlW/2qHBDtXZTUCeX
         ZK0oNgm38a1y/3yPObCBRncpVGEWHHJyEXCifDe8LYeycXhdnOi2AnzkHnBVUosoIp0U
         MmIjZUfHiGhk0ELnlFSlCiyWGM4vR+2HHlA6EqYQczlcFM5dNHtESZcTjhoL54oSm5Kw
         G/Hw==
X-Gm-Message-State: AOAM530k09bqU/z8+hEGbf5Nik8uuZDNcPm4u8QV+yX1xYuksbntEYEq
        p4lEIHev/gMe4d8nr8BzDBefuEmeN79CXLT5Mc398ugIMEcEog==
X-Google-Smtp-Source: ABdhPJzbvpTWXVuIjS/XjHNa8littqTkjF6TQBikKhXHbgTCjjUteC4b/xejz1U2eG7DGGSoU8BB+NLCXOAU65/AcM4=
X-Received: by 2002:a05:620a:470a:: with SMTP id bs10mr392145qkb.583.1644871152704;
 Mon, 14 Feb 2022 12:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com> <20220201205534.1962784-6-haoluo@google.com>
 <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7jkJbvQrTx4oPJAoBZ0EOCtr3C2PKbrzhxj-7euBK8ojg@mail.gmail.com>
 <CAADnVQLZZ3SM2CDxnzgOnDgRtGU7+6wT9u5v4oFas5MnZF6DsQ@mail.gmail.com>
 <CA+khW7i+TScwPZ6-rcFKiXtxMm8hiZYJGH-wYb=7jBvDWg8pJQ@mail.gmail.com>
 <CAADnVQ+-29CS7nSXghKMgZjKte84L0nRDegUE0ObFm3d7E=eWw@mail.gmail.com>
 <CA+khW7iWd5MzZW_mCfgqHESi8okjNRiRMr0TM=CQzLkMsa_a5g@mail.gmail.com>
 <CAADnVQJcTAgcbwrOWO8EnbTdAcQ91HQmtpn7aKJGwHc=mEpJ1g@mail.gmail.com>
 <CA+khW7i46Rg8q=8goXdmuJuZ+NOuZ5AP6fSbSVzyqcU3C5iX4A@mail.gmail.com>
 <CAADnVQK+Eh9qCuoBWZ1cRQ4h+fS5J+zy+GePEGXijZ_BD_5Q3w@mail.gmail.com>
 <CA+khW7jeptVgZziTqexXp2dNC0Kk+di8f8xkd2dTzXb8YR0Mjw@mail.gmail.com> <CAADnVQLvVEBowTKuRpYny47L6Az4C2LqrD3T4bnG_i2vCfE2TQ@mail.gmail.com>
In-Reply-To: <CAADnVQLvVEBowTKuRpYny47L6Az4C2LqrD3T4bnG_i2vCfE2TQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 14 Feb 2022 12:39:01 -0800
Message-ID: <CA+khW7gY9O+=8MExreeV6jziMSEJVMSvP2Nvn9FRwvA4d6ipdA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 5/5] selftests/bpf: test for pinning for
 cgroup_view link
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 14, 2022 at 12:28 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 14, 2022 at 12:23 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Feb 14, 2022 at 11:25 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Feb 14, 2022 at 10:29 AM Hao Luo <haoluo@google.com> wrote:
> > > > Hi Alexei,
> > > >
> > > > Actually, I found this almost worked, except that the tracepoints
> > > > cgroup_mkdir and cgroup_rmdir are not sleepable. They are inside a
> > > > spinlock's critical section with irq off. I guess one solution is to
> > > > offload the sleepable part of the bpf prog into a thread context. We
> > > > may create a dedicated kernel thread or use workqueue for this. Do you
> > > > have any advice?
> > >
> > > Are you referring to spin_lock in TRACE_CGROUP_PATH
> > > that protects global trace_cgroup_path[] buffer?
> >
> > Yes, that's the spin_lock I am talking about.
> >
> > > That is fixable.
> > > Do you actually need the string path returned by cgroup_path() in bpf prog?
> > > Maybe prog can call cgroup_path() by itself when necessary.
> > > Parsing strings isn't great anyway. The bpf prog probably needs the last
> > > part of the dir only. So cgrp->kn->name would do it?
> > > The TRACE_CGROUP_PATH wasn't designed to be turned on 24/7.
> > > That global spin_lock is not great for production use.
> > > No need to delegate sleepable bpf to thread context.
> > > Let's refactor that tracepoint a bit.
> >
> > No, we don't need cgroup_path(). We are going to name the directories
> > by cgrp->kn->id. I can add a fast version for cgroup_xxx tracepoints,
> > which don't require the full path and can be turned on 24/7.
>
> Sounds good. We need a flag for tracepoints anyway to indicate
> which ones are sleepable.
> Probably similar to what we did for DEFINE_EVENT_WRITABLE.

No problem. I'll take a look at it. Thanks!
