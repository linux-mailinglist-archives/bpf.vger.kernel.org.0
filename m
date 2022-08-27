Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4DA5A3A7F
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 01:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiH0XqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 19:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH0XqA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 19:46:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32174E627
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BBA2B80A6A
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 23:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E8C433D7
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 23:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661643956;
        bh=6V7QaYazlv7zLobd0OziwDUOntKxt41UK0u+iYMS8i0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YW0BpsksfbZh/Bf1H46puxpk/Z+O4q3hZylEtFFCvxSz4w2CUlmKC27YO03GQnY/S
         hllKYzm3EDcQCmKrtjIbIXUFMGP9xe1cO8GZ+YbEfdE/HXgyiYm7yw9gUMV/TkZF6O
         caOvNUr8ZtktYkuUsDVUIYEIYiE1GEF0ZpXcsoiM+4qslmTn9QpYysQskG+AbEEx9w
         dDk9XOAo5TnnZmxmS5M5ZedxHIZdH8dQZLkfihIMc2dPxYqli4mMmpseSUV5m8Iq1I
         5E5Ri5zgAxigyuHGJmccvakYWjufotNeQvCR1LUigLij0IIq5bYCpe7Jd3VDo44iXW
         QMy15gDs7+OVw==
Received: by mail-qv1-f54.google.com with SMTP id d1so3876049qvs.0
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:45:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo3iwiIQPrPplhvze0cqfPwTeHMctc4Dd/n1G2RM6smcQeZ2eCPi
        INFa9gxxDdIGaBgjoguRRiZUsHwuQ0qKfQKPlVi6xg==
X-Google-Smtp-Source: AA6agR53WqNHG1bWNWMJT7AG6+TO4dUS+JaXMp/vjbTmnwqmj4Tyy97gq6S5KgLpvvki1JWPtNg0w1Tdguqi06l3L8k=
X-Received: by 2002:a05:6214:2684:b0:496:de55:8df0 with SMTP id
 gm4-20020a056214268400b00496de558df0mr5176242qvb.107.1661643955812; Sat, 27
 Aug 2022 16:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220826231531.1031943-1-andrii@kernel.org> <20220826231531.1031943-3-andrii@kernel.org>
In-Reply-To: <20220826231531.1031943-3-andrii@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 28 Aug 2022 01:45:45 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5+DzWsuz6PTMOgzg_uxwPiPpcK5AC3ttnxKPU0M0gRfQ@mail.gmail.com>
Message-ID: <CACYkzJ5+DzWsuz6PTMOgzg_uxwPiPpcK5AC3ttnxKPU0M0gRfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: fix crash if SEC("freplace")
 programs don't have attach_prog_fd set
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

On Sat, Aug 27, 2022 at 1:16 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix SIGSEGV caused by libbpf trying to find attach type in vmlinux BTF
> for freplace programs. It's wrong to search in vmlinux BTF and libbpf
> doesn't even mark vmlinux BTF as required for freplace programs. So
> trying to search anything in obj->vmlinux_btf might cause NULL
> dereference if nothing else in BPF object requires vmlinux BTF.
>
> Instead, error out if freplace (EXT) program doesn't specify
> attach_prog_fd during at the load time.
>
> Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: KP Singh <kpsingh@kernel.org>
