Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC44A6CFAD6
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 07:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjC3FjO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 01:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjC3FjN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 01:39:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2D75B8A
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:39:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id er13so30994498edb.9
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680154744; x=1682746744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l575AqULl23Ia0mKgXsYaqdBK5jpiypuDbQJC/LWzUQ=;
        b=b8TA2Xa9TV8Kg2zh47Nbt1yzXbV8IFp06c9QJ9KBMPNc9GSyVu3et6HpY+bxSNzUgs
         V3ItD89xGn7crz6o1pyNTGVIkQ2237hBwHXZy7dPCiEbaiQRj+Jf5Ya3wJ305cQpwXh4
         Oe3vwFif4WxeLd7Jbxl0HaSp7RJumVSRAnYpT+qyv4RvMycykiTVLVPBQXmNI8Als12y
         EP8Xw6nKR/dqmcvDqf/yv8a7NGx5rSsSXBgs3otbshRIIGXiVD7shvxhlNry5Yd2mOIb
         wXSLzVKIA1izLtJyd+osImUnYlYny4X5hZr3SGQj/LFD3huKo+hqN2FK+LWbr1tAJA6N
         cMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680154744; x=1682746744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l575AqULl23Ia0mKgXsYaqdBK5jpiypuDbQJC/LWzUQ=;
        b=SEK64K3/Q7FBZ3PU4Ay1XisRU6B50h1np390B1rJ4Et3U5WVUeAWoEAFjGfWt4By5E
         EKyq4pWNBXuMLB0kx+LFEzUfHuG9O804+bnFEzgLMBzhslfcy0UaCXX+eJ9ZEkTanhZS
         BpwVdL8U9TFmrbH2il9wRF2D2XqHuY1KGyQ2gzgVP467mc6GWCedqwkNbK9IiJybA+Ts
         BkIMyw6UyhNxpgi1naiFp7ccMONxxuQql7pb6m6Kz4tvTglchiD2BboQh8cHKRVKwEbY
         3sLmsg/6tIQ+zNjIwDAFjbk1+orhAjXJ0XX0qCHjdECWEVRThfUPB1o7wYvvEbimngR5
         wbtQ==
X-Gm-Message-State: AAQBX9e/SNX7kXAsvYT9HLVNGS3t6/6fDV9y4D6iOquf7lqvVF2vV/4X
        a/mR7MTSAr15uhdKxtyKKS3eYcJ0FYMRKjZ55TA=
X-Google-Smtp-Source: AKy350Z2/mjIRJ23ycKJxGF7wnDqkz4WTm/2T+K3PdYeK71PYJhPPAG2sLQc2rpY4ZOeHrDP3BjTykyPHS5gwQUfHts=
X-Received: by 2002:a17:907:7f19:b0:926:8f9:735d with SMTP id
 qf25-20020a1709077f1900b0092608f9735dmr12132594ejc.3.1680154744335; Wed, 29
 Mar 2023 22:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <CAEf4BzaAcD0HEgJzQH4NTWAzkTXHLS7T-eGGxxhHm2ADROTRrg@mail.gmail.com>
In-Reply-To: <CAEf4BzaAcD0HEgJzQH4NTWAzkTXHLS7T-eGGxxhHm2ADROTRrg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Mar 2023 22:38:53 -0700
Message-ID: <CAADnVQKT7Hifb=vV1yu8orgPMkRynNLZykCPKanRqDigE8xVEA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/6] BPF verifier rotating log
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>, lmb@isovalent.com,
        Timo Beckers <timo@incline.eu>, robin.goegge@isovalent.com,
        Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 4:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 28, 2023 at 4:56=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > This patch set changes BPF verifier log behavior to behave as a rotatin=
g log,
> > by default. If user-supplied log buffer is big enough to contain entire
> > verifier log output, there is no effective difference. But where previo=
usly
> > user supplied too small log buffer and would get -ENOSPC error result a=
nd the
> > beginning part of the verifier log, now there will be no error and user=
 will
> > get ending part of verifier log filling up user-supplied log buffer.  W=
hich
> > is, in absolute majority of cases, is exactly what's useful, relevant, =
and
> > what users want and need, as the ending of the verifier log is containi=
ng
> > details of verifier failure and relevant state that got us to that fail=
ure. So
> > this rotating mode is made default, but for some niche advanced debuggi=
ng
> > scenarios it's possible to request old behavior by specifying additiona=
l
> > BPF_LOG_FIXED (8) flag.
> >
> > This patch set adjusts libbpf to allow specifying flags beyond 1 | 2 | =
4. We
> > also add --log-size and --log-fixed options to veristat to be able to b=
oth
> > test this functionality manually, but also to be used in various debugg=
ing
> > scenarios. We also add selftests that tries many variants of log buffer=
 size
> > to stress-test correctness of internal verifier log bookkeeping code.
> >
> > v1->v2:
> >   - return -ENOSPC even in rotating log mode for preserving backwards
> >     compatibility (Lorenz);
>
> I haven't implemented the feature we discussed, where the
> BPF_PROG_LOAD (and BPF_BTF_LOAD) command will return back the full
> size of the buffer that's necessary to contain the complete log
> buffer. I'm building it on top of this patch set and would like to
> send it separately as a follow up, as it touches UAPI some more, and I
> feel like we'll have few revisions just for this. So I didn't want to
> delay these changes. Plus, I think to add this even for BPF_LOG_FIXED
> mode, so it's provided consistently. So I need a bit more time to
> implement this. Hopefully this version will work for everyone and can
> go in sooner.

Lorenz, ping.
