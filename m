Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE255A5DE
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 03:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiFYBcD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 21:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFYBcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 21:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2420D45ADD
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 18:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADEFA61CF4
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 01:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94C6C341CA
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 01:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656120720;
        bh=TDEVecaUSFDkgwOjDDTuGj465oKn3neklsRuAmXVJmo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tFDiwuFjybVe5EUIJjw1j8YrfMM2UWDCQ+xdi8UODdqPQKp8HjAAFuDR1PkPIA/uW
         6XMz6afyJAaOiGZZclccDRrUzrq+XdzzMwVgiR6t6uoY75hZsJlcJ3qd09iD0i5Lrx
         yx9Iq+kt8dUH6QGpKyuXpHQ9KVDl69dr+m0wM1LcX2QZuQfvd9aArFjLa98zlV61/P
         /rdYS5eBhHIAKhaU7bT8IUF8otzR9zwHg0oOcbHARuiGcLRO+n675BsWqNQMVT1Rxq
         ETIKPSyPXSa3WX0zfgwhF8+jwM4/brFmhmWtQ6FPN/HUzu3fdMRgNEpS7wcV59japg
         R6eTkwb/0YAgA==
Received: by mail-yb1-f177.google.com with SMTP id x38so7271517ybd.9
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 18:32:00 -0700 (PDT)
X-Gm-Message-State: AJIora+zA89PPQW10t71e+eMq9gyyhvIUjEXex8zcIH53vy+5pEouir+
        9IQ6KjFw/V1QnrrwYF/G9K/dvR4IMnCNcVh/mEQSTA==
X-Google-Smtp-Source: AGRyM1sfdDiTkdvwcLYtL1E6GL0IfJGeAc/pLRs4ZtjBWDqosSCLl3DCLLJmNtln+z4W4j5PansvBxe0nK3Cl9e99tA=
X-Received: by 2002:a25:6ed5:0:b0:669:8b84:bb57 with SMTP id
 j204-20020a256ed5000000b006698b84bb57mr2031021ybc.227.1656120720010; Fri, 24
 Jun 2022 18:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220621204642.2891979-1-kpsingh@kernel.org> <20220621204642.2891979-3-kpsingh@kernel.org>
 <20220622012654.xl5bax75muwdd764@apollo.legion>
In-Reply-To: <20220622012654.xl5bax75muwdd764@apollo.legion>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 24 Jun 2022 20:31:49 -0500
X-Gmail-Original-Message-ID: <CACYkzJ4RBJpQva3kk0Hoxad3fyCG7vqFR6gTUybPP7eWrOjOcg@mail.gmail.com>
Message-ID: <CACYkzJ4RBJpQva3kk0Hoxad3fyCG7vqFR6gTUybPP7eWrOjOcg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: kfunc support for ARG_PTR_TO_CONST_STR
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 8:27 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>

[...]

>
> Sorry for not seeing it before, I think this i++ is incorrect. It is skipping
> over the next argument. Which means mem, len pair is not being seen, otherwise
> it should have given an error with the void * argument, because the next
> argument does not have __sz prefix, so there is no mem, len pair in the kfunc
> args.
>
> The i++ is done for arg_mem_size case because we processed both argno and argno + 1
> together, so the next size arg doesn't need to be processed.
>
> So the bpf_getxattr declaration needs to change from:
>
> noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
>                                      const char *name, void *value, int size)
>
> to
>
> noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
>                                      const char *name, void *value, int value__sz)
>
> You only need the __sz suffix, the part before that is your choice.
> Then it will actually check the size for the value pointer.
> Also, I think neither noinline nor __weak are needed.
>

So, yes, I thought about this and you are right, noinline and __weak
are indeed not needed. The compiler will inline the call sites. But there
are no call sites to be inlined in the kernel. So, we are good with just
silencing the compiler warnings
