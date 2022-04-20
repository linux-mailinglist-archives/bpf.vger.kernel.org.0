Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B0E508EB2
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 19:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiDTRmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 13:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiDTRmt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 13:42:49 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F0743ACD
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:40:02 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r17so1446633iln.9
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4gRXbwGWeQbEOQRWaNaZSKa64vSDMdfhUN310xP+Sw=;
        b=SNFtw31WTDEtiAcqgMek4a/xGHFuk7lt2Oh17bB+TZmb5LRgN8g6eqXtPcff6tAFvU
         F7l5RNqZBYM8NoWUj2o26SF4bM3O/d68YWLgucvN3tdjrcXMZjmMqgv7mTY5bF4Z1N7s
         q568ntr7LZOY4cseDy3MKg65hVZB3kNXtOJTbRnT99cFgRh8spmOShqLkwS68+AkGi6z
         f8Vr0WS2j35UAdoItsU0K7puVqdEasmVHbDxkrjPtgPXiG05MrA4gbaGBaoLDYrVvTsu
         F+UWevNqts5y2xJUid4XSz+6rOLXHsy+upPGitQZ+GyZLiPcapc9ArghhMQnG/R1wBKG
         Fu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4gRXbwGWeQbEOQRWaNaZSKa64vSDMdfhUN310xP+Sw=;
        b=yREhx9iqvEWmiyK1jw3YHzZ+BX02BrVgxDKSD+r6unWbqyIRqnlRXBRnMFaxqLL5+o
         HzarUIfMudp+N1lk8sNEJEjaNJYGoHkm+nKLNE5FFVk/uOfuoht7pm18aivZos1YEG91
         cmQR7s47zdDOsl3ozzWKlWX9jBpmiv6vmWxLYG0CdOrlMnSbr61XuNurw945npzo4jwo
         Nqw3XTlpOUucoFz6LZbsbVvlscXWl+fFfEr57g7rW5LUo6nHc4OqUUAIYroHYS1JOv/N
         OJyiaacooXrVu560ogQopuys++RYxUF7fu9DklSCUrylRCH4iuwb0+4ESzvRN9IgpXpT
         PCaA==
X-Gm-Message-State: AOAM531O/TqpwpUPzpP714PpaQdBOcr6ih9v9yH8cHjVEs09kpywoe2c
        mqeBeGvQgNOxSfCF79P87368BSLyQtj7iMy4LKQ=
X-Google-Smtp-Source: ABdhPJwEwO4pHej9wisYHUCuX6O3dYXAw52idatx7CFrSietTTLj97aPaTupAmIVCJJguoygepXjtw4Iu0ViKWvIwLY=
X-Received: by 2002:a05:6e02:1ba3:b0:2cc:4158:d3ff with SMTP id
 n3-20020a056e021ba300b002cc4158d3ffmr4688396ili.98.1650476402107; Wed, 20 Apr
 2022 10:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220416042940.656344-1-kuifeng@fb.com> <20220416042940.656344-3-kuifeng@fb.com>
In-Reply-To: <20220416042940.656344-3-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 10:39:51 -0700
Message-ID: <CAEf4BzZC3rWe4xan8fHWMZtT1ckHCUAx8N0htFGh1gO8=XMVBA@mail.gmail.com>
Subject: Re: [PATCH dwarves v6 2/6] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 9:30 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> BPF trampolines will create a bpf_tramp_run_ctx, a bpf_run_ctx, on
> stacks and set/reset the current bpf_run_ctx before/after calling a
> bpf_prog.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

the overall approach makes sense to me, I'll leave it up to Alexei to
validate nitty-gritty details of x86 assembly :)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  arch/x86/net/bpf_jit_comp.c | 38 +++++++++++++++++++++++++++++++++++++
>  include/linux/bpf.h         | 17 +++++++++++++----
>  kernel/bpf/syscall.c        |  7 +++++--
>  kernel/bpf/trampoline.c     | 20 +++++++++++++++----
>  4 files changed, 72 insertions(+), 10 deletions(-)
>

[...]
