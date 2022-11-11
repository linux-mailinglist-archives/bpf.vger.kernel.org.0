Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1576261E1
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiKKT3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiKKT3e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:29:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128FC6CA1D;
        Fri, 11 Nov 2022 11:29:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m22so14752057eji.10;
        Fri, 11 Nov 2022 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCawkF6LEOLVHZwjEBGXQw5suytiQvMMfoA6wpZGHVE=;
        b=NvFHGwEaTEky/6SwEmA6/+dQIm3mjVTIBSFAB8Yldz+y7ah2uzyCr1bNLRSL2q61dp
         2bUbvuqwk75IH1qmj/az6iTNl/R4/TRYXJxV63DotfQzEMVdHPRoPLf6JatS1ubkt6/N
         zi06gF2M6DRAgDiX0CwzSmYaeLINCWEGOIkyRuLVeG4V/JF7AUNM8cKvAWGuCjRjLO80
         zTuYMpQzXgOqjHkR9SYkQnaOBqQyW76sbgk3IRWM19MZn1LaaAdSF3gkhIipsqoBp2TG
         zfYRvp1A6LXKlJXHY3uwhpq0SHnU3UWi5cMdocbmL5dgHSSKHCfDF56vpKoMcD7SGFNP
         htOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCawkF6LEOLVHZwjEBGXQw5suytiQvMMfoA6wpZGHVE=;
        b=wNCvqymoxg/w69cP/w4iiFPNuNjAh4XJvTUURINXKzTgWDD6qB4ffcMC5Cz7AzOepj
         /7c+8AWgQs8NUUk4pWm1VNkhqEG5qHhZk1JP4HKq7uBX9X7+sXdInApVRScDKvZjHi6k
         l6CNWzDDBsd5qZF7T08Si/RQFEbf+mgUPulDcsBxdvuRwfRNtwOa82/dpgyDfANOxtQd
         M+wuv74An+7TCdgB3Wx7jNbczdp4kdnN27jbkJNOQnInRM21jRpd/4jm3LDXoGBxMgH5
         nAXB5497hpmFAe4gIocbKUvqEOtcDxy158MBbmHO0Gt2aBMzGTOdW7/q09p9LZ2zHron
         UcgA==
X-Gm-Message-State: ANoB5pnJPdj6PE1FAFNK4XlWVTiWdziNskOFxam59x0vd6nPxKZeRH5t
        HIEc7yz6qdhOci9ZZ68KcGOLbDZTBNZxkSAAEszOKvkR
X-Google-Smtp-Source: AA0mqf6RzbRIsUumsadVwc6BggJIswJbMaC8VzAszVy9wH+YtA5aCty1z5XukxmeK3js7vYabgl0pIkAFCe6QYPwCcs=
X-Received: by 2002:a17:906:1d08:b0:7a9:ecc1:2bd2 with SMTP id
 n8-20020a1709061d0800b007a9ecc12bd2mr3030830ejh.545.1668194972619; Fri, 11
 Nov 2022 11:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20221107165207.2682075-1-mtahhan@redhat.com>
In-Reply-To: <20221107165207.2682075-1-mtahhan@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 11:29:20 -0800
Message-ID: <CAEf4BzacLJ-yE0x+JYSbZ=azfSMXgYzb9Fw2-_Gh+m3EGyPDRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/1] docs: BPF_MAP_TYPE_CPUMAP
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 7, 2022 at 8:06 AM <mtahhan@redhat.com> wrote:
>
> From: Maryam Tahhan <mtahhan@redhat.com>
>
> Add documentation for BPF_MAP_TYPE_CPUMAP including
> kernel version introduced, usage and examples.
>
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> v3:
> - Updated introduction to use cpumap definition from kernel/bpf/cpumap.c
> - Separated examples and APIs under Kernel and Userspace headings.
> - Updated Userspace function signatures.
> - Fixed typos.
> - Migrated the use of u32 types to __u32.
>
> v2:
> - Removed TMI.
> - Updated example to use a round robin scheme.
>
> Maryam Tahhan (1):
>   docs: BPF_MAP_TYPE_CPUMAP
>
>  Documentation/bpf/map_cpumap.rst | 166 +++++++++++++++++++++++++++++++
>  kernel/bpf/cpumap.c              |   9 +-
>  2 files changed, 172 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/bpf/map_cpumap.rst
>
> --
> 2.35.3
>

Similar to Donald's patch, there is no need for a cover letter for
single patch submission. Applied to bpf-next, thanks.
