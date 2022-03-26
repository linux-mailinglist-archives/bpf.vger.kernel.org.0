Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7663E4E8294
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 18:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiCZRIn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Mar 2022 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiCZRIn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Mar 2022 13:08:43 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54F4614A
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 10:07:06 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 125so12337243iov.10
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lAbsm/9A8/hlxK0NxovzYU/AT4alExVTYIL4ws1sEPA=;
        b=odcCyewlLofS97ThzOb50/kBhzt4xTmLB8LPKMX0MGxjj5sanUJqdp8e19P6l0tsCn
         drd4xm1OcFDJjTua2cQvj82HpuhiJBMAgBha8nc+QIlhPavspZqcs7r5JgmvsWRk+oyS
         9ZokeV8edoItoAaQzqtqWYwwmLQJQqt7yfaoT/jucyk9HSIDETRE1bUTl6h75f4iEfjp
         1t1q+N6sxzO+N/Sd9FXItdiHRCsutOi8NGaGwUXoPJ4IjFtK2EtnGvOsMKFoAZmLRqB+
         0zqdYLwzAZN51msTKwG4Z+yDBBWs8tY10eI4x6/68gjZe/jXJGklXh35PMrdQR18oGvZ
         FFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lAbsm/9A8/hlxK0NxovzYU/AT4alExVTYIL4ws1sEPA=;
        b=TbfqZ/1TEFG5T9/ROAHZMQs4iSxK8DmghWhid6Oo6tzJlq8lg/sXx4MabIdXuAc+ek
         7hsS3+34WbN9VZevTMuBVEyEey/cGtJXLhMluZqRyhEH2H9aWzRb/4UAik5mIFluwIxk
         a4pKOQmJ3SiCNe7T+0Gf2voLuaxN0btcLXkzuQ6vJMbT9x+9bVqZL34axf9gWDxyw+xl
         xPQnPejIm9VJy4W16X8yPc42KtEecfR3nn43t1pXjAF17rcK7st0U0QeM8Om0XSqZj74
         3PxvFgE1VA6DQpTJ2KwCiDniNr6arGZXHTKgfzgVBIqV0/+2FvTGxEJUCNyOcvQX3dVd
         DJ1w==
X-Gm-Message-State: AOAM530Q4/hbe60OoKABdcEgAj+TVaAXK52/11q1IdkgvK7SPKBPzFBM
        eLsxxunudgpgysNkBXNVW3/HXmGOiqELBInZid1YXg==
X-Google-Smtp-Source: ABdhPJz4EhdAT4vz5cpyykkpLdsQgmE9vXa45+UR8CESY2SRqlZuAemuONqIDxLaq5eHY/Iiwsb435+KuoUm1kA12qA=
X-Received: by 2002:a05:6638:4194:b0:319:c062:965b with SMTP id
 az20-20020a056638419400b00319c062965bmr8069123jab.187.1648314425552; Sat, 26
 Mar 2022 10:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220322154231.55044-1-fankaixi.li@bytedance.com> <2dea8e1c-b3c8-d9ae-aed8-fc78dd624a51@fb.com>
In-Reply-To: <2dea8e1c-b3c8-d9ae-aed8-fc78dd624a51@fb.com>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Sun, 27 Mar 2022 01:06:54 +0800
Message-ID: <CAEEdnKF2q37fNXw7thMCY_8g7m1maj7m+ra-PFg=mHPYuo1Vrg@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 0/3] bpf: Add support to set and get
To:     Yonghong Song <yhs@fb.com>
Cc:     kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
        ast@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8826=E6=97=A5=E5=
=91=A8=E5=85=AD 00:46=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 3/22/22 8:42 AM, fankaixi.li@bytedance.com wrote:
> > From: "kaixi.fan" <fankaixi.li@bytedance.com>
> >
> > Now bpf code could not set tunnel source ip address of ip tunnel. So it
> > could not support flow based tunnel mode completely. Because flow based
> > tunnel mode could set tunnel source, destination ip address and tunnel
> > key simultaneously.
> >
> > Flow based tunnel is useful for overlay networks. And by configuring tu=
nnel
> > source ip address, user could make their networks more elastic.
> > For example, tunnel source ip could be used to select different egress
> > nic interface for different flows with same tunnel destination ip. Anot=
her
> > example, user could choose one of multiple ip address of the egress nic
> > interface as the packet's tunnel source ip.
> >
> > v1 -> v2:
> > v1: https://lore.kernel.org/bpf/20220319130538.55741-1-fankaixi.li@byte=
dance.com
> >
> > - Add secondary ip and set tunnel remote ip in "add_vxlan_tunnel" and
> > "add_ip6vxlan_tunnel"
> >
> > kaixi.fan (3):
> >    bpf: Add source ip in "struct bpf_tunnel_key"
> >    selftests/bpf: add ipv4 vxlan tunnel source testcase
> >    selftests/bpf: add ipv6 vxlan tunnel source testcase
> >
> >   include/uapi/linux/bpf.h                      |   4 +
> >   net/core/filter.c                             |   9 ++
> >   tools/include/uapi/linux/bpf.h                |   4 +
> >   .../selftests/bpf/progs/test_tunnel_kern.c    | 115 +++++++++++++++++=
+
> >   tools/testing/selftests/bpf/test_tunnel.sh    |  80 +++++++++++-
> >   5 files changed, 206 insertions(+), 6 deletions(-)
>
> The subject "bpf: Add support to set and get" is incomplete.

Thanks. Sorry for the confusion. I will fix it.
