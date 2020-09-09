Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFAD2638AD
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 23:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIIVvI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 17:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIIVvG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 17:51:06 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58DDC061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 14:51:05 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p13so3818463ils.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbmcFvblMf2fD8HTFQnrfzBnp6Lnk39k8oBgB6/Ch44=;
        b=Jhu9tputUMQA/PN7jGIdy//oXokB0qOMwqEcjIRdaSBrAEBC9sKrYHVVpc+JyHfAGT
         Hp1Eq1uxYq3S3OwVAJeqw9gjJqB0FQKz9QT9vVcQWPjkUa8+A791YNlyoF6Pvz7D43ZE
         Ex6aVhY+vybdYlkKYvPWEYFxHf9gWf2u/BLag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbmcFvblMf2fD8HTFQnrfzBnp6Lnk39k8oBgB6/Ch44=;
        b=dGvmZjvPyloidvxplf7xU+eDfr08sAaaW/mVtHgDS48cD5bZTcTzYdZUoNil81t190
         h+Qpm6HNSI4Gy1LtdNPjczN9uPui5/ukc5qRxHFronN+NqQCkbKI+9b7dyGWXYLRZ/ln
         gduGpKTvWs9fnkHiLJtQ32jOhNi/0fIRNd4FB6arXEp5++Km6mtV/jpceI0XedC1J8u5
         3T5KUwRLG/L1/IyoUg14Xx6nwJdbFsw3WBCXnjhe8gPVaBpzPi0kYtov6Bs23mqXGYUe
         8W6sDJowYoOYW1gbQXWlNIG0zCDFVY5lBLMV1Hb0anAXJERC+PZjrwpyXNgG7URYYYlW
         0AOg==
X-Gm-Message-State: AOAM532XpP1npPKeiUork91f+PAr+UbemzlonDRVAvwtA+4GwgfYQfRi
        wlkn2rfV3bJnyZGLZNE0x23jwS5wjuQe2GwIWab9Fw==
X-Google-Smtp-Source: ABdhPJxaWXGMLToZGmahA1JCKVhfC9ElSxoh3o3rzqAopMHqLx49PzZ0KsO3gMwwGzwawspawVg1SFmIThddHmJcnwk=
X-Received: by 2002:a05:6e02:10d1:: with SMTP id s17mr4103439ilj.24.1599688264864;
 Wed, 09 Sep 2020 14:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANoWswkaj1HysW3BxBMG9_nd48fm0MxM5egdtmHU6YsEc_GUtQ@mail.gmail.com>
In-Reply-To: <CANoWswkaj1HysW3BxBMG9_nd48fm0MxM5egdtmHU6YsEc_GUtQ@mail.gmail.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Wed, 9 Sep 2020 14:50:29 -0700
Message-ID: <CADasFoCaEYQCuF+SVF7PBTB6-dU7MZj1NHwxQ0=qacTi516SPw@mail.gmail.com>
Subject: Re: arm64 jit ctx.offset[-1] access
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yauheni,

Thanks for the report!

>
> Jitting the program causes invocation of bpf2a64_offset(-1, 2, ctx)
> from
>         jmp_offset = bpf2a64_offset(i + off, i, ctx);
>
> which does ctx->offset[-1] then (and works by accident when it
> returns 0).
>

This definitely looks like a bug to me, I ran your test program and
printed out the values of bpf_to in bpf2a64_offset and it is being called
with bpf_to = -1.

One way to fix this is to do something similar to what the RISC-V JITs
do here, by checking for the < 0 case explicitly:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/riscv/net/bpf_jit.h?h=v5.8.8#n145

I imagine it would look something like the following:

--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -146,11 +146,11 @@ static inline void emit_addr_mov_i64(const int
reg, const u64 val,
 static inline int bpf2a64_offset(int bpf_to, int bpf_from,
                                 const struct jit_ctx *ctx)
 {
-       int to = ctx->offset[bpf_to];
-       /* -1 to account for the Branch instruction */
-       int from = ctx->offset[bpf_from] - 1;
+       int to = (bpf_to >= 0) ? ctx->offset[bpf_to] : 0;
+       int from = (bpf_from >= 0) ? ctx->offset[bpf_from] : 0;

-       return to - from;
+       /* -1 to account for the Branch instruction. */
+       return to - (from - 1);
 }

Anybody else have any thoughts? I can turn around and submit this as an
actual patch if it seems reasonable to others.

- Luke
