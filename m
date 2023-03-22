Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582E66C4421
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCVHdc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 03:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCVHdb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 03:33:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9B4ECEE
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 00:33:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so68949666edb.13
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679470409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DhKo4uPOKGEjmlqKw99Ku48Qcs3BaHFMsvQsM8SpoVs=;
        b=OXLMUhhdGdxNmH/k8fSLKrI6pAxdM+7x7y+jvsgxzyKsG5IDdNTBM/hlTAin0vwu65
         FFivOoVEAoF6I1m2V/IavLJOsxbdOo8EsuCOS59MWGhXGIgM6jyYGRiRAjxf3+JsbZn2
         gVgeJJb7GJ43PzeyuQ335xvWhoPkZ8T/GHrELn8fawvv088kNUSsBlgzyZLQIvxK26Ru
         USgcGkNuJ9ujH/HV13XfrheCPCkSrHqlneBPiXF/XqDzeXYBqcW0AL0/RA0QgX20JQ+4
         TCo7+8k2XsB5OmHaz8HQye4Icqxva6dEaWUXx8aGrU/zyfLI2BTeXqwnSBdIBJ4EyScZ
         FpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhKo4uPOKGEjmlqKw99Ku48Qcs3BaHFMsvQsM8SpoVs=;
        b=32j+R19LuYT2oRNkjk6X75b1f1u3BGZn7oPPK96UUc3xJ/aKFY6LELkdqXpKkRLBHz
         WQuN5nb112XJPxii6QC5L5Dqbb7NUOQg7WmU+ZspEgKjdgjzEt+9y4oU4GuoInWGphLV
         IA2PwirSdEaWyLGha8Fd/lgkVauL6VzM69Px6T2stCjgDoFV9Hjt/R56532t7ybISvK3
         D3YAYqdh2NsETHKWiHlb7I47hNd8GYmYh4nAGXaMEEB1l8gFca/Y3KEjSMUbgGQsqIdu
         My2ZIpQynreo0oqAGgB6k9OZp5kLl7Njs1fbG4NouEaV2ZY6gbf/HpnD6ovaQ3g0Bxqh
         OeHg==
X-Gm-Message-State: AO0yUKU02jV7z/3Wbk3WrAT3p0GPRfh1Kc8tJxYh3h4a74o99HL+5YQ3
        1zIyI39SIXj5ApqGkN2l1mgeT9mnD0YWdm3zMnmTt8JA6rTzVA==
X-Google-Smtp-Source: AK7set8SeTCy1B6h1b6mb8dfdWYNxMLjyihTp4fVSgF/NXxufee+Qtr3I91ZQKCDgUCuItV+GI0vjFf/kOuFxzqN68w=
X-Received: by 2002:a17:906:fb0b:b0:933:4ca3:9672 with SMTP id
 lz11-20020a170906fb0b00b009334ca39672mr2932957ejb.12.1679470409398; Wed, 22
 Mar 2023 00:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
 <ZBo164Lc2eL3HUvN@krava>
In-Reply-To: <ZBo164Lc2eL3HUvN@krava>
From:   Davide Miola <davide.miola99@gmail.com>
Date:   Wed, 22 Mar 2023 08:33:18 +0100
Message-ID: <CAMAi7A7Y=m=i-yEOuh-sO-5R5zEGQuo1VwOLKsgvFcv4RRhbhQ@mail.gmail.com>
Subject: Re: bpf: missed fentry/fexit invocations due to implicit recursion
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> seems correct to me, can you see see recursion_misses counter in
> bpftool prog output for the entry tracing program?

Indeed I can. The problem here is that the recursion is not triggered
by my programs; from my point of view any miss is basically a random
event, and the fact that entry and exit progs can miss independently
means that, at any point, I can count two exits for one entry or
(worse) just one exit for two entries, making the whole mechanism
wildly unreliable.

Would using kprobes/kretprobes instead of fentry/fexit here be my
best compromise? It is my understanding (please correct me if I'm
wrong) that kprobes' recursion prevention is per-cpu rather than
per-program, so in this case there would be no imbalance in the
number of misses between the entry and exit probes.
