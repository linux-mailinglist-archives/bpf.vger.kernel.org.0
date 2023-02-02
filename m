Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E7687C27
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 12:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjBBL0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 06:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjBBL0o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 06:26:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE889FAE;
        Thu,  2 Feb 2023 03:26:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ml19so5184078ejb.0;
        Thu, 02 Feb 2023 03:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O6oWaCj5vHS3jXg8ySUjTa+u1D8hWBtGtNI3mRImg0Y=;
        b=F79pokKP1WiCid6YMixYPHt5bZLnbK+gTlGo7cZnKIM3lqK2y2k1Llqq5yKcrQgcqC
         PKnxlxzsvsx8F2//SlQL/bOySmxcrs3fvfKruq38exYlm9Cm78+wOG5K1WS55OX36Gzw
         aekRgG3rfKDsI+UWJhjoLQ07XH+UKZ3mygLibrwXMjFQWnKQvZS3GyOouYzL/rlCoadz
         Gg3MyfxVU+iNfEuARuCD989VT2zjga0o91uE4hyrG/ah7xAY28f4ZIWwGZ1mDRGHIY7T
         Naq54vOrOaiTVtgjZcFszf+0GOsSda+/h1C/GfCVv8wUeP15BDHbEte7YcKFLeAR5gls
         +GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6oWaCj5vHS3jXg8ySUjTa+u1D8hWBtGtNI3mRImg0Y=;
        b=5wtgLK2enJJDcfzlmMJqGscug3sZPRjj1VR+D0sCGRljnsTbLZhkDhdZ4INmARTaZ3
         mNi2gyL3jl6MXRniAJj4KP3cyuI667aYc8K453I7/gN34cIV/pqRTDXPCpTfC5erVgTt
         el7BbiXcaanYQwCnyDKJ2cBO/861YVTAyXLRBh5YiL5uMnlS3FC31jOrQl58F06X00mi
         Suz8b+DAKZEWNRl6CTodkoRPh2XWL2X4zeAVG5LU7P0SI2wqtn/W7Z37GQBt9ASyKv9P
         tAAI2RIfWtq3ZRex99r+dRpK0hz266yOUHyC1qAtGGLmyk3jnBZdXKjfrVLTE6Gl+I4y
         2jcg==
X-Gm-Message-State: AO0yUKVaMyHXRaRUAvHme0Bjfsgx+uhEHbkDAQBcsh6wR0FDEVyZHwDU
        tqawqTjzGUYw7vMJNv5jC8w8ECiuOuv189N/vknioi046Bs=
X-Google-Smtp-Source: AK7set8vT6OFL2YDCpRYuF9hPA/fQW+8qFZprEMIhCW6ignSyaGa0sMCBwDXXsztYK8YzT+AMiIHohCUSGpX4MExO/E=
X-Received: by 2002:a17:906:4b57:b0:878:74d0:c173 with SMTP id
 j23-20020a1709064b5700b0087874d0c173mr1721816ejv.264.1675337201809; Thu, 02
 Feb 2023 03:26:41 -0800 (PST)
MIME-Version: 1.0
References: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Feb 2023 03:26:30 -0800
Message-ID: <CAADnVQKWWf6==B=X+2zazt1dmfK6ENAaGWWS_2QkX4bDJrJJNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] bpf: Replace BPF_ALU and BPF_JMP with
 BPF_ALU32 and BPF_JMP64
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Feb 1, 2023 at 4:36 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> The intention of this patchset is to make the code more readable,
> no functional changes, based on bpf-next.
>
> If this patchset makes no sense, please ignore it and sorry for that.
...
>  157 files changed, 4299 insertions(+), 4295 deletions(-)

Are you trying to get to the top of lwn's "most active developers by
lines changed" ?
I'm sure you knew that it's most likely going to be rejected,
yet you still sent it. why?
Your developer's reputation suffers.
Think quality and not quantity.
