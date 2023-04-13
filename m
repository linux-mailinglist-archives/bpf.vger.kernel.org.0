Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8676E0347
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 02:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDMAn2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 20:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMAn1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 20:43:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ED530FB
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 17:43:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5027d3f4cd7so5780216a12.0
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 17:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681346605; x=1683938605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeaVbdFJvtZB4Tyc1zbc9PwIQN50lpoOHtu6Jg3TFno=;
        b=BXtDejVw2nngtzzfgUWX2jtXKtMCfpM1cLBHKsV5J5KOsjZSOAOpoFGD8e3XDzEeXE
         jlAtOn1JDArZXcHG+TrbsRk/g21K+08AvwE5P8y5C+OMBPXOx2sBWlA1YuUO2nFsrt2v
         r7qcSURAKjVUGKEyZb/QJEmZISu2EgNwr12cRbN9YJxr4mYj5RWpFaSIK6iE9Wb8g8ZS
         cCY7GyWaW8IxCoedRj2W2OJCaJsMC/MyQhACuOgpZNCKbvGv8kNU5klzmKQ+MduR7LCB
         cv0ed/xfDEG9xKBlF+DHRVN3usy52yJ8wOh5n40nxxIyrJGz49nqrJvdoW9dwA2ZZkpK
         eArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681346605; x=1683938605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeaVbdFJvtZB4Tyc1zbc9PwIQN50lpoOHtu6Jg3TFno=;
        b=GGMlyZnkORwcVLyeC5FjrLSvmkww4k/rfb/99dHpxurQWmoXJusL2BLNpINYGKxRuR
         fQ19HdA8OYmvw+nXk5Nsthb/a51+YXEURrWpejcoZc9PKA290ASs/3BrakCiIn4doIZC
         QxbP79KMavqyayCfcsRNOGo9wBA32Zbb6SrhrL+jyx4sUd47BSElL6FplD2bdtTOa7MY
         4YbU9xO+Wdd7fBAQRwersO9OeSabeseH4ztw8CvUXLLzCKjENmm1Q4S4A5+8oemS16r2
         FuyKF1XhXciZkDDw3Q+WJJuSost9rtwrSVKnr9z5kkRX9DUyNe/r2RMRQJkIK5z/8X+h
         O44g==
X-Gm-Message-State: AAQBX9cpQx/l2T1wTmMZZkgsqygl7woEwFBQFE51v8Ww1HxVX1OR3+S2
        SlFyJtTdIJUEWd4NKMHA5Dkzvk9OiUBz9ShWaFc=
X-Google-Smtp-Source: AKy350acMNsWGS+6WUWBrgeWxQqdoK8pwRvZu1EyiiOwDnqVHQSCEabz2tnT0gxbNLMGN5AlYmXL1nU6G9XWOg+N0Rs=
X-Received: by 2002:a50:a415:0:b0:504:898b:e482 with SMTP id
 u21-20020a50a415000000b00504898be482mr280373edb.3.1681346604711; Wed, 12 Apr
 2023 17:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230410174345.4376-1-dev@der-flo.net> <20230410174345.4376-3-dev@der-flo.net>
In-Reply-To: <20230410174345.4376-3-dev@der-flo.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 12 Apr 2023 17:43:13 -0700
Message-ID: <CAADnVQJRd3r84yLcqH1Z-BYU76SRYuDMOCWRcvBfapsXs_w-rg@mail.gmail.com>
Subject: Re: [v2 bpf-next 2/2] perf: Fix arch_perf_out_copy_user().
To:     Florian Lehner <dev@der-flo.net>
Cc:     bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hsin-Wei Hung <hsinweih@uci.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>, dylany@meta.com,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 10, 2023 at 10:44=E2=80=AFAM Florian Lehner <dev@der-flo.net> w=
rote:
>
>
> -#ifndef arch_perf_out_copy_user
> -#define arch_perf_out_copy_user arch_perf_out_copy_user
> -
> -static inline unsigned long
> -arch_perf_out_copy_user(void *dst, const void *src, unsigned long n)
> -{
> -       unsigned long ret;
> -
> -       pagefault_disable();
> -       ret =3D __copy_from_user_inatomic(dst, src, n);
> -       pagefault_enable();
> -
> -       return ret;
> -}
> -#endif
> +#define arch_perf_out_copy_user copy_from_user_nmi

This fails to build on aarch64. See BPF CI:
https://github.com/kernel-patches/bpf/actions/runs/4683969153/jobs/82996124=
49

Easy to fix, but I'd like to get an Ack from x86 folks for the 2nd patch.

I've applied the first patch to bpf-next, since it fixes the real
issue for kernels with hardened_usercopy=3Dy
