Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84352B0518
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2019 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfIKVHv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Sep 2019 17:07:51 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34745 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfIKVHv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Sep 2019 17:07:51 -0400
Received: by mail-vs1-f68.google.com with SMTP id g14so9196708vsp.1
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2019 14:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XJHMobu+BW8e+V93RysuqAgvySnrHLkRIzv4bFfI7f4=;
        b=rLaITkTegfgDMi+pB/j2GYgfbd6BDMH+O8pwlAubC6Z5n5kBe90cnyi48On+jQNA9m
         baSrbYQ59tXUdZLYPMx3QGsc/mNPgpai5FUjX2j4kJNpm01e2LBSRiiMCVycweKWx29F
         n2QZ7KQZPwv5UqS+w6i5mDg7DGJmRcULePrDjgC+78lhrCqZq6dMTxvqH1oui/kEYQPM
         reYg7Ub6C0ts0aefaw+ybSvD4KteJ5fluoZHKnSzOCzb4HXsFcDAn8swltoqO4hMwSLN
         tq+MfJQ0P8ajLboT7nYDwDWBR7DkiGnrhlLPoxQHgCIkKf6YdD/uAoJTUpoR71KYDK1a
         IFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XJHMobu+BW8e+V93RysuqAgvySnrHLkRIzv4bFfI7f4=;
        b=AiN7fqCxBEaQOAf9fXEGd3pnURjJ9eQ0A7oHkvcptGsK1ifH96m1wHgBIZkOnS+PEm
         eYg0xwUa3NVCtquMD3ljNiBACXZ/nQOJAXAtavylcA0/sfAYZkbYBPqRXec6P1vwmAlp
         21/GAFrk9HVTQehyz5FMy2cfbKP1XrqcPKHWOcSeyYRUFpzlObXUxIf9DIkZTHg6M34p
         gOSNnfYtLtQQ0TYdAb2Z/WXfWS/ixtDba2dhp5+rvj5l59HKooAG2QCrWNCQzLFodI1y
         pLueAPeN5EDg3kqN6j9Ox5Af+7cS71q6C37hrvWEptgpCRY/ftQO1qK2iwQgwiVA4/9x
         60oA==
X-Gm-Message-State: APjAAAXX9eBtvXjjKNzSpcbKEArxHD6k1mV3gjv6xPrRC/xXMAmL9mHs
        z18xhNT9pLQvAtMQTPlY8kW/9kQ31pDaTVuzujJSmQ==
X-Google-Smtp-Source: APXvYqzVFDguN8esHlbARMFIHd2F5AxzYzchx7PmiukG4R+VEAGjETrh4svN9zZQtYLaAcXSG2g3v9d0ZdhTkVGhPNc=
X-Received: by 2002:a67:6d06:: with SMTP id i6mr21756050vsc.5.1568236069615;
 Wed, 11 Sep 2019 14:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190909223236.157099-1-samitolvanen@google.com>
 <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com>
 <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com> <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com>
 <87impzt4pu.fsf@toke.dk>
In-Reply-To: <87impzt4pu.fsf@toke.dk>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 11 Sep 2019 14:07:38 -0700
Message-ID: <CABCJKufCwjXQ6a4oLjywDmxY2apUZ1yop-5+qty82bfwV-QTAA@mail.gmail.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 11, 2019 at 5:09 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:
> > I ran the "xdp_rxq_info" sample with and without Sami's patch:
>
> Thanks for doing this!

Yes, thanks for testing this Bj=C3=B6rn!

> Or (1/22998700 - 1/23923874) * 10**9 =3D=3D 1.7 nanoseconds of overhead.
>
> I guess that is not *too* bad; but it's still chipping away at
> performance; anything we could do to lower the overhead?

The check is already rather minimal, but I could move this to a static
inline function to help ensure the compiler doesn't generate an
additional function call for this. I'm also fine with gating this
behind a separate config option, but I'm not sure if that's worth it.
Any thoughts?

Sami
