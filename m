Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C482C55323B
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349594AbiFUMgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiFUMgx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 08:36:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619863C5
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 05:36:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so4177880pju.1
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/wBx1U87F0mwXCeJEQm4bfh1jkngeatEHBu/UXjedzQ=;
        b=q7t7KahvAudn0QI1ydkLmD57rkbM7TjYeICQbbQ8gwU08X07oBww4YIVajn8PCZCtq
         DK0GJcWNaAVo/FjdvEvisGwgmekOzCXQn2QA/iLoaxa7wSH5fIkvv4xrLmYAkh6A5CVb
         vnMEWyLDojXZs5LYZc392WxFVkLu/LsG7+fMcQAV/npppftKKtLG0x/5pFlan/+inx9o
         Pi23Ulq3FDSPdhKfStzqmewLJP7pqeTnP6ji/aa6sJAercxKYdasmYImnBng+292GZX7
         VIirEtLtPozi7QppnesgrZE0Bl0E5zHtMtsNhARPv9lkhUPkD9poCY/yW3K+ZYOS6I6J
         a0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/wBx1U87F0mwXCeJEQm4bfh1jkngeatEHBu/UXjedzQ=;
        b=LEo0OOYceL8zQ0PrP9jaQvPHBJH4tPXmhhPz7A0T//eKQlnoz3gZJRH3xSVXx4zB8w
         bVv9wYIBO04q9pze/hKAj7o3Y3tzNNo3QAGD358YyIbf2MIq6mM7VBvPqRJqy39MMYBT
         dSrDxVHwFICva5LahOjJ37OawSqMe5oqi0kyLInrBVanJf81M+LHWG5HUN2gk1DzMK4c
         dTU8dn/TFRFdgMitdcuH1EV9f5hllt8fxdH4wNKruKf/Ye8OWxJ/2b8ujaD+oJNNW+y3
         dcpdFJFS3n6FFMhOqMBmJ1ejNEITS+AodeB7/pN0os/xiVKGodO8g2T4689pDr0/CQyB
         NTcQ==
X-Gm-Message-State: AJIora92jIJYwTbFf/ntrPRKQeu4IFl8DUZD37Z3o41SZsl2+yXSbPHF
        kHjPvLIQCB6W3a6tuwyyU3M=
X-Google-Smtp-Source: AGRyM1uiTedoC5PJa8DnnwgXo7v0ErL46ky15vPwTOxaZwBO095PSam635NAbPVc+DMlxb0lL3lEiw==
X-Received: by 2002:a17:902:b208:b0:168:dd3a:235d with SMTP id t8-20020a170902b20800b00168dd3a235dmr28440584plr.101.1655815010341;
        Tue, 21 Jun 2022 05:36:50 -0700 (PDT)
Received: from localhost ([2405:201:6014:d0c0:79de:f3f4:353c:8616])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b00164097a779fsm10540771plr.147.2022.06.21.05.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:36:49 -0700 (PDT)
Date:   Tue, 21 Jun 2022 18:06:46 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Allow kfuncs to be used in LSM
 programs
Message-ID: <20220621123646.wxdx4lzk3cgnknjr@apollo.legion>
References: <20220621012811.2683313-1-kpsingh@kernel.org>
 <20220621012811.2683313-4-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621012811.2683313-4-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 06:58:09AM IST, KP Singh wrote:
> In preparation for the addition of bpf_getxattr kfunc.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  kernel/bpf/btf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 02d7951591ae..541cf4635aa1 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7264,6 +7264,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>  	case BPF_PROG_TYPE_STRUCT_OPS:
>  		return BTF_KFUNC_HOOK_STRUCT_OPS;
>  	case BPF_PROG_TYPE_TRACING:
> +	case BPF_PROG_TYPE_LSM:
>  		return BTF_KFUNC_HOOK_TRACING;

Should we define another BTF_KFUNC_HOOK_LSM instead? Otherwise when you register
for tracing or lsm progs, you write to the same hook instead, so kfunc enabled
for tracing progs also gets enabled for lsm, I guess that is not what user
intends when registering kfunc set.

>  	case BPF_PROG_TYPE_SYSCALL:
>  		return BTF_KFUNC_HOOK_SYSCALL;
> --
> 2.37.0.rc0.104.g0611611a94-goog
>

--
Kartikeya
