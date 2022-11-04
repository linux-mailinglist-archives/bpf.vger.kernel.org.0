Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2105619754
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 14:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiKDNQ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiKDNQw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 09:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE8A2EF05
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 06:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F3E0B82CFE
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 13:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21A3C433D6
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 13:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667567807;
        bh=T2gXDiJqgByvHZsKFOUU0vjzD/iVerZ54w/8dGlGVBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Co+Ihr7+mylgkgwzTP8PJus/1/+5pCRPPWe+NwqjRMx6zTeYYlLRmeV8qXN5Vdl/A
         iWi1sJUAT7k+M1au+gp1Uav5bo9aJ0XytNt6QvRvZifGEx23VvdPMi2vxrAmExMwUe
         Vc5N/OXwU3EL5bvapARozPwC4g/NVYD+dXRon2oYSiP789dUjNAJDWyobUgExMRHjR
         Hhp6H34wYcOeVuDu86ht+H1lhqKqb3x3qDCTFo0JWctuZhjF9ofxVqj/cgdwu7y/Cm
         w1ZWgU17y+OnuFt4m/JOQdFAWnuFN896TvIccfDYtJdtCdFD4oEHnaOlQtf9OyvNV6
         vsQ15khype3Pw==
Received: by mail-lj1-f179.google.com with SMTP id k19so6321737lji.2
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 06:16:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf1N/hjjSQCkdZ+Lkga0GjtPCGNKr9IPJrI0RrMeit5SSj1FjURr
        ILZFiDd0FdOzQ9OYOp5XpbHbuxuvX0s0vPm+WAqP3Q==
X-Google-Smtp-Source: AMsMyM7NWcVL2vaGbcou/fnIP3CKTPl+hRuPzErwPx7le/15F84d+iL7YhayD2QXQkCrJL1HCwESjQnI47zMh23OWn0=
X-Received: by 2002:a2e:a211:0:b0:26e:861:522f with SMTP id
 h17-20020a2ea211000000b0026e0861522fmr13091555ljm.508.1667567805033; Fri, 04
 Nov 2022 06:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221104123913.50610-1-bagasdotme@gmail.com>
In-Reply-To: <20221104123913.50610-1-bagasdotme@gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 4 Nov 2022 14:16:33 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6h=TsxLvXVbfUDgsfd5uZqqsmAXsZhdQS12ZyHniiVMg@mail.gmail.com>
Message-ID: <CACYkzJ6h=TsxLvXVbfUDgsfd5uZqqsmAXsZhdQS12ZyHniiVMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Documentation: bpf: escape underscore in BPF
 type name prefix
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 4, 2022 at 1:39 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Sphinx reported unknown target warning:
>
> Documentation/bpf/bpf_design_QA.rst:329: WARNING: Unknown target name: "bpf".
>
> The warning is caused by BPF type name prefix ("bpf_") which is written
> without escaping the trailing underscore.
>
> Escape the underscore to fix the warning. While at it, wrap the
> containing paragraph in less than 80 characters.
>
> Fixes: 9805af8d8a5b17 ("bpf: Document UAPI details for special BPF types")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: KP Singh <kpsingh@kernel.org>
