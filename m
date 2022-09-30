Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8315F1607
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiI3WVI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiI3WVG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:21:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C3844DE
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:21:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id b5so5259733pgb.6
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JK+nlzVL21KAvkrCJX33+fpLXd3um1KF2+bY59QVUTY=;
        b=fgo8Nc2PXvkagixdmqp5c643nHXw7UQsotrcJDojKBYHa2TeNL2SZ/eUzk3lMPh8V/
         o5OhKC92GfPfhtgB4w9BWR3FkajjNmUoTqFFxzoKSNtBJsXTt0Ej7tjWZmCkYy92JFuc
         3pT7zz4APmUdx+tdmz9QeiIo0UytCQPlamXP08Ld8vJ72j5A7cEYJKZ5Blf5NcGWHjMS
         O9DfqSIMg3GKh9VQNzzsctvllAr84LdWT6bHcBaIQ8gdQIEBP90g4I8CeQ5DDa8//hCB
         pTeIDko+nChGyqOG8cdcGBaVAlrBCzG/zCWO/+UiGibr9cosoRT1jLmFAnkHaU61+JgF
         biyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JK+nlzVL21KAvkrCJX33+fpLXd3um1KF2+bY59QVUTY=;
        b=Y9v3pCNk0Dx0bkWzKioUFw9Ns7GYWzzNVS5AbZOnrHWER9TaXL7dFeKoBuipRZwO54
         e2nmbbdiixZD3gDdXnkdHDufENaUYv4VLEsYbt9qNliClKR0SqjKEZWIpQN1Qba5eQHX
         XaBg6AVRI0w+A+yZn5w4mHj1DbSHDL4Y7irgiqFpEeY/TovdqEe5k7m/2uyQmsoWfLr0
         GhOn6bHGybbyIUx10UBM6pTqqAmfUyCBduxhZiHebBXyFuTzP94QeVFzUvuGAaZq2ltW
         wGmvMH5eG562UKbudmjt1ysJqGWKsuLU2xpnDhpfYOjuW/0NMfl6yStoJoPNyEB61V3D
         hs/A==
X-Gm-Message-State: ACrzQf1212MsTm/Kekw/vs8MY75woUHADcDAjnvA3YqC+B6Lt6L3MsO1
        J3Av/R2021tqMcKYFmaBvpA=
X-Google-Smtp-Source: AMsMyM6q6IF30tlpIv058hBqh+yF2+JQpVRb6xfdcg2GN9f6lQYduPfzBuaesSE9H5U/yiX7zdR1qQ==
X-Received: by 2002:a63:6a47:0:b0:43c:a935:f0f with SMTP id f68-20020a636a47000000b0043ca9350f0fmr9523017pgc.95.1664576464817;
        Fri, 30 Sep 2022 15:21:04 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:5e53])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090302ce00b0017a09ebd1e2sm2368617plk.237.2022.09.30.15.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:21:04 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:21:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH 15/15] ebpf-docs: Add note about invalid instruction
Message-ID: <20220930222102.ulfwinlp7l4srphc@macbook-pro-4.dhcp.thefacebook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-15-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927185958.14995-15-dthaler1968@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 06:59:58PM +0000, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/clang-notes.rst     | 5 +++++
>  Documentation/bpf/instruction-set.rst | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
> index 528feddf2..3c934421b 100644
> --- a/Documentation/bpf/clang-notes.rst
> +++ b/Documentation/bpf/clang-notes.rst
> @@ -20,6 +20,11 @@ Arithmetic instructions
>  For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
>  ``-Xclang -target-feature -Xclang +alu32``.  In CPU version 3, support is automatically included.
>  
> +Invalid instructions
> +====================
> +
> +Clang will generate the invalid ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d) instruction if ``-O0`` is used.

I wouldn't call it invalid and it's not related to -O0.
It's a "reserved" instruction.
When we support indirect jumps that's what it would be.

> +
>  Atomic operations
>  =================
>  
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 2ac8f0dae..af9dc0cc6 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -303,6 +303,9 @@ with the remaining registers being ignored.  The definition of a helper function
>  is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
>  the number of arguments, and the type of each argument.
>  
> +Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function integer
> +would be read from a specified register, is not currently permitted.

I would say:
Note that ``BPF_CALL | BPF_X | BPF_JMP`` instruction is reserved and currently not permitted.

> +
>  Runtime functions
>  ~~~~~~~~~~~~~~~~~
>  Runtime functions are like helper functions except that they are not specific
> -- 
> 2.33.4
> 
