Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF38221154F
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 23:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGAVr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 17:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGAVr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 17:47:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA007C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 14:47:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e11so23791418qkm.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjKXrOrkTYJAza1zjIIUDRbs3atSXs5X/UaNFiIyD+E=;
        b=sZVVrUhpFeXxEXoek5K1eg7ncTNAdlf+Ufp0Vqw+s8IBxOKljLOm1KlU8wNx2hwM2d
         YSBQf169LHlC8Mj03gAwcNUPWRNqhlhxedSgIFsg7w6TtcUcIKr32he2ueGIrI8R0/R4
         agGXRYjZ8TPCRZHWHFqoYZn+2pp/kfSvPvW1bQ7pvOWWrrnkdaphf2g+wZZQhDh6YmY1
         /kRsYDEou4YN+HEgmSmy6x9WWf7JP/29JUM5ONalu5ax/FhYnnIy+zrdutQxqMu+CCK6
         PqXRUhApZbUvcsAoIZ/qKY0kisXcByz0s2PuARhKaGniv4yvZ7R3dccTTDxslJDGnQVf
         dRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjKXrOrkTYJAza1zjIIUDRbs3atSXs5X/UaNFiIyD+E=;
        b=gmVp4DfDmNJl0abIW1KPwGpahOPl26sPC/j250ADnigEpr5YGIGv274RKNquKEvZ1z
         DCeNUo2lddeh1dkmIduRRv1p07gq50DadhAfsR8CJIRs8V/7hxqwNwSop7S6XPGyPy7H
         R2G3ZS8oLeFFRdueuRJVmtR0V7oBkck+O2GgW/Kzp/6JRiyBkrqb2Fomn6Uy51YKXa9u
         FLZkXsfDK7f9SHcG4LnGFGL1t9OxQyz1EB5ulJcW/OxXv/w6NbzZ69lRhrDtFbGbvFeU
         +brOCighuUXAGZ4hdImnfQAdNlV5FtWRHKn0zU3fBuvMRkl17a/RNR+O0zm6zDgKNWj2
         1jyw==
X-Gm-Message-State: AOAM530iUWnyXr95+KAp0M3XAFkW2Ho/S10BG1R3sLULIpyO0CreXtqa
        Bvy6l3S22f34KB8+a2SN2ob2BKdmz2RdhsDGbcY=
X-Google-Smtp-Source: ABdhPJyVUYgomuZS0FI1X+/+4wVeAApplB4hDs3Y30ov0PG8kA5BPbOJ/lyzSjjvqA9KtfvoJ07B6HW9Gk1FQicw47s=
X-Received: by 2002:ae9:f002:: with SMTP id l2mr16564435qkg.437.1593640076006;
 Wed, 01 Jul 2020 14:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <159363976938.930467.11835380146293463365.stgit@firesoul> <159363985244.930467.12617117873058936829.stgit@firesoul>
In-Reply-To: <159363985244.930467.12617117873058936829.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Jul 2020 14:47:44 -0700
Message-ID: <CAEf4BzbQj4mvNP-JYfiDTSX35x_uynYFTJWeVHh7bdH5DyyeoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next V3 2/3] selftests/bpf: test_progs option for
 getting number of tests
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 2:44 PM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> It can be practial to get the number of tests that test_progs contain.
> This could for example be used to create a shell for-loop construct that
> runs the individual tests.
>
> Like:
>  for N in $(seq 1 $(./test_progs -c)); do
>    ./test_progs -n $N 2>&1 > result_test_${N}.log &
>  done ; wait
>
> V2: Add the ability to return the count for the selected tests. This is
> useful for getting a count e.g. after excluding some tests with option -b.
> The current beakers test script like to report the max test count upfront.
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/test_progs.c |   18 ++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h |    1 +
>  2 files changed, 19 insertions(+)
>

[...]
