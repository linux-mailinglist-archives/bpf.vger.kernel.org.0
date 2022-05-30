Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437A25374A5
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiE3Fu1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 May 2022 01:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiE3Fu0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 01:50:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AA6470B;
        Sun, 29 May 2022 22:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3337B80B9C;
        Mon, 30 May 2022 05:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9557FC3411A;
        Mon, 30 May 2022 05:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653889821;
        bh=zR5wxk1o5yG2X1p3FMRn06KEzqM/Qj4ZRx4DJMWegBI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SdXfO5nzp9kGY8QxfVDAcmiIzQnzWzMbb3UDSPS+uwXYkw3YfpcUswC6iPK74iDtD
         6PhQ5KtzLH0RCH+LZ+6AyYbKWIeaingXISyPC3gVt4E8Za3pJtFuqTanJQ0tcvme/4
         ltSS7Nm1QfQCGWE1c4/K2YpdZWWrc+BlfWv407E5ZLl626fV5k1kSzCFmx7ethGojw
         3ocQbrR7tkwWimvb6w9IGSTzh/aRVrLSadE+nyh6TXCUnQnaSc5sT+uDBlcbFNrPWe
         4VDKHGdFfYfPLo8PKAMur+QgaUjFdC0Q2ECsI7DZtXP0KazNGt57+mN5SV/FYAM+vz
         RVlJqxvTKB3/A==
Received: by mail-yb1-f182.google.com with SMTP id h75so11343761ybg.4;
        Sun, 29 May 2022 22:50:21 -0700 (PDT)
X-Gm-Message-State: AOAM533NRMn+CIsYqnLeT8K6SbcjkgS4y0YEUgJkxwkwGuPb0JJ0Etoy
        4O880cwkkdqsGrX5sRZ0tcpZbPOpahvWqeepzZE=
X-Google-Smtp-Source: ABdhPJyx/idoF+26OybQl9WinGG6SC8BnaZd3+wjIH3J3SjDiGty9Q4ujOgCIxhagSXt+BCokd88FxWx82/VYxoLP6M=
X-Received: by 2002:a25:7e84:0:b0:650:10e0:87bd with SMTP id
 z126-20020a257e84000000b0065010e087bdmr31358213ybc.257.1653889820663; Sun, 29
 May 2022 22:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <0a9aaac329f76ddb17df1786b001117823ffefa5.1653855302.git.dxu@dxuuu.xyz>
In-Reply-To: <0a9aaac329f76ddb17df1786b001117823ffefa5.1653855302.git.dxu@dxuuu.xyz>
From:   Song Liu <song@kernel.org>
Date:   Sun, 29 May 2022 22:50:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW55ZtCWcFyKThf-ShvgsZWHgz=zSjhSHROTuruYJu-zvA@mail.gmail.com>
Message-ID: <CAPhsuW55ZtCWcFyKThf-ShvgsZWHgz=zSjhSHROTuruYJu-zvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, test_run: Remove unnecessary prog type checks
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 29, 2022 at 1:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> These checks were effectively noops b/c there's only one way these
> functions get called: through prog_ops dispatching. And since there's no
> other callers, we can be sure that `prog` is always the correct type.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Acked-by: Song Liu <songliubraving@fb.com>
