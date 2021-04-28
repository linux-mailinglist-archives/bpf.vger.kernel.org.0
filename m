Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20D36DFD7
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 21:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbhD1TqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 15:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhD1TqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 15:46:08 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC7EC061573;
        Wed, 28 Apr 2021 12:45:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y2so73346793ybq.13;
        Wed, 28 Apr 2021 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UP6/zlQsB9dpz1gBGDQSIq5aIV4UhU6jWhHp88ZVcuA=;
        b=R8EXNRbG2nVs1wF7m0KwzI6kVTtwXh8Cdymb/qNLYuJHHJDBm93i1xOwFu2Qf2xzi7
         sJVxErcpvWk866QVjkle0BM9UVjmzsDuVVh+LSEBlBjEIvyvDCXd+A+f7M7TSuLg/vm2
         eAhGRm/JQQgSujodE8aJdZjd9vv3E9SW801s3KmubKxRXsfRM1LB+jJHRx2TmTssJnGb
         Fj5VcjF14HXrONEUx1QxfTO3ytR10TKEtMLhC9ipG2eTufdJufArJ41q1WKByopZBSOc
         sUSc5O/9+4BWeoWHQ2EM3WJW1i/lEEbo9rZshbW6zXOpet5aGx0OCA+AeElUtMPDc1lB
         acSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UP6/zlQsB9dpz1gBGDQSIq5aIV4UhU6jWhHp88ZVcuA=;
        b=XivLaM5FdRiAHO5Gs0Dal7Oq7qAqyNGN+XaCVJbrbAIEC2A/OtKNKDbgNqe1JycIqs
         Oz3PZtDXHCplRFXyCfFyna6mfHWFEELpoA2vgl4pBn7WghF8t8YkE8Fps/4p/9v6W/4X
         39/P5e0gwgQz1ufNfsM603AvuvHsHMjHVCjIXTM3GuhxDS3Lnl1UX2opWd8sdlBssYbZ
         5OkHFN1kynabfy5y7+kxBTT4jOf7gXTs3LbIOUayVy+1pv8+akJIyEeyYTgyA5I2lP8g
         KA4fsssSDlIRrpDZeWo7C5k8uWIEb9D+0ftw3EcdMVJ8F8BKV/KCV9rcRmfohPfHy2fu
         jUWA==
X-Gm-Message-State: AOAM530mdfTpAIfObtair07HiXk14G91TfY95hZGbOZmW3rg4UaPefkd
        JD4sd0Xf+y2aVav27tbDGENFTZodhOdHjuSQPUQ=
X-Google-Smtp-Source: ABdhPJzXiQPL1oYucRiMtrwiGFyw1wTlIdwqrI+kH2FcjGdB78zL8+UAwIOE+zmM4r2SWg96LtJezMN5G/UX7XRg9v0=
X-Received: by 2002:a25:1455:: with SMTP id 82mr274657ybu.403.1619639121840;
 Wed, 28 Apr 2021 12:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210423213728.3538141-1-kafai@fb.com> <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
 <YIf3rHTLqW7yZxFJ@krava> <YIgE1hAaa3Hzwni8@kernel.org> <CAEf4Bzbh7+WJ502J_MQKiHDZ_Ab-Vb_ysHO6NNuZwNfThKCAKw@mail.gmail.com>
 <YIle2kdR4IniQnbN@kernel.org>
In-Reply-To: <YIle2kdR4IniQnbN@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Apr 2021 12:45:10 -0700
Message-ID: <CAEf4BzbzYeG9fWPe=Vugq8WG6bK79dk3byjWV9gtCX_v7L0XLw@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids section
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 28, 2021 at 6:10 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Apr 27, 2021 at 01:38:51PM -0700, Andrii Nakryiko escreveu:
> > On Tue, Apr 27, 2021 at 5:34 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > > And tools that expect to trace a function can get that information from
> > > the BTF info instead of getting some failure when trying to trace those
> > > functions, right?
>
> > I don't think it belongs in BTF, though.
>
> My thinking was that since BTF is used when tracing, one would be
> interested in knowing if some functions can't be used for that.
>
> > Plus there are additional limitations enforced by BPF verifier that
> > will prevent some functions to be attached. So just because the
> > function is in BTF doesn't mean it's 100% attachable.
>
> Well, at least we would avoid some that can't for sure be used for
> tracing. But, a bit in there is precious, so probably geting a NACK from
> the kernel should be a good enough capability query. :-)
>
> Tools should just silently prune things in wildcards provided by the
> user that aren't traceable, silently, and provide an error message when
> the user explicitely asks for tracing a verbotten function.

Yep, that's what I'm doing in my retsnoop tool (I both filter by
available kprobes [0], and have extra blacklist [1]). Loading kprobes
is pretty simple and fast enough, shouldn't be a problem.

  [0] https://github.com/anakryiko/retsnoop/blob/master/src/mass_attacher.c#L495
  [1] https://github.com/anakryiko/retsnoop/blob/master/src/mass_attacher.c#L41


>
> - Arnaldo
