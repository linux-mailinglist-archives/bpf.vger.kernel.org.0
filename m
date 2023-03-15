Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD86BBEE7
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 22:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjCOVV0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjCOVVZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 17:21:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB6786AD;
        Wed, 15 Mar 2023 14:20:54 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id y19so11610044pgk.5;
        Wed, 15 Mar 2023 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678915250;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yljKuAczGYt4Ja4FPBcd9N4OqR/KKOBeL7coSkUeCGI=;
        b=hPnXTgdm6YGEeV4tLP9B+vNhAVCfCnbJf+RDz5geD4j5r4kLzEVVN7LherzmYQD+Z1
         ZpKKRQljZ+VvGi6RV7RiQ35LNyRJ5X1RSpmr0Qs/XxzemW39WIflraTSB7wS78a9DcOE
         KNDjB7mnB4QoA9SafkPpwk8RBTSVq+Ici3KwFmZJsdjgR2SwDgT1cYKqDt0Kuc1gD1LJ
         JsOWmDTwhtLXpmFmDQrhpGbwdaAPAfid5EbTTRuF50zN5YdRMg9VfnoglTr/z7pWNi57
         YCNq8/Ox2gMHCoV8CImK1mDXbCXflPNwrtWOfZR8I89WRcWXVZw6+kkczzhA/FAifZt3
         ZSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678915250;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yljKuAczGYt4Ja4FPBcd9N4OqR/KKOBeL7coSkUeCGI=;
        b=ZwtkQHQLXTB/YPHyKr8Z+z73cA2R/4srG3Zk9wAlMCG8uVcG/6MREvTfL9B2j/qr4M
         4sqQOT5bSOmh0BSBWU8QlDspMwmRJt/M2cdZQIXXnuVjN4qUo9UIHJy25MD+pmyxFFrZ
         VJ2Gq/2WIchMf8XKj4Q6bJY/ELDWGjcttI1mIJii+LwFkanNCQeRyK3MRylRBQud4ZG7
         cJ+Rlqy/0zAoTZLJMn98KOfIiIv1VXSP1wMaLJTuIPxiAgsCWnLi155QgklkMwRJOcFa
         Mqhq9o9d3g1jz168Cq5FEiXXvmWSgT3EcXAA2q0V7GUk5LSdbkEzck0MvK9gpNf3ZaB0
         ZdLg==
X-Gm-Message-State: AO0yUKXmHK8kiEpadoCHSnz/lr6iaMGAGKb0t9MiEKy8I5/rQ8PEmeoB
        KPPcafYJ2aT6VGgp+BBvW8w=
X-Google-Smtp-Source: AK7set86DXYC1k8HBLiZGq1z7YSeqqcu05dxBpS/bUleqxZZeiZsX/oxzNHOSQ30Kdl1cr1tZH3pRA==
X-Received: by 2002:aa7:96c5:0:b0:625:6e2f:defa with SMTP id h5-20020aa796c5000000b006256e2fdefamr762998pfq.31.1678915250148;
        Wed, 15 Mar 2023 14:20:50 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id l190-20020a6388c7000000b00502ea97cbc0sm3779958pgd.40.2023.03.15.14.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:20:49 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:20:48 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Greg Thelen <gthelen@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Message-ID: <641236b06baa1_63dce208a1@john.notmuch>
In-Reply-To: <20230315054932.1639169-1-gthelen@google.com>
References: <20230315054932.1639169-1-gthelen@google.com>
Subject: RE: [PATCH] tools/resolve_btfids: Add libsubcmd to .gitignore
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greg Thelen wrote:
> After building the kernel I see:
>   $ git status -s
>   ?? tools/bpf/resolve_btfids/libbpf/
> 
> Commit af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
> started copying header files into
> tools/bpf/resolve_btfids/libsubcmd/include/subcmd. These *.h files are
> not covered by higher level wildcard gitignores.
> 
> gitignore the entire libsubcmd directory. It's created as part of build
> and removed by clean.
> 
> Fixes: af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---
>  tools/bpf/resolve_btfids/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfids/.gitignore
> index 16913fffc985..52d5e9721d92 100644
> --- a/tools/bpf/resolve_btfids/.gitignore
> +++ b/tools/bpf/resolve_btfids/.gitignore
> @@ -1,3 +1,4 @@
>  /fixdep
>  /resolve_btfids
>  /libbpf/
> +/libsubcmd/
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 

Thanks.

Acked-by: John Fastabend <john.fastabend@gmail.com>
