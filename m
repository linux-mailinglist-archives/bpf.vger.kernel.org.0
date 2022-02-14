Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155604B5BAD
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 22:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiBNU7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 15:59:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiBNU7Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 15:59:24 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EC8145E1C;
        Mon, 14 Feb 2022 12:59:10 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id x4so8500904oic.9;
        Mon, 14 Feb 2022 12:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/bS6El9B0zRCiRKsjycXs0hnJXDV/WUGWitZwC9Ic4=;
        b=jILBRWKtzkWUzvcgS2TtBHr2FiKhc/8ebPSF7R/0nQgYxsyunQT0ay6z5V5NW6UJ9u
         lzzu6Rf5X0IX5cyZ8gwJ9qZ56Z7CAN3XeIkcULOv5Lonwc1t4Rvlk0AbXIsAcUXzpWYk
         L3cHi2ADLPm/hcYwXf997I+ZtmwbIpg2mfjXsrnj8ciiP9t+x69GDWT2QkBd4OR5f2PJ
         OIy3ISfH3csPXkqjTnYBNU8KOxtkTddTHMCmAtlYooeKJnSJQInOB5i5uUzdlCyI2Rsl
         1iKmxz4rQUQUBV/M8OWE/AcfS5hQA6baq5iuWI+V0YYk7A3sPYU7OdV2CSCfLE/XfxuH
         TQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/bS6El9B0zRCiRKsjycXs0hnJXDV/WUGWitZwC9Ic4=;
        b=KM22bbmih8XMMzW9p9NCNaRsYmMe49yM1IeSF/OVtXimjUW7kWVOVz5mEifa9KR60P
         g9SK3yTHLdMVXPwo/wdj0KIGceg4/OlRzt5vZ3v7XXCGHl/DaQB2HhM8qjTQT4XkUPdE
         nENlyqmAd0cAw5gWULX5RwQi8nZiE+hwjwcQc9fo604EPh5+frXFcqu8DKPx/22zMiGG
         mbRa4w8htsYoUJgQVTaFlQQJ9ZWvvvUassJgAd7rUl0n4DspznTOviSdzAZ8l8u3MFLI
         NRhgfwfV3xf8jJ1nxqb8STOTCf+i57J2SwwOvCbW1Aa1qLhCj9XizKsmOu/fU4qyqlc0
         yl5g==
X-Gm-Message-State: AOAM530n59oR9Ej8au5G+bwKoYT+B3NCRokXoac3Y5MJ549kSG+ULfWV
        1ovx1YESb0LY/BkUs0xl4zCz1fJrtS0Cah6FjNlt9ZGaiUw=
X-Google-Smtp-Source: ABdhPJxiqJIdP0aB2Rv0HqfuOL9ch+awC64MhNT3LqkpB13Zakymd/P6lSMJzSyuq5i+p9qw+9RdnXfOMO7ngYC62Zg=
X-Received: by 2002:a17:90b:1d84:b0:1b4:dc8e:2cc2 with SMTP id
 pf4-20020a17090b1d8400b001b4dc8e2cc2mr458721pjb.122.1644870485755; Mon, 14
 Feb 2022 12:28:05 -0800 (PST)
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
 <CAADnVQK+Eh9qCuoBWZ1cRQ4h+fS5J+zy+GePEGXijZ_BD_5Q3w@mail.gmail.com> <CA+khW7jeptVgZziTqexXp2dNC0Kk+di8f8xkd2dTzXb8YR0Mjw@mail.gmail.com>
In-Reply-To: <CA+khW7jeptVgZziTqexXp2dNC0Kk+di8f8xkd2dTzXb8YR0Mjw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 14 Feb 2022 12:27:54 -0800
Message-ID: <CAADnVQLvVEBowTKuRpYny47L6Az4C2LqrD3T4bnG_i2vCfE2TQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 5/5] selftests/bpf: test for pinning for
 cgroup_view link
To:     Hao Luo <haoluo@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 14, 2022 at 12:23 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Feb 14, 2022 at 11:25 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 14, 2022 at 10:29 AM Hao Luo <haoluo@google.com> wrote:
> > > Hi Alexei,
> > >
> > > Actually, I found this almost worked, except that the tracepoints
> > > cgroup_mkdir and cgroup_rmdir are not sleepable. They are inside a
> > > spinlock's critical section with irq off. I guess one solution is to
> > > offload the sleepable part of the bpf prog into a thread context. We
> > > may create a dedicated kernel thread or use workqueue for this. Do you
> > > have any advice?
> >
> > Are you referring to spin_lock in TRACE_CGROUP_PATH
> > that protects global trace_cgroup_path[] buffer?
>
> Yes, that's the spin_lock I am talking about.
>
> > That is fixable.
> > Do you actually need the string path returned by cgroup_path() in bpf prog?
> > Maybe prog can call cgroup_path() by itself when necessary.
> > Parsing strings isn't great anyway. The bpf prog probably needs the last
> > part of the dir only. So cgrp->kn->name would do it?
> > The TRACE_CGROUP_PATH wasn't designed to be turned on 24/7.
> > That global spin_lock is not great for production use.
> > No need to delegate sleepable bpf to thread context.
> > Let's refactor that tracepoint a bit.
>
> No, we don't need cgroup_path(). We are going to name the directories
> by cgrp->kn->id. I can add a fast version for cgroup_xxx tracepoints,
> which don't require the full path and can be turned on 24/7.

Sounds good. We need a flag for tracepoints anyway to indicate
which ones are sleepable.
Probably similar to what we did for DEFINE_EVENT_WRITABLE.
