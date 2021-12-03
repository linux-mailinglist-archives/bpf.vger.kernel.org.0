Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C86467DC8
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353109AbhLCTMu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbhLCTMt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:12:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B19C061751;
        Fri,  3 Dec 2021 11:09:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y8so2771388plg.1;
        Fri, 03 Dec 2021 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IoBuVhCiR9BrSiQMh75XUsvklE4yOFaQXUkrNsUI+/Y=;
        b=o+MayrhIXhy6Tn8p5jFoe3c6UEGzOvhNMOZ3TtvQekj4JCNjdsawVl2u3l5SENbfof
         TNfIHy73jO38Cwwn82y0/O0BIKnFHjyLPXQJDzy7qycQOBmCsMlzDh1Q2DR/dDfUPV+T
         r18zoZXJa+kuffykx6WxpgSUqIrRhMh+5seYzmBeIdQgodapeD3BgFIao8z0z3xul5DI
         zzfBS7ojv+CsTNBmtiL+bcj2r2Be0KmQr05NMIrnRPld2usPWmwa7QKmH4TJixqKzBoT
         zvPWSf1nPvABpim+20Hg6l+G/t1o5CzzG1XTTa95NmXosfCoW+SB7in29LfUrsF96+Pj
         5kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IoBuVhCiR9BrSiQMh75XUsvklE4yOFaQXUkrNsUI+/Y=;
        b=ZXaOe5keT66gzNdrFNH1gMj5L8sQA6Ftlox4P2TRU2/0gALcEp1WciHqtWBh1Sa9Fi
         ufNc6h8CoCnYfeL1C37StgZs3EsJx8J8IdR575YwwB6XgzZIhD5zflkF+ITf+SUPPzmC
         UTi7yZCO26G8kEDiHucBwqk/rGVQhUH30yhCj84tz7ek2K3DVyMnrbmJ5x9l7abOwEgm
         HUpRmuLn3w4NYEqt2p9virR+qWYgUDyZhxwNoYeJqlhP/MnQFloeyn6H9L8dJlVpPqDe
         5ApJEPzDcS2twiz/O/oiFb0Hsky/xqrTSqxjyftDGc6txgrapU/kkvusWCXkG75Mg86R
         aptQ==
X-Gm-Message-State: AOAM533bFrv9KdfdKcHhHUbvYgEQLQJNgHT6njgGJyyn5KtgXK0fV20E
        nNKt4UiJV9grAz9VOMtk8DYfOBNs/ESX4kiQhcE=
X-Google-Smtp-Source: ABdhPJxZJvNEr3MwGMO10MxWXmKiW1dA8s8jvQruDvE9ccjiUSFfbFTenWOarBOh/3TPJbQ4+kPRDOmSReFhkMMc+GI=
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr15942710pja.122.1638558564703;
 Fri, 03 Dec 2021 11:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20211202203400.1208663-1-kuba@kernel.org> <YanDM7hD9KucIRq6@kroah.com>
In-Reply-To: <YanDM7hD9KucIRq6@kroah.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Dec 2021 11:09:13 -0800
Message-ID: <CAADnVQJXSksytrk5aLGQzgzaoGB9xFWqXWSTj0AmkEWiEs2jWg@mail.gmail.com>
Subject: Re: [PATCH bpf v2] treewide: add missing includes masked by cgroup ->
 bpf dependency
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Peter Chen <peter.chen@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, David Airlie <airlied@linux.ie>,
        daniel@ffwll.ch, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, yuq825@gmail.com,
        robdclark@gmail.com, sean@poorly.run, christian.koenig@amd.com,
        ray.huang@amd.com, Sunil Goutham <sgoutham@marvell.com>,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        jingoohan1@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski@canonical.com,
        mani@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        thomas.hellstrom@linux.intel.com,
        Matthew Auld <matthew.auld@intel.com>, colin.king@intel.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-pci@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 2, 2021 at 11:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 02, 2021 at 12:34:00PM -0800, Jakub Kicinski wrote:
> > cgroup.h (therefore swap.h, therefore half of the universe)
> > includes bpf.h which in turn includes module.h and slab.h.
> > Since we're about to get rid of that dependency we need
> > to clean things up.
> >
> > v2: drop the cpu.h include from cacheinfo.h, it's not necessary
> > and it makes riscv sensitive to ordering of include files.
> >
> > Link: https://lore.kernel.org/all/20211120035253.72074-1-kuba@kernel.or=
g/  # v1
> > Link: https://lore.kernel.org/all/20211120165528.197359-1-kuba@kernel.o=
rg/ # cacheinfo discussion
> > Acked-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> > Acked-by: Peter Chen <peter.chen@kernel.org>
> > Acked-by: SeongJae Park <sj@kernel.org>
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I'm not sure how to test that it helps to reduce build deps,
but it builds and passes tests, so applied to bpf tree.
Jakub, you'll soon get it back via bpf tree PR :)
