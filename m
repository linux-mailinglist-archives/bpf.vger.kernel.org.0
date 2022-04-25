Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF7C50EB8D
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiDYWYe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 18:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbiDYV1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 17:27:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046C1106DFE
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 14:24:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h12so24665343plf.12
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RYuhCQRZSGGvQlvR3KQE72md5GMXY8uozyrhKpZbH4=;
        b=76+cFpJlB2znElEluziuC+lYgS8j/y2ZEoL/3Ey3E/ltwLqQH/caL2CbKx/CjviqTf
         VAaanrajTbqytcF+DAjxDxfemaieNsNjWEIwzrpenjDnuT3/Vvt91nO3RSOu+HURxpbK
         xZGwSNJa/1fZh35VZAg66cOoBhCb5R93A36Y8b6aFV3V8SsN5YV4OJIqwVDg2rVMlhKQ
         P3HvUczasvOvTuh312jNOy/Hb8K7vagFPrwqtDxTo+p3o4Vg6PlUrTa0KLpPggpj9dsW
         X1tD8lce6FcfSlraB0XhUaoAIl5/WlVdnVLVivKxVON4WbD/O6yXfbjLvVxaLd5+EfZA
         BhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RYuhCQRZSGGvQlvR3KQE72md5GMXY8uozyrhKpZbH4=;
        b=QhrdVm1BfB+BvNeoZ9mvX0be2LT8LjO5pcTkNE88ABUx2BOFbtl97b5PfxLfDSaBQL
         +9iQ+Nrv4TPn0o1K1N/xemFOc4Jo2RV5NffO9GEQ5VSc8f9jaDzyzpmUSlFygOSF8HwZ
         J3kxCce9yjF7pJUpPiN6wpPeSTLLiOOftAn8NtDRyg7iIAlHIyEqwoshejf6GCwt2unW
         29bzxR10inJRt3M2itJ12a9QQ6zHIfrf2sQr/jwplih73VHDdCybs85ErCCyiKuQp3xM
         Np9PMEP8RTAsfzzMvkBVGYcMoPbc933t1EHFzrTcXNiyJAQNQy9FysxHdPhoZRaPDXaF
         w/5w==
X-Gm-Message-State: AOAM530kqUd/iW0/agoDY76USMOoALRqO8ubvNbDE2BiV5uwnU8uDoTg
        AxMY7YPKA6NtwvPF1fGvE+snac80XPzgmf0xrkSzNw==
X-Google-Smtp-Source: ABdhPJysD+6GxIKJGVU76kXWf16Gd4VaOx1Mwbkre+dhBbQ/oZx7AXi6WajOGSoOZadUd7bvIs6Q73h8n6Qn3HjHypQ=
X-Received: by 2002:a17:90b:1d12:b0:1d9:8499:545d with SMTP id
 on18-20020a17090b1d1200b001d98499545dmr5770592pjb.96.1650921888547; Mon, 25
 Apr 2022 14:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220424051022.2619648-1-asmadeus@codewreck.org> <20220424051022.2619648-4-asmadeus@codewreck.org>
In-Reply-To: <20220424051022.2619648-4-asmadeus@codewreck.org>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 25 Apr 2022 22:24:37 +0100
Message-ID: <CACdoK4LH3b-n3j_9r4hbgAus1UiJkfMBOMxboTzSVWbqi+j4wg@mail.gmail.com>
Subject: Re: [PATCH 3/4] tools/bpf: musl compat: replace nftw with FTW_ACTIONRETVAL
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 24 Apr 2022 at 06:11, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> musl nftw implementation does not support FTW_ACTIONRETVAL.
>
> There have been multiple attempts at pushing the feature in musl
> upstream but it has been refused or ignored all the times:
> https://www.openwall.com/lists/musl/2021/03/26/1
> https://www.openwall.com/lists/musl/2022/01/22/1
>
> In this case we only care about /proc/<pid>/fd/<fd>, so it's not
> too difficult to reimplement directly instead, and the new
> implementation makes 'bpftool perf' slightly faster because it doesn't
> needlessly stat/readdir unneeded directories (54ms -> 13ms on my machine)
>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Acked-by: Quentin Monnet <quentin@isovalent.com>
