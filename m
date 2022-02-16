Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9E4B92A4
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 21:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiBPUxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 15:53:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiBPUxA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 15:53:00 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AEE12E9E2
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 12:52:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l9so2974315plg.0
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 12:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6U1OWDzDuHUDHT4Q7SRFO//aqz0YdaSYhfHGycuZpcw=;
        b=IwH2pnp4oDdGQ52UBnCrFVqm/ja+i4E+JpjXNY4FOJV5WGNCgFKMzpe9RflTmJozDK
         GZvPGSYaoDT+rwlRKRYi41uMuxZAkw4BOO99pmEnQuSZXY+FqTi4kmqGsbZ+y5RAVZw4
         IqSN+fF1jBRHjzDplLgN9d+m4TZu2X6vAqxyUzp/KXh1Sg3fL1fyQgAaohXgcOFhBzkp
         mQDI6xr2sJAeGqS/A1C3PWr/xTE46MyervwGydr9y8JHW0Vn751nK63TvpUPcJp78rZZ
         G3BzLFs+3zr4BJOI1lG0sLHfA4U0EWtuy4C6iHfvsUPMlcZdjRnIZvz0gd9TGzZxD7Ij
         +rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6U1OWDzDuHUDHT4Q7SRFO//aqz0YdaSYhfHGycuZpcw=;
        b=5zGfuoRLlH/R+3i06pj5d/9sYvOURTHELfZjb1RnHqeI0DAcLFOwMAaGF7r4qCTPnx
         rlkf/B1o2yFNtYKuMvO28GtXQSPj3OFJMcg8IKQsUksigKKfZuWwEF+fPMZlAYMX4934
         T/ubhlKcztbjr35lygmsM3iHpJNGQ4Gka1/nxg/JemwdRpQt8jNoMV4EAHl5WJ6vS25G
         9+lmpyxj6JHXgKXTeZMK+mq26iMIkMBVG61waJ7cvWpneTFu1Qjq33NqlLGhmifFzavG
         EGg/F2XM/QpXGvmJ9WYn7ULEsq6OABN71VAyieKt8Ez7pIA9dwdFRcilwAebPudzzpyk
         sGdQ==
X-Gm-Message-State: AOAM5337bApjebze8Dek4Bj08Pq3A7jifmREq1ccQH3zxxHPg+QdhN3t
        GgjW8zrBlJeKFwvDXdc91o9gIMmNAR908MeQKpS4m5Yb
X-Google-Smtp-Source: ABdhPJwqNEyxoXKkqbOl38sTyOsH22eiBWTfnl8ueTnD5WH4K+gHRvESB4zL7BGGa3InY1nlt6EY85PM46P2W2Wexqw=
X-Received: by 2002:a17:90a:b017:b0:1b9:485b:3005 with SMTP id
 x23-20020a17090ab01700b001b9485b3005mr3819355pjq.33.1645044767468; Wed, 16
 Feb 2022 12:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20220216201943.624869-1-memxor@gmail.com>
In-Reply-To: <20220216201943.624869-1-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Feb 2022 12:52:36 -0800
Message-ID: <CAADnVQ+AqthyJY+QbFMH_-gckRO1SyNjGHEXyHXsL9wd0ffeTQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] Fix crash due to OOB access when reg->type > __BPF_REG_TYPE_MAX
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 16, 2022 at 12:19 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> When commit e6ac2450d6de ("bpf: Support bpf program calling kernel
> function") added kfunc support, it defined reg2btf_ids as a cheap way to
> translate the verifier reg type to the appropriate btf_vmlinux BTF ID,
> however commit c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with
> PTR_TO_XXX | PTR_MAYBE_NULL") moved the __BPF_REG_TYPE_MAX from the last

The commit description shouldn't be wrapped into multiline.
The subj also missed the "bpf:" prefix.
I fixed that and pushed to bpf tree.
Thanks!
