Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C842709C
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 20:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhJHSSG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 14:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhJHSSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 14:18:06 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7231C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 11:16:10 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a7so22987400yba.6
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PW/9L4jM2+C32iCWswQlA4iVbPjdUXEY0PTXS51ZExY=;
        b=EvcNaYnxLpjRNQlNXHA2HoE6qcy1Uh+TIlEV8D3UZu8shnvBVhTTcK96DivNVollWr
         bFhd4LqXJAubYU8lSFXzPz3Vj8pYbrBkxgHzuqn6R/vNcQvjWtcdeMgJn12x/N1ndTQG
         FG69l7h3/XLHRoJAf6BJBZCAIWRb2RRhi4irWxDDpw2lzZkDvjhGMClxbeYiImJ3ZCbA
         RmMrLdPf4les/Xcauc0omGx+4dfX4tyAVczna6fOZEvdK3x9u5eWPjmEfzCdgVlYhUdn
         t8YTfnqr3dQoqHst5YGko5nfyrfuH3c6qANj3dCt+AR9rU1cuOgu1FGv6Y8fOfrHfPMf
         YeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PW/9L4jM2+C32iCWswQlA4iVbPjdUXEY0PTXS51ZExY=;
        b=Yvhspx4WQl2f2rFahVDkJLeacUS2aay7ujxMmZBB57t4YDdA6JpHGZ3Z0U0/lr7erL
         jxUVdzUSBMia7v5izMpUszcqf0/iPMEEqcppIOviA96giwM6nPYFvo5eY+BQyJd/2O4T
         OTXtxxWa668FJ4Ao6xqOq+feIY0EWdsIODloamVbyw5agwbIFSHiKgrRWw2w4RrHTHU5
         v4VqWDFArZoJB/1WtDVpfhrs//pzsDnbORI1PAHMMfw3nuSRBXXdKmgpZelihc8Cfy7R
         p066aRLxvp7dQnUOvWjl92IEmOlCt3EnubhaVOLd1XIYLJuhQORvF64aziXGHMf6XubY
         irig==
X-Gm-Message-State: AOAM533BKJWxeS0mKldd3zu+1PBXUj7tj4RHcPj7DcekgBXCDpuQ8mB/
        hgKopl4UvEYLmynwTzgiHSg+TIl9BKeSyAaW2ks7EAxA3QI/3g==
X-Google-Smtp-Source: ABdhPJwYFShhqeajT9vP08lFN1mOjjfpHj/gXlSIZPMY9LHbMmCzPyL/+3s7oImBOOULC/IXZcy8X2M/9B2hR3wNEhw=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr5260017ybj.504.1633716970074;
 Fri, 08 Oct 2021 11:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211008173139.1457407-1-fallentree@fb.com>
In-Reply-To: <20211008173139.1457407-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 11:15:58 -0700
Message-ID: <CAEf4Bzb0c9R3y24NSGJ=14tLozd3A=PYZVc5H1Witw2oud0mRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftest/bpf: fix btf_dump test under new clang
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 10:31 AM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> New clang version changed type name in dwarf from "long int" to "long",
> this is causing btf_dump tests to fail.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---

Fixed the prefix to "selftests/bpf: ", applied to bpf-next. Thanks for
a quick fix!

Also added the reference to the "offending" LLVM change you've sent me offline:

https://github.com/llvm/llvm-project/commit/f6a561c4d6754b13165a49990e8365d819f64c86

>  .../selftests/bpf/progs/btf_dump_test_case_bitfields.c | 10 +++++-----
>  .../selftests/bpf/progs/btf_dump_test_case_packing.c   |  4 ++--
>  .../selftests/bpf/progs/btf_dump_test_case_padding.c   |  2 +-
>  .../selftests/bpf/progs/btf_dump_test_case_syntax.c    |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
>

[...]
