Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E374641AAF0
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 10:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhI1Itg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbhI1Itf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 04:49:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28201C061604
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 01:47:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i4so89294328lfv.4
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uJKoh2QybjdwEcBDFQWT745Mc7o3vbDoM1cNTlXAm8Y=;
        b=eR1cmiyIiIapnh5XoFT/9vz3CdnXWcnVKIQLM0O6lBS2TkrAklYuIFWf4L39n5/Trf
         69+Hg8oHO+fYu5FgxEYFf2RliqfYIuDslAZ73jfzu1++8VdBcLQNlmn4vR3ZijGXDH/M
         bbGJlH3chxZDT2tm9pH/EklWsCCeKVzmt6RZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uJKoh2QybjdwEcBDFQWT745Mc7o3vbDoM1cNTlXAm8Y=;
        b=6N9Iwxdw7UAYN+uOydEYrGu8eRYkZo2x660Htk4RMxdV9P5qZv9PtNgIw0uoq9CaHF
         zHI7ze98Hi9okcvRkXlUNnHLr+ZBMGgDZrIFa47FODvTyLQrZjMRHVyfRm5DoQFmvSIZ
         kBENlofdZHGuEhb0Uy+fDNdA23Tv/SgF5ossH7oPlTIuM0aprgV1FLYIimNwJh4lLYyc
         xSTa7BgWbuqMJp43m2gGJ3IS3boJyzwmBPwWGRfD6fH2fsqvTxwcReYcHb9v1p/zTMnN
         L3MN5/3VNM2ZSG0n2kYMeBO7lPMrPmzPiGOxN4FngJvetQ/TmJYHFsxv0mKciN7iMZYB
         /ogA==
X-Gm-Message-State: AOAM533u92nFPky9IedWkVCTGRS4BOxGnZiQ6pnMAKvm6emg245sy1LN
        LCUYtPusM0/PfB9ROK9pzXrmQk9spxzrkqJL6ivdBI7BNjo=
X-Google-Smtp-Source: ABdhPJzhGJtuezcFyjvFMOcWVc19yWqrGUn56e9swBelpJT9HRmsVePaLJPQcJpECOfRBTsRuL+qQ8g4YPcYG4MJDH8=
X-Received: by 2002:ac2:5b10:: with SMTP id v16mr4277234lfn.331.1632818874513;
 Tue, 28 Sep 2021 01:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <87o88l3oc4.fsf@toke.dk> <CACAyw99+KvsJGeqNE09VWHrZk9wKbQTg3h1h2LRmJADD5En2nQ@mail.gmail.com>
 <87tuibzbv2.fsf@toke.dk> <CACAyw9_N2Jh651hXL=P=cFM7O-n7Z0NXWy_D9j0ztVpEm+OgNA@mail.gmail.com>
 <87tui9ydb6.fsf@toke.dk>
In-Reply-To: <87tui9ydb6.fsf@toke.dk>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 28 Sep 2021 09:47:43 +0100
Message-ID: <CACAyw9_grv4_c4gDntK7jT3hfBM+O0qSJZ7xFpaknd58e1PeQQ@mail.gmail.com>
Subject: Re: Redux: Backwards compatibility for XDP multi-buff
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lbianconi@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 24 Sept 2021 at 20:38, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
> >
> > Porting is only easy if we are guaranteed that the first PAGE_SIZE
> > bytes (or whatever the current limit is) are available via ->data
> > without trickery. Otherwise we have to convert all direct packet
> > access to the new API, whatever that ends up being. It seemed to me
> > like you were saying there is no such guarantee, and it could be
> > driver dependent, which is the worst possible outcome imo. This is the
> > status quo for TC classifiers, which is a great source of hard to
> > diagnose bugs.
>
> Well, for the changes we're proposing now it will certainly be the case
> that the first PAGE_SIZE will always be present. But once we have the
> capability, I would expect people would want to do more with it, so we
> can't really guarantee this in the future. We could require that any
> other use be opt-in at the driver level, I suppose, but not sure if that
> would be enough?

I'm not sure what you mean by "opt-in at driver level"? Make smaller
initial fragments a feature on the driver? We shouldn't let drivers
dictate the semantics of a program type, it defeats the purpose of the
context abstraction. We're using XDP precisely because we don't want
to deal with vendor specific network stack bypass, etc. I would prefer
not specifying the first fragment size over the driver knob,
unfortunately it invalidates your assumption that porting is going to
be trivial.

Lorenz

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
