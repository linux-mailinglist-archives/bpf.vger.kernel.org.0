Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD438EEF1
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhEXPzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 11:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhEXPwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 11:52:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699EFC014DFE
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 08:05:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q7so39784471lfr.6
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=kD1YgnfmVi1P0TqS21nqyM3dRTXHLqHyzYLii32DiYw=;
        b=JGq486ZxwvTSM9BlKFHujpZmdlNJ2cB8kAa2tu9ppZqn1xvKH3DV37X1K/VBSvfzwH
         cpl95nwTCtVn8DjzSJMxf/4FiOp/gb/Y+YaoetJ/5o4qJwZGGFmatPT8Kpjx7MuhNWVA
         NyOq5TyFIWH//4iyM3M2hytb6YN1Yol/ODp2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kD1YgnfmVi1P0TqS21nqyM3dRTXHLqHyzYLii32DiYw=;
        b=FH1PFuqbyRbbLJDHAVvC3OklSi9tJwZ7FfyNmlulcZrckpniJpS5qmyGHogmUxCkSe
         Rc9tjvqdfXmI9gGhKsCr6OSjRPrcrcdGSJOCSVk5rSva7z3xBInj7QM42TRIHLeU/3EO
         xs8Q4d5W7amQGaWRrnxhnCkIZsmIK69CvTNtbdhd/Gn0ys4pZZJ1MoTRhe7wI6fxjRpy
         MWrcKsjEuzZA4vkhxY5kAmC3HCcDwK64nCqUNADuY6FTlIf5OxxCp6FwdLl7nr21PwN7
         LGJ0zfUxSkSGeVgF1IE9iWq/KBf5uPo9cBwdgYF3DQLBj5l3QbCmu9NVfqzlutXneUFW
         GX6A==
X-Gm-Message-State: AOAM532gkMVj8EhornQfnDPKiZidcDSekV3Y46Tj776C0WPv3BXUwEOV
        QXMVX6XqioLqs7DEdUjuA8Oo4L4Wr1YUokcPRuM7keYn1aa1PQ==
X-Google-Smtp-Source: ABdhPJzdTKzILml37+0SG9DeCjGxWzDx2/RNAqdzIjz6UsWmoxgt9t5fBhYfyedL4Sde82x5EGRER5x5H8sAuCUijCU=
X-Received: by 2002:a05:6512:10c8:: with SMTP id k8mr11205803lfg.325.1621868715609;
 Mon, 24 May 2021 08:05:15 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 24 May 2021 16:05:04 +0100
Message-ID: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
Subject: Portability of bpf_tracing.h
To:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

A user of bpf2go [1] recently ran into the problem of PT_REGS not
being defined after including bpf_tracing.h. It turns out this is
because we by default compile for bpfel / bpfeb so the logic in the
header file doesn't kick in. I originally filed [2] as a quick fix,
but looking at the issue some more made me wonder how to fit this into
bpf2go better.

Basically, the convention of bpf2go is that the compiled BPF is
checked into the source code repository to facilitate distributing BPF
as part of Go packages (as opposed to libbpf tooling which doesn't
include generated source). To make this portable, bpf2go by default
generates both bpfel and bpfeb variants of the C.

However, code using bpf_tracing.h is inherently non-portable since the
fields of struct pt_regs differ in name between platforms. It seems
like this forces one to compile to each possible __TARGET_ARCH
separately. If that is correct, could we extend CO-RE somehow to cover
this as well?

If that isn't possible, I want to avoid compiling and shipping BPF for
each possible __TARGET_ARCH_xxx by default. Instead I would like to
achieve:
* Code that doesn't use bpf_tracing.h is distributed in bpfel and bpfeb variants
* Code that uses bpf_tracing.h has to explicitly opt into the
supported platforms via a flag to bpf2go

The latter point is because the go tooling has to know the target arch
to be able to generate the correct Go wrappers. How would you feel
about adding something like the following to bpf_tracing.h:

--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -25,6 +25,9 @@
        #define bpf_target_sparc
        #define bpf_target_defined
 #else
+       #if defined(BPF_REQUIRE_EXPLICIT_TARGET_ARCH)
+               #error BPF_REQUIRE_EXPLICIT_TARGET_ARCH set and no
target arch defined
+       #endif
        #undef bpf_target_defined
 #endif

bpf2go would always define BPF_REQUIRE_EXPLICIT_TARGET_ARCH. If the
user included bpf_tracing.h they get this error. They can then add
-target amd64, etc. and the tooling then defines __TARGET_ARCH_x86_64

1: https://pkg.go.dev/github.com/cilium/ebpf/cmd/bpf2go
2: https://github.com/cilium/ebpf/issues/305

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
