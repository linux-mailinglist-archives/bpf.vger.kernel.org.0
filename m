Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DBF4954C4
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 20:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377550AbiATTP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 14:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377473AbiATTOH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 14:14:07 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C6EC061756
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 11:14:00 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z19so8182532ioj.1
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 11:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6EukJxVYUT00gmmvhMt6ZHODT7a2/zZInpUYiJaIDgI=;
        b=O4ByYDxXynkUNpzfoJ7pe4x7wR8u2B1rCWtzJEFdkbRMxapnt06KNSv9XL2o6oxaDg
         i3Tjc+mKnZ0UjzutVD6iyRD+F47FEtF2P4Nr+Q0+Hnf0+qtgrQwf9rpfp9TiiBcWGYy5
         hdocDX4/PYzIkNnVUdsm7FB4gCc0lNNKABKpbZijk5cd94nZ7To/j4ioWUpxTf9opIp3
         4zJvVx6r1wR2j9KmfW4OEkOLqx7EtZfh1uBHC6mauQzlX4hJgfD8ojxFOG5GOKwdzY+t
         HVl/UGSO3B1LS7H90MNzQr1UcqTlTEzDaUr5OnkrdOGdtODNWwwGJBoWj8IexwMD4p1d
         xS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6EukJxVYUT00gmmvhMt6ZHODT7a2/zZInpUYiJaIDgI=;
        b=k4klSRnkw0Tl7ds68Yb4t00skZKk/+qwrRu/ZDRyeeB6RKzMOSCB2KP++pR84j7DSC
         fRsjd6E+NMK0nhReodh44cV61dvgmgtyFsiARVaTwZxZHkCrccKv7Z+PaB3J9nfl1tVm
         5Sp65XZISVh9HIWk1du59FWmzGik7v+uoYChvhJvrTp6qTrbyFToBXbRyUaGY6/ldOp8
         v7WpFpIcfYRWNQ1tRjYym1mu1+pBxf3IqRLPSnj6euKspG9VeljdOoFYeuIwdWwKb4DX
         X/81TxJz+wykbUXxJz5hfK6JO4LTtaNAAexih3PpEGS8G9Vk2nNyb2rUMbvgP0AjaGQa
         RIzg==
X-Gm-Message-State: AOAM532VMldRUFymf1WU4J3aV1t48xgm5RA4QxrIKjoQfAN1nC3mJvIy
        N2QrgR2Ed7AEiqRc9FNvIFGSuNMcLZ8NgvaBYIw=
X-Google-Smtp-Source: ABdhPJy6EBgpbgBfBI8Xyk/ok/d3YNL1tVG14qiOdoJ9WZVIXqpChRPO4w/kxDQgItnZPHOoF1Mqiz6fQYZWifmKBNQ=
X-Received: by 2002:a02:8648:: with SMTP id e66mr99256jai.145.1642706040254;
 Thu, 20 Jan 2022 11:14:00 -0800 (PST)
MIME-Version: 1.0
References: <20220120060529.1890907-1-andrii@kernel.org> <20220120060529.1890907-4-andrii@kernel.org>
 <87wniu7hss.fsf@toke.dk>
In-Reply-To: <87wniu7hss.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 11:13:49 -0800
Message-ID: <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map definitions
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Andrii Nakryiko <andrii@kernel.org> writes:
>
> > Enact deprecation of legacy BPF map definition in SEC("maps") ([0]). Fo=
r
> > the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS flag
> > for libbpf strict mode. If it is set, error out on any struct
> > bpf_map_def-based map definition. If not set, libbpf will print out
> > a warning for each legacy BPF map to raise awareness that it goes
> > away.
>
> We've touched upon this subject before, but I (still) don't think it's a
> good idea to remove this support entirely: It makes it impossible to
> write a loader that can handle both new and old BPF objects.
>
> So discourage the use of the old map definitions, sure, but please don't
> make it completely impossible to load such objects.

BTF-defined maps have been around for quite a long time now and only
have benefits on top of the bpf_map_def way. The source code
translation is also very straightforward. If someone didn't get around
to update their BPF program in 2 years, I don't think we can do much
about that.

Maybe instead of trying to please everyone (especially those that
refuse to do anything to their BPF programs), let's work together to
nudge laggards to actually modernize their source code a little bit
and gain some benefits from that along the way? It's the same thinking
with stricter section names, and all the other backwards incompatible
changes that libbpf 1.0 will do.

If you absolutely cannot afford to drop support for all the
to-be-removed things from libbpf, you'll have to stick to 0.x libbpf
version. I assume (it will be up to disto maintainers, I suppose)
you'll have that option.


>
> -Toke
>
