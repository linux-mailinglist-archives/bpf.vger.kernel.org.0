Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628CF3AA9E3
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 06:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhFQE1A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 00:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQE07 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 00:26:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4A9C061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 21:24:51 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id b13so6243797ybk.4
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 21:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gwd5nsZ0A1WsxXirPUUxF46A37PjRb4ZgzX04NLCVG4=;
        b=cqbmSIDTnz/Esha4vbJwFQ1yw+2/j1suXi8lGfR175MmdSO2ROXNBnFa4CjaxnzYjU
         Nc3NcfvSqKomp/oRy0dai8XxQSIsy5MNTYH3J7truKBaFDBLcOSYRXiaaNAFhgzKQ/Bw
         Anz0F5Q8tuVjxYiXLVL27rO3Wvpw+h5C2cO71Wz6olDs69MaxBO+NXppYeXY+UlEIwwd
         jb5GuV1UgeuR0CC88P0BX8npbDXemtcC9TsY7b9IM1QqbwERIffTcLAOFv8MjPWBsl6a
         m8hwufO8yFfM/TQ3iSPGh9Ph/BQlUyNxG2bBK/AemU0lGlArAulV/9s2pzlKwvFFU83G
         kz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gwd5nsZ0A1WsxXirPUUxF46A37PjRb4ZgzX04NLCVG4=;
        b=PD6u7YeC+qa8M4USrLcosZTTO2OmV67YfKn8oUR1CNT5QOYbzfIPWff4UWgrhd1Lmu
         IR/H/Fh7I9burlDmMSK30d8HV4vnMAKY9rDsJ17Ty8vHFSHCZFaVChTmJ0sNPlj8vSJP
         n+4wvXAbmRhQgoNWzcZ77uOQro27plIr5R+0RFdjIItN9CTYUGb3417Tv7mK/35QEW8/
         kVA0q7PIvwpCas8TG2NEPDNxVK+5r6h9Dp9JNgTuh24EcEJaNS16FrEG/dAexo+M6hnC
         q3cf19imtYUvu/WR2S3JRzCIr5G2E4Lkst4jVhY5QORLxQFqNpr5nETCP8pDuyWCCour
         nCgg==
X-Gm-Message-State: AOAM531ditIx5RpwAfF4qhWQje3+0S7ug18VMVI5APXgBYPQbLJeL0gP
        uM5mYDcEduRuC3bEfRcgpEORqWYcP+p0CvKCTrY=
X-Google-Smtp-Source: ABdhPJwDToe/TUqyyaKpdD41lXBcLpsXyyePrqLXM4nXyhr3iyLlm1aggypeGtD6V1zPAGi2ZOMZZPAYFib9WB2nOHA=
X-Received: by 2002:a25:df82:: with SMTP id w124mr3376403ybg.425.1623903890525;
 Wed, 16 Jun 2021 21:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210616083635.11434-1-lmb@cloudflare.com>
In-Reply-To: <20210616083635.11434-1-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Jun 2021 21:24:39 -0700
Message-ID: <CAEf4BzbJRMuG_h9x1mv_ab_JHA-gx6=+6bc9ydAWPNGV_jQpOA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/1] lib: bpf: tracing: fail compilation if target
 arch is missing
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 1:36 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> bpf2go is the Go equivalent of libbpf skeleton. The convention is that
> the compiled BPF is checked into the repository to facilitate distributing
> BPF as part of Go packages. To make this portable, bpf2go by default
> generates both bpfel and bpfeb variants of the C.
>
> Using bpf_tracing.h is inherently non-portable since the fields of
> struct pt_regs differ between platforms, so CO-RE can't help us here.
> The only way of working around this is to compile for each target
> platform independently. bpf2go can't do this by default since there
> are too many platforms.
>
> Define the various PT_... macros when no target can be determined and
> turn them into compilation failures. This works because bpf2go always
> compiles for bpf targets, so the compiler fallback doesn't kick in.
> Conditionally define __BPF_MISSING_TARGET so that we can inject a
> more appropriate error message at build time. The user can then
> choose which platform to target explicitly.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Applied to bpf-next, thanks.

But please use one of few "canonical" patch subject prefixes next time:
  - libbpf:
  - selftests/bpf:
  - bpftool:
  - bpf: (for kernel patches)

We don't do ":each: folder: path:" prefixes, it's not necessary and is
quite long.

>  tools/lib/bpf/bpf_tracing.h | 46 +++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>

[...]
