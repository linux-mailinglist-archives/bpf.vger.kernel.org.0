Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5B37D4DC
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 23:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243388AbhELSdr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353797AbhELSMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 14:12:44 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A27C061574
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 11:11:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v188so31840621ybe.1
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glo/mTGRM0lTlL/fLQcDwAS/qdWKO6QEFp3wnQiqgUg=;
        b=RtYOQ25VFANugjmDzVuCHJIwWi13NnaeENg6G24vOircEi0JTg9pYheYJs/WC/XCro
         taXvddEJ39SFUyoolCXbKysWmCAsDrYbeIsd6EWzRZxD/HsDlOSXHcIb9BuW+kjUIL/Q
         DMNol6QzW9FHXlCFi+51HT7z9sQ2NtPMfF5e6anmGf/DXL6jkYOmkuigaC2e88Pkk9b3
         RDO+7JRsg/XlU8/2GzedD0FUrz/0ayJzu4pSrHB3ivZ4ytJbVeDRSA8FDz9w7UF17VNG
         Vh+A/AqLcYfXQla58pfC4OHoS7TKFGX9R9GW62T/IOcrPP/TVoBP11eBucELneMM1Rgf
         aytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glo/mTGRM0lTlL/fLQcDwAS/qdWKO6QEFp3wnQiqgUg=;
        b=SMJUpN/e1E7LpysnpLHfLTzyG3YP/IirmzKP/Zd7viUAQSsAaISmyg9vY0dutp1lxA
         mesj/OI9itDxIFtHw+xwcnSIHhFN8NuqKwMtVrQ/z0Z+oCUEqwzWV9us2MNgzpa2vKds
         PD0UDI7R0ck3aC4GkHfGOpItHQas/WxJQnJh164I06jgK5CFCIwUM9+uO5OGlfRadexg
         lYPTC3gqj6KVBQAqCIr13tyaKD91ECiSfAi8gex3MfiVKiZ81PvS3/ofZjfBGwWndpq8
         hnFatWw/J0hswW9DFUDS6kY0uNFvaKElZZCTqCLwj/GrkCLuO0CEYl/Tj2QXmDXP4YJq
         S7ww==
X-Gm-Message-State: AOAM531jiZY3yXJPJwX1U/nW20pqSs4VMrPTQ0M8FQh5mKhETHv8ZBfq
        yn0MD5qTt3jX0h2Iqq9fmz4iOcbMCg5VO603jXsrtQPJ
X-Google-Smtp-Source: ABdhPJyIsdmofwrM8onnd/IR8pVVG2pVlEUBHbXEhKAsDaPoekPTPIHmcrh8/RH4tOLNDNMGGT+REqo9kA2ObrYinZU=
X-Received: by 2002:a25:1455:: with SMTP id 82mr49460822ybu.403.1620843094369;
 Wed, 12 May 2021 11:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
 <20210508034837.64585-16-alexei.starovoitov@gmail.com> <CAEf4BzaBS4hhiSvsLcdZvSQv598+ODAyXstLcFgEhzEmzmj2yw@mail.gmail.com>
 <8122c5c0-1429-9f2d-c73a-9d8ada4f318e@fb.com>
In-Reply-To: <8122c5c0-1429-9f2d-c73a-9d8ada4f318e@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 May 2021 11:11:23 -0700
Message-ID: <CAEf4BzZyFYT8=e-g5U8VRXt_h9pwxaUWzpjNtj9My7GEm4ozuQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 15/22] libbpf: Use fd_array only with gen_loader.
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 11, 2021 at 9:17 PM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 5/11/21 4:24 PM, Andrii Nakryiko wrote:
> > On Fri, May 7, 2021 at 8:49 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> Rely on fd_array kernel feature only to generate loader program,
> >> since it's mandatory for it.
> >> Avoid using fd_array by default to preserve test coverage
> >> for old style map_fd patching.
> >>
> >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >> ---
> >
> > As mentioned in the previous patch, this is almost a complete undo of
> > one of the earlier patches, but it also leaves FEAT_FD_IDX and
> > probe_kern_fd_idx() around. Can you please try to combine them?
>
> I cannot combine 9 and this 15, because then 14 will be broken.
> I'd have to combine all 3, but then the fd_idx won't get its own
> test coverage.

If you want to keep them separate, then adding `void *gen_loader` and
using that instead of kernel_supports() check would minimize code
churn. It will be auto-initialized to NULL and then in patch #14
you'll just define gen_loader with a proper type and initialization.

> With patches 1 through 9 I've tested the whole test_progs
> and that gives the confidence that kernel and libbpf side
> are doing it correctly.
> Then with the rest of patches and without 15 I test everything again.
> Such testing approach covers lskel and fd_idx together.
> I think this patch 15 is rather unnecessary. It's here only because
> you didn't like patch 9.
> I think patch 9 is a good default for libbpf to take.
> Eventually llvm can emit .o with fd_idx style.

When it does and it provides some benefits, we can switch. As I
mentioned previously, the current mechanism covers all the cases and
works fine without requiring extra code, so there is little reason to
switch the default to it.

> The libbpf would just call probe_kern_fd_idx() and won't need
> to massage the .text after llvm if kernel supports it.
> It would need to sanitize back to BPF_PSEUDO_MAP_FD only on older kernels.
> That's the reason I'm not deleting probe_kern_fd_idx() in this patch,
> because I think it will be used fairly soon.
> But I can delete it too if you insist.

Yes, please. We can always add it back when necessary. I'd like to
avoid dead code lying around.

> But combining 9,14,15 into one I'd like to avoid.

Sure, I agree, see above for a simple way to keep them separate
without code churn.

> I think there is a value to have this in git to easily go back later
> to test everything in fd_idx mode by reverting this patch 15.
