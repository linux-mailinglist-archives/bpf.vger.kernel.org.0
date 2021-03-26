Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63A34B281
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhCZXNI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCZXMw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 19:12:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C438C0613AA;
        Fri, 26 Mar 2021 16:12:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g8so9974438lfv.12;
        Fri, 26 Mar 2021 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gy/AOg2acqPIjNJng5nvKAEetoAIusyvT1ZDpARRMRw=;
        b=a1m94jl6EvRWswzn+ZhlZDJkUV6822eCVwkRrEFF+//uW68RRuKD/B8zLfeG3fmx2+
         HyNvDiIDyXAxp+PKgpMPvIHbm0FHwIVSdIh+D7W73tjui/ki+TGo+vua1xCgnAXQ3/NG
         Qy5L+rTXstE/6gZDLaLWq7SXqBQZljvk2FdSA7+OUUciQV4e8tVJk1ryMjeJ97mIhVAV
         hBFqJiOUEjaSrtKSmiJR24ttrVyIVqZuFxYAoUuesGoORwvHHAvHE1okqLEta/+H0UyT
         R1wFMz34/FwaIgorBamhnQ5Yug6NAH5lIbgFC0UVLgG5g6MUG5tTbTjqChsNjjX8c7HS
         kjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gy/AOg2acqPIjNJng5nvKAEetoAIusyvT1ZDpARRMRw=;
        b=F4uPs+Qy66uoou1hwBDuA9GUQWsTAy6AG+DRl7tp5UJNdykbzg/cv8g3ucODSYr3Mc
         kO1wOljaQ5uDFl1B7uQPfr4nfom6NFxFqs0IsBGJvmVeocO4Ifx2V/FflXT5vzlnZxpa
         XovGsqGzDF9pIAAEp9tTnaX7oUj9ct2NBqh1dAflbFZF7S6+Rc1lLfBT4KSKWDTKUGm0
         zNxiyl4jYT5DOgsDwi/bkyBdJhDHIS76w2eQOEJVBToNghpw8Sw6pYpZ/CfMfjQcuXXx
         JxMs/hsTaHlNZnTsOnh1LHwoZ1vrX0x+ZDbQZocaHiJ0s5peP+FtvPgzdiK2Q+Kd/Alh
         bOZQ==
X-Gm-Message-State: AOAM531rYnrTVf0ABThuWT3XlZIbT6JK5s3GtHcUg/VX7PaLncJQCvlF
        yKgn7VmUyEF1aGJQTVZC2sr5eQ/xQOOJHSA37aE=
X-Google-Smtp-Source: ABdhPJw0dXciSyJiCvwqSr2FlXg4hnYBaBeIqdZnbHoE+NFiO8MbB4j+NJ/yptpJzy0owLXjCIDiFXsYHytGZLd40d8=
X-Received: by 2002:a05:6512:21a5:: with SMTP id c5mr9701830lft.534.1616800370797;
 Fri, 26 Mar 2021 16:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210325065316.3121287-1-yhs@fb.com> <20210325065332.3122473-1-yhs@fb.com>
 <YF3ynAKXDCE0kDpp@kernel.org> <d618edb6-e4c0-a260-905f-e07720746594@fb.com>
 <YF4ltLywXsM3YkSs@kernel.org> <74e25d53-1e36-03a0-2de5-bd2d349a4a7f@fb.com>
In-Reply-To: <74e25d53-1e36-03a0-2de5-bd2d349a4a7f@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 26 Mar 2021 16:12:39 -0700
Message-ID: <CAADnVQ+MT_u7q7veB_ws8PZ0XC0v2f2=P-TnzOBbaahbvYRDwQ@mail.gmail.com>
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 26, 2021 at 4:05 PM Yonghong Song <yhs@fb.com> wrote:
>
> Now since you found gcc actually has flags in dwarf tag producer which
> will provides whether lto is used, I went on clang side found that
> the following flag is needed in clang in order to embed flags in
> the producer tag:
>     -grecord-gcc-switches
...
>    In Linux:
>       - add flag -grecord-gcc-switches if clang lto is enabled.

I think that will help to make dwarf output a bit more uniform between
gcc and clang. So it's a good thing on its own.
Recording compilation flags in the debug info could be useful in
other cases too. I would pass it for both lto and non-lto builds.
