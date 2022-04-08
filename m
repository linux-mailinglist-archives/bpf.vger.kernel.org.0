Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC44F9EDD
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 23:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiDHVLM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 17:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiDHVLL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 17:11:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16DE12AF0
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 14:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C311B82C8F
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 21:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5257C385A1
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 21:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649452141;
        bh=FCrG/TbHf1Rx9sHdO4EIxvzfBALSoavhFb04g88YGsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=olNkjqkwqrNOCsg53C3bkTwT9vdUUremrOpCYr3BEmEkIeiPvMknFN15zJRQVOQAM
         /i++emyk4d5DKMDntgd5DcqoVzhKgI2oFz5gci4J2rZIPIgrKxMexcMaZ2iTYzXx6O
         kMBdolC4NGTAe6Af/3fQIwwTQTGqQIL332phtocLxw1AxOZSr9EUlAgHWJg6cM67Gd
         5BnG23TDhQ4NBxNnYq1RojSpdBaEj48NMv/IRoEO5YzvhhWCg9049IcbS5lYkHlgQB
         6bcg+QVZ7dfIH3Y0mx0+Gpm6ngZH5u0Fp4XD4vReFThhs1kalOPMzeaqUFizldLr0E
         vRGKGB3MTIU4w==
Received: by mail-yb1-f171.google.com with SMTP id d138so17155489ybc.13
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 14:09:01 -0700 (PDT)
X-Gm-Message-State: AOAM531nhWm3FvvZKsallDHBs9kVZ3NvF49Qut+c1fUBltzUUQWZ+TAK
        idi35XN6D0vxhDKkZX2XqAsG0nY+E9J5Xehae+I=
X-Google-Smtp-Source: ABdhPJxfgEn7G6vAEODlTHpOUaVG/HddChBwmvDzzMO3A/+INXpZz4NcGM9XXv1Da5Yv8I8Lh0yWvL4nt4PTQpQ/jEE=
X-Received: by 2002:a05:6902:1506:b0:63e:4f1b:40ae with SMTP id
 q6-20020a056902150600b0063e4f1b40aemr8473256ybu.322.1649452140956; Fri, 08
 Apr 2022 14:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220408203433.2988727-1-andrii@kernel.org> <20220408203433.2988727-3-andrii@kernel.org>
In-Reply-To: <20220408203433.2988727-3-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Apr 2022 14:08:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6ZYEzibrw380sWVdHvOtJ7UtC=E_fT2ohYK_QUa-Zjqg@mail.gmail.com>
Message-ID: <CAPhsuW6ZYEzibrw380sWVdHvOtJ7UtC=E_fT2ohYK_QUa-Zjqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: support target-less SEC()
 definitions for BTF-backed programs
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
> Similar to previous patch, support target-less definitions like
> SEC("fentry"), SEC("freplace"), etc. For such BTF-backed program types
> it is expected that user will specify BTF target programmatically at
> runtime using bpf_program__set_attach_target() *before* load phase. If
> not, libbpf will report this as an error.
>
> Aslo use SEC_ATTACH_BTF flag instead of explicitly listing a set of
> types that are expected to require attach_btf_id. This was an accidental
> omission during custom SEC() support refactoring.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
