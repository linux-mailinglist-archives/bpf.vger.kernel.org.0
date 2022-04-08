Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BF64F9ED4
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 23:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiDHVKd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239630AbiDHVKd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 17:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE0160FC6
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 14:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F53261F4E
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 21:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBD1C385A6
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 21:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649452107;
        bh=ESLaPSPNPV9TcCCf8EXdRHXQtxk6eKO7pufLSb/dHnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bDISaIn1egnrMuflLp1uLv9wm0x16VobYNFrHtYcDVdPC+g1SXXRd5XogheiVNrmU
         FL8DrUXh2Rnyq46AM0kM+ny53XZ2lwghRKwSK7QKGHrL51oU2GnzqervsIktM7x45x
         vrr0vIFJKit/fEA1rCTsAcBrV2UzDQV+AbKgf4i31pQqIYCgOj4FN0eyLi/n0CKBKa
         HCM48XWwCR4/8u6pFCU94rHAWfPKy96ZrcjmpChT7fsjsswTTaKA/lE65HkKVbh7cm
         NQyvvejx+gCCLto/VksK6ygMhpGmQwkt9wfjRD4sfZwtvk/g2RcgX7KWvdamYS/11q
         NvTIgMa7mwrHw==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ebef467b1bso21253417b3.13
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 14:08:27 -0700 (PDT)
X-Gm-Message-State: AOAM531YiQoQFXxM5FHBiDAqTt9w2cZzqh6KIbgVyxbKjd5VUHiIWUJG
        GN2PVGAS/gdQ4rQvbiM9IXSWnVYz0IvjCHbNdl4=
X-Google-Smtp-Source: ABdhPJxpXG1eLTrO4NYgE4pJQ0nGw/WLVdYDuGWcEqHHq5CF2V134/oRlSB1AoNeiZ4xp1uGhLkLcU3vBfw21YqsUJ0=
X-Received: by 2002:a81:14c8:0:b0:2eb:eb91:d88f with SMTP id
 191-20020a8114c8000000b002ebeb91d88fmr3381369ywu.148.1649452106646; Fri, 08
 Apr 2022 14:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220408203433.2988727-1-andrii@kernel.org> <20220408203433.2988727-4-andrii@kernel.org>
In-Reply-To: <20220408203433.2988727-4-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Apr 2022 14:08:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4oEtV8i9JEx8fLN-Yp54VWdADc=hUYNfWFbrDHVudNww@mail.gmail.com>
Message-ID: <CAPhsuW4oEtV8i9JEx8fLN-Yp54VWdADc=hUYNfWFbrDHVudNww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: use target-less SEC()
 definitions in various tests
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Apr 8, 2022 at 1:34 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add new or modify existing SEC() definitions to be target-less and
> validate that libbpf handles such program definitions correctly.
>
> For kprobe/kretprobe we also add explicit test that generic
> bpf_program__attach() works in cases when kprobe definition contains
> proper target. It wasn't previously tested as selftests code always
> explicitly specified the target regardless.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
