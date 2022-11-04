Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B6E619A30
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 15:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiKDOiN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiKDOhn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 10:37:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B947338
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 07:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E125462173
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 14:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47214C433C1
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667572505;
        bh=3tM0gxjWY8KEy9byWN7hAJJfWRhSSIiLsgxoPZrgI2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jUIMR274AfUPRTabjJQx6OTmL3mTqBuU1UqHuyPNSd8BpDcFdSbbS2tclX2/WK9bT
         CnwtVEBiJgAq/9tVEJqSBQ2w1RNUOwWrJGPFp2ZdrUhzTfFMuON6iYgIK8YmRyz+Fl
         C4frqqaPR1Akj4IlLjBs9g0NVjpAk2G4LAIk2PcvrLWsv190o79LwJhkQuVfbdIuN6
         yQzDEqA84i8UGHJR+o/ThpkGII3ybMCI8Sm9RR9mylc09US2SVFBFC9mACizIx9JXJ
         hVv0qm5R5XF+pkSOlgQnL3KKv8S5RD+EVvjX4q45/chsI8qsEpZh5D46x95vLIT216
         onnMeNStlkbJg==
Received: by mail-lj1-f177.google.com with SMTP id c25so6613678ljr.8
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 07:35:05 -0700 (PDT)
X-Gm-Message-State: ACrzQf3wq6vrPKByMMR0Qzw5tV1HdM2YAgDj+Qyn2swPiJRQaeouZf1U
        lVgiU+UDXYAg6qjok60vXT7tUWH1P1tqsDReyr+jXw==
X-Google-Smtp-Source: AMsMyM5HbK+ugzyU/UP3aZiHPx6ClTIgbwUqO+CBf2YizPH4MrtPZdSIf2GVIGkXvjrTJv4bO39zMSEx4WaelNmIWKI=
X-Received: by 2002:a2e:a211:0:b0:26e:861:522f with SMTP id
 h17-20020a2ea211000000b0026e0861522fmr13207433ljm.508.1667572503281; Fri, 04
 Nov 2022 07:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221104051644.nogfilmnjred2dt2@altlinux.org>
In-Reply-To: <20221104051644.nogfilmnjred2dt2@altlinux.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 4 Nov 2022 15:34:52 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4AeNEbag2EZo4+Mpn6NM-ELvKUkSKVDHdoNFHcFOygQA@mail.gmail.com>
Message-ID: <CACYkzJ4AeNEbag2EZo4+Mpn6NM-ELvKUkSKVDHdoNFHcFOygQA@mail.gmail.com>
Subject: Re: bpf: Is it possible to move .BTF data into a module
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 4, 2022 at 6:16 AM Vitaly Chikunov <vt@altlinux.org> wrote:
>
> Hi,
>
> We need to reduce kernel size for aarch64, because it does not fit into
> U-Boot loader on Raspberry Pi (due to it having fdt_addr_r=0x02600000)
> and one of big ELF sections in vmlinuz is .BTF taking around 5MB.
> Compression does not help because on aarch64 kernels are
> uncompressed[1].
>
> Is it theoretically possible to make sysfs_btf a module?

I think so, it may need some refactoring and changes
but, yeah, in theory, the module could ship with the
kernel's BTF information which can then be initialized by the module.

Curious to see what others think as well.

>
> Yes this will reduce tracing at boot times, but at least it will give
> option for occasional tracing after boot.
>
> Thanks,
>
> [1] https://www.kernel.org/doc/Documentation/arm64/booting.txt #3.
