Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5160324BA2
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 09:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhBYIAQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 03:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbhBYIAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 03:00:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C0C061756
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:59:35 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id n4so4271836wrx.1
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=54N2ApRNKIaBqIzgr/oBQYIvazUz5lKpmTMmctuwycc=;
        b=P9lZU4+htaTBLPlV2RdekSdZJX5ptI6QTR+7gNbNrD2sWah1LkMe++DDDz0gznS5Sj
         +uxxbVLawWDsxxBQwZkh6lz93ovHncEa67Y+R40xBuIt8Ywc7SWpEzD9MWNVdcukiMbc
         oTrqI5/cuWy/+Wh9MGvjaadh7MJk4q/KKLWQ4eYVIRYHp4gFN63+lpuRkP3PLEZ5DmEV
         ZFnCvxJlmXX6BeRW+forKdJBhUHVTvRXTSoNUAyiU7r3pbktm5e4sAqc4SIT92Nf4Inq
         LEShJq9bZA1tH0dRrU3u2LyWxNCTOMc9qhE7VqwtWMx1Pm32xGZKL5VE5okX81vfhbSM
         JDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=54N2ApRNKIaBqIzgr/oBQYIvazUz5lKpmTMmctuwycc=;
        b=ES16PB0NnKaU75Un4gW13Xtt/WGcMaWP/E30ur+ut+husN6urc8MQevygtF0ih6AsT
         N2hQTPA3PahiFVnq6hqChfmbo4Ilh3xA9cEwKh6RnwqwvjeQg4gow1DcFty/KvYaWfWX
         MKEgtuJ+u7fL4yE4GZisEC1iUquUhF6Er92cDCV1Hrfe/T9fv9mHDk/IbB+TSi/amlce
         2JN+YmaAtssHep7enzfbnd4qjxEJyrmJWct5iwuIjIwrh2AL7YOWB7WEcVQTOtCw9q4p
         ngvqi4eT+qx42uak5F912W+pHMlwIkOfe+heBCfbrr/HVDUr6W4kq6npkdhQHEw5jQM+
         v/Vg==
X-Gm-Message-State: AOAM532ofZ8H6ofn8hJU5tUjHH5sZpukjrQ/E+kberVXHKzQf+Vyx6KD
        Q+XruTirX6XZgbGDdplrXqB7RA==
X-Google-Smtp-Source: ABdhPJwfEjondZvmscsqMJzgnOEg3UJSncsAwGjzl2aQ4afSKWRRaYIu7JJRH1lQ/wgM2m5tMLihnA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr2140400wrp.196.1614239974022;
        Wed, 24 Feb 2021 23:59:34 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id 6sm7906542wra.63.2021.02.24.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 23:59:33 -0800 (PST)
Date:   Thu, 25 Feb 2021 08:59:14 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Luigi Rizzo <rizzo@iet.unipi.it>, bpf@vger.kernel.org,
        kpsingh@chromium.org, will@kernel.org
Subject: Re: arch_prepare_bpf_trampoline() for arm ?
Message-ID: <YDdY0gdKftxXZeMN@myrica>
References: <CA+hQ2+hhDG2JprNLaUdX4xgcihvchEda1aJuQN3jtJ3hYucDcQ@mail.gmail.com>
 <6af0ab27-48f1-e389-d2f4-41b3c1db4a18@iogearbox.net>
 <87blc92m5p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87blc92m5p.fsf@toke.dk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 24, 2021 at 10:25:38PM +0100, Toke Høiland-Jørgensen wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
> 
> > On 2/24/21 8:54 PM, Luigi Rizzo wrote:
> >> I prepared a BPF version of kstats[1]
> >> https://github.com/luigirizzo/lr-cstats
> >> that uses fentry/fexit hooks to monitor the execution time
> >> of a kernel function.
> >> 
> >> I hoped to have it working on ARM64 too, but it looks like
> >> arch_prepare_bpf_trampoline() only exists for x86.
> >> 
> >> Is there any outstanding patch for this function on ARM64,
> >> or any similar function I could look at to implement it myself ?
> >
> > Not that I'm currently aware of, arm64 support would definitely be great
> > to have. From x86 side, the underlying arch dependency was basically on
> > text_poke_bp() to patch instructions on a live kernel. Haven't checked
> > recently whether an equivalent exists on arm64 yet, but perhaps Will
> > might know.
> 
> Adding Jean-Philippe; I believe he is/was working on this...?

Yes, I have a very rough prototype here:
https://jpbrucker.net/git/linux/log/?h=bpf/devel

But not a ton of time to work on it at the moment, I don't know when I'll
be able to post something.

Thanks,
Jean

