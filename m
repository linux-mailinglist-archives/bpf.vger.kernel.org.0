Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E77435819
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhJUBRU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 21:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUBRT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 21:17:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB73C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:15:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so4784435pjq.0
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXDTw7d0cPR+8smk9qH70d3rDhJlXOcHQl7G8ZzwRz0=;
        b=qciiRO0FMH2ida7N+/2qGp9yDir4LxNzu4n32X92pJ8fPuc75RL+OV8WQBKpMQ0pe4
         pHHN57bLDywWBjJiHt4+tMOGx63ROb2sr34Dhlr0KW4enDzLY/lyrv8m2aB43o/RHToU
         gHU/EbRw/nAHGHGY9mRZQ4xx3AI73+St1o9PBJnn7/tn4LA4elsSNoXMwa+FfBncQXpu
         WgZhzdsQR/CEe5luCWYAT9wIJIT0N346hSy2E/2osacygP+NkoYZySI9sEPLG1dkkXgT
         M4sfrYPOyC9pJrqX7++EdJ4OqjupQQ1orIHI1op7U+kQAsZnRG9Uzm0eQBXMU3h8NuIm
         WkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXDTw7d0cPR+8smk9qH70d3rDhJlXOcHQl7G8ZzwRz0=;
        b=PwwD7f6f2OiJdNRHdi/PdN7vDuAJUi/BEBboPdolPtgdP56YDPcN2jaMI3nTip+MsP
         4BoenhNGv/Ls03pusJPGRGrDMgBZuoU/AIeVtrITWg5c4EZjr2q8pjQURXfTwHBGYVVZ
         A8IvSqAnHj6lu7HALRXmgJ/+ApQHjnJYyR9c0gv/Lam5gSJ43FbIfOocwYpWQrF7CyRA
         Wrd7Htv8HZilIAhRMq/yTPB4riVeDa9Bhuu7rEZM7/7pCla/SH3/QU6fOUrzgir3DYrZ
         dT3bW6ctg/Qs7/l+T8cp6vA3Lr5lTTRCwyTQAEzy5z5bp1Dx3L+347yNHupfwMz0N9Ah
         rKKg==
X-Gm-Message-State: AOAM531h4uBTjrfNIMY8NduMIHaskws1p6RnPOLeifk9HQ+1px5W9PYc
        qglJOZLgMjOcpqU0ivrFQCdepXKhAWE8VuJzYokY1JOM
X-Google-Smtp-Source: ABdhPJz/MdprEM4vnRWR8m5aKkrLfOby3zVbui0y/BZ3aCRdDEBJ8H/Pal4h9kgEWnEYgjWDI4LfUwJYlxzIOO6cfxQ=
X-Received: by 2002:a17:902:ea09:b0:13f:ac2:c5ae with SMTP id
 s9-20020a170902ea0900b0013f0ac2c5aemr2313566plg.3.1634778904286; Wed, 20 Oct
 2021 18:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211019165801.88714-1-andrii@kernel.org>
In-Reply-To: <20211019165801.88714-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 20 Oct 2021 18:14:53 -0700
Message-ID: <CAADnVQK+OaCwowuMUkByZ=HeACpDZHL7kZdE2J6fXek+mPLSDg@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix overflow in BTF sanity checks
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Evgeny Vereshchagin <evvers@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 19, 2021 at 9:58 AM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> btf_header's str_off+str_len or type_off+type_len can overflow as they
> are u32s. This will lead to bypassing the sanity checks during BTF
> parsing, resulting in crashes afterwards. Fix by using 64-bit signed
> integers for comparison.
>
> Fixes: d8123624506c ("libbpf: Fix BTF data layout checks and allow empty BTF")
> Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Applied.
