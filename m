Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389D465258C
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 18:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiLTR1Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 12:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiLTR1P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 12:27:15 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAB16269
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 09:27:14 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id k7-20020a17090a39c700b002192c16f19aso5428616pjf.1
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 09:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CSLVZBAHtbd6SWKuGlApjel+VcT8nQLTJZTtZffl9ek=;
        b=j2DgosoDwqOFtjwoQUL7AQPiAHx25itWnUwHYAYe8eAZ8sPiGF1BtruTSfo1ksNbKS
         Y1AF1kGuWneOLrOTVYVvQmnbbNyXKpz3eIDx/pe1IS2apYkhn9TTgAjTMdHxAVgOitnT
         bqTfcdm59+qL/qBx07ZcGqCfw7CWRMcFiZ/hm7BrBMANJ0wUl0d5ypf63c6fTi0/YfuG
         /8SWBc1+g8Fk+GOiKednPdW/RMUBxawhGWKBgJaXVFFtgQ6mPpXMSElYjXWcI09BCBF6
         Kp2y3Dlfbyk6IeL7WPrs4qNcUUqS7Hi9jWbunfXLqwodhby4A0HEhglpoP6HnMZZrjm7
         i93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSLVZBAHtbd6SWKuGlApjel+VcT8nQLTJZTtZffl9ek=;
        b=nmypIJu23R3WO/+sk25W0ZgdJisLmGA60c/AEs7B5gWGQu7dyCblC2xNJWOyJe4Kv+
         OMOViUcaP3dhajyUIg/CZpLbi0mlEGvH62UubfR3pBED0LRDYJhNzHj4SIjkuRpBADBT
         P/uc6dN/9xtuGTvP64fP6H1ecx4aJ6n/DCcbKCJczTH7irdSStlZqUtqqGCyTQUnFwSf
         k4xfNYc6gf0MZvdHLfiwhoDROsXMXT3ceCcirReo5O1ZPwCODGcB7fQzHWu845FktIDc
         QUOZYZSfKf4Ao03y2e6uoSVx3w1o54OsSKBK/8q+AxEBXowhbNd8ZQazpRLgGFxXJhEo
         VSBg==
X-Gm-Message-State: AFqh2krNkDMrBVj835S2mVfbs/G+C11Ei723AkgMwAwGb6O88JUQd+Gu
        +9DqHgOKgbNKBpNX8rldczq1c9Q=
X-Google-Smtp-Source: AMrXdXs8R+rjhECppMaMVXNducZBq3Iyox5oqSpwdQIkXfqUnOtqzIm0XpnZaNLLXD9xpnLcoM/UgPs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:e152:0:b0:491:8233:399 with SMTP id
 h18-20020a63e152000000b0049182330399mr40287pgk.149.1671557233753; Tue, 20 Dec
 2022 09:27:13 -0800 (PST)
Date:   Tue, 20 Dec 2022 09:27:12 -0800
In-Reply-To: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
Mime-Version: 1.0
References: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
Message-ID: <Y6HwQSCdxkRS00q9@google.com>
Subject: Re: Support for gcc
From:   sdf@google.com
To:     SuHsueyu <anolasc13@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/20, SuHsueyu wrote:
> Hello, I use gcc 12.1.0 to compile a source file:
> t.c
> struct t {
>    int a:2;
>    int b:3;
>    int c:2;
> } g;
> with gcc -c -gbtf t.c
> and try to use libbpf API btf__parse_split, bpf_object__open, and
> bpf_object__open to parse and load into the kernel, but it failed with
> "libbpf: elf: /path/to/t.o is not a valid eBPF object file".

> Is it wrong for me to do so? Due to some constraint, I cannot use
> clang but gcc. How to parse and load gcc compiled object file with
> libbpf?

I haven't used gcc myself, so can't really help. All I can do is to
point you to these two places:

* https://gcc.gnu.org/wiki/BPFBackEnd
* tools/testing/selftests/bpf/Makefile

Maybe try to follow the instructions on that BPFBackEnd page and try
to compile kernel's selftests to see what's missing?
