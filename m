Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C472A49F311
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 06:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiA1Fbo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 00:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiA1Fbk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 00:31:40 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68168C061714;
        Thu, 27 Jan 2022 21:31:40 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so10007379pju.2;
        Thu, 27 Jan 2022 21:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uH+S1HOxh4bJPXiMacZ+TMSTa1RCMltBNdnFPdeD0Sg=;
        b=G4bb5x24JtNPCVho7l6b5yTBc3s6n4vvv8j9hyaGNHAxjoT3WfQpFFo++wUFvSUH2T
         fbrPNJgqliydugV3q3aQYONuEnjg0NHp3NYvmwiA2z3LQ/2K/nRH2XoPmimL3obm11pA
         QyQdPD/j29yNS/C+k7o//sNPTCHuq9gfEH1AYFLeSl0rL00s4ZyXAKO/oq7oxtKxLIfB
         5RgxFqPJ94O88ZHB1s8NcNrTKlkRvR1wSvPuvLMeUs4asD9xGW6auOcdbI4gpMwvxicM
         eIHRgrk+A3J42IkzQFCJ5rXwiyxjSmXdw3RR8nWQfuLGggGImt0y+FbYsSHS00b6tr4X
         GFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uH+S1HOxh4bJPXiMacZ+TMSTa1RCMltBNdnFPdeD0Sg=;
        b=2xvqMMSkiTO+tfXVnWC/BWBCcpCSgr+yrDsQO6r4R66sSvbVnEBmQ27Pk5jQFK8XpA
         Thbq9hVk6oDhyIUtHlCT/2xAF3cYGtgBBiB2bEK19fvJyY+sFDHfen8wtzv50Nyd8sOr
         K2mLrZrqF8TMopozh2NgjBpe3AvXJP3w8XA8ITwjiIt+CQS0VZHPpOsuCw73QRiqopLB
         zGe16F3tTPI2+yBX30aUtP88s16LV30FsnmqK03mdtEA+Y16FBVHv5Nfd+ha8IjW4L62
         AogY/U6UE4C/P5nnJ32SBb/PWR0fuOx2+u54a74Y1KpZWOYZpdEd9yt//cmXVWSsRhmM
         +EmQ==
X-Gm-Message-State: AOAM533YHHP9l95HIqusYMgdo3kVrtSYLfqwQIWAENSpEuPHBnt43yhR
        lycjSupTcImtmqYpaw++5vYHJBlR679vlj1asfU=
X-Google-Smtp-Source: ABdhPJzX9s+gGKmm8KRAQWISPjMtNlkMg+tBBqevMk6w3Eb0EPL6DhikQHTbfhFkZ9gbG/7RSTi67Db+8J5evv/3Ow0=
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr6512809pls.126.1643347899702;
 Thu, 27 Jan 2022 21:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
 <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
 <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
 <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
 <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com> <177da568-8410-36d6-5f95-c5792ba47d62@fb.com>
In-Reply-To: <177da568-8410-36d6-5f95-c5792ba47d62@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 27 Jan 2022 21:31:28 -0800
Message-ID: <CAADnVQJZvgpo-VjUCBL8YZy8J+s7O0mv5FW+5sx8NK84Lm6FUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
To:     Yonghong Song <yhs@fb.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 20, 2021 at 10:34 PM Yonghong Song <yhs@fb.com> wrote:
>
>
> https://reviews.llvm.org/D116063 improved the error message as below
> to make it a little bit more evident what is the problem:
>
> $ clang -target bpf -O2 -g -c bug.c
>
> fatal error: error in backend: SubroutineType not supported for
> BTF_TYPE_ID_REMOTE reloc

Hi Matteo,

Are you still working on a test?
What's a timeline to repost the patch set?

Thanks!
