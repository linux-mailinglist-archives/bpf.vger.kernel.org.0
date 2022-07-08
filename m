Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2656C438
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbiGHW1z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 18:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbiGHW1s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 18:27:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8139313B448;
        Fri,  8 Jul 2022 15:27:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dn9so34605605ejc.7;
        Fri, 08 Jul 2022 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jWEX2CAxd2pxItuLqmMwJVi6a+9EYVwihXMCh0ihgo=;
        b=U3iDzdgXfVzjGXD+G2rfy3gKypcJs18kw1GTLONv2MDm8G0RrUrg1dKCVtAvXfLfVV
         Us5QzXMAaG9z7C+VdtuVO3iRmoHRBJolqSPUnp6hFNUB2OmZNCzIRHeIRuSTqjUPRww8
         C71PuBR7F5Dxs2ZcRSItBp8kUwsR27OtkDga6FBNk6QNaBndWI38RqgpZwQWhCGUGYtl
         h8+XT4mVWSbRWXKxLCSBn0pbldS2+CL/iCa/os/PzuCvqcxdo67E7lM+Kxpu6D+TZFBg
         dEOrp6LtxKWaNlORMasmO3uE8ZSAuR230NBs0jKtacRPi+LkgqSG7I9TVIbR66UJJeea
         UDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jWEX2CAxd2pxItuLqmMwJVi6a+9EYVwihXMCh0ihgo=;
        b=SAySfGEtayiyC9IxUeMGm0VrFqVT7UQswuLEfjkjKZ43RtYd3mUNOwHE6QrHU26F++
         ysfYELH80A58ZaT1/evq9uP4wSH4zEtgYooi/g3cSYzF7x1yzRcjkn1XYgCfQvmPoK1q
         DB4y7DLw32vD1+91B2WSAKwjTzYX+VEdTBZqOcNQ33GivxSojLq2cXjNA8CEdXHDaeri
         RKlKny/99WKXkCE0YPDkzBZJyho5KBn72LjyXzuhwgDd6ZXJN7M3oDHb7HOKxi40K5EW
         ASev3s4QT6K9zoJa1OtHPGgDx2FgSgA1Zo/iqMPw+qTVw82rjTm2uyJMZTOczu739fCQ
         MspQ==
X-Gm-Message-State: AJIora9/wtbapM8d8zZBJ5hVoNRCset0MAjrehxMKqJ7BLQBNkci4rtN
        Gsd8cxyjlvid1neuVvPgSeU8OD4fPGepzYcFgEY=
X-Google-Smtp-Source: AGRyM1uM7iTMCcrXnyKJjpWe5665SWlObmqF2sh59dLgUlFOwpTMXAodJBPRhB1IYcZNf8UkdjqfEpoqCYFWFzfv+h4=
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id
 sd5-20020a1709076e0500b0072aa1410962mr5832229ejc.545.1657319266147; Fri, 08
 Jul 2022 15:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <1657113391-5624-1-git-send-email-alan.maguire@oracle.com> <1657113391-5624-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1657113391-5624-3-git-send-email-alan.maguire@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jul 2022 15:27:35 -0700
Message-ID: <CAEf4BzYMggGGti_w+_V=2ZULHztnUBEJyGvFeG=q5=7UMtJeQg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: add a ksym iter subtest
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Vernet <void@manifault.com>, swboyd@chromium.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Kenny Yu <kennyyu@fb.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 6, 2022 at 6:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> add subtest verifying BPF ksym iter behaviour.  The BPF ksym
> iter program shows an example of dumping a format different to
> /proc/kallsyms.  It adds KIND and MAX_SIZE fields which represent the
> kind of symbol (core kernel, module, ftrace, bpf, or kprobe) and
> the maximum size the symbol can be.  The latter is calculated from
> the difference between current symbol value and the next symbol
> value.
>
> The key benefit for this iterator will likely be supporting in-kernel
> data-gathering rather than dumping symbol details to userspace and
> parsing the results.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

Please see progs/bpf_iter.h and add ksym iterator types there. Thanks!


>  tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 +++++
>  tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 74 +++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
>

[...]
