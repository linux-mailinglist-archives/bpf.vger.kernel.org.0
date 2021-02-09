Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2F31484E
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 06:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBIFpw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 00:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhBIFpw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 00:45:52 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E987AC061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 21:45:11 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id r2so17001922ybk.11
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 21:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhyYry96duXUtJhovqOjwmvx2/DUOKft4wX5eYMIwDQ=;
        b=kjHRq3wwQG97iFxdu4L9bopUAR9bd5HgwYt6wl8FD2jCbLnCdVovvQQOVqt02LdsYo
         xGsspgPFYH7MrhcNA1CSgBCBuvvJnWmD7d1Blv8oAkMXOKimzUTsHervUj+z4RI03+ch
         i80N8k3zIFN9fNtTdmUo4gLn9+WTSQbh3vwYvj7SJIyraIp153T7k+0m2BfMwmPQ0/TS
         sE1io3ohyH0a1LV6RayyjYBh8PIJ+dKKzpBme2I1w5AtIcDczAyYuceiMSRBkJ+VosK2
         PMLfBx8FnVhkUpUqas+6MnM67QgIoR1yzpZzo9znNY15R6Hpi4hhl4mbx8ldTZn/1Std
         WdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhyYry96duXUtJhovqOjwmvx2/DUOKft4wX5eYMIwDQ=;
        b=egsnkJQeoZgZZV43xHgEsKqdN/gUxXve1kvGCsJ2owoFSgVA6K7ibDflqSaDT0gP5/
         HhCgWgD9M4ogCL47EamP60cCgmTz/Pjn3tInF4LWxrdbfe0/RG7Le1OtAvWYQ0lp8NSI
         wi6sWBsz5LVCsJNqHDvhU1nu+MFTYRiFl629tbqzGlwZVMBmhGhEh2dLM8aXwWET82oz
         mz7IQRc666UcfZdSuQEURqg3rcCIfZAh0ZYFZZpcJhrIzgSyiQTDOQoosmvDd4isGEMf
         Z9DY8fs5Hu/wLICoKyhtRncYgYPEWEYcoOjihsGRotBsJmiuCBMuGiyvxtqnCvSQ17XR
         xc1A==
X-Gm-Message-State: AOAM530niGcXyIZM0ZrDqiFi+qAN2eqvmB4OzL+Y1pei4fPjmTMgNTB7
        fmXp0/WrZtqiHMe0QvJ2jAduI673RnoMTUADmnmbKsZthwA=
X-Google-Smtp-Source: ABdhPJwHx295krKFTNVfoavFDnogQ2B5B/tVT5Llht7nvtsbB1qS2caZl5d6WhORcd80kU0e1Uis2TiHiMoIdpkBHyo=
X-Received: by 2002:a25:a183:: with SMTP id a3mr29665904ybi.459.1612849510483;
 Mon, 08 Feb 2021 21:45:10 -0800 (PST)
MIME-Version: 1.0
References: <YBGe5WFzSc3Z8Oh5@gmail.com>
In-Reply-To: <YBGe5WFzSc3Z8Oh5@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 21:44:59 -0800
Message-ID: <CAEf4Bzab4fZm04xR+3DYEHNaxAoaNM+hZFdYWGJ_qk1fNyAitQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add lookup_and_delete_elem support to hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 27, 2021 at 9:15 AM Denis Salopek <denis.salopek@sartura.hr> wrote:
>
> Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> hashtab maps, in addition to stacks and queues.
> Create a new hashtab bpf_map_ops function that does lookup and deletion
> of the element under the same bucket lock and add the created map_ops to
> bpf.h.
> Add the appropriate test case to 'maps' selftests.
>
> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---

I think this patch somehow got lost, even though it seems like a good
addition. I'd recommend rebasing and re-submitting to let people take
a fresh look at this.

It would also be nice to have a test_progs test added, not just
test_maps. I'd also look at supporting lookup_and_delete for other
kinds of hash maps (LRU, per-CPU), so that the support is more
complete. Thanks!

>  include/linux/bpf.h                     |  1 +
>  kernel/bpf/hashtab.c                    | 38 +++++++++++++++++++++++++
>  kernel/bpf/syscall.c                    |  9 ++++++
>  tools/testing/selftests/bpf/test_maps.c |  7 +++++
>  4 files changed, 55 insertions(+)
>

[...]
