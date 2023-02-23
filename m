Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4F6A04CE
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 10:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjBWJbg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 04:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjBWJbf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 04:31:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96BA17159
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 01:31:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j2so9936814wrh.9
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPO/JMXazXQ8Kyo/A/3o1pvRNp7LsXYtBLZ94I6IFD8=;
        b=B6Px3m43o3CGzzrvmZOxz9aw8Usyg6hYdVtnNpXMHl8YNNYZI6YWmDknfEOe3zZozc
         +TabUYYYhnm4bdjVUfuQnIrn/oDwuPSlzqkyYD7kjXQpSipNpIt/qKOYckCXQUIz3vnt
         vFmASVz7el7Ifq+ykYwJIsXXPBoWyp9oznmJCU/ZJlCYDJYXL8E/3mzGWw6jWbGLucI3
         C572tDcRrnxtDOud73vPA2uoZ2kWXpryZY4DnRD4MIrdVxZ+p0foaL3Bs2hBNfXapIsl
         Cv5WnMFK/2kQz7TKGZrkAbfsHpJKk0Oc5ErXuRFW3gAIELLTbSy7/YMYsx77D2PDiz15
         Ff8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPO/JMXazXQ8Kyo/A/3o1pvRNp7LsXYtBLZ94I6IFD8=;
        b=EbM9HUWs64Say04dtZnz8EL2ZyaJiMYfOPEqT9KccSsl7QXB6Hp8KhG2bmf73/Z34Z
         RWhPnZoyyc+N5kw8yBRQvtvkNzAaJqGy5WXMrzoYXdj2A8ExdE9ZpU2jgK5a+Cni3kA7
         1486SOLTiBmlegspa6hwxz/9YZ4eJ455k9G4n+AUgm+kpOeCdQyFrbwHhlTz80kZDq/N
         5N+iMpLXjMqXYhJOCsNglaDe0z5vWk93X5ILgZvIidkwQnHiJSSnlyf2TBGn/bQbIn8t
         bVa9C/KPB7uF66sgOuRv5HH21IWccSKef8O4j76z+1NUyiZVGsExkBDjZuL4wwGZO1TO
         Qe/w==
X-Gm-Message-State: AO0yUKUh7IL1N9mXaj61Q187p9ubybKrl8hALYMupl4c0oZ+0JqYKyBD
        oK1ycxwOGzwODq+mMwxWb6SgsotGvA5uVA==
X-Google-Smtp-Source: AK7set9EoUCU2u96D9k6cVjdwy+I92Dh4wFsbY8vCrKbyyw/xJlXECzFw+QD/rDyL0c92IARmHy+rA==
X-Received: by 2002:a5d:66ce:0:b0:2c5:c71:4a84 with SMTP id k14-20020a5d66ce000000b002c50c714a84mr7973791wrw.68.1677144692200;
        Thu, 23 Feb 2023 01:31:32 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d6b4d000000b002c6e8af1037sm12569816wrw.104.2023.02.23.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:31:31 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 23 Feb 2023 10:31:29 +0100
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stanislav Fomichev <sdf@google.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH bpf-next v3 08/12] bpf: sparc64: Use
 bpf_jit_get_func_addr()
Message-ID: <Y/cycQibEW46BIUE@krava>
References: <20230222223714.80671-1-iii@linux.ibm.com>
 <20230222223714.80671-9-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222223714.80671-9-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 11:37:10PM +0100, Ilya Leoshkevich wrote:
> Preparation for moving kfunc address from bpf_insn.imm.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/sparc/net/bpf_jit_comp_64.c | 20 ++++++++++++++------
>  arch/x86/net/bpf_jit_comp32.c    |  7 +++++++
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
> index 6c482685dc6c..b23083776718 100644
> --- a/arch/sparc/net/bpf_jit_comp_64.c
> +++ b/arch/sparc/net/bpf_jit_comp_64.c
> @@ -893,7 +893,8 @@ static void emit_tail_call(struct jit_ctx *ctx)
>  	emit_nop(ctx);
>  }
>  

SNIP

> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index 429a89c5468b..0abb4d6c9dec 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -2091,6 +2091,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>  			if (insn->src_reg == BPF_PSEUDO_CALL)
>  				goto notyet;
>  
> +			err = bpf_jit_get_func_addr(bpf_prog, insn, extra_pass,
> +						    &func_addr,
> +						    &func_addr_fixed);
> +			if (err)
> +				return err;
> +			func = (u8 *)(unsigned long)func_addr;
> +
>  			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>  				int err;

looks like this hunk should be in:
  bpf, x86_32: Use bpf_jit_get_func_addr

jirka
