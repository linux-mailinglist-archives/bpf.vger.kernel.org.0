Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9307363C76F
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 19:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiK2SyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 13:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiK2SyP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 13:54:15 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30EF4E413;
        Tue, 29 Nov 2022 10:54:14 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id c14so6391118qvq.0;
        Tue, 29 Nov 2022 10:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqjJlh60+/poGgPfMfNUOD4lo3vmtRtOphg6/Fz5FDk=;
        b=NhbcohtzNNZNqqtaY69FqfU+Z2cabzOBz4iNmiI7MtMwbp4PwCEVRxwKXsf8UOZLSq
         IfK25l3hKnkYdpnuGvDwCxCVZiWtPHiNFf6s0alxdk6ZaUd+PKiz5ikGuDJUgP9FSPu/
         YTI+fNyQCrdAaZEJoBE8x1h0MhtQuCfXp57gzjqQwkUYVUfuu8Qe7EF8OAe6k3ktlNOq
         T2mCbowInXgHjzs1X/vPsJtYaujDzlzW2fusQVEah67c+Xh0IMgQvV/fVhch+176E0a/
         d5ZyEcI0hNGk7O+SKM0+rtHe/D3ZWjLBMO/fUaQQsteaHbg7Z8hlPgWs/cjjDIL2rwKc
         jygA==
X-Gm-Message-State: ANoB5pkC2eAoFcNcTG5Fn79EJ/ZpB0eLt1WZk3Zz6o8DXN32ghParHc2
        99Xvylka28RTfDA3ABw4BrQ=
X-Google-Smtp-Source: AA0mqf5gAZhU5mj9rpqN3kVXIHgnexqqCVmTdFry+pV3187acgyklmdwNptFqVjDsEUJNsdm8oiOBA==
X-Received: by 2002:a0c:eb8d:0:b0:4c7:69c:6738 with SMTP id x13-20020a0ceb8d000000b004c7069c6738mr7914410qvo.24.1669748053722;
        Tue, 29 Nov 2022 10:54:13 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id bn31-20020a05620a2adf00b006b95b0a714esm11132232qkb.17.2022.11.29.10.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 10:54:13 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:54:10 -0600
From:   David Vernet <void@manifault.com>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, docs: Correct the example of BPF_XOR
Message-ID: <Y4ZVUiwGnVIj/V4U@maniforge.lan>
References: <20221129134558.2757043-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129134558.2757043-1-zhengyejian1@huawei.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 09:45:58PM +0800, Zheng Yejian wrote:
> Refer to description of BPF_XOR, dst_reg should be used but not src_reg
> in the examples.
> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  Documentation/bpf/instruction-set.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 5d798437dad4..e672d5ec6cc7 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -122,11 +122,11 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>  
>  ``BPF_XOR | BPF_K | BPF_ALU`` means::
>  
> -  src_reg = (u32) src_reg ^ (u32) imm32
> +  dst_reg = (u32) dst_reg ^ (u32) imm32

Shouldn't this be 

dst_reg = (u32) dst_reg ^ (u32) src_reg

Same idea below for 64 bit

>  
>  ``BPF_XOR | BPF_K | BPF_ALU64`` means::
>  
> -  src_reg = src_reg ^ imm32
> +  dst_reg = dst_reg ^ imm32
>  
>  
>  Byte swap instructions
> -- 
> 2.25.1
> 
