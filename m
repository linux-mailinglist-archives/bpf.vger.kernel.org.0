Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9840149E949
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 18:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiA0Rum (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 12:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiA0Rul (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 12:50:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588BC061714
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 09:50:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j16so3139817plx.4
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 09:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ja1xVGUnZRIoEMXcEMDqVybyIPNAFTg3b3S14TIv+4I=;
        b=frAeWE/LAt/Zth3iqo7nehlkMwXlQ8eUa4jUtW/Qq43hMO+DvB3nBg5LmYpRasJ5pN
         6nGG/CEC2LiJf4CZB3lyxshpmiAsEfJP6wro0WWIn8dn7DGNgEOxkUAd8kPvO3FT1ZB/
         qsVimc3kAeD2cKeZQVo4+zOerlYuS1MI02/KuTZ4znzGmOwWfalhgao3ZTooEVNmns49
         jhQXXWEocZldWSiPqgAuP/ECdQmPG/wfQgOZwK8LQrZi/jwhHU5NshD31YBTlefp8ZDj
         jNNB4TsB3OexGrUZamUaxj79UIvK9p+CNguglefmoQRdy4yMfAkjty+77gS7LC9o6urI
         AgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ja1xVGUnZRIoEMXcEMDqVybyIPNAFTg3b3S14TIv+4I=;
        b=5TimJrOHxdIR76NAGMNagaHVKxEtn9EjBWv6J57Qamn1cgNdscpvnv6Ubt0H6JvSNt
         exrjSqvjQ03KlPhFAK740ZRYXqePfXYLpz3fzOhiCDHVMnlil2Szn8iOoIT0+RmJYOA7
         FVhZyO0gERYloRr4P0AzX24B5dViFF54Et+4iA7NQR/113D8mDi40o2MSxqjfesqDtS9
         zyrFmJBerz4iI5KYx+McwX+JfOy7mOidAdCD2laYlSQPXKp54hRPyc2ubJFHiFJ6jk+3
         oF8927aVL1LOk3rHTam609s1acr3iuYoOP4qx4bA0CVYEe4/OMWz3hYPvWAkGB0VZurm
         vRGw==
X-Gm-Message-State: AOAM531ZLUvqISU/dV6qjA+o0TOA41/pmOUxDPH1gAgluGS+gjdPUTGC
        aDuGUcwiLzfALGnVEgwz2f0HOS7qbtodm/Y6L4U=
X-Google-Smtp-Source: ABdhPJzxTdmoEm6L93ITAw0CwTQUoJ2Vt8WtLMBCn7nKwpKFoi16OSMSZPbYJPu4PmzlmfKO0PZ1uyrqhwuy9MKMZ9A=
X-Received: by 2002:a17:902:e54c:: with SMTP id n12mr4229197plf.78.1643305841203;
 Thu, 27 Jan 2022 09:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20220127163726.1442032-1-yhs@fb.com>
In-Reply-To: <20220127163726.1442032-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 27 Jan 2022 09:50:29 -0800
Message-ID: <CAADnVQL3J01F_2GsPGCU8AtH=JL9wNJ2V6LvWqDqR4pYTi=aDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a clang compilation error
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 8:37 AM Yonghong Song <yhs@fb.com> wrote:
>
> When building selftests/bpf with clang
>   make -j LLVM=1
>   make -C tools/testing/selftests/bpf -j LLVM=1
> I hit the following compilation error:
>
>   trace_helpers.c:152:9: error: variable 'found' is used uninitialized whenever 'while' loop exits because its condition is false [-Werror,-Wsometimes-uninitialized]
>           while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   trace_helpers.c:161:7: note: uninitialized use occurs here
>           if (!found)
>                ^~~~~
>   trace_helpers.c:152:9: note: remove the condition if it is always true
>           while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                  1
>   trace_helpers.c:145:12: note: initialize the variable 'found' to silence this warning
>           bool found;
>                     ^
>                      = false
>
> It is possible that for sane /proc/self/maps we may never hit the above issue
> in practice. But let us initialize variable 'found' properly to silence the
> compilation error.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied. Thanks
