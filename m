Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D83A5A3A7E
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 01:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiH0Xn3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH0Xn2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 19:43:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E449B4BD07
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 338F4B80A6A
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 23:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1194C433D7
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661643805;
        bh=+fyjPINZdGUzyAA1QpPU87R9QIjARoT2LiO3hR+xMKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aOZ8V+Mm0Pcia4LAblIOuighAYKZno+/puqELwuNoiV4mOXWl/45YVqn/Ooi7/XxO
         8csEDwhamLQvk3He3VrcLDepu/IHnKDEshnuQNsB02KZ63mcSZ49J2eKS3OCdhjcyU
         eSfKbYk+hIoSRnnn7/w56N1LqwwDoWaIyFhzp/S5XWxi4y+HOCVr1JJ/JIetJdDs6r
         3vrOzcbtBOt0pCrk4DV5g0ugG9lQU2XDS4xIC02HBcOZlcgev4dbZxZFHA81NF70Az
         L6k5syutQRVJUypI9Aq5Yjj+fGjh/S1ZaUf1ViNdzkbwvNPbhRbtW+xUzl32LGP1nj
         EuZ67J0z/J3Lg==
Received: by mail-qv1-f53.google.com with SMTP id f9so177097qvw.11
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:43:24 -0700 (PDT)
X-Gm-Message-State: ACgBeo0MlHwlV6QJ8w+yQIGwOuvrt6asR+5e+9XUOIrJxgATqGBMcr6F
        OdWKevF4GDoM/BwScC25dzS6dcaZDqGIPV8AB3dP4w==
X-Google-Smtp-Source: AA6agR48MaQKe8txkGX5Y2Qm7ct1iEywiZWCb1HnRpjdrn21i4M9N57C4Tc/WXfpzZG9cw8g30Xju3ql72GMgqckNs0=
X-Received: by 2002:a05:6214:2aae:b0:476:b97e:1c1e with SMTP id
 js14-20020a0562142aae00b00476b97e1c1emr5147046qvb.126.1661643803757; Sat, 27
 Aug 2022 16:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220826231531.1031943-1-andrii@kernel.org> <20220826231531.1031943-2-andrii@kernel.org>
In-Reply-To: <20220826231531.1031943-2-andrii@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 28 Aug 2022 01:43:13 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4VdYREhc+=pUKo6jfgu5UXqkAVEbJ49-pPZXgGhmRnQw@mail.gmail.com>
Message-ID: <CACYkzJ4VdYREhc+=pUKo6jfgu5UXqkAVEbJ49-pPZXgGhmRnQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: fix test_verif_scale{1,3}
 SEC() annotations
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 27, 2022 at 1:15 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Use proper SEC("tc") for test_verif_scale{1,3} programs. It's not
> a problem for selftests right now because we manually set type
> programmatically, but not having correct SEC() definitions makes it
> harded to generically load BPF object files.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: KP Singh <kpsingh@kernel.org>
