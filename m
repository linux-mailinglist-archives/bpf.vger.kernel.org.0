Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394723B161D
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFWIrX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhFWIrW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Jun 2021 04:47:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03743C061574
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 01:45:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h15so2704705lfv.12
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mnf/412BXT3SW6cMM4XrHUEIZkc2F6iPAGQOAC9hxkI=;
        b=HRe8ptDqAKO9fbUgdpEpgLH+fZ2WoPny5DL8SFLjklM1wPMdFyZ8rDTy5Zf6zytLuS
         yyW3HOR8JXPAcThdImno7gqL53pekgyvJAV+R0hQiNDQIQ1BNzjJDPX99dsjp6ueApbx
         S8iiesbcp2zi71iXH0Mdkm02Z96nIOuol/S3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mnf/412BXT3SW6cMM4XrHUEIZkc2F6iPAGQOAC9hxkI=;
        b=BTLy0hNGItm4Goo8wjsfKxcHx2zUbkcdokgViN1pYcnDxHT3qrEyBF0h9JYSwBVvgK
         /wzkvMe/3D3IxZG3oMm6SuA1Dlw/bJE3lOi9YBs2L2jcP/7ocSmOXEe06pvTu2SPgAGM
         9mvAR45FP6uix7VqRHUez4mIgM3bjYsvxKENQwpGAiML4c1cYdWIveXXqA0XBrdBlYoa
         Ogzarhq7nfBnkUEFfoWRHjaz4kt15gae6qNLDpOA0qeJoZeCVYYzeORSd9/gJmgYEmly
         JKiqUDSKDL7tI0qanpBxU7EzoI11n77BMD7uiT1EsZBSyDrTwMQFUHtWcmBmQTwQ0c7o
         iUhw==
X-Gm-Message-State: AOAM532C895mpn8RGpAZqiFzIxtTJQwSAStrDnOK4PCPiXmYPH4SlOFc
        aLRRVPnvGkh5W8fKwEtwlQ1TNRlojA7B54iDGIHBmw==
X-Google-Smtp-Source: ABdhPJzixrwlbsgihe9DSf0fQWrERfgmVQa0QAoHiwkWYylAeOsi7OM1vaTkpZk9MirF+w40feaVLpI7dAXAZ3q1yY0=
X-Received: by 2002:ac2:4db6:: with SMTP id h22mr5928298lfe.171.1624437903317;
 Wed, 23 Jun 2021 01:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210618105526.265003-1-zenczykowski@gmail.com>
In-Reply-To: <20210618105526.265003-1-zenczykowski@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 23 Jun 2021 09:44:52 +0100
Message-ID: <CACAyw9-UnQODTf+=xEmexpWE6zhYUQfp7go76bEEc_A1rAyd7Q@mail.gmail.com>
Subject: Re: [PATCH bpf] Revert "bpf: program: Refuse non-O_RDWR flags in BPF_OBJ_GET"
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 18 Jun 2021 at 11:55, Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> From: Maciej =C5=BBenczykowski <maze@google.com>
>
> This reverts commit d37300ed182131f1757895a62e556332857417e5.
>
> This breaks Android userspace which expects to be able to
> fetch programs with just read permissions.
>
> See: https://cs.android.com/android/platform/superproject/+/master:framew=
orks/libs/net/common/native/bpf_syscall_wrappers/include/BpfSyscallWrappers=
.h;drc=3D7005c764be23d31fa1d69e826b4a2f6689a8c81e;l=3D124

As a follow up, what does Android expect to be able to do with this
read only FD?

Lorenz

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
