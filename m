Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394865321C6
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 05:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiEXDzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 23:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiEXDzF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 23:55:05 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA4D3B57E
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 20:54:59 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-30007f11f88so37370377b3.7
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 20:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02PRBMhXiS9MzzAmTxIommRPUw0PsVFtBIV5R9sSMDk=;
        b=XZ1upDXpQgYfRQxYPPF2gE6L9ciCtAQhjsIC9OlmBNdoToZyT3/s20+nl1cDBM8L39
         LEdynr/SdPltOn+gppCX+YniidUAE4zthzV4aI39Ow0MJVKoQh6P4P6tbaXDo8HTXipa
         KSq69Z2+TJvkFPIl9MsWZxVorWu1qOWDd9/H1FiG0d/ELqlPdnj1zZSGdQ5ZaXvHL0Uk
         0YkmmzXnOZLUTissCnxXRs/oS5XkwpwF658oIk3ABUbMc+a1NolDq/Ly7X4uC7q4frfJ
         IpjymSPLrYOJryyyFUI4YAOGFFPENdmr0aLoxvGiJUsBrsFJX1oIWricQHb+X8SromL6
         0xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02PRBMhXiS9MzzAmTxIommRPUw0PsVFtBIV5R9sSMDk=;
        b=qHF2r6kTkLviwaCFB4aunLFfzrXh4unBZRnBssY1JWWpTXpPHH5mRt6d3aS8wBlK8q
         t5BH8bFP0WPgooL6uWZXCLCuP1D3yLQwWqdNWr8S5v7hg6e8biYFBcoif6KeZAFW2IbX
         K+PpqRGvWiSWL8J9CtD1xcd42NNat0MN9dD6Vx6Jikc5Wwf9sj3uv9UyptxZNHaR+L9b
         xmRL6sSiByHjw+SVrARGKO6WGZVWlCv+nIwaH0MpjuxyKv9KbOvOYpPw304+fLSJ2woD
         enj3hfh4ePNpVI4GBvOfHQM4Tq3xzUOax83cVlBFlzXTcG0bqWCdLvR5GDfL/XAaLtMg
         KspQ==
X-Gm-Message-State: AOAM5314wldoHxuw8HopVIxw0MZn1ZDxn58HPUgnSeXyDPZpk2dJKP2g
        FMiMZqQ6yBx0IXoq2cdZgfCWy7HjRPCcH72cgo9KyA==
X-Google-Smtp-Source: ABdhPJyKe2ct0Exan/BNSwYxnwykqLkDjScTQxoA6AyDL5vw70Cpvt4jkceJEc9oueLbQYsbkb24LLAPRlEVshDRa+Q=
X-Received: by 2002:a81:1d4e:0:b0:2f7:be8b:502e with SMTP id
 d75-20020a811d4e000000b002f7be8b502emr26659521ywd.278.1653364498584; Mon, 23
 May 2022 20:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220524034629.395939-1-wangyufen@huawei.com>
In-Reply-To: <20220524034629.395939-1-wangyufen@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 23 May 2022 20:54:47 -0700
Message-ID: <CANn89iK25tMWxyLYhFK8oMx9zJeQAntbiK1J=8hpeMg51GSKhA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: Fix signed integer overflow in __ip6_append_data
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 23, 2022 at 8:29 PM Wang Yufen <wangyufen@huawei.com> wrote:
>
> Resurrect ubsan overflow checks and ubsan report this warning,
> fix it by change len check from INT_MAX to IPV6_MAXPLEN.
>
> UBSAN: signed-integer-overflow in net/ipv6/ip6_output.c:1489:19
> 2147479552 + 8567 cannot be represented in type 'int'

OK, so why not fix this point, instead of UDP, which is only one of
the possible callers ?

It seems the check in __ip6_append_data() should be unsigned.
