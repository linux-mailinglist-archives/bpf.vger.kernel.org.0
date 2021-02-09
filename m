Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE13154C2
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 18:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhBIRNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 12:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhBIRNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 12:13:09 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AE1C061574
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 09:12:29 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f8so13662371ljk.3
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 09:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDMSI3v7ltMIvBubdz7fHFJUzTUea6dzVTOKPGGvbQ8=;
        b=o6OBUPJRj9e+m1Y+DH+0WyghSD+J0B6L5/grMpSW510IA3IvHyPkrGExqAYudEYD6w
         2LMUyuuM+f7BC56gNChF4kUh2l8f5coMfNtYh+2jofomR0yQDlzZ9KrXG0KDePY3FL2p
         lx1xgg45KhZeBclQnJhAkN9Cxg/hIV7qveotmvyRrkRbEfe8iasVdg2hzwOvPieURpi8
         hUTx2JRmZq/6+WgUN/nuNMvdT170eVS5mUbe6aWhQo3IeYDCIUAPoHNdmoc8BH1joQSc
         IcePKUPbyOpMugeDU31lKSI0si/oJduEsDqqiStT8Yfg2HaROY3r3mf1ygW6Oh1X2UOC
         rsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDMSI3v7ltMIvBubdz7fHFJUzTUea6dzVTOKPGGvbQ8=;
        b=gjUrNRyo+7m5euJalNbs5Qzx1/hfPnmanlx+sLJkv0LpAy9Rvz2Ec1g426nT32Hwk3
         RIejNF1uJ5tB+dcXxSxECgY1Dw+eXVQJ7M+OcrlTUepIruwLe6peBEvi7bRbqAH393Jf
         umMXqCCBLcFDsUBxXf1kA0N/8gL3lzE8d8SUXnaj4YLx/tkQS4WCBmsMVOXYtUVXgJDE
         cn53+NmILEVV7cq+FGVWhQwisQpUj3CLfvbU1yQcQPr+HMfnvGwIxJFjglOz/LFKf0sA
         3ejwGpX6C3zX+XeLeTu+O57SkEU5Amzf1apED6aCemHr5YR30ZOGt2zJwVPqrGap+LYV
         RXLg==
X-Gm-Message-State: AOAM532PU7+3ggzhMOELZslXW4Mj5md3VXnh2Jg6U1WFsoviCcnvJEiY
        1AP5MYbn6UtHbiPLSiHecZLlgYzZqqBkQekev9pmeQ==
X-Google-Smtp-Source: ABdhPJztUqRb7QgYbn/p3w90iPRbcIxstn4kQ+qoy2y/zyE3qgHNXuc4HN5Is+gjdpgEkd/75vAKTwDiY1FTMBAzQIk=
X-Received: by 2002:a2e:b0f3:: with SMTP id h19mr14365459ljl.233.1612890747452;
 Tue, 09 Feb 2021 09:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20210209034416.GA1669105@ubuntu-m3-large-x86> <CAEf4BzYnT-eoKRL9_Pu_DEuqXVa+edN5F-s+k2RxBSzcsSTJ1g@mail.gmail.com>
 <20210209052311.GA125918@ubuntu-m3-large-x86> <CAEf4BzZV0-zx6YKUUKmecs=icnQNXJjTokdkSAoexm36za+wdA@mail.gmail.com>
 <CAEf4BzYvri7wzRnGH_qQbavXOx5TfBA0qx4nYVnn=YNGv+vNVw@mail.gmail.com>
 <CAEf4Bzax90hn_5axpnCpW+E6gVc1mtUgCXWqmxV0tJ4Ud7bsaA@mail.gmail.com>
 <20210209074904.GA286822@ubuntu-m3-large-x86> <YCKB1TF5wz93EIBK@krava>
 <YCKlrLkTQXc4Cyx7@krava> <YCKwxNDkS9rdr43W@krava> <20210209163514.GA1226277@ubuntu-m3-large-x86>
 <CA+icZUWcyFLrFmW=btSFx_-5c-cUAYXhcjR+Jdog0-qV-bis7w@mail.gmail.com>
In-Reply-To: <CA+icZUWcyFLrFmW=btSFx_-5c-cUAYXhcjR+Jdog0-qV-bis7w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Feb 2021 09:12:12 -0800
Message-ID: <CAKwvOdkQixhz1LiMrFx=+zf5o29UHaUrGTz=TPEsigtGakDXBA@mail.gmail.com>
Subject: Re: FAILED unresolved symbol vfs_truncate on arm64 with LLVM
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 9:07 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> We should ask linux-kbuild/Masahiro to have an option to OVERRIDE:
> When scripts/link-vmlinux.sh fails all generated files like vmlinux get removed.
> For further debugging they should be kept.

I find it annoying, too.  But I usually just comment out the body of
cleanup() in scripts/link-vmlinux.sh.
-- 
Thanks,
~Nick Desaulniers
